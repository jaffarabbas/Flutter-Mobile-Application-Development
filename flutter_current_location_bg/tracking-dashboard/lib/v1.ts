import { timingSafeEqual } from "node:crypto";
import { connection } from "next/server";
import sql from "mssql";
import { getSqlPool } from "@/lib/db";

export class ApiError extends Error {
  constructor(message: string, public status = 400) { super(message); }
}
export function object(value: unknown): Record<string, unknown> {
  if (!value || typeof value !== "object" || Array.isArray(value)) throw new ApiError("Expected a JSON object.");
  return value as Record<string, unknown>;
}
export function text(value: unknown, name: string, max: number): string {
  if (typeof value !== "string" || !value.trim() || value.length > max) throw new ApiError(`${name} must be a nonempty string of at most ${max} characters.`);
  return value;
}
export function uuid(value: unknown, name = "id"): string {
  if (typeof value !== "string" || !/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/.test(value)) throw new ApiError(`${name} must be a lowercase UUID.`);
  return value;
}
export function finite(value: unknown, name: string): number {
  if (typeof value !== "number" || !Number.isFinite(value)) throw new ApiError(`${name} must be a finite number.`);
  return value;
}
export function epoch(value: unknown, name: string): number {
  const n = finite(value, name);
  if (!Number.isSafeInteger(n) || n < 0 || n > 253402300799999) throw new ApiError(`${name} must be epoch milliseconds UTC (1970–9999).`);
  return n;
}
export function nullableNumber(value: unknown, name: string) { return value == null ? null : finite(value, name); }
export function nullableText(value: unknown, name: string, max: number) {
  if (value == null) return null;
  if (typeof value !== "string" || value.length > max) throw new ApiError(`${name} must be a string of at most ${max} characters or null.`);
  return value;
}
export function flag(value: unknown, name: string) {
  if (value === undefined) return false;
  if (typeof value !== "boolean") throw new ApiError(`${name} must be boolean.`);
  return value;
}
export async function api(request: Request, action: () => Promise<unknown>) {
  await connection();
  try {
    const key = process.env.API_KEY;
    if (key) {
      const supplied = Buffer.from(request.headers.get("X-Api-Key") ?? "");
      const expected = Buffer.from(key);
      if (supplied.length !== expected.length || !timingSafeEqual(supplied, expected)) throw new ApiError("Invalid or missing X-Api-Key.", 401);
    }
    const result = await action();
    if (result instanceof Response) return result;
    return Response.json({ success: true, ...object(result) }, { headers: { "Cache-Control": "no-store" } });
  } catch (error) {
    if (error instanceof ApiError || error instanceof SyntaxError) {
      return Response.json({ success: false, message: error.message }, { status: error instanceof ApiError ? error.status : 400 });
    }
    if (error instanceof sql.RequestError && error.number === 51000) {
      return Response.json({ success: false, message: error.message }, { status: 400 });
    }
    console.error("v1 API failure", error);
    return Response.json({ success: false, message: "Database operation failed. Please retry." }, { status: 503 });
  }
}
// One transaction-wide lock serializes ride/point writes, including concurrent retries.
// Bulk data itself is sent in one request, never one SQL request per point.
export async function write<T>(action: (transaction: sql.Transaction) => Promise<T>) {
  const transaction = new sql.Transaction(await getSqlPool());
  await transaction.begin(sql.ISOLATION_LEVEL.SERIALIZABLE);
  try {
    await new sql.Request(transaction).query(`
      DECLARE @result int;
      EXEC @result = sys.sp_getapplock @Resource = 'ride-sync-v1', @LockMode = 'Exclusive', @LockOwner = 'Transaction', @LockTimeout = 10000;
      IF @result < 0 THROW 51001, 'Sync write lock unavailable.', 1;
    `);
    const result = await action(transaction);
    await transaction.commit();
    return result;
  } catch (error) {
    try { await transaction.rollback(); } catch { /* SQL may already have rolled back. */ }
    throw error;
  }
}
export const pointColumns = `id, ride_id AS rideId, device_id AS deviceId, lat, lng,
  accuracy, altitude, speed, bearing, provider, is_mocked AS isMocked,
  is_filtered AS isFiltered, filter_reason AS filterReason,
  DATEDIFF_BIG(millisecond, '19700101', recorded_at) AS recordedAt,
  DATEDIFF_BIG(millisecond, '19700101', received_at) AS receivedAt`;
// Tedious represents BIGINT as a string; JSON contract requires numeric epoch ms.
export function numbers<T extends Record<string, unknown>>(row: T): T {
  const result = { ...row };
  for (const key of ["recordedAt", "receivedAt", "startedAt", "endedAt", "createdAt", "updatedAt", "lastSeenAt", "durationMs"]) {
    if (result[key] != null) (result as Record<string, unknown>)[key] = Number(result[key]);
  }
  return result;
}

import sql from "mssql";
import { NextResponse } from "next/server";

import { getSqlPool } from "@/lib/db";

class ValidationError extends Error {}

const ensureValidCoordinate = (value: unknown, label: string) => {
  if ((typeof value !== "number" && typeof value !== "string") || String(value).trim() === "") {
    throw new ValidationError(`${label} is required and must be a number.`);
  }
  const number = Number(value);

  if (!Number.isFinite(number)) {
    throw new ValidationError(`${label} must be a valid number.`);
  }

  return number;
};

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const limit = Number(searchParams.get("limit") ?? 100);
    if (!Number.isInteger(limit) || limit < 1 || limit > 500) {
      throw new ValidationError("limit must be an integer between 1 and 500.");
    }
    const deviceId = searchParams.get("deviceId");

    const pool = await getSqlPool();
    const query = `
      SELECT TOP (@limit)
        id,
        device_id AS deviceId,
        latitude,
        longitude,
        accuracy,
        speed,
        source,
        created_at AS createdAt
      FROM dbo.device_positions
      ${deviceId ? "WHERE device_id = @deviceId" : ""}
      ORDER BY created_at DESC, id DESC
    `;

    const requestQuery = pool.request();
    requestQuery.input("limit", sql.Int, limit);

    if (deviceId) {
      requestQuery.input("deviceId", sql.NVarChar(100), deviceId);
    }

    const result = await requestQuery.query(query);

    return NextResponse.json({
      success: true,
      data: result.recordset,
    });
  } catch (error) {
    return NextResponse.json(
      {
        success: false,
        message: error instanceof Error ? error.message : "Failed to load positions.",
      },
      { status: error instanceof ValidationError ? 400 : 500 },
    );
  }
}

export async function POST(request: Request) {
  try {
    const body = await request.json();
    if (!body || typeof body !== "object" || Array.isArray(body)) {
      throw new ValidationError("Expected a JSON object.");
    }
    const deviceId = String(body.deviceId ?? body.device_id ?? "").trim();
    const latitude = ensureValidCoordinate(body.latitude, "Latitude");
    const longitude = ensureValidCoordinate(body.longitude, "Longitude");
    const accuracy = body.accuracy == null ? null : ensureValidCoordinate(body.accuracy, "Accuracy");
    const speed = body.speed == null ? null : ensureValidCoordinate(body.speed, "Speed");
    const source = String(body.source ?? "mobile").trim() || "mobile";
    if (deviceId.length > 100 || source.length > 50) {
      throw new ValidationError("deviceId must be at most 100 characters and source at most 50.");
    }
    if ((accuracy !== null && (accuracy < 0 || accuracy > 9999999.999)) ||
        (speed !== null && (speed < -1 || speed > 9999999.999))) {
      throw new ValidationError("Invalid accuracy or speed (speed may be -1 when unavailable).");
    }

    if (!deviceId) {
      return NextResponse.json(
        { success: false, message: "deviceId is required." },
        { status: 400 },
      );
    }

    if (latitude < -90 || latitude > 90) {
      return NextResponse.json(
        { success: false, message: "Latitude must be between -90 and 90." },
        { status: 400 },
      );
    }

    if (longitude < -180 || longitude > 180) {
      return NextResponse.json(
        { success: false, message: "Longitude must be between -180 and 180." },
        { status: 400 },
      );
    }

    const pool = await getSqlPool();
    const insert = pool.request();

    insert.input("device_id", sql.NVarChar(100), deviceId);
    insert.input("latitude", sql.Decimal(9, 6), latitude);
    insert.input("longitude", sql.Decimal(9, 6), longitude);
    insert.input("accuracy", sql.Decimal(10, 3), accuracy);
    insert.input("speed", sql.Decimal(10, 3), speed);
    insert.input("source", sql.NVarChar(50), source);

    const result = await insert.query(`
      INSERT INTO dbo.device_positions (
        device_id,
        latitude,
        longitude,
        accuracy,
        speed,
        source
      )
      OUTPUT INSERTED.id, INSERTED.created_at
      VALUES (
        @device_id,
        @latitude,
        @longitude,
        @accuracy,
        @speed,
        @source
      )
    `);

    const inserted = result.recordset[0];

    return NextResponse.json({
      success: true,
      message: "Position saved successfully.",
      data: {
        id: inserted.id,
        deviceId,
        latitude,
        longitude,
        createdAt: inserted.created_at,
      },
    }, { status: 201 });
  } catch (error) {
    return NextResponse.json(
      {
        success: false,
        message: error instanceof Error ? error.message : "Unable to save position.",
      },
      { status: error instanceof ValidationError || error instanceof SyntaxError ? 400 : 500 },
    );
  }
}

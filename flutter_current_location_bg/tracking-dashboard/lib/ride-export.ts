import sql from "mssql";
import { getSqlPool } from "@/lib/db";
import { ApiError, uuid, pointColumns, numbers } from "@/lib/v1";
import type { RidePoint } from "@/lib/sync-types";
import { quality } from "@/lib/quality";

export async function allPoints(rideId: string) {
  uuid(rideId,"rideId");
  const result = await (await getSqlPool()).request().input("ride",sql.NVarChar(36),rideId).query(`
    IF NOT EXISTS(SELECT 1 FROM dbo.rides WHERE id=@ride) THROW 51000, 'Ride not found.', 1;
    SELECT ${pointColumns} FROM dbo.ride_points WHERE ride_id=@ride ORDER BY recorded_at,id;
  `);
  return result.recordset.map(numbers) as RidePoint[];
}
export async function rideQuality(rideId: string) { return { data: quality(await allPoints(rideId)) }; }
export async function gpx(request: Request, rideId: string) {
  const include = new URL(request.url).searchParams.get("includeFiltered") ?? "false";
  if (include !== "true" && include !== "false") throw new ApiError("includeFiltered must be true or false.");
  const points = (await allPoints(rideId)).filter(p=> include === "true" || !p.isFiltered);
  const xml = `<?xml version="1.0" encoding="UTF-8"?>\n<gpx version="1.1" creator="Ride dashboard" xmlns="http://www.topografix.com/GPX/1/1"><trk><name>${rideId}</name><trkseg>\n` +
    points.map(p=>`<trkpt lat="${p.lat}" lon="${p.lng}">${p.altitude === null ? "" : `<ele>${p.altitude}</ele>`}<time>${new Date(p.recordedAt).toISOString()}</time></trkpt>`).join("\n") +
    "\n</trkseg></trk></gpx>";
  return new Response(xml, { headers: { "Content-Type": "application/gpx+xml", "Content-Disposition": `attachment; filename="${rideId}-${include === "true" ? "all" : "good"}.gpx"`, "Cache-Control": "no-store" } });
}

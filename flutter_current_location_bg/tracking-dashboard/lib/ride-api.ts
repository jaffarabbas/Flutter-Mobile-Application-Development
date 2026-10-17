import sql from "mssql";
import { getSqlPool } from "@/lib/db";
import { ApiError, object, text, uuid, finite, epoch, nullableNumber, nullableText, flag, write, numbers, pointColumns } from "@/lib/v1";

export async function upsertRide(request: Request, rideId: string) {
  uuid(rideId, "rideId");
  const body = object(await request.json());
  const deviceId = text(body.deviceId, "deviceId", 100);
  const startedAt = epoch(body.startedAt, "startedAt");
  if (body.status !== "active" && body.status !== "ended") throw new ApiError("status must be active or ended.");
  const endedAt = body.endedAt == null ? null : epoch(body.endedAt, "endedAt");
  if (body.status === "ended" && endedAt === null) throw new ApiError("endedAt is required for ended rides.");
  if (endedAt !== null && endedAt < startedAt) throw new ApiError("endedAt cannot precede startedAt.");
  await write(async (tx) => {
    await new sql.Request(tx).input("id", sql.NVarChar(36), rideId)
      .input("device", sql.NVarChar(100), deviceId)
      .input("started", sql.DateTime2(3), new Date(startedAt))
      .input("ended", sql.DateTime2(3), endedAt === null ? null : new Date(endedAt))
      .input("status", sql.NVarChar(10), body.status).query(`
        IF EXISTS (SELECT 1 FROM dbo.rides WHERE id=@id AND device_id<>@device)
          THROW 51000, 'rideId belongs to another device.', 1;
        IF EXISTS (SELECT 1 FROM dbo.rides WHERE id=@id AND @ended < started_at)
          THROW 51000, 'endedAt cannot precede the stored startedAt.', 1;
        IF EXISTS (SELECT 1 FROM dbo.rides WHERE id=@id)
          UPDATE dbo.rides SET ended_at=CASE WHEN status='ended' AND @status='active' THEN ended_at ELSE @ended END,
            status=CASE WHEN status='ended' THEN status ELSE @status END, updated_at=SYSUTCDATETIME() WHERE id=@id;
        ELSE
          INSERT dbo.rides(id, device_id, started_at, ended_at, status) VALUES(@id,@device,@started,@ended,@status);
      `);
  });
  return { rideId };
}

export async function batch(request: Request) {
  const body = object(await request.json());
  const deviceId = text(body.deviceId, "deviceId", 100);
  if (!Array.isArray(body.points) || body.points.length < 1 || body.points.length > 500) throw new ApiError("points must contain 1–500 entries.");
  const points = body.points.map((value) => {
    const p = object(value);
    const lat = finite(p.lat, "lat"), lng = finite(p.lng, "lng");
    if (lat < -90 || lat > 90 || lng < -180 || lng > 180) throw new ApiError("lat/lng out of range.");
    return {
      id: uuid(p.id), rideId: uuid(p.rideId, "rideId"), lat, lng,
      accuracy: nullableNumber(p.accuracy, "accuracy"), altitude: nullableNumber(p.altitude, "altitude"),
      speed: nullableNumber(p.speed, "speed"), bearing: nullableNumber(p.bearing, "bearing"),
      provider: nullableText(p.provider, "provider", 20), filterReason: nullableText(p.filterReason, "filterReason", 32),
      isMocked: flag(p.isMocked, "isMocked"), isFiltered: flag(p.isFiltered, "isFiltered"),
      recordedAt: new Date(epoch(p.recordedAt, "recordedAt")).toISOString(),
    };
  });
  const inserted = await write(async (tx) => {
    const result = await new sql.Request(tx).input("json", sql.NVarChar(sql.MAX), JSON.stringify(points))
      .input("device", sql.NVarChar(100), deviceId).query(`
      SELECT * INTO #incoming FROM OPENJSON(@json) WITH (
        id nvarchar(36), rideId nvarchar(36), lat float, lng float,
        accuracy float, altitude float, speed float, bearing float,
        provider nvarchar(20), filterReason nvarchar(32), isMocked bit, isFiltered bit,
        recordedAt datetime2(3)
      );
      IF EXISTS(SELECT 1 FROM #incoming i JOIN dbo.rides r ON r.id=i.rideId WHERE r.device_id<>@device)
        THROW 51000, 'rideId belongs to another device.', 1;
      INSERT dbo.rides(id,device_id,started_at,status)
        SELECT i.rideId,@device,MIN(i.recordedAt),'active' FROM #incoming i
        WHERE NOT EXISTS(SELECT 1 FROM dbo.rides r WHERE r.id=i.rideId) GROUP BY i.rideId;
      ;WITH unique_points AS (SELECT *, ROW_NUMBER() OVER(PARTITION BY id ORDER BY recordedAt) AS rn FROM #incoming)
      INSERT dbo.ride_points(id,ride_id,device_id,lat,lng,accuracy,altitude,speed,bearing,provider,is_mocked,is_filtered,filter_reason,recorded_at)
        SELECT id,rideId,@device,lat,lng,accuracy,altitude,speed,bearing,provider,isMocked,isFiltered,filterReason,recordedAt
        FROM unique_points i WHERE rn=1 AND NOT EXISTS(SELECT 1 FROM dbo.ride_points p WHERE p.id=i.id);
      SELECT @@ROWCOUNT AS inserted;
    `);
    return result.recordset[0].inserted as number;
  });
  return { received: points.length, inserted, duplicates: points.length - inserted };
}

export async function devices() {
  const result = await (await getSqlPool()).request().query(`
    SELECT d.device_id AS deviceId, DATEDIFF_BIG(millisecond,'19700101',p.recorded_at) AS lastSeenAt,
      p.lat,p.lng,p.accuracy,p.speed,r.id AS activeRideId
    FROM (SELECT DISTINCT device_id FROM dbo.rides) d
    OUTER APPLY(SELECT TOP(1) * FROM dbo.ride_points WHERE device_id=d.device_id ORDER BY recorded_at DESC,id DESC) p
    OUTER APPLY(SELECT TOP(1) id FROM dbo.rides WHERE device_id=d.device_id AND status='active' ORDER BY started_at DESC,id) r
    ORDER BY p.recorded_at DESC,d.device_id;
  `);
  return { data: result.recordset.map(numbers) };
}

export async function rides(request: Request, rideId?: string) {
  const params = new URL(request.url).searchParams;
  const limit = Number(params.get("limit") ?? 50);
  if (!Number.isInteger(limit) || limit < 1 || limit > 500) throw new ApiError("limit must be an integer from 1 to 500.");
  const deviceId = params.get("deviceId");
  if (deviceId !== null) text(deviceId, "deviceId", 100);
  if (rideId) uuid(rideId, "rideId");
  const result = await (await getSqlPool()).request()
    .input("limit", sql.Int, limit).input("device", sql.NVarChar(100), deviceId)
    .input("id", sql.NVarChar(36), rideId ?? null).query(`
      ;WITH selected AS (
        SELECT TOP(@limit) * FROM dbo.rides WHERE (@device IS NULL OR device_id=@device) AND (@id IS NULL OR id=@id)
        ORDER BY started_at DESC,id
      ), counts AS (
        SELECT p.ride_id,COUNT(*) AS pointCount,SUM(CASE WHEN is_filtered=0 THEN 1 ELSE 0 END) AS goodCount,
          SUM(CASE WHEN is_filtered=1 THEN 1 ELSE 0 END) AS filteredCount
        FROM dbo.ride_points p JOIN selected r ON r.id=p.ride_id GROUP BY p.ride_id
      ), good AS (
        SELECT p.ride_id,lat,lng,LAG(lat) OVER(PARTITION BY ride_id ORDER BY recorded_at,p.id) AS prevLat,
          LAG(lng) OVER(PARTITION BY ride_id ORDER BY recorded_at,p.id) AS prevLng
        FROM dbo.ride_points p JOIN selected r ON r.id=p.ride_id WHERE is_filtered=0
      ), haversine AS (
        SELECT ride_id, POWER(SIN(RADIANS(lat-prevLat)/2),2) + COS(RADIANS(prevLat))*COS(RADIANS(lat))*POWER(SIN(RADIANS(lng-prevLng)/2),2) AS a FROM good
      ), distances AS (
        SELECT ride_id,SUM(12742000.0*ASIN(SQRT(CASE WHEN a>1 THEN 1 WHEN a<0 THEN 0 ELSE a END))) AS distanceM FROM haversine GROUP BY ride_id
      )
      SELECT r.id,r.device_id AS deviceId,r.status,
        DATEDIFF_BIG(millisecond,'19700101',r.started_at) AS startedAt,
        DATEDIFF_BIG(millisecond,'19700101',r.ended_at) AS endedAt,
        DATEDIFF_BIG(millisecond,'19700101',r.created_at) AS createdAt,
        DATEDIFF_BIG(millisecond,'19700101',r.updated_at) AS updatedAt,
        DATEDIFF_BIG(millisecond,r.started_at,COALESCE(r.ended_at,SYSUTCDATETIME())) AS durationMs,
        COALESCE(c.pointCount,0) AS pointCount,COALESCE(c.goodCount,0) AS goodCount,
        COALESCE(c.filteredCount,0) AS filteredCount,COALESCE(d.distanceM,0) AS distanceM
      FROM selected r LEFT JOIN counts c ON c.ride_id=r.id LEFT JOIN distances d ON d.ride_id=r.id ORDER BY r.started_at DESC,r.id;
    `);
  if (rideId && !result.recordset.length) throw new ApiError("Ride not found.", 404);
  return { data: rideId ? numbers(result.recordset[0]) : result.recordset.map(numbers) };
}

export async function ridePoints(request: Request, rideId: string) {
  uuid(rideId, "rideId");
  const params = new URL(request.url).searchParams;
  const include = params.get("includeFiltered") ?? "false";
  if (include !== "true" && include !== "false") throw new ApiError("includeFiltered must be true or false.");
  const raw = params.get("since");
  if (raw !== null && !/^\d+$/.test(raw)) throw new ApiError("since must be epoch milliseconds UTC.");
  const since = raw === null ? null : epoch(Number(raw), "since");
  const result = await (await getSqlPool()).request().input("ride", sql.NVarChar(36), rideId)
    .input("include", sql.Bit, include === "true").input("since", sql.DateTime2(3), since === null ? null : new Date(since))
    .query(`SELECT TOP(20000) ${pointColumns} FROM dbo.ride_points WHERE ride_id=@ride
      AND (@include=1 OR is_filtered=0) AND (@since IS NULL OR recorded_at>@since) ORDER BY recorded_at ASC,id ASC;`);
  return { data: result.recordset.map(numbers) };
}

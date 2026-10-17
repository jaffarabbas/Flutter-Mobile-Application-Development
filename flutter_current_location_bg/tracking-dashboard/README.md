# Ride sync API v1 and GPS dashboard

Next.js App Router runs the Node.js API and web UI. MSSQL stores rides and fixes;
Leaflet uses free OpenStreetMap tiles without an API key. No new npm dependencies.
The shared contract is [../docs/SYNC_API.md](../docs/SYNC_API.md).

## Run (PowerShell)

```powershell
cd tracking-dashboard
npm.cmd install
# New installations only: Copy-Item .env.example .env.local
# Edit .env.local for SQL Server credentials and optional API_KEY.
npm.cmd run dev -- --hostname 0.0.0.0 --port 3001
```

Open http://localhost:3001. If the port is occupied, stop its existing server or
choose another port and use that port in mobile/seed URLs. Keep SQL Server running
with database test2 already created and TCP/IP enabled. The SQL user needs CREATE
TABLE permission on first connection, or run database/schema.sql in test2 manually.
The idempotent script adds dbo.rides, dbo.ride_points and indexes without dropping
or changing the legacy dbo.device_positions table. SQL Server 2016+ and database
compatibility level 130+ are required for OPENJSON.

.env.local is ignored by Git. Variables: DB_SERVER, DB_PORT, DB_DATABASE, DB_USERNAME,
DB_PASSWORD, DB_ENCRYPT, DB_TRUST_SERVER_CERTIFICATE, API_KEY. Local defaults use
localhost:1433, test2, encryption enabled and trusted server certificate. Never put
SQL credentials in the browser. If API_KEY is configured, every implemented v1
endpoint checks X-Api-Key. Enter it in the dashboard Connect form; it stays in tab
memory. Use HTTPS and a scoped SQL user outside a trusted testing LAN.

Production mode:

```powershell
npm.cmd run build
npm.cmd run start -- --hostname 0.0.0.0 --port 3001
```

Android emulator API base: http://10.0.2.2:3001/api/v1. Physical phones use
http://YOUR_PC_LAN_IP:3001/api/v1 on the same Wi-Fi with inbound TCP 3001 allowed in
Windows Firewall. Mobile HTTP permissions are configured separately. This change
leaves mobile/native tracking and sync code untouched.

## Dashboard

Use the sun/moon button in the header to switch between light and dark mode. The
initial theme follows your operating system until you choose one; your preference
is saved locally and synchronized across tabs. The saved theme is applied before
the page paints. Dark mode includes the dashboard, map controls, popups and dimmed
OSM tiles, while preserving route/marker colors. No extra dependencies are needed.

The Trace workspace opens the first available device and an active or latest ride
automatically. Search device IDs in the sidebar, then browse ride cards using the
All / Active / Ended filters. Overview cards summarize only the latest 50 rides on
the selected device, not the entire database. Devices show GPS last-seen time, an
online indicator for fixes under 30 seconds old, and active ride status. Lists
refresh every 5 seconds. Connection settings are available from the header icon;
an authentication error opens the API-key form automatically.
Distance is Haversine over consecutive good fixes. Synced means points stored on
this server, not the phone's queued points.

Good fixes are blue, filtered fixes red, raw track optionally grey. Popups show local
time, accuracy, speed in m/s and km/h, filter reason, provider and mocked status.
Bounds fit once; refresh does not reset zoom. Follow pans to new fixes and turns off
when the user drags or pans with arrow keys. Fit entire route explicitly reframes
the map; responsive resizing preserves the camera. Active rides poll every 3 seconds with since and merge
by UUID. Live can be paused. Reload points also picks up older offline uploads.
The export selector chooses good or all points before Export GPX. Start/latest good
fixes have distinct markers; popups include detailed measurements. Mobile screens
use horizontal device and ride lists above the map. Keyboard focus, reduced-motion
support, loading placeholders, empty states, and retry actions are included.

The v1 cursor is strictly recordedAt > since, maximum 20,000 rows per page. Full
pages drain immediately. If more than 20,000 fixes share a boundary timestamp, this
cursor cannot recover every tie; a warning is shown after a full page. Quality and
GPX use the complete server ride, independent of map limits.

Quality uses all fixes ordered by GPS time: maximum gap, gaps strictly over 5 s,
median/p95 non-null accuracy, counts by filter reason (null = none), and median
receivedAt - recordedAt. Percentiles use linear interpolation. Negative delay means
clock skew. GPX contains ordered trackpoints with time, coordinates and optional
elevation, for good fixes or all fixes. Full quality/export currently load a ride
in server memory, appropriate for this testing/R&D service.

## v1 API

All JSON timestamps are numeric epoch milliseconds UTC, including receivedAt.
Ride and point IDs are lowercase UUIDs in 8-4-4-4-12 format. Device IDs are nonempty
strings up to 100 chars; the mobile client generates a persistent UUID. Batch size:
1-500 points. Numeric fields must be finite JSON numbers, not strings. Measurements
may be null. Provider allows at most 20 characters; filterReason allows any string
up to 32 characters, including unknown future reasons. Omitted flags default false.

Success: {success:true,...}; reads use data (list array or single ride object).
Validation: HTTP 400, auth: 401, missing ride detail: 404, DB failure: 503, always
with success:false. Failure never returns 200. Ended rides cannot revert to active.
Existing ride start/device identity is retained; another device's ride ID is invalid.

Batches validate first, then use one serializable SQL transaction with a
transaction-owned application lock. OPENJSON stages all fixes in one request and
set-based inserts auto-create missing rides using the earliest batch fix time.
Existing point IDs and repeats within a batch count as duplicates. Response:
{success:true,received:120,inserted:118,duplicates:2}. HTTP 200 means every ID exists
on the server and the phone can mark those IDs synced.

### Example setup (PowerShell)

Commands use curl.exe to avoid PowerShell's curl alias. Leave key empty when auth
is disabled. Save these two JSON payloads in ride.json and batch.json respectively:

```json
{
  "deviceId": "22222222-2222-4222-8222-222222222222",
  "startedAt": 1760700000000,
  "endedAt": null,
  "status": "active"
}
```

```json
{
  "deviceId": "22222222-2222-4222-8222-222222222222",
  "points": [{
    "id": "33333333-3333-4333-8333-333333333333",
    "rideId": "11111111-1111-4111-8111-111111111111",
    "lat": 24.860712, "lng": 67.001134,
    "accuracy": 4.8, "altitude": 12.3, "speed": 8.4, "bearing": 181,
    "provider": "fused", "isMocked": false, "isFiltered": false,
    "filterReason": null, "recordedAt": 1760700001000
  }]
}
```

```powershell
$base = 'http://localhost:3001'
$key = ''
$headers = @{ 'X-Api-Key' = $key }
$rideId = '11111111-1111-4111-8111-111111111111'
$deviceId = '22222222-2222-4222-8222-222222222222'
```

### PUT /api/v1/rides/{rideId}

```powershell
curl.exe -X PUT "$base/api/v1/rides/$rideId" -H "X-Api-Key: $key" -H 'Content-Type: application/json' --data-binary '@ride.json'
Invoke-RestMethod -Method Put -Uri "$base/api/v1/rides/$rideId" -Headers $headers -ContentType 'application/json' -Body (Get-Content ride.json -Raw)
```

Returns HTTP 200 with success and rideId. End a ride by sending status ended and
numeric endedAt greater than or equal to startedAt.

### POST /api/v1/points/batch

```powershell
curl.exe -X POST "$base/api/v1/points/batch" -H "X-Api-Key: $key" -H 'Content-Type: application/json' --data-binary '@batch.json'
Invoke-RestMethod -Method Post -Uri "$base/api/v1/points/batch" -Headers $headers -ContentType 'application/json' -Body (Get-Content batch.json -Raw)
```

Returns received/inserted/duplicates. Repeating the request is safe.

### GET /api/v1/devices

```powershell
curl.exe "$base/api/v1/devices" -H "X-Api-Key: $key"
Invoke-RestMethod -Uri "$base/api/v1/devices" -Headers $headers
```

Fields: deviceId,lastSeenAt,lat,lng,accuracy,speed,activeRideId.
Devices with rides but no fixes have null fix fields.

### GET /api/v1/rides?deviceId=&limit=50

```powershell
curl.exe "$base/api/v1/rides?deviceId=$deviceId&limit=50" -H "X-Api-Key: $key"
Invoke-RestMethod -Uri "$base/api/v1/rides?deviceId=$deviceId&limit=50" -Headers $headers
```

Omit deviceId for all devices. Limit is an integer 1-500, default 50. Newest first.
Fields: id,deviceId,startedAt,endedAt,status,createdAt,updatedAt,pointCount,goodCount,
filteredCount,distanceM,durationMs. Active duration runs to server time.

### GET /api/v1/rides/{rideId}

```powershell
curl.exe "$base/api/v1/rides/$rideId" -H "X-Api-Key: $key"
Invoke-RestMethod -Uri "$base/api/v1/rides/$rideId" -Headers $headers
```

Returns a single ride with the same statistics as the list.

### GET /api/v1/rides/{rideId}/points

```powershell
curl.exe "$base/api/v1/rides/$rideId/points?includeFiltered=true&since=1760700000000" -H "X-Api-Key: $key"
Invoke-RestMethod -Uri "$base/api/v1/rides/$rideId/points?includeFiltered=true&since=1760700000000" -Headers $headers
```

includeFiltered defaults false. Omit since for initial load; otherwise only strictly
newer GPS timestamps are returned. Maximum 20,000 rows ordered recordedAt ASC, id ASC.
Point fields match the upload plus deviceId and server receivedAt.

### Additional dashboard helpers: GET quality and GPX

These authenticated helpers extend the dashboard without changing the mobile contract.

```powershell
curl.exe "$base/api/v1/rides/$rideId/quality" -H "X-Api-Key: $key"
Invoke-RestMethod -Uri "$base/api/v1/rides/$rideId/quality" -Headers $headers
curl.exe "$base/api/v1/rides/$rideId/gpx?includeFiltered=false" -H "X-Api-Key: $key" -o ride-good.gpx
Invoke-RestMethod -Uri "$base/api/v1/rides/$rideId/gpx?includeFiltered=false" -Headers $headers -OutFile ride-good.gpx
curl.exe "$base/api/v1/rides/$rideId/gpx?includeFiltered=true" -H "X-Api-Key: $key" -o ride-all.gpx
Invoke-RestMethod -Uri "$base/api/v1/rides/$rideId/gpx?includeFiltered=true" -Headers $headers -OutFile ride-all.gpx
```

## Demo without a phone

```powershell
# If server auth is enabled: $env:API_KEY = 'your-key'
node scripts/seed-demo-ride.mjs http://localhost:3001
# Append fixes every 3 seconds for 30 seconds, then end the ride:
node scripts/seed-demo-ride.mjs http://localhost:3001 --live
```

Each run creates random UUIDs, posts 120 fake Karachi points including filtered fixes
and a gap, retries to demonstrate deduplication, and ends the ride. It prints the
device/ride IDs to select in the dashboard. Each run creates a new test ride.

## Checks

```powershell
npm.cmd run lint
npm.cmd run build
# Against a running server, optionally with $env:API_KEY configured:
node scripts/check-v1.mjs http://localhost:3001
```

The integration script creates test devices/rides/points in the configured DB. It
checks 500-point uploads, concurrent retries, same-batch duplicates, auto-rides,
monotonic ended status, failed-batch rollback, numeric timestamps, stats, cursors,
filtering, quality, both GPX variants, validation, and legacy reads. With API_KEY in
the script environment, it checks missing/wrong keys across every v1 endpoint too.

## Legacy compatibility

POST /api/positions, GET /api/positions?limit=50&deviceId=phone-01 and
dbo.device_positions retain their previous behavior, independently of v1 rides.
The new dashboard shows v1 rides only. Legacy map components remain available in
components/TrackingMap.tsx and TrackingMapWrapper.tsx.

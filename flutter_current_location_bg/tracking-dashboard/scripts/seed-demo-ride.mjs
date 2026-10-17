import { randomUUID } from "node:crypto";

// node scripts/seed-demo-ride.mjs [http://localhost:3001] [--live]
const base = (process.argv.find(arg => /^https?:/.test(arg)) ?? "http://localhost:3001").replace(/\/$/, "");
const live = process.argv.includes("--live");
const rideId = randomUUID(), deviceId = randomUUID();
const startedAt = Date.now() - 180_000;
async function call(path, method, body) {
  const response = await fetch(`${base}/api/v1/${path}`, {
    method, headers: { "Content-Type": "application/json", "X-Api-Key": process.env.API_KEY ?? "" },
    body: JSON.stringify(body),
  });
  const result = await response.json();
  if (!response.ok || !result.success) throw new Error(`${response.status}: ${result.message}`);
  return result;
}
const points = Array.from({length:120},(_,i) => {
  const filtered = i%17 === 0;
  return {id:randomUUID(),rideId, lat:24.8607+i*.000025+(filtered ? .0003 : 0), lng:67.0011+i*.00004,
    accuracy:filtered ? 90 : 4+i%6, altitude:12, speed:5, bearing:58,provider:"demo",
    isMocked:false,isFiltered:filtered,filterReason:filtered ? "low_accuracy" : null,
    recordedAt:startedAt+i*1000+(i>=60 ? 8000 : 0)};
});
await call(`rides/${rideId}`,"PUT",{deviceId,startedAt,endedAt:null,status:"active"});
console.log("Batch:",await call("points/batch","POST",{deviceId,points}));
console.log("Retry (duplicates expected):",await call("points/batch","POST",{deviceId,points}));
if(live) {
  console.log("Appending live fixes for 30 seconds. Pan the map to disable Follow.");
  for(let i=0;i<10;i++) {
    await new Promise(resolve=>setTimeout(resolve,3000));
    await call("points/batch","POST",{deviceId,points:[{...points.at(-1),id:randomUUID(),lat:24.864+i*.00005,lng:67.006+i*.00004,recordedAt:Date.now(),isFiltered:false,filterReason:null}]});
  }
}
await call(`rides/${rideId}`,"PUT",{deviceId,startedAt,endedAt:live ? Date.now() : points.at(-1).recordedAt,status:"ended"});
console.log(JSON.stringify({dashboard:base,deviceId,rideId},null,2));

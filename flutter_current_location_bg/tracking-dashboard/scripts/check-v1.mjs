import assert from "node:assert/strict";
import { randomUUID as id } from "node:crypto";
const base=process.argv[2] ?? "http://localhost:3003", key=process.env.API_KEY ?? "";
async function call(path,method="GET",body,expected=200,apiKey=key) {
  const r=await fetch(`${base}/api/v1/${path}`,{method,headers:{"Content-Type":"application/json","X-Api-Key":apiKey},body:body===undefined?undefined:JSON.stringify(body)});
  const j=await r.json();assert.equal(r.status,expected,JSON.stringify(j));assert.equal(j.success,expected<400);return j;
}
const deviceId=id(),rideId=id(),start=Date.now()-10000;
const point=(i=0)=>({id:id(),rideId,lat:24.86+i*.00001,lng:67+i*.00001,recordedAt:start+i*10,accuracy:5,altitude:null,speed:3,bearing:null,provider:"test",isMocked:false,isFiltered:i%10===0,filterReason:i%10===0?"future_reason":null});
await call(`rides/${rideId}`,"PUT",{deviceId,startedAt:start,status:"active",endedAt:null});
const points=Array.from({length:500},(_,i)=>point(i)),before=performance.now();
assert.deepEqual(await call("points/batch","POST",{deviceId,points}),{success:true,received:500,inserted:500,duplicates:0});
console.log(`500-point batch: ${Math.round(performance.now()-before)} ms`);
for(const retry of await Promise.all([call("points/batch","POST",{deviceId,points}),call("points/batch","POST",{deviceId,points})]))assert.equal(retry.duplicates,500);
const same=point(501);
const races=await Promise.all([call("points/batch","POST",{deviceId,points:[same,same]}),call("points/batch","POST",{deviceId,points:[same]})]);
assert.equal(races.reduce((s,r)=>s+r.inserted,0),1);
const all=(await call(`rides/${rideId}/points?includeFiltered=true`)).data;
assert.equal(all.length,501);assert.equal(typeof all[0].recordedAt,"number");assert.equal(typeof all[0].receivedAt,"number");
assert.ok(all.every((p,i)=>i===0 || p.recordedAt>=all[i-1].recordedAt));
assert.equal((await call(`rides/${rideId}/points`)).data.length,451);
assert.equal((await call(`rides/${rideId}/points?since=${start+4990}&includeFiltered=true`)).data.length,1);
let detail=(await call(`rides/${rideId}`)).data;
assert.equal(detail.pointCount,501);assert.equal(detail.filteredCount,50);assert.equal(detail.goodCount,451);assert.ok(detail.distanceM>0);assert.equal(typeof detail.startedAt,"number");
assert.equal((await call(`rides?deviceId=${deviceId}&limit=1`)).data[0].id,rideId);
let device=(await call("devices")).data.find(d=>d.deviceId===deviceId);
assert.equal(device.lastSeenAt,same.recordedAt);assert.equal(device.activeRideId,rideId);
const q=(await call(`rides/${rideId}/quality`)).data;assert.equal(q.pointCount,501);assert.equal(q.medianAccuracy,5);assert.equal(q.filterReasons.future_reason,50);
for(const include of [false,true]) {
 const r=await fetch(`${base}/api/v1/rides/${rideId}/gpx?includeFiltered=${include}`,{headers:{"X-Api-Key":key}});assert.equal(r.status,200);assert.equal(((await r.text()).match(/<trkpt /g)??[]).length,include?501:451);
}
await call(`rides/${rideId}`,"PUT",{deviceId,startedAt:start,status:"ended",endedAt:start+8000});
await call(`rides/${rideId}`,"PUT",{deviceId,startedAt:start,status:"active",endedAt:null});
detail=(await call(`rides/${rideId}`)).data;assert.equal(detail.status,"ended");assert.equal(detail.endedAt,start+8000);
assert.equal((await call("devices")).data.find(d=>d.deviceId===deviceId).activeRideId,null);
const auto=id();await call("points/batch","POST",{deviceId,points:[{...point(),rideId:auto,recordedAt:start+10},{...point(),rideId:auto,recordedAt:start}]});
assert.equal((await call(`rides/${auto}`)).data.startedAt,start);
await call("points/batch","POST",{deviceId,points:[point(),{...point(),lat:91}]},400);
assert.equal((await call(`rides/${rideId}`)).data.pointCount,501);
for(const body of [{deviceId,points:[]},{deviceId,points:Array(501).fill(point())},{deviceId,points:[{...point(),recordedAt:"123"}]},{deviceId,points:[{...point(),lat:null}]},{deviceId,points:[{...point(),id:"bad"}]},{deviceId,points:[{...point(),isFiltered:"yes"}]},{deviceId,points:[{...point(),accuracy:"5"}]},{deviceId,points:[{...point(),filterReason:"x".repeat(33)}]}])await call("points/batch","POST",body,400);
await call(`rides/${rideId}`,"PUT",{deviceId,startedAt:start,status:"ended"},400);
for(const path of ["rides/not-a-uuid","rides?limit=NaN",`rides/${rideId}/points?includeFiltered=1`,`rides/${rideId}/points?since=-1`])await call(path,"GET",undefined,400);
await call(`rides/${id()}`,"GET",undefined,404);
const unknown=id();await call("points/batch","POST",{deviceId:id(),points:[{...point(),rideId:unknown},point()]},400);
await call(`rides/${unknown}`,"GET",undefined,404);
if(key) {
 for(const path of ["devices","rides",`rides/${rideId}`,`rides/${rideId}/points`,`rides/${rideId}/quality`,`rides/${rideId}/gpx`])await call(path,"GET",undefined,401,"");
 await call("points/batch","POST",{deviceId,points:[point()]},401,"wrong");await call(`rides/${rideId}`,"PUT",{},401,"");
}
const legacy=await fetch(`${base}/api/positions?limit=1`);assert.equal(legacy.status,200);assert.equal((await legacy.json()).success,true);
console.log("Passed batch/retry/concurrency, auto-rides, rollback, timestamps, stats, cursors, GPX, validation, auth (if enabled), legacy read.");
console.log({deviceId,rideId,autoCreatedRideId:auto});

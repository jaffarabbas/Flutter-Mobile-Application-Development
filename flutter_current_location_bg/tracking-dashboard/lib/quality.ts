export function percentile(values: number[], q: number) {
  if (!values.length) return null;
  const sorted = [...values].sort((a,b) => a-b);
  const index = (sorted.length-1)*q, lower = Math.floor(index);
  return sorted[lower] + (sorted[Math.ceil(index)]-sorted[lower])*(index-lower);
}
export function quality(points: { recordedAt: number; receivedAt: number; accuracy: number | null; filterReason: string | null }[]) {
  const gaps = points.slice(1).map((p,i) => (p.recordedAt-points[i].recordedAt)/1000);
  const accuracy = points.flatMap(p => p.accuracy === null ? [] : [p.accuracy]);
  const reasons: Record<string, number> = {};
  for (const p of points) reasons[p.filterReason ?? "none"] = (reasons[p.filterReason ?? "none"] ?? 0)+1;
  return { maxGapSeconds: gaps.reduce((max, gap) => Math.max(max, gap), 0), gapsOver5Seconds: gaps.filter(g=>g>5).length,
    medianAccuracy: percentile(accuracy,.5), p95Accuracy: percentile(accuracy,.95), filterReasons: reasons,
    medianUploadDelayMs: percentile(points.map(p=>p.receivedAt-p.recordedAt),.5), pointCount: points.length };
}
export type Quality = ReturnType<typeof quality>;

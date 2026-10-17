"use client";

import dynamic from "next/dynamic";
import { useCallback, useEffect, useState } from "react";
import type { Ride, RidePoint } from "@/lib/sync-types";
import type { Quality } from "@/lib/quality";
import { getDashboardData as get, errorMessage, dateLabel, clockLabel, durationLabel, measure } from "@/lib/dashboard-client";
import { EmptyState, Icon, Notice, ProgressBar, Skeleton, StatusBadge } from "./DashboardUI";

const RideMap = dynamic(() => import("./RideMap"), {
  ssr: false,
  loading: () => <div className="map-placeholder" role="status"><span className="spinner" />Preparing your map...</div>,
});

function QualityPanel({ quality, goodCount, failed }: { quality: Quality | null; goodCount: number; failed: boolean }) {
  const metrics = quality ? [
    { label: "Median accuracy", value: measure(quality.medianAccuracy, "m"), hint: "Typical GPS precision" },
    { label: "95th percentile", value: measure(quality.p95Accuracy, "m"), hint: "Accuracy for 95% of fixes" },
    { label: "Longest gap", value: measure(quality.maxGapSeconds, "s"), hint: `${quality.gapsOver5Seconds} gaps over 5 seconds` },
    { label: "Upload delay", value: measure(quality.medianUploadDelayMs === null ? null : quality.medianUploadDelayMs / 1000, "s"), hint: "Median time to reach server" },
  ] : [];
  const goodPercent = quality?.pointCount ? Math.min(100, goodCount / quality.pointCount * 100) : 0;
  return <section className="surface quality-panel" aria-labelledby="quality-title">
    <div className="section-heading"><div className="heading-with-icon"><span className="section-icon"><Icon name="signal" /></span><div><h3 id="quality-title">Data quality</h3><p>Understand the signal behind the route.</p></div></div><span className="subtle-label">All server fixes</span></div>
    {!quality ? failed ? <EmptyState compact icon="signal" title="Quality data unavailable">Reload the ride to retrieve its GPS quality metrics.</EmptyState> : <div className="quality-metrics" role="status" aria-label="Loading quality metrics">{[0, 1, 2, 3].map(n => <Skeleton key={n} className="metric-skeleton" />)}</div> : <>
      <div className="quality-metrics">{metrics.map(metric => <div className="quality-metric" key={metric.label}><span>{metric.label}</span><strong>{metric.value}</strong><small>{metric.hint}</small></div>)}</div>
      <div className="quality-breakdown"><div className="quality-ratio"><div><span>Good fixes</span><strong>{goodPercent.toFixed(1)}%</strong></div><ProgressBar percent={goodPercent} /><p>{quality.pointCount.toLocaleString()} fixes analyzed, including filtered points.</p></div>
        <div className="reason-list" aria-label="Counts by filter reason">{Object.entries(quality.filterReasons).sort((a, b) => b[1] - a[1]).map(([reason, count]) => <span className={`reason-chip ${reason === "none" ? "neutral" : ""}`} key={reason} title={reason}><span className="status-dot" />{reason === "none" ? "No filter reason" : reason.replaceAll("_", " ")}<strong>{count.toLocaleString()}</strong></span>)}</div>
      </div>
      {quality.medianUploadDelayMs !== null && quality.medianUploadDelayMs < 0 && <p className="quality-note">Negative upload delay indicates a difference between the phone and server clocks.</p>}
    </>}
  </section>;
}

export default function RideDetail({ initial, apiKey }: { initial: Ride; apiKey: string }) {
  const [ride, setRide] = useState(initial);
  const [points, setPoints] = useState<RidePoint[]>([]);
  const [quality, setQuality] = useState<Quality | null>(null);
  const [error, setError] = useState("");
  const [loaded, setLoaded] = useState(false);
  const [refreshing, setRefreshing] = useState(true);
  const [capped, setCapped] = useState(false);
  const [showFiltered, setShowFiltered] = useState(true);
  const [showRaw, setShowRaw] = useState(false);
  const [follow, setFollow] = useState(false);
  const [live, setLive] = useState(true);
  const [reload, setReload] = useState(0);
  const [fitVersion, setFitVersion] = useState(0);
  const [exportAll, setExportAll] = useState(false);
  const [exporting, setExporting] = useState(false);
  const [exportMessage, setExportMessage] = useState("");
  const [updatedAt, setUpdatedAt] = useState<number | null>(null);
  const stopFollowing = useCallback(() => setFollow(false), []);

  useEffect(() => {
    const controller = new AbortController();
    let timer: ReturnType<typeof setTimeout>;
    let last: number | null = null;
    let ended = initial.status === "ended";
    async function load() {
      try {
        const page = await get<RidePoint[]>(`rides/${initial.id}/points?includeFiltered=true${last === null ? "" : `&since=${last}`}`, apiKey, controller.signal);
        if (controller.signal.aborted) return;
        setPoints(previous => {
          const merged = new Map(previous.map(point => [point.id, point]));
          for (const point of page) merged.set(point.id, point);
          return [...merged.values()].sort((a, b) => a.recordedAt - b.recordedAt || a.id.localeCompare(b.id));
        });
        if (page.length) last = page[page.length - 1].recordedAt;
        if (page.length === 20000) setCapped(true);
        const [detail, qualityData] = await Promise.all([
          get<Ride>(`rides/${initial.id}`, apiKey, controller.signal),
          get<Quality>(`rides/${initial.id}/quality`, apiKey, controller.signal),
        ]);
        if (controller.signal.aborted) return;
        setRide(detail);
        setQuality(qualityData);
        setError("");
        setLoaded(true);
        setUpdatedAt(Date.now());
        ended = detail.status === "ended";
        if (page.length === 20000) timer = setTimeout(load, 0);
        else if (!ended && live) timer = setTimeout(load, 3000);
      } catch (loadError) {
        if (!controller.signal.aborted) {
          setError(errorMessage(loadError));
          if (!ended && live) timer = setTimeout(load, 3000);
        }
      } finally {
        if (!controller.signal.aborted) setRefreshing(false);
      }
    }
    void load();
    return () => { controller.abort(); clearTimeout(timer); };
  }, [initial.id, initial.status, apiKey, live, reload]);

  function refresh() { setRefreshing(true); setReload(value => value + 1); }
  async function download() {
    setExporting(true);
    setExportMessage("");
    try {
      const response = await fetch(`/api/v1/rides/${ride.id}/gpx?includeFiltered=${exportAll}`, { headers: { "X-Api-Key": apiKey } });
      if (!response.ok) throw new Error((await response.json()).message ?? "Could not export this ride.");
      const url = URL.createObjectURL(await response.blob());
      const link = document.createElement("a");
      link.href = url;
      link.download = `${ride.id}-${exportAll ? "all" : "good"}.gpx`;
      document.body.appendChild(link);
      link.click();
      link.remove();
      setTimeout(() => URL.revokeObjectURL(url), 1000);
      setExportMessage("GPX file ready.");
    } catch (downloadError) { setExportMessage(errorMessage(downloadError)); }
    finally { setExporting(false); }
  }

  return <div className="ride-detail-stack">
    <section className="surface route-panel" aria-labelledby="route-title">
      <div className="route-heading"><div><div className="title-line"><h2 id="route-title">{dateLabel(ride.startedAt)}</h2><StatusBadge active={ride.status === "active"} /></div><p className="ride-subtitle">{clockLabel(ride.startedAt)}{ride.endedAt !== null ? ` – ${clockLabel(ride.endedAt)}` : " · Ride in progress"}<span className="inline-divider" />{durationLabel(ride.durationMs)}</p></div>
        <div className="export-controls"><select aria-label="Points to include in GPX" value={exportAll ? "all" : "good"} onChange={event => setExportAll(event.target.value === "all")}><option value="good">Good points</option><option value="all">All points</option></select><button className="button button-primary" onClick={() => void download()} disabled={exporting}><Icon name="download" />{exporting ? "Exporting..." : "Export GPX"}</button></div>
      </div>
      {exportMessage && <p className="export-message" role="status">{exportMessage}</p>}
      {error && <Notice onRetry={refresh}>{error}{loaded && " Your last loaded route is still shown."}</Notice>}
      <div className="ride-facts"><span><Icon name="route" /><strong>{(ride.distanceM / 1000).toFixed(2)}</strong> km</span><span><Icon name="pin" /><strong>{ride.pointCount.toLocaleString()}</strong> synced</span><span className="good-fact"><span className="status-dot" /><strong>{ride.goodCount.toLocaleString()}</strong> good</span><span className="filtered-fact"><span className="status-dot" /><strong>{ride.filteredCount.toLocaleString()}</strong> filtered</span></div>
      <div className="map-toolbar"><div className="layer-controls" role="group" aria-label="Map layers"><label className={`layer-toggle ${showFiltered ? "enabled" : ""}`}><input type="checkbox" checked={showFiltered} onChange={event => setShowFiltered(event.target.checked)} /><span className="layer-swatch filtered" />Filtered points</label><label className={`layer-toggle ${showRaw ? "enabled" : ""}`}><input type="checkbox" checked={showRaw} onChange={event => setShowRaw(event.target.checked)} /><Icon name="layers" />Raw track</label></div>
        <div className="camera-controls"><button className={`button button-small ${follow ? "button-tinted" : "button-quiet"}`} aria-pressed={follow} onClick={() => setFollow(value => !value)} title="Follow new points. Drag the map to stop following."><Icon name="follow" />Follow</button><button className="icon-button" onClick={() => setFitVersion(value => value + 1)} aria-label="Fit the entire route" title="Fit entire route" disabled={!points.length}><Icon name="expand" /></button></div>
      </div>
      <div className="map-frame" role="region" aria-label="Ride route map">
        {points.length > 0 ? <RideMap points={points} showFiltered={showFiltered} showRaw={showRaw} follow={follow} onPan={stopFollowing} fitVersion={fitVersion} /> : <div className="map-placeholder">{!loaded && !error ? <><span className="spinner" /><p>Finding your route...</p></> : <EmptyState icon="pin" title={error ? "Map unavailable" : "Waiting for the first fix"}>{error ? "Retry loading to see this ride on the map." : "Synced location points will appear here automatically while this ride is active."}</EmptyState>}</div>}
      </div>
      <div className="map-footer"><div className="map-legend"><span><i className="legend-line" />Good route</span><span><i className="legend-dot start" />Start</span><span><i className="legend-dot finish" />Latest</span></div><span className="subtle-label">{points.length.toLocaleString()} points loaded</span></div>
      {capped && <p className="notice notice-info">Large ride: some fixes sharing a page-boundary timestamp may be absent from the map. Quality and GPX include the full ride.</p>}
      <div className="route-bottom"><span className="update-label"><span className={`status-dot ${error ? "warning" : ""}`} />{updatedAt ? `Updated ${clockLabel(updatedAt)}` : "Waiting for data"}</span><div>{ride.status === "active" && <label className="live-switch"><input type="checkbox" checked={live} onChange={event => setLive(event.target.checked)} /><span className="switch-track" /><span>Live updates <small>3s</small></span></label>}<button className="button button-small button-quiet" onClick={refresh} disabled={refreshing}><Icon name="refresh" className={refreshing ? "spinning" : ""} />{refreshing ? "Refreshing" : "Reload points"}</button></div></div>
      <details className="ride-identifier"><summary>Ride identifier</summary><code>{ride.id}</code></details>
    </section>
    <QualityPanel quality={quality} goodCount={ride.goodCount} failed={Boolean(error)} />
  </div>;
}

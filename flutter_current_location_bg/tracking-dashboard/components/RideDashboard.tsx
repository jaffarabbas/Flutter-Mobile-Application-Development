"use client";

import { useEffect, useState } from "react";
import type { Device, Ride } from "@/lib/sync-types";
import { DashboardError, getDashboardData as get, errorMessage, shortId, dateLabel, clockLabel, durationLabel, relativeTime, measure } from "@/lib/dashboard-client";
import { EmptyState, Icon, Notice, ProgressBar, Skeleton, StatusBadge } from "./DashboardUI";
import type { IconName } from "./DashboardUI";
import RideDetail from "./RideDetail";
import ThemeToggle from "./ThemeToggle";

function Metric({ icon, label, value, note, tone = "blue", loading }: { icon: IconName; label: string; value: string; note: string; tone?: string; loading: boolean }) {
  return <div className="overview-card"><div className="overview-label"><span>{label}</span><span className={`metric-icon ${tone}`}><Icon name={icon} /></span></div>{loading ? <Skeleton className="number-skeleton" /> : <strong className="overview-value">{value}</strong>}<p>{note}</p></div>;
}

function DeviceWorkspace({ device, apiKey, refreshVersion }: { device: Device; apiKey: string; refreshVersion: number }) {
  const [rides, setRides] = useState<Ride[]>([]);
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [filter, setFilter] = useState<"all" | "active" | "ended">("all");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(true);
  const [retry, setRetry] = useState(0);
  useEffect(() => {
    const controller = new AbortController();
    let timer: ReturnType<typeof setTimeout>;
    async function load() {
      try {
        const data = await get<Ride[]>(`rides?deviceId=${encodeURIComponent(device.deviceId)}&limit=50`, apiKey, controller.signal);
        if (!controller.signal.aborted) {
          setRides(data);
          setSelectedId(current => current && data.some(ride => ride.id === current) ? current : data.find(ride => ride.status === "active")?.id ?? data[0]?.id ?? null);
          setError("");
        }
      } catch (loadError) { if (!controller.signal.aborted) setError(errorMessage(loadError)); }
      if (!controller.signal.aborted) { setLoading(false); timer = setTimeout(load, 5000); }
    }
    void load();
    return () => { controller.abort(); clearTimeout(timer); };
  }, [device.deviceId, apiKey, refreshVersion, retry]);

  const selected = rides.find(ride => ride.id === selectedId);
  const visibleRides = rides.filter(ride => filter === "all" || ride.status === filter);
  const totalPoints = rides.reduce((sum, ride) => sum + ride.pointCount, 0);
  const goodPoints = rides.reduce((sum, ride) => sum + ride.goodCount, 0);
  const distance = rides.reduce((sum, ride) => sum + ride.distanceM, 0);

  return <>
    <div className="device-context"><div><span className="context-icon"><Icon name="devices" /></span><div><h2>Device {shortId(device.deviceId)}</h2><p title={device.deviceId}>{device.deviceId}</p></div></div><span className="scope-label">Overview of the latest {rides.length || "50"} rides</span></div>
    <section className="overview-grid" aria-label="Device ride overview">
      <Metric icon="route" label="Recorded rides" value={rides.length.toLocaleString()} note={`${rides.filter(ride => ride.status === "active").length} currently active`} loading={loading} />
      <Metric icon="pin" label="Distance travelled" value={`${(distance / 1000).toLocaleString(undefined, { maximumFractionDigits: 2 })} km`} note="Across good GPS fixes" tone="violet" loading={loading} />
      <Metric icon="layers" label="Synced points" value={totalPoints.toLocaleString()} note="Safely stored on the server" tone="teal" loading={loading} />
      <Metric icon="signal" label="Good fixes" value={totalPoints ? `${(goodPoints / totalPoints * 100).toFixed(1)}%` : "—"} note={totalPoints ? `${goodPoints.toLocaleString()} of ${totalPoints.toLocaleString()} points` : "Waiting for location data"} tone="green" loading={loading} />
    </section>
    {error && <Notice onRetry={() => setRetry(value => value + 1)}>{error}</Notice>}
    <div className="ride-workspace" id="rides">
      <section className="surface ride-history" aria-labelledby="rides-title">
        <div className="history-heading"><div><h2 id="rides-title">Ride history <span className="count-badge">{rides.length}</span></h2><p>Choose a ride to explore.</p></div><Icon name="clock" /></div>
        <div className="segmented-control" role="group" aria-label="Filter rides by status">{(["all", "active", "ended"] as const).map(value => <button key={value} aria-pressed={filter === value} onClick={() => setFilter(value)}>{value === "all" ? "All rides" : value === "active" ? "Active" : "Ended"}</button>)}</div>
        <div className="ride-list" aria-busy={loading}>
          {loading ? <div role="status" aria-label="Loading rides">{[0, 1, 2].map(value => <Skeleton className="ride-skeleton" key={value} />)}</div> : !visibleRides.length ? <EmptyState compact icon="route" title={rides.length ? `No ${filter} rides` : "No rides yet"}>{rides.length ? "Choose another filter to find your rides." : "Start a ride on your phone. It will appear here after syncing."}</EmptyState> : visibleRides.map(ride => <button key={ride.id} className={`ride-card ${selectedId === ride.id ? "is-selected" : ""}`} aria-pressed={selectedId === ride.id} onClick={() => setSelectedId(ride.id)}>
            <span className="ride-card-top"><span className="ride-card-date">{dateLabel(ride.startedAt)}</span><StatusBadge active={ride.status === "active"} /></span>
            <span className="ride-card-time">{clockLabel(ride.startedAt)}<span className="ride-card-chevron"><Icon name="chevron" /></span></span>
            <span className="ride-card-stats"><span><Icon name="route" />{(ride.distanceM / 1000).toFixed(2)} km</span><span><Icon name="clock" />{durationLabel(ride.durationMs)}</span></span>
            <ProgressBar percent={ride.pointCount ? ride.goodCount / ride.pointCount * 100 : 0} />
            <span className="ride-card-counts"><span>{ride.pointCount.toLocaleString()} synced</span><span>{ride.goodCount.toLocaleString()} good · {ride.filteredCount.toLocaleString()} filtered</span></span>
          </button>)}
        </div>
        <div className="history-footer"><Icon name="refresh" /><span>Updates automatically every 5s</span></div>
      </section>
      {selected ? <RideDetail key={selected.id} initial={selected} apiKey={apiKey} /> : <section className="surface unselected-panel">{loading ? <div className="detail-skeleton" role="status" aria-label="Loading ride details"><Skeleton className="heading-skeleton" /><Skeleton className="map-skeleton" /></div> : <EmptyState icon="pin" title="A clearer view of every ride">{error ? "Retry loading your rides to continue." : "Your route, GPS quality and export tools will appear here when a ride is available."}</EmptyState>}</section>}
    </div>
  </>;
}

export default function RideDashboard() {
  const [keyInput, setKeyInput] = useState("");
  const [apiKey, setApiKey] = useState("");
  const [settingsOpen, setSettingsOpen] = useState(false);
  const [devices, setDevices] = useState<Device[]>([]);
  const [deviceId, setDeviceId] = useState<string | null>(null);
  const [query, setQuery] = useState("");
  const [error, setError] = useState("");
  const [authRequired, setAuthRequired] = useState(false);
  const [now, setNow] = useState(0);
  const [loading, setLoading] = useState(true);
  const [refreshVersion, setRefreshVersion] = useState(0);
  const [updatedAt, setUpdatedAt] = useState<number | null>(null);

  useEffect(() => {
    const controller = new AbortController();
    let timer: ReturnType<typeof setTimeout>;
    async function load() {
      try {
        const data = await get<Device[]>("devices", apiKey, controller.signal);
        if (!controller.signal.aborted) {
          setDevices(data);
          setDeviceId(current => current && data.some(device => device.deviceId === current) ? current : data[0]?.deviceId ?? null);
          setError("");
          setAuthRequired(false);
          setNow(Date.now());
          setUpdatedAt(Date.now());
        }
      } catch (loadError) {
        if (!controller.signal.aborted) {
          setError(errorMessage(loadError));
          setAuthRequired(loadError instanceof DashboardError && loadError.status === 401);
          if (loadError instanceof DashboardError && loadError.status === 401) setSettingsOpen(true);
        }
      }
      if (!controller.signal.aborted) { setLoading(false); timer = setTimeout(load, 5000); }
    }
    void load();
    const clock = setInterval(() => setNow(Date.now()), 1000);
    return () => { controller.abort(); clearTimeout(timer); clearInterval(clock); };
  }, [apiKey, refreshVersion]);

  const online = (device: Device) => device.lastSeenAt !== null && now - device.lastSeenAt < 30000 && now >= device.lastSeenAt;
  const selectedDevice = devices.find(device => device.deviceId === deviceId);
  const matchingDevices = devices.filter(device => device.deviceId.toLowerCase().includes(query.toLowerCase().trim()));
  const onlineCount = devices.filter(online).length;

  return <div className="app-shell">
    <a className="skip-link" href="#workspace">Skip to workspace</a>
    <aside className="app-sidebar" aria-label="Device navigation">
      <a className="brand" href="#workspace" aria-label="Trace tracking workspace"><span className="brand-symbol"><Icon name="route" /></span><span>trace<span className="brand-subtitle">TRACKING WORKSPACE</span></span></a>
      <div className="sidebar-section-label">WORKSPACE</div><a className="sidebar-nav is-current" href="#workspace" aria-current="page"><Icon name="route" />Ride explorer<span className="nav-indicator" /></a>
      <div className="sidebar-devices-heading"><h2>Devices</h2><span>{devices.length}</span></div>
      <label className="device-search"><Icon name="search" /><input type="search" aria-label="Search devices by ID" placeholder="Find a device..." value={query} onChange={event => setQuery(event.target.value)} /></label>
      <div className="device-list" aria-busy={loading}>
        {loading ? <div role="status" aria-label="Loading devices">{[0, 1, 2].map(value => <Skeleton className="device-skeleton" key={value} />)}</div> : matchingDevices.map(device => <button className={`device-card ${device.deviceId === deviceId ? "is-selected" : ""}`} key={device.deviceId} aria-pressed={device.deviceId === deviceId} onClick={() => setDeviceId(device.deviceId)} title={device.deviceId}>
          <span className="device-avatar"><Icon name="devices" /></span><span className="device-card-content"><span className="device-name">{shortId(device.deviceId)}</span><span className="device-seen"><span className={`status-dot ${online(device) ? "online" : ""}`} />{online(device) ? "Online" : "Offline"}<span>· {relativeTime(device.lastSeenAt, now)}</span></span>{device.lat !== null && device.lng !== null && <span className="device-coordinates">{device.lat.toFixed(4)}, {device.lng.toFixed(4)}</span>}{device.activeRideId && <span className="sidebar-active">Ride in progress</span>}</span><Icon name="chevron" />
        </button>)}
        {!loading && !matchingDevices.length && <p className="sidebar-empty">{query ? "No matching devices. Try another ID." : error ? "Connect to load your devices." : "Your devices will appear after their first sync."}</p>}
      </div>
      <div className="sidebar-footer"><span className={`connection-dot ${error ? "has-error" : loading ? "is-loading" : ""}`} /><div><strong>{error ? "Connection interrupted" : loading ? "Connecting" : "Server connected"}</strong><span>{error ? "Check connection settings" : "Your workspace updates automatically"}</span></div></div>
    </aside>
    <div className="main-shell"><header className="app-header"><div className="breadcrumbs"><span>Workspace</span><Icon name="chevron" /><strong>Ride explorer</strong></div><div className="header-actions"><ThemeToggle /><span className="online-summary"><span className="status-dot online" />{onlineCount} online<span className="summary-divider">/</span>{devices.length} devices</span><button className={`icon-button ${settingsOpen ? "is-active" : ""}`} aria-expanded={settingsOpen} aria-controls="connection-settings" aria-label="Connection settings" title="Connection settings" onClick={() => setSettingsOpen(value => !value)}><Icon name="settings" /></button></div></header>
      <main className="workspace" id="workspace" tabIndex={-1}>
        <div className="page-heading"><div><p className="eyebrow">LOCATION INTELLIGENCE</p><h1>Ride explorer<span className="title-dot">.</span></h1><p>Follow your devices. Understand every ride.</p></div><div className="page-actions"><span className="last-updated">{updatedAt ? `Synced ${clockLabel(updatedAt)}` : "Waiting for connection"}</span><button className="button button-secondary" onClick={() => setRefreshVersion(value => value + 1)}><Icon name="refresh" />Refresh</button></div></div>
        {settingsOpen && <section className="surface connection-settings" id="connection-settings" aria-labelledby="connection-title"><div className="section-heading"><div className="heading-with-icon"><span className="section-icon"><Icon name="key" /></span><div><h2 id="connection-title">Connection settings</h2><p>Enter an API key if your server requires one.</p></div></div><button className="icon-button" aria-label="Close connection settings" onClick={() => setSettingsOpen(false)}><Icon name="close" /></button></div><form onSubmit={event => { event.preventDefault(); setApiKey(keyInput); setRefreshVersion(value => value + 1); }}><div className="key-field"><label htmlFor="api-key">API key</label><input id="api-key" type="password" placeholder="Leave empty for local testing" value={keyInput} onChange={event => setKeyInput(event.target.value)} autoComplete="off" aria-describedby="key-help" /></div><button className="button button-primary" type="submit">Connect<Icon name="arrow" /></button></form><p id="key-help" className="field-help">Stored in memory for this tab only. Never saved to your browser.</p></section>}
        {error && <Notice onRetry={() => setRefreshVersion(value => value + 1)}>{authRequired ? "This server requires a valid API key. Add it in Connection settings to continue." : error}</Notice>}
        {selectedDevice ? <DeviceWorkspace key={`${selectedDevice.deviceId}:${apiKey}`} device={selectedDevice} apiKey={apiKey} refreshVersion={refreshVersion} /> : <section className="surface welcome-panel">{loading ? <div className="workspace-loading" role="status"><span className="spinner" /><h2>Connecting your workspace</h2><p>Loading devices and their latest rides...</p></div> : <EmptyState icon={authRequired ? "key" : "devices"} title={authRequired ? "Connect your workspace" : error ? "Let's get you reconnected" : "Your next journey starts here"}>{authRequired ? "Enter your API key above to load devices and rides." : error ? "Check that the server is running, then try refreshing." : "Start and sync a ride from your phone. Select its device here to explore the route and GPS quality."}</EmptyState>}</section>}
        <footer className="workspace-footer"><span><Icon name="route" />Trace · Ride research workspace</span>{selectedDevice?.lastSeenAt != null && <span>Last device fix {relativeTime(selectedDevice.lastSeenAt, now)} · {measure(selectedDevice.accuracy, "m")} accuracy</span>}</footer>
      </main>
    </div>
  </div>;
}

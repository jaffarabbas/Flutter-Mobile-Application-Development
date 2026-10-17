"use client";

import { useEffect, useMemo, useState } from "react";
import { MapContainer, Marker, Polyline, Popup, TileLayer, useMap } from "react-leaflet";
import L from "leaflet";

type PositionPoint = {
  id: number;
  deviceId: string;
  latitude: number;
  longitude: number;
  accuracy: number | null;
  speed: number | null;
  source: string;
  createdAt: string;
};

function FollowLatest({ latitude, longitude }: { latitude?: number; longitude?: number }) {
  const map = useMap();
  useEffect(() => {
    if (latitude !== undefined && longitude !== undefined) map.setView([latitude, longitude], 15);
  }, [map, latitude, longitude]);
  return null;
}

export default function TrackingMap() {
  const pinIcon = useMemo(() => {
    if (typeof window === "undefined") {
      return null;
    }

    return L.divIcon({
      className: "tracking-pin",
      html: "<span></span>",
      iconSize: [18, 18],
      iconAnchor: [9, 9],
    });
  }, []);

  const [positions, setPositions] = useState<PositionPoint[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchPositions = async () => {
    try {
      const response = await fetch("/api/positions?limit=50", { cache: "no-store" });
      const payload = await response.json();

      if (!payload.success) {
        throw new Error(payload.message ?? "Failed to load positions.");
      }

      setPositions(payload.data ?? []);
      setError(null);
    } catch (loadError) {
      setError(loadError instanceof Error ? loadError.message : "Unable to load positions.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    const initial = window.setTimeout(fetchPositions, 0);
    const timer = window.setInterval(fetchPositions, 15000);

    return () => {
      window.clearTimeout(initial);
      window.clearInterval(timer);
    };
  }, []);

  const latestPoint = positions[0];
  const paths = useMemo(
    () => Object.values(positions.reduce<Record<string, [number, number][]>>((groups, point) => {
      (groups[point.deviceId] ??= []).push([point.latitude, point.longitude]);
      return groups;
    }, {})),
    [positions],
  );

  const center = useMemo(() => {
    if (!latestPoint) {
      return [0, 0] as [number, number];
    }

    return [latestPoint.latitude, latestPoint.longitude] as [number, number];
  }, [latestPoint]);

  return (
    <section className="panel map-panel">
      <div className="panel-header">
        <div>
          <p className="eyebrow">Live tracking</p>
          <h2>Device position map</h2>
        </div>
        <button type="button" className="refresh-button" onClick={fetchPositions}>
          Refresh
        </button>
      </div>

      {error ? <div className="alert error">{error}</div> : null}

      {loading && positions.length === 0 ? (
        <div className="loading-box">Loading positions…</div>
      ) : (
        <MapContainer center={center} zoom={latestPoint ? 15 : 2} scrollWheelZoom className="map-container">
          <FollowLatest latitude={latestPoint?.latitude} longitude={latestPoint?.longitude} />
          <TileLayer
            url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
            attribution="&copy; OpenStreetMap contributors"
          />

          {paths.map((path, index) => path.length > 1 ? (
            <Polyline key={index} positions={path} pathOptions={{ color: "#2563eb", weight: 4, opacity: 0.9 }} />
          ) : null)}

          {positions.map((point) => (
            <Marker
              key={point.id}
              position={[point.latitude, point.longitude]}
              icon={pinIcon ?? undefined}
            >
              <Popup>
                <strong>{point.deviceId}</strong>
                <br />
                Lat: {point.latitude}
                <br />
                Lng: {point.longitude}
                <br />
                Speed: {point.speed ?? "n/a"} m/s
              </Popup>
            </Marker>
          ))}
        </MapContainer>
      )}

      <div className="status-row">
        <div className="stat-box">
          <span>Total points</span>
          <strong>{positions.length}</strong>
        </div>
        <div className="stat-box">
          <span>Latest latitude</span>
          <strong>{latestPoint ? latestPoint.latitude.toFixed(6) : "-"}</strong>
        </div>
        <div className="stat-box">
          <span>Latest longitude</span>
          <strong>{latestPoint ? latestPoint.longitude.toFixed(6) : "-"}</strong>
        </div>
      </div>
    </section>
  );
}

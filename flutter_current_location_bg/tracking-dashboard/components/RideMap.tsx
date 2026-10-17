"use client";

import { useEffect, useRef } from "react";
import { MapContainer, TileLayer, Polyline, CircleMarker, Popup, useMap, useMapEvents } from "react-leaflet";
import L from "leaflet";
import type { RidePoint } from "@/lib/sync-types";
import { measure } from "@/lib/dashboard-client";

function Camera({ points, follow, onPan, fitVersion }: { points: RidePoint[]; follow: boolean; onPan: () => void; fitVersion: number }) {
  const map = useMap();
  const fitted = useRef(false);
  const lastFit = useRef(fitVersion);
  const lastFollowed = useRef<string | null>(null);
  useMapEvents({
    dragstart: onPan,
    keydown: event => {
      if (["ArrowUp", "ArrowDown", "ArrowLeft", "ArrowRight"].includes(event.originalEvent.key)) onPan();
    },
  });
  useEffect(() => {
    // Leaflet otherwise retains a stale viewport after responsive layout changes.
    const observer = new ResizeObserver(() => map.invalidateSize({ pan: false }));
    observer.observe(map.getContainer());
    return () => observer.disconnect();
  }, [map]);
  useEffect(() => {
    if (!points.length) return;
    const latest = points[points.length - 1];
    if (!fitted.current || lastFit.current !== fitVersion) {
      map.fitBounds(L.latLngBounds(points.map(point => [point.lat, point.lng])), { padding: [35, 35], maxZoom: 17, animate: false });
      fitted.current = true;
      lastFit.current = fitVersion;
      lastFollowed.current = latest.id;
    } else if (follow && lastFollowed.current !== latest.id) {
      map.panTo([latest.lat, latest.lng], { animate: false });
      lastFollowed.current = latest.id;
    }
    if (!follow) lastFollowed.current = null;
  }, [map, points, follow, fitVersion]);
  return null;
}

function PointPopup({ point, label }: { point: RidePoint; label?: string }) {
  return <Popup><div className="point-popup"><strong>{label ?? (point.isFiltered ? "Filtered fix" : "GPS fix")}</strong><small>{new Date(point.recordedAt).toLocaleString()}</small><small>{point.lat.toFixed(6)}, {point.lng.toFixed(6)}</small><dl>
    <dt>Accuracy</dt><dd>{measure(point.accuracy, "m")}</dd>
    <dt>Speed</dt><dd>{measure(point.speed, "m/s")}</dd>
    <dt>Speed in km/h</dt><dd>{measure(point.speed === null || point.speed < 0 ? null : point.speed * 3.6, "km/h")}</dd>
    <dt>Filter reason</dt><dd className={point.isFiltered ? "filtered-value" : ""}>{point.filterReason ?? "None"}</dd>
    <dt>Provider</dt><dd>{point.provider ?? "Unavailable"}</dd>
    <dt>Mocked</dt><dd>{point.isMocked ? "Yes" : "No"}</dd>
  </dl></div></Popup>;
}

export default function RideMap({ points, showFiltered, showRaw, follow, onPan, fitVersion = 0 }: {
  points: RidePoint[]; showFiltered: boolean; showRaw: boolean; follow: boolean; onPan: () => void; fitVersion?: number;
}) {
  const good = points.filter(point => !point.isFiltered);
  const start = good[0];
  const latest = good[good.length - 1];
  return <MapContainer center={[24.86, 67.01]} zoom={12} className="map-container" scrollWheelZoom preferCanvas>
    <TileLayer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" attribution={'&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'} />
    <Camera points={points} follow={follow} onPan={onPan} fitVersion={fitVersion} />
    {showRaw && <Polyline positions={points.map(point => [point.lat, point.lng])} pathOptions={{ color: "#939eaf", weight: 2, opacity: .65 }} />}
    <Polyline positions={good.map(point => [point.lat, point.lng])} pathOptions={{ color: "#4778ed", weight: 4, opacity: .9 }} />
    {points.filter(point => !point.isFiltered || showFiltered).map(point => <CircleMarker key={point.id} center={[point.lat, point.lng]} radius={point.isFiltered ? 5 : 3}
      pathOptions={{ color: point.isFiltered ? "#cf6176" : "#4778ed", fillColor: point.isFiltered ? "#ed96a6" : "#fff", fillOpacity: .9, weight: point.isFiltered ? 1.5 : 1 }}><PointPopup point={point} /></CircleMarker>)}
    {start && <CircleMarker center={[start.lat, start.lng]} radius={7} pathOptions={{ color: "#fff", fillColor: "#35a184", fillOpacity: 1, weight: 3 }}><PointPopup point={start} label="Route start · first good fix" /></CircleMarker>}
    {latest && latest.id !== start?.id && <CircleMarker center={[latest.lat, latest.lng]} radius={7} pathOptions={{ color: "#fff", fillColor: "#4778ed", fillOpacity: 1, weight: 3 }}><PointPopup point={latest} label="Latest good fix" /></CircleMarker>}
  </MapContainer>;
}

"use client";

import dynamic from "next/dynamic";

const TrackingMap = dynamic(() => import("./TrackingMap"), {
  ssr: false,
  loading: () => <div className="loading-box">Loading map…</div>,
});

export default function TrackingMapWrapper() {
  return <TrackingMap />;
}

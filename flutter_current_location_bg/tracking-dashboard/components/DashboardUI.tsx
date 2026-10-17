import type { CSSProperties, ReactNode } from "react";

export type IconName = "route" | "devices" | "search" | "arrow" | "refresh" | "download" | "settings" | "signal" | "clock" | "pin" | "layers" | "follow" | "expand" | "check" | "alert" | "close" | "key" | "chevron" | "sun" | "moon";
const paths: Record<IconName, ReactNode> = {
  sun: <><circle cx="12" cy="12" r="4" /><path d="M12 2v2m0 16v2M2 12h2m16 0h2M5 5l1.5 1.5m11 11L19 19M5 19l1.5-1.5m11-11L19 5" /></>,
  moon: <path d="M20.5 13A9 9 0 0 1 11 3.5 9 9 0 1 0 20.5 13Z" />,
  route: <><circle cx="6" cy="5" r="2" /><circle cx="18" cy="19" r="2" /><path d="M6 7v7a4 4 0 0 0 4 4h2M18 17V10a4 4 0 0 0-4-4h-2" /></>,
  devices: <><rect x="6" y="2" width="12" height="20" rx="3" /><path d="M10 5h4M11 18h2" /></>,
  search: <><circle cx="10.5" cy="10.5" r="6.5" /><path d="m16 16 4.5 4.5" /></>,
  arrow: <path d="M4 12h16m-6-6 6 6-6 6" />,
  refresh: <><path d="M20 7v5h-5M4 17v-5h5" /><path d="M6 7a7 7 0 0 1 12-1l2 3M4 15l2 3a7 7 0 0 0 12-1" /></>,
  download: <><path d="M12 3v12m-5-5 5 5 5-5M4 16v4h16v-4" /></>,
  settings: <><path d="M4 7h16M4 17h16" /><circle cx="9" cy="7" r="3" /><circle cx="15" cy="17" r="3" /></>,
  signal: <><path d="M5 19v-4m5 4V9m5 10V5m5 14V2" /></>,
  clock: <><circle cx="12" cy="12" r="9" /><path d="M12 7v5l3 2" /></>,
  pin: <><path d="M19 10c0 5-7 11-7 11S5 15 5 10a7 7 0 1 1 14 0Z" /><circle cx="12" cy="10" r="2.5" /></>,
  layers: <><path d="m3 8 9-5 9 5-9 5-9-5Zm0 5 9 5 9-5M3 18l9 5 9-5" /></>,
  follow: <><circle cx="12" cy="12" r="6" /><path d="M12 2v4m0 12v4M2 12h4m12 0h4" /><circle cx="12" cy="12" r="1" /></>,
  expand: <path d="M8 3H3v5m13-5h5v5M3 16v5h5m13-5v5h-5" />,
  check: <path d="m5 12 4 4L19 6" />,
  alert: <><path d="m12 3 10 18H2L12 3Z" /><path d="M12 9v5m0 3v.1" /></>,
  close: <path d="m6 6 12 12M6 18 18 6" />,
  key: <><circle cx="8" cy="9" r="5" /><path d="m12 13 8 8m-5-5 3-3m0 6 3-3" /></>,
  chevron: <path d="m9 5 7 7-7 7" />,
};
export function Icon({ name, className = "" }: { name: IconName; className?: string }) {
  return <svg className={`icon ${className}`} width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.7" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">{paths[name]}</svg>;
}
export function EmptyState({ icon = "route", title, children, compact = false }: { icon?: IconName; title: string; children: ReactNode; compact?: boolean }) {
  return <div className={`empty-state ${compact ? "compact" : ""}`}><span className="empty-icon"><Icon name={icon} /></span><h3>{title}</h3><p>{children}</p></div>;
}
export function Notice({ children, onRetry }: { children: ReactNode; onRetry?: () => void }) {
  return <div className="notice notice-error" role="alert"><Icon name="alert" /><div>{children}</div>{onRetry && <button className="text-button" onClick={onRetry}>Try again</button>}</div>;
}
export function Skeleton({ className = "" }: { className?: string }) { return <div className={`skeleton ${className}`} aria-hidden="true" />; }
export function StatusBadge({ active }: { active: boolean }) {
  return <span className={`status-badge ${active ? "is-active" : ""}`}><span className="status-dot" />{active ? "Active" : "Ended"}</span>;
}
export function ProgressBar({ percent, className = "" }: { percent: number; className?: string }) {
  return <div className={`progress-track ${className}`} aria-hidden="true"><span style={{ "--progress": `${Math.max(0, Math.min(100, percent))}%` } as CSSProperties} /></div>;
}

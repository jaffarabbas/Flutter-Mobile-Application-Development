"use client";

import { useSyncExternalStore } from "react";
import { Icon } from "./DashboardUI";

type Theme = "light" | "dark";
const storageKey = "trace-theme";
const changeEvent = "trace-theme-change";

function systemTheme(): Theme {
  return window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light";
}
function savedTheme(): Theme | null {
  try {
    const value = localStorage.getItem(storageKey);
    return value === "light" || value === "dark" ? value : null;
  } catch { return null; }
}
function applyTheme(theme: Theme) {
  document.documentElement.dataset.theme = theme;
}
function subscribe(notify: () => void) {
  const media = window.matchMedia("(prefers-color-scheme: dark)");
  const onSystemChange = () => {
    if (!savedTheme()) { applyTheme(systemTheme()); notify(); }
  };
  const onStorage = (event: StorageEvent) => {
    if (event.key === storageKey || event.key === null) {
      applyTheme(savedTheme() ?? systemTheme());
      notify();
    }
  };
  media.addEventListener("change", onSystemChange);
  window.addEventListener("storage", onStorage);
  window.addEventListener(changeEvent, notify);
  return () => {
    media.removeEventListener("change", onSystemChange);
    window.removeEventListener("storage", onStorage);
    window.removeEventListener(changeEvent, notify);
  };
}
const snapshot = (): Theme => document.documentElement.dataset.theme === "dark" ? "dark" : "light";
const serverSnapshot = (): Theme => "light";

export default function ThemeToggle() {
  const theme = useSyncExternalStore(subscribe, snapshot, serverSnapshot);
  const label = `Switch to ${theme === "dark" ? "light" : "dark"} mode`;
  return <button type="button" className="icon-button theme-toggle" title={label} aria-label={label} aria-pressed={theme === "dark"} onClick={() => {
    const next = theme === "dark" ? "light" : "dark";
    applyTheme(next);
    try { localStorage.setItem(storageKey, next); } catch { /* Theme still works when storage is blocked. */ }
    window.dispatchEvent(new Event(changeEvent));
  }}><Icon name={theme === "dark" ? "sun" : "moon"} /></button>;
}

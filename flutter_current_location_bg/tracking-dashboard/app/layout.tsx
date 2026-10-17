import type { Metadata } from "next";
import "leaflet/dist/leaflet.css";
import "./globals.css";


export const metadata: Metadata = {
  title: "Trace | Ride explorer",
  description: "Explore synced GPS rides, follow live routes, and understand location data quality.",
};

export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html lang="en" suppressHydrationWarning>
      <head>
        {/* Apply the saved/system theme before paint. Only html's theme attribute changes before hydration. */}
        <script id="trace-theme-init" dangerouslySetInnerHTML={{ __html: `(function(){try{var t=localStorage.getItem('trace-theme');document.documentElement.dataset.theme=t==='light'||t==='dark'?t:matchMedia('(prefers-color-scheme: dark)').matches?'dark':'light'}catch(e){document.documentElement.dataset.theme=matchMedia('(prefers-color-scheme: dark)').matches?'dark':'light'}})();` }} />
      </head>
      <body>{children}</body>
    </html>
  );
}

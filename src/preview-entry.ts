// Used only by wrangler.preview.json. Production keeps src/final-entry.ts.
import site from "./final-entry";
import {readOnlyDatabase} from "./readonly-db";
type Env = Parameters<typeof site.fetch>[1] & { APP_ENV?: string };
const ROBOTS = "noindex, nofollow, noarchive";

export function protect(response: Response, head = false): Response {
  const headers = new Headers(response.headers);
  headers.set("X-Robots-Tag", ROBOTS);
  headers.set("Cache-Control", "no-store");
  headers.set("Referrer-Policy", "no-referrer");
  // Third-party ad / analytics scripts and API calls must not run in previews.
  headers.set("Content-Security-Policy", "script-src 'self' 'unsafe-inline'; connect-src 'self'; frame-src 'none'; object-src 'none'; base-uri 'self'; form-action 'none'");
  headers.delete("set-cookie");
  headers.delete("content-length");
  headers.delete("etag");
  return new Response(head ? null : response.body, {status: response.status, statusText: response.statusText, headers});
}

export function previewHtml(html: string): string {
  html = html.replace(/<script\b[^>]*>[\s\S]*?<\/script\s*>/gi, script =>
    /adsbygoogle|googlesyndication|googletagmanager|google-analytics|\bgtag\s*\(|\bdataLayer\b/i.test(script) ? "" : script);
  html = html.replace(/<meta\b(?=[^>]*\bname=["'](?:robots|googlebot|googlebot-news)["'])[^>]*>/gi, "");
  return html.replace(/<\/head>/i, `<meta name="robots" content="${ROBOTS}"></head>`);
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);
    const head = request.method === "HEAD";
    // Fail closed if someone accidentally deploys this entrypoint as production.
    if (env.APP_ENV !== "preview" || /^(?:www\.)?inu-taikenki\.com$/i.test(url.hostname)) {
      return protect(new Response("Preview configuration required", {status: 503}), head);
    }
    if (!["GET", "HEAD"].includes(request.method)) {
      return protect(new Response("Preview is read-only", {status: 405, headers:{Allow:"GET, HEAD"}}));
    }
    // Allow crawling so crawlers can see noindex; robots Disallow alone is insufficient.
    if (url.pathname === "/robots.txt") return protect(new Response("User-agent: *\nAllow: /\n", {headers:{"Content-Type":"text/plain"}}), head);
    if (["/sitemap.xml", "/ads.txt"].includes(url.pathname)) return protect(new Response("", {status:404}), head);
    if (!env.DB) return protect(new Response("Preview database unavailable", {status:503}), head);
    try {
      const safeEnv = Object.freeze({DB: readOnlyDatabase(env.DB), ASSETS: env.ASSETS});
      let response = await site.fetch(head ? new Request(request.url, {headers:request.headers}) : request, safeEnv);
      if (response.headers.get("content-type")?.includes("text/html")) {
        response = new Response(previewHtml(await response.text()), {status:response.status, statusText:response.statusText, headers:response.headers});
      }
      return protect(response, head);
    } catch {
      return protect(new Response("Preview unavailable", {status:503}), head);
    }
  }
};

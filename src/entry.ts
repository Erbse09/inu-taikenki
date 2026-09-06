import worker from "./index";

type WorkerEnv = Parameters<typeof worker.fetch>[1];

const GA4_ID = "G-QPN12RPX3N";
const GA4_TAG = `<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=${GA4_ID}"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', '${GA4_ID}');
</script>`;

function withAnalytics(response: Response, html: string) {
  const headers = new Headers(response.headers);
  headers.delete("content-length");
  headers.delete("etag");
  return new Response(html, {
    status: response.status,
    statusText: response.statusText,
    headers,
  });
}

export default {
  async fetch(request: Request, env: WorkerEnv): Promise<Response> {
    const response = await worker.fetch(request, env);

    if (request.method !== "GET" || !response.ok) return response;
    const contentType = response.headers.get("content-type") ?? "";
    if (!contentType.includes("text/html")) return response;

    let html = await response.text();
    if (html.includes(GA4_ID)) return withAnalytics(response, html);

    if (html.includes("<head>")) {
      html = html.replace("<head>", `<head>\n${GA4_TAG}`);
    } else if (html.includes("</head>")) {
      html = html.replace("</head>", `${GA4_TAG}\n</head>`);
    } else {
      return withAnalytics(response, html);
    }

    return withAnalytics(response, html);
  },
};

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

function alignHomepageReviewCounts(request: Request, html: string) {
  const pathname = new URL(request.url).pathname;
  if (pathname !== "/" && pathname !== "/index.html") return html;

  html = html.replaceAll('<b>10</b><span>具体的な体験</span>', '<b>50</b><span>公開体験DB</span>');
  html = html.replace('犬の具体的な公開体験10件から「うちの子なら？」を比べます。', '公開体験50件をDBに整理し、記事内の具体例から「うちの子なら？」を比べます。');
  html = html.replace('犬種が分かる公開体験を中心に25件整理。乾燥時間・音への反応・困った点まで比較しました。', '犬種が分かる公開体験50件をDBに整理。記事内では代表例も掲載し、乾燥時間・音への反応・困った点まで比較しました。');
  html = html.replace('<b>25</b><span>具体的な体験</span>', '<b>50</b><span>公開体験DB</span>');
  return html;
}

export default {
  async fetch(request: Request, env: WorkerEnv): Promise<Response> {
    const response = await worker.fetch(request, env);

    if (request.method !== "GET" || !response.ok) return response;
    const contentType = response.headers.get("content-type") ?? "";
    if (!contentType.includes("text/html")) return response;

    let html = await response.text();
    html = alignHomepageReviewCounts(request, html);
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

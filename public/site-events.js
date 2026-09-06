(() => {
  const send = (name, params = {}) => {
    if (typeof window.gtag !== 'function') return;
    window.gtag('event', name, params);
  };

  document.addEventListener('click', (event) => {
    const target = event.target instanceof Element ? event.target.closest('a[href]') : null;
    if (!(target instanceof HTMLAnchorElement)) return;

    let url;
    try {
      url = new URL(target.href, location.href);
    } catch {
      return;
    }

    const isAmazon = /(^|\.)amazon\.(co\.jp|com)$/i.test(url.hostname) || /(^|\.)amzn\.to$/i.test(url.hostname);
    if (!isAmazon) return;

    const productContainer = target.closest('.card, .product-card, .reco, [data-product-id]');
    const productName = productContainer?.querySelector('h3, .product-name, .reco-name')?.textContent?.trim() || '';

    send('affiliate_click', {
      affiliate_network: 'amazon',
      page_path: location.pathname,
      link_text: target.textContent?.trim().slice(0, 80) || 'amazon_link',
      product_name: productName.slice(0, 100),
    });
  });

  const category = document.getElementById('category');
  const size = document.getElementById('size');
  const coat = document.getElementById('coat');
  const query = document.getElementById('query');

  if (category && size && coat && query) {
    let timer;
    const sendFilter = () => {
      window.clearTimeout(timer);
      timer = window.setTimeout(() => {
        send('review_filter', {
          page_path: location.pathname,
          category: category.value || 'all',
          dog_size: size.value || 'all',
          coat_type: coat.value || 'all',
          has_query: query.value.trim() ? 'yes' : 'no',
        });
      }, 250);
    };

    category.addEventListener('change', sendFilter);
    size.addEventListener('change', sendFilter);
    coat.addEventListener('change', sendFilter);
    query.addEventListener('change', sendFilter);
  }
})();

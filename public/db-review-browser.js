(() => {
  const INITIAL_COUNT = 4;
  const PAGE_SIZE = 6;

  const esc = (value) => String(value ?? '')
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#039;');

  async function initBrowser(section) {
    const category = section.dataset.category;
    const select = section.querySelector('[data-db-product-select]');
    const status = section.querySelector('[data-db-status]');
    const list = section.querySelector('[data-db-review-list]');
    const more = section.querySelector('[data-db-more]');
    if (!category || !select || !status || !list || !more) return;

    let currentData = null;
    let visibleCount = INITIAL_COUNT;

    const renderReviews = () => {
      if (!currentData) {
        list.innerHTML = '';
        more.hidden = true;
        return;
      }

      const reviews = currentData.reviews || [];
      const visible = reviews.slice(0, visibleCount);
      list.innerHTML = visible.map((review) => `
        <article class="db-review-card">
          <div class="db-review-product">${esc(currentData.product.name)}</div>
          <div class="db-review-dog">${esc(review.dog_breed || '犬種情報なし')}</div>
          <div class="db-review-summary">${esc(review.summary)}</div>
        </article>
      `).join('');

      if (!reviews.length) {
        list.innerHTML = '<div class="db-empty">この商品に紐づく体験はまだDBにありません。</div>';
      }

      const remaining = Math.max(0, reviews.length - visibleCount);
      more.hidden = remaining === 0;
      more.textContent = remaining > 0 ? 'もっと見る（あと' + remaining + '件）' : 'すべて表示しました';
    };

    const loadReviews = async (productId) => {
      if (!productId) {
        currentData = null;
        list.innerHTML = '';
        status.textContent = '';
        more.hidden = true;
        return;
      }

      visibleCount = INITIAL_COUNT;
      currentData = null;
      status.textContent = '体験を読み込み中…';
      list.innerHTML = '';
      more.hidden = true;

      try {
        const res = await fetch('/api/products/' + encodeURIComponent(productId) + '/reviews');
        if (!res.ok) throw new Error('reviews request failed');
        currentData = await res.json();
        status.textContent = currentData.count + '件';
        renderReviews();
      } catch (error) {
        status.textContent = '読み込みに失敗しました';
        list.innerHTML = '<div class="db-empty">データを取得できませんでした。</div>';
        console.error(error);
      }
    };

    more.addEventListener('click', () => {
      visibleCount += PAGE_SIZE;
      renderReviews();
    });

    select.addEventListener('change', () => loadReviews(select.value));

    try {
      const res = await fetch('/api/products?category=' + encodeURIComponent(category));
      if (!res.ok) throw new Error('products request failed');
      const data = await res.json();
      const products = data.products || [];

      if (!products.length) {
        select.innerHTML = '<option value="">DB登録準備中</option>';
        status.textContent = 'このカテゴリの商品はまだDBにありません';
        more.hidden = true;
        return;
      }

      select.innerHTML = products.map((product) =>
        '<option value="' + esc(product.id) + '">' + esc(product.name) + '</option>'
      ).join('');

      select.value = products[0].id;
      await loadReviews(products[0].id);
    } catch (error) {
      select.innerHTML = '<option value="">商品一覧を取得できません</option>';
      status.textContent = 'API未接続';
      more.hidden = true;
      console.error(error);
    }
  }

  document.querySelectorAll('[data-db-review-browser]').forEach(initBrowser);
})();
(() => {
  const INITIAL_COUNT = 6;
  const PAGE_SIZE = 8;
  const AMAZON_TAG = '100things-22';

  const esc = (value) => String(value ?? '')
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#039;');

  const SIZE_LABELS = {
    small: '小型',
    medium: '中型',
    large: '大型',
  };

  const COAT_LABELS = {
    short: '短毛',
    long: '長毛',
    double: 'ダブルコート',
    curly: '巻毛',
    fluffy: 'ふわふわ毛',
    single: 'シングルコート',
  };

  const NEED_LABELS = {
    scared: '怖がり',
    puppy: '子犬',
    senior: 'シニア',
    speed: '時短',
    handsfree: 'ハンズフリー',
    shedding: '抜け毛',
    mat: '毛玉',
    tangle: 'もつれ',
    gentle: 'やさしさ重視',
    relaxed: '落ち着いて使用',
    multi: '多頭',
    'multi-dog': '多頭',
    daily: '日常ケア',
    grooming: 'お手入れ',
    face: '顔まわり',
    skin: '皮膚配慮',
    'skin-sensitive': '皮膚配慮',
    quiet: '静音',
    camera: 'カメラ',
    travel: '外出・旅行',
    mischief: 'いたずら対策',
  };

  const QUERY_ALIASES = {
    怖がり: 'scared',
    子犬: 'puppy',
    シニア: 'senior',
    時短: 'speed',
    抜け毛: 'shedding',
    毛玉: 'mat',
    もつれ: 'tangle',
    多頭: 'multi',
    静音: 'quiet',
    皮膚: 'skin',
    カメラ: 'camera',
    旅行: 'travel',
    いたずら: 'mischief',
    ハンズフリー: 'handsfree',
  };

  const tokens = (value) => String(value ?? '')
    .trim()
    .split(/\s+/)
    .map((token) => token.toLowerCase())
    .filter((token) => token && token !== 'null');

  const unique = (values) => [...new Set(values)];

  const labelsForReview = (review) => {
    const labels = [];
    tokens(review.dog_size).forEach((token) => {
      if (SIZE_LABELS[token]) labels.push(SIZE_LABELS[token]);
    });
    tokens(review.coat_type).forEach((token) => {
      if (COAT_LABELS[token]) labels.push(COAT_LABELS[token]);
    });
    tokens(review.needs).forEach((token) => {
      if (NEED_LABELS[token]) labels.push(NEED_LABELS[token]);
    });
    return unique(labels).slice(0, 6);
  };

  async function initBrowser(section) {
    const category = section.dataset.category;
    const select = section.querySelector('[data-db-product-select]');
    const status = section.querySelector('[data-db-status]');
    const list = section.querySelector('[data-db-review-list]');
    const more = section.querySelector('[data-db-more]');
    const controls = section.querySelector('.db-controls');
    if (!category || !select || !status || !list || !more || !controls) return;

    let currentData = null;
    let visibleCount = INITIAL_COUNT;
    let categoryTotal = 0;
    const filterState = { size: '', coat: '', query: '' };

    const note = section.querySelector('.db-review-note');
    if (note) {
      note.textContent = '商品を選び、犬のサイズ・毛質・キーワードで近い体験を絞り込めます。書かれていない犬情報は推測していません。';
    }

    const totalBadge = document.createElement('div');
    totalBadge.className = 'db-total-badge';
    totalBadge.setAttribute('aria-live', 'polite');
    controls.before(totalBadge);

    const allSearchLink = document.createElement('a');
    allSearchLink.className = 'db-all-search-link';
    allSearchLink.href = '/review-search.html?category=' + encodeURIComponent(category);
    allSearchLink.textContent = 'このカテゴリ50件をまとめて検索 →';
    totalBadge.after(allSearchLink);

    const filters = document.createElement('div');
    filters.className = 'db-review-filters';
    filters.innerHTML = `
      <label class="db-filter-field">
        <span>犬のサイズ</span>
        <select data-db-size-filter>
          <option value="">すべて</option>
          <option value="small">小型</option>
          <option value="medium">中型</option>
          <option value="large">大型</option>
        </select>
      </label>
      <label class="db-filter-field">
        <span>毛質</span>
        <select data-db-coat-filter>
          <option value="">すべて</option>
          <option value="short">短毛</option>
          <option value="long">長毛</option>
          <option value="double">ダブルコート</option>
          <option value="curly">巻毛</option>
        </select>
      </label>
      <label class="db-filter-field db-filter-search">
        <span>キーワード</span>
        <input data-db-query-filter type="search" inputmode="search" placeholder="例：怖がり、子犬、抜け毛" autocomplete="off">
      </label>
      <button class="db-filter-reset" type="button" data-db-filter-reset>条件をクリア</button>
    `;
    controls.after(filters);

    const sizeFilter = filters.querySelector('[data-db-size-filter]');
    const coatFilter = filters.querySelector('[data-db-coat-filter]');
    const queryFilter = filters.querySelector('[data-db-query-filter]');
    const resetFilter = filters.querySelector('[data-db-filter-reset]');

    const filteredReviews = () => {
      if (!currentData) return [];
      const query = filterState.query.trim().toLowerCase();
      const alias = QUERY_ALIASES[query] || '';
      return (currentData.reviews || []).filter((review) => {
        if (filterState.size && !tokens(review.dog_size).includes(filterState.size)) return false;
        if (filterState.coat && !tokens(review.coat_type).includes(filterState.coat)) return false;
        if (query) {
          const haystack = [
            review.dog_breed,
            review.dog_size,
            review.coat_type,
            review.needs,
            review.summary,
          ].filter(Boolean).join(' ').toLowerCase();
          if (!haystack.includes(query) && (!alias || !haystack.includes(alias))) return false;
        }
        return true;
      });
    };

    const renderReviews = () => {
      if (!currentData) {
        list.innerHTML = '';
        more.hidden = true;
        return;
      }

      const reviews = filteredReviews();
      const visible = reviews.slice(0, visibleCount);
      list.innerHTML = visible.map((review) => {
        const tags = labelsForReview(review);
        const tagsHtml = tags.length
          ? '<div class="db-review-tags">' + tags.map((tag) => '<span>' + esc(tag) + '</span>').join('') + '</div>'
          : '';
        const sourceHtml = review.source_url && /^https?:\/\//i.test(review.source_url)
          ? '<div class="db-review-source"><a href="' + esc(review.source_url) + '" target="_blank" rel="noopener noreferrer nofollow">確認元を見る ↗</a></div>'
          : '';
        return `
          <article class="db-review-card">
            <div class="db-review-product">${esc(currentData.product.name)}</div>
            <div class="db-review-dog">${esc(review.dog_breed || '犬種情報なし')}</div>
            ${tagsHtml}
            <div class="db-review-summary">${esc(review.summary)}</div>
            ${sourceHtml}
          </article>
        `;
      }).join('');

      if (!reviews.length) {
        list.innerHTML = '<div class="db-empty">この条件に合う体験はありません。条件を少し広げてみてください。</div>';
      }

      const totalProductReviews = Number(currentData.count || 0);
      status.textContent = reviews.length === totalProductReviews
        ? totalProductReviews + '件'
        : '条件一致 ' + reviews.length + '件 / 商品全体 ' + totalProductReviews + '件';

      const remaining = Math.max(0, reviews.length - visibleCount);
      more.hidden = remaining === 0;
      more.textContent = remaining > 0 ? 'もっと見る（あと' + remaining + '件）' : 'すべて表示しました';
    };

    const resetVisibleAndRender = () => {
      visibleCount = INITIAL_COUNT;
      renderReviews();
    };

    sizeFilter.addEventListener('change', () => {
      filterState.size = sizeFilter.value;
      resetVisibleAndRender();
    });
    coatFilter.addEventListener('change', () => {
      filterState.coat = coatFilter.value;
      resetVisibleAndRender();
    });
    queryFilter.addEventListener('input', () => {
      filterState.query = queryFilter.value;
      resetVisibleAndRender();
    });
    resetFilter.addEventListener('click', () => {
      filterState.size = '';
      filterState.coat = '';
      filterState.query = '';
      sizeFilter.value = '';
      coatFilter.value = '';
      queryFilter.value = '';
      resetVisibleAndRender();
    });

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
      list.innerHTML = '<div class="db-empty">体験を読み込み中…</div>';
      more.hidden = true;

      try {
        const res = await fetch('/api/products/' + encodeURIComponent(productId) + '/reviews');
        if (!res.ok) throw new Error('reviews request failed');
        currentData = await res.json();
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
        totalBadge.textContent = '公開体験 0件';
        more.hidden = true;
        return;
      }

      categoryTotal = products.reduce((sum, product) => sum + Number(product.review_count || 0), 0);
      totalBadge.innerHTML = '<strong>' + categoryTotal + '件</strong><span>このカテゴリでDBに整理した公開体験</span>';

      select.innerHTML = products.map((product) => {
        const count = Number(product.review_count || 0);
        return '<option value="' + esc(product.id) + '">' +
          esc(product.name) + '（体験' + count + '件）</option>';
      }).join('');

      const firstWithReviews = products.find((product) => Number(product.review_count || 0) > 0);
      const initialProduct = firstWithReviews || products[0];
      select.value = initialProduct.id;
      await loadReviews(initialProduct.id);
    } catch (error) {
      select.innerHTML = '<option value="">商品一覧を取得できません</option>';
      status.textContent = 'API未接続';
      totalBadge.textContent = '体験件数を取得できませんでした';
      more.hidden = true;
      console.error(error);
    }
  }

  function amazonSearchUrl(productName) {
    const url = new URL('https://www.amazon.co.jp/s');
    url.searchParams.set('k', productName);
    url.searchParams.set('tag', AMAZON_TAG);
    return url.toString();
  }

  function appendAmazonSearchLinks(pathPattern, cardSelector, linkClass = 'amazon-cta', noteClass = 'amazon-note') {
    if (!pathPattern.test(window.location.pathname)) return;

    document.querySelectorAll(cardSelector).forEach((card) => {
      if (card.querySelector('.amazon-cta, .amazon-search-cta, .amazon-btn')) return;
      const heading = card.querySelector('h3');
      const productName = heading?.textContent?.trim();
      if (!productName) return;

      const link = document.createElement('a');
      link.className = linkClass;
      link.href = amazonSearchUrl(productName);
      link.target = '_blank';
      link.rel = 'sponsored noopener';
      link.textContent = 'Amazonで商品名を探す';

      const note = document.createElement('span');
      note.className = noteClass;
      note.textContent = '※型番・容量・販売元をAmazonの商品ページで確認してください。';

      card.append(link, note);
    });
  }

  document.querySelectorAll('[data-db-review-browser]').forEach(initBrowser);
  appendAmazonSearchLinks(/\/auto-feeder\.html$/, '.product-grid .product');
  appendAmazonSearchLinks(/\/dog-clipper\.html$/, '.cards .card');
})();

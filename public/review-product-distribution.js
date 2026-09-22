(() => {
  const category = document.getElementById('category');
  const size = document.getElementById('size');
  const coat = document.getElementById('coat');
  const query = document.getElementById('query');
  const status = document.getElementById('status');
  if (!category || !size || !coat || !query || !status) return;

  const esc = v => String(v ?? '').replaceAll('&','&amp;').replaceAll('<','&lt;').replaceAll('>','&gt;').replaceAll('"','&quot;').replaceAll("'",'&#039;');
  const box = document.createElement('section');
  box.className = 'experience-distribution';
  box.innerHTML = '<div class="dist-title">📊 この条件の体験分布</div><p class="dist-note">条件に一致した体験が、どの商品に何件あるかを表示します。件数の多さはおすすめ順位・満足度・商品の優劣を意味しません。商品名をタップすると、その商品の体験だけに絞れます。</p><div class="dist-list" aria-live="polite">読み込み中…</div>';
  status.insertAdjacentElement('afterend', box);

  const style = document.createElement('style');
  style.textContent = '.experience-distribution{margin:0 0 14px;padding:13px;background:#fffdf9;border:1px solid #eee3d8;border-radius:14px}.dist-title{font-size:12px;font-weight:900;color:#51463f}.dist-note{margin:3px 0 9px;font-size:8px;line-height:1.65;color:#958981}.dist-list{display:grid;gap:6px}.dist-row{width:100%;display:grid;grid-template-columns:minmax(0,1fr) auto;gap:10px;align-items:center;padding:9px;border:1px solid transparent;background:#faf6f1;border-radius:9px;color:inherit;text-align:left;font:inherit;cursor:pointer}.dist-row:active{transform:translateY(1px)}.dist-row:focus-visible{outline:2px solid #ed9349;outline-offset:2px}.dist-name{font-size:9px;font-weight:800;overflow-wrap:anywhere}.dist-count{font-size:9px;font-weight:900;color:#d97828;white-space:nowrap}.dist-empty{font-size:9px;color:#958981}.dist-more{font-size:8px;color:#958981;text-align:right}';
  document.head.appendChild(style);

  let controller, requestId = 0;
  async function load(params) {
    controller?.abort(); controller = new AbortController(); const id = ++requestId;
    params.delete('cursor'); params.delete('offset'); params.delete('limit');
    try {
      const res = await fetch('/api/reviews/stats?' + params, {signal:controller.signal});
      if (!res.ok) throw new Error('stats request failed');
      const payload = await res.json(); if (id !== requestId) return;
      const ranked = payload.products || [];
      box.querySelector('.dist-list').innerHTML = ranked.map(p => '<button type="button" class="dist-row" data-product="'+esc(p.product_name)+'" aria-label="'+esc(p.product_name)+'の体験に絞り込む"><span class="dist-name">'+esc(p.product_name)+'</span><span class="dist-count">'+p.count+'件 →</span></button>').join('') + (payload.product_count>8 ? '<div class="dist-more">ほか '+(payload.product_count-8)+'商品</div>' : '') || '<div class="dist-empty">この条件では商品別の体験分布を表示できません。</div>';
    } catch (error) {
      if (error.name === 'AbortError' || id !== requestId) return;
      box.querySelector('.dist-list').innerHTML = '<div class="dist-empty">体験分布を読み込めませんでした。</div>';
    }
  }
  document.addEventListener('review-search-loading', () => {
    controller?.abort(); ++requestId;
    box.querySelector('.dist-list').textContent = '読み込み中…';
  });
  document.addEventListener('review-search-error', () => {
    controller?.abort(); ++requestId;
    box.querySelector('.dist-list').textContent = '体験分布を読み込めませんでした。';
  });
  document.addEventListener('review-search-results', event => {
    if (!event.detail.append) load(new URLSearchParams(event.detail.params));
  });

  box.addEventListener('click', event => {
    const row = event.target.closest('.dist-row[data-product]');
    if (!row) return;
    query.value = row.dataset.product || '';
    query.dispatchEvent(new Event('input', {bubbles:true}));
    status.scrollIntoView({behavior:'smooth', block:'center'});
  });

})();

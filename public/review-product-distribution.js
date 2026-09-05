(() => {
  const category = document.getElementById('category');
  const size = document.getElementById('size');
  const coat = document.getElementById('coat');
  const query = document.getElementById('query');
  const status = document.getElementById('status');
  if (!category || !size || !coat || !query || !status) return;

  const esc = v => String(v ?? '').replaceAll('&','&amp;').replaceAll('<','&lt;').replaceAll('>','&gt;').replaceAll('"','&quot;').replaceAll("'",'&#039;');
  const tokens = v => String(v ?? '').trim().toLowerCase().split(/\s+/).filter(x => x && x !== 'null');
  const aliases = {怖がり:'scared',子犬:'puppy',シニア:'senior',時短:'speed',抜け毛:'shedding',毛玉:'mat',もつれ:'tangle',多頭:'multi',静音:'quiet',皮膚:'skin',カメラ:'camera',旅行:'travel',いたずら:'mischief',ハンズフリー:'handsfree'};
  let all = [];

  const box = document.createElement('section');
  box.className = 'experience-distribution';
  box.innerHTML = '<div class="dist-title">📊 この条件の体験分布</div><p class="dist-note">条件に一致した体験が、どの商品に何件あるかを表示します。件数の多さはおすすめ順位・満足度・商品の優劣を意味しません。商品名をタップすると、その商品の体験だけに絞れます。</p><div class="dist-list" aria-live="polite">読み込み中…</div>';
  status.insertAdjacentElement('afterend', box);

  const style = document.createElement('style');
  style.textContent = '.experience-distribution{margin:0 0 14px;padding:13px;background:#fffdf9;border:1px solid #eee3d8;border-radius:14px}.dist-title{font-size:12px;font-weight:900;color:#51463f}.dist-note{margin:3px 0 9px;font-size:8px;line-height:1.65;color:#958981}.dist-list{display:grid;gap:6px}.dist-row{width:100%;display:grid;grid-template-columns:minmax(0,1fr) auto;gap:10px;align-items:center;padding:9px;border:1px solid transparent;background:#faf6f1;border-radius:9px;color:inherit;text-align:left;font:inherit;cursor:pointer}.dist-row:active{transform:translateY(1px)}.dist-row:focus-visible{outline:2px solid #ed9349;outline-offset:2px}.dist-name{font-size:9px;font-weight:800;overflow-wrap:anywhere}.dist-count{font-size:9px;font-weight:900;color:#d97828;white-space:nowrap}.dist-empty{font-size:9px;color:#958981}.dist-more{font-size:8px;color:#958981;text-align:right}';
  document.head.appendChild(style);

  function matches(r) {
    if (size.value && !tokens(r.dog_size).includes(size.value)) return false;
    if (coat.value && !tokens(r.coat_type).includes(coat.value)) return false;
    const q = query.value.trim().toLowerCase();
    if (!q) return true;
    const alias = aliases[q] || '';
    const hay = [r.product_name,r.dog_breed,r.dog_size,r.coat_type,r.needs,r.summary].filter(Boolean).join(' ').toLowerCase();
    return hay.includes(q) || (!!alias && hay.includes(alias));
  }

  function render() {
    const rows = all.filter(matches);
    const counts = new Map();
    rows.forEach(r => counts.set(r.product_name || '商品名なし', (counts.get(r.product_name || '商品名なし') || 0) + 1));
    const ranked = [...counts.entries()].sort((a,b) => b[1]-a[1] || a[0].localeCompare(b[0],'ja'));
    const list = box.querySelector('.dist-list');
    if (!ranked.length) {
      list.innerHTML = '<div class="dist-empty">この条件では商品別の体験分布を表示できません。</div>';
      return;
    }
    const shown = ranked.slice(0,8);
    list.innerHTML = shown.map(([name,count]) => '<button type="button" class="dist-row" data-product="'+esc(name)+'" aria-label="'+esc(name)+'の体験に絞り込む"><span class="dist-name">'+esc(name)+'</span><span class="dist-count">'+count+'件 →</span></button>').join('') + (ranked.length>8 ? '<div class="dist-more">ほか '+(ranked.length-8)+'商品</div>' : '');
  }

  async function load() {
    const c = category.value;
    const url = c ? '/api/reviews?category=' + encodeURIComponent(c) : '/api/reviews';
    try {
      const res = await fetch(url, {headers:{accept:'application/json'}});
      if (!res.ok) throw new Error('HTTP '+res.status);
      const payload = await res.json();
      all = Array.isArray(payload.reviews) ? payload.reviews : [];
      render();
    } catch (_) {
      box.querySelector('.dist-list').innerHTML = '<div class="dist-empty">体験分布を読み込めませんでした。体験一覧はそのまま利用できます。</div>';
    }
  }

  box.addEventListener('click', event => {
    const row = event.target.closest('.dist-row[data-product]');
    if (!row) return;
    query.value = row.dataset.product || '';
    query.dispatchEvent(new Event('input', {bubbles:true}));
    status.scrollIntoView({behavior:'smooth', block:'center'});
  });

  category.addEventListener('change', load);
  size.addEventListener('change', render);
  coat.addEventListener('change', render);
  query.addEventListener('input', render);
  load();
})();

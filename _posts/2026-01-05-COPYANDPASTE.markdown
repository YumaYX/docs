---
layout: post
category: uncategorized
title: "COPY AND PASTE"
---

<div id="d1"></div>
<button onclick="copyById('d1')">Copy</button>
<div id="d2"></div>
<button onclick="copyById('d2')">Copy</button>
<div id="d3"></div>
<button onclick="copyById('d3')">Copy</button>

<div id=winhome>C:\Users\%username%\</div>
<button onclick="copyById('winhome')">Copy</button>

<script>
  function getTodayJST(format) {
    const d = new Date(
      new Date().toLocaleString('en-US', { timeZone: 'Asia/Tokyo' })
    );

    const yyyy = d.getFullYear();
    const mm = String(d.getMonth() + 1).padStart(2, '0');
    const dd = String(d.getDate()).padStart(2, '0');

    switch (format) {
      case 'yyyymmdd':
        return `${yyyy}${mm}${dd}`;
      case 'yyyy-mm-dd':
        return `${yyyy}-${mm}-${dd}`;
      case 'yyyy/mm/dd':
        return `${yyyy}/${mm}/${dd}`;
      default:
        throw new Error('unknown format');
    }
  }
  document.getElementById('d1').textContent = getTodayJST('yyyymmdd');
  document.getElementById('d2').textContent = getTodayJST('yyyy-mm-dd');
  document.getElementById('d3').textContent = getTodayJST('yyyy/mm/dd');
</script>

<script>
  function copyById(id) {
    const el = document.getElementById(id);
    if (!el) return;
    const text = el.value ?? el.textContent;
    navigator.clipboard.writeText(text);
  }
</script>


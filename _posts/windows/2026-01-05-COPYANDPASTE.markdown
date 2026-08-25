---
layout: post
category: windows
title: "COPY AND PASTE"
---

<div id="d1"></div>
<button onclick="copyById('d1')">Copy</button>
<div id="d2"></div>
<button onclick="copyById('d2')">Copy</button>
<div id="d3"></div>
<button onclick="copyById('d3')">Copy</button>

<div id="youbi"></div>
<button onclick="copyById('youbi')">Copy</button>

<div id="winhome">C:\Users\%username%\</div>
<button onclick="copyById('winhome')">Copy</button>

<div id="winhosts">C:\Windows\System32\drivers\etc\hosts</div>
<button onclick="copyById('winhosts')">Copy</button>



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

<script>
  document.getElementById('youbi').textContent =
    '(' +
    new Date().toLocaleDateString('ja-JP', {
      timeZone: 'Asia/Tokyo',
      weekday: 'short'
    }) +
    ')';
</script>


---

<div id="appList"></div>

<script>
const apps = [
  ["エクスプローラー", "explorer"],
  ["コマンドプロンプト", "cmd"],
  ["PowerShell", "powershell"],
  ["タスクマネージャー", "taskmgr"],
  ["コントロールパネル", "control"],
  ["システム構成", "msconfig"],
  ["サービス", "services.msc"],
  ["イベントビューアー", "eventvwr"],
  ["パフォーマンスモニター", "perfmon"],
  ["リソースモニター", "resmon"],

  ["コンピューターの管理", "compmgmt.msc"],
  ["ディスクの管理", "diskmgmt.msc"],
  ["デバイスマネージャー", "devmgmt.msc"],
  ["ローカルユーザーとグループ", "lusrmgr.msc"],
  ["ローカルグループポリシー", "gpedit.msc"],
  ["ローカルセキュリティポリシー", "secpol.msc"],

  ["システム情報", "msinfo32"],
  ["DirectX 診断ツール", "dxdiag"],
  ["Windows バージョン", "winver"],

  ["メモ帳", "notepad"],
  ["電卓", "calc"],
  ["ペイント", "mspaint"],
  ["WordPad", "write"],
  ["切り取りツール", "snippingtool"],
  ["スクリーンキーボード", "osk"],
  ["文字コード表", "charmap"],

  ["ネットワーク接続", "ncpa.cpl"],
  ["インターネットオプション", "inetcpl.cpl"],
  ["Windows Defender ファイアウォール", "wf.msc"],

  ["ユーザーアカウント", "netplwiz"],
  ["ディスククリーンアップ", "cleanmgr"],
  ["Windows の機能", "optionalfeatures"],
  ["拡大鏡", "magnify"]
];

const makeId = cmd => "id_" + cmd.replace(/[^a-zA-Z0-9]/g, "");

function copyById(id) {
  navigator.clipboard.writeText(
    document.getElementById(id).textContent
  );
}

function renderApps(apps, targetId) {
  document.getElementById(targetId).innerHTML =
    apps.map(([name, cmd]) => {
      const id = makeId(cmd);
      return `
        <h2>${name}</h2>
        <div id="${id}">${cmd}</div>
        <button onclick="copyById('${id}')">Copy</button>
      `;
    }).join("");
}

renderApps(apps, "appList");
</script>

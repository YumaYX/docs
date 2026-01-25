#!/bin/bash

cat _posts/* | grep ^categor | sort | uniq | awk '{print $2}' | while read line
do
  echo "${line}"
  cat << EOF > ${line}.markdown
---
layout: sub
title: ${line}
permalink: /${line}/
---

<h2 id="{{ category[0] }}">{{ category[0] | capitalize }}</h2>
<ul>
{% assign sorted_site_posts = site.posts | sort %}
{% for post in sorted_site_posts %}
{% if post.category == "${line}" %}
<li><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></li>
{% endif %}
{% endfor %}
</ul>

EOF
done


cat <<'EOF' > list.markdown
---
layout: sub
title: All List
permalink: /all/
---

{% assign sorted_site_categories = site.categories | sort %}
{% for category in sorted_site_categories %}

<h2 id="{{ category[0] }}">{{ category[0] | capitalize }}</h2>
<ul>
{% assign sorted_site_posts = site.posts | sort %}
{% for post in sorted_site_posts %}
{% if post.category == category[0] %}
<li><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></li>
{% endif %}
{% endfor %}
</ul>
{% endfor %}
EOF



cat <<'EOF' > index.markdown
---
layout: default
---

<div class="row">

<div class="one-half column">
<h2>Articles</h2>

<ul><li><a href="{{ site.baseurl }}/all/">All List</a></li></ul>
<ul>
EOF

cat _posts/* | grep ^categor | sort | uniq | awk '{print $2}' | while read line
do
  echo "<li><a href=\"{{ site.baseurl }}/${line}/\">${line}</a></li>" >> index.markdown
done

cat <<'EOF' >> index.markdown
</ul>
</div>

<div class="one-half column">
<h2>Links</h2>
<ul>
  <li><a href="https://github.com/YumaYX?tab=repositories">GitHub Repositories</a></li>
  <li><a href="/works/">Works</a> / <a href="/works/ja.index.html">Works - Ja</a></li>
  <li><a href="https://yumayx.github.io/rubydemodoc/">Ruby Demo Doc</a></li>
  <li><a href="/Workshop/">Workshop</a></li>
  <li><a href="/lllmd/">lllmd</a></li>
  <li><a href="/VBANotes/">VBANotes</a></li>
</ul>
</div>

</div>

EOF

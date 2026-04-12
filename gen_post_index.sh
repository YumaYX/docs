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

<section>
<h2 id="{{ category[0] }}">{{ category[0] | capitalize }}</h2>
<ul>
{% assign sorted_site_posts = site.posts | sort %}
{% for post in sorted_site_posts %}
{% if post.category == "${line}" %}
<li><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></li>
{% endif %}
{% endfor %}
</ul>
</section>
EOF
done


cat <<'EOF' > list.markdown
---
layout: sub
title: All List
permalink: /all/
---


<section>
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
</section>
EOF



cat <<'EOF' > index.markdown
---
layout: default
---


<section>
<div class="row">

<div class="one-half column">
<h1>ARTICLES</h1>

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
<h1>LINKS</h1>
<ul>
  <li><a href="https://github.com/YumaYX?tab=repositories">GitHub Repositories</a></li>
  <li><a href="/works/">Works</a></li>
  <li><a href="https://yumayx.github.io/rubydemodoc/">Ruby Demo Doc</a></li>
  <li><a href="/Workshop/">Workshop</a></li>
  <li><a href="/lllmd/">lllmd</a></li>
  <li><a href="/VBANotes/">VBANotes</a></li>
</ul>
</div>

</div>

</section>

EOF

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

cat <<'EOF' > index.markdown
---
layout: default
---

# Links

- [GitHub Repositories](https://github.com/YumaYX?tab=repositories)
- [Works](/works/) / [Works - Ja](/works/ja.index.html)
- [Ruby Demo Doc](https://yumayx.github.io/rubydemodoc/)
- [Workshop](/Workshop/)
- [R-X](/R-X/)
- [lllmd](/lllmd/)
- [VBANotes](/VBANotes/)
- [practice2](/practice2/)

---

# Articles

EOF

cat _posts/* | grep ^categor | sort | uniq | awk '{print $2}' | while read line
do
  echo "- ["${line}"]({{ site.baseurl }}/${line}/)" >> index.markdown
done

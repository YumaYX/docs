grep '^catego' _posts/* | awk '{print $2}' | sort | uniq | while read -r line
do
  category=$(printf '%s' "$line" | tr '[:upper:]' '[:lower:]')
  atitle=$(printf '%s' "$line" | tr '[:lower:]' '[:upper:]')

  cat <<EOF > "${category}.markdown"
---
layout: default
title: ${line}
permalink: /${category}/
---

## ${atitle} ARTICLE(S)

<ul>
  {% for post in site.categories.${category} %}
    <li>
      <a href="{{ post.url | relative_url }}">
        {{ post.title }}
      </a>
    </li>
  {% endfor %}
</ul>
EOF
done

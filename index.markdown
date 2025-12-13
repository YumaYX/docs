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

---

# Articles

{% assign sorted_site_categories = site.categories | sort %}
{% for category in sorted_site_categories %}

<h3 id="{{ category[0] }}">{{ category[0] | capitalize }}</h3>
<ul>
{% assign sorted_site_posts = site.posts | sort %}
{% for post in sorted_site_posts %}
{% if post.category == category[0] %}
<li><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></li>
{% endif %}
{% endfor %}
</ul>

{% endfor %}

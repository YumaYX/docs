---
layout: default
---

# Links

- [GitHub Repositories](https://github.com/YumaYX?tab=repositories)
- [Works](/works/) / [Works - Ja](/works/jp/)
- [Ruby Demo Doc](https://yumayx.github.io/rubydemodoc/)
- [Workshop](/Workshop/)
- [R-X](/R-X/)
- [lllmd](/lllmd/)
- [practice2](/practice2/)

---

# Articles

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

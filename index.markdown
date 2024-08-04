---
layout: default
---

# Links

- [GitHub Repositories](https://github.com/YumaYX?tab=repositories)
- [Ruby Quick Reference](/RubyQuickReference/)
- [py-note](/py-note/)
- [Workshop](/Workshop/)


# Articles


{% assign sorted_site_categories = site.categories | sort %}
{% for category in sorted_site_categories %}
<h3 id="{{ category[0] }}"><a href="#{{ category[0] }}">-</a> {{ category[0] | capitalize }}</h3>
<ul>
{% assign sorted_site_posts = site.posts | sort %}
{% for post in sorted_site_posts %}
{% if post.category == category[0] %}
<li><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></li>
{% endif %}
{% endfor %}
</ul>
{% endfor %}


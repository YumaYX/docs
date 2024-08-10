---
layout: default
---

# Links

- [GitHub Repositories](https://github.com/YumaYX?tab=repositories)
- [Ruby Quick Reference](/RubyQuickReference/)
- [py-note](/py-note/)
- [Works](/works/)
- [Workshop](/Workshop/)


# Articles


{% assign sorted_site_categories = site.categories | sort %}
{% for category in sorted_site_categories %}
<h2 id="{{ category[0] }}"><a href="#{{ category[0] }}">-</a> {{ category[0] | capitalize }}</h2>
<ul>
{% assign sorted_site_posts = site.posts | sort %}
{% for post in sorted_site_posts %}
{% if post.category == category[0] %}
<li><a class="post-link" href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></li>
{% endif %}
{% endfor %}
</ul>
{% endfor %}


---
layout: default
---

# Links

- [GitHub Repositories](https://github.com/YumaYX?tab=repositories)
- [Ruby Quick Reference](/RubyQuickReference/)
- [Express](/express/)
- [Workshop](/Workshop/)

# Works

- [Works](/works)


# Articles

{% assign sorted_site_categories = site.categories | sort %}
{% for category in sorted_site_categories %}
<div class="docs-section">

<h6 class="docs-header" id="{{ category[0] }}">{{ category[0] | capitalize }}</h6>
<ul>
{% assign sorted_site_posts = site.posts | sort %}
{% for post in sorted_site_posts %}
{% if post.category == category[0] %}
<li><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></li>
{% endif %}
{% endfor %}
</ul>

</div>
{% endfor %}

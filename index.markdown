---
layout: default
---

# Links

- [Essential](/Essential/_index.html)
- [Ruby Quick Reference](/RubyQuickReference/)
- [GitHub - YumaYX](https://github.com/YumaYX)

## References/Tools

- [PyAutoGUI](https://pyautogui.readthedocs.io/en/latest/index.html)

# Articles

{% assign sorted_site_categories = site.categories | sort %}
{% for category in sorted_site_categories %}
<h2 class="post-list-heading"> {{ category[0] | capitalize }} </h2>
<ul>
{% assign sorted_site_posts = site.posts | sort %}
{% for post in sorted_site_posts %}
{% if post.category == category[0] %}
<li><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></li>
{% endif %}
{% endfor %}
</ul>
{% endfor %}



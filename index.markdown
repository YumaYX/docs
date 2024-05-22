---
layout: default
---

# Links

- [GitHub - YumaYX](https://github.com/YumaYX)
- [Ruby Quick Reference](/RubyQuickReference/)
- [Hateblo](https://yumayxx.hateblo.jp/archive/author/yumayxx)

## [GitHub Repositories](https://github.com/YumaYX?tab=repositories)

- [init](https://github.com/YumaYX/init)
- [YS1](https://github.com/YumaYX/YS1)
  - [Docs](https://yumayx.github.io/YS1/)
  - [Ruby Gem](https://github.com/users/YumaYX/packages/rubygems/package/ys1)

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

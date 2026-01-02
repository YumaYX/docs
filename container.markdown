---
layout: sub
title: container
permalink: /container/
---

<h2 id="{{ category[0] }}">{{ category[0] | capitalize }}</h2>
<ul>
{% assign sorted_site_posts = site.posts | sort %}
{% for post in sorted_site_posts %}
{% if post.category == "container" %}
<li><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></li>
{% endif %}
{% endfor %}
</ul>


---
layout: default
title: All Posts
permalink: /all/
---

# All Posts

{% for post in site.posts %}
- {{ post.date | date: "%Y/%m/%d" }} - [{{ post.title }}]({{ post.url | relative_url }}) :{{ post.categories | join: ", " }}{% endfor %}

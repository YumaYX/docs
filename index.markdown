---
layout: default
links:
  - name: YS0
    url: https://github.com/YumaYX/YS0
  - name: YS1
    url: https://yumayx.github.io/YS1/
  - name: YS124
    url: https://yumayx.github.io/YS124/
  - name: YS910
    url: https://yumayx.github.io/YS910/
  - name: YS1XL
    url: https://github.com/YumaYX/YS1XL/
---

{% assign sorted_categories = site.categories | sort %}

<section>


<div class="row">


<div class="one-half column">
<h2>INDEX</h2>
<ul>
  {% for category in sorted_categories %}
    <li>
      <a href="{{ site.baseurl }}/menu#{{ category[0] | slugify }}">
        {{ category[0] | upcase }}
      </a>
    </li>
  {% endfor %}
</ul>
</div>

<div class="one-half column">
<h2>LINKS</h2>
<ul>
<li><a href="https://github.com/YumaYX?tab=repositories">GITHUB REPOSITORIES</a></li>

{% for item in page.links %}
<li><a href="{{ item.url }}">{{ item.name }}</a></li>
{% endfor %}

</ul>
</div>

</div>

</section>


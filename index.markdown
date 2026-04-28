---
layout: default
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
<li><a href="https://yumayx.github.io/">WORKS</a></li>
</ul>
</div>

</div>

</section>


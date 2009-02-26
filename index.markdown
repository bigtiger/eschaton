---
layout: default
title: eschaton
---

{% for post in site.posts %} 
  <h1 class="post_header"><a href="/eschaton{{ post.url }}">{{ post.title }}</a></h1>
  <span>{{ post.date | date_to_string }}</span>
  {{post.content}}
  <br/>
  <hr/>
{% endfor %}
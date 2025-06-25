{% extends 'markdown/index.md.j2' %}

{% block data_svg %} 
![svg]({{ output.metadata.filenames['image/svg+xml'] | path2support }}) 
{% endblock data_svg %} 

{% block data_png %} 
![png]({{ output.metadata.filenames['image/png'] | path2support }}) 
{% endblock data_png %} 

{% block data_jpg %} 
![jpeg]({{ output.metadata.filenames['image/jpeg'] | path2support }}) 
{% endblock data_jpg %} 

{# Show input (no execution count) #}
{% block input %}
```python
{{ cell.source | indent | strip_trailing_newline }}
```
{% endblock input %}

{# Show output (no execution count), handle all output types #}
{% block output %}
{% if output.output_type == 'stream' %}
```text
{{ output.text | strip_trailing_newline }}
```
{% elif output.output_type == 'error' %}
```text
{{ output.ename }}: {{ output.evalue }}
{% for line in output.traceback %}
{{ line }}
{% endfor %}
```
{% else %}
```text
{{ output.data['text/plain'] if 'text/plain' in output.data else super() | strip }}
```
{% endif %}
{% endblock output %}


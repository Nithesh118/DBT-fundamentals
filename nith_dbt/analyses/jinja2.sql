{%- set apples = ["Gala","Red Delicious"] -%}

{% for i in apples %}

    {% if i != "Gala" %}
        {{ i }}

    {% else %}
        I hate {{ i }}

    {% endif %}
{% endfor %}
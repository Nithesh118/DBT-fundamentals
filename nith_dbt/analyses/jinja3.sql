{% set inc_flag = 1 %}
{% set last_load = 3 %}


select 
* 
from
    {{ ref('bronze_sales') }}

{% if inc_flag == 1 %}
    where date_sk > {{ last_load }}
{% endif %}
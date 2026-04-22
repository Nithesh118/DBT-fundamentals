with dedup_query as (
select 
    * ,
    ROW_NUMBER() OVER (Partition by id order by updated desc) as deduplication_id
from {{ source('source','items')}}
)
select id, name, category, updated
from dedup_query
where deduplication_id = 1
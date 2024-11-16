{{ config(
    vars={
        "dbt_date:time_zone": "America/Los_Angeles"
    }
) }}


with stg_dim_customers as (
    select
        customer_id as nk_customer_id,
        *
    from {{ ref("stg_pactravel_customers") }}
),

final_dim_customers as (
    select
        {{ dbt_utils.generate_surrogate_key( ["nk_customer_id"] ) }} as sk_customer_id,
        *,
        {{ dbt_date.now() }} as created_at,
        {{ dbt_date.now() }} as updated_at
    from stg_dim_customers
)

select * from final_dim_customers
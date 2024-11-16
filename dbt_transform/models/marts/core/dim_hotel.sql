{{ config(
    vars={
        "dbt_date:time_zone": "America/Los_Angeles"
    }
) }}



with stg_dim_hotel as (
    select 
        hotel_id as nk_hotel_id,
        *
    from {{ ref("stg_pactravel_hotel") }}
),

final_dim_hotel as (
    select
        {{ dbt_utils.generate_surrogate_key( ["nk_hotel_id"] ) }} as sk_hotel_id,
        *,
        {{ dbt_date.now() }} as created_at,
        {{ dbt_date.now() }} as updated_at
    from stg_dim_hotel
)

select * from final_dim_hotel
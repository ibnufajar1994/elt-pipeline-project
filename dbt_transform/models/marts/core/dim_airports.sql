with stg_dim_airports as (
    select
        airport_id as nk_airport_id,
        *
    from {{ ref("stg_pactravel_airports") }}
),

final_dim_airports as (
    select
        {{ dbt_utils.generate_surrogate_key( ["nk_airport_id"] ) }} as sk_airport_id,
        *
    from stg_dim_airports
)

select * from final_dim_airports
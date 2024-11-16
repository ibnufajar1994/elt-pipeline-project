with stg_dim_airlines as (
    select
        airline_id as nk_airline_id,
        *
    from {{ ref("stg_pactravel_airlines") }}
),

final_dim_airlines as (
    select
        {{ dbt_utils.generate_surrogate_key( ["nk_airline_id"] ) }} as sk_airline_id,
        *
    from stg_dim_airlines
)

select * from final_dim_airlines
with stg_dim_aircrafts as (
    select
        aircraft_id as nk_aircraft_id,
        *
    from {{ ref("stg_pactravel_aircrafts") }}
),

final_dim_aircrafts as (
    select
        {{ dbt_utils.generate_surrogate_key( ["nk_aircraft_id"] ) }} as sk_aircraft_id,
        *
    from stg_dim_aircrafts
)

select * from final_dim_aircrafts
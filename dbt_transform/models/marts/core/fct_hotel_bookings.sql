with stg_hotel as(
    select * 
    from {{ ref("stg_pactravel_hotel_bookings")}}
),


dim_hotel as (
    select * 
    from {{ ref("dim_hotel") }}

),

dim_customers as (
    select *
    from {{ ref("dim_customers") }}
),


final_fct_hotel_bookings as (
    select
    {{ dbt_utils.generate_surrogate_key( ["sh.trip_id", "dc.sk_customer_id"] ) }} as sk_trip_id,
    sh.trip_id as nk_trip_id,
    dc.sk_customer_id as customer_code,
    dh.sk_hotel_id as hotel_code,
    sh.breakfast_included as breakfast_included,
    sh.price as price,
    sh.check_out_date - sh.check_in_date as duration,
    {{ dbt_date.now() }} as created_at,
    {{ dbt_date.now() }} as updated_at

    from stg_hotel as sh

    join dim_customers dc
        on dc.nk_customer_id = sh.customer_id
    join dim_hotel dh
        on dh.nk_hotel_id = sh.hotel_id
)

select * from final_fct_hotel_bookings
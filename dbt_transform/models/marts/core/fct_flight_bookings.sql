with stg_flight as(
    select * 
    from {{ ref("stg_pactravel_flight_bookings")}}
),

dim_aircrafts as (
    select * 
    from {{ ref("dim_aircrafts") }}
),

dim_airlines as (
    select *
    from {{ ref("dim_airlines") }}
),

dim_airports as (
    select *
    from {{ ref("dim_airports") }}
),

dim_customers as (
    select *
    from {{ ref("dim_customers") }}
),

final_fct_flight_bookings as (
    select
        {{ dbt_utils.generate_surrogate_key( ["sf.trip_id", "dc.sk_customer_id"] ) }} as sk_trip_id,
        sf.trip_id as nk_trip_id,
        da1.sk_aircraft_id as aircraft_code,    
        da2.airline_id as airline_code,      
        da3.sk_airport_id as airport_code,      
        dc.sk_customer_id as customer_code,     
        sf.travel_class as travel_class,
        sf.price as price,
        {{ dbt_date.now() }} as created_at,
        {{ dbt_date.now() }} as updated_at
    from stg_flight as sf
    join dim_aircrafts da1
        on da1.nk_aircraft_id = sf.aircraft_id  
    join dim_airlines da2
        on da2.nk_airline_id = sf.airline_id    
    join dim_airports da3
        on da3.nk_airport_id = sf.airport_src    
    join dim_customers dc
        on dc.nk_customer_id = sf.customer_id   
)

select * from final_fct_flight_bookings
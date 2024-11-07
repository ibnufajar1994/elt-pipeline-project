# ELT PIPELINE PROJECT
## **Designing an ELT Pipeline and Implementing SCD Strategy in a Data Warehouse Using Luigi and dbt**

This project is focus on designing the ELT pipeline for datawarehouse with implementing the SCD strategies using. This project uses the "Kimball Method" approach to design the data warehouse model.

Before we jump in to the step of designing the data warehouse, first we need understand the bussiness process. Imagine you are a data engineer, you have a client called "pactravel" that manage application for online bookings for airline & hotel ticket. The picture shown bellow is the ERD from database of pactravel
![pactravel - erd](https://github.com/user-attachments/assets/d7e6d136-7e30-4299-ad06-818a3cfdd020)

 Here’s a breakdown of the business process based on the ERD:
 1. Customer Registration
    - Customers register their details in the system, creating a profile with personal and contact information.
 
 2. Flight Booking:
    - Customers can book flights by selecting an airline and flight details.
    - The system records the flight number, airline, aircraft, and airport information.
    - Pricing and class are also selected during booking.
 
 3. Hotel Booking:
    - Customers can book hotels by choosing a hotel and specifying check-in/check-out dates.
    - Pricing and additional services (e.g., breakfast) are recorded.

 4. Integration:
    - The system integrates flight and hotel bookings, allowing seamless travel planning.
    - Customers can manage their bookings through the system.

## 1. Requirement Gathering
Based on the database structure and business context, here are the potential problems and answer that might Pactravel needs for designing the data warehouse:
### PROBLEMS AND STAKEHOLDER NEEDS

## 1. Problem:
Revenue Analysis and Optimization Stakeholder Need: Management needs to understand revenue patterns, pricing effectiveness, and profitability across different services.
**- Current Challenges:**
  - Difficult to track total revenue per customer
  - No clear visibility on which routes/hotels are most profitable
  - Cannot easily identify peak booking seasons
  - No way to analyze package deals vs individual bookings
**- Solution:**
    - Create a revenue analysis dashboard that includes:
    - Revenue trends by time period
    - Revenue breakdown by service type (flights vs hotels)
    - Revenue per route and hotel
    - Package deal performance metrics
    - Add booking source tracking to understand which channels drive the most revenue

## 2. Problem:
Customer Behavior and Preferences Analysis Stakeholder Need: Marketing and Product teams need to understand customer patterns to improve offerings and targeting.
**Current Challenges:**
- No tracking of customer booking frequency
- Cannot easily segment customers
- Limited visibility into travel preferences
- No way to track customer lifetime value
**Solution:**
- Develop customer analytics capabilities:
- Create customer segmentation based on booking patterns
- Track customer lifetime value
- Analyze preferred destinations and accommodation types
- Monitor seasonal booking patterns by customer segment


## 3. Problem:
Operational Performance Monitoring Stakeholder Need: Operations team needs to optimize service delivery and identify potential issues
- Current chalanges:
  - No systematic way to track booking completion rates
  - Cannot easily identify popular routes and hotels
  - Difficult to optimize inventory management
  - No clear view of capacity utilization
### Solutions
Create operational dashboards showing:
- Booking trends by route and hotel
- Capacity utilization rates
- Popular travel periods
- Hotel occupancy rates
- Add tracking for booking status and completion rates

## 2. Select the Businsess Process
From the previous problems identified:
- Revenue Analysis and Optimization
- Customer Behavior and Preferences Analysis
- Operational Performance Monitoring

Here are the relevant business processes that should be modeled:

**1. Sales/Booking Process**
- This process covers all booking transactions (both flights and hotels)
- Addresses revenue analysis needs
- Captures customer booking patterns
- Key metrics: revenue, booking volume, average ticket value
- Primary source tables: flight_bookings, hotel_bookings
**This process is crucial for:**
  - Revenue tracking and analysis -
  - Customer purchase behavior
  - Sales performance monitoring
  - Package vs. individual booking analysis

**2. Customer Management Process**
- Focuses on customer relationships and profiles
- Addresses customer behavior analysis needs
- Captures customer demographics and preferences
- Key metrics: customer lifetime value, customer segmentation
- Primary source tables: customers, flight_bookings, hotel_bookings
This process supports:
  - Customer segmentation
  - Customer preference analysis
  - Demographics analysis
  - Customer value assessment
Flight Operations Process
Covers flight-specific operational metrics
Addresses operational performance monitoring
Captures route performance and capacity utilization
Key metrics: route popularity, seat utilization, flight frequency
Primary source tables: flight_bookings, aircrafts, airlines, airports
This process enables:
Route analysis
Airline partnership performance
Capacity planning
Flight scheduling optimization
Hotel Operations Process
Focuses on hotel-specific operational metrics
Addresses operational performance monitoring
Captures hotel performance and occupancy
Key metrics: occupancy rate, average daily rate, hotel popularity
Primary source tables: hotel_bookings, hotel
This process supports:
Hotel performance analysis
Occupancy tracking
Hotel partnership evaluation
Pricing optimization

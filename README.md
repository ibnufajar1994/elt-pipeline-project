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

**Problem 1:**
Revenue Analysis and Optimization Stakeholder Need: Management needs to understand revenue patterns, pricing effectiveness, and profitability across different services.
- Current Challenges:
  - Difficult to track total revenue per customer
  - No clear visibility on which routes/hotels are most profitable
  - Cannot easily identify peak booking seasons
  - No way to analyze package deals vs individual bookings

**Solution:**
  - Create a revenue analysis dashboard that includes:
  - Revenue trends by time period
  - Revenue breakdown by service type (flights vs hotels)
  - Revenue per route and hotel
  - Package deal performance metrics
  - Add booking source tracking to understand which channels drive the most revenue

**Problem 2:**
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


**Problem3:**
Operational Performance Monitoring Stakeholder Need: Operations team needs to optimize service delivery and identify potential issues
- Current chalanges:
  - No systematic way to track booking completion rates
  - Cannot easily identify popular routes and hotels
  - Difficult to optimize inventory management
  - No clear view of capacity utilization

**Solutions:**
Create operational dashboards showing:
- Booking trends by route and hotel
- Capacity utilization rates
- Popular travel periods
- Hotel occupancy rates
- Add tracking for booking status and completion rates


## 2. Select the Businsess Process & Declare the Grain
From the previous problems identified:
- Revenue Analysis and Optimization
- Customer Behavior and Preferences Analysis
- Operational Performance Monitoring

Here are the relevant business processes and the grain that should be modeled:

**1. For Revenue Analysis and Optimization:**
Business Process: Booking Transaction
Grains: 
- a. Individual Booking Level (Most Granular)
  - A single record represents one flight booking or hotel booking transaction. Captures detailed transaction data including customer, price, date, route/hotel.

- b. Daily Booking Summary Level
  - A single record represents daily total bookings and revenue by service type (flight/hotel). Aggregated view of bookings and revenue performance per day.

**2. For Customer Behavior and Preferences Analysis:**
Business Process: Customer Travel Patterns Grains: 

- a. Customer Trip Level
  - A single record represents one complete trip by a customer (combining flight and hotel bookings). Shows customer's travel choices and preferences per trip.

- b. Customer Monthly Activity Level
  - A single record represents a customer's monthly travel activity. Aggregates customer's booking behavior and spending patterns monthly.

**3. For Operational Performance Monitoring:**
Business Process: Service Capacity Utilization Grains:
- a. Flight Route Daily Level
  - A single record represents daily capacity and utilization for each flight route. Shows booking rates and seat occupancy per route per day.


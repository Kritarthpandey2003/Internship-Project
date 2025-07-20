# Airline Reservation System

## Overview
This project implements a **SQL-based Airline Reservation System** for managing flights, customers, bookings, and seat availability. It allows searching flights, booking seats, and tracking bookings efficiently.

## Objective
- Manage flight details, customers, bookings, and seats.
- Enable flight search and booking.
- Automatically update seat status using triggers.
- Generate booking summary reports.

## Tools Used
- MySQL Workbench
- SQL (DDL, DML, Triggers, Views)

##  Database Schema
### Tables:
- `Flights`: Details of flights
- `Customers`: Customer information
- `Seats`: Seats for each flight with booking status
- `Bookings`: Bookings made by customers

### ER Diagram
*Attached  (ER_DIAGRAM airline_reservation.png)

##  Key Features
 Schema design with 4 normalized tables.  
 Sample data inserted for flights, customers, seats, and bookings.  
 Queries to find available seats & search flights.  
 Triggers to handle booking & cancellation.  
 Booking summary report view.  

## How to Run
1. Import the `airline_reservation.sql` script in MySQL Workbench.
2. Run the script to create tables, insert sample data, define triggers & views.
3. Explore the database:
   - Query available seats:  
     ```sql
     SELECT * FROM Seats WHERE flight_id=1 AND is_booked=0;
     ```
   - Search flights:  
     ```sql
     SELECT * FROM Flights WHERE source='Delhi' AND destination='Mumbai';
     ```
   - View bookings:  
     ```sql
     SELECT * FROM booking_summary;
     ```

## Deliverables
- SQL Schema & sample data
- Triggers & Views
- Booking summary report
- ER Diagram

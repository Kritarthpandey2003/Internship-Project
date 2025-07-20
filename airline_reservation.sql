use PROJECT;
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Seats;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Flights;
CREATE TABLE Flights (
    flight_id INT AUTO_INCREMENT PRIMARY KEY,
    airline VARCHAR(50),
    source VARCHAR(50),
    destination VARCHAR(50),
    departure_time DATETIME,
    arrival_time DATETIME,
    price DECIMAL(10,2)
);
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15)
);
CREATE TABLE Seats (
    seat_id INT AUTO_INCREMENT PRIMARY KEY,
    flight_id INT,
    seat_number VARCHAR(5),
    class VARCHAR(20),
    is_booked BOOLEAN DEFAULT 0,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);
CREATE TABLE Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    flight_id INT,
    seat_id INT,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Confirmed',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id),
    FOREIGN KEY (seat_id) REFERENCES Seats(seat_id)
);
INSERT INTO Flights (airline, source, destination, departure_time, arrival_time, price) VALUES
('IndiGo', 'Delhi', 'Mumbai', '2025-07-15 08:00:00', '2025-07-15 10:00:00', 4500),
('Air India', 'Bangalore', 'Chennai', '2025-07-15 09:30:00', '2025-07-15 11:00:00', 3500);
INSERT INTO Customers (name, email, phone) VALUES
('John Doe', 'john@example.com', '9876543210'),
('Jane Smith', 'jane@example.com', '8765432109');
INSERT INTO Seats (flight_id, seat_number, class) VALUES
(1, '1A', 'Economy'),
(1, '1B', 'Economy'),
(1, '2A', 'Business'),
(2, '1A', 'Economy'),
(2, '1B', 'Economy'),
(2, '2A', 'Business');
INSERT INTO Bookings (customer_id, flight_id, seat_id) VALUES (1, 1, 1);
UPDATE Seats SET is_booked = 1 WHERE seat_id = 1;
SELECT seat_number, class
FROM Seats
WHERE flight_id = 1 AND is_booked = 0;
SELECT flight_id, airline, departure_time, arrival_time, price
FROM Flights
WHERE source = 'Delhi' AND destination = 'Mumbai';
SELECT f.flight_id, f.airline, COUNT(b.booking_id) AS total_bookings
FROM Flights f
LEFT JOIN Bookings b ON f.flight_id = b.flight_id
GROUP BY f.flight_id, f.airline;
DELIMITER //

-- Mark seat as booked after booking
CREATE TRIGGER after_booking_insert
AFTER INSERT ON Bookings
FOR EACH ROW
BEGIN
   UPDATE Seats SET is_booked = 1 WHERE seat_id = NEW.seat_id;
END //

-- Mark seat as available after booking is cancelled
CREATE TRIGGER after_booking_delete
AFTER DELETE ON Bookings
FOR EACH ROW
BEGIN
   UPDATE Seats SET is_booked = 0 WHERE seat_id = OLD.seat_id;
END //

DELIMITER ;
-- Booking summary view
CREATE OR REPLACE VIEW booking_summary AS
SELECT b.booking_id, c.name AS customer_name, f.airline, f.source, f.destination,
       f.departure_time, s.seat_number, b.status
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Seats s ON b.seat_id = s.seat_id;
CREATE DATABASE hotel_booking_db;
USE hotel_booking_db;

CREATE TABLE hotels (
    hotel_id INT AUTO_INCREMENT PRIMARY KEY,
    hotel_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    rating DECIMAL(2,1)
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    hotel_id INT,
    room_type VARCHAR(50),
    price_per_night DECIMAL(10,2),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
);

CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

INSERT INTO hotels (hotel_name, city, rating) VALUES
('Grand Palace', 'Chennai', 4.5),
('Ocean View', 'Coimbatore', 4.2),
('Royal Stay', 'Salem', 4.0);

INSERT INTO customers (customer_name, phone, email) VALUES
('Ravi', '9876543210', 'ravi@gmail.com'),
('Priya', '9876543211', 'priya@gmail.com'),
('Arun', '9876543212', 'arun@gmail.com');

INSERT INTO rooms (hotel_id, room_type, price_per_night) VALUES
(1, 'Deluxe', 3000),
(1, 'Suite', 5000),
(2, 'Standard', 2500),
(3, 'Deluxe', 3500);

INSERT INTO bookings (customer_id, room_id, check_in, check_out) VALUES
(1, 1, '2026-06-01', '2026-06-03'),
(2, 2, '2026-06-05', '2026-06-08'),
(3, 4, '2026-06-10', '2026-06-12');

CREATE VIEW booking_report AS
SELECT
    b.booking_id,
    c.customer_name,
    h.hotel_name,
    r.room_type,
    b.check_in,
    b.check_out,
    r.price_per_night,
    DATEDIFF(b.check_out, b.check_in) AS total_days,
    (DATEDIFF(b.check_out, b.check_in) * r.price_per_night) AS total_amount
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id
JOIN rooms r ON b.room_id = r.room_id
JOIN hotels h ON r.hotel_id = h.hotel_id;

SELECT * FROM booking_report;
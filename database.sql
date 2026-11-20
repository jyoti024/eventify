-- Eventify: import this file in phpMyAdmin (Import tab) or run: mysql -u root -p < database.sql
CREATE DATABASE IF NOT EXISTS event_booking CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE event_booking;

-- Eventify schema (safe to run multiple times)

CREATE TABLE IF NOT EXISTS users (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS events (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    category VARCHAR(50) NOT NULL,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    venue VARCHAR(200) NOT NULL,
    city VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    available_tickets INT NOT NULL DEFAULT 0,
    image VARCHAR(500) DEFAULT NULL,
    INDEX idx_event_date (event_date),
    INDEX idx_category (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS bookings (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    booking_ref VARCHAR(20) NOT NULL UNIQUE,
    event_id INT UNSIGNED NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    booking_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    CONSTRAINT fk_booking_event FOREIGN KEY (event_id)
        REFERENCES events(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Sample events (dates are relative to today so they are always upcoming)

INSERT INTO events (title, description, category, event_date, event_time, venue, city, price, available_tickets, image) VALUES
('Sunburn Music Festival', 'Three stages, top DJs and a night of non-stop electronic music under the stars.', 'Music', DATE_ADD(CURDATE(), INTERVAL 14 DAY), '18:00:00', 'Vagator Beach Arena', 'Goa', 2499.00, 200, 'https://picsum.photos/seed/eventify-music1/800/500'),
('Arijit Singh Live in Concert', 'An unforgettable evening of soulful Bollywood hits performed live.', 'Music', DATE_ADD(CURDATE(), INTERVAL 21 DAY), '19:30:00', 'Jawaharlal Nehru Stadium', 'Delhi', 3999.00, 150, 'https://picsum.photos/seed/eventify-music2/800/500'),
('IPL Match: Mumbai vs Chennai', 'Watch the biggest rivalry in T20 cricket live from the stands.', 'Sports', DATE_ADD(CURDATE(), INTERVAL 10 DAY), '19:30:00', 'Wankhede Stadium', 'Mumbai', 1800.00, 300, 'https://picsum.photos/seed/eventify-sports1/800/500'),
('City Marathon 2026', 'Run through the heart of the city. 5K, 10K and half-marathon categories.', 'Sports', DATE_ADD(CURDATE(), INTERVAL 30 DAY), '05:30:00', 'Cubbon Park', 'Bengaluru', 599.00, 500, 'https://picsum.photos/seed/eventify-sports2/800/500'),
('Stand-Up Comedy Night', 'A packed lineup of the country''s funniest comedians. Laughter guaranteed.', 'Comedy', DATE_ADD(CURDATE(), INTERVAL 7 DAY), '20:00:00', 'Canvas Laugh Club', 'Pune', 799.00, 80, 'https://picsum.photos/seed/eventify-comedy1/800/500'),
('Laugh Riot: Open Mic Special', 'Fresh voices, big laughs. Sign up or just sit back and enjoy the show.', 'Comedy', DATE_ADD(CURDATE(), INTERVAL 18 DAY), '19:00:00', 'The Habitat', 'Hyderabad', 499.00, 60, 'https://picsum.photos/seed/eventify-comedy2/800/500'),
('Web Development Bootcamp', 'A hands-on one-day workshop covering HTML, CSS, JavaScript and PHP.', 'Workshop', DATE_ADD(CURDATE(), INTERVAL 12 DAY), '10:00:00', 'Tech Hub Convention Center', 'Chennai', 999.00, 40, 'https://picsum.photos/seed/eventify-workshop1/800/500'),
('Startup Pitch & Networking Workshop', 'Learn to pitch your idea and meet founders, mentors and investors.', 'Workshop', DATE_ADD(CURDATE(), INTERVAL 25 DAY), '11:00:00', 'WeWork Galaxy', 'Bengaluru', 1499.00, 50, 'https://picsum.photos/seed/eventify-workshop2/800/500');

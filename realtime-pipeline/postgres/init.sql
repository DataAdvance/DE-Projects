CREATE DATABASE ecommerce_db;

\c ecommerce_db

CREATE TABLE user_events (
    event_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    event_type VARCHAR(10) NOT NULL,
    event_timestamp TIMESTAMP NOT NULL
);

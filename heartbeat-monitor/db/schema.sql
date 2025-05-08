CREATE TABLE IF NOT EXISTS heartbeat_data (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER,
    timestamp TIMESTAMP,
    heart_rate INTEGER
);

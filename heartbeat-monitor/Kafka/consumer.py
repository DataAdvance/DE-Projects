from kafka import KafkaConsumer
import json
import psycopg2

# Kafka config
TOPIC_NAME = 'heartbeat_topic'
KAFKA_SERVER = 'localhost:9092'

# PostgreSQL config
DB_CONFIG = {
    'dbname': 'heartbeat',
    'user': 'postgres',
    'password': 'postgres',
    'host': 'localhost',
    'port': '5432'
}

# Set up Kafka consumer
consumer = KafkaConsumer(
    TOPIC_NAME,
    bootstrap_servers=KAFKA_SERVER,
    value_deserializer=lambda v: json.loads(v.decode('utf-8')),
    auto_offset_reset='earliest',
    enable_auto_commit=True,
    group_id='heartbeat-consumer-group'
)

def insert_to_db(conn, record):
    """
    Inserts a heart rate record into the database.
    """
    with conn.cursor() as cur:
        cur.execute(
            """
            INSERT INTO heartbeat_data (customer_id, timestamp, heart_rate)
            VALUES (%s, %s, %s)
            """,
            (record['customer_id'], record['timestamp'], record['heart_rate'])
        )
        conn.commit()

def main():
    """
    Listens to Kafka, processes records, and stores them in PostgreSQL.
    """
    print("Starting Kafka consumer...")

    # Connect to PostgreSQL
    conn = psycopg2.connect(**DB_CONFIG)

    for message in consumer:
        record = message.value
        print(f"Consumed: {record}")

        try:
            insert_to_db(conn, record)
            print("Inserted into DB.")
        except Exception as e:
            print(f"DB insert failed: {e}")

if __name__ == "__main__":
    main()

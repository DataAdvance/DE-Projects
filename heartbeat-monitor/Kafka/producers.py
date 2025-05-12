import sys
import os
import json
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import logging
from kafka import KafkaProducer
from data_gen.generator import generate_heartbeat_data



# ------------------------------------
# Set up logging configuration
# ------------------------------------
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(sys.stdout)
    ]
)

# Kafka configuration
TOPIC_NAME = 'heartbeat_topic'
KAFKA_BROKER = 'localhost:9092'

# Initialize Kafka producer
try:
    producer = KafkaProducer(
        bootstrap_servers=KAFKA_BROKER,
        value_serializer=lambda v: json.dumps(v).encode('utf-8')
    )
    logging.info(f"KafkaProducer connected to {KAFKA_BROKER}")
except Exception as e:
    logging.error(f"Failed to connect KafkaProducer: {e}")
    sys.exit(1)

def main():
    """
    Connects to Kafka and sends simulated heartbeat data to a topic.
    """
    logging.info("Starting Kafka producer...")
    try:
        for record in generate_heartbeat_data():
            # Convert back to dict for serialization
            record_dict = json.loads(record)

            # Send the data to Kafka
            producer.send(TOPIC_NAME, value=record_dict)
            logging.info(f"Sent to Kafka topic '{TOPIC_NAME}': {record_dict}")
    except Exception as e:
        logging.error(f"Error while sending message to Kafka: {e}")
    finally:
        producer.flush()
        producer.close()
        logging.info("Kafka producer connection closed.")

if __name__ == "__main__":
    main()

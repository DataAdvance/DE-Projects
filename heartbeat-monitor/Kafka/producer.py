import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from kafka import KafkaProducer
import json
from data_gen.generator import generate_heartbeat_data

# Initialize Kafka producer
producer = KafkaProducer(
    bootstrap_servers='localhost:9092',  # Kafka running on Docker
    value_serializer=lambda v: json.dumps(v).encode('utf-8')  # Serialize JSON to bytes
)

TOPIC_NAME = 'heartbeat_topic'  # The Kafka topic to send data to

def main():
    """
    Connects to Kafka and sends simulated heartbeat data to a topic.
    """
    print("Starting Kafka producer...")
    for record in generate_heartbeat_data():
        # Convert back to dict for serialization
        record_dict = json.loads(record)

        # Send the data to Kafka
        producer.send(TOPIC_NAME, value=record_dict)

        print(f"Sent to Kafka: {record_dict}")

if __name__ == "__main__":
    main()

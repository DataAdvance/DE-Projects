# Import the necessary libraries
import random
import time
import json
from datetime import datetime

def generate_heartbeat_data():
    """
    This function continuously generates synthetic heart rate data
    for fake customers and yields each record as a JSON string.
    """
    while True:
        # Simulate a record
        record = {
            "customer_id": random.randint(1, 10),                   # Fake customer ID
            "timestamp": datetime.now().isoformat(),               # Current timestamp
            "heart_rate": random.randint(55, 100)                  # Random heart rate
        }

        # Convert record to JSON string
        json_record = json.dumps(record)

        # Print for debug purposes
        print(f"Generated: {json_record}")

        # Yield to Kafka producer (or test usage)
        yield json_record

        # Simulate 1-second interval between heartbeats
        time.sleep(1)

# For quick local testing
if __name__ == "__main__":
    for data in generate_heartbeat_data():
        pass  # You can print here or hook this up with a Kafka producer

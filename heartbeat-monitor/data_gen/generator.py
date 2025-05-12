import random
import time
import json
import logging
from datetime import datetime

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s | %(levelname)s | %(message)s",
    handlers=[
        logging.FileHandler("heartbeat_generator.log"),
        logging.StreamHandler()
    ]
)

logger = logging.getLogger(__name__)

def generate_heartbeat_data():
    """
    Continuously generates synthetic heart rate data
    for fake customers and yields each record as a JSON string.
    """
    while True:
        record = {
            "customer_id": random.randint(1, 10),
            "timestamp": datetime.now().isoformat(),
            "heart_rate": random.randint(55, 100)
        }

        json_record = json.dumps(record)

        # Log the generated data
        logger.info(f"Generated: {json_record}")

        yield json_record
        time.sleep(1)

# For testing
if __name__ == "__main__":
    for data in generate_heartbeat_data():
        pass

import csv, os, random, time
from faker import Faker

fake = Faker()
event_types = ['view', 'purchase']
output_dir = "generated_data"
os.makedirs(output_dir, exist_ok=True)

def generate_event(event_id):
    return {
        "event_id": event_id,
        "user_id": random.randint(1, 1000),
        "product_id": random.randint(1, 500),
        "event_type": random.choice(event_types),
        "timestamp": fake.date_time_between(start_date='-1d', end_date='now')
    }

def write_csv(batch_size=50, delay=10):
    event_id = 1
    while True:
        filename = os.path.join(output_dir, f"events_{int(time.time())}.csv")
        with open(filename, "w", newline='') as file:
            writer = csv.DictWriter(file, fieldnames=["event_id", "user_id", "product_id", "event_type", "timestamp"])
            writer.writeheader()
            for _ in range(batch_size):
                writer.writerow(generate_event(event_id))
                event_id += 1
        print(f"Generated {batch_size} events to {filename}")
        time.sleep(delay)

if __name__ == "__main__":
    write_csv()

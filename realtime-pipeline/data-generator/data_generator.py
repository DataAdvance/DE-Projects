import csv, os, random, time
from faker import Faker

# Initialize the Faker library to generate realistic fake data
fake = Faker()

# Define possible user actions
event_types = ['view', 'purchase']

# This is the folder where all generated CSV files will be stored
output_dir = "generated_data"

# Make sure the folder exists — create it if it doesn't
os.makedirs(output_dir, exist_ok=True)

def generate_event(event_id):
    return {
        "event_id": event_id,
        "user_id": random.randint(1, 1000),         # Random user ID between 1 and 1000
        "product_id": random.randint(1, 500),       # Random product ID between 1 and 500
        "event_type": random.choice(event_types),   # Randomly pick 'view' or 'purchase'
        "timestamp": fake.date_time_between(start_date='-1d', end_date='now')  # Generate a timestamp sometime in the past day
    }

# Main function that writes batches of events to CSV files
def write_csv(batch_size=50, delay=10): ## could have been dynamic
    event_id = 1
    while True:
        # Create a new filename using the current time (this ensures uniqueness)
        filename = os.path.join(output_dir, f"events_{int(time.time())}.csv")

        # Open the file and write the batch of events
        with open(filename, "w", newline='') as file:
            writer = csv.DictWriter(file, fieldnames=["event_id", "user_id", "product_id", "event_type", "timestamp"])
            writer.writeheader()
            # Write 'batch_size' number of events to the file
            for _ in range(batch_size):
                writer.writerow(generate_event(event_id))
                event_id += 1
        print(f"Generated {batch_size} events to {filename}")
        time.sleep(delay)
        
# If this script is being run directly (not imported), start the generator
if __name__ == "__main__":
    write_csv()

# User Guide: Running the Real-Time Streaming Pipeline

## Prerequisites

- Docker and Docker Compose installed
- Docker Desktop running

## Folder Structure

realtime-pipeline/ ├── docker-compose.yml ├── data-generator/ │ ├── data_generator.py │ ├── Dockerfile │ └── requirements.txt ├── postgres/ │ └── init.sql ├── spark/ │ └── spark_streaming_to_postgres.py ├── generated_data/ ├── postgres_connection_details.txt └── requirements.txt


## Steps to Run

1. Open terminal in the `realtime-pipeline/` folder.
2. Start the project:

Run docker compose up --build in the terminal
3. Open another terminal and check data in PostgreSQL:


Run docker exec -it postgres psql -U postgres -d ecommerce_db in the terminal

ecommerce_db shows up then 
Run:
```sql
SELECT * FROM user_events LIMIT 10;


4. To stop the docker container:
docker compose down

# Project Overview: Real-Time Data Ingestion Pipeline with Spark & PostgreSQL

## Components

- **Data Generator (`data_generator.py`)**: Simulates user events like product views and purchases, writing CSV files periodically.
- **Spark Structured Streaming (`spark_streaming_to_postgres.py`)**: Monitors the CSV folder, reads new data in real time, processes it, and writes it to PostgreSQL.
- **PostgreSQL**: Stores all ingested event data in a structured table (`user_events`).

## Data Flow

1. `data_generator.py` generates fake CSV event files every few seconds.
2. Spark detects new files in the `generated_data/` folder.
3. Spark transforms the data (e.g., timestamp parsing) and writes it to PostgreSQL.
4. PostgreSQL stores the cleaned and structured data for analysis.

## Purpose

This project demonstrates a real-time data ingestion and processing pipeline using open-source tools. It provides hands-on experience with:
- Stream processing
- Batch ingestion in micro-batches
- PostgreSQL integration
- Docker-based orchestration

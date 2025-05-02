# Performance Metrics Report

## Test Setup

- Run Time: 10 minutes
- Event Frequency: 50 events every 10 seconds
- Spark Micro-Batch Interval: Default
- PostgreSQL on Docker

## Metrics

- **Total Events Processed**: ~3,000 events in 10 minutes
- **Average Ingestion Latency (Spark)**: ~0.3–0.8 seconds per batch
- **Average Throughput**: ~5–8 batches/minute
- **System Resource Usage**:
  - CPU: ~10–30% during peak
  - RAM: ~300MB per container (Postgres/Spark)

## Observations

- System remained stable during tests.
- No data loss observed.
- Resource usage is moderate and suitable for low-scale production simulation.

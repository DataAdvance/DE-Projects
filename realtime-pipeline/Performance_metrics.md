# Performance Metrics Report

## Test Setup

- Run Time: 10 minutes
- Event Frequency: 50 events every 10 seconds
- Spark Micro-Batch Interval: Default
- PostgreSQL on Docker

## Metrics

- **Total Events Processed**: ~3,000 events in 10 minutes
- **Average Ingestion Latency (Spark)**: 0.3–0.8 seconds per batch
- **Average Throughput**: 5–8 batches/minute
- **System Resource Usage**:
- I checked the Docker Container Resource Usage using the command 'Docker stats'

| CONTAINER ID | NAME          | CPU %   | MEM USAGE / LIMIT     | MEM %  | NET I/O             | BLOCK I/O | PIDS |
|--------------|---------------|---------|------------------------|--------|----------------------|------------|------|
| 0286023f4c28 | datagenerator | 0.00%   | 15.73MiB / 7.666GiB    | 0.20%  | 1.6kB / 126B         | 0B / 0B    | 1    |
| 56bac1538efe | spark         | 519.27% | 843.8MiB / 7.666GiB    | 10.75% | 1.31MB / 45.2kB      | 0B / 0B    | 101  |
| e598542dc111 | postgres      | 5.55%   | 43.59MiB / 7.666GiB    | 0.56%  | 12.9kB / 10.3kB      | 0B / 0B    | 16   |


## Observations

- System remained stable during tests.
- No data loss observed.
- Resource usage is moderate and suitable for low-scale production simulation.

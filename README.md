# Real-Time Heart Beat Monitoring System

This project simulates and processes real-time customer heart rate data using a modern data pipeline. It demonstrates data generation, Kafka-based streaming, real-time processing, and PostgreSQL integration. An interactive Streamlit dashboard is included for data visualization.

---

## 📌 Project Structure

```
heartbeat-monitor/
├── kafka/
│   ├── producer.py            # Sends generated data to Kafka
│   └── consumer.py            # Reads from Kafka and inserts into Postgres
├── data_gen/
│   └── generator.py           # Generates synthetic heart rate data
├── db/
│   └── schema.sql             # SQL Script to create heartbeat_data table
├── dashboard/
│   └── app.py                 # Streamlit dashboard for visualization
├── docker-compose.yml         # Docker setup for Kafka, Zookeeper, Postgres
└── README.md                  # This file
```

---

##  How to Run the Project

### 1. Clone the Repository

```bash
git clone <repo_url>
cd heartbeat-monitor
```

### 2. Start Docker Services

```bash
docker-compose up -d
```

This launches:

* Kafka and Zookeeper
* PostgreSQL

### 3. Create the Database Table

```bash
docker exec -i heartbeat-monitor-postgres-1 psql -U postgres -d heartbeat < db/schema.sql
```

### 4. Run the Kafka Producer

```bash
python kafka/producer.py
```

This sends real-time heart rate data to the Kafka topic.

### 5. Run the Kafka Consumer

```bash
python kafka/consumer.py
```

This reads from Kafka, validates data, and inserts into PostgreSQL.

### 6. Run the Dashboard

```bash
streamlit run dashboard/app.py
```

Visit `http://localhost:8501` to view the live heart rate dashboard.

---

##  Requirements

* Python 3.12
* Docker & Docker Compose
* Python packages:

 * For Streamlit dashboard
 ```bash
  pip install kafka-python psycopg2 streamlit pandas
  ```

---

##  Features

* Real-time heart rate simulation
* Kafka data streaming
* PostgreSQL storage
* Streamlit dashboard with live charts
* Data filtering and anomaly detection

---

##  Example Use Case

This system simulates heartbeat monitors worn by customers in a fitness center, allowing real-time health monitoring and alerting. 

---


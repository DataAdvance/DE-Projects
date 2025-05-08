import streamlit as st
import psycopg2
import pandas as pd
import time

# PostgreSQL connection config
DB_CONFIG = {
    'dbname': 'heartbeat',
    'user': 'postgres',
    'password': 'postgres',
    'host': 'localhost',
    'port': '5432'
}

# Function to fetch data from the database
def fetch_data():
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        query = """
            SELECT customer_id, timestamp, heart_rate
            FROM heartbeat_data
            ORDER BY timestamp DESC
            LIMIT 50
        """
        df = pd.read_sql(query, conn)
        conn.close()
        return df
    except Exception as e:
        st.error(f"Error fetching data: {e}")
        return pd.DataFrame()

# Streamlit dashboard layout
st.title("💓 Real-Time Heartbeat Monitor")

placeholder = st.empty()

# Auto-refresh every 5 seconds
while True:
    df = fetch_data()
    if not df.empty:
        df['timestamp'] = pd.to_datetime(df['timestamp'])
        df = df.sort_values('timestamp')

        with placeholder.container():
            st.line_chart(df.set_index('timestamp')['heart_rate'])
            st.dataframe(df)
    else:
        st.info("Waiting for data...")

    time.sleep(5)

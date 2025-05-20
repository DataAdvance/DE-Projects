
from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

# Import the task functions
from tasks.load import load_csv_to_mysql
from tasks.validate import validate_flight_data
from tasks.transform import transform_and_compute_kpis

# Define the DAG and task pipeline
with DAG(
    dag_id='flight_price_pipeline',
    start_date=datetime(2023, 1, 1),
    schedule_interval=None,
    catchup=False,
    tags=["flight", "mysql"]
) as dag:

    task_load = PythonOperator(
        task_id='load_csv',
        python_callable=load_csv_to_mysql
    )

    task_validate = PythonOperator(
        task_id='validate_data',
        python_callable=validate_flight_data
    )

    task_transform = PythonOperator(
        task_id='transform_kpis',
        python_callable=transform_and_compute_kpis
    )

    # Define task dependencies
    task_load >> task_validate >> task_transform

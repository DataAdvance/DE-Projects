from pyspark.sql import SparkSession
from pyspark.sql.functions import to_timestamp, col

conn_details = {}
with open("/opt/spark-apps/postgres_connection_details.txt") as f:
    for line in f:
        key, val = line.strip().split('=')
        conn_details[key] = val

spark = SparkSession.builder \
    .appName("StreamingToPostgres") \
    .config("spark.jars.packages", "org.postgresql:postgresql:42.2.18") \
    .getOrCreate()

schema = "event_id INT, user_id INT, product_id INT, event_type STRING, timestamp STRING"
df = spark.readStream.option("header", True).schema(schema).csv("/opt/generated_data")

df_transformed = df.withColumn("event_timestamp", to_timestamp(col("timestamp"))).drop("timestamp")

def write_to_postgres(batch_df, batch_id):
    batch_df.write \
        .format("jdbc") \
        .option("url", f"jdbc:postgresql://{conn_details['host']}:{conn_details['port']}/{conn_details['database']}") \
        .option("dbtable", "user_events") \
        .option("user", conn_details["user"]) \
        .option("password", conn_details["password"]) \
        .option("driver", "org.postgresql.Driver") \
        .mode("append") \
        .save()

query = df_transformed.writeStream.foreachBatch(write_to_postgres).start()
query.awaitTermination()

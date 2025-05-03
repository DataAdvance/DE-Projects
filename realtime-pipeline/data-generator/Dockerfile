FROM python:3.9-slim

# Set the working directory in the container to /app
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the required Python packages listed in requirements.txt
RUN pip install -r requirements.txt

# Copy the main script that generates data
COPY data_generator.py .

# By default, run the data generator script when the container starts
CMD ["python", "data_generator.py"]


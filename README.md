# Movie Analysis with PySpark

## Project Overview
This project analyzes movie data from The Movie Database (TMDB) API using PySpark. It processes and transforms movie data into a structured format for analysis.

## Data Processing Steps
1. Fetches movie data from TMDB API
2. Creates a Spark DataFrame from the API responses
3. Cleans and transforms the data:
    - Removes irrelevant columns
    - Extracts nested JSON data
    - Handles missing values
    - Converts data types
    - Processes credits data for cast and crew information
    - Converts budget/revenue to millions USD

## Key Features
- Uses PySpark for data processing
- Handles nested JSON structures
- Implements data quality checks
- Processes movie metadata and credits information

## Data Structure
Final dataset includes:
- Movie basic information (id, title, release date)
- Financial data (budget, revenue)
- Production details (companies, countries)
- Cast and crew information
- Ratings and popularity metrics

## Dependencies
- PySpark
- Requests (for API calls)
- TMDB API key required

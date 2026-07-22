-- =============================================================================
-- Cyclistic Bike-Share Case Study
-- File:        01_data_cleaning.sql
-- Author:      Abhimanyu Jain
-- Database:    DuckDB
-- Dataset:     Cyclistic Historical Trip Data (July 2025 – June 2026)
--
-- Description:
-- This script performs the complete data preparation workflow including:
--   1. Importing and merging 12 monthly trip datasets
--   2. Cleaning, validating, and filtering out invalid/incomplete records
--   3. Feature engineering (creating derived variables for analysis)
--   4. Exporting the final cleaned dataset for exploratory analysis

-- =============================================================================
-- STEP 1: IMPORT MONTHLY DATASETS
-- =============================================================================

-- Import July 2025 dataset
CREATE TABLE july_2025 AS 
SELECT * FROM read_csv_auto('01- Data/01- July, 2025.csv');

-- Import August 2025 dataset
CREATE TABLE august_2025 AS 
SELECT * FROM read_csv_auto('01- Data/02- August, 2025.csv');

-- Import September 2025 dataset
CREATE TABLE september_2025 AS 
SELECT * FROM read_csv_auto('01- Data/03- September, 2025.csv');

-- Import October 2025 dataset
CREATE TABLE october_2025 AS 
SELECT * FROM read_csv_auto('01- Data/04- October, 2025.csv');

-- Import November 2025 dataset
CREATE TABLE november_2025 AS 
SELECT * FROM read_csv_auto('01- Data/05- November, 2025.csv');

-- Import December 2025 dataset
CREATE TABLE december_2025 AS 
SELECT * FROM read_csv_auto('01- Data/06- December, 2025.csv');

-- Import January 2026 dataset
CREATE TABLE january_2026 AS 
SELECT * FROM read_csv_auto('01- Data/07- January, 2026.csv');

-- Import February 2026 dataset
CREATE TABLE february_2026 AS 
SELECT * FROM read_csv_auto('01- Data/08- February, 2026.csv');

-- Import March 2026 dataset
CREATE TABLE march_2026 AS 
SELECT * FROM read_csv_auto('01- Data/09- March, 2026.csv');

-- Import April 2026 dataset
CREATE TABLE april_2026 AS 
SELECT * FROM read_csv_auto('01- Data/10- April, 2026.csv');

-- Import May 2026 dataset
CREATE TABLE may_2026 AS 
SELECT * FROM read_csv_auto('01- Data/11- May, 2026.csv');

-- Import June 2026 dataset
CREATE TABLE june_2026 AS 
SELECT * FROM read_csv_auto('01- Data/12- June, 2026.csv');

-- =============================================================================
-- STEP 2: MERGE ALL MONTHLY DATASETS
-- =============================================================================

-- Merge all monthly datasets into a single master table
CREATE TABLE cyclistic_trip_data AS
SELECT * FROM july_2025
UNION ALL
SELECT * FROM august_2025
UNION ALL
SELECT * FROM september_2025
UNION ALL
SELECT * FROM october_2025
UNION ALL
SELECT * FROM november_2025
UNION ALL
SELECT * FROM december_2025
UNION ALL
SELECT * FROM january_2026
UNION ALL
SELECT * FROM february_2026
UNION ALL
SELECT * FROM march_2026
UNION ALL
SELECT * FROM april_2026
UNION ALL
SELECT * FROM may_2026
UNION ALL
SELECT * FROM june_2026;

-- Result:
-- Successfully merged all twelve monthly datasets (July 2025 – June 2026)
-- into a single master table named 'cyclistic_trip_data' containing
-- 5,932,349 trip records. This consolidated dataset served as the
-- foundation for all subsequent data cleaning, transformation,
-- and exploratory analysis.

-- =============================================================================
-- STEP 3: IDENTIFY AND REMOVE DUPLICATE RECORDS
-- =============================================================================

-- Check for duplicate ride records
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT ride_id) AS unique_ride_ids
FROM cyclistic_trip_data;

-- Result:
-- The merged dataset contained 5,932,349 trip records.
-- Comparison of the total row count and unique ride_id count
-- identified 35 completely identical duplicate records.

-- Remove duplicate records
CREATE OR REPLACE TABLE cyclistic_trip_data AS
SELECT DISTINCT *
FROM cyclistic_trip_data;

-- Verify duplicate removal
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT ride_id) AS unique_ride_ids
FROM cyclistic_trip_data;

-- Result:
-- Successfully removed 35 completely identical duplicate records.
-- The cleaned dataset now contains 5,932,314 unique trip records.

-- =============================================================================
-- STEP 4: IDENTIFY MISSING VALUES
-- =============================================================================

-- Count non-null values in each column to identify missing data
SELECT
    COUNT(*) AS total_rows,
    COUNT(ride_id) AS ride_id,
    COUNT(rideable_type) AS rideable_type,
    COUNT(started_at) AS started_at,
    COUNT(ended_at) AS ended_at,
    COUNT(start_station_name) AS start_station_name,
    COUNT(start_station_id) AS start_station_id,
    COUNT(end_station_name) AS end_station_name,
    COUNT(end_station_id) AS end_station_id,
    COUNT(start_lat) AS start_lat,
    COUNT(start_lng) AS start_lng,
    COUNT(end_lat) AS end_lat,
    COUNT(end_lng) AS end_lng,
    COUNT(member_casual) AS member_casual
FROM cyclistic_trip_data;

-- Result:
-- Missing values were identified in the following columns:
--
--   • start_station_name : 1,257,507 missing values
--   • start_station_id   : 1,257,507 missing values
--   • end_station_name   : 1,321,666 missing values
--   • end_station_id     : 1,321,666 missing values
--   • end_lat            : 5,600 missing values
--   • end_lng            : 5,600 missing values
--
-- All remaining columns contained complete records with no missing values.

-- Business Context & Handling:
-- Missing values were identified in the station name, station ID, and destination 
-- coordinate columns. After assessing their impact on the business task, these 
-- records were retained because the missing fields did not affect the variables 
-- required to compare riding behavior between annual members and casual riders. 
-- Retaining these records preserved the maximum amount of usable trip data while 
-- avoiding unnecessary data loss.

-- =============================================================================
-- STEP 5: IDENTIFY BLANK (EMPTY) TEXT VALUES
-- =============================================================================

-- Check for blank (empty) text values in character columns
SELECT
    SUM(CASE WHEN TRIM(ride_id) = '' THEN 1 ELSE 0 END) AS blank_ride_id,
    SUM(CASE WHEN TRIM(rideable_type) = '' THEN 1 ELSE 0 END) AS blank_rideable_type,
    SUM(CASE WHEN TRIM(start_station_name) = '' THEN 1 ELSE 0 END) AS blank_start_station_name,
    SUM(CASE WHEN TRIM(start_station_id) = '' THEN 1 ELSE 0 END) AS blank_start_station_id,
    SUM(CASE WHEN TRIM(end_station_name) = '' THEN 1 ELSE 0 END) AS blank_end_station_name,
    SUM(CASE WHEN TRIM(end_station_id) = '' THEN 1 ELSE 0 END) AS blank_end_station_id,
    SUM(CASE WHEN TRIM(member_casual) = '' THEN 1 ELSE 0 END) AS blank_member_casual
FROM cyclistic_trip_data;

-- Result:
-- No blank (empty) text values were identified in any text columns.
--
-- This confirms that:
--   • ride_id contains no blank values.
--   • rideable_type contains no blank values.
--   • start_station_name contains no blank values (only legitimate NULL values).
--   • start_station_id contains no blank values.
--   • end_station_name contains no blank values.
--   • end_station_id contains no blank values.
--   • member_casual contains no blank values.
--
-- This also confirms that missing station information is stored
-- consistently as NULL values rather than empty strings,
-- indicating good overall data quality.

-- =============================================================================
-- STEP 6: VALIDATE TIMESTAMP CONSISTENCY
-- =============================================================================

-- Check for rides with negative durations
SELECT COUNT(*) AS negative_duration_rides
FROM cyclistic_trip_data
WHERE ended_at < started_at;

-- Check for rides with zero duration
SELECT COUNT(*) AS zero_duration_rides
FROM cyclistic_trip_data
WHERE ended_at = started_at;

-- Result:
--   • Negative-duration rides: 29
--   • Zero-duration rides: 0

-- Inspect all negative-duration ride records
SELECT
    ride_id,
    started_at,
    ended_at,
    rideable_type,
    member_casual
FROM cyclistic_trip_data
WHERE ended_at < started_at
LIMIT 29;

-- Result & Key Finding:
-- All 29 negative-duration rides occurred on November 2, 2025,
-- between approximately 1:00 AM and 2:00 AM.
--
-- Conclusion:
-- These records are not data errors. They coincide with the end of
-- Daylight Saving Time (DST) in Chicago, when clocks were set back
-- one hour. As a result, rides that legitimately crossed the DST
-- transition appear to have end times earlier than their start times
-- when recorded in local time.
--
-- Handling Strategy:
-- Since these rides represent valid trips affected by a time-zone
-- transition rather than erroneous timestamps, all 29 records were
-- retained for analysis.

-- =============================================================================
-- STEP 7: VALIDATE GEOGRAPHIC COORDINATES
-- =============================================================================

-- Check for invalid starting latitude values
SELECT COUNT(*) AS invalid_start_lat
FROM cyclistic_trip_data
WHERE start_lat < -90
   OR start_lat > 90;

-- Check for invalid ending latitude values
SELECT COUNT(*) AS invalid_end_lat
FROM cyclistic_trip_data
WHERE end_lat IS NOT NULL
  AND (end_lat < -90 OR end_lat > 90);

-- Check for invalid starting longitude values
SELECT COUNT(*) AS invalid_start_lng
FROM cyclistic_trip_data
WHERE start_lng < -180
   OR start_lng > 180;

-- Check for invalid ending longitude values
SELECT COUNT(*) AS invalid_end_lng
FROM cyclistic_trip_data
WHERE end_lng IS NOT NULL
  AND (end_lng < -180 OR end_lng > 180);

-- Result:
--   • Invalid start_lat values: 0
--   • Invalid end_lat values: 0
--   • Invalid start_lng values: 0
--   • Invalid end_lng values: 0
--
-- Conclusion:
-- All non-null geographic coordinates fall within the valid latitude
-- (-90 to 90) and longitude (-180 to 180) ranges. No impossible or
-- corrupted coordinate values were identified.
--
-- The previously identified NULL values in end_lat and end_lng were
-- excluded from this validation, as they represent missing data rather
-- than invalid geographic coordinates.


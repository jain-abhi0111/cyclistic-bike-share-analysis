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
-- STEP 6: TIMESTAMP VALIDATION AND RIDE DURATION CLEANING
-- =============================================================================

-- Review ride duration statistics and identify potential timestamp anomalies
SELECT
    COUNT(*) AS total_trips,
    MIN(ended_at - started_at) AS minimum_duration,
    MAX(ended_at - started_at) AS maximum_duration,
    COUNT(*) FILTER (WHERE ended_at < started_at) AS negative_duration_rides,
    COUNT(*) FILTER (WHERE ended_at = started_at) AS zero_duration_rides,
    COUNT(*) FILTER (
        WHERE EXTRACT(EPOCH FROM (ended_at - started_at))/60 < 1
    ) AS under_1_minute,
    COUNT(*) FILTER (
        WHERE EXTRACT(EPOCH FROM (ended_at - started_at))/3600 >= 24
    ) AS rides_24_hours_or_longer
FROM cyclistic_trip_data;

-- Inspect negative-duration rides
SELECT
    ride_id,
    started_at,
    ended_at,
    rideable_type,
    member_casual
FROM cyclistic_trip_data
WHERE ended_at < started_at;

-- Inspect rides lasting 24 hours or longer
SELECT
    ride_id,
    rideable_type,
    member_casual,
    started_at,
    ended_at,
    ROUND(
        EXTRACT(EPOCH FROM (ended_at - started_at))/3600,
        2
    ) AS duration_hours
FROM cyclistic_trip_data
WHERE EXTRACT(EPOCH FROM (ended_at - started_at))/3600 >= 24
ORDER BY duration_hours DESC;

-- Result:
--   • Total trips analysed: 5,932,314
--   • Minimum ride duration: -00:54:47.688
--   • Maximum ride duration: 1 day 01:59:57.011
--   • Negative-duration rides: 29
--   • Zero-duration rides: 0
--   • Rides under one minute: 162,217
--   • Rides lasting 24 hours or longer: 5,532

-- Data Cleaning Rationale:

--   1. Short Rides (< 1 minute) & DST Anomalies:
--      Rides under one minute are unlikely to represent meaningful trips and
--      frequently reflect accidental unlocks, docking/mechanical issues, or 
--      maintenance checks. The 29 negative-duration rides occurred during the 
--      end of Daylight Saving Time (DST) in Chicago; since they also fell under 
--      one minute in duration, they were removed alongside all short rides.
--
--   2. Long Rides (>= 24 hours):
--      Rides lasting 24 hours or longer were removed because the objective of 
--      this study is to analyze typical customer riding behavior. Trips of this 
--      length represent operational timeouts, lost/unreturned bikes, or system 
--      closings rather than standard transportation journeys.

-- Remove rides lasting less than one minute
DELETE FROM cyclistic_trip_data
WHERE EXTRACT(EPOCH FROM (ended_at - started_at))/60 < 1;

-- Remove rides lasting 24 hours or longer
DELETE FROM cyclistic_trip_data
WHERE EXTRACT(EPOCH FROM (ended_at - started_at))/3600 >= 24;

-- Verify the cleaned dataset
SELECT
    COUNT(*) AS total_rows,
    MIN(EXTRACT(EPOCH FROM (ended_at - started_at))/60) AS shortest_trip_minutes,
    MAX(EXTRACT(EPOCH FROM (ended_at - started_at))/60) AS longest_trip_minutes
FROM cyclistic_trip_data;

-- Final Result:
--   • Final cleaned dataset: 5,764,536 trips
--   • Shortest ride duration: 1.0 minute
--   • Longest ride duration: 1,439.99 minutes (less than 24 hours)

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

-- =============================================================================
-- STEP 8: VALIDATE RIDER CATEGORIES
-- =============================================================================

-- Identify all unique rider categories
SELECT DISTINCT member_casual
FROM cyclistic_trip_data;

-- Count the number of trips for each rider category
SELECT
    member_casual,
    COUNT(*) AS total_trips
FROM cyclistic_trip_data
GROUP BY member_casual
ORDER BY total_trips DESC;

-- Check for NULL or unexpected rider categories
SELECT
    COUNT(*) FILTER (WHERE member_casual IS NULL) AS null_values,
    COUNT(*) FILTER (
        WHERE member_casual NOT IN ('member', 'casual')
    ) AS unexpected_values
FROM cyclistic_trip_data;

-- Result:
--   • Rider categories identified: 2
--       - member : 3,732,745 trips
--       - casual : 2,031,791 trips
--   • NULL values: 0
--   • Unexpected category values: 0
--
-- Conclusion:
-- The rider category field passed validation successfully. Only the two
-- expected categories ('member' and 'casual') were present, with no missing
-- or invalid values. Therefore, no additional data cleaning was required for
-- this variable, and it was retained for all subsequent analysis.

-- =============================================================================
-- STEP 9: VALIDATE BIKE TYPES
-- =============================================================================

-- Identify all unique bike types
SELECT DISTINCT rideable_type
FROM cyclistic_trip_data;

-- Count the number of trips for each bike type
SELECT
    rideable_type,
    COUNT(*) AS total_trips
FROM cyclistic_trip_data
GROUP BY rideable_type
ORDER BY total_trips DESC;

-- Check for NULL or unexpected bike types
SELECT
    COUNT(*) FILTER (WHERE rideable_type IS NULL) AS null_values,
    COUNT(*) FILTER (
        WHERE rideable_type NOT IN ('classic_bike', 'electric_bike')
    ) AS unexpected_values
FROM cyclistic_trip_data;

-- Result:
--   • Bike types identified: 2
--       - electric_bike : 3,850,227 trips
--       - classic_bike  : 1,914,309 trips
--   • NULL values: 0
--   • Unexpected bike types: 0
--
-- Conclusion:
-- The bike type variable passed validation successfully. Only the two expected
-- bike types ('electric_bike' and 'classic_bike') were present, with no
-- missing or unexpected values. Therefore, no additional data cleaning was
-- required, and the variable was retained for subsequent analysis.

-- =============================================================================
-- DATA CLEANING SUMMARY & RECORD COUNT
-- =============================================================================
--
--  Raw Records Merged:         5,932,349
--  Identical Duplicates:             -35
--  Short Rides (< 1 min):       -162,217
--  Long Rides (≥ 24 hrs):         -5,532
--  -------------------------------------
--  Final Clean Dataset:        5,764,536 trips  (97.17% retained)
--
-- Summary Conclusion:
-- The cleaning pipeline removed 167,813 records (~2.83% of total data) consisting 
-- of duplicate entries, false starts/docking glitches (< 1 min), and system 
-- timeouts/unreturned bikes (≥ 24 hrs). The remaining 5,764,536 rows represent 
-- valid, high-quality customer trips ready for feature engineering and analysis.
-- =============================================================================

-- =============================================================================
-- STEP 10: FEATURE ENGINEERING
-- =============================================================================

-- Create new variables required for exploratory analysis.
-- These derived variables simplify analysis and enable grouping,
-- aggregation, and visualization of rider behaviour.

-- -----------------------------------------------------------------------------
-- Create ride_length (minutes)
-- -----------------------------------------------------------------------------
ALTER TABLE cyclistic_trip_data
ADD COLUMN ride_length DOUBLE;

UPDATE cyclistic_trip_data
SET ride_length = ROUND(
    EXTRACT(EPOCH FROM (ended_at - started_at)) / 60,
    2
);

-- -----------------------------------------------------------------------------
-- Create hour
-- -----------------------------------------------------------------------------
ALTER TABLE cyclistic_trip_data
ADD COLUMN hour INTEGER;

UPDATE cyclistic_trip_data
SET hour = EXTRACT(HOUR FROM started_at);

-- -----------------------------------------------------------------------------
-- Create day_of_week
-- -----------------------------------------------------------------------------
ALTER TABLE cyclistic_trip_data
ADD COLUMN day_of_week VARCHAR;

UPDATE cyclistic_trip_data
SET day_of_week = CASE EXTRACT(DOW FROM started_at)
    WHEN 0 THEN 'Sunday'
    WHEN 1 THEN 'Monday'
    WHEN 2 THEN 'Tuesday'
    WHEN 3 THEN 'Wednesday'
    WHEN 4 THEN 'Thursday'
    WHEN 5 THEN 'Friday'
    WHEN 6 THEN 'Saturday'
END;

-- -----------------------------------------------------------------------------
-- Create month
-- -----------------------------------------------------------------------------
ALTER TABLE cyclistic_trip_data
ADD COLUMN month VARCHAR;

UPDATE cyclistic_trip_data
SET month = CASE EXTRACT(MONTH FROM started_at)
    WHEN 7 THEN 'July'
    WHEN 8 THEN 'August'
    WHEN 9 THEN 'September'
    WHEN 10 THEN 'October'
    WHEN 11 THEN 'November'
    WHEN 12 THEN 'December'
    WHEN 1 THEN 'January'
    WHEN 2 THEN 'February'
    WHEN 3 THEN 'March'
    WHEN 4 THEN 'April'
    WHEN 5 THEN 'May'
    WHEN 6 THEN 'June'
END;

-- Verify the newly created variables
SELECT
    ride_length,
    hour,
    day_of_week,
    month
FROM cyclistic_trip_data
LIMIT 10;

-- Result:
--   • Successfully created four derived variables:
--       - ride_length : Ride duration in minutes
--       - hour        : Hour of trip start (0–23)
--       - day_of_week : Day on which the trip started
--       - month       : Month in which the trip started
--
--   • Trip distribution by month (July 2025 – June 2026):
--       - July      : 738,840 trips
--       - August    : 766,663 trips
--       - September : 695,681 trips
--       - October   : 628,474 trips
--       - November  : 346,643 trips
--       - December  : 136,459 trips
--       - January   : 133,743 trips
--       - February  : 197,317 trips
--       - March     : 308,466 trips
--       - April     : 435,478 trips
--       - May       : 635,395 trips
--       - June      : 741,377 trips
--
-- Conclusion:
-- Feature engineering was successfully completed. Four analytical variables
-- were derived from the original trip timestamps to support exploratory
-- analysis. These variables enable comparison of rider behaviour by ride
-- duration, hour of the day, day of the week, and month throughout the
-- July 2025–June 2026 study period.

-- =============================================================================
-- STEP 11: REVIEW FINAL DATASET STRUCTURE
-- =============================================================================

-- Display the final schema of the cleaned dataset
DESCRIBE cyclistic_trip_data;

-- Result:
-- Final cleaned dataset contains the following columns:
--
-- Original Variables:
--   • ride_id
--   • rideable_type
--   • started_at
--   • ended_at
--   • start_station_name
--   • start_station_id
--   • end_station_name
--   • end_station_id
--   • start_lat
--   • start_lng
--   • end_lat
--   • end_lng
--   • member_casual
--
-- Derived Variables:
--   • ride_length
--   • hour
--   • day_of_week
--   • month
--
-- Conclusion:
-- The final cleaned dataset contains 17 variables, consisting of
-- 13 original variables and 4 derived variables created during
-- feature engineering. The dataset is fully prepared for
-- exploratory data analysis.

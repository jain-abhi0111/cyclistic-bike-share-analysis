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

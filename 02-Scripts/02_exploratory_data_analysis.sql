-- =============================================================================
-- CYCLISTIC BIKESHARE ANALYSIS: EXPLORATORY DATA ANALYSIS (EDA)
-- =============================================================================
-- Author      : Abhimanyu Jain
-- Dataset     : Cyclistic Bikeshare Trip Data (July 2025 – June 2026)
-- Clean Data  : 5,764,536 valid trips (17 variables)
-- Objective   : Identify how do Annual Members and Casual Riders use Cyclistic 
--               bikes differently?
-- =============================================================================
--
-- TABLE OF CONTENTS:
-- ------------------
-- ANALYSIS 1: RIDE VOLUME ANALYSIS (Who uses Cyclistic more?)
-- ANALYSIS 2: TRIP DURATION & BIKE PREFERENCES (How do they use Cyclistic differently?)
-- ANALYSIS 3: TEMPORAL BEHAVIOR PATTERNS (When do they ride?)
-- ANALYSIS 4: SPATIAL BEHAVIOR PATTERNS (Where do they ride?)
-- EXECUTIVE SUMMARY & STRATEGIC RECOMMENDATIONS
-- =============================================================================

-- =============================================================================
-- ANALYSIS 1: WHO USES CYCLISTIC MORE? (RIDE VOLUME)
-- =============================================================================

-- Objective:
-- Compare the total number and percentage of trips taken by annual members
-- and casual riders throughout the study period.

SELECT
    member_casual,
    COUNT(*) AS total_trips,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM cyclistic_trip_data
GROUP BY member_casual
ORDER BY total_trips DESC;

-- Result:
--   • Annual Members : 3,732,745 trips (64.75%)
--   • Casual Riders  : 2,031,791 trips (35.25%)
--
-- Conclusion:
-- Annual members accounted for nearly two-thirds (64.75%) of all bike trips,
-- while casual riders contributed the remaining 35.25%. This indicates that
-- annual members represent Cyclistic's primary customer base and rely on the
-- service more frequently than casual riders. However, casual riders still
-- generated more than two million trips during the study period, highlighting
-- a substantial opportunity for membership conversion.

-- =============================================================================
-- ANALYSIS 2: HOW DO THEY USE CYCLISTIC DIFFERENTLY? (TRIP DURATION & BIKE PREFERENCES)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 2.1 Ride Duration
-- -----------------------------------------------------------------------------
-- Objective:
-- Compare ride duration between annual members and casual riders by
-- calculating the average, minimum, and maximum ride length.

SELECT
    member_casual,
    COUNT(*) AS total_trips,
    ROUND(AVG(ride_length), 2) AS average_ride_minutes,
    ROUND(MIN(ride_length), 2) AS minimum_ride_minutes,
    ROUND(MAX(ride_length), 2) AS maximum_ride_minutes
FROM cyclistic_trip_data
GROUP BY member_casual;

-- Result:
--   • Annual Members:
--       - Total Trips         : 3,732,745
--       - Average Ride Length : 12.32 minutes
--       - Minimum Ride Length : 1.00 minute
--       - Maximum Ride Length : 1,439.90 minutes
--
--   • Casual Riders:
--       - Total Trips         : 2,031,791
--       - Average Ride Length : 19.29 minutes
--       - Minimum Ride Length : 1.00 minute
--       - Maximum Ride Length : 1,439.98 minutes
--
-- Conclusion:
-- Casual riders spent considerably more time on each trip than annual
-- members, averaging 19.29 minutes compared with 12.32 minutes for members.
-- This suggests that casual riders primarily use Cyclistic for leisure,
-- sightseeing, and recreational travel, whereas annual members tend to make
-- shorter, purpose-driven trips such as commuting to work or running errands.

-- -----------------------------------------------------------------------------
-- 2.2 Bike Type Preference
-- -----------------------------------------------------------------------------
-- Objective:
-- Compare bicycle preferences between annual members and casual riders.

SELECT
    member_casual,
    rideable_type,
    COUNT(*) AS total_trips,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY member_casual),
        2
    ) AS percentage
FROM cyclistic_trip_data
GROUP BY
    member_casual,
    rideable_type
ORDER BY
    member_casual,
    total_trips DESC;

-- Result:
--   • Casual Riders:
--       - Electric Bike : 1,401,385 trips (68.97%)
--       - Classic Bike  :   630,406 trips (31.03%)
--
--   • Annual Members:
--       - Electric Bike : 2,448,842 trips (65.60%)
--       - Classic Bike  : 1,283,903 trips (34.40%)
--
-- Conclusion:
-- Electric bikes were the preferred bicycle type for both rider groups.
-- Approximately 69% of casual riders and 66% of annual members chose
-- electric bikes, while classic bikes accounted for the remaining trips.
-- The similarity in bike preferences suggests that bicycle type is unlikely
-- to be a major factor influencing membership conversion.

-- =============================================================================
-- ANALYSIS 3: WHEN DO THEY RIDE? (TEMPORAL BEHAVIOR PATTERNS)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 3.1 Hour of the Day
-- -----------------------------------------------------------------------------
-- Objective:
-- Compare hourly riding patterns between annual members and casual riders
-- to identify the busiest times of day for each rider group.

SELECT
    hour,
    member_casual,
    COUNT(*) AS total_trips,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY member_casual),
        2
    ) AS percentage
FROM cyclistic_trip_data
GROUP BY
    hour,
    member_casual
ORDER BY
    hour,
    member_casual;

-- Result:
--   • Annual members showed a pronounced increase in ride activity during the
--     morning commute (06:00–09:00), with morning activity peaking at
--     08:00 (7.32%).
--
--   • Casual riders displayed a more gradual increase in ride activity
--     throughout the day, with usage steadily rising from late morning until
--     late afternoon.
--
--   • Both rider groups reached their highest level of activity at
--     17:00 (5:00 PM):
--        - Annual Members : 403,223 trips (10.80%)
--        - Casual Riders  : 194,121 trips (9.55%)
--
--   • Between 16:00 and 18:00, both rider groups recorded the highest
--     concentration of daily trips, making this the busiest period of the day.
--
--   • Overnight activity remained consistently low for both rider groups,
--     particularly between 00:00 and 05:00.
--
-- Conclusion:
-- Annual members exhibited clear commuting behaviour, with distinct peaks
-- during the morning and evening rush hours. In contrast, casual riders
-- showed a more evenly distributed riding pattern throughout the day,
-- suggesting greater recreational and leisure use. Although both groups
-- experienced their highest activity during the late afternoon, the sharper
-- morning peak among members highlights their stronger reliance on Cyclistic
-- for routine transportation.

-- -----------------------------------------------------------------------------
-- 3.2 Day of the Week
-- -----------------------------------------------------------------------------
-- Objective:
-- Compare weekly riding patterns between annual members and casual riders
-- to identify differences in weekday and weekend usage.

SELECT
    day_of_week,
    member_casual,
    COUNT(*) AS total_trips,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY member_casual),
        2
    ) AS percentage
FROM cyclistic_trip_data
GROUP BY
    day_of_week,
    member_casual
ORDER BY
    CASE day_of_week
        WHEN 'Sunday' THEN 1
        WHEN 'Monday' THEN 2
        WHEN 'Tuesday' THEN 3
        WHEN 'Wednesday' THEN 4
        WHEN 'Thursday' THEN 5
        WHEN 'Friday' THEN 6
        WHEN 'Saturday' THEN 7
    END,
    member_casual;

-- Result:
--   • Annual members recorded the highest ride activity during weekdays,
--     particularly between Tuesday and Thursday.
--
--   • Tuesday represented the busiest day for annual members,
--     accounting for 605,709 trips (16.23%), followed closely by
--     Thursday (15.96%) and Wednesday (15.82%).
--
--   • Casual riders displayed a distinctly different riding pattern,
--     with activity concentrated on weekends.
--
--   • Saturday was the busiest day for casual riders,
--     accounting for 427,263 trips (21.03%), followed by
--     Sunday with 333,151 trips (16.40%).
--
--   • Friday also represented a relatively busy day for casual riders
--     (15.66%), suggesting recreational riding begins before the weekend.
--
-- Conclusion:
-- Weekly riding behaviour differed substantially between the two rider
-- groups. Annual members primarily used Cyclistic during the traditional
-- workweek, reinforcing the conclusion that membership is closely associated
-- with commuting and routine travel. In contrast, casual riders were most
-- active on weekends, particularly Saturdays, indicating that their trips
-- were more recreational and leisure-oriented.

-- -----------------------------------------------------------------------------
-- 3.3 Month
-- -----------------------------------------------------------------------------
-- Objective:
-- Compare monthly riding patterns between annual members and casual riders
-- to identify seasonal trends throughout the July 2025–June 2026 study period.

SELECT
    month,
    member_casual,
    COUNT(*) AS total_trips,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY member_casual),
        2
    ) AS percentage
FROM cyclistic_trip_data
GROUP BY
    month,
    member_casual
ORDER BY
    CASE month
        WHEN 'July' THEN 1
        WHEN 'August' THEN 2
        WHEN 'September' THEN 3
        WHEN 'October' THEN 4
        WHEN 'November' THEN 5
        WHEN 'December' THEN 6
        WHEN 'January' THEN 7
        WHEN 'February' THEN 8
        WHEN 'March' THEN 9
        WHEN 'April' THEN 10
        WHEN 'May' THEN 11
        WHEN 'June' THEN 12
    END,
    member_casual;

-- Result:
--   • Ride activity increased substantially during the warmer months and
--     declined during the winter months for both rider groups.
--
--   • Casual riders recorded their highest ride activity during:
--        - August   : 323,533 trips (15.92%)
--        - July     : 308,446 trips (15.18%)
--        - June     : 297,240 trips (14.63%)
--
--   • Annual members also reached their highest ride activity during summer:
--        - June     : 444,137 trips (11.90%)
--        - August   : 443,130 trips (11.87%)
--        - September: 440,954 trips (11.81%)
--
--   • Both rider groups experienced their lowest activity during the winter
--     months, particularly December and January.
--
-- Conclusion:
-- Riding activity exhibited strong seasonality for both rider groups, with
-- demand peaking during the summer months and declining considerably during
-- winter. Casual riders showed a more pronounced seasonal pattern, indicating
-- that their usage is highly influenced by favourable weather and recreational
-- opportunities. Annual members also followed seasonal trends but maintained
-- a relatively more consistent ridership throughout the year in contrast to
-- casual riders.

-- =============================================================================
-- ANALYSIS 4: WHERE DO THEY RIDE? (SPATIAL BEHAVIOR PATTERNS)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 4.1 Top Start Stations
-- -----------------------------------------------------------------------------
-- Objective:
-- Identify the ten most frequently used trip origin stations for annual
-- members and casual riders to understand where each rider group typically
-- begins their journeys.

SELECT
    start_station_name,
    member_casual,
    COUNT(*) AS total_trips
FROM cyclistic_trip_data
WHERE start_station_name IS NOT NULL
GROUP BY
    start_station_name,
    member_casual
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY member_casual
    ORDER BY COUNT(*) DESC
) <= 10
ORDER BY
    member_casual,
    total_trips DESC;

-- Result:
--   • Top Start Stations – Casual Riders:
--       - Navy Pier                            : 45,972 trips
--       - DuSable Lake Shore Dr & Monroe St    : 32,167 trips
--       - Michigan Ave & Oak St                : 22,470 trips
--       - DuSable Lake Shore Dr & North Blvd   : 19,789 trips
--       - Millennium Park                      : 18,135 trips
--       - Shedd Aquarium                       : 16,866 trips
--       - Theater on the Lake                  : 15,963 trips
--       - DuSable Harbor                       : 14,852 trips
--       - Michigan Ave & 8th St                : 10,701 trips
--       - Montrose Harbor                      : 10,389 trips
--
--   • Top Start Stations – Annual Members:
--       - Canal St & Madison St                : 22,534 trips
--       - State St & Chicago Ave               : 20,892 trips
--       - Clinton St & Madison St              : 19,609 trips
--       - Wells St & Concord Ln                : 19,212 trips
--       - Wells St & Elm St                    : 19,209 trips
--       - Clinton St & Washington Blvd         : 19,115 trips
--       - Clinton St & Jackson Blvd            : 19,043 trips
--       - Clark St & Elm St                    : 17,972 trips
--       - Wells St & Huron St                  : 17,966 trips
--       - Kingsbury St & Kinzie St             : 16,809 trips
--
-- Conclusion:
-- Casual riders most frequently began their trips at Chicago's popular
-- recreational and tourist destinations, including Navy Pier, Millennium
-- Park, Shedd Aquarium, and stations along DuSable Lake Shore Drive.
-- In contrast, annual members primarily started their trips at stations
-- located within Chicago's central business district and surrounding
-- commercial neighbourhoods, reinforcing the finding that members rely
-- on Cyclistic predominantly for commuting and routine urban travel.

-- -----------------------------------------------------------------------------
-- 4.2 Top End Stations
-- -----------------------------------------------------------------------------
-- Objective:
-- Identify the ten most frequently used trip destination stations for annual
-- members and casual riders to understand where each rider group typically
-- ends their journeys.

SELECT
    end_station_name,
    member_casual,
    COUNT(*) AS total_trips
FROM cyclistic_trip_data
WHERE end_station_name IS NOT NULL
GROUP BY
    end_station_name,
    member_casual
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY member_casual
    ORDER BY COUNT(*) DESC
) <= 10
ORDER BY
    member_casual,
    total_trips DESC;

-- Result:
--   • Top End Stations – Casual Riders:
--       - Navy Pier                            : 47,271 trips
--       - DuSable Lake Shore Dr & Monroe St    : 29,855 trips
--       - Michigan Ave & Oak St                : 22,942 trips
--       - DuSable Lake Shore Dr & North Blvd   : 22,278 trips
--       - Millennium Park                      : 19,139 trips
--       - Theater on the Lake                  : 17,520 trips
--       - Shedd Aquarium                       : 15,002 trips
--       - DuSable Harbor                       : 12,804 trips
--       - Montrose Harbor                      : 10,223 trips
--       - Clark St & Lincoln Ave               : 9,835 trips
--
--   • Top End Stations – Annual Members:
--       - Canal St & Madison St                : 21,904 trips
--       - State St & Chicago Ave               : 21,511 trips
--       - Clinton St & Madison St              : 20,029 trips
--       - Wells St & Concord Ln                : 19,404 trips
--       - Wells St & Elm St                    : 19,063 trips
--       - Clark St & Elm St                    : 18,689 trips
--       - Clinton St & Washington Blvd         : 18,568 trips
--       - Clinton St & Jackson Blvd            : 18,528 trips
--       - Wells St & Huron St                  : 17,454 trips
--       - Kingsbury St & Kinzie St             : 16,981 trips
--
-- Conclusion:
-- Casual riders most frequently ended their trips at Chicago's popular
-- recreational and tourist destinations, with Navy Pier remaining the
-- single busiest destination. Annual members predominantly ended their
-- trips at stations located throughout Chicago's downtown business district,
-- further supporting the conclusion that members primarily use Cyclistic
-- for commuting and routine urban transportation.

-- =============================================================================
-- EXECUTIVE SUMMARY & STRATEGIC RECOMMENDATIONS
-- =============================================================================
--
-- BEHAVIORAL COMPARISON MATRIX:
-- -----------------------------------------------------------------------------
-- Metric / Feature       | Annual Members              | Casual Riders
-- -----------------------|-----------------------------|-----------------------
-- Usage Pattern          | Routine Commuting & Transit | Leisure & Recreation
-- Market Share           | 64.75% (3.73M trips)        | 35.25% (2.03M trips)
-- Average Duration       | 12.32 minutes               | 19.29 minutes (+56.6%)
-- Preferred Bike Type    | Electric (65.60%)           | Electric (68.97%)
-- Peak Days              | Weekdays (Tue–Thu)          | Weekends (Fri–Sun)
-- Peak Hours             | 08:00 AM & 05:00 PM         | 04:00 PM–06:00 PM
-- Peak Seasons           | Summer (June–September)     | Summer (Jul–Aug)
-- Key Locations          | Business & Transit Hubs     | Lakefront & Tourist Hubs
--
-- KEY MARKETING RECOMMENDATIONS FOR CONVERSION:
-- -----------------------------------------------------------------------------
-- 1. Weekend Membership Trial:
--    Offer a low-cost one-month membership during summer weekends, allowing casual 
--    riders to experience member benefits before upgrading to a full annual 
--    membership.
--
-- 2. Targeted On-Site Marketing at Tourist & Waterfront Docks:
--    Deploy targeted in-app promotions, station signage, and QR codes promoting 
--    membership perks at top casual stations like Navy Pier, Lake Shore Drive, 
--    and Millennium Park.
--
-- 3. High-Volume Season Promotions:
--    Launch seasonal membership campaigns during May–July, before peak recreational 
--    demand begins, offering discounted first-year memberships to casual riders.
-- =============================================================================

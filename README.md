# Cyclistic Bike-Share Analysis: Converting Casual Riders to Annual Members

## Executive Summary
This case study analyzes **5.93 million trip records** from July 2025 to June 2026 to identify behavioral differences between **casual riders** and **annual members** of Cyclistic (a Chicago-based bike-share company). 

The goal of this analysis is to inform targeted marketing strategies aimed at converting high-value casual riders into long-term annual subscribers.

### Key Insights
* **Usage Intent:** **Members** use Cyclistic primarily for daily commutes (peaking on weekdays during 8 AM and 5 PM rush hours near business centers). **Casual riders** use the service for leisure and tourism (peaking on weekends, during summer months, and near lakefront/recreational stations).
  
* **Trip Duration:** Casual riders spend significantly more time per ride (averaging longer duration) compared to members, who take shorter, task-oriented trips.
  
* **Bike Preference:** Electric bikes are the preferred choice across both groups, showing that hardware choice is not a primary factor distinguishing rider types.

### Top Business Recommendations
1. **Seasonal & Weekend Campaigns:** Focus marketing efforts on weekend riders during peak summer months at popular recreational and lakefront stations.
   
3. **Flexible Membership Products:** Introduce weekend-pass-to-membership transition credits or seasonal membership tiers tailored for recreational riders.
   
5. **Targeted Behavioral Nudges:** Implement digital promotions targeting casual riders who log frequent trips during weekday commuting hours.

---

## Tools Used
* **Dataset:** Cyclistic (Divvy) public trip data provided by Motivate International Inc. (5.93M rows).
  
* **Microsoft Excel:** Initial data inspection, formatting, and quick validation checks.
  
* **DuckDB (SQL):** High-performance SQL engine used to clean, transform, join 12 monthly tables, and perform feature engineering.
  
* **Google Sheets:** Data visualization, trend charting, and dashboard layout.

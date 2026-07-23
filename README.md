# Cyclistic Bike-Share Analysis: Converting Casual Riders into Annual Members

## Project Overview
This project is the capstone case study for the **Google Data Analytics Professional Certificate**. It analyzes Cyclistic's historical bike-share trip data to identify how **annual members** and **casual riders** use the service differently and provides data-driven marketing recommendations to increase annual memberships.

The analysis follows the **Google Data Analytics Process**:

> **Ask → Prepare → Process → Analyze → Share → Act**

---

## Business Task
Analyze Cyclistic's historical bike trip data to compare the riding behavior of annual members and casual riders and develop data-driven marketing recommendations to encourage casual riders to become annual members.

---

## Dataset

* **Source:** Cyclistic (Divvy) public trip data provided by Motivate International Inc.
* **Study Period:** July 2025 – June 2026
* **Original Dataset:** 5.93 million trips
* **Final Cleaned Dataset:** **5,764,536 trips**

---

## Tools Used

* **Microsoft Excel:** Initial data inspection, formatting, and quick validation checks.
* **DuckDB (SQL):** SQL engine used to clean, transform, join 12 monthly tables, and perform feature engineering.
* **Google Sheets/Tableau:** Data visualization, trend charting, and dashboard layout.
* **GitHub:** Project documentation and portfolio presentation

---

## Key Findings

* **Annual members generated 64.75%** of all trips, while casual riders accounted for **35.25%**.
  
* Casual riders rode **56.6% longer** on average (19.29 minutes) than annual members (12.32 minutes).
  
* Both rider groups preferred **electric bikes**, indicating that bike type was not a major differentiating factor.
  
* Annual members primarily rode during **weekday commuting hours**, while casual riders were most active on **weekends, summer months, and late afternoons**.
  
* Casual riders frequently travelled around **Chicago's tourist attractions and lakefront destinations**, whereas members primarily rode between stations in the **downtown business district**.
  
* Casual riders completed proportionally more **round trips (7.92%)** than annual members (2.23%), reinforcing their recreational riding behavior.

---

## Business Recommendations

* Launch seasonal membership campaigns before peak summer demand.
* Promote memberships at high-volume recreational stations such as **Navy Pier** and **Millennium Park**.
* Deliver personalized in-app and email promotions to frequent casual riders.
* Highlight the long-term value and cost savings of annual memberships for regular leisure riders.

---

## Repository Structure

```text
Cyclistic-Case-Study/
│
├── Data/
├── Scripts/
├── Visualizations/
├── Reports/
├── LICENSE/
└── README.md

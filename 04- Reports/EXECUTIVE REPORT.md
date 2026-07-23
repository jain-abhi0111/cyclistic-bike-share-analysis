# 📊 Cyclistic Case Study: Executive Strategy Report

**Prepared For:** Moreno (Director of Marketing) & Cyclistic Executive Team  
**Dataset Scope:** July 2025 – June 2026 (5,764,536 Cleaned Trips)  
**Author:** Lead Data Analyst  

---

## 1. Executive Summary

Cyclistic’s long-term financial profitability relies on expanding annual membership subscriptions. While casual riders generate immediate revenue through single-ride and full-day passes, annual members provide recurring, predictable revenue and form the operational backbone of the bike-share system.

Through an end-to-end data pipeline—cleaning 5.76 million records in BigQuery SQL and analyzing user behaviors—we identified clear behavioral distinctions between casual riders and annual members. Casual riders account for **2,031,791 trips (35.25%)** and ride **56.6% longer per trip** than members. Converting even a fraction of these highly engaged recreational users into annual members represents Cyclistic's highest-value growth opportunity.

---

## 2. Behavioral Profile Comparison

| Analytical Dimension | Annual Members | Casual Riders | Key Business Takeaway |
| :--- | :--- | :--- | :--- |
| **Total Trips** | **3,732,745** (64.75%) | **2,031,791** (35.25%) | Casual riders represent a massive 2M+ trip conversion market. |
| **Average Duration** | **12.32 minutes** | **19.29 minutes** | Casual rides are 56.6% longer (leisure & recreation vs. utility). |
| **Bike Preference** | **65.60%** Electric / **34.40%** Classic | **68.97%** Electric / **31.03%** Classic | Hardware preference is identical; bike type is **not** a conversion barrier. |
| **Peak Days** | Tuesday – Thursday (16.2%) | Saturday – Sunday (21.1%) | Members commute during workdays; Casuals ride on weekends. |
| **Peak Hours** | 8:00 AM & 5:00 PM Spikes | 12:00 PM – 5:00 PM Curve | Utility commute spikes vs. steady afternoon leisure building. |
| **Top Hotspots** | Canal & Madison, State & Chicago | Navy Pier, DuSable Lake Shore Dr | Commercial transit hubs vs. waterfront tourist attractions. |

---

## 3. Core Strategic Insights

### 💡 Insight 1: Fleet Preference Parity
Both groups prefer electric bikes by nearly 2:1 (**68.97% Casual vs. 65.60% Member**). Casual users do not avoid memberships due to hardware preferences. Product experience is identical; friction exists purely in pricing structure and membership positioning.

### 💡 Insight 2: Utility vs. Recreational Usage
* **Members** rely on Cyclistic for routine daily transportation, showing sharp commuter spikes at 8 AM and 5 PM on weekdays and maintaining year-round trip baselines.
* **Casual Riders** ride for leisure, peaking on sunny summer weekends (**21.1% on Saturdays**) and late afternoons, with sharp winter drops (<2% in Jan/Feb).

### 💡 Insight 3: Geographic Isolation of Casual Riders
Casual trips heavily cluster near Chicago's waterfront and parks. **Navy Pier** is the #1 station for casual starts (**45,972 trips**) and ends (**47,271 trips**). Conversely, members cluster around financial district transit hubs like *Canal St & Madison St*.

---

## 4. Data-Driven Marketing Recommendations (Act Phase)

### 1. 🎟️ Introduce a "Seasonal / Weekend Pass" Gateway Tier
* **Strategy:** Launch a 4-Month Summer Pass or Weekend Pass. Since casual riders peak in summer and weekends, a lower-barrier seasonal tier captures revenue and creates an automated upgrade path to full annual subscriptions.

### 2. 📍 Geofenced & Station-Targeted Promotions
* **Strategy:** Deploy physical kiosk wrap advertising and geofenced mobile app notifications at Navy Pier, DuSable Lake Shore Dr, and Millennium Park.
* **Tactics:** Offer immediate ride-credit promotions: *"Turn today's $15 pass into a credit toward an Annual Membership!"*

### 3. ⏱️ Convert Peak-Hour Casual Commuters
* **Strategy:** 9.5% of casual trips occur during the 5:00 PM weekday rush hour. Target non-subscribing commuters with a "5-Day Commuter Challenge" offering bonus e-bike credits when they test commuting via Cyclistic.

### 4. ⚡ E-Bike Credit Membership Perks
* **Strategy:** Capitalize on the ~69% preference for electric bikes by offering 60 minutes of free monthly e-bike unlock/ride credits exclusively included in annual memberships.

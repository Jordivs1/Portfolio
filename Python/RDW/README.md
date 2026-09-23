# RDW Vehicle Registration - Data Pipeline

## Project Overview
This project extracts, cleans, and analyzes vehicle registration data from
the RDW (Dutch vehicle authority) Open Data API. It answers a set of
business questions about vehicle admissions, fuel types, and the current
vehicle fleet using a small Python ETL pipeline built with `requests` and
`pandas`.

## Data Source
- **Source:** RDW Open Data (opendata.rdw.nl), a Socrata-based REST API
- **Datasets used:**
  - *Gekentekende voertuigen* (vehicle registrations) — brand, vehicle
    type, admission date, load capacity, export indicator, and more
  - *Gekentekende voertuigen brandstof* (fuel type per vehicle) — fuel
    type per registration, linked to the vehicle registrations via
    `kenteken` (license plate)

## Business Questions
1. Which brand was admitted the most per year?
2. How has the fuel mix of newly admitted vehicles developed over the years?
3. What is the average load capacity per vehicle type, and which vehicle
   types are admitted most?
4. How many vehicles are exported each year, compared to the number of new
   admissions per year?
5. What is the average age of the current vehicle fleet per vehicle type?

## Approach
- Vehicle registration data is pulled first and cleaned (dates parsed,
  columns cast to the right types).
- The license plates from that sample are then used to filter the
  fuel-type API request, using the API's `in()` filter operator — this
  guarantees the two datasets actually overlap, instead of pulling two
  independent samples that may not share any records.
- The cleaned datasets are merged and grouped with pandas to answer each
  business question.

## Tools Used
- Python
- `requests`
- `pandas`

## How to Run
1. Install the dependencies: `pip install requests pandas`
2. Run the script: `python rdw.py`

## Author
Jordi van Sighem
- 📧 jvsighem@gmail.com
- 💼 [LinkedIn](www.linkedin.com/in/jordi-van-sighem)
- 🌍 Rotterdam, Netherlands

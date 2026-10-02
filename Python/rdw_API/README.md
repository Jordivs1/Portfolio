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

## Key Findings

- **Volkswagen dominates recent years.** It's the most-admitted brand in
  the clear majority of recent years in the sample (2007, 2011–2012,
  2015–2016, 2019–2022, 2026), with Toyota and BMW as the main
  competitors. Toyota shows a striking spike in 2023 (132 admissions,
  versus roughly 5–20 in surrounding years) — likely a large batch
  registration rather than a steady trend.
- **New admissions grow sharply over time**, from a handful per year
  before 2000 to well over 100 per year from 2016 onward, peaking at 256
  in 2023 and 247 in 2017. This reflects both real growth in vehicle
  registrations and how the sample itself is drawn — these are counts
  within this ~3,000-record sample, not national totals.
- **Exports follow a broadly similar upward pattern** to new admissions,
  peaking around 2010–2015 and again in 2021 (9–11 exports/year in the
  sample), loosely consistent with older vehicles cycling out as the
  overall registered fleet grows.
- **Load capacity (laadvermogen) is only meaningfully registered for
  freight-oriented vehicle types.** Semi-trailers (*Oplegger*) average
  almost 32.8 tons, dwarfing regular trailers (*Aanhangwagen*: ~876 kg,
  *Middenasaanhangwagen*: ~1,688 kg). Passenger cars, motorcycles and
  mopeds have no registered load capacity at all.
- **Fleet age varies enormously by vehicle type.** Trailers
  (*Aanhangwagen*) average roughly 31 years old — by far the oldest
  category — while semi-trailers (*Oplegger*) average only about 5.5
  years, and passenger cars (*Personenauto*) sit in between at roughly
  11 years.

> **Note:** these findings are based on a sample of 3,000 vehicle
> registrations pulled from the API, not the full RDW dataset — patterns
> are indicative of what's in the sample, not definitive national
> statistics.

## Approach
- Vehicle registration data is pulled first (with pagination via the
  API's `$offset` parameter, since a single request is capped at ~1,000
  rows) and cleaned (dates parsed, columns cast to the right types).
- The license plates from that sample are then used to filter the
  fuel-type API request in batches, using the API's `in()` filter
  operator — this guarantees the two datasets actually overlap, instead
  of pulling two independent samples that may not share any records, and
  avoids hitting the API's URL length limit when the kenteken list is
  large.
- The cleaned datasets are merged and grouped with pandas to answer each
  business question, and each result is written to its own CSV file in
  `output/`.

## Tools Used
- Python
- `requests`
- `pandas`

## How to Run
1. Install the dependencies: `pip install requests pandas`
2. Run the script: `python rdw.py`
3. Results are written to the `output/` folder as individual CSV files,
   one per business question.

## Author
Jordi van Sighem
- 📧 jvsighem@gmail.com
- 💼 [LinkedIn](https://www.linkedin.com/in/jordi-van-sighem-2953671a3)
- 🌍 Rotterdam, Netherlands
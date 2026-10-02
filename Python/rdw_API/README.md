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

- **Volkswagen dominates for most of the 2010s.** It's the most-admitted
  brand for 8 years in a row (2015–2022), after also leading in 2009,
  2011 and 2012. From 2023 onward the top spot diversifies — BMW, Tesla
  and Suzuki each lead a year — with Tesla's jump to 29 admissions in
  2024 standing out against single digits in neighboring years.
- **New admissions grow sharply over time**, from single digits per year
  before 1990 to regular triple digits from the early 2000s onward,
  peaking at 396 in 2015 and 219 in 2024. This reflects both real growth
  in vehicle registrations and how the sample itself is drawn — these
  are counts within this ~3,000-record sample, not national totals.
- **Exports broadly track new admissions**, with the same 2015 peak (36
  exports that year, the sample's highest), and otherwise ranging from
  single digits to the high teens (e.g. 17 in 2011, 12 in 2008) —
  consistent with older vehicles cycling out as the overall registered
  fleet grows.
- **Load capacity (laadvermogen) is only meaningfully registered for
  freight/commercial vehicle types.** In this sample that's
  *Middenasaanhangwagen* (~1,958 kg), *Bedrijfsauto* (~1,872 kg), *Bus*
  (~1,680 kg) and *Aanhangwagen* (~1,458 kg). Passenger cars,
  motorcycles and mopeds have no registered load capacity at all.
- **Fleet age varies enormously by vehicle type.** Sidecar motorcycles
  (*Motorfiets met zijspan*) are the oldest on average at roughly 43.6
  years, followed by agricultural/forestry tractors (*Land- of
  bosbouwtrekker*, ~36.3 years) and trailers (*Aanhangwagen*, ~22.7
  years), while passenger cars (*Personenauto*) average roughly 14.3
  years.
- **The fuel mix shows electric vehicles emerging sharply in 2024**,
  jumping to 169 electric admissions that year (up from 39–42 in
  2021–2023) — the first year electric briefly rivals petrol (127) as
  the dominant fuel type in the sample.

> **Note:** these findings reflect one run of the pipeline against live
> RDW data. The script pulls a ~3,000-record sample with no fixed date
> filter or random seed, so the exact vehicle mix — and therefore these
> numbers — will shift on every re-run (a previous run of this pipeline,
> for example, had *Oplegger*/semi-trailers as the heaviest and youngest
> vehicle type; this run's sample doesn't contain any). Treat these
> findings as illustrative of patterns in a snapshot, not as fixed,
> reproducible statistics — the `output/` CSVs in this repo always
> reflect the most recent run.

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

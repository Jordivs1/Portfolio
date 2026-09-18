# E-commerce Sales & Customer Analytics — Exploratory Analysis

Portfolio project (Python/pandas) — a hands-on exploratory analysis of a multi-country e-commerce
dataset, using pandas to answer 14 concrete business questions about revenue, profit margin,
discounting behavior and customer satisfaction.

## Business questions

The notebook works through a progression of questions, from basic exploration to more advanced
grouping, merging, time series and correlation analysis:

1. How many unique customers and countries are in the dataset?
2. What's the average net sales for completed orders?
3. What's the date range covered by the data?
4. How do revenue, order volume and margin compare across customer segments?
5. Which product category generates the most total profit?
6. How does monthly net sales develop over time?
7. Does order volume or customer rating vary by country?
8. How does revenue break down across customer segment × sales channel?
9. Is there a relationship between customer rating and profit margin?
10. How does average profit margin differ per product category?
11. How much discount is typically applied, and how is it distributed across orders?
12. How often is each payment method used?

## Key findings

- Discounts are common, but heavy discounting (>20%) is not the norm — most orders fall in the
  "average discount" band.
- Profit margin varies substantially by product category: Books & Media sits around 35%, while
  Grocery exceeds 50% — suggesting room to shift focus toward higher-margin categories.
- Mobile App and Website are the clearly dominant sales channels by revenue, well ahead of
  Marketplace and Social Media.
- Customer rating is remarkably consistent across countries, pointing to a uniform product/service
  experience globally.
- Order volume spikes sharply at year-end and then drops off — a pattern worth investigating
  further (seasonality vs. one-off promotion effect).

Full analysis, code and charts are in the notebook.

## Data

| File | Grain | Rows |
|---|---|---|
| `ecommerce_sales_customer_analytics_150k.csv` | 1 row per order | 138,116 |
| `order_items.csv` | 1 row per order line | 397,569 |
| `customer_master.csv` | 1 row per customer | 25,000 |
| `product_catalog.csv` | 1 row per product | 1,175 |

Synthetic e-commerce dataset used for portfolio/learning purposes — 7 countries, 4 sales channels,
15 product categories.

> **Note:** the raw CSV files are not included in this repository — the two largest ones (48MB and
> 37MB) are above GitHub's file upload limit. The notebook below is fully executed with all outputs,
> tables and charts preserved, so it can be read and reviewed end-to-end without rerunning it.

## Approach

- **Exploration:** initial inspection of structure, dtypes and summary statistics.
- **Analysis:** grouping and aggregation (single and multi-key), merging datasets on a shared key,
  datetime conversion and monthly resampling, pivot tables, correlation analysis, and a custom
  function applied row-wise to bucket orders into discount categories.
- **Tools:** Python, pandas, matplotlib, Jupyter.

## Repo structure

```
Python/
├── ecommerce.ipynb          # full analysis, executed with outputs
└── README.md
```

## How to run

The raw data files aren't in the repo (see note above), so the notebook can't be re-executed as-is.
To run it yourself, place the four CSV files listed under **Data** in the same folder as the
notebook, then:

```bash
pip install pandas matplotlib jupyter
jupyter notebook ecommerce.ipynb
```

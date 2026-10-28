# Maven Market: Retail Sales & Returns Dashboard

An interactive Power BI dashboard for a three-country grocery chain (USA, Canada, Mexico). It tracks revenue, profit, transactions and product returns across stores, brands and time.

![Maven Market dashboard](images/dashboard.png)

## Key figures (1997-1998)

| Metric | Value |
|---|---|
| Transactions | 269,720 |
| Revenue | $1.76M |
| Profit | $1.05M (59.7% margin) |
| Return rate | 0.99% |
| Stores | 24 across USA, Canada and Mexico |
| Brands | 111 |

## What the dashboard shows

- **Current-month KPIs** for transactions, profit and returns, each compared against last month as the goal
- **Returns vs Last Month %**, a plain-language change figure next to the returns KPI
- **Top brands table** with transactions, profit, margin and a return-rate heat map
- **Store map** plotting all 24 stores from exact latitude and longitude
- **Revenue by Country** treemap, plus Canada / Mexico / USA filter buttons
- **Weekly revenue trend** and a **Revenue vs Target** gauge
- **Year slicer** for 1997 and 1998

## Data model

A star schema with two fact tables and five dimensions.

- **Facts:** `Transaction_Data`, `Return_Data`
- **Dimensions:** `Calendar`, `Customers`, `Products`, `Stores`, `Regions`
- All relationships are many-to-one with single-direction filtering
- `Calendar` is marked as the date table, and auto date/time is turned off

### Measures (organized in display folders)

| Folder | Measures |
|---|---|
| Revenue & Profit | Total Revenue, Total Cost, Total Profit, Profit Margin, Revenue Target |
| Time Intelligence | YTD Revenue, 60-Day Revenue, Last Month Transactions / Revenue / Profit |
| Transactions | Total Transactions, All Transactions, Quantity Sold, Weekend Transactions, % Weekend Transactions |
| Returns | Return Rate, Quantity Returned, Total Returns, All Returns, Last Month Returns, Returns vs Last Month % |

## Improvements made during review

- Fixed measure formats (currency, thousands separators, removed 15-decimal formats)
- Sorted Month Name and Day Name correctly with helper sort columns
- Set Quarter, Year, price and quantity columns to "Don't summarize" so reports use measures
- Added latitude and longitude to `Stores`, because city-name geocoding placed stores in the wrong countries (e.g. Merida, Mexico plotted in Venezuela)
- Added a Month Year column for clean trend labels
- Hid technical key columns and grouped measures into display folders
- Added visual titles and a Year slicer

## Tools

Power BI Desktop, DAX, Power Query, Power BI Project (`.pbip`) with TMDL, Git and GitHub. The model review was done with Claude through the Power BI Modeling MCP server.

## Open the project

1. Clone this repo.
2. Open `MavenMarket_Transactions.pbip` in Power BI Desktop.
3. The source CSV paths in Power Query point to a local folder, so update them to where your copy of the Maven Market CSV files lives, then refresh.

## Data

Maven Market sample dataset from [Maven Analytics](https://mavenanalytics.io/data-playground).

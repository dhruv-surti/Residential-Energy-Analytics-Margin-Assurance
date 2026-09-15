# Residential Energy Analytics & Margin Assurance

A comprehensive data analytics project analyzing residential energy consumption patterns, customer segmentation, and revenue margins for an energy utility company. This project integrates SQL-based data transformations with Tableau visualizations to provide actionable insights for business strategy and pricing optimization.

## Overview

This project processes and analyzes large-scale residential energy consumption data to:
- **Identify revenue growth opportunities** across different customer segments and geographic regions
- **Optimize pricing strategies** by analyzing tariff effectiveness and customer plan distribution
- **Ensure profit margins** through data-driven insights on supply costs and consumption patterns
- **Support business decisions** with interactive dashboards and detailed analytical reports

## Project Structure

```
.
├── energy_tables.sql                    # SQL schema and data transformation logic
├── Origin_Cleaned_Dataset.csv           # Raw energy consumption data (~4.2 MB)
├── Origin_Final_Analysis_Ready.csv.xlsx # Processed analysis-ready dataset (~8.5 MB)
├── Book1.twb                            # Tableau workbook with interactive visualizations
│
├── Visualizations & Dashboards:
├── final_dashboard.png                  # Complete business dashboard
├── Revenue Growth.png                   # Revenue trends and forecasts
├── avg_revenue_per_user.png             # ARPU analysis by segment
├── distribution_state.png               # Geographic distribution heatmap
├── plan_by_state.png                    # Plan type prevalence by state
├── product_segment.png                  # Customer segmentation breakdown
├── cleaned_dataset.png                  # Data quality overview
├── pivot_table.png                      # Cross-tabulated analysis
└── sql.png                              # SQL query documentation
```

## Key Features

### Data Integration & Transformation
- **SQL-based ETL pipeline** that cleanses raw consumption data and handles outliers
- **Data quality management**: Replaces invalid values (9999) and null records with intelligent defaults
- **Date standardization**: Converts and normalizes date formats for consistency
- **Tariff calculation**: Computes average rates by plan type and time block for commercial pricing logic

### Business Analytics Dimensions
1. **Customer Analysis**: Segmentation by state, plan type, and consumption patterns
2. **Revenue Metrics**: Per-user ARPU, total revenue by segment, growth trends
3. **Pricing Optimization**: Rate effectiveness by time block (Peak, Shoulder, Off-Peak)
4. **Geographic Insights**: State-level distribution and plan adoption rates
5. **Supply Cost Analysis**: Fixed supply charges vs. variable consumption costs

### Visualizations
- Interactive Tableau dashboards for exploring multi-dimensional data
- Revenue growth trajectories and forecasting
- State-level geographic analysis with heatmaps
- Customer segmentation and plan preference breakdowns
- Pivot tables for detailed cross-tabulations

## Data Schema

### Core Tables
- **Customer_Master**: Customer metadata including state, plan type, and active status
- **Energy_Consumption**: Time-series consumption data with time blocks (Peak, Shoulder, Off-Peak)
- **Pricing_Tariffs**: Rate structures and supply charges by plan type and time block

### Key Transformations (vw_cleansed_energy_data)
- Cleansed usage values (handling outliers and nulls)
- Applied rates based on time blocks and plan types
- Joined customer and tariff data for complete billing context

## Getting Started

### Prerequisites
- SQL database (MySQL/PostgreSQL compatible)
- Tableau Desktop or Tableau Reader (to view `.twb` files)
- Python or similar tool for CSV analysis (optional)

### Setup Instructions

1. **Import the database schema**:
   ```sql
   source energy_tables.sql;
   ```

2. **Load the cleaned dataset**:
   - Import `Origin_Cleaned_Dataset.csv` into the `Energy_Consumption` table
   - Import customer and tariff reference data into respective tables

3. **Verify data quality**:
   ```sql
   SELECT * FROM vw_cleansed_energy_data LIMIT 100;
   ```

4. **Open Tableau workbook**:
   - Open `Book1.twb` in Tableau Desktop
   - Connect to your database
   - Explore interactive dashboards and drill-down analyses

### Analysis Workflows

**Revenue Analysis**:
```sql
SELECT Plan_Type, State, SUM(Cleaned_Usage_kWh * Applied_Rate_kWh) as Revenue
FROM vw_cleansed_energy_data
GROUP BY Plan_Type, State;
```

**Margin Calculation**:
```sql
SELECT Plan_Type, 
       SUM(Cleaned_Usage_kWh * Applied_Rate_kWh) - SUM(Supply_Charge) as Net_Margin
FROM vw_cleansed_energy_data
GROUP BY Plan_Type;
```

## Key Insights

The analysis reveals:
- **Revenue growth** varies significantly by state and plan type
- **ARPU drivers** are consumption patterns and time block distribution
- **Geographic variations** in customer adoption and pricing effectiveness
- **Margin opportunities** through optimized tariff structures and supply chain efficiency

## Deliverables

- ✅ Cleaned and validated energy consumption dataset
- ✅ SQL transformation logic for ongoing data processing
- ✅ Comprehensive Tableau dashboard suite
- ✅ Segmentation analysis and insights
- ✅ Revenue and margin forecasting models

## Technologies Used

- **SQL** - Data warehousing and ETL
- **Tableau** - Interactive visualization and dashboarding
- **CSV** - Data storage and export
- **Excel** - Data analysis and pivot tables

## Future Enhancements

- Predictive modeling for consumption forecasting
- Automated alerting for anomalies and margin deviations
- API integration for real-time data streaming
- Advanced segmentation using machine learning
- Sustainability metrics and carbon footprint analysis

## Contact

For questions or collaboration opportunities, please reach out to [dhruv-surti](https://github.com/dhruv-surti).

---

*Last Updated: September 2026*

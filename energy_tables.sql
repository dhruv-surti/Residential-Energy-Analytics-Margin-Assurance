CREATE DATABASE Origin_Energy_Project;-- Create a view to keep the raw data intact while performing transformations
CREATE OR REPLACE VIEW vw_cleansed_energy_data AS
WITH tariff_avg AS (
    -- Calculate the average rate for 'Shoulder' blocks per Plan_Type
    SELECT 
        Plan_Type,
        AVG(Rate_per_kWh) as Shoulder_Rate,
        AVG(Supply_Charge) as Avg_Supply_Charge
    FROM Pricing_Tariffs
    GROUP BY Plan_Type
)
SELECT 
    ec.Record_ID,
    ec.Customer_ID,
    cm.State,
    cm.Plan_Type,
    STR_TO_DATE(ec.Usage_Date, '%Y-%m-%d') as Usage_Date, -- Standardizing date format
    ec.Time_Block,
    -- Step 1: Handle outliers (9999) and NULLs by replacing them with the average usage (approx 15 kWh)
    CASE 
        WHEN ec.Usage_kWh >= 9000 OR ec.Usage_kWh IS NULL THEN 15.0 
        ELSE ec.Usage_kWh 
    END as Cleaned_Usage_kWh,
    -- Step 2: Commercial Logic - Assign rates including the calculated Shoulder rate
    CASE 
        WHEN ec.Time_Block = 'Shoulder' THEN ta.Shoulder_Rate
        ELSE pt.Rate_per_kWh
    END as Applied_Rate_kWh,
    pt.Supply_Charge
FROM Energy_Consumption ec
JOIN Customer_Master cm ON ec.Customer_ID = cm.Customer_ID
LEFT JOIN Pricing_Tariffs pt ON cm.Plan_Type = pt.Plan_Type AND ec.Time_Block = pt.Time_Block
LEFT JOIN tariff_avg ta ON cm.Plan_Type = ta.Plan_Type
WHERE cm.Is_Active = 'True'; -- Only analyze active customers
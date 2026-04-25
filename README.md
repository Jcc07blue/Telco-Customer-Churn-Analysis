## TELCO_CUSTOMER_CHURN_ANALYSIS

## PROBLEM STATEMENT
In subscription-based models and recurring payment industries, customer churn serves as a pivotal metric. It directly influences *Customer Lifetime Value (CLV)* and revenue trajectories, making it essential for assessing both business growth and long-term market competitiveness.

This project aims to analyze customer behavior and identify the key factors driving churn, with a focus on uncovering actionable insights that can support data-driven retention strategies.

By leveraging customer demographics, service usage, payment behavior, and geographic data, the objective is to answer:

- Why are customers churning?
- Which customers are at the highest risk?
- What patterns can help predict and prevent churn?

The goal is to provide insights that help the business identify areas of improvement, in order to reduce churn, retain high-value customers, and raise overall customer satisfaction.

## INTERATIVE DASHBOARD
Access the full interactive analysis on Tableau Public:  
[https://public.tableau.com/views/Dashboard_Ready2/Dashboard1?:language=es-ES&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link]

## DATA CLEANNING
- Fixed encoding issues (BOM) affecting column names.  
- Standardized column names to snake_case.  
- Corrected data types for numerical and categorical variables.  
- Validated null values and inconsistencies across key fields.

Primary and foreign keys were implemented to enforce relational integrity across the dataset.
- customer_id was used as the primary key for customer-level tables.
- zip_code was used as the primary key for the population table.
- customer_location was linked to population data via zip_code.

This structure enables analysis across both customer-level and geographic-level data.

## ANALYSIS  
- Used window functions to calculate calculated churn distribution and relative percentages across multiple dimensions without additional joins or subqueries.
- Used CTEs to create a tenure-segmentation for churned and current customers which allowed me to know if tenure is a strong predictor of churn, as well as to know which segments have the higher risks. 
- Used a CTE to establish relationships between the payment method and the contract type, allowing you to determine whether there is a correlation between these columns and the number of churned customers, as well as the areas of highest risk.
- Applied the *Pareto principle (80/20 rule)* to identify the high-value customer segment contributing to *80% of total revenue*.
-  Created a view to analyze churn metrics across different cities. By calculating city-specific vs. overall churn rates, I implemented a ranking system to identify and prioritize high-risk geographical segments.
-  Analyzed the impact of key service features (technical support, online security, and internet type) on churn behavior.


## INSIGHTS
- *Competitors are the primary reported cause of churn*. However, *32% of churn* is driven by controllable company-related factors, such as *service dissatisfaction and poor expertise of support*, representing a significant opportunity for internal improvement.
- The *'Initial' segment (0-12 months)* is the most volatile with a *47% churn rate*, highlighting a critical onboarding or early-stage service issue.
- Customers on *month-to-month contracts* using manual payment methods as *mailed check*, show the highest churn rates at *56%*. Followed by *Bank Withdrawal payments at 53%*, suggesting low commitment and potential friction in the payment experience. 
- High-value customers were identified using a *Pareto-based revenue distribution*. Within this segment, percentile-based churn risk segmentation revealed that *27% of top revenue-generating customers* are at high risk of churn.
- Certain cities show churn rates significantly above the global average, indicating localized retention risks.
- Customers *without technical support services* show a churn rate of *~41%*. Specifically, *Fiber Optic* users *without* support reach a staggering *48% churn rate*, compared to only *22%* for those who have it.

## REPOSITORY STRUCTURE
- `/sql_scripts`: Data cleaning, CTEs for segmentation, and Pareto analysis.
- `/images`: Dashboard, tech support and Pareto graphs Screenshots.
- `README.md`: Project documentation and executive summary.

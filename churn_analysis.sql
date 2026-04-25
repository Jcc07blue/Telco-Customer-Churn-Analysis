use telco_churn;
#DATA CLEANING
#RENAME COLUMNS, TYPES CHANGES, NULL AND INCONSISTENCIES

ALTER TABLE customer_churn CHANGE `customer_id` Customer_ID varchar(20);
ALTER TABLE customer_churn CHANGE `Tenure Months` Tenure_Months INT;
ALTER TABLE customer_churn CHANGE `Phone Service` Phone_Service text;
ALTER TABLE customer_churn CHANGE `Multiple Lines` Multiple_Lines text;
ALTER TABLE customer_churn CHANGE `Internet Service` Internet_Service text;
ALTER TABLE customer_churn CHANGE `Online Security` Online_Security text;
ALTER TABLE customer_churn CHANGE `Online Backup` Online_Backup text;
ALTER TABLE customer_churn CHANGE `Tech Support` Tech_Support text;
ALTER TABLE customer_churn CHANGE `Streaming TV` Streaming_TV text;
ALTER TABLE customer_churn CHANGE `Paperless Billing` Paperless_Billing text;
ALTER TABLE customer_churn CHANGE `Monthly Charges` Monthly_Charges text;
ALTER TABLE customer_churn CHANGE `Total Charges` Total_Charges text;
ALTER TABLE customer_churn CHANGE `Churn Label` Churn_Label text;
ALTER TABLE customer_churn CHANGE `Churn Value` Churn_Value int;
ALTER TABLE customer_churn CHANGE `Churn Score` Churn_Score int;
ALTER TABLE customer_churn CHANGE `Churn Reason` Churn_Reason text;
ALTER TABLE customer_churn CHANGE `Payment Method` Payment_Method text;
ALTER TABLE customer_churn CHANGE `Streaming Movies` Streaming_Movies text;
ALTER TABLE customer_churn CHANGE `Device Protection` Device_Protection text;
ALTER TABLE customer_demographics change `Customer_ID` Customer_ID varchar(20);
ALTER TABLE customer_demographics CHANGE `Senior Citizen` Senior_Citizen text;
ALTER TABLE customer_demographics CHANGE `Under 30` Under_30 text;
ALTER TABLE customer_location CHANGE `Customer_ID` Customer_ID varchar(20);
ALTER TABLE customer_location CHANGE `Zip_Code` Zip_Code int;
ALTER TABLE customer_location CHANGE `Lat Long` Lat_Long text;
ALTER TABLE customer_services CHANGE `Customer_ID` Customer_ID varchar(20);
ALTER TABLE customer_services CHANGE `Number of Referrals`Number_of_Referrals INT (10);
ALTER TABLE customer_services CHANGE `Referred a Friend` Referred_a_Friend text;
ALTER TABLE customer_services CHANGE `Tenure in Months` Tenure_in_Months INT (50);
ALTER TABLE customer_services CHANGE `Phone Service` Phone_Service text;
ALTER TABLE customer_services CHANGE `Avg Monthly Long Distance Charges` Avg_Monthly_Long_Distance_Charges decimal (15, 2);
ALTER TABLE customer_services CHANGE `Multiple Lines` Multiple_Lines text;
ALTER TABLE customer_services CHANGE `Internet Service` Internet_Service text;
ALTER TABLE customer_services CHANGE `Internet Type` Internet_Type text;
ALTER TABLE customer_services CHANGE `Avg Monthly GB Download` Avg_Monthly_GB_Download int;
ALTER TABLE customer_services CHANGE `Online Security` Online_Security text;
ALTER TABLE customer_services CHANGE `Online Backup` Online_Backup text;
ALTER TABLE customer_services CHANGE `Device Protection Plan` Device_Protection_Plan text;
ALTER TABLE customer_services CHANGE `Premium Tech Support` Premium_Tech_Support text;
ALTER TABLE customer_services CHANGE `Streaming TV` Streaming_TV text;
ALTER TABLE customer_services CHANGE `Streaming Movies` Streaming_Movies text;
ALTER TABLE customer_services CHANGE `Streaming Music` Streaming_Music text;
ALTER TABLE customer_services CHANGE `Unlimited Data` Unlimited_Data text;
ALTER TABLE customer_services CHANGE `Paperless Billing` Paperless_Billing text;
ALTER TABLE customer_services CHANGE `Payment Method` Payment_Method text;
ALTER TABLE customer_services CHANGE `Monthly Charge` Monthly_Charge decimal (15,2);
ALTER TABLE customer_services CHANGE `Total Charges` Total_Charges decimal (15,2);
ALTER TABLE customer_services CHANGE `Total Refunds` Total_Refunds decimal (15,2);
ALTER TABLE customer_services CHANGE `Total Extra Data Charges` Total_Extra_Data_Charges int;
ALTER TABLE customer_services CHANGE `Total Long Distance Charges` Total_Long_Distance_Charges decimal (15,2);
ALTER TABLE customer_services CHANGE `Total Revenue` Total_Revenue decimal (15,2);
ALTER TABLE customer_status CHANGE `Customer_ID` Customer_ID varchar(20);
ALTER TABLE customer_status CHANGE `Satisfaction Score` Satisfaction_Score int;
ALTER TABLE customer_status CHANGE `Customer Status` Customer_Status text;
ALTER TABLE customer_status CHANGE `Churn Label` Churn_Label text;
ALTER TABLE customer_status CHANGE `Churn Value` Churn_Value int;
ALTER TABLE customer_status CHANGE `Churn Score` Churn_Score int;
ALTER TABLE customer_status CHANGE `Churn Category` Churn_Category text;
ALTER TABLE customer_status CHANGE `Churn Reason` Churn_Reason text;

#VALIDACION DE DATOS
#VALORES NULOS
select 
	count(*) - count(customer_id) as null_customer_id, 
	count(*) - count(count)  as null_count, 
	count(*) - count(contract) as null_contract
from customer_churn;

select
	count(*) - count(customer_id) as null_customer_id, 
	count(*) - count(count)  as null_count
from customer_demographics;

select
	count(*) - count(customer_id) as null_customer_id, 
	count(*) - count(count)  as null_count
from customer_location;

select 
	count(*) - count(ID)  as null_ID,
	count(*) - count(zip_code)  as null_zip_code
from customer_population;

select 
	count(*) - count(customer_id)  as null_customer_id,
    	count(*) - count(count)  as null_count,
	count(*) - count(Contract)  as null_Contract,
	count(*) - count(Paperless_Billing)  as null_Paperless_Billing,
	count(*) - count(Payment_Method)  as null_Payment_Method,
	count(*) - count(Monthly_Charge)  as null_Monthly_Charge
from customer_services;

select 
	count(*) - count(customer_id)  as null_customer_id,
	count(*) - count(count)  as null_count,
	count(*) - count(customer_status)  as null_customer_status
from customer_status;
    
#DUPLICATES
SELECT customer_id, COUNT(*)
FROM customer_churn
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT customer_id, COUNT(*)
FROM customer_demographics
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT customer_id, COUNT(*)
FROM customer_location
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT Zip_Code, COUNT(*)
FROM customer_population
GROUP BY zip_code
HAVING COUNT(*) > 1;

SELECT customer_id, COUNT(*)
FROM customer_services
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT customer_id, COUNT(*)
FROM customer_status
GROUP BY customer_id
HAVING COUNT(*) > 1;

#VALORES INCONSISTENTES

select distinct gender from customer_churn;

select  number_of_dependents from customer_demographics
where Number_of_Dependents < 0;

select distinct contract from customer_services;
select distinct customer_status from customer_status;

select distinct churn_category from customer_status;

#verify uniqueness
select count(customer_id), customer_id from customer_churn
group by customer_id
having count(customer_id)>1;

select count(customer_id), customer_id from customer_demographics
group by customer_id
having count(customer_id)>1;

select count(customer_id), customer_id from customer_location
group by customer_id
having count(customer_id)>1;

select count(zip_code), zip_code from customer_population
group by zip_code
having count(zip_code)>1;

select count(customer_id), customer_id from customer_services
group by customer_id
having count(customer_id)>1;

select count(customer_id), customer_id from customer_status
group by customer_id
having count(customer_id)>1;

#DATA MODELING
#ASSIGNAMENT OF PRIMARY AND FOREIGN KEYS
alter table customer_churn add primary key (customer_id);
alter table customer_demographics add primary key (customer_id);
alter table customer_location add primary key (customer_id);
alter table customer_population add primary key (zip_code);
alter table customer_services add primary key (customer_id);
alter table customer_status add primary key (Customer_ID);

alter table customer_churn add foreign key (customer_id) REFERENCES customer_demographics(customer_id) ON DELETE CASCADE;
alter table customer_location add foreign key (customer_id) REFERENCES customer_demographics(customer_id) ON DELETE CASCADE;
alter table customer_services add foreign key (customer_id) REFERENCES customer_demographics(customer_id) ON DELETE CASCADE;
alter table customer_status add foreign key (customer_id) REFERENCES customer_demographics(customer_id) ON DELETE CASCADE;
ALTER TABLE customer_location ADD FOREIGN KEY (zip_code) REFERENCES customer_population(zip_code) ON DELETE CASCADE;

#Churn_Analysis

#Window function to determinate churned customers per category
SELECT 
    churn_category,
    COUNT(*) AS churn_customers,
    SUM(COUNT(*)) OVER () AS total_churn_customers,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 
        2
    ) AS churn_percentage
FROM customer_status
WHERE customer_status = 'Churned'
GROUP BY churn_category
ORDER BY churn_percentage DESC;

#Is the tenure a predictor of churn, andwhich tenure segments are at highest risk?
with tenure_seg_churn as (
select count(distinct css.customer_id) as Churn_customers,
case 
	when tenure_in_months between 0 and 12 then 'Initial_CS(0-12)'
    when tenure_in_months between 13 and 24 then 'Mid_CS(13-24)'
    when tenure_in_months between 25 and 48 then 'Senior_CS(25-48)'
    when tenure_in_months >= 49 then 'Premium_CS(>49)'
    else 'error'
    end as tenure_segmentation
from customer_status as css left join customer_services as csv
	on css.Customer_ID = csv.customer_id
where customer_status = "churned"
group by tenure_segmentation
order by churn_customers desc),


tenure_seg_all as (
select count(distinct css.customer_id) as All_customers,
case 
	when tenure_in_months between 0 and 12 then 'Initial_CS(0-12)'
    when tenure_in_months between 13 and 24 then 'Mid_CS(13-24)'
    when tenure_in_months between 25 and 48 then 'Senior_CS(25-48)'
    when tenure_in_months >= 49 then 'Premium_CS(>49)'
    else 'error'
    end as tenure_segmentation
from customer_status as css left join customer_services as csv
	on css.Customer_ID = csv.customer_id
group by tenure_segmentation
order by all_customers desc)

select tenure_seg_churn.tenure_segmentation, churn_customers, all_customers, (churn_customers/all_customers)*100 as churned_cs_perctg	
from tenure_seg_churn inner join tenure_seg_all
	on tenure_seg_churn.tenure_segmentation = tenure_seg_all.tenure_segmentation;

#Contract type-payment method combination, and churn risk associated

with churn_cs_seg as
(select count(distinct csv.customer_id) as churned_cs,
case when payment_method = 'Bank Withdrawal' and contract = 'Month-to-Month' then 'Bank_MTM'
	when payment_method = 'Bank Withdrawal' and contract = 'One Year' then 'Bank_1y'
	when payment_method = 'Bank Withdrawal' and contract = 'Two Year' then 'Bank_2y'
	when payment_method = 'Credit Card' and contract = 'Month-to-Month' then 'CC_MTM'
	when payment_method = 'Credit Card' and contract = 'One Year' then 'CC_1y'
	when payment_method = 'Credit Card' and contract = 'Two Year' then 'CC_2y'
	when payment_method = 'Mailed Check' and contract = 'Month-to-Month' then 'MC_MTM'
	when payment_method = 'Mailed Check' and contract = 'One Year' then 'MC_1y'
	when payment_method = 'Mailed Check' and contract = 'Two Year' then 'MC_2y'
    else 'error'
    end as Payment_method_contract_relationship
from customer_services as csv inner join customer_status as css
	on csv.Customer_ID = css.Customer_ID
where customer_status = 'churned'
group by Payment_method_contract_relationship
order by churned_cs desc),

total_cs_seg as 
(select count(distinct csv.customer_id) as total_cs,
case when payment_method = 'Bank Withdrawal' and contract = 'Month-to-Month' then 'Bank_MTM'
	when payment_method = 'Bank Withdrawal' and contract = 'One Year' then 'Bank_1y'
	when payment_method = 'Bank Withdrawal' and contract = 'Two Year' then 'Bank_2y'
	when payment_method = 'Credit Card' and contract = 'Month-to-Month' then 'CC_MTM'
	when payment_method = 'Credit Card' and contract = 'One Year' then 'CC_1y'
	when payment_method = 'Credit Card' and contract = 'Two Year' then 'CC_2y'
	when payment_method = 'Mailed Check' and contract = 'Month-to-Month' then 'MC_MTM'
	when payment_method = 'Mailed Check' and contract = 'One Year' then 'MC_1y'
	when payment_method = 'Mailed Check' and contract = 'Two Year' then 'MC_2y'
    else 'error'
    end as Payment_method_contract_relationship
from customer_services as csv inner join customer_status as css
	on csv.Customer_ID = css.Customer_ID
group by Payment_method_contract_relationship
order by total_cs desc)

select cse.Payment_method_contract_relationship, churned_cs, total_cs, (churned_cs/total_cs)*100 as churned_overtotal_pctg
from churn_cs_seg as cse inner join total_cs_seg as tcs
	on cse.Payment_method_contract_relationship = tcs.Payment_method_contract_relationship;


#High value customers, their percentil churn-risk segmentation
create view highvalue_cs_segmentation as
select *,
case when percentil >80 then 'High Risk'
	when percentil between 50 and  79 then 'Stable'
    when percentil <50 then 'Low Risk'
    else 'error'
    end as seg_percentil
from (select  *, percent_rank () over (order by churn_score) * 100 as percentil 
	from (select *
from (select *, (sum(rev_cs) over (order by rev_cs desc)/sum(rev_cs) over ())*100  as porcentaje_acumulado
from (select distinct cv.customer_id, sum(total_revenue) as rev_cs, cc.churn_score as churn_score
from customer_services as cv inner join customer_Status as cs
	on cv.Customer_ID = cs.Customer_ID
inner join customer_churn as cc
	on cc.Customer_ID = cs.Customer_ID
where customer_status != 'churned'
group by customer_id) as tabla_porcentaje_acumulado
) as tabla_porcentajes
where porcentaje_acumulado <= 80.001502) as tabla_percentiles) tabla_seg_per;

select seg_percentil, count(*) as high_valued_cs 
from highvalue_cs_segmentation
group by seg_percentil;

#Geographic location impact on churn riks and cities with higher risk
create view churnedCs_city_pctg as 
with churn_cs_city as (
select city, count(distinct cs.customer_id) as churned_cs_city
from customer_location as cl inner join customer_status as cs
	on cl.Customer_ID = cs.customer_id
where customer_status = 'churned'
group by city
),

total_cs_city as (
select city, count(distinct cs.customer_id) total_customers
from customer_location as cl inner join customer_status as cs
	on cl.Customer_ID = cs.customer_id
group by city
),

pctg_churnedcs_city_CTE as (select ccc.city, churned_cs_city, total_customers, (churned_cs_city/total_customers) *100 as pctg_churnedcs_city
from churn_cs_city as ccc inner join total_cs_city as tcc
	on ccc.city = tcc.city)
    
select *,
case when pctg_churnedcs_city <= churn_rate_global then 'Low risk'
     when pctg_churnedcs_city > churn_rate_global then 'High risk'
     else 'error'
     end as seg_churn_risk_City
from (select *, (sum(churned_cs_city) over ()/ sum(total_customers) over ())*100 as churn_rate_global
 from churnedcs_city_pctg) as seg_churn_Rate;

#Subscription to additional services (tech support, online security, internet type, premium tech support, unlimited data) impact on churn rate

select s.internet_type,SUM(case when c.churn_label = 'yes' then 1 else 0 end) as churned_clients,
    COUNT(*) as total_clients, avg(CASE WHEN churn_label = 'yes' then 1 else 0 end) * 100 as churn_rate
from customer_services as s
JOIN customer_churn AS c ON s.customer_id = c.customer_id
GROUP BY s.internet_type;

select tech_support, sum(case when churn_label = 'yes' then 1 else 0 end) as churn_cs,
count(distinct customer_id) as total_cs, avg(case when churn_label = 'yes' then 1 else 0 end)*100 as avg_churn
from customer_churn
group by tech_support;

select online_Security, sum(case when churn_label = 'yes' then 1 else 0 end) as churn_cs,
count(distinct customer_id) as total_cs, avg(case when churn_label = 'yes' then 1 else 0  end)*100 as churn_rate
from customer_churn
group by online_security;

 select Premium_Tech_Support, sum(case when churn_label = 'yes' then 1 else 0 end) as churn_Cs,
 count(distinct cs.customer_id) as total_Cs, avg(case when churn_label = 'yes' then 1 else 0 end)*100 as churn_rate
 from customer_Services as cs inner join customer_churn as cc
	on cs.customer_id = cc.Customer_ID
 group by Premium_Tech_Support;

 
select distinct unlimited_data, sum(case when churn_label= 'yes' then 1 else 0 end) as churn_cs,
count(distinct cs.customer_id) as total_cs, avg(case when churn_label = 'yes' then 1 else 0 end)*100 churn_Rate
from customer_Services as cs inner join customer_churn as cc
	on cs.customer_id = cc.customer_id
group by unlimited_data;



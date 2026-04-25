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

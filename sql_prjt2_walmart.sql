create  database sql_prjct2;
USE sql_prjct2;
/* CREATING TABLE/----------------------------------------------------------------------------------------------------------------

CREATE TABLE walmartsales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

select * from walmartsales;
-------------------------------------------------------------------------------------------------------------------------------------------------------
---timeofday

select 
time,(
case
    when time between "00:00:00" and "12:00:00" then "morning"
	when time between "12:01:00" and "16:00:00" then "afternoon"
    else "evening" end)
 as time_of_date
 from walmartsales;
 
 alter table walmartsales add column time_of_date varchar(20);
 
 update walmartsales 
 set time_of_date=(
 case
    when time between "00:00:00" and "12:00:00" then "morning"
	when time between "12:01:00" and "16:00:00" then "afternoon"
    else "evening"
    end
 );
 
 ---------dayname
 
 select date,
 dayname(date)
 from walmartsales;
 
  alter table walmartsales add column day_name varchar(20);
  
  update walmartsales 
  set
  day_name=dayname(date);
 
 ----------------month name
 
  select date,
 monthname(date)
 from walmartsales;
 
  alter table walmartsales add column month_name varchar(20);
  
  update walmartsales 
  set
  month_name=monthname(date);

-------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------exploratory data analysis--------------------------------------------------------------------------------

------------------How many unique cities does the data have?

select 
distinct city
 from walmartsales;
 
------------------In which city is each branch?

select 
distinct city,
branch
 from walmartsales;
 ----------------------------------------------------------------------------------------------------------------------------------------------
--------------------------How many unique product lines does the data have?

select 
count(distinct product_line)
 from walmartsales;
--------------------------What is the most common payment method?

select payment,
count(payment) 
 from walmartsales
 group by payment asc
 ;
 
 --------------------------What is the most selling product line?
 
 select 
 product_line,
 count(product_line) as cnt
 from walmartsales
 group by product_line 
 order by cnt desc;
 
 --------------------------What is the total revenue by month?
 
 select monthname(date),
 sum(total) as total_revenue
 from walmartsales
 group by monthname(date)
 order by total_revenue desc;
 
  --------------------------What month had the largest COGS?
  
 select monthname(date),
 sum(cogs) as lagest_cog
 from walmartsales
 group by monthname(date)
 order by  lagest_cog desc
 ;
 
  --------------------------What product line had the largest revenue?
  select product_line,
 sum(cogs) as lagest_cog
 from walmartsales
 group by monthname(date)
 order by  lagest_cog desc
 ;
 
 --------------------------What product line had the largest revenue?
 
 select product_line,
 sum(total) as largest_revenue
 from walmartsales
 group by product_line
 order by largest_revenue desc
 ;
 
 --------------------------Which city has a largest revenue?
 
  select city,
 sum(total) as largest_revenue
 from walmartsales
 group by city
 order by largest_revenue desc
 ;
 
 --------------------------What product line had the largest vat?
 
 select product_line,
 round(avg(tax_pct)) as avg_tax
 from walmartsales
 group by product_line
 order by avg_tax desc
 ;
 
 -------------------------------------------Which branch sold more products than average product sold?
 select branch,
sum(quantity) as qty
 from walmartsales
 group by branch
 having qty > (select avg(quantity) from walmartsales)
 ;
 
 -------------------------------------------What is the most common product line by gender?
 
 select gender,product_line,
count(gender) as total_count
 from walmartsales
 group by  gender,product_line
;

 -------------------------------------------What is the average rating of each product line?
 
 select product_line,
avg(rating) as avg_rating
 from walmartsales
 group by  product_line
 order by avg_rating desc
;
------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------sales--------------------------------------------------------------------------------------

-------------------Number of sales made in each time of the day per weekday????????????

select time_of_day,
count(*) as total_sales
 from walmartsales
 where day_name='sunday'      
 group by  time_of_day
 order by total_sales desc
;

-------------------Which of the customer types brings the most revenue?????????????
select customer_type,
sum(total) as total_revenue
 from walmartsales
 group by customer_type
 order by total_revenue desc
;

-------------------Which city has the largest tax percent/ VAT (Value Added Tax)?

select city,
avg(tax_pct) as max_tax
 from walmartsales
 group by city
 order by max_tax desc
;

-------------------Which customer type pays the most in VAT?

select customer_type,
avg(tax_pct) as payable_tax
 from walmartsales
 group by customer_type
 order by payable_tax desc
;

------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------customer--------------------------------------------------------------------------------------

-------------------How many unique customer types does the data have??

select
distinct customer_type
 from walmartsales
;

-------------------How many unique payment methods does the data have??

select 
distinct payment
 from walmartsales
;

-------------------What is the most common customer type???

select customer_type,
count(*) as totl_sales
 from walmartsales
 group by customer_type
;


-------------------Which customer type buys the most???

select customer_type,
count(*) as most_sales
 from walmartsales
 group by customer_type
;

-------------------What is the gender of most of the customers????


select gender,
count(*) as most_sales
 from walmartsales
 group by gender desc
;


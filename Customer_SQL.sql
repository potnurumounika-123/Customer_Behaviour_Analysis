---Q1 Display entire customer table 
select * from customer

---Q2 Display entire customer table upto 20 record
select * from customer limit 20

---Q3 Which customers used a discount but still spent more than the average purchase amount?
select customer_id, purchase_amount 
from customer 
where discount_applied = 'Yes' and purchase_amount >= (select AVG(purchase_amount) from customer)

---Q4 Which are Top 5 products with highest average review rating?
select item_purchased, Round(AVG(review_rating :: numeric),2) as "Average Product Rating"
from customer
group by item_purchased
order by AVG(review_rating) desc 
limit 5

---Q5 Compare the average purchase amounts between standard and express shipping?
select shipping_type, Round(AVG(purchase_amount),2)
from customer
where shipping_type in ('Standard','Express')
group by shipping_type

---Q6 Do subcribe customers spend more? 
---compare average spend and total revenue between subcribers and non subcribers?
select subscription_status,
COUNT(customer_id) as total_customers,
ROUND(AVG(purchase_amount),2) as avg_spend,
ROUND(SUM(purchase_amount),2) as total_revenue
from customer
group by subscription_status
order by total_revenue, avg_spend desc

---Q7 Which 5 products have the highest % of percentage of purchases with discounts applied?
select item_purchased,
ROUND(100 * SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END)/COUNT(*),2) as discount_rate
from customer
group by item_purchased
order by discount_rate desc
limit 5

---Q8 Find the top 5 most frequently discounted items based on the percentage of purchases that had a discount applied?
select item_purchased,
ROUND(SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END)/COUNT(*) * 100,2) as discount_rate
from customer
group by item_purchased
order by discount_rate desc
limit 5

---Q9 Are customers who are repeat buyers (more than 5 previous purchased) also likely to subscribe?
select subscription_status,
count(customer_id) as repeat_buyers
from customer
where previous_purchases > 5
group by subscription_status

---Q10 What is the revenue contribution of eacg age group?
select age_group,
SUM(purchase_amount) as total_revenue
from customer
group by age_group
order by total_revenue desc
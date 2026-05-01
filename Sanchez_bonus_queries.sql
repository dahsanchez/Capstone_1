use sample_sales;

-- Bonus Questions 

-- SELECT, Filtering & Sorting

-- Create a list of all transactions that took place on January 15, 2024, sorted by sale amount from
-- highest to lowest.
select *
from
	store_sales
where
	Transaction_Date = '2024-01-15'
order by
	Sale_Amount desc;
    
-- Which transactions had a sale amount greater than $500? Display the transaction date, store ID,
-- product number, and sale amount.
select
	Transaction_Date,
    Store_ID,
    Prod_Num as ProductNumber,
    Sale_Amount
from
	store_sales
where
	Sale_Amount > 500;
    
-- Find all products whose product number begins with the prefix 105250. What category do they
-- belong to?
select 
	Product,
    ProdNum,
    Category
from
	products
join
	inventory_categories
on
	products.Categoryid = inventory_categories.Categoryid
where
	ProdNum like '105250%';
    
-- Aggregation
    
-- What is the total sales revenue across all transactions? What is the average transaction amount?
select
	round(sum(Sale_Amount),2) as TotalRevenue,
    round(avg(Sale_Amount),2) as AvgTransaction
from
	store_sales;

--  How many transactions were recorded for each product category? Which category has the most
-- transactions?
select
	Category,
    count(*) as TotalTransaction
from
	store_sales
join
	products
on
	store_sales.Prod_Num = products.ProdNum
join
	inventory_categories
on
	products.Categoryid = inventory_categories.Categoryid
group by
	Category
order by
	TotalTransaction desc;

-- 6. Which store generated the highest total revenue? Which generated the lowest?
select
	Store_ID,
	round(sum(Sale_Amount),2) as TotalRevenue
from
	store_sales
group by
	store_sales.Store_ID
order by
	TotalRevenue desc;
    
-- 7. What is the total revenue for each category, sorted from highest to lowest?
select
	
-- 8. Which stores had total revenue above $50,000? (Hint: you'll need HAVING.)
-- Joins
-- 9. Find all sales records where the category is either "Textbooks" or "Technology & Accessories."
-- 10. List all transactions where the sale amount was between $100 and $200, and the category was
-- "Textbooks."



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

-- Which store generated the highest total revenue? Which generated the lowest?
select
	Store_ID,
	round(sum(Sale_Amount),2) as TotalRevenue
from
	store_sales
group by
	store_sales.Store_ID
order by
	TotalRevenue desc;
    
-- What is the total revenue for each category, sorted from highest to lowest?
select
	Category,
	round(sum(Sale_Amount),2) as TotalRevenue
from
	store_sales
join
	products
on
	store_sales.Prod_num = products.ProdNum
join
	inventory_categories
on
	products.Categoryid = inventory_categories.Categoryid
group by
	Category
order by
	TotalRevenue desc;

-- Which stores had total revenue above $50,000? (Hint: you'll need HAVING.)
select
	Store_ID,
    round(sum(Sale_Amount),2) as TotalRevenue
from
	store_sales
group by 
	Store_ID
having	
	TotalRevenue > 50000;

-- Joins
-- Find all sales records where the category is either "Textbooks" or "Technology & Accessories."
select
	Transaction_Date,
    Store_ID,
    Sale_Amount,
    Product,
    Category
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
where
	Category in('Technology & Accessories','Textbooks');
	
-- List all transactions where the sale amount was between $100 and $200, and the category was
-- "Textbooks."
select
	Transaction_Date,
    Store_ID,
    Sale_Amount,
    Product,
    Category
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
where
	Category = 'Textbooks' and Sale_Amount between 100 and 200;
    
-- Write a query that displays each store's total sales along with the city and state where that store is located.
select
    Store_ID,
    StoreLocation as City,
    State,
    round(sum(Sale_Amount),2) as TotalSales
from 
	store_sales
join
	store_locations
on
	store_sales.Store_ID = store_locations.StoreId
group by
	Store_ID,
    City, 
    State;
    
-- For each sale, display the transaction date, sale amount, city, state, and the name of the store
-- manager responsible for that state.
select
	Transaction_Date,
    Sale_Amount,
    StoreLocation as City,
    store_locations.State,
    SalesManager
from
	store_sales
join
	store_locations
on
	store_sales.Store_ID = store_locations.StoreId
join
	management
on
	store_locations.State = management.State;
    
-- Write a query that shows total sales by region. Which region generates the most revenue?
select
	round(sum(Sale_Amount),2) as TotalSales,
    Region
from
	store_sales
join
	store_locations
on
	store_sales.Store_ID = store_locations.StoreId
join
	management
on
	store_locations.State = management.State
group by
	Region
order by
	TotalSales desc;

-- For states that have a preferred shipper listed in Shipper_List, show the total sales alongside the
-- preferred shipper and volume discount.
select
	State,
    PreferredShipper,
    VolumeDiscount,
    round(sum(Sale_Amount),2) as TotalSales
from
	store_sales
join
	store_locations
on 
	store_sales.Store_ID = store_locations.StoreId
join
	shipper_list
on
	store_locations.State = shipper_list.ShiptoState
group by
	State,
    PreferredShipper,
    VolumeDiscount;

-- Are there any states with sales data that do not appear in Shipper_List?
-- States with sales data that do not appear in the shipper list
select 
distinct store_locations.State
from
    store_sales
join
    store_locations
on
    store_sales.Store_ID = store_locations.StoreId
left join
    shipper_list
on
    store_locations.State = shipper_list.ShiptoState
where
    shipper_list.ShiptoState is null;

-- Display total revenue by regional director.
select
	Region,
    RegionalDirector,
    round(sum(Sale_Amount),2) as TotalRevenue
from
	store_sales
join
	store_locations
on
	store_sales.Store_ID = store_locations.StoreId
join
	management
on
	store_locations.State = management.State
group by
	Region,
    RegionalDirector;
    
		
	
    

	
	



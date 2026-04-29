# The sales territory I have is South Carolina, This analysis is only for South Carolina

use sample_sales;

select * from management; -- To see what territory i am analyzing; South Carolina
select * from store_locations;  --  Find my terriory storeids; 852-Charleston, 853-Greenville

-- Total revenue of both store in South Carolina
select  								
	min(Transaction_Date) as StartDate,		-- Earliest transaction date
    max(Transaction_Date) as EndDate,		-- Lastest transaction date
    round(sum(Sale_Amount),2) as TotalRevenue	-- total sales amount rounded to 2 decimal places
from 
	store_sales
where
	Store_ID in(852,853);		-- my two stores in South Carolina
    
-- Month by Month Revenue for South Carolina
select								
	year(Transaction_Date) as Year,		-- Get transaction by year
    month(Transaction_Date) as Month,	-- Get transaction by month
	round(sum(Sale_Amount),2) as MonthlyRevenue		-- Total sales amount round to 2 decimal places
from
	store_sales
where
	Store_ID in(852,853)		-- My two stores in South Carolina
group by
	year(Transaction_Date),		-- Starts with year
    month(Transaction_Date)		-- then goes to months of that year
order by
	year asc; -- Earliest transaction year is shown first
    
-- Total revenue comparason for South Carolina an the whole South region
select									
    sum(Sale_Amount) as RegionRevenue,		-- Total sales revenue for all of the South Region
	(select		-- Total sales revenue for South Carolina
		sum(Sale_Amount)
	from 
			store_sales
	join 
		store_locations 
	on 
		store_sales.Store_ID = store_locations.StoreId
	where
		State = 'South Carolina'
    ) 
as TerritoryRevenue
from
	store_sales
join 		-- To get sales data for whole south region
	store_locations 
on 
	store_sales.Store_ID = store_locations.StoreId
where		-- states in the South region
	State in('Florida','Texas','South Carolina');
    
-- Number of transactions by month,avg transaction size by product category
select										
	year(Transaction_Date) as SalesYear,	-- Sales by year
    month(Transaction_Date) as SalesMonth,	-- Sales by month
	Category as ProductCategory,		
    round(avg(Sale_Amount),2) as AvgTransactionSize,		-- Total avg sale roundd to 2 decimal places
    Count(*) as TransactionCount		-- total transactions
	from
		store_sales
	join		-- to get product information
		products
	on
		store_sales.Prod_Num = products.ProdNum
	join		-- To get category information
		inventory_categories
	on 
		products.Categoryid = inventory_categories.Categoryid
	where		-- My two stores in South Carolina
		store_sales.Store_ID in(852,853)
	group by		-- have all the years, months, and product categories togther in the table
		year(Transaction_Date),
		month(Transaction_Date),
        Category
	order by		-- to show the sales by earliest date
		SalesYear,
        SalesMonth,
        ProductCategory;
        
-- Compare total sales from both stores in South Carolina
select	
	sum(Sale_Amount) as TotalSales, -- add up sales totals
    Store_ID
from
	store_sales
where
	store_sales.Store_ID in(852,853) -- limit to my stores
group by
	store_sales.Store_ID -- separate by store id
order by
	TotalSales desc; -- show the largest total first
    
--  What is your recommendation for where to focus sales attention in the next quarter?
  /* My recommendations for where to focus sales attention for the next quarter is to focus on stationery and supplies sales.
  Overall the sales in that product category are low, even though that category has the highest number of transactions. We could offer more advertising for our stationery and supplies, as well as hold promotions for that category. The Greenville store brought in $25,191.44 more in revenue then Charleston store. We can doo more advertising for the Charleston store to bring in more customers. */
  
    

	









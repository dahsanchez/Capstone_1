# The sales territory I have is South Carolina, This analysis is only for South Carolina

use sample_sales;

select * from management; -- To see what territory i am analyzing; South Carolina
select * from store_locations;  --  Find my terriory storeids; 852-Charleston, 853-Greenville

select  								-- Total revenue in both store in South Carolina
	min(Transaction_Date) as StartDate,
    max(Transaction_Date) as EndDate,
    round(sum(Sale_Amount),2) as TotalRevenue
from 
	store_sales
where
	Store_ID = 852 or Store_ID = 853;
    

select								-- Month by Month Revenue for South Carolina
	year(Transaction_Date) as Year,
    month(Transaction_Date) as Month,
	round(sum(Sale_Amount),2) as MonthlyRevenue
from
	store_sales
where
	Store_ID = 852 or Store_ID = 853
group by
	year(Transaction_Date),
    month(Transaction_Date)
order by
	year asc;
    

select									-- Total revenue comparason for South Carolina an the whole South region
    sum(Sale_Amount) as RegionRevenue,
	(select
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
join 
	store_locations 
on 
	store_sales.Store_ID = store_locations.StoreId
where
	State in('Florida','Texas','South Carolina');
    
--  What is the number of transactions per month and average transaction size by product category
-- for the sales territory?
    
  

    

	









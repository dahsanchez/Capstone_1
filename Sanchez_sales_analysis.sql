# The sales territory I have is South Carolina, This analysis is only for South Carolina

use sample_sales;

select * from management; -- To see what territory i am analyzing; South Carolina
select * from store_locations;  --  Find my terriory storeids; 852-Charleston, 853-Greenville

-- What is total revenue overall for sales in the assigned territory, plus the start date and end date
-- that tell you what period the data covers?

select  		-- all in store sales for both stores
	min(Transaction_Date) as StartDate,
    max(Transaction_Date) as EndDate,
    round(sum(Sale_Amount),2) as TotalRevenue
from 
	store_sales
where
	Store_ID = 852 or Store_ID = 853;
    
-- What is the month by month revenue breakdown for the sales territory?

select
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
    
-- Provide a comparison of total revenue for the specific sales territory and the region it belongs to.
select * 
from
	store_locations
where
	State 
    

	









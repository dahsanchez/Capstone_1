# The sales territory I have is South Carolina, This analysis is only for South Carolina

use sample_sales;

select * from management; -- To see what territory i am analyzing; South Carolina
select * from store_locations; --  Find my terriory storeids; 852-Charleston, 853-Greenville

-- What is total revenue overall for sales in the assigned territory, plus the start date and end date
-- that tell you what period the data covers?

select * from store_sales -- all in store sales for both stores
where
	Store_ID = 852 or Store_ID = 853
order by
	Transaction_Date asc;





SELECT "Date","Ticker","Open","High","Low","Close","Volume",
        AVG("Close") over (Partition by "Ticker"
						   order by "Date"
						 rows between 1 following 
						 and 30 following) as "CloseOver30",
	   AVG("Volume") over (Partition by "Ticker"
						   order by "Date"
						 rows between 1 following 
						 and 30 following) as "VolumeOver30",
	   AVG("Close") over (Partition by "Ticker"
						   order by "Date"
						 rows between 1 following 
						 and 60 following) as "CloseOver60",
	   AVG("Volume") over (Partition by "Ticker"
						   order by "Date" 
						 rows between 1 following 
						 and 60 following) as "VolumeOver60",
	   AVG("Close") over (Partition by "Ticker"
						   order by "Date"
						 rows between 1 following 
						 and 90 following) as "CloseOver90",
	   AVG("Volume") over (Partition by "Ticker"
						   order by "Date" 
						 rows between 1 following 
						 and 90 following) as "VolumeOver90"
into new_table
From stock_history;
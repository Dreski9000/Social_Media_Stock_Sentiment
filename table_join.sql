--SELECT * FROM stock_prices LIMIT 1000;
--SELECT * FROM comments LIMIT 1000;
--SELECT * FROM sentiment LIMIT 1000;
--DROP TABLE IF EXISTS sentiment;

--SELECT COUNT(*) FROM comments;

SELECT
	sent.*,
	sp.*
FROM sentiment sent
INNER JOIN stock_prices sp
ON (sent.ticker = sp.Ticker AND sent.date = sp.Date)
LIMIT 100000
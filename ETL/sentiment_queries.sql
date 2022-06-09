SELECT * FROM stock_prices LIMIT 1000;
SELECT * FROM comments LIMIT 1000;
SELECT * FROM sentiment LIMIT 1000;
DROP TABLE IF EXISTS sentiment;

SELECT COUNT(*) FROM comments;

SELECT
	sent.*,
	sp.*
FROM sentiment sent
INNER JOIN stock_prices sp
ON (sent.ticker = sp.Ticker AND sent.date = sp.Date)
LIMIT 100000
SELECT
	pg_typeof(date)
FROM sentiment
LIMIT 1

SELECT 
	EXTRACT (YEAR FROM date),
	EXTRCT (MONTH FROM date),
 	date, 
	ticker,
 	COUNT (DISTINCT comment_id)
	AVG (overall_sent_comp) as avg_comp_sentiment,
	AVG(mean_t_comp_score) as avg_t_comp_sent,
	AVG(mean_tgt_comp_score) as avg_tgt_comp_score,
	AVG(mean_custom_score) as avg_custom_score
FROM sentiment
GROUP BY 1,2,3
ORDER BY 1,2,3

SELECT
	CASE
		WHEN overall_sent_comp < -0.1 THEN '<= -0.1'
		WHEN overall_sent_comp <= -0.25 THEN '<= -0.25'
		WHEN overall_sent_comp <= -0.5 THEN ' <= -0.5 TRS'
		WHEN overall_sent_comp <= -0.75 THEN '<= -0.75 TRS'
		WHEN overall_sent_comp <= 0 THEN '<= 0 TRS'
		WHEN overall_sent_comp <= 0.25 THEN '<= 0.35 TRS'
		WHEN overall_sent_comp <= 0.5 THEN '<= 0.5 TRS'
		WHEN overall_sent_comp <= 0.75 THEN '<= 0.75 TRS'
		ELSE '>0.75 TRS'
	END as overall_comp_trs,
	CASE
		WHEN mean_t_comp_score < -0.1 THEN '<= -0.1'
		WHEN mean_t_comp_score <= -0.25 THEN '<= -0.25'
		WHEN mean_t_comp_score <= -0.5 THEN ' <= -0.5 TRS'
		WHEN mean_t_comp_score <= -0.75 THEN '<= -0.75 TRS'
		WHEN mean_t_comp_score <= 0 THEN '<= 0 TRS'
		WHEN mean_t_comp_score <= 0.25 THEN '<= 0.35 TRS'
		WHEN mean_t_comp_score <= 0.5 THEN '<= 0.5 TRS'
		WHEN mean_t_comp_score <= 0.75 THEN '<= 0.75 TRS'
		ELSE '>0.75 TRS'
	END as mean_t_comp_trs,
	CASE
		WHEN mean_tgt_comp_score < -0.1 THEN '<= -0.1'
		WHEN mean_tgt_comp_score <= -0.25 THEN '<= -0.25'
		WHEN mean_tgt_comp_score <= -0.5 THEN ' <= -0.5 TRS'
		WHEN mean_tgt_comp_score <= -0.75 THEN '<= -0.75 TRS'
		WHEN mean_tgt_comp_score <= 0 THEN '<= 0 TRS'
		WHEN mean_tgt_comp_score <= 0.25 THEN '<= 0.35 TRS'
		WHEN mean_tgt_comp_score <= 0.5 THEN '<= 0.5 TRS'
		WHEN mean_tgt_comp_score <= 0.75 THEN '<= 0.75 TRS'
		ELSE '>0.75 TRS'
	END as mean_tgt_comp_trs,
	CASE
		WHEN mean_custom_score < -0.1 THEN '<= -0.1'
		WHEN mean_custom_score <= -0.25 THEN '<= -0.25'
		WHEN mean_custom_score <= -0.5 THEN ' <= -0.5 TRS'
		WHEN mean_custom_score <= -0.75 THEN '<= -0.75 TRS'
		WHEN mean_custom_score <= 0 THEN '<= 0 TRS'
		WHEN mean_custom_score <= 0.25 THEN '<= 0.35 TRS'
		WHEN mean_custom_score <= 0.5 THEN '<= 0.5 TRS'
		WHEN mean_custom_score <= 0.75 THEN '<= 0.75 TRS'
		ELSE '>0.75 TRS'
	END as mean_custom_score,
	COUNT(comment_id)
FROM sentiment
GROUP BY 1
	

SELECT "Close" FROM stock_prices

SELECT *
INTO sentiment_filtered
FROM sentiment
WHERE ticker in ('AAPL','AI','AMD','AMZN','BA','BABA','DIS','DOW','FB',
'GOOG','MSFT','NFLX','NVDA','RE','SPCE','SQ','TA','TD','TIL','TSLA') 
AND ABS(mean_tgt_comp_score) >= 0.4 
		
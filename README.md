# Social_Media_Stock_Sentiment
Does social media sentiment have predictive value in future stock prices?

Can we predict future price trends for stock tickers based on social media buzz?
  * Can NLP social media sentiment predict stock trend movement for the next (28 days, 60 days, 90 days)?
  * Do variations of comment volumes for certain tickets have predictive value on future price trends or trading volume?

## Overview

### Data Source Description
   * Text data from Reddit comments (scraped primarily from r/Wallstreetbets)
      * Future versions to include r/Stocks and other related subreddits.
   * Daily Stock Price Data (pulled via yahoo finance API)
      * Date Range : 01/01/2018 - 12/31/2021

**Project Tracking**
    
*  [Google Sheets (Main Project Tracker w/ grading rubric)](https://docs.google.com/spreadsheets/d/1JCo-vFEugonDY_eLBWxoHMpitbmhl6kYNvJa8xVJeWE/edit?usp=sharing)

### Project Outline
   * Determine set of Tickers for Analysis:
      * Set determined by trending list on apewisdom.io on May 16, 2022. Some values such as ETFs were removed for    consistency. Set available to view on stock-sentiment-etl.ipynb
   * Scrape comment data for analysis
      * Extracted via PushiftAPI (psaw Python module)
   * ETL Process
      * Scraper -> CSV Files -> AWS RD -> Local Postgres DB (via SQLAlchemy)
      * Relevant files: Reddit_Scraper.ipynb, reddit_text_etl.ipynb,  stock_history_etl.ipynb, rds_schema
   * Data Prep
      * NLP Sentiment scores via SentimentIntenistyAnalyzer, Vader (NLTK module); custom scores and additional features
      * Relevant files: stock_sentiment_etl.ipynb
   * Machine Learning & Classifiers
      * Deep Neural Network
      * [Future]: Gradient Boost, Random Forest, Bag of Words
      * What are we trying to predict?
          - Average Price over (N28d, N60d N90d)
          - Binary classification: does the price move up or down?
          - Do changes in volume count per stock have predictive value on price or trading volume? 
      * Relevant Files: social_stocks_ml1.ipynb
   * Database Schemas
      * Table: comments
        * Columns: comment_id (INT), date (DATE), body (TEXT), username (VARCHAR), subreddit (VARCHAR)
      * Table: stock_prices
        * Columns: Ticker (VARCHAR), Date (DATE), Volume (DOUBLE), Open (DOUBLE), Close (Double), High (Double), Low  (Double)
      * Table: sentiment
        * Columns: comment_id (INT), ticker (VARCHAR), date (DATE), username (VARCHAR), subreddit (VARCHAR), body (TEXT), overall_sent_comp (DOUBLE), overall_sent_pos (DOUBLE), overall_sent_neg (DOUBLE), mean_t_comp_score (DOUBLE), mean_t_neg_score (DOUBLE), mean_tgt_comp_score (DOUBLE), mean_tgt_pos_score (DOUBLE), mean_tgt_neg_score (DOUBLE), verb_tense (VARCHAR), mean_custom_score (DOUBLE)
  
### Dashboard (link)
   * [*TABLEAU*](https://public.tableau.com/app/profile/helena.claybrook/viz/StockSentimentsv2/Dashboard1?publish=yes)

### Presentation (link)
* [*Social Media Sentiment Analysis*](https://docs.google.com/presentation/d/1Xe5wgTKFCUUx9honSPuoJNbzzv6wYgwGQHg37Fkk51k/edit?usp=sharing)

### Prediction Model Results 
  * *Classifier X Date Range Matrix*


|                     |    Avg Price N30d   |    Avg Price N60d   |    Avg Price N90d   |
| ------------------- | ------------------- | ------------------- | ------------------- |
| Logistic Regression |         58%         |         50%         |          50%        |
| Random Forest       |         65%         |         61%         |          61%        |
| Ada Boost           |         59%         |         54%         |          52%        |
| Deep Network        |         60%         |         59%         |          64%        |  


### Visualizations
![Sentiment vs Closing Price](https://raw.githubusercontent.com/Dreski9000/Social_Media_Stock_Sentiment/main/Visualization/overallsentimentbyclosingprice.png)

![Comments by Volume Heatmap](https://raw.githubusercontent.com/Dreski9000/Social_Media_Stock_Sentiment/main/Visualization/monthlycommentsbyvolume.png)

![Comment Volume vs Trading Volume](https://raw.githubusercontent.com/Dreski9000/Social_Media_Stock_Sentiment/main/Visualization/%24oftotalvolumevstotalcount.png)

### Lessons and Challenges
* *NLP is Hard*
 - Sentiment classifier could potentially be improved by manual labelling and statistical analysis.
* *Bigger Data is Better*
 - Expanding the data set to other subreddits and social media platforms could strengthen our analysis.
* *More Features, More Problems*
 - Having more features does not necessarily make a classifier better.
 - Our classifier scores improved by trimming features.
* *Wax On, Wax Off*
 - Gathering and sanitizing data accounts for 90% of the effort behind this project.
 - Good data has more impact than advanced algos.

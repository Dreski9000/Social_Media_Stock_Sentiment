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
      * Date Range : 01/01/2018 - 05/01/2022

### Communication Protocols

**Project Tracking**
    
*  [Google Sheets (Main Project Tracker w/ grading rubric)](https://docs.google.com/spreadsheets/d/1JCo-vFEugonDY_eLBWxoHMpitbmhl6kYNvJa8xVJeWE/edit?usp=sharing)

**Brainstorming / Idea Organizing**
   
   * Weekly Meetings (2 -3) based on need

   * Google Docs Brainstorming Document



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
   * *PLANNED*
   * [Storyboard via Slides](https://docs.google.com/presentation/d/1Xe5wgTKFCUUx9honSPuoJNbzzv6wYgwGQHg37Fkk51k/edit#slide=id.g12f93bee036_1_0)

### Presentation (link)
* [*IN PROGRESS*](https://docs.google.com/presentation/d/1Xe5wgTKFCUUx9honSPuoJNbzzv6wYgwGQHg37Fkk51k/edit?usp=sharing)

# Yelp_Business_review_analysis

# 📊 Yelp Business Review Analysis

An end-to-end data analytics project that processes, transforms, and analyzes customer reviews from the Yelp Academic Dataset using Python, Snowflake, SQL, and AWS S3. The goal is to extract insights on customer sentiment and business performance.

##  Tools & Technologies Used

- Python (Jupyter Notebook) – Data preprocessing & JSON splitting
- Snowflake – Cloud data warehouse for storage and transformation
- AWS S3 – Temporary storage for large JSON file uploads
- SQL – Data extraction, transformation, and sentiment analysis

- 
---

## 🔍 Project Workflow

### 1. Data Preprocessing
- Loaded a large Yelp review dataset (~6.9M records) in JSON format.
- Used Python to split the large file into smaller chunks for easy handling and S3 upload.

### 2. Cloud Data Loading
- Uploaded the split JSON files to an **AWS S3 bucket**.
- Used `COPY INTO` commands in Snowflake to import JSON data into a staging table with a `VARIANT` column.

### 3. Data Transformation
- Parsed key fields (`business_id`, `user_id`, `stars`, `text`, `date`) from the JSON column.
- Casted them into appropriate data types.
- Created a new structured table (`table_yelp_reviews`) for querying.

### 4. Sentiment Analysis
- Applied `analyze_sentiment()` on review text to extract sentiment scores directly in SQL.

##  Key Takeaways

- Managed large, semi-structured datasets using Python and SQL.
- Integrated Snowflake with AWS S3 for scalable data processing.
- Applied SQL-based NLP (sentiment analysis) within a cloud data warehouse.
- Demonstrated end-to-end skills: ETL, data cleaning, transformation, and analytics.




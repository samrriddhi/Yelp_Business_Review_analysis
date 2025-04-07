//10 questions of SQL


//  1) Find the no. of businesses in each category.

with cte as(
SELECT 
  business_id,
  trim(A.VALUE) AS category
FROM 
  table_yelp_businesses,
  LATERAL SPLIT_TO_TABLE(categories, ',') A
)
select category,count(*) as No_of_businesses
from cte
group by 1
order by 2 desc

//  2) Find the top 10 users who have reviewed the most  businesses in the 'Restaurants'  category .

SELECT 
  r.user_id,
  COUNT(DISTINCT b.business_id) AS restaurant_review_count
FROM 
  table_yelp_reviews r
JOIN 
  table_yelp_businesses b 
  ON r.business_id = b.business_id
WHERE 
  b.categories ILIKE '%Restaurants%'
GROUP BY 
  r.user_id
ORDER BY 
  restaurant_review_count DESC;

LIMIT 10;

//   3)Find the most popular categories of businesses based on reviews

WITH cte AS (
  SELECT 
    business_id,
    TRIM(A.VALUE) AS category
  FROM 
    table_yelp_businesses,
    LATERAL SPLIT_TO_TABLE(categories, ',') A
  WHERE categories IS NOT NULL
)
SELECT 
  category,
  COUNT(*) AS no_of_reviews
FROM 
  cte
JOIN 
  table_yelp_reviews r ON cte.business_id = r.business_id
GROUP BY 
  category
ORDER BY 
  no_of_reviews DESC;

//  4) Find the top 3 most recent reviews for each businesses

with cte as( 
select r.* , b.name,
row_number() over (partition by r.business_id order by review_date desc) as rn
from
table_yelp_reviews r
inner join table_yelp_businesses b on  r.business_id = b.business_id
)
select * from cte
where rn<=3


//  5)Find the month with the highest no.of reviews.

select month(review_date) as review_month ,count(*) as no_of_reviews 
from table_yelp_reviews
group by 1
order by 2 desc

//  6)Find the percentage of 5-star reviews for each busniness

select b.BUSINESS_ID,b.name,count(*) as total_reviews,
sum(case when r.review_star=5 then 1 else 0 end)as star_reviews_5,
star_reviews_5*100/total_reviews as percentage
from table_yelp_reviews r 
inner join table_yelp_businesses b on r.business_id=b.business_id
group by 1,2


//  7)Find the top 5 most reviewed businesses in each city

with cte as(
select b.city,b.business_id,b.name,count(*) as total_reviews,
from table_yelp_reviews r
inner join table_yelp_businesses b on r.business_id=b.business_id
group by 1,2,3
)

select * from cte 
qualify row_number() over (partition by city order by total_reviews desc) <=5


//  8)Find the average rating of businesses that have atleast 100 reviews

select b.BUSINESS_ID,b.name,count(*) as total_reviews,
avg(r.review_star) as avg_review_rating
from table_yelp_reviews r 
inner join table_yelp_businesses b on r.business_id=b.business_id
group by 1,2
having count(*) >=100


//  9) Find the top 10 users who have written the most reviews along with the name of the businesses they reviewed.
with cte as (
select r.user_id,count(*) as total_reviews,
from table_yelp_reviews r 
inner join table_yelp_businesses b on r.business_id=b.business_id
group by 1
order by 2 desc
limit 10
)
select user_id,business_id from table_yelp_reviews where user_id in (select user_id from cte)
group by 1,2
order by user_id
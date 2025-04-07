CREATE OR REPLACE TABLE reviews (
    review VARCHAR(200)
);

INSERT INTO reviews VALUES ('The food was amazing and the service was excellent!');
INSERT INTO reviews VALUES ('The place was okay, nothing special.');
INSERT INTO reviews VALUES ('Terrible experience. I will never come back.');
INSERT INTO reviews VALUES ('Had a great time with friends, really enjoyed it!');
INSERT INTO reviews VALUES ('It was just average, not bad but not great either.');
INSERT INTO reviews VALUES ('The staff was rude and the food was cold.');

CREATE OR REPLACE FUNCTION analyze_sentiment(text STRING)
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.8'
PACKAGES = ('textblob')
HANDLER = 'sentiment_analyzer'
AS
$$
from textblob import TextBlob

def sentiment_analyzer(text):
    analysis = TextBlob(text)
    polarity = analysis.sentiment.polarity
    if polarity > 0:
        return 'Positive'
    elif polarity == 0:
        return 'Neutral'
    else:
        return 'Negative'
$$;

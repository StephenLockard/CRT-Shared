import re
import nltk
from nltk.sentiment import SentimentIntensityAnalyzer
from robot.api.deco import keyword

class SentimentAnalysis:
    def __init__(self):
        nltk.download('vader_lexicon', quiet=True)
        self.sia = SentimentIntensityAnalyzer()

    def analyze_sentiment(self, text):
        sentiment_score = self.sia.polarity_scores(text)['compound']
        return sentiment_score

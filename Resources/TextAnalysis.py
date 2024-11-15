import re
import nltk
from nltk.sentiment import SentimentIntensityAnalyzer
from robot.api.deco import keyword

class SentimentAnalysis:
    def __init__(self):
        nltk.download('vader_lexicon', quiet=True)
        self.sia = SentimentIntensityAnalyzer()
        self.affirmative_patterns = [
            r'\byes\b', r'\byeah\b', r'\byep\b', r'\bsure\b', r'\bcorrect\b', 
            r'\baffirmative\b', r'\bindeed\b', r'\bagreed\b', r'\bconfirm\b'
        ]
        self.negative_patterns = [
            r'\bno\b', r'\bnope\b', r'\bnah\b', r'\bincorrect\b', r'\bnegative\b', 
            r'\bdisagree\b', r'\bdeny\b', r'\brefuse\b', r'\breject\b'
        ]

    def analyze_sentiment(self, text):
        sentiment_score = self.sia.polarity_scores(text)['compound']
        return sentiment_score

    def classify_response(self, text):
        text = text.lower()
        
        for pattern in self.affirmative_patterns:
            if re.search(pattern, text):
                return "Affirmative"
        
        for pattern in self.negative_patterns:
            if re.search(pattern, text):
                return "Negative"
        
        return "Unclear"
# 🎭 Sentiment Analysis of YouTube Short Drama Reviews

<p align="center">
  <img src="plots/youtube_header.png" alt="Drama Screenshot" width="35%">
</p>

[![R](https://img.shields.io/badge/R-4.3.1-blue.svg)](https://www.r-project.org/)  
[![Tidyverse](https://img.shields.io/badge/Libraries-Tidyverse%20%7C%20ggplot2-green)](https://www.tidyverse.org/)  
[![Sentiment](https://img.shields.io/badge/Sentiment-Bing%20%7C%20AFINN%20%7C%20NRC%20%7C%20Syuzhet-red)](https://cran.r-project.org/web/packages/syuzhet/)  
[![Platform](https://img.shields.io/badge/Platform-RStudio-orange.svg)](https://posit.co/)  

---

## 📌 Overview

This project analyzes **audience comments** on a popular YouTube short Chinese drama:  
**“Rural girl was forced to marry a poor boy, didn't expect he was CEO and fell in love with her!”** (uploaded by **KIKI SHORTDRAMA**, duration 1h46m).  

Using **lexicon-based sentiment analysis**, this project uncovers how viewers emotionally responded to the drama and what common expressions dominate the reviews.  

**Dataset:** Collected with *Comment Exporter for YouTube* (CSV format) extension from Google with version 0.0.4.3.  
**Attributes available:** Author, Content, Link (only **Content** was used).  

---

## 🧰 Methodology

- **Preprocessing**:  
  - Replaced common emojis with words (e.g., ❤ → love, 😂 → funny).  
  - Removed other emojis via Unicode ranges, stripped numbers/punctuation, lowercased text.  
  - Filtered missing values.  

- **Tokenization & Stopword Removal**: Used `tidytext` stopwords.  

- **Sentiment Analysis Tools**:  
  - **Bing** → Positive vs Negative classification.  
  - **AFINN** → Numeric sentiment scores (-5 to +5).  
  - **NRC** → Emotion classification (Joy, Trust, Anger, Sadness, etc.).  
  - **Syuzhet** → Sentiment trajectory over comments.  

---

## 📊 Results & Discussion

### 🔠 1. Frequent Words

- **“Love”** was the most frequent (227 mentions), reflecting strong emotional connection.  
- Other common words: *movie, drama, story, nice, kiss* and character names (*Claire, Shea*).  
- Suggests viewers were engaged with both **plot** and **characters**.  

<p align="center">
  <img src="plots/Top_10_Most Frequent_Words_in_Reviews.png" alt="Top 10 Frequent Words" width="500"/>
</p>

---

### 😀 2. Bing Lexicon (Positive vs Negative)

- **Positive words:** 609  
- **Negative words:** 320  
- Audience response was **overwhelmingly positive**.  

Most common positives: *love, nice, beautiful, lovely*  
Negatives (less frequent): *stupid, annoying, bad*  

> ⚠️ Note: “Funny” was misclassified as negative by Bing, showing a limitation of rigid lexicons.

<p align="center">
  <img src="plots/Top_Sentiment_Words_in_YouTube_Drama_Reviews.png" alt="Bing Sentiment Plot" width="600"/>
</p>

---

### 📈 3. AFINN Scores

- **Mean:** 1.55 (moderately positive)  
- **Std Dev:** 2.26 (variation across reviews)  

Interpretation: While most viewers expressed **enjoyment**, some provided **criticism**, leading to sentiment diversity.  

---

### ❤️ 4. NRC Emotion Classification

- **Joy** was most dominant (518 mentions), followed by **Trust** (273) and **Anticipation** (249).  
- Negative emotions (*sadness, fear, anger, disgust*) also appeared, reflecting **drama-like highs and lows**.  

<p align="center">
  <img src="plots/Emotion_Classification_in_YouTube_Reviews.png" alt="NRC Emotions" width="600"/>
</p>

---

### 📉 5. Syuzhet Sentiment Trajectory

- **Average score:** 0.49 (slightly positive).  
- Fluctuations show **emotional ups and downs**, mirroring the drama’s storyline.  
- Early reviewers were more **positive** compared to later ones.  

<p align="center">
  <img src="plots/Sentiment_Trajectory_(Syuzhet).png" alt="Sentiment Trajectory" width="600"/>
</p>

---

## ✅ Conclusion

- Viewers reacted **positively** to the drama, with *love* being the most frequent keyword.  
- **Bing, AFINN, and Syuzhet** confirmed an overall **positive tone**.  
- **NRC analysis** revealed emotional depth: joy, trust, anticipation, but also sadness and anger.  
- Shows the **emotional richness of short dramas** and how viewers connect through both admiration and critique.  

---

## 👨‍🎓 Author  

**Azrul Zulhilmi Ahmad Rosli**  

---

## 📜 License  

This project is for academic purposes.  
Data source: [YouTube - KIKI SHORT DRAMA](https://www.youtube.com/watch?v=yDOzuBrOdRo&ab_channel=KIKISHORTDRAMA).  

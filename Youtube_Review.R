# ================================
# SENTIMENT ANALYSIS SCRIPT (YouTube Short Drama Reviews)
# ================================

# youtube: https://www.youtube.com/watch?v=yDOzuBrOdRo&ab_channel=KIKISHORTDRAMA
# --------- Install Required Packages ---------
library(tidyverse)
library(tidytext)
library(textdata)
library(ggplot2)
library(wordcloud)
library(stringr)

# --------- Step 1: Read CSV (Only Use 'Content' Column) ---------
reviews_raw <- read.csv("youtube_reviews.csv", sep = ";", stringsAsFactors = FALSE)
reviews_clean <- reviews_raw %>%
  select(Content) %>%
  rename(text = Content)

reviews_clean <- reviews_clean %>%
  filter(!is.na(text))


# --------- Step 2: Translate Known Emojis to Words ---------
emoji_dict <- c(
  "❤" = "love",
  "😂" = "funny",
  "😭" = "cry",
  "😊" = "happy",
  "😢" = "sad",
  "😍" = "lovely",
  "😡" = "angry",
  "👍" = "thumbs_up",
  "🎉" = "celebrate",
  "🔥" = "hot",
  "😎" = "cool"
)

# Translate known emojis
for (emoji in names(emoji_dict)) {
  reviews_clean$text <- str_replace_all(reviews_clean$text, fixed(emoji), emoji_dict[[emoji]])
}

# --------- Step 3: Remove Unclassified Emojis and Clean Text ---------
# Remove remaining emojis (unicode emoji blocks) and non-letters
# Emoji ranges: https://unicode.org/Public/emoji/15.0/emoji-data.txt
reviews_clean$text <- reviews_clean$text %>%
  str_replace_all("[\U0001F600-\U0001F64F]", "") %>%  # emoticons
  str_replace_all("[\U0001F300-\U0001F5FF]", "") %>%  # symbols & pictographs
  str_replace_all("[\U0001F680-\U0001F6FF]", "") %>%  # transport & map
  str_replace_all("[\U0001F1E0-\U0001F1FF]", "") %>%  # flags
  str_replace_all("[^a-zA-Z\\s]", "") %>%            # remove punctuation/numbers
  str_to_lower()

# --------- Step 4: Tokenize and Remove Stopwords ---------
data("stop_words")

reviews_words <- reviews_clean %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

# --------- Step 5: Bing Sentiment Analysis ---------
bing <- get_sentiments("bing")

bing_sentiment <- reviews_words %>%
  inner_join(bing) %>%
  count(word, sentiment, sort = TRUE)

# Plot Top Positive and Negative Words
ggplot(bing_sentiment %>% group_by(sentiment) %>% top_n(10, n) %>% ungroup(),
       aes(x = reorder(word, n), y = n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  coord_flip() +
  labs(title = "Top Sentiment Words in YouTube Drama Reviews",
       x = "Word", y = "Count")

# Total number of positive and negative words in the dataset
bing_total <- bing_sentiment %>%
  group_by(sentiment) %>%
  summarise(total = sum(n)) %>%
  arrange(desc(total))

print(bing_total)

# --------- Step 6: AFINN Sentiment Scores ---------
afinn <- get_sentiments("afinn")

afinn_score <- reviews_words %>%
  inner_join(afinn) %>%
  summarise(mean_score = mean(value), sd_score = sd(value))

print("AFINN Score Summary:")
print(afinn_score)

# --------- Step 7: NRC Emotion Classification ---------
nrc <- get_sentiments("nrc") %>%
  filter(!sentiment %in% c("positive", "negative"))

nrc_emotions <- reviews_words %>%
  inner_join(nrc) %>%
  count(sentiment, sort = TRUE)

# Plot Emotion Distribution
ggplot(nrc_emotions, aes(x = reorder(sentiment, n), y = n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  labs(title = "Emotion Classification in YouTube Reviews",
       x = "Emotion", y = "Count")

# --------- Step 8: Word Cloud ---------
reviews_words %>%
  count(word, sort = TRUE) %>%
  with(wordcloud(words = word, freq = n, max.words = 100, colors = brewer.pal(8, "Dark2")))

# --------- Step 9: Syuzhet Sentiment Scores ---------
syuzhet_scores <- get_sentiment(reviews_clean$text, method = "syuzhet")
reviews_clean$syuzhet_score <- syuzhet_scores

# Print average sentiment score
cat("Mean Syuzhet Sentiment Score:\n")
print(mean(syuzhet_scores))

# Optional: Plot Sentiment Trajectory
plot(syuzhet_scores, type = "l",
     main = "Sentiment Trajectory (Syuzhet)",
     xlab = "Review Index", ylab = "Sentiment Score")
abline(h = 0, col = "red")

# --------- Top 10 Most Frequent Words ---------
top_words <- reviews_words %>%
  count(word, sort = TRUE) %>%
  top_n(10, n)

print(top_words)

ggplot(top_words, aes(x = reorder(word, n), y = n)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Top 10 Most Frequent Words in Reviews",
       x = "Word", y = "Frequency")

require(twitteR)
require(tm)
require(wordcloud)
require(RColorBrewer)

#Twitter Keys
consumer_key <- '[consumer key from twitter]'
consumer_secret <- '[consumer secret key]'
access_token <- '[Access Token]'
access_secret <- '[Access Secret key]'

setup_twitter_oauth(consumer_key,consumer_secret,access_token,access_secret)

#Get the top trendsin twitter(Worldwide)
trend <- getTrends(1)
tweetname <- trend$name[1]

#Search tweets and save the text
tweets <- searchTwitter(tweetname, lang="en", n=500, resultType = "recent")
tweets_text <- sapply(tweets,function(x) x$getText())

#Data Cleaning in tweet data
tweets_text = gsub('?(f|ht)(tp)(s?)(://)(.*)[.|/](.*)', '', tweets_text)
tweets_text = gsub('[[:punct:]]', '', tweets_text)

#corpus of tweets
tweets_corpus <- Corpus(VectorSource(tweets_text))
tweets_corpus <- tm_map(tweets_corpus, PlainTextDocument)
tweets_corpus <- tm_map(tweets_corpus, removePunctuation)
tweets_corpus <- tm_map(tweets_corpus, content_transformer(tolower))
tweets_corpus <- tm_map(tweets_corpus, removeWords,stopwords("english"))
tweets_corpus <- tm_map(tweets_corpus, removeNumbers)
tweets_corpus <- tm_map(tweets_corpus, stripWhitespace)

#Document Matrix
tweet_matrix <- TermDocumentMatrix(tweets_corpus)
twt_matrix <- as.matrix(tweet_matrix)
t_matrix  <- sort(rowSums(twt_matrix),decreasing = TRUE)
tweet_words <- data.frame(word = names(t_matrix),freq=t_matrix)

#Wordcloud of the tweets
wordcloud(tweet_words$word, random.order = F, freq = tweet_words$freq,max.words = 100,colors = brewer.pal(8,"Dark2"))

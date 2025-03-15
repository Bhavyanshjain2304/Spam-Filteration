sms_raw <- read.csv(file.choose(),sep = ",",header = T,stringsAsFactors = FALSE)
str(sms_raw)
sms_raw$type <- factor(sms_raw$type)
str(sms_raw$type)
table(sms_raw$type)

#install.packages("tm")
# for text mining

library(tm)

sms_corpus <- VCorpus(VectorSource(sms_raw$text))
print(sms_corpus)

inspect(sms_corpus[1:2])
as.character(sms_corpus[[1]]) # to convert from list to character
lapply(sms_corpus[1:2], as.character)
sms_corpus_clean <- tm_map(sms_corpus,content_transformer(tolower))
as.character(sms_corpus[[1]])
as.character(sms_corpus_clean[[1]])
sms_corpus_clean
sms_corpus_clean <- tm_map(sms_corpus_clean, removeNumbers)
sms_corpus_clean <- tm_map(sms_corpus_clean, removeWords,stopwords())
sms_corpus_clean <- tm_map(sms_corpus_clean,removePunctuation)

#install.packages("SnowballC")
library(SnowballC)

wordStem(c("learn","learned","learnt","learning","learns"))
sms_corpus_clean <- tm_map(sms_corpus_clean,stemDocument)
sms_corpus_clean <- tm_map(sms_corpus_clean,stripWhitespace)
sms_dtm <- DocumentTermMatrix(sms_corpus_clean) # dtm makes a table



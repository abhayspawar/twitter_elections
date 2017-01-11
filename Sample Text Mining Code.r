library(rjson)
library(RJSONIO)
library(tm)
library(NLP)
if (Sys.getenv("JAVA_HOME")!="")
  Sys.setenv(JAVA_HOME="")
library(openNLP)
library(RWeka)
library(RWekajars)
library(stringr)


k <-'{
      "text": "RT @PostGradProblem: In preparation for the NFL lockout, I will be spending twice as much time analyzing my fantasy baseball team during ...", 
      "truncated": true, 
      "in_reply_to_user_id": null, 
      "in_reply_to_status_id": null, 
      "favorited": false, 
      "source": "<a href=\"http://twitter.com/\" rel=\"nofollow\">Twitter for iPhone</a>", 
      "in_reply_to_screen_name": null, 
      "in_reply_to_status_id_str": null, 
      "id_str": "54691802283900928", 
      "entities": {
            "user_mentions": [
                  {
                        "indices": [
                              3, 
                              19
                        ], 
                        "screen_name": "PostGradProblem", 
                        "id_str": "271572434", 
                        "name": "PostGradProblems", 
                        "id": 271572434
                  }
            ], 
            "urls": [ ], 
            "hashtags": [ ]
      }, 
      "contributors": null, 
      "retweeted": false, 
      "in_reply_to_user_id_str": null, 
      "place": null, 
      "retweet_count": 4, 
      "created_at": "Sun Apr 03 23:48:36 +0000 2011", 
      "retweeted_status": {
            "text": "In preparation for the NFL lockout, I will be spending twice as much time analyzing my fantasy baseball team during company time. #PGP", 
            "truncated": false, 
            "in_reply_to_user_id": null, 
            "in_reply_to_status_id": null, 
            "favorited": false, 
            "source": "<a href=\"http://www.hootsuite.com\" rel=\"nofollow\">HootSuite</a>", 
            "in_reply_to_screen_name": null, 
            "in_reply_to_status_id_str": null, 
            "id_str": "54640519019642881", 
            "entities": {
                  "user_mentions": [ ], 
                  "urls": [ ], 
                  "hashtags": [
                        {
                              "text": "PGP", 
                              "indices": [
                                    130, 
                                    134
                              ]
                        }
                  ]
            }, 
            "contributors": null, 
            "retweeted": false, 
            "in_reply_to_user_id_str": null, 
            "place": null, 
            "retweet_count": 4, 
            "created_at": "Sun Apr 03 20:24:49 +0000 2011", 
            "user": {
                  "notifications": null, 
                  "profile_use_background_image": true, 
                  "statuses_count": 31, 
                  "profile_background_color": "C0DEED", 
                  "followers_count": 3066, 
                  "profile_image_url": "http://a2.twimg.com/profile_images/1285770264/PGP_normal.jpg", 
                  "listed_count": 6, 
                  "profile_background_image_url": "http://a3.twimg.com/a/1301071706/images/themes/theme1/bg.png", 
                  "description": "", 
                  "screen_name": "PostGradProblem", 
                  "default_profile": true, 
                  "verified": false, 
                  "time_zone": null, 
                  "profile_text_color": "333333", 
                  "is_translator": false, 
                  "profile_sidebar_fill_color": "DDEEF6", 
                  "location": "", 
                  "id_str": "271572434", 
                  "default_profile_image": false, 
                  "profile_background_tile": false, 
                  "lang": "en", 
                  "friends_count": 21, 
                  "protected": false, 
                  "favourites_count": 0, 
                  "created_at": "Thu Mar 24 19:45:44 +0000 2011", 
                  "profile_link_color": "0084B4", 
                  "name": "PostGradProblems", 
                  "show_all_inline_media": false, 
                  "follow_request_sent": null, 
                  "geo_enabled": false, 
                  "profile_sidebar_border_color": "C0DEED", 
                  "url": null, 
                  "id": 271572434, 
                  "contributors_enabled": false, 
                  "following": null, 
                  "utc_offset": null
            }, 
            "id": 54640519019642880, 
            "coordinates": null, 
            "geo": null
      }, 
      "user": {
            "notifications": null, 
            "profile_use_background_image": true, 
            "statuses_count": 351, 
            "profile_background_color": "C0DEED", 
            "followers_count": 48, 
            "profile_image_url": "http://a1.twimg.com/profile_images/455128973/gCsVUnofNqqyd6tdOGevROvko1_500_normal.jpg", 
            "listed_count": 0, 
            "profile_background_image_url": "http://a3.twimg.com/a/1300479984/images/themes/theme1/bg.png", 
            "description": "watcha doin in my waters?", 
            "screen_name": "OldGREG85", 
            "default_profile": true, 
            "verified": false, 
            "time_zone": "Hawaii", 
            "profile_text_color": "333333", 
            "is_translator": false, 
            "profile_sidebar_fill_color": "DDEEF6", 
            "location": "Texas", 
            "id_str": "80177619", 
            "default_profile_image": false, 
            "profile_background_tile": false, 
            "lang": "en", 
            "friends_count": 81, 
            "protected": false, 
            "favourites_count": 0, 
            "created_at": "Tue Oct 06 01:13:17 +0000 2009", 
            "profile_link_color": "0084B4", 
            "name": "GG", 
            "show_all_inline_media": false, 
            "follow_request_sent": null, 
            "geo_enabled": false, 
            "profile_sidebar_border_color": "C0DEED", 
            "url": null, 
            "id": 80177619, 
            "contributors_enabled": false, 
            "following": null, 
            "utc_offset": -36000
      }, 
      "id": 54691802283900930, 
      "coordinates": null, 
      "geo": null
}'

m <-'{
      "text": "RT @PostGradProblem: In preparation for the NFL lockout, I will be spending twice as much time analyzing my fantasy football team during ...", 
      "truncated": true, 
      "in_reply_to_user_id": null, 
      "in_reply_to_status_id": null, 
      "favorited": false, 
      "source": "<a href=\"http://twitter.com/\" rel=\"nofollow\">Twitter for iPhone</a>", 
      "in_reply_to_screen_name": null, 
      "in_reply_to_status_id_str": null, 
      "id_str": "54691802283900929", 
      "entities": {
            "user_mentions": [
                  {
                        "indices": [
                              3, 
                              19
                        ], 
                        "screen_name": "PostGradProblem", 
                        "id_str": "271572434", 
                        "name": "PostGradProblems", 
                        "id": 271572434
                  }
            ], 
            "urls": [ ], 
            "hashtags": [ ]
      }, 
      "contributors": null, 
      "retweeted": false, 
      "in_reply_to_user_id_str": null, 
      "place": null, 
      "retweet_count": 4, 
      "created_at": "Sun Apr 03 23:48:36 +0000 2011", 
      "retweeted_status": {
            "text": "In preparation for the NFL lockout, I will be spending twice as much time analyzing my fantasy baseball team during company time. #PGP", 
            "truncated": false, 
            "in_reply_to_user_id": null, 
            "in_reply_to_status_id": null, 
            "favorited": false, 
            "source": "<a href=\"http://www.hootsuite.com\" rel=\"nofollow\">HootSuite</a>", 
            "in_reply_to_screen_name": null, 
            "in_reply_to_status_id_str": null, 
            "id_str": "54640519019642881", 
            "entities": {
                  "user_mentions": [ ], 
                  "urls": [ ], 
                  "hashtags": [
                        {
                              "text": "PGP", 
                              "indices": [
                                    130, 
                                    134
                              ]
                        }
                  ]
            }, 
            "contributors": null, 
            "retweeted": false, 
            "in_reply_to_user_id_str": null, 
            "place": null, 
            "retweet_count": 4, 
            "created_at": "Sun Apr 03 20:24:49 +0000 2011", 
            "user": {
                  "notifications": null, 
                  "profile_use_background_image": true, 
                  "statuses_count": 31, 
                  "profile_background_color": "C0DEED", 
                  "followers_count": 3066, 
                  "profile_image_url": "http://a2.twimg.com/profile_images/1285770264/PGP_normal.jpg", 
                  "listed_count": 6, 
                  "profile_background_image_url": "http://a3.twimg.com/a/1301071706/images/themes/theme1/bg.png", 
                  "description": "", 
                  "screen_name": "PostGradProblem", 
                  "default_profile": true, 
                  "verified": false, 
                  "time_zone": null, 
                  "profile_text_color": "333333", 
                  "is_translator": false, 
                  "profile_sidebar_fill_color": "DDEEF6", 
                  "location": "", 
                  "id_str": "271572434", 
                  "default_profile_image": false, 
                  "profile_background_tile": false, 
                  "lang": "en", 
                  "friends_count": 21, 
                  "protected": false, 
                  "favourites_count": 0, 
                  "created_at": "Thu Mar 24 19:45:44 +0000 2011", 
                  "profile_link_color": "0084B4", 
                  "name": "PostGradProblems", 
                  "show_all_inline_media": false, 
                  "follow_request_sent": null, 
                  "geo_enabled": false, 
                  "profile_sidebar_border_color": "C0DEED", 
                  "url": null, 
                  "id": 271572434, 
                  "contributors_enabled": false, 
                  "following": null, 
                  "utc_offset": null
            }, 
            "id": 54640519019642880, 
            "coordinates": null, 
            "geo": null
      }, 
      "user": {
            "notifications": null, 
            "profile_use_background_image": true, 
            "statuses_count": 351, 
            "profile_background_color": "C0DEED", 
            "followers_count": 48, 
            "profile_image_url": "http://a1.twimg.com/profile_images/455128973/gCsVUnofNqqyd6tdOGevROvko1_500_normal.jpg", 
            "listed_count": 0, 
            "profile_background_image_url": "http://a3.twimg.com/a/1300479984/images/themes/theme1/bg.png", 
            "description": "watcha doin in my waters?", 
            "screen_name": "OldGREG85", 
            "default_profile": true, 
            "verified": false, 
            "time_zone": "Hawaii", 
            "profile_text_color": "333333", 
            "is_translator": false, 
            "profile_sidebar_fill_color": "DDEEF6", 
            "location": "Texas", 
            "id_str": "80177619", 
            "default_profile_image": false, 
            "profile_background_tile": false, 
            "lang": "en", 
            "friends_count": 81, 
            "protected": false, 
            "favourites_count": 0, 
            "created_at": "Tue Oct 06 01:13:17 +0000 2009", 
            "profile_link_color": "0084B4", 
            "name": "GG", 
            "show_all_inline_media": false, 
            "follow_request_sent": null, 
            "geo_enabled": false, 
            "profile_sidebar_border_color": "C0DEED", 
            "url": null, 
            "id": 80177619, 
            "contributors_enabled": false, 
            "following": null, 
            "utc_offset": -36000
      }, 
      "id": 54691802283900930, 
      "coordinates": null, 
      "geo": null
}'

n <-'{
      "text": "RT @PostGradProblem: In preparation for the NFL lockout, I will be spending twice as much time analyzing my fantasy cricket team during ... #cricket", 
      "truncated": true, 
      "in_reply_to_user_id": null, 
      "in_reply_to_status_id": null, 
      "favorited": false, 
      "source": "<a href=\"http://twitter.com/\" rel=\"nofollow\">Twitter for iPhone</a>", 
      "in_reply_to_screen_name": null, 
      "in_reply_to_status_id_str": null, 
      "id_str": "54691802283900930", 
      "entities": {
            "user_mentions": [
                  {
                        "indices": [
                              3, 
                              19
                        ], 
                        "screen_name": "PostGradProblem", 
                        "id_str": "271572434", 
                        "name": "PostGradProblems", 
                        "id": 271572434
                  }
            ], 
            "urls": [ ], 
            "hashtags": [
                        {
                              "text": "cricket", 
                              "indices": [
                                    130, 
                                    134
                              ]
                        }
						
                  ]
      }, 
      "contributors": null, 
      "retweeted": false, 
      "in_reply_to_user_id_str": null, 
      "place": null, 
      "retweet_count": 4, 
      "created_at": "Sun Apr 03 23:48:36 +0000 2011", 
      "retweeted_status": {
            "text": "In preparation for the NFL lockout, I will be spending twice as much time analyzing my fantasy baseball team during company time. #PGP", 
            "truncated": false, 
            "in_reply_to_user_id": null, 
            "in_reply_to_status_id": null, 
            "favorited": false, 
            "source": "<a href=\"http://www.hootsuite.com\" rel=\"nofollow\">HootSuite</a>", 
            "in_reply_to_screen_name": null, 
            "in_reply_to_status_id_str": null, 
            "id_str": "54640519019642881", 
            "entities": {
                  "user_mentions": [ ], 
                  "urls": [ ], 
                  "hashtags": [
                        {
                              "text": "PGP", 
                              "indices": [
                                    130, 
                                    134
                              ]
                        }
                  ]
            }, 
            "contributors": null, 
            "retweeted": false, 
            "in_reply_to_user_id_str": null, 
            "place": null, 
            "retweet_count": 4, 
            "created_at": "Sun Apr 03 20:24:49 +0000 2011", 
            "user": {
                  "notifications": null, 
                  "profile_use_background_image": true, 
                  "statuses_count": 31, 
                  "profile_background_color": "C0DEED", 
                  "followers_count": 3066, 
                  "profile_image_url": "http://a2.twimg.com/profile_images/1285770264/PGP_normal.jpg", 
                  "listed_count": 6, 
                  "profile_background_image_url": "http://a3.twimg.com/a/1301071706/images/themes/theme1/bg.png", 
                  "description": "", 
                  "screen_name": "PostGradProblem", 
                  "default_profile": true, 
                  "verified": false, 
                  "time_zone": null, 
                  "profile_text_color": "333333", 
                  "is_translator": false, 
                  "profile_sidebar_fill_color": "DDEEF6", 
                  "location": "", 
                  "id_str": "271572434", 
                  "default_profile_image": false, 
                  "profile_background_tile": false, 
                  "lang": "en", 
                  "friends_count": 21, 
                  "protected": false, 
                  "favourites_count": 0, 
                  "created_at": "Thu Mar 24 19:45:44 +0000 2011", 
                  "profile_link_color": "0084B4", 
                  "name": "PostGradProblems", 
                  "show_all_inline_media": false, 
                  "follow_request_sent": null, 
                  "geo_enabled": false, 
                  "profile_sidebar_border_color": "C0DEED", 
                  "url": null, 
                  "id": 271572434, 
                  "contributors_enabled": false, 
                  "following": null, 
                  "utc_offset": null
            }, 
            "id": 54640519019642880, 
            "coordinates": null, 
            "geo": null
      }, 
      "user": {
            "notifications": null, 
            "profile_use_background_image": true, 
            "statuses_count": 351, 
            "profile_background_color": "C0DEED", 
            "followers_count": 48, 
            "profile_image_url": "http://a1.twimg.com/profile_images/455128973/gCsVUnofNqqyd6tdOGevROvko1_500_normal.jpg", 
            "listed_count": 0, 
            "profile_background_image_url": "http://a3.twimg.com/a/1300479984/images/themes/theme1/bg.png", 
            "description": "watcha doin in my waters?", 
            "screen_name": "OldGREG85", 
            "default_profile": true, 
            "verified": false, 
            "time_zone": "Hawaii", 
            "profile_text_color": "333333", 
            "is_translator": false, 
            "profile_sidebar_fill_color": "DDEEF6", 
            "location": "Texas", 
            "id_str": "80177619", 
            "default_profile_image": false, 
            "profile_background_tile": false, 
            "lang": "en", 
            "friends_count": 81, 
            "protected": false, 
            "favourites_count": 0, 
            "created_at": "Tue Oct 06 01:13:17 +0000 2009", 
            "profile_link_color": "0084B4", 
            "name": "GG", 
            "show_all_inline_media": false, 
            "follow_request_sent": null, 
            "geo_enabled": false, 
            "profile_sidebar_border_color": "C0DEED", 
            "url": null, 
            "id": 80177619, 
            "contributors_enabled": false, 
            "following": null, 
            "utc_offset": -36000
      }, 
      "id": 54691802283900930, 
      "coordinates": null, 
      "geo": null
	
}'


#tweets <- c(k,m,n)

tweet_function <- function(tweets) {
	tweet_df <- as.data.frame(matrix(NA,0,3))
	names(tweet_df) <- c("tweet_id","text","hashtag")
	for (j in 1:length(tweets)){
		tweet_df_sub <- as.data.frame(matrix(NA,1,3))
		names(tweet_df_sub) <- c("tweet_id","text","hashtag")
		tweet <- tweets[j]
		tweet <- gsub("\\\"","\"",tweet)
		tweetR <- fromJSON(tweet)
		tweet_df_sub$tweet_id[1] <- tweetR$id_str
		tweet_df_sub$text[1] <- tweetR$text
		if (length(tweetR$entities$hashtags)!=0){
			hash_vector <- NULL
			for (z in 1:length(tweetR$entities$hashtags)){
				hash_vector <- c(hash_vector,tweetR$entities$hashtags[[z]]$text)
			}
		}		
		tweet_df_sub$hashtag[1] <- ifelse(length(tweetR$entities$hashtags)==0,"",paste(hash_vector,collapse="|"))
		tweet_df <- as.data.frame(rbind(tweet_df,tweet_df_sub))
	}
	return(tweet_df)
}
df <- tweet_function(c(k,m,n))

### Text Cleaning

text_str <- df$text
text_str <- tolower(text_str)   #base
text_str <- str_trim(text_str)  #stringr
text_str <- removePunctuation(text_str) #tm
text_str <- removeNumbers(text_str) #tm

Other_stopwords <- c("during","as","in")
myStopWords <- c(stopwords('english'),Other_stopwords)
text_str <- removeWords(text_str,myStopWords) #tm

### Find, replace

find_word <- "baseball"
replace_word <- "badminton"

grep(find_word,text_str)  #base
grepl(find_word,text_str)  #base
str_detect(text_str,find_word) #stringr
text_str_change <- gsub(find_word,replace_word,text_str) #base

### Text-Document Matrix

text_str_corpus <- Corpus(VectorSource(text_str)) #tm
text_str_corpus <- tm_map(text_str_corpus,tolower) 
text_str_corpus <- tm_map(text_str_corpus,removePunctuation)
text_str_corpus <- tm_map(text_str_corpus,removeNumbers)
text_str_corpus <- tm_map(text_str_corpus, stripWhitespace)
	
text_str_corpus <- tm_map(text_str_corpus,removeWords,myStopWords)

NgramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
tdm <- TermDocumentMatrix(text_str_corpus, control = list(tokenize = NgramTokenizer))
tdm <- as.matrix(tdm)

### Parts of Speech

docs <- text_str[1] 
docs <- String(docs)

sent_token_annotator <- Maxent_Sent_Token_Annotator()
word_token_annotator <- Maxent_Word_Token_Annotator()
pos_tag_annotator <- Maxent_POS_Tag_Annotator()

annotator <- annotate(docs, sent_token_annotator)
docs <- gsub("[[:punct:]]", "", docs)

words <- annotate(docs, list(sent_token_annotator, word_token_annotator))
doc_words <- docs[subset(words, type == "word")]
a3 <- as.data.frame(annotate(docs, pos_tag_annotator, words))
a3w <- subset(a3, type == "word")
tags <- a3w$features
pos_df <- as.data.frame(cbind(doc_words,tags))

############################################









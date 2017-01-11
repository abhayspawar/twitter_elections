
setwd("D:/Delhi Elections/Resources/data/Tweets/Tweets-1")

library(rjson)
library(RJSONIO)
library(tm)

filepath <- './Tweets-1-corrected/' 

filename_list <- c("AamAadmiParty__results.json","ajaymaken__results.json","AAP_Legislature__results.json")
full_df <- as.data.frame(matrix(NA,0,4))# change number of columns depending on number of attributes 3+1
names(full_df) <- c("filename","tweet_id","text","hashtag")  # more attributes have to added here
for (y in 1:length(filename_list)) { 
  tw =fromJSON(paste(filepath,filename_list[y],sep=""))	
  filen <- unlist(strsplit(filename_list[y],"__"))[1]
  filename <- tw[[filen]]
  tweet_df <- as.data.frame(matrix(NA,0,3)) # change number of columns depending on number of attributes
  names(tweet_df) <- c("tweet_id","text","hashtag")
  for (j in 1:length(filename)){
    tweet_df_sub <- as.data.frame(matrix(NA,1,3)) # change number of columns depending on number of attributes
    names(tweet_df_sub) <- c("tweet_id","text","hashtag") # more attributes have to added here
    tweetR <- filename[[j]]
    
    tweet_df_sub$tweet_id[1] <- tweetR$id  # add assignments depending on number of attributes
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
  filename_col <- rep(filen,nrow(tweet_df))
  tweet_df_append <- as.data.frame(cbind(filename_col,tweet_df))
  full_df <- as.data.frame(rbind(full_df,tweet_df_append))
}

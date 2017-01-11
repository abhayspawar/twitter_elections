library(RWeka)
library(RWekajars)
if (Sys.getenv("JAVA_HOME")!="")
  Sys.setenv(JAVA_HOME="")
library(RTextTools)

setwd("D:/abhay/Election Twitter")

tagged_kag<-read.csv("./train_kaggle.csv")

#remove retweets, mentions, URL before applying any tm
only_text_kag<-as.data.frame(matrix(NA,7086,0))
only_text_kag$text <- tagged_kag$Text

only_text_kag$text1 <- tolower(only_text_kag$text)   #base
only_text_kag$text1 <- str_trim(only_text_kag$text1)  #stringr
only_text_kag$text1 <- removePunctuation(only_text_kag$text1) #tm
only_text_kag$text1 <- removeNumbers(only_text_kag$text1) #tm

#stop_words<-stopwords('english')

Other_stopwords <- c("ive","youve","weve","dont","shes","hes","hers","can","aap","bjp","aam","aadmi","party","congress","inc","bharatiya","janta","modi","arvind","kejri","kejriwal","bedi","kiran","kiranbedi","namo","modi","amit","shah","rahul","gandhi","sonia","arun","jaitley","anna","muffler","man","woman","men","women","election","elections","delhi","india","bharat","i", "me", "my", "myself", "we", "our", "ours", "ourselves", "you", "your", "yours", "yourself", "yourselves","he", "him", "his", "himself", "she", "her", "hers", "herself", "it", "its", "itself", "they", "them", "their", "theirs", "themselves", "what", "which", "who", "whom",  "this","that", "these", "those", "am", "is", "are", "was", "were", "be", "been", "being", "have", "has", "had", "having", "do", "does", "did", "doing", "would", "should", "could", "ought",  "im", "youre", "hes", "shes", "its", "were", "theyre", "ive", "youve", "weve", "theyve","id", "youd", "hed", "shed", "wed", "theyd", "ill", "youll", "hell", "shell", "well", "theyll", "lets", "thats", "whos", "whats", "heres", "theres", "whens", "wheres", "whys", "hows", "a", "an", "the", "and", "but", "if", "or", "because","as","until", "while", "of", "at", "by", "for", "with", "about", "against", "between", "into", "through", "during", "before", "after", "above", "below", "to", "from", "up", "down", "in", "out", "on", "off", "over", "under", "again", "further", "then", "once", "here", "there", "when", "where", "why", "how", "all", "any", "both", "each", "few", "more", "most", "other", "some", "such", "only", "own", "same", "so", "than", "too", "very")
#myStopWords <- c(stopwords('english'),Other_stopwords)
only_text_kag$text1 <- removeWords(only_text_kag$text1,Other_stopwords) #tm

# remove unnecessary spaces
only_text_kag$text1 = gsub("\\s\\s+", " ", only_text_kag$text1)
only_text_kag$text1 = gsub("^\\s+|\\s+$", "", only_text_kag$text1)
only_text_kag$text1 <- str_trim(only_text_kag$text1)  #stringr

only_text_kag$text1 <- gsub("no\\s","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("isnt","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("arent","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("wasnt","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("werent","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("hasnt","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("havent","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("hadnt","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("doesnt","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("dont","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("didnt","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("wont","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("wouldnt","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("shant","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("shouldnt","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("cant","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("cannot","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("couldnt","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("mustnt","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("nor","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("not","not",only_text_kag$text1)
only_text_kag$text1 <- gsub("aint","not",only_text_kag$text1)

only_text_kag$text1 = gsub("\\s\\S\\S\\s", " ", only_text_kag$text1)
only_text_kag$text1 = gsub("^\\S\\S\\s", "", only_text_kag$text1)
only_text_kag$text1 = gsub("\\s\\S\\S$", "", only_text_kag$text1)
only_text_kag$text1 = gsub("\\s\\S$", "", only_text_kag$text1)
only_text_kag$text1 = gsub("\\s\\S\\s", " ", only_text_kag$text1)
only_text_kag$text1 = gsub("^\\S\\s", "", only_text_kag$text1)

only_text_lemma<-gsub("not\\s","not",only_text_lemma)
home=create_matrix(only_text_lemma, language="english")
matrix_h=as.matrix(home)

write.csv(matrix_h,"./manual tagging/matrix.csv")
classes<-as.vector(tagged_kag$Sentiment)

df=data.frame(Y=factor(classes),X=matrix_h)

model<-naiveBayes(df[,-1],df[,1])
#model$tables$X.aae
predicted <- predict(model,df[,-1])
table(df[,1],predicted)
recall_accuracy(df[,1], predicted)

senti_mod<-matrix(NA,1888,1);
for (z in 1:1888){
  ifelse(df1[z,1]==-1,senti_mod[z]<-0,senti_mod[z]<-1)
}
classes=factor(senti_mod)
classifier <- naiveBayes(matrix_h1[1:1991,],factor(classes[1:1991]),laplace=3)


#Lemmatization
adorn <- function(text) {
  require(httr)
  require(XML)
  url <- "http://devadorner.northwestern.edu/maserver/partofspeechtagger"
  response <- GET(url,query=list(text=text, media="xml", 
                                 xmlOutputType="outputPlainXML",
                                 corpusConfig="ncf", # Nineteenth Century Fiction
                                 includeInputText="false", outputReg="true"))
  doc <- content(response,type="text/xml")
  words <- doc["//adornedWord"]
  xmlToDataFrame(doc,nodes=words)
}
vector.documents <- c("Here is some text.", 
                      "This might possibly be some additional text, but then again, maybe not...",
                      "This is an abstruse grammatical construction having as it's sole intention the demonstration of MorhAdorner's capability.")
corpus.documents <- Corpus(VectorSource(only_text_kag$text1))
ex<-lapply(corpus.documents,function(x) adorn(as.character(x)))

only_text_lemma<-only_text_kag$text1
length(ex[[1]]$token)
for (z in 1:7086){
  for (j in 1:(length(ex[[z]]$token)))
  {
    only_text_lemma<-gsub(paste("\\b",ex[[z]]$token[j],"\\b",sep=""),ex[[z]]$lemmata[j],only_text_lemma)
}}

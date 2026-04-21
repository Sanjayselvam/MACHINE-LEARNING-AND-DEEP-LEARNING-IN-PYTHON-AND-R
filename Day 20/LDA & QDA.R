#Classification Models

df <- read.csv('C:/Users/HP/Downloads/Data Science/Classification_data_R.csv', header = TRUE)

str(df)

#LDA
library(MASS, lib.loc = "C:/Program Files/R/R-4.5.3/library")
lda.fit = lda(Sold~., data = df)

lda.fit

lda.pred = predict(lda.fit, df)
lda.pred$posterior

lda.class = lda.pred$class

table(lda.class,df$Sold)

sum(lda.pred$posterior[,1]>0.8)
#sum will give the count

#QDA

qda.fit = qda(Sold~., data = df)

qda.fit

qda.pred = predict(qda.fit, df)
qda.pred$posterior

qda.class = qda.pred$class

table(qda.class,df$Sold)

sum(qda.pred$posterior[,1]>0.8)

#LDA after train-test split

library(caTools)
lda.fit01 = lda(Sold~., data = train_set)
lda.pred01 = predict(lda.fit01, test_set)
lda.pred01$posterior

lda.class01 = lda.pred01$class

table(lda.class01,test_set$Sold)

sum(lda.pred01$posterior[,1]>0.8)

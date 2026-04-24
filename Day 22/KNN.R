df <- read.csv('C:/Users/HP/Downloads/Data Science/Classification_data_R.csv', header = TRUE)

str(df)

library(class, lib.loc = "C:/Program Files/R/R-4.5.3/library")
library(caTools)
set.seed(0)
split = sample.split(df,SplitRatio = 0.8)#80% training set
train_set = subset(df, split == 'TRUE')
test_set = subset(df, split == 'FALSE')
View(train_set)

trainX = train_set[, -16]
testX = test_set[, -16]
trainY = train_set$Sold
testY = test_set$Sold

k = 3

trainX_s = scale(trainX)
testX_s = scale(testX)

set.seed(0)

knn.pred = knn(trainX_s, testX_s, trainY, k = k)

table(knn.pred, testY)


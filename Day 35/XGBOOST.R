#import dataset
df <- read.csv("C:/Users/HP/Downloads/Data Science/SDT/Movie_classification.csv")

#data preprocessing
summary(df)
df$Time_taken[is.na(df$Time_taken)] <- mean(df$Time_taken, na.rm = TRUE)

#Test_train Split
library(caTools)
set.seed(0)
split = sample.split(df, SplitRatio = 0.8)
trainclf = subset(df, split == TRUE)
testclf = subset(df, split == FALSE)

#XGBOOST

#install.packages("xgboost")
library(xgboost)

trainY = trainclf$Start_Tech_Oscar == "1"
trainY

trainX = model.matrix(Start_Tech_Oscar ~ .-1, data = trainclf)
#the variable before ~ will not convert into dummy variable and -1 represent delete the first column of the dummy variable
trainX <- trainX[,-12]
View(trainX)

testY = testclf$Start_Tech_Oscar == "1"

testX = model.matrix(Start_Tech_Oscar ~ .-1, data = testclf)
testX <- testX[,-12]
View(testX)
#delete additional variable


Xmatrix <- xgb.DMatrix(data = trainX, label = trainY)
Xmatrix_t <- xgb.DMatrix(data = testX, label = testY)

Xgboosting <- xgb.train(data = Xmatrix, #the data
                      nround = 50, #max number of boosting iterations
                      objective = "multi:softmax", eta = 0.3, num_class = 2, max_depth = 100)
#max - depth = (for Tree Booster) (default=6, type=int32) Maximum depth of a tree. 
#Increasing this value will make the model more complex and more likely to overfit. 
#0 indicates no limit on depth. Beware that XGBoost aggressively consumes memory when training a deep tree. 
#"exact" tree method requires non-zero value.

#(alias: eta) Step size shrinkage used in update to prevent overfitting. After each boosting step, we can directly get the weights of new features, and learning_rate shrinks the feature weights to make the boosting process more conservative.

#range: 
#  [
#    0
#   ,
#    1
#  ]
#[0,1]

#default value: 0.3 for tree-based boosters, 0.5 for linear booster.)

xgpred <- predict(Xgboosting, Xmatrix_t)
table(testY, xgpred)

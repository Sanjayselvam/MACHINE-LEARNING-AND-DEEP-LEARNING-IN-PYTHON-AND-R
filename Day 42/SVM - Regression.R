#import dataset
df <- read.csv("C:/Users/HP/Downloads/Data Science/SDT/Movie_regression.csv", header = TRUE)

#data preprocessing
summary(df)
df$Time_taken[is.na(df$Time_taken)] <- mean(df$Time_taken, na.rm = TRUE)

#Test_train Split
library(caTools)
set.seed(0)
split = sample.split(df, SplitRatio = 0.8)
trainclf = subset(df, split == TRUE)
testclf = subset(df, split == FALSE)

##Importing relevant library
#install.packages('e1071')
library(e1071)

svmfit = svm(Collection~., data = trainclf, kernel = 'linear', cost=0.01, scale = TRUE)
summary(svmfit)

#predicting

ypred = predict(svmfit,testclf)

mse <- mean((ypred-testclf$Collection)^2)

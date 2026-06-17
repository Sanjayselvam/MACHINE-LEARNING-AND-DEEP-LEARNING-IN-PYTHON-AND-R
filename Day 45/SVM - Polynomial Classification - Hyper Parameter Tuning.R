#import dataset
movie <- read.csv("C:/Users/HP/Downloads/Data Science/SDT/Movie_classification.csv", header = TRUE)

#data preprocessing
summary(movie)
movie$Time_taken[is.na(movie$Time_taken)] <- mean(movie$Time_taken, na.rm = TRUE)

#Test_train Split
library(caTools)
set.seed(0)
split = sample.split(movie, SplitRatio = 0.8)
trainclf = subset(movie, split == TRUE)
testclf = subset(movie, split == FALSE)

#For classification
#It is important to make the R understand that Start_Tech_Oscar(dependent variable) as categorical variable
trainclf$Start_Tech_Oscar <- as.factor(trainclf$Start_Tech_Oscar)
testclf$Start_Tech_Oscar <- as.factor(testclf$Start_Tech_Oscar)

##Importing relevant library
#install.packages('e1071')
library(e1071)

#Polynomial kernel

svmfitP = svm(Start_Tech_Oscar~., data=trainclf, kernel = 'polynomial', cost=1, degree=2)
ypred = predict(svmfitP, testclf)
table(ypred,testclf$Start_Tech_Oscar)

#accuracy 
64/107

#Hyper paramter Tuning
tune.outP = tune(svm, Start_Tech_Oscar~., data = trainclf, cross = 4, kernel = 'polynomial',
                 ranges = list(cost=c(0.001,0.01,0.1,1,5,10),degree=c(0.5,1,2,3,5)))
#cross = 4 means it will run the model 4 times will each of the values of the parameter and cross validate each time

bestmodP = tune.outP$best.model
summary(bestmodP)

ypredP = predict(bestmodP, testclf)
table(ypredP, testclf$Start_Tech_Oscar)

#accuracy
66/107

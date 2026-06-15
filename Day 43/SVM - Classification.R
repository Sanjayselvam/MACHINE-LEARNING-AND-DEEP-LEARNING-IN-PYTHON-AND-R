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

svmfit = svm(Start_Tech_Oscar~., data= trainclf, kernel = 'linear', cost = 1, scale = TRUE)
#cost is a hyperparameter, is the cost of miscalculation, scale = TRUE -> allows scaling of the value(means kind of standardization)
summary(svmfit)


#Predicting of test set
ypred = predict(svmfit, testclf)
table(ypred, testclf$Start_Tech_Oscar)

#accuracy
66/107

#TO check the support vector
svmfit$index

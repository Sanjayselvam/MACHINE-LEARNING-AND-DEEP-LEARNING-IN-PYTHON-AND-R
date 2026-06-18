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

#Radial Kernel
svmfitR = svm(Start_Tech_Oscar~., data = trainclf, kernel='radial',gamma=1, cost=1)

ypred = predict(svmfitR,testclf)
table(ypred, testclf$Start_Tech_Oscar)
#accuracy 
56/107

#Hyperparamater tuning

tune.outR = tune(svm, Start_Tech_Oscar~., data = trainclf, kernel='radial',
                 ranges = list(cost=c(0.001,0.01,0.1,1,10,100,1000),gamma=c(0.01,0.1,0.5,1,3,5,10,50)), cross=4)
summary(tune.outR)
bestmodR = tune.outR$best.model
summary(bestmodR)

ypredR = predict(bestmodR, testclf)
table(ypredR, testclf$Start_Tech_Oscar)

58/107

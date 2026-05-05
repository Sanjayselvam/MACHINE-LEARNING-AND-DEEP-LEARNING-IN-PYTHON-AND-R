#import dataset
df <- read.csv("C:/Users/HP/Downloads/Data Science/SDT/Movie_classification.csv")
View(df)

#data preprocessing
summary(df)
df$Time_taken[is.na(df$Time_taken)] <- mean(df$Time_taken, na.rm = TRUE)

#Test_train Split
library(caTools)
set.seed(0)
split = sample.split(df, SplitRatio = 0.8)
trainclf = subset(df, split == TRUE)
testclf = subset(df, split == FALSE)

#install required package
library(rpart)
library(rpart.plot)

#Run classification tree model on train set
classtree <- rpart(formula = Start_Tech_Oscar~., data = trainclf, method = 'class', control = rpart.control(maxdepth = 3))
#for classification method = 'class'

#plot the tree
rpart.plot(classtree, box.palette = "RdBu", digits = -3)

#Predict value at any point
testclf$pred <- predict(classtree, testclf, type = 'class')
# For regression type = vector and for classification type = class

table(testclf$Start_Tech_Oscar, testclf$pred)

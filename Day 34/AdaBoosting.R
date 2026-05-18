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

#Ada Boost
install.packages("adabag")
library(adabag)

trainclf$Start_Tech_Oscar <- as.factor(trainclf$Start_Tech_Oscar)

adaboost <- boosting(Start_Tech_Oscar~., data=trainclf, boos = TRUE, mfinal = 1000)

predada <- predict(adaboost, testclf)

table(predada$class, testclf$Start_Tech_Oscar)

71/107

t1 <- adaboost$trees[[1]]
plot(t1)
text(t1,pretty=100)

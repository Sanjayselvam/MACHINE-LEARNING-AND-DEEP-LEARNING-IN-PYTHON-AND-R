#Classification Models

df <- read.csv('C:/Users/HP/Downloads/Data Science/Classification_data_R.csv', header = TRUE)

str(df)

#Logistic Regression using single predictor
library(glmnet)
glm.fit = glm(Sold~price, data = df, family = binomial) #glm - generalized linear model
#family = binomial represents that it is logistic model

summary(glm.fit)
#Estimate of (Intercept) is beta0 value and 
#Estimate of price is beta1 value

#Logistic Regression using multiple predictor

glm.fit = glm(Sold~., data = df, family = binomial) #glm - generalized linear model
#family = binomial represents that it is logistic model

summary(glm.fit)
#Estimate of (Intercept) is beta0 value
#Estimate of other values are beta1, beta2,...,betan

glm.probs = predict(glm.fit, type = "response")
glm.probs[1:10]

glm.pred = rep("NO",506)
glm.pred[glm.probs>0.5] = "YES"
glm.pred

table(glm.pred,df$Sold) #predicted value as rows, actual value as colums

#Logistic regression after train-test split
library(caTools)
set.seed(0)
split = sample.split(df,SplitRatio = 0.8)#80% training set
train_set = subset(df, split == 'TRUE')
test_set = subset(df, split == 'FALSE')

train.fit = glm(Sold~.,data = train_set, family = binomial)
test.probs = predict(train.fit, test_set, type = 'response')

test.pred = rep ('NO', 120) #test_set has 120 values
test.pred[test.probs>0.5] = 'YES'
table(test.pred, test_set$Sold)

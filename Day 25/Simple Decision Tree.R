#import dataset

movie <- read.csv("C:/Users/HP/Downloads/Data Science/SDT/Movie_regression.csv")
View(movie)

#Data Preprocessing
summary(movie)
#you can see the Time_taken column has NA's : 12, that is 12 missing values
movie$Time_taken[is.na(movie$Time_taken)] <- mean(movie$Time_taken, na.rm = TRUE)
summary(movie)

#test-train split
library(caTools)
set.seed(0)
split = sample.split(movie,SplitRatio = 0.8)
train = subset(movie,split == TRUE)
test = subset(movie, split == FALSE)

#install required package
install.packages('rpart')
install.packages('rpart.plot')
library(rpart)
library(rpart.plot)

#Run regression tree model on train set
regtree <- rpart(formula = Collection~., data = train, control = rpart.control(maxdepth = 3))
#press F1 on rpart for help

#plot the decision tree
rpart.plot(regtree, box.palette = "RdBu", digits = -3)

#Predict value at any point
test$pred <- predict(regtree, test, type = "vector")

MSE2 <- mean((test$pred - test$Collection)^2)

#Tree Pruning
library(rpart)
library(rpart.plot)
fulltree <- rpart(formula = Collection~., data = train, control = rpart.control( cp = 0))
#cp = 0, normal tree- not having any pruning
rpart.plot(fulltree, box.palette="RdBu", digits = -3)
printcp(fulltree)
plotcp(regtree)

mincp <- regtree$cptable[which.min(regtree$cptable[,"xerror"]),"CP"]

prunedtree <- prune(fulltree, cp = mincp)
rpart.plot(prunedtree, box.palette = "RdBu", digits = -3)

test$fulltree <- predict(fulltree, test, type = "vector")
MSE2full <- mean((test$fulltree - test$Collection)^2)

test$pruned <- predict(prunedtree, test, type = "vector")
MSE2pruned <- mean((test$pruned - test$Collection)^2)



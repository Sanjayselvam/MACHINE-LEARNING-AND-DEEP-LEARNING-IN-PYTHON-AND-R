#import dataset

movie <- read.csv("C:/Users/HP/Downloads/Data Science/SDT/Movie_regression.csv")
View(movie)

#Data Preprocessing
summary(movie)
#you can see the Time_taken column has NA's : 12, that is 12 missing values
movie$Time_taken[is.na(movie$Time_taken)] <- mean(movie$Time_taken, na.rm = TRUE)
summary(movie)
# Convert all character columns to factor
movie[] <- lapply(movie, function(x) {
  if (is.character(x)) as.factor(x) else x
})
#test-train split
library(caTools)
set.seed(0)
split = sample.split(movie,SplitRatio = 0.8)
train = subset(movie,split == TRUE)
test = subset(movie, split == FALSE)

#Gradient Boosting
install.packages('gbm')
library(gbm)
set.seed(0)
boosting = gbm(Collection~., data = train, distribution = "gaussian", n.trees = 5000, interaction.depth = 4, shrinkage = 0.2,verbose = F)
#shrinkage is lambda(minimum lambda need to provide), interaction.depth is depth of intermediate trees, n.tress is how many iterations of trees,verbose=F means it will only give final output not output in each step
#distribution = "Gaussian" for regression
#distribution = "Bernoulli" for classification

test$boost = predict(boosting, test, n.trees = 5000)
MSE2boost <- mean((test$boost - test$Collection)^2)
#IMPORT DATA FROM CSV OR TEXT FILES

Customer <- read.csv("C:/Users/HP/Downloads/Data Science/Data Files/1. ST Academy - Crash course and Regression files/Customer.csv", header = TRUE)
Customer

View(Customer)

y <- table(Customer$Region) #It creates a table using the values of the column "Region"
y
View(y)

barplot(y)
barplot(y[order(y)]) #ascending order
barplot(y[order(-y)]) #descending order
barplot(y [order(y)], horiz = TRUE)
barplot(y [order(y)], horiz = TRUE, col = "blue")
barplot(y [order(y)], horiz = TRUE, col = c("red","green","yellow","blue"))

colors() #list of colors in R

barplot(y [order(y)], horiz = TRUE, col = c("red","green","yellow","blue"), border = NA) #removes the borderline of the barplots
barplot(y [order(y)], horiz = TRUE, col = c("red","green","yellow","blue"), border = NA, main = "Freq of \n Regions") #gives title for the barplot graph

barplot(y [order(y)], horiz = TRUE, col = c("red","green","yellow","blue"), border = NA, main = "Freq of \n Regions", xlab = "No of customers") #gives name for x-axis

hist(Customer$Age)
hist(Customer$Age, breaks = 5)
hist(Customer$Age, breaks = c(0,40,60,100), freq = TRUE)
hist(Customer$Age, breaks = c(0,40,60,100), freq = TRUE, col = 'blue', main = "Histogram of Age")

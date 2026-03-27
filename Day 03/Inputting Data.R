#INBUILT DATASETS OF R

data()
library(help = "datasets")

? iris

str(iris) #structure of the iris dataset

iris

data("iris")

#ENTER DATA MANUALLY

x1 <- 1:10
x2 <-c(2,5,7,4)
x3 <- seq(5,50, by = 5) #from 5 to 50, with the step of 5
x4 <- scan()

#IMPORT DATA FROM CSV OR TEXT FILES

Customer <- read.csv("C:/Users/HP/Downloads/Data Science/Data Files/1. ST Academy - Crash course and Regression files/Customer.csv", header = TRUE)
Customer

View(Customer)                     

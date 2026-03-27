#Basics of R

x<-2 # <- acts as '=' and assign the number 2 to variable x
x
y<-c(1,2,3,4,5) #c acts as concatination that assigns the list of values to the variable y
y
y<-1:10
y
x<-y<-1:10
x
y
z <- x+y
z
z2<-x*y
X<-20

ls() #It displays what are the variable we are having in the current project

rm(X) #It removes the variable X
remove(z2) #rm() and remove() both are same

rm(list = ls())

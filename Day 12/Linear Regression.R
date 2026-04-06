df <- read.csv("C:/Users/HP/Downloads/Data Science/Datasets/House_Price.csv", header = TRUE)

View(df)

str(df)

summary(df)

hist(df$crime_rate) #histogram
plot(x = df$n_hot_rooms, y = df$price) #scatterplot
pairs(~price+crime_rate+n_hot_rooms+rainfall, data=df) #scatterplot matrix
barplot(table(df$airport))
barplot(table(df$waterbody))
barplot(table(df$bus_ter))

# Observations:

# 1. Missing values in n_hos_beds
# 2. Skewness or outliers in crime_rate
# 3. Outliers in n-hot_rooms and rainfall
# 4. bus_ter only has "Yes" value. So it might not be useful for our model


quantile(df$n_hot_rooms, 0.99)
uv = 3*quantile(df$n_hot_rooms, 0.99)
df$n_hot_rooms[df$n_hot_rooms > uv] <- uv

summary(df$n_hot_rooms)


lv = quantile(df$rainfall, 0.01)
df$rainfall[df$rainfall < lv] <- 0.3*lv

summary(df$rainfall)

mean(df$n_hos_beds)
mean(df$n_hos_beds, na.rm = TRUE)

which(is.na(df$n_hos_beds))
is.na(df$n_hos_beds)
df$n_hos_beds[is.na(df$n_hos_beds)] <-mean(df$n_hos_beds, na.rm = TRUE)

summary(df$n_hos_beds)
which(is.na(df$n_hos_beds))


pairs(~price+crime_rate, data=df)
plot(df$crime_rate,df$price)

df$crime_rate = log(1+df$crime_rate)
plot(df$price,df$crime_rate)

df$avg_dist = (df$dist1+df$dist2+df$dist3+df$dist4)/4

df2 <- df[,-7:-10]
df <- df2
rm(df2)
df <- df[,-14]


install.packages("fastDummies")

df <- dummy_cols(df, select_columns = "airport")
df <- dummy_cols(df, select_columns = "waterbody")

df <- df[,-9]
df <- df[,-11]
df <- df[,-14]
df <- df[,-17]

cor(df)

round(cor(df),2)

df <- df[,-12]
summary((df))
View(df)

#In the above correlation matrix, the values near 1 and -1 are really important. 
#The values far away from 1 and -1 are not much important. 
#Here you can see, 'room_num' and 'poor_prop' are having good correlation with 'price' then other variables. 
#And 'rainfall' and 'n_hot_rooms' are having very poor correlation with 'price'. In this dataset, we are not removing any column with low correlation, because we are having limited variable. 
#If we are having like 100, 150 or 200+ variables, we can directly remove variable with very low correlation.

#The high correlation between two non-independent variable can cause multicollinearity. 
#Here we are going to check which two independent variables having correlation greater than 0.8 and lesser than -0.8. 
#Here you can see, 'parks' and 'air_qual' having multicollinearity. 
#So, we need to remove either one of the columns, so now we need to check the correlation of both variables with 'price'(dependent variable). 
#Here air_qual has higher correlation than parks variable. So, we need to delete park column


simple_model <- lm(price~room_num, data = df)
#lm - linear model, left of '~' represents dependent variable and right to that represents independent variable

summary(simple_model)
#beta1 is 9.0997 - represents If we increase room_num by 1 value, the price will increase by 9 units
#beta0 is -34.6592 - represents, if room_num is 0, then price will be -34.6592
#Pr(>|t|) is really low, represents significant relationship between room_num and price and 
# three stars *** represents 99% the room_num affects the price. SO we got a good relationship

plot(df$room_num,df$price)
abline(simple_model)

multiple_model <- lm(price~., data = df) #'.' after ~ tells to select all columns
summary(multiple_model)

#We need to check the p-value of (F-statistic) all variable and it needs to be lower than 1% or 5% threshold value. 
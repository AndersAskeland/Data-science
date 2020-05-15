data <- read.csv("hw1_data.csv")

## Find column names
colnames(data)

## Extract 2 first rows.
print(data[1:2,])

## Number of rows in data frame
nrow(data)

## Extract 2 last rows.
print(data[152:153, ])

## Value of ozone in 47th row
print(data[47,"Ozone"])

## How many missing values are in the Ozone column of this data frame?
sum(is.na(data[,"Ozone"]))

## What is the mean of the Ozone column in this dataset? Exclude missing values (coded as NA) from this calculation.
mean(data$Ozone, na.rm = T)

## Extract the subset of rows of the data frame where Ozone values are above 31 and Temp values are above 90. What is the mean of Solar.R in this subset?
new_data <- data[data$Ozone > 31 & data$Temp > 90, ]

mean(new_data$Solar.R, na.rm = T)



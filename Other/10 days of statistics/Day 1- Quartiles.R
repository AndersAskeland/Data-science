# Enter your code here. Read input from STDIN. Print output to STDOUT
data<-read_lines("data_day1_01")
x <- scan(text = data[1], sep = " ", quiet = TRUE)
y <- scan(text = data[2], sep = " ", quiet = TRUE)

quantile(y, x)
xwMultiplied <- x * w 
sum1 <- sum(xwMultiplied) 
weightedMean <- (sum1/sum(w)) 


cat(trimws(format(round(weightedMean,1), nsmall=1))) # trimws removes trailing white spaces that sometimes causes errors.

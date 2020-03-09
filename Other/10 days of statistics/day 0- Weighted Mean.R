# Enter your code here. Read input from STDIN. Print output to STDOUT
data<-read_lines("data_day0_02")
x <- scan(text = data[2], sep = " ", quiet = TRUE)
w <- scan(text = data[3], sep = " ", quiet = TRUE)


xwMultiplied <- x * w 
sum1 <- sum(xwMultiplied) 
weightedMean <- (sum1/sum(w)) 

cat(trimws(format(round(weightedMean,1), nsmall=1))) # trimws removes trailing white spaces that sometimes causes errors.

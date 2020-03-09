# Enter your code here. Read input from STDIN. Print output to STDOUT
x <- read_lines("data_day0_01")

## Extracts stuff
elements <- scan(text = x[1], quiet = TRUE)
element_number <- scan(text = x[2], sep = " ", quiet = TRUE)


# Mean
mean_cal <- sum((element_number)/elements)

# Median
median_cal <- median(element_number)

# Mode
freqTable <- table(element_number) # It is allready sorted

# finds max
max_number <- which.max(freqTable)

# Extracts and convert mode back to int
mode_cal <- as.numeric(names(max_number))

# Print - I need to use cat function to avoid [1] prior to result
cat(mean_cal, "\n")
cat(median_cal, "\n")
cat(mode_cal, "\n")


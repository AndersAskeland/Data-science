
# 1 - Basics of R ---------------------------------------------------------
## Asigns a variable
weight_kilos <- 100
weight_kilos


## define a vectors
vector_1 <- c("a", "b", "c")
vector_1

## This is a data.frame
head(iris) # Allready stored file


## To get information from a data.frame
colnames(iris) #Column names

str(iris) #Structure

summary(iris) # Summary


# 2 - Make code more readable ---------------------------------------------
## Make this code more readable
## Original
# Object names
DayOne
Day_one

dayone
day_one

T <- FALSE
c <- 9
mean <- function(x) sum(x)

# Spacing
x[,1]
x[ ,1]
x[ , 1]
mean (x, na.rm = TRUE)
mean( x, na.rm = TRUE )
function (x) {}
function(x){}
height<-feet*12+inches
mean(x, na.rm=10)
sqrt(x ^ 2 + y ^ 2)
df $ z
x <- 1 : 10

# Indenting
if (y < 0 && debug)
  message("Y is negative")

## Solution
# Object names

# Should be camel case
# DayOne
day_one
# dayone
day_one

# Should not over write existing function names
# T = TRUE, so don't name anything T
# T <- FALSE
false <- FALSE
# c is a function name already. Plus c is not descriptive
# c <- 9
number_value <- 9
# mean is a function, plus does not describe the function which is sum
# mean <- function(x) sum(x)
sum_vector <- function(x) sum(x)

# Spacing
# Commas should be in correct place
# x[,1]
# x[ ,1]
# x[ , 1]
x[, 1]
# Spaces should be in correct place
# mean (x, na.rm = TRUE)
# mean( x, na.rm = TRUE )
mean(x, na.rm = TRUE)
# function (x) {}
# function(x){}
function(x) {}
# height<-feet*12+inches
height <- feet * 12 + inches
# mean(x, na.rm=10)
mean(x, na.rm = 10)
# sqrt(x ^ 2 + y ^ 2)
sqrt(x^2 + y^2)
# df $ z
df$z
# x <- 1 : 10
x <- 1:10

# Indenting should be done after if, for, else functions
# if (y < 0 && debug)
# message("Y is negative")
if (y < 0 && debug)
  message("Y is negative")


# 3 - Automatic styling ---------------------------------------------------
## We can use styler package to automatically style our document - Use ctrl-shift-a or using the addin thing at the top of the source window


# 4 - DRY and describing code ---------------------------------------------
## Dont repeat yourself and rather make your own functions


# 5 - Packages, data, and file paths --------------------------------------
## It is tedious to load all packages each time you load up a project. You can make a seperate script that loads all relevant packages
## You can also run a universal package loading script using

source(here::here("R/package-loading.R")) ## The here package always use your project root as a baseline




# 3 - Import data ---------------------------------------------------------
## You can import data line this

write_csv(iris, here::here("data/iris.csv"))
imported_iris <- read_csv(here::here("data/iris.csv"))
head(imported_iris)


##### Part 1 #####
## Write a function named 'pollutantmean' that calculates the mean of a pollutant (sulfate or nitrate) across a 
## specified list of monitors. The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. 
## Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data from the directory 
## specified in the 'directory' argument and returns the mean of the pollutant across all of the monitors, ignoring any 
## missing values coded as NA. A prototype of the function is as follows

polluteantmean <- function(directory, pollutant, id)
{
  ## Sets variables i calculate mean on
  count <- 0
  sum <- 0

  ## Itterate over all Ids
  for (i in seq_along(id)) 
  {
    ## Set folder
    folder <- paste(directory, "/", sprintf("%03s.csv", id[i]), sep = "");
    
    ## Opens file
    x <- read_csv(folder)
    
    ## Calculate and ad sum and count to total
    sum <- sum + sum(x[[pollutant]], na.rm = T)
    count <- count + sum(!is.na(x[[pollutant]]))
  }
  
  sum/count
}


##### Part 2 #####
## Write a function that reads a directory full of files and reports the number of completely observed cases in 
## each data file. The function should return a data frame where the first column is the name of the file and the 
## second column is the number of complete cases. A prototype of this function follows
complete <- function(directory, id = 1:322)
{
  ## Sets variables
  nobs <- 0
  data <- tibble(id = double(), nobs = double()) ## Creates empty tibble
  
  ## Itterate over all Ids
  for (i in id) 
  {
    ## Set folder
    folder <- paste(directory, "/", sprintf("%03s.csv", i), sep = "");
    
    ## Opens file
    x <- read_csv(folder)
    
    ## Calculate observations
    nobs <- sum(!is.na(x$sulfate) & !is.na(x$nitrate))
    data <- add_row(data, id = i, nobs = nobs)
  }
  
data
}

##### Part 3 #####
## Write a function that takes a directory of data files and a threshold for complete cases and calculates the 
## correlation between sulfate and nitrate for monitor locations where the number of completely observed cases 
## (on all variables) is greater than the threshold. The function should return a vector of correlations for the 
## monitors that meet the threshold requirement. If no monitors meet the threshold requirement, then the function should 
## return a numeric vector of length 0. A prototype of this function follows

corr <- function(directory, treshold = 0)
{
  ## Sets variables
  correlations <- c()
  
## I need a loop that knows how many files there are in directory. Currently hardcoded to 332
  for (i in 1:332) 
  {
    ## Set folder
    folder <- paste(directory, "/", sprintf("%03s.csv", i), sep = "");
    
    ## Opens file
    x <- read_csv(folder)
    
    ## Calculate observations
    if(sum(!is.na(x$sulfate) & !is.na(x$nitrate)) >= treshold)
    {
      data <- filter(x, !is.na(x$sulfate) & !is.na(x$nitrate))  
      correlations <- c(correlations, cor(data$sulfate, data$nitrate))
    } 
  }
  correlations
}

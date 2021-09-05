# finds the shortest string in vector
find_short <- function(s){
  # Variables
  i <- 1
  min <- length(unlist(strsplit(s[1], ""))) # Maximum length

  # Split string
  s_vector <- strsplit(x = s, split = " ", fixed = T) %>%
    unlist()

  # Loop through all strings
  for(i in i:(length(s_vector))){
    # Check if shorter than min
    if(length(unlist(strsplit(s_vector[i], ""))) < min)
      # Stores to min if smaller
      min <- length(unlist(strsplit(s_vector[i], "")))
  }

  # Return
  return(min)

}

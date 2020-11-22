## Working file

## Find length
vol = 3500
diameter = 120

length = vol / (pi * ((120/2)^2))

## Find area
?v

bouncingBall <- function(h, bounce, window) {
  # Error handling
  if(h <= 0 | (bounce <= 0 | bounce >= 1) | window >= h){
    return(-1)
  }

  # First bounce
  count <- 1 # falling

  # Bounces
  while((h * bounce) > window){
      h <- h * bounce
      count <- count + 2
  }
  return(count)
}


longestConsec <- function (strarr, k) {
  # Error handling
  if(length(strarr) == 0 | k > length(strarr) | k <= 0){
    return("")
  }

  # Set variables
  output <- NULL
  max <- 0

  # Check longest
  for (i in seq_along(strarr)){
    if(nchar(strarr[i] + nchar(strarr[i]) > max){
      max <- nchar(strarr[i])
      index <- i
    }
  }
  print(strarr[index])
  # Print
  for(i in 0:(k-1)){
    if(is.na(strarr[index+i])){
      break
    } else {
      output <- paste0(output, strarr[index+i])
    }
  }
  print(output)
}

# Make n into reversed vector
reverse <- function(n){
  vec <- c(NULL)

  while(n > 0) {
    vec <- append(vec, (n %% 10))
    n <- floor(n / 10)
  }
return(vec)
}

# Thirt function
thirt <- function (n){
  # Variables
  seq <- c(1,10,9,12,3,4)
  vec <- reverse(n)
  j <- 1
  i <- 1

  # Calculates output
  while(length(vec) > 2){
    # Reset total
    total <- 0

    for(i in seq_along(vec)){
      # Check if we are done with the seq and restart count
      if(j > length(seq)){
        j <- 1
      }

      # Add to total
      total <- total + (vec[i] * seq[j])
      j <- j + 1
    }
    vec <- reverse(total)
    i <- 1
    j <- 1
  }
  return(total)
}






arrange <- function(s) {

  vec <- unlist(strsplit(x = s, split = " "))
  for(i in seq_along(vec)){
    if((nchar(vec[i]) > nchar(vec[i + 1])) && ((i %% 2) != 0)){
      # Replace if larger and odd
      vec <- replace(x = vec, list = c(i, i+1), values = vec[c(i+1, i)])

    } else if ((nchar(vec[i]) < nchar(vec[i + 1])) && ((i %% 2) == 0)){
      # replace if smaller and even
      vec <- replace(x = vec, list = c(i, i+1), values = vec[c(i+1, i)])
    }
  }

  for (j in seq_along(vec)){

    if((j %% 2) != 0) {
      vec[j] <- tolower(vec[j])
    } else {
      vec[j] <- toupper(vec[j])
    }
  }

  print(paste(vec,collapse=" ")
)
}


# removeNb return a list of vectors
removeNb <- function(n) {
  # Variables
  n_sum <- (n*(n+1)/2)
  output <- list()
  append_index <- 1


  # Outer loop - Reversed loop
  for(i in n:1){

    # Equation (Solve from a * i = sum - a - i)
    product = (n_sum - i)/(i + 1)

    # Check if match
    if(product < n && (floor(product) == product)){
      output[[append_index]] <- c(product, i)
      append_index <- append_index + 1
    }
  }

  print(output)
}


## Testing (input of n = 26)

# Variables
n_sum <- (n*(n+1)/2)
output <- list()
append_index <- 1


# Outer loop - Reversed loop
for(i in n:1){
  print(i)

  # Equation (Solve from a * i = sum - a - i)
  product = (n_sum - i)/(i + 1)
  print(product)
  #
  if(product < n && (floor(product) == product)){
    print("patch")
    output[[append_index]] <- c(product, i)
    append_index <- append_index + 1
  }
}

print(output)











longestConsec <- function (strarr, k) {
  # Error handling
  if(length(strarr) == 0 | k > length(strarr) | k <= 0){
    return("")
  }

  # Set variables
  word <- ""
  max <- 0


  # Check longest
  for (i in seq_along(strarr)){

    # Create word
    for (j in 1:k){
      print(strarr[j + (i - 1)])
      word = paste0(word, strarr[j + (i - 1)])
    }


    # Check of longest
    if(nchar(word) > max){
      max <- nchar(word)
      output <- word
    }
    word <- ""
  }

  return(output)
}


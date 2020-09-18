# Calculate the perfect power
isPP <- function(n){
  # Variables
  i <- 2
  j <- 2
  sum <- 0

  if (n > 10000) {
    return(NULL)
  }

  # Loop while the sum is below n. No need to continue past that.
  while (i < n) {


    # Inner loop that goes over the product
    while (n > sum & j < n) {
      # Find sum
      sum <- i ^ j

      # Check if match
      if ((i ^ j) == n) {
        return(c(i, j))
      }

      # Itterates j
      j <- j + 1
    }
    # Returns j to 2
    j <- 2

    # Itterages i
    i <- i + 1

    # reset sum
    sum <- 0
  }

  # Return NULL if nothing found
  return(NULL)
}

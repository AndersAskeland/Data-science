# Sum of multiples
sum_mul <- function(n, m){


  ## Initiate variables used
  sum <- 0L
  total <- 0L

  ## Calculate total
  while((sum + n) < m){
    sum <- sum + n
    total <- total + sum
  }
  return(total)
}

# Takes a vector and adds 1: to the front
number <- function(lines) {
  # Variables
  dat <- c(NULL)
  i <- 1

  # Main loop
  for (i in i:length(lines)){
    # Check if NULL
    if(identical(lines[i], "")){
      next
    } else {
      # Save stuff
      dat <- c(dat, (paste0(i, ": ", lines[i])))
    }
  }
  print(dat)
}


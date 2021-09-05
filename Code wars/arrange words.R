arrange <- function(s){
  browser()
  vec <- unlist(strsplit(x = s, split = " "))
  for(i in seq_along(vec)){
    if(((nchar(vec[i]) > nchar(vec[i + 1])) & ((i %% 2) != 0)) & !is.na(vec[i + 1])){
      # Replace if larger and odd
      vec <- replace(x = vec, list = c(i, i+1), values = vec[c(i+1, i)])
      } else if(((nchar(vec[i]) < nchar(vec[i + 1])) & ((i %% 2) == 0)) & !is.na(vec[i + 1])){
      # replace if smaller and even
      vec <- replace(x = vec, list = c(i, i+1), values = vec[c(i+1, i)])
    }
  }

  # Make stuff lower and upper
  for (j in seq_along(vec)){

    if((j %% 2) != 0) {
      vec[j] <- tolower(vec[j])
    } else {
      vec[j] <- toupper(vec[j])
    }
  }

  print(paste(vec,collapse=" "))
}


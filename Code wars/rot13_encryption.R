# Rot13 encryption
rot13 <- function(x){
  j <- 1
  word <- c(NULL)

  ## Vector loop
  for (j in j:length(x)) {

    ## Check if its empty.
    if(identical(x[j], "") == T){
      word <- c(word, "")
    } else if(identical(x, character(0)) == T){
      return(x)
    } else {

      ## Initilize stuff
      ints <- utf8ToInt(x[j])
      i <- 1

      ## Word loop
      for (i in i:length(ints)){
        if(ints[i] <= 64 | (ints[i] >= 91 & ints[i] <= 96) | ints[i] >= 123){
          next
        } else if((ints[i] >= 65 & ints[i] <= 77) | (ints[i] >= 97 & ints[i] <= 109)){
          ints[i] <- ints[i] + 13
        }
        else if((ints[i] >= 78 & ints[i] <= 90) | (ints[i] >= 110 & ints[i] <= 122)){
          ints[i] <- ints[i] - 13
        } else {
          return(F)
        }
      }

      word <- c(word, intToUtf8(ints))
    }

  }

  return(word)
}


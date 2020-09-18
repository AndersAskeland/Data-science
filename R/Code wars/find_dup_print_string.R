# Finds duplicates and prints strings
duplicate_encode <- function(word) {
  ## Variables
  output <- NULL
  i <- 1
  word <- tolower(word)
  copy <- paste(unlist(strsplit(word, ""))[-i], collapse = "")


  ## Loop that checks for word
  for (i in i:nchar(word)) {
    if (!grepl(substr(word, i, i), copy, fixed = T)) {
      output <- paste0(output, "(")
      copy <- paste(unlist(strsplit(word, ""))[-(i+1)], collapse = "")
    } else {
      output <- paste0(output, ")")
      copy <- paste(unlist(strsplit(word, ""))[-(i+1)], collapse = "")
    }
  }
  return(output)
}

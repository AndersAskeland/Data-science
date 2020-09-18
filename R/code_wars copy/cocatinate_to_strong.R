# Add - to string
accum <- function(s){
  i <- 1
  j <- 1
  output <- NULL
  for (i in i:nchar(s)){
    capital <- toupper(substr(s, i, i))
    lower_case <- strrep(tolower(substr(s, i, i)), i-1)

    output <- append(output, paste0(capital, lower_case))
  }

  return(paste0(output, collapse = "-"))
}

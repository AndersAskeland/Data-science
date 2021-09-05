library(tidyverse)

stringr::str_extract_all(strg, pattern = stringr::regex("(\\d?\\d\\|\\d?\\d\\|\\d?\\d)", dotall = F))


stat <- function (strg) {
  # Extract all to times using regular expressions
  times <- stringr::str_extract_all(strg, pattern = stringr::regex("(\\d?\\d\\|\\d?\\d\\|\\d?\\d)", dotall = F), simplify = T)

  # Create summary statistics
  mean <- format(mean(strptime(times, "%H|%M|%S")), "%H|%M|%S")
  median <- format(median(strptime(times, "%H|%M|%S")), "%H|%M|%S")
  diff_hours <- max(strptime(times, "%H|%M|%S")) - min(strptime(times, "%H|%M|%S"))
  diff <- format(ISOdatetime(1900,1,1,0,0,0, tz="GMT") +
           as.difftime(diff_hours, unit="hours"), "%H|%M|%S")

  # Print
  sprintf("Range: %s Average: %s Median: %s", diff, mean, median)

}


stat <- function (strg) {
  # Extract all to vector
  vector <- stringr::str_extract_all(strg, "[:digit:][:digit:]?", simplify = T) %>%
    as.numeric()

  # make a tibble
  tibble <- matrix(vector, ncol = 3, byrow =T) %>%
    dplyr::as_tibble() %>%
    dplyr::rename(Hour = V1, Minute = V2, Second = V3)

  # Calculate mean
  summary <- tibble %>%
    dplyr::summarise(dplyr::across(c(Hour, Minute, Second), list(mean = mean, diff = ~ max(.x) - min(.x), median = median), na.rm = T), .groups = "drop_last")

  # Print
  sprintf("Range: %02d|%02d|%02d Average: %02.0f|%02.0f|%02.0f Median: %02.0f|%02.0f|%02.0f", summary$Hour_diff, summary$Minute_diff, summary$Second_diff, summary$Hour_mean, summary$Minute_mean, summary$Second_mean, summary$Hour_median, summary$Minute_median, summary$Second_median)

  }






movie <- function(card, ticket, perc) {
  ticket_total <- 0
  print(paste0(count, ": Ticket total: ", ticket_total))

  card_total <- card
  print(paste0(count, ": Card total: ", card_total))

  discount_ticket <- ticket * perc
  print(paste0(count, ": Price per ticket: ", discount_ticket))

  count <- 0

    while(ceiling(card_total) >= ceiling(ticket_total)){
      ticket_total <- ticket_total + ticket
      print(paste0(count, ": Ticket total: ", (ticket_total)))

      card_total <- card_total + discount_ticket
      print(paste0(count, ": Card total: ", (card_total)))

      discount_ticket <- discount_ticket * perc
      print(paste0(count, ": Price per ticket: ", discount_ticket))

      count <- count + 1


    }
  return(count)
}


data0 <-
  "Rome:Jan 81.2,Feb 63.2,Mar 70.3,Apr 55.7,May 53.0,Jun 36.4,Jul 17.5,Aug 27.5,Sep 60.9,Oct 117.7,Nov 111.0,Dec 97.9
    London:Jan 48.0,Feb 38.9,Mar 39.9,Apr 42.2,May 47.3,Jun 52.1,Jul 59.5,Aug 57.2,Sep 55.4,Oct 62.0,Nov 59.0,Dec 52.9
    Paris:Jan 182.3,Feb 120.6,Mar 158.1,Apr 204.9,May 323.1,Jun 300.5,Jul 236.8,Aug 192.9,Sep 66.3,Oct 63.3,Nov 83.2,Dec 154.7
    NY:Jan 108.7,Feb 101.8,Mar 131.9,Apr 93.5,May 98.8,Jun 93.6,Jul 102.2,Aug 131.8,Sep 92.0,Oct 82.3,Nov 107.8,Dec 94.2
    Vancouver:Jan 145.7,Feb 121.4,Mar 102.3,Apr 69.2,May 55.8,Jun 47.1,Jul 31.3,Aug 37.0,Sep 59.6,Oct 116.3,Nov 154.6,Dec 171.5
    Sydney:Jan 103.4,Feb 111.0,Mar 131.3,Apr 129.7,May 123.0,Jun 129.2,Jul 102.8,Aug 80.3,Sep 69.3,Oct 82.6,Nov 81.4,Dec 78.2
    Bangkok:Jan 10.6,Feb 28.2,Mar 30.7,Apr 71.8,May 189.4,Jun 151.7,Jul 158.2,Aug 187.0,Sep 319.9,Oct 230.8,Nov 57.3,Dec 9.4
    Tokyo:Jan 49.9,Feb 71.5,Mar 106.4,Apr 129.2,May 144.0,Jun 176.0,Jul 135.6,Aug 148.5,Sep 216.4,Oct 194.1,Nov 95.6,Dec 54.4
    Beijing:Jan 3.9,Feb 4.7,Mar 8.2,Apr 18.4,May 33.0,Jun 78.1,Jul 224.3,Aug 170.0,Sep 58.4,Oct 18.0,Nov 9.3,Dec 2.7
    Lima:Jan 1.2,Feb 0.9,Mar 0.7,Apr 0.4,May 0.6,Jun 1.8,Jul 4.4,Aug 3.1,Sep 3.3,Oct 1.7,Nov 0.5,Dec 0.7"

## First name
library(magrittr)

data0 %>%
  stringr::str_extract(pattern = stringr::regex("((Lima:).*)")) %>%
  stringr::str_extract_all(pattern = stringr::regex("(\\d\\d?\\.\\d)", dotall = F), simplify = T) %>%
  as.numeric() %>%
  mean()
## function
avg <- function(town, strng) {
  expression <- paste0("((", {
    {
      town
    }
  }, ":).*)")

  avg <- strng %>%
    stringr::str_extract(pattern = stringr::regex(expression)) %>%
    stringr::str_extract_all(
      pattern = stringr::regex("(\\d?\\d?\\d?\\d?\\.\\d?\\d?)", dotall = F),
      simplify = T
    ) %>%
    as.numeric() %>%
    mean()

  if (is.na(avg)) {
    return(-1)
  } else{
    return(avg)
  }
}

variance <- function(town, strng) {
  expression <- paste0("((", {
    {
      town
    }
  }, ":).*)")

  vector <- strng %>%
    stringr::str_extract(pattern = stringr::regex(expression)) %>%
    stringr::str_extract_all(
      pattern = stringr::regex("(\\d?\\d?\\d?\\d?\\.\\d?\\d?)", dotall = F),
      simplify = T
    ) %>%
    as.numeric()

  variance <- var(vector) * (length(vector) - 1) / length(vector)


  if (is.na(variance)) {
    return(-1)
  } else{
    return(variance)
  }
}

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


vector <- stringr::str_extract_all(strg, "[:digit:][:digit:]?", simplify = T) %>%
  as.numeric()

# make a tibble
tibble <- matrix(vector, ncol = 3, byrow =T) %>%
  dplyr::as_tibble() %>%
  dplyr::rename(Hour = V1, Minute = V2, Second = V3)


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


numbers <- function(lines) {
  if(length(lines)==0) return(c())
  paste0(1:length(lines), ": ", lines)
}
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

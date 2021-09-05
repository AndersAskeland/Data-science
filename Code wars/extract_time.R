## Function that extract time from string and calculates summary statistics
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

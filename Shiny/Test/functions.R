# Library
library(magrittr)

# TODO
## Function to check API code is valid

check_api <- function(api = 0) {
  # Error check using tryCatch
  check <- tryCatch(
    # expression
    expr = {
      # Test
      postForm(
        uri='https://redcap.rn.dk/api/',
        token=api,
        content='version')
    }, warning = function(warning_condition) {
      return(0)
    }, error = function(error_condition) {
      return(0)
    })

  # Return
  if (check == 0){
    return(0)
  } else {
    return(1)
  }
}

check_arm <- function(arm){
  # Error check using tryCatch
  check <- tryCatch(
    # expression
    expr = print(arm),
    # Warning
    warning = function(warning_condition) {
      return(0)
    }, error = function(error_condition) {
      return(0)
    })

  # Return
  print("Function done")
}


# Get vector of study arms using supplied API code
study_arms <- function(api = 0) {

  # API call for study arms
  result <- RCurl::postForm(
    uri='https://redcap.rn.dk/api/',
    token=api,
    content='arm',
    format='csv',
    returnFormat='csv'
  )

  # Get names
  names <- result %>%
    readr::read_csv() %>%
    dplyr::select(name) %>%
    dplyr::pull()

  # Return
  return(names)
}



# Get vector of study IDs in selected arm - maybe input should be selection of first thing
study_ids <- function(api = 0, arm) {
  # Check if api is 0 and arm is loaded
  if (is.null(arm)) {
    return("Loading")
  }


  # API call for study arms and arm numbers
  result_arm_id <- RCurl::postForm(
    uri='https://redcap.rn.dk/api/',
    token=api,
    content='arm',
    format='csv',
    returnFormat='csv'
  )

  print(arm)
  # Get arm ID
  arm_id <- result_arm_id %>%
    readr::read_csv() %>%
    dplyr::filter(name == arm) %>% # TODO change to selected_arm
    dplyr::select(arm_num) %>%
    dplyr::pull()

  # API call to get all user data
  result_user_id <- RCurl::postForm(
    uri='https://redcap.rn.dk/api/',
    token=api,
    content='record',
    format='csv',
    type='flat',
    'events[0]'=stringr::str_c("enrolment_arm_", arm_id),
    rawOrLabel='raw',
    rawOrLabelHeaders='raw',
    exportCheckboxLabel='false',
    exportSurveyFields='false',
    exportDataAccessGroups='false',
    returnFormat='csv'
  )


  # Extract vector of user IDs
  user_id <- tryCatch(
    # expression
    expr = {
      user_id <- result_user_id %>%
        readr::read_csv() %>%
        dplyr::select(participant_id) %>%
        dplyr::pull()
      return(user_id)
    }, warning = function(warning_condition) {
      return(0)
    }, error = function(error_condition) {
      return(0)
    })

  # Return and check if error
  if (user_id == 0){
    return("No data")
  } else {
    return(user_id)
  }
}







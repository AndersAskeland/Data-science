#' Add numbers function
#'
#' @param num1 Number to be added 1
#' @param num2 Number to be added 2
#'
#' @return Returns the combined total of num1 and num2
add_numbers <- function(num1, num2){
  return(num1 + num2)
}




#' Get user_info_stuff
#'
#' @param file_path Give me the filepath. You can use the herrrrrrre package.
#'
#' @return
#' @export
#'
#' @examples
import_user_info <- function(file_path){
  info_data <- vroom::vroom(file = (file_path),
                     col_select = -1,
                     col_types = vroom::cols(
                       Gender = vroom::col_character(),
                       Weight = vroom::col_double(),
                       Height = vroom::col_double(),
                       Age = vroom::col_double()),
                     .name_repair = snakecase::to_snake_case)

  return(info_data)
}



#' Import data and create a comnbined tibble
#'
#' @param dataType The data file you wish to use
#' @param mainDir The main dir location
#'
#' @return
#' @export
#'
#' @examples
import_data_advanced <- function(dataType, mainDir){
  # Create matrix
  mat <- matrix(, nrow = 15, ncol = 0)
  patient <- matrix(, nrow = 15, ncol = 0)

i <- 1
  # For loop
  for (i in 1:length(list.files(mainDir))) {
    ## Create dir
    completeDir <-
      here::here(paste0(mainDir, "user_", i, "/", dataType, ".csv"))

    # Check if the file is present
    if(file.exists(completeDir)){

      temp <- vroom::vroom(
        file = (completeDir),
        col_select = -1,
        col_types = vroom::cols(
          Gender = vroom::col_character(),
          Weight = vroom::col_double(),
          Height = vroom::col_double(),
          Age = vroom::col_double()
        ),
        .name_repair = snakecase::to_snake_case
      )

      temp <- cbind(patient_ID = i, temp)

      mat <- rbind(mat, temp)
    }
  }

  return(mat)

}


extract_data <- function(path){
  if(stringr::str_detect(path, "saliva")){
    data <- vroom::vroom(path,
                  col_select = -1,
                  col_types = vroom::cols(
                    SAMPLES = vroom::col_character(),
                    `Cortisol NORM` = vroom::col_double(),
                    `Melatonin NORM` = vroom::col_double()),
                  .name_repair = snakecase::to_snake_case)
  }

  else if(stringr::str_detect(path, "user_info")){
    data <- vroom::vroom(path,
                         col_select = -1,
                         col_types = vroom::cols(
                           Gender = vroom::col_character(),
                           Weight = vroom::col_double(),
                           Height = vroom::col_double(),
                           Age = vroom::col_double(),
                         ),
                         .name_repair = snakecase::to_snake_case)
  }

  else if(stringr::str_detect(path, "RR")){
    data <- vroom::vroom(path,
                  col_select = -1,
                  col_types = vroom::cols(
                    ibi_s = vroom::col_double(),
                    day = vroom::col_double(),
                    time = vroom::col_time(format = "")
                  ),
                  .name_repair = snakecase::to_snake_case)
  }
  else if(stringr::str_detect(path, "Actigraph")){
    data <- vroom::vroom(path,
                  col_select = -1,
                  col_types = vroom::cols(
                    Axis1 = vroom::col_double(),
                    Axis2 = vroom::col_double(),
                    Axis3 = vroom::col_double(),
                    Steps = vroom::col_double(),
                    HR = vroom::col_double(),
                    `Inclinometer Off` = vroom::col_double(),
                    `Inclinometer Standing` = vroom::col_double(),
                    `Inclinometer Sitting` = vroom::col_double(),
                    `Inclinometer Lying` = vroom::col_double(),
                    `Vector Magnitude` = vroom::col_double(),
                    day = vroom::col_double(),
                    time = vroom::col_time(format = "")
                  ),
                  .name_repair = snakecase::to_snake_case)
  }
  else if(stringr::str_detect(path, "Activity")){
    data <- vroom::vroom(path,
                         col_select = -1,
                         col_types = vroom::cols(
                           Activity = col_double(),
                           Start = col_time(format = ""),
                           End = col_time(format = ""),
                           Day = col_double()),
                         .name_repair = snakecase::to_snake_case)
  }

  return(data)
}


import_multiple_files <- function(file_pattern){
  # Get files
  file <- fs::dir_ls(here::here("data-raw/mmash/"),
                     regexp = file_pattern,
                     recurse = TRUE)

  # Get data for each file
  import <- function(file_path){
    data <- vroom::vroom(file = (file_path),
                         col_select = -1,
                         .name_repair = snakecase::to_snake_case)
    return(data)

  }


  # Create data
  data <- furrr::future_map_dfr(file, import, .id = "file_path_id")

  # Return
  return(data)
}

import_multiple_files_new <- function(file_pattern){
  # Get files
  file <- fs::dir_ls(here::here("data-raw/mmash/"),
                     regexp = file_pattern,
                     recurse = TRUE)

  # Create data
  data <- furrr::future_map_dfr(file, extract_data, .id = "file_path_id") %>%
    extract_user_id()

  # Return
  return(data)
}

extract_user_id <- function(df, column = file_path_id){
data <- df %>%
    dplyr::mutate(user_id = stringr::str_extract({{column}}, "user_[:digit:][:digit:]?")) %>%
    dplyr::select(-{{column}})

return(data)
}

tidy_summarize_by_day <- function(data, columns){
  data %>%
    group_by(day) %>%
    summarise(across(
      {{columns}},
      list(mean = mean, sd = sd),
      na.rm = TRUE
    )) %>%
    pivot_longer(ends_with(c("mean", "sd")),
                 names_to = c("names", "summary_statistic"),
                 names_sep = "_") %>%
    pivot_wider(names_from = summary_statistic,
                values_from = value)
}




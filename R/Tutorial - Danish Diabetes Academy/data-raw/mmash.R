# load packages
library(here) # Point to wd
library(fs) # Delete stuff
library(tidyverse)
library(furrr)
devtools::load_all() # Load this as a package


# Enable parallel processing - To run multisession using load_all the package must be installed.
# You can create namespace with commands + shift + D and install/build command + shift + b.
# This actually installs it.
plan(multisession)

# Download data
mmash_link <- "https://physionet.org/static/published-projects/mmash/multilevel-monitoring-of-activity-and-sleep-in-healthy-people-1.0.0.zip"

# download.file(mmash_link, destfile = here("data-raw/mmash-data.zip"))

# Add data to gitignore
# usethis::use_git_ignore(("data-raw/mmash-data.zip"))
# usethis::use_git_ignore(("data-raw/mmash/"))
#
# # Unzip
# unzip(here("data-raw/mmash-data.zip"),
#       exdir = here('data-raw/'),
#       junkpaths = T)
#
# unzip(here("data-raw/MMASH.zip"),
#       exdir = here("data-raw/"))
#
# # Delete uneeded files
# file_delete(here(c("data-raw/MMASH.zip",
#                    "data-raw/SHA256SUMS.txt",
#                    "data-raw/LICENSE.txt")))
#
# # Rename data file
# file_move(here("data-raw/DataPaper/"), here("data-raw/mmash/"))

# Open files
user_info_df <- import_multiple_files_new("info")
saliva_df <- import_multiple_files_new("saliva")
rr_df <- import_multiple_files_new("RR")
actigraph_df <- import_multiple_files_new("Actigraph")

# Summarise rr
summarised_rr_df <- rr_df %>%
  group_by(user_id, day) %>% # we group by two varibles
  summarise(across(ibi_s, list(mean = mean, sd = sd), na.rm = T), .groups = "drop_last")

# Saliva w. day
saliva_with_day_df <- saliva_df %>%
  mutate(day = case_when(
    samples == "before sleep" ~ 1,
    samples == "wake up" ~ 2,
    TRUE ~ NA_real_))

# Summarise actigraph (hr and steps)
summarised_actigraph_df <- actigraph_df %>%
  group_by(user_id, day) %>% # we group by two varibles
  summarise(across(c(hr, steps), list(mean = mean, sd = sd), na.rm = T), .groups = "drop_last")

# Group
mmash <- reduce(list(user_info_df, saliva_with_day_df, summarised_rr_df, summarised_actigraph_df), full_join)


usethis::use_data(mmash, overwrite = TRUE)

# Disable parallel processing
plan(sequential)



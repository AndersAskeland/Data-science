
# 1 - Managing and working with data in R ---------------------------------
## You should never edit your raw data! Always create a copy.

## Wrangling uses the following commands

select() ## Select a specific column

rename() ## rename column

mutate() ## transform column

filter() ## Removes stuff

arrange() ## changes about stuff

gather()

spread()

summarise()

group_by()

## load package and datasets
library(tidyverse)
library(NHANES)

glimpse(NHANES) ## Briefly glimse



# 2 - Exercise ------------------------------------------------------------
# Load the packages
library(tidyverse)
library(NHANES)

# Check column names
colnames(NHANES)

# Look at contents
str(NHANES) ## I can better like glimse
glimpse(NHANES)

# See summary
summary(NHANES)

# Look over the dataset documentation
?NHANES


# 3 - Mutatle -------------------------------------------------------------

NHANES %>%
  mutate(Height = Height / 100)

NHANES %>%
  mutate(HighlyActive = if_else(PhysActiveDays >= 5, "yes", "no"))

NHANES %>%
  mutate(new_column = "only one value",
         Height = Height / 100)

NHANES_update <- NHANES %>%
  mutate(UrineVolAverage = (UrineVol1 + UrineVol2) / 2)



# 4 - Exercise 2 ----------------------------------------------------------

# Create a new variable called “UrineVolAverage” by calculating the average urine volumne (from “UrineVol1” and “UrineVol2”).
# Modify/replace the “Pulse” variable to beats per second (currently is beats per minute).
# Create a new variable called “YoungChild” when age is less than 6 years.


# Check the names of the variables
colnames(NHANES)

# Pipe the data into mutate function and:
NHANES_modified <- NHANES %>% # dataset
  mutate(
    # 1. Calculate average urine volume
    urinevolAverage = (UrineVol1 + UrineVol2)/2,
    # 2. Modify Pulse variable
    pulse = (Pulse * 60),
    # 3. Create YoungChild variable using a condition
    YoungChild = if_else(Age <= 6, TRUE, FALSE)
  )
NHANES_modified

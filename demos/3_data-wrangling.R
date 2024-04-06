# session 2 - starting with data in r
# date: 25 March 2024
# instructor: Eirini Zormpa

# install.packages("tidyverse")
# install.packages("here")

library(tidyverse)
library(here)

# read in data
census_data <- read_csv(here("data_raw", "census_data.csv"))
View(census_data)

# factors
region <- factor(c("Northern Ireland", "London", "South East", "East Midlands"))

levels(region)
nlevels(region)

region

region <- factor(c("Northern Ireland", "London", "South East", "East Midlands"),
                 levels = c("South East", "London", "East Midlands", "Northern Ireland"))

region

levels(region)[2] <- "Greater London"
levels(region)

region <- fct_recode(region, "Greater London" = "London")
region

# ordered factor
class(census_data$interview_date)

interview_day <- wday(census_data$interview_date, label = TRUE)
class(interview_day)

likert_scale <- factor(c("Very unlikely", "Unlikely", "Neither likely nor unlikely", "Likely", "Very likely"),
                       levels = c("Very unlikely", "Unlikely", "Neither likely nor unlikely", "Likely", "Very likely"),
                       ordered = TRUE)

likert_scale

as.character(region)

year_factor <- factor(c(1999, 2005, 2006, 1967, 2023))
levels(year_factor)

as.numeric(year_factor)
as.numeric(as.character(year_factor))

as.numeric(levels(year_factor))[year_factor]

cars <- census_data$cars
cars <- as.factor(cars)
cars

plot(cars)

cars <- census_data$cars
cars[is.na(cars)] <- "unknown"
cars

cars <- as.factor(cars)
cars

plot(cars)

# select and filter

## select one column
select(census_data, region)

## select multiple columns
select(census_data, region, cars)
select(census_data, ID: dwelling_type, cars)
select(census_data, -religion)

## filters using one condition
filter(census_data, region == "East Midlands")
filter(census_data, household_size > 1)

## stacking conditions
filter(census_data, household_size > 1 & household_size < 4)
filter(census_data, region == "East Midlands" | region == "West Midlands")

# pipes
east_midlands <- filter(census_data, region == "East Midlands")
east_midlands_subset <- select(east_midlands, ID, dwelling_type:cars)

east_midlands_subset_2 <- select(filter(census_data, region == "East Midlands"), ID, dwelling_type:cars)

east_midlands_subset_3 <- census_data %>% 
  filter(region == "East Midlands") %>%
  select(ID, dwelling_type:cars)





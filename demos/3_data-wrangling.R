# session 2 - starting with data in r
# date: 25 March 2024
# instructor: Eirini Zormpa

# install.packages("tidyverse")
# install.packages("here")

library(tidyverse)
library(here)

# read in data
census_data <- read_csv(here("data_raw", "census_data.csv"), na = "NULL")
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

# the above is the magrittr pipe, there has recently been a base R pipe
# the symbol for that is: |>
# they are basically the same

# exercise 1
census_data %>%
  filter(region == "London") %>%
  select(household_size, dwelling_type, cars)

# mutate
census_data %>% 
  mutate(people_per_room = household_size/bedrooms)

# group_by and summarise
census_data %>% 
  group_by(region) %>% 
  summarise(median_bedroom = median(bedrooms))

census_data %>% 
  group_by(central_heating, region) %>% 
  summarise(median_bedroom = median(bedrooms))

census_data %>%
  filter(!is.na(central_heating)) %>% 
  group_by(central_heating, region) %>% 
  summarise(median_bedroom = median(bedrooms)) %>% 
  View()

census_data %>%
  drop_na(central_heating) %>% 
  group_by(central_heating, region) %>% 
  summarise(median_bedroom = median(bedrooms)) %>% 
  View()

# ungroup
census_data %>% 
  group_by(central_heating, region) %>% 
  summarise(median_bedroom = median(bedrooms)) %>% 
  ungroup()

# multiple new columns
census_data %>% 
  group_by(central_heating, region) %>% 
  summarise(median_bedroom = median(bedrooms),
            mean_hh_size = mean(household_size))

# arrange
census_data %>% 
  group_by(central_heating, region) %>% 
  summarise(median_bedroom = median(bedrooms),
            mean_hh_size = mean(household_size)) %>% 
  arrange(mean_hh_size)

## and in descending order
census_data %>% 
  group_by(central_heating, region) %>% 
  summarise(median_bedroom = median(bedrooms),
            mean_hh_size = mean(household_size)) %>% 
  arrange(desc(mean_hh_size))

# count
census_data %>% 
  count(region)

# exercise 2
census_data %>%
  count(dwelling_type)

census_data %>%
  group_by(dwelling_type) %>%
  summarise(
    median_bedrooms = median(bedrooms),
    min_bedrooms = min(bedrooms),
    max_bedrooms = max(bedrooms),
    n = n()
  )

census_data %>%
  drop_na(cars) %>%
  group_by(region) %>%
  filter(cars == max(cars))


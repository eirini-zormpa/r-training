# session 2 - starting with data in r
# date: 25 March 2024
# instructor: Eirini Zormpa

# install.packages("tidyverse")
# install.packages("here")

library(tidyverse)
library(here)

# download the data
download.file(url = "https://raw.githubusercontent.com/theRSAorg/r-training/main/data_raw/synthetic-census-data.csv?download=1",
              destfile = here("data_raw", "census_data.csv"))

# this prints the data in the console
read_csv(here("data_raw", "census_data.csv"))

# we would prefer the data to be saved in an object
census_data <- read_csv(here("data_raw", "census_data.csv"))

# but printing can be helpful for seeing how the data was read
census_data
View(census_data)

# we have missing values!
census_data <- read_csv(here("data_raw", "census_data.csv"),
                        na = "NULL")

# interrogate the data
nrow(census_data)
ncol(census_data)
dim(census_data)

head(census_data)
head(census_data, n = 10)
tail(census_data)

names(census_data)

str(census_data)
summary(census_data)
glimpse(census_data)

# subsetting data
# data[row, column]
census_data[1, 1]
census_data[2, 1]
census_data[1, 2]

census_data[, 1]
census_data[1]

census_data[1, ]

census_data[1:3, 1]
census_data[1, 1:3]

census_data[c(1, 3, 5), ]
census_data[, c(1, 3, 5)]

census_data[-1]
census_data[-1, ]

census_data[-(7:131), ]

census_data["age"]
typeof(census_data["age"])
class(census_data["age"])

census_data$age
typeof(census_data$age)
class(census_data$age)

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

# dates
interview_dates <- census_data$interview_date
str(interview_dates)

interview_day <- day(interview_dates)
interview_day

interview_month <- month(interview_dates)
interview_month

interview_year <- year(interview_dates)
interview_year

char_date <- c("31/7/2012", "8/9/2014", "30/4/2016")
mdy(char_date)        

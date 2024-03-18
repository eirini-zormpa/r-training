# session 1 - intro to R
# date: 
# instructor: Eirini Zormpa

# basic math
3+5

12/7

# assigning values to objects

gbp <- 1000
gbp

# once R knows the value of something we can do math with it
gbp * 1.17

# and we can create new objects using known ones
eur <- gbp * 1.17

# we can also change the value of an object
gbp <- 900

# but the value of other objects that used it, doesn't change automatically!
eur

# we'd have to rerun the code for that!
# if we wanted, we could also create an object containing the value of the exchange rate
exchange_rate <- 1.17

eur <- gbp * exchange_rate

# exercise 1
income <- 100
expenses <- 90
profit <- income - expenses
profit

## change the values of `income` and `expenses`
income <- 80
expenses <- 100

## the value of `profit` hasn't changed
profit

# functions
sqrt(2)

# one argument
round(1.414214)

# two arguments
round(1.414214, 2)
round(1.414214, digits = 2)
round(digits = 2, x = 1.414214)


# vectors
hh_size <- c(1, 3, 1, 2, 4, 5, 6)
region <- c("London", "South East", "North East")

length(hh_size)
length(region)

typeof(hh_size)
typeof(region)

str(hh_size)
str(region)

region <- c (region, "Scotland")
region <- c("East Midlands", region)

mean(hh_size)
median(hh_size)

# missing data
cars <- c(1, 2, 4, NA, 2, 3, 2)

length(cars)
mean(cars)

mean(cars, na.rm = TRUE)

is.na(cars)
sum(is.na(cars))

cars_no_na <- na.omit(cars)
cars_no_na

sum(is.na(cars_no_na))

# session 4 - data visualisation
# date: 15 April 2024
# instructor: Eirini Zormpa

# load packages
library(here)
library(tidyverse)
library(viridisLite)

# read in data
census_data <- read_csv(here("data_raw", "synthetic-census-data.csv"),
                        na = "NULL")

census_data %>% 
  ggplot()

census_data %>% 
  ggplot(aes(x = household_size, y = bedrooms))

census_data %>% 
  ggplot(aes(x = household_size, y = bedrooms)) +
  geom_point()

census_data %>% 
  ggplot(aes(x = household_size, y = bedrooms)) +
  geom_point(alpha = 0.3)

census_data %>% 
  ggplot(aes(x = household_size, y = bedrooms)) +
  geom_jitter()

census_data %>% 
  ggplot(aes(x = household_size, y = bedrooms)) +
  geom_jitter(alpha = 0.3,
              width = 0.3,
              height = 0.3)

census_data %>% 
  ggplot(aes(x = household_size, y = bedrooms)) +
  geom_jitter(alpha = 0.3,
              colour = "tomato",
              width = 0.3,
              height = 0.3)

census_data %>% 
  ggplot(aes(x = household_size, y = bedrooms)) +
  geom_jitter(aes(colour = dwelling_type),
              alpha = 0.3,
              width = 0.3,
              height = 0.3)

census_data %>% 
  separate_wider_delim(dwelling_type,
                       names = c("dwelling_type", "dwelling_type_detail"),
                       delim = " - ",
                       too_few = "align_start") %>% 
  ggplot(aes(x = household_size, y = bedrooms)) +
  geom_jitter(aes(colour = dwelling_type))

census_viz_data <- census_data %>% 
  separate_wider_delim(dwelling_type,
                       names = c("dwelling_type", "dwelling_type_detail"),
                       delim = " - ",
                       too_few = "align_start")

census_viz_data %>% 
  ggplot(aes(x = household_size, y = bedrooms)) +
  geom_jitter(aes(colour = dwelling_type),
              alpha = 0.5,
              width = 0.3,
              height = 0.3)

census_viz_data %>% 
  ggplot(aes(x = household_size, y = bedrooms)) +
  geom_jitter(aes(colour = dwelling_type),
              alpha = 0.5,
              width = 0.3,
              height = 0.3) +
  scale_colour_viridis_d()

# exercise 1
census_viz_data %>% 
  ggplot(aes(x = household_size, y = cars)) +
  geom_jitter(aes(colour = dwelling_type),
              alpha = 0.3,
              width = 0.3,
              height = 0.3) +
  scale_colour_viridis_d()

# boxplots
census_viz_data %>% 
  ggplot(aes(x = dwelling_type, y =  bedrooms)) +
  geom_boxplot()

census_viz_data %>% 
  ggplot(aes(x = dwelling_type, y =  bedrooms)) +
  geom_boxplot() +
  geom_jitter()

census_viz_data %>% 
  ggplot(aes(x = dwelling_type, y =  bedrooms)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.3,
              colour = "tomato",
              width = 0.3,
              height = 0.3)

# exercise 2
census_viz_data %>% 
  ggplot(aes(x = dwelling_type, y =  bedrooms)) +
  geom_violin(alpha = 0) +
  geom_jitter(alpha = 0.3,
              colour = "tomato",
              width = 0.3,
              height = 0.3)

# barplots
census_data %>% 
  ggplot(aes(x = region)) +
  geom_bar()

census_data %>% 
  ggplot(aes(x = region, fill = religion)) +
  geom_bar()

census_data %>% 
  ggplot(aes(x = region, fill = religion)) +
  geom_bar() +
  scale_colour_viridis_d()

census_data %>% 
  ggplot(aes(x = region, fill = religion)) +
  geom_bar() +
  scale_fill_viridis_d()

census_data %>% 
  ggplot(aes(x = region, fill = religion)) +
  geom_bar(position = "dodge") +
  scale_fill_viridis_d()

religion_percentage <- census_data %>% 
  drop_na(religion) %>% 
  count(region, religion) %>% 
  group_by(region) %>% 
  mutate(percent = (n/sum(n)) * 100) %>% 
  ungroup()

religion_percentage %>% 
  ggplot(aes(x = region, y = percent, fill = religion)) +
  geom_bar(stat = "identity", position = "dodge")  +
  scale_fill_viridis_d()

religion_percentage %>% 
  ggplot(aes(x = region, y = percent, fill = religion)) +
  geom_bar(stat = "identity", position = "dodge")  +
  scale_fill_viridis_d() +
  coord_flip()

religion_percentage %>% 
  ggplot(aes(x = religion, y = percent, fill - religion)) +
  geom_bar(stat = "identity", position = "dodge")  +
  facet_wrap(~region)

religion_percentage %>% 
  ggplot(aes(x = religion, y = percent, fill = religion)) +
  geom_bar(stat = "identity", position = "dodge")  +
  facet_wrap(~region) +
  scale_fill_viridis_d()

# title
religion_percentage %>% 
  ggplot(aes(x = religion, y = percent, fill = religion)) +
  geom_bar(stat = "identity", position = "dodge")  +
  facet_wrap(~region) +
  scale_fill_viridis_d() +
  ggtitle("Religious belief in England and Wales")

# tweaking
religion_percentage %>% 
  ggplot(aes(x = religion, y = percent, fill = religion)) +
  geom_bar(stat = "identity", position = "dodge")  +
  facet_wrap(~region) +
  scale_fill_viridis_d() +
  ggtitle("Religious belief in England and Wales") +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank())

# themes
religion_percentage %>% 
  ggplot(aes(x = religion, y = percent, fill = religion)) +
  geom_bar(stat = "identity", position = "dodge")  +
  facet_wrap(~region) +
  scale_fill_viridis_d() +
  ggtitle("Religious belief in England and Wales") +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) +
  theme_minimal()

religion_percentage %>% 
  ggplot(aes(x = religion, y = percent, fill = religion)) +
  geom_bar(stat = "identity", position = "dodge")  +
  facet_wrap(~region) +
  scale_fill_viridis_d() +
  ggtitle("Religious belief in England and Wales") +
  theme_minimal() +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank())

religion_plot <- religion_percentage %>% 
  ggplot(aes(x = religion, y = percent, fill = religion)) +
  geom_bar(stat = "identity", position = "dodge")  +
  facet_wrap(~region) +
  scale_fill_viridis_d() +
  ggtitle("Religious belief in England and Wales") +
  theme_minimal() +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank())

ggsave(here("figures", "religion_plot.png"), religion_plot)  

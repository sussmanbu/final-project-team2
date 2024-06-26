suppressPackageStartupMessages(library(tidyverse))

police_f <- read.csv(here::here("dataset", "police_fatalities.csv"))

police_f <- police_f |>
  filter(Race != "" & Race != "Other" & !is.na(Race)) |>
  mutate(Race = recode(Race,
                       "Black" = "Black or African-American",
                       "White" = "White",
                       "Hispanic" = "Hispanic or Latino",
                       "Asian" = "Asian",
                       "Native" = "American Indian and Alaska Native"))

us_dem <- read.csv(here::here("dataset", "us_cities_demographics.csv"), sep=";")

# pivot so that there is only one observation for each city, 
#   each race has its own column w/count
us_dem_wid <- us_dem |> 
  pivot_wider(names_from = "Race", values_from = "Count")

# inner join to keep only the data that has a match from each dataset, 
police_dem <- inner_join(us_dem_wid, police_f, by = c("City" = "City", "State.Code" = "State"), relationship = "many-to-many") |>
  group_by(Name, City, State) |>
  filter(n() == 1) |>
  ungroup()

# remove the observations with missing Race values as race is the main variable of interest
police_dem <- police_dem |> filter(Race != "")

# save combined dataset in dataset folder
save(police_dem, file = here::here("dataset/police_demo_combined.RData"))

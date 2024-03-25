#load data
library(tidyverse)
police_data <- read_csv(here::here("dataset", "police_fatalities.csv"))

#clean data
police_data_clean <- police_data

write_rds(police_data_clean, file = here::here("dataset", "police_refusal_clean.rds"))

save(police_data_clean, file = here::here("dataset/police_refusal.RData"))


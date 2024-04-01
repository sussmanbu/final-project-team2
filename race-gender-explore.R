prc <- police_refusal_clean

library(tidyverse)

prc |> 
  na.omit() |>  
  ggplot(aes(x = Race, fill = Gender)) + 
  geom_bar()


prc |> 
  na.omit() |> 
  ggplot(aes(x = State)) + geom_bar()

prc |> na.omit() |> group_by(State) |> summarize(n = n()) |> arrange(-n)
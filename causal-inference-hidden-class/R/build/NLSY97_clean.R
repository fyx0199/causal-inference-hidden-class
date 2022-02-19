library(stats)
library(here)
library(kableExtra)
library(rlang)
library(ggthemes)
library(tidyverse)
library(janitor)
library(magrittr)
library(glue)
library(lubridate)
library(haven)
library(snakecase)
library(sandwich)
library(gganimate)
library(gapminder)
library(stargazer)
library(plyr)
library(dplyr)


read.csv("/Users/yf/causal-inference-hidden-class/data/NLSY97.csv") %>%
  
  
  mutate(across(starts_with("E"), ~case_when(
    .x < 0   ~ NA_real_,
    .x == 99 ~ NA_real_,
    TRUE     ~ .x
  ))) %>%
  filter(if_any(starts_with("E"), ~!is.na(.x))) %>%
  rowwise() %>%
  dplyr::mutate(total_incarc = sum(c_across(starts_with("E")), na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(gender = if_else(R0536300 == 1, "Male", "Female")) %>%
  mutate(race = case_when(
    R1482600 == 1 ~ "Black",
    R1482600 == 2 ~ "Hispanic",
    R1482600 == 3 ~ "Mixed Race (Non-Hispanic)",
    R1482600 == 4 ~ "Non-Black / Non-Hispanic",
  )) %>%
  select(race, gender, total_incarc) %>%
  write_csv("/Users/yf/causal-inference-hidden-class/data/NLSY97_clean.csv")

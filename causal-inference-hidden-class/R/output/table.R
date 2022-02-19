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

read_csv("/Users/yf/causal-inference-hidden-class/data/NLSY97_clean.csv") %>%
  
  group_by(race, gender) %>%
  summarize(total_incarc = mean(total_incarc)) %>%
  
  pivot_wider(names_from = race, values_from = total_incarc) %>%
  
  rename_with(to_title_case) %>%
  
  kbl(
    caption = "Mean incarcerations in 2002 by Race and Gender",
    booktabs = TRUE,
    format = "latex",
    label = "tab:summarystats"
  ) %>%
  kable_styling(latex_options = c("striped", "HOLD_position")) %>%
  
  write_lines("/Users/yf/causal-inference-hidden-class/tables/incarcerations_by_racegender.tex")

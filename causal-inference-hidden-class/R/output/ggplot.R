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
  ggplot(aes(race, total_incarc, fill = gender)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    x = "Race", 
    y = "Mean incarcerations", 
    fill = "Gender",
    title = "Mean Number of incarceration in 2002 by Race and Gender") +
  theme_minimal() +
  scale_fill_economist()

ggsave(here("figures/incarcerations_by_racegender.png"), width=8, height=4.5)

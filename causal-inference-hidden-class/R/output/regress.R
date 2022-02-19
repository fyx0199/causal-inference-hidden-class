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


model <- 
  read_csv(here("data/NLSY97_clean.csv")) %>%
  lm(total_incarc ~ race + gender, data = .)


se <- model %>% vcovHC %>% diag %>% sqrt


covariate.labels <- names(coef(model))[-1] %>% str_replace("(^race)|(^gender)", "")

stargazer(
  model,
  se = list(se),
  covariate.labels = covariate.labels,
  dep.var.labels = "incarcerations in 2002",
  out = here("tables/regress_incarcerations_by_racegender.tex"),
  title = "Regression Output. Omitted category is Black Females.",
  label = "tab:regression"
)
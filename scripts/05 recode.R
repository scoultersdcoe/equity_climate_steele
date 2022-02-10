library(tidyverse)
library(here)

helix_results <- readRDS(here("data", "processed", "helix_clean.rds"))

helix_recode <- helix_results %>% 
  select(id, belong:problem, look:racism_impact, uncom_gender:uncom_disable, unsafe, 
         harassment:slurs_adults) %>%
  mutate(across(.cols = belong:slurs_adults, 
                ~ (case_when(
                  . == "Strongly disagree" ~ 1,
                  . == "Somewhat disagree" ~ 2,
                  . == "Neither agree nor disagree" ~ 3,
                  . == "Somewhat agree" ~ 4,
                  . == "Strongly agree" ~ 5,
                  . == "No" ~ 0,
                  . == "Yes" ~ 1,
                  . == "Maybe" ~ 0,
                  . == "Not at all true" ~ 1,
                  . == "Mostly untrue" ~ 2,
                  . == "Somewhat true" ~ 3,
                  . == "Very true" ~ 4,
                  . == "I'm not sure." ~ 0))))


saveRDS(helix_recode, here("data", "processed", "helix_recode.rds"))

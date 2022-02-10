library(qualtRics) #https://cran.r-project.org/web/packages/qualtRics/vignettes/qualtRics.html
library(here)
library(tidyverse)

qualtrics_api_credentials(api_key = "XJ0XDiedax2UyvMH0UDJxaFbk5E2ZZlvgI8Vl4VU", 
                          base_url = "iad1.qualtrics.com",
                          install = TRUE,
                          overwrite = TRUE)

surveys <- all_surveys() 

steele_results <- fetch_survey(surveyID = surveys$id[84], 
                         save_dir = "../equity_climate_steele/data/raw/", 
                         verbose = TRUE)


saveRDS(steele_results, here("data", "raw", "steele_results.rds")) # Write file
write_csv(steele_results, file = here("data", "raw", "steele_results.csv"))

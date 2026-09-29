# Align variable names in the processed survey responses file with other years
# to facilitate time series analyses

library(dplyr)

# Import processed survey responses
srvy <- readRDS("data/2-final/mh_survey_results.rds")

# Import codebook for aligning variable names
vars <- readxl::read_excel("data/1-source/codebook-align-var-names.xlsx")

vars <- vars |>
  mutate(var2 = ifelse(is.na(var2), var1, var2))

colnames(srvy) <- vars$var2

# Remove variables with the outdated scoring for social isolation
srvy <- srvy |>
  select(-starts_with("si_"))

saveRDS(srvy, "data/2-final/mhs_responses_2024.rds")

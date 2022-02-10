library(janitor)
# skip the first XX rows because Qualtrics stores un-needed information there.
steele_mutate <- steele_results %>%
  #row_to_names(row_number = 1, remove_row = F, remove_rows_above = F) %>%
  #slice(-c(1:3)) %>%
  # Select necessary columns
  select(id = ResponseId, duration = `Duration (in seconds)`, 
         progress = Progress, start_date = StartDate, end_date = EndDate,
         starts_with("Q")) %>%
  # Rename and tidy 
  rename(belong = Q3, care = Q4, respect = Q5, listen = Q6, accept = Q7, pronouns = Q8,
         allow = Q9, bathroom = Q10, learn = Q11, talk = Q12, value = Q13, 
         version = Q14, problem = Q15, intervene = Q16, staff_uncom_gender = Q17_1, 
         staff_uncom_religion = Q17_2, staff_uncom_race = Q17_3, 
         staff_uncom_orient = Q17_4, staff_uncom_accent = Q17_5, 
         student_uncom_gender = Q18_1, student_uncom_religion = Q18_2, 
         student_uncom_race = Q18_3, student_uncom_orient = Q18_4, 
         student_uncom_accent = Q18_5, look = Q20, contribution = Q21, 
         curriculum = Q22, racism_impact = Q23, get_along = Q24, safe = Q25, 
         harassment = Q27, issues = Q28, bullies = Q29, tolerated = Q30, 
         grade = Q36, race_AmIndian = Q37_3, race_asian = Q37_2, race_black = Q37_4,
         race_filipino = Q37_7, race_hispanic = Q37_10, race_middle = Q37_9, 
         race_native = Q37_1, race_two = Q37_8, race_white = Q37_5, race_other = Q37_6,
         identity = Q39, trans = Q40, sex = Q41) %>%
  clean_names()

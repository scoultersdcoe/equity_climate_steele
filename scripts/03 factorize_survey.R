# store survey responses for factorizing
clean_names <- tribble(
  ~ variable_name, ~ new_name,
  "belong", "I feel like I belong at Steele Canyon.",
  "care", "Steele Canyon staff care about me.",
  "respect", "Steele Canyon staff treat everyone with respect.",
  "listen", "Steele Canyon staff listen to me.",
  "accept", "Students at Steele Canyon accept me.",
  "pronouns", "My teachers refer to me by my chosen pronouns in class (he/him she/her, they/theirs).",
  "allow", "My teachers allow me to use my chosen pronouns in class (he/him, she/her, they/theirs).",
  "bathroom", "I feel comfortable using the bathroom that matches my identity at Steele Canyon.",
  "learn", "I believe my teachers are confident that I can learn.",
  "talk", "There is an adult at school I can talk with if I need help.",
  "value", "I feel valued and respected at Steele Canyon.",
  "version", "Adults at Steele Canyon encourage me to be the best version of myself.",
  "problem", "I know the appropriate person to go to if I have a problem at Steele Canyon.",
  'intervene', "Adults at Steele Canyon immediately intervene when they hear inappropriate comments.",
  "staff_uncom_gender", "A staff member has made me feel uncomfortable because of my gender.",
  "staff_uncom_religion", "A staff member has made me feel uncomfortable because of my religion.",
  "staff_uncom_race", "A staff member has made me feel uncomfortable because of my race or ethnicity.",
  "staff_uncom_orient", "A staff member has made me feel uncomfortable because of my sexual orientation.",
  "staff_uncom_accent", "A staff member has made me feel uncomfortable because of my accent.",
  "student_uncom_gender", "A student has made me feel uncomfortable because of my gender.",
  "student_uncom_religion", "A student member has made me feel uncomfortable because of my religion.",
  "student_uncom_race", "A student member has made me feel uncomfortable because of my race or ethnicity.",
  "student_uncom_orient", "A student member has made me feel uncomfortable because of my sexual orientation.",
  "student_uncom_accent", "A student member has made me feel uncomfortable because of my accent.",
  "look", "I see pictures, artwork, and books that look like me at this school.",
  "contribution", "We have books and lessons...showcase...people of different races, gender, cultures.",
  "curriculum", "The curriculum we use in my classes at Steele Canyon is relevant to me.",
  "racism_impact", "In my classes, we have discussed how racism impacts us and/or our community.",
  "get_along", "Our classroom lessons teach us about how to get along with other people who are different.",
  "safe", "I feel safe at school.",
  "harassment", "Adults immediately stop harassment at Steele Canyon.",
  "issues", "At Steele Canyon, I know who to go to if issues of race, bullying, or harassment come up at school.",
  "bullies", "Nothing happens to bullies here.",
  "tolerated", "Harassment is not tolerated at Steele Canyon.",
  "grade", "What grade are you in this year (2021-2022)?",
  "race", "What is your race?",
  "identity", "Which of the following best describes your gender identity?",
  "trans", "Do you identify as transgender?",
  "sex", "Which of the following best describes your sexual orientation?"
)

agreement_lev <- c("Strongly disagree", "Somewhat disagree", "Neither agree nor disagree", 
               "Somewhat agree", "Strongly agree")

yes_lev <- c("No", "Maybe", "Yes")

true_lev <- c("Not at all true", "Mostly untrue", "Somewhat true", "Very true", "I'm not sure.")

grade_lev <- c("9th", "10th", "11th", "12th")

race_lev <- c("American Indian or Alaska Native", "Asian", "Black or African American",
          "Filipino", "Hispanic", "Middle Eastern, Arabic", "Native Hawaiian or Pacific Islander",
          "Two or more races", "White", "Other")
  
identity_lev <- c("Female", "Male", "Non-binary", "Prefer not to say")

trans_lev <- c("No", "Yes", "Prefer not to say")
  
sex_lev <- c("Bisexual", "Gay or Lesbian", "Heterosexual", "Not sure", "Prefer not to say",
                 "Other")


# factorize survey variables
steele_factorize <- steele_mutate %>%
  mutate_at(vars(belong:intervene, look:safe),
            list(~factor(., levels = agreement_lev, ordered = TRUE))) %>%
  mutate_at(vars(staff_uncom_gender:student_uncom_accent),
            list(~factor(., levels = yes_lev, ordered = TRUE))) %>%
  mutate_at(vars(harassment:tolerated),
            list(~factor(., levels = true_lev, ordered = TRUE))) %>%
  mutate(grade = factor(grade, levels = 
                               grade_lev, ordered = TRUE),
         race = factor(race, levels =
                         race_lev, ordered = TRUE),
         identity = factor(identity, levels =
                           identity_lev, ordered = TRUE),
         trans = factor(trans, levels = 
                          trans_lev, ordered = TRUE),
         sex = factor(sex, levels = 
                               sex_lev, ordered = TRUE),
         
  )
# check factorization
viz <- skimr::skim(steele_factorize)
viz

# Save final data
saveRDS(steele_factorize, here("data", "processed", "steele_clean.rds"))
write.csv(steele_factorize, file = 
            here("data", "processed", "steele_clean.csv"))

library(tidyverse)
library(here)

steele_results <- readRDS(here("data", "processed", "steele_clean.rds"))


demo_grade <- steele_results %>%
  count(grade) %>%
  ggplot(mapping = aes(x = factor(grade), y = n)) +
  geom_col() +
  geom_text(mapping = aes(label = n), vjust = -1) +    
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  labs(x = NULL,
       y = NULL)

demo_grade_plot <- sdcoe_plot(demo_grade,
                            sdcoe_logo_text(),
                            ncol = 1, heights = c(30, 1))

#Another way of creating a stacked bar chart...ggplot()+geom_bar(data = fig_1, aes(x = reorder(variable_name,value), y=proportion, fill=value), position="stack", stat="identity")+
#ggsave("./output/figures/likert_4.png", width = 8, height = 6.5)

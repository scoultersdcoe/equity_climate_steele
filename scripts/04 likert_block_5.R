library(tidyverse)
library(here)

steele_results <- readRDS(here("data", "processed", "steele_clean.rds"))


# Likert Items
likert_items_block_5 <- select(steele_results, harassment:tolerated)

names(likert_items_block_5) <- c(
  harassment = "Adults immediately stop harassment at Steele Canyon.",
  issues = "At Steele Canyon, I know who to go to if issues of race, bullying, or harassment come up at school.",
  bullies = "Nothing happens to bullies here.",
  tolerated = "Harassment is not tolerated at Steele Canyon.")
  
items_long_block_5 <- likert_items_block_5 %>%
  pivot_longer(everything(), # pivot every variable longer
               names_to = "variable_name", #rename variables and values
               values_to = "value"
  ) 

fig_5 <- items_long_block_5 %>%
  group_by(variable_name, value) %>%
  dplyr::summarise(cnt = n()) %>% # summarise number of values by variable name
  mutate(proportion = round(cnt / sum(cnt), 3)) # get proportion b variable name


likert_5 <- ggplot(# plot data in a stacked bar chart
  fig_5, mapping = aes(x = variable_name, y = proportion, fill = value,
                       label = scales::percent(proportion, accuracy = 1L))) +
  geom_col(position =  "fill") +
  geom_text(aes(color = value),
            position = position_stack(vjust=0.5),
            show.legend = F) +
  scale_color_manual(values = c("white", "black", "black", "black", "black")) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)),
                     labels = scales::percent) +
  labs(x = NULL,
       y = NULL,
       fill = "") +  
  theme(axis.line = element_blank(),
        legend.position = "top") +
  guides(fill = guide_legend(reverse = TRUE)) +
  coord_flip()

likert_plot_5 <- sdcoe_plot(likert_5,
                            sdcoe_logo_text(),
                            ncol = 1, heights = c(30, 1))

#Another way of creating a stacked bar chart...ggplot()+geom_bar(data = fig_1, aes(x = reorder(variable_name,value), y=proportion, fill=value), position="stack", stat="identity")+
#ggsave("./output/figures/likert_5.png", width = 8, height = 6.5)

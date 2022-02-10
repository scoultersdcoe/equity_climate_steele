library(tidyverse)
library(here)

steele_results <- readRDS(here("data", "processed", "steele_clean.rds"))


# Likert Items
likert_items_block_1 <- select(steele_results, belong:intervene)

names(likert_items_block_1) <- c(
  belong = 'I feel like I belong at Steele Canyon.',
  care = "Steele Canyon staff care about me.",
  respect = "Steele Canyon staff treat everyone with respect.",
  listen = "Steele Canyon staff listen to me.",
  accept = "Students at Steele Canyon accept me.",
  pronouns = "My teachers refer to me by my chosen pronouns in class (he/him she/her, they/theirs).",
  allow = "My teachers allow me to use my chosen pronouns in class (he/him, she/her, they/theirs).",
  bathroom = "I feel comfortable using the bathroom that matches my identity at Steele Canyon.",
  learn = "I believe my teachers are confident that I can learn.",
  talk = "There is an adult at school I can talk with if I need help.",
  value = "I feel valued and respected at Steele Canyon.",
  version = "Adults at Steele Canyon encourage me to be the best version of myself.",
  problem = "I know the appropriate person to go to if I have a problem at Steele Canyon.",
  intervene = "Adults at Steele Canyon immediately intervene when they hear inappropriate comments.")

items_long_block_1 <- likert_items_block_1 %>%
  pivot_longer(everything(), # pivot every variable longer
               names_to = "variable_name", #rename variables and values
               values_to = "value"
  ) 

fig_1 <- items_block_1_long %>%
  group_by(variable_name, value) %>%
  dplyr::summarise(cnt = n()) %>% # summarise number of values by variable name
  mutate(proportion = round(cnt / sum(cnt), 3)) # get proportion b variable name


likert_1 <- ggplot(# plot data in a stacked bar chart
  fig_1, mapping = aes(x = variable_name, y = proportion, fill = value,
                       label = scales::percent(proportion, accuracy = 1L))) +
  geom_col(position =  "fill") +
  geom_text(aes(color = value),
            position = position_stack(vjust=0.5),
            show.legend = F) +
  scale_color_manual(values = c("white", "white", "white", "black", "black")) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)),
                     labels = scales::percent) +
  labs(x = NULL,
       y = NULL,
       fill = "") +  
  theme(axis.line = element_blank(),
        legend.position = "top") +
  guides(fill = guide_legend(reverse = TRUE)) +
  coord_flip()


likert_plot_1 <- sdcoe_plot(likert_1,
                         sdcoe_logo_text(),
                         ncol = 1, heights = c(30, 1))

#Another way of creating a stacked bar chart...ggplot()+geom_bar(data = fig_1, aes(x = reorder(variable_name,value), y=proportion, fill=value), position="stack", stat="identity")+
#ggsave("./output/figures/likert_plot_1.png")

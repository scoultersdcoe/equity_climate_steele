library(tidyverse)
library(here)

steele_results <- readRDS(here("data", "processed", "steele_clean.rds"))


# Likert Items
likert_items_block_4 <- select(steele_results, look:get_along)

names(likert_items_block_4) <- c(
  look = 'I see pictures, artwork, and books that look like me at this school.',
  contribution = "We have books and lessons...showcase...people of different races, gender, cultures.",
  curriculum = "The curriculum we use in my classes at Steele Canyon is relevant to me.",
  racism_impact = "In my classes, we have discussed how racism impacts us and/or our community.",
  get_along = "Our classroom lessons teach us about how to get along with other people who are different.",
  safe = "I feel safe at school.")

items_long_block_4 <- likert_items_block_4 %>%
  pivot_longer(everything(), # pivot every variable longer
               names_to = "variable_name", #rename variables and values
               values_to = "value"
  ) 

fig_4 <- items_long_block_4 %>%
  group_by(variable_name, value) %>%
  dplyr::summarise(cnt = n()) %>% # summarise number of values by variable name
  mutate(proportion = round(cnt / sum(cnt), 3)) # get proportion b variable name


likert_4 <- ggplot(# plot data in a stacked bar chart
  fig_4, mapping = aes(x = variable_name, y = proportion, fill = value,
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

likert_plot_4 <- sdcoe_plot(likert_4,
                            sdcoe_logo_text(),
                            ncol = 1, heights = c(30, 1))

#Another way of creating a stacked bar chart...ggplot()+geom_bar(data = fig_1, aes(x = reorder(variable_name,value), y=proportion, fill=value), position="stack", stat="identity")+
#ggsave("./output/figures/likert_2.png", width = 8, height = 6.5)

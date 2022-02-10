library(tidyverse)
library(here)

steele_results <- readRDS(here("data", "processed", "steele_clean.rds"))


# Likert Items
likert_items_block_2 <- select(steele_results, staff_uncom_gender:staff_uncom_accent)

names(likert_items_block_2) <- c(
  staff_uncom_gender = "A staff member has made me feel uncomfortable because of my gender.",
  staff_uncom_religion = "A staff member has made me feel uncomfortable because of my religion.",
  staff_uncom_race = "A staff member has made me feel uncomfortable because of my race or ethnicity.",
  staff_uncom_orient = "A staff member has made me feel uncomfortable because of my sexual orientation.",
  staff_uncom_accent = "A staff member has made me feel uncomfortable because of my accent.")

items_long_block_2 <- likert_items_block_2 %>%
  pivot_longer(everything(), # pivot every variable longer
               names_to = "variable_name", #rename variables and values
               values_to = "value"
  ) 

fig_2 <- items_long_block_2 %>%
  group_by(variable_name, value) %>%
  dplyr::summarise(cnt = n()) %>% # summarise number of values by variable name
  mutate(proportion = round(cnt / sum(cnt), 3)) # get proportion b variable name


likert_2 <- ggplot(# plot data in a stacked bar chart
  fig_2, mapping = aes(x = variable_name, y = proportion, fill = value,
                       label = scales::percent(proportion, accuracy = 1L))) +
  geom_col(position =  "fill") +
  geom_text(aes(color = value),
            position = position_stack(vjust=0.5),
            show.legend = F) +
  scale_color_manual(values = c("white", "black", "black")) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)),
                     labels = scales::percent) +
  labs(x = NULL,
       y = NULL,
       fill = "") +  
  theme(axis.line = element_blank(),
        legend.position = "top") +
  guides(fill = guide_legend(reverse = TRUE)) +
  coord_flip()

likert_plot_2 <- sdcoe_plot(likert_2,
                            sdcoe_logo_text(),
                            ncol = 1, heights = c(30, 1))

#Another way of creating a stacked bar chart...ggplot()+geom_bar(data = fig_1, aes(x = reorder(variable_name,value), y=proportion, fill=value), position="stack", stat="identity")+
#ggsave("./output/figures/likert_3.png", width = 8, height = 6.5)

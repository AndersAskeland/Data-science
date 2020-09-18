# Packages
library(ggplot2)
library(dplyr)
library(tidyverse)
library(ggthemes)
library(extrafont)

# Import
avacado_data <- read_csv("Data/Example/avocado.csv") %>%
  filter(region == c("Midsouth", "Northeast", "Plains", "Southeast", "West"), type == "organic")

# Color palatte
my_colors <- c("#A6611A", "#DFC27D", "#5e6c6b", "#80CDC1", "#018571")

# Graph
avacado_data %>%
  mutate(isNortheast = (region == "Northeast")) %>% # Creates a specific column with T & F for a logical condition
  ggplot(aes(x = Date, y = AveragePrice, color = region)) +
  geom_line(aes(linetype = isNortheast), size = 1.5, alpha = 0.8) + # Linetype is based on linetype, also larger size and transparancy
  labs(title = "Average Avacado Prices in the US over time", # Set labels
       subtitle = "How do avacado prices differ by region?",
       x = "Date",
       y = "Average Price (USD)",
       color = "Region") +
  theme_fivethirtyeight() + #Set themes
  theme(axis.title = element_text(), text = element_text(family = "Roboto"))+
  scale_linetype_manual(values = c("dashed", "solid"), guide = "none") + # Sets which should be dashed
  scale_color_manual(values = my_colors) # color palatte 
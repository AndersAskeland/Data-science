# Install packages
devtools::install_github("jespermaag/gganatogram")

# Load packages
library(gganatogram)
library(dplyr)
library(viridis)
library(gridExtra)

# Data
hgMale <- gganatogram(data=hgMale_key, fillOutline='#a6bddb', organism='human', sex='male', fill="colour") + 
  theme_void()
organPlot <- data.frame(organ = "liver", 
                        type = "digestion", 
                        colour = "orange", 
                        value = 2, 
                        stringsAsFactors=F)

# One anatogram
gganatogram(data=organPlot, fillOutline='#a6bddb', organism='human', sex='male', fill="colour")
organPlot2 <- data.frame(organ = "liver", 
                        type = "digestion", 
                        colour = "orange", 
                        value = 100, 
                        stringsAsFactors=F)

gganatogram(data=organPlot2, fillOutline='#a6bddb', organism='human', sex='male', fill="colour")

# Compare groups
compareGroups <- rbind(data.frame(organ = "liver", 
                                  colour = "orange", 
                                  value = 5, 
                                  type = 'Normal', 
                                  stringsAsFactors=F),
                       data.frame(organ = "liver", 
                                  colour = "orange", 
                                  value = 40, 
                                  type = 'Obese', 
                                  stringsAsFactors=F))
# Draw
gganatogram(data=compareGroups, fillOutline='#a6bddb', organism='human', sex='male', fill="value") + 
  theme_void() +
  facet_wrap(~type) +
  scale_fill_gradient(low = "white", high = "red") 
    
# Library
library(flowCore)
library(ggcyto)
library(tidyverse)

#### 1. Read data
# Read data as a flowset (several files at once)
fs <- read.flowSet(path = "example_data//", pattern = ".fcs", alter.names = TRUE)  # Alter names renames files to valid R names using make.names


# Show samle names information
pData(fs)

# Extract stuff - This example extracts WELL into seperate column
pData(fs)$well <- gsub(".*_.*_(.*)_.*.fcs","\\1",sampleNames(fs)) # extract well from name and add new 'well' column


# CHange column names - This might not be needed on apogee
colnames(fs)[colnames(fs)=="FITC.A"] <- "GFP"
colnames(fs)[colnames(fs)=="Pacific.Blue.A"] <- "BFP"


#### 2. Gating
# Create gateset
gs <- GatingSet(fs)

# Manual gating using polygongate
g.singlets <- polygonGate(filterId = "Singlets","FSC.A"=c(2e4,25e4,25e4,2e4),"FSC.H"=c(0e4,12e4,18e4,6e4)) # define gate

# Show image
ggcyto(gs[[1]],aes(x=FSC.A,y=FSC.H),subset="root")+geom_hex(bins = 200)+geom_gate(g.singlets)+ggcyto_par_set(limits = "instrument") # check gate



# Add gate to gating thiong
gs_pop_add(gs,g.singlets) # add gate to GatingSet


# Library
library(flowCore)
library(ggcyto)
library(tidyverse)

#### 1. Read data
# Read some data as a flowset (several files at once)
fs <- read.flowSet(path = "example_data/Apogee/test/", pattern = ".fcs", alter.names = TRUE)  # Alter names renames files to valid R names using make.names

## read a single file
ff <- read.FCS(filename = "example_data/Apogee/20181127_ExoFCM_Compensation_PE_CD9_10ul_01_0.fcs")


# Display data
pData(ff)

colnames(ff)

# Gate on edge/rectangle
gs <- GatingSet(ff)  ## Make it a gatingset


rg1 <- rectangleGate("405-MALS(Peak)" = c(1, Inf), filterId = "edge")  ## Create gate

gs_pop_add(ff, rg1, parent = "root") ## Add gate to file



gs <- GatingSet(fs)


g.singlets <- polygonGate(filterId = "Singlets","FSC.A"=c(2e4,25e4,25e4,2e4),"FSC.H"=c(0e4,12e4,18e4,6e4)) # define gate


# Plot apogeemix
ggcyto(ff, aes(x="405-MALS(Peak)", y="405-Org(Peak)"), subset="root") +
  geom_hex(bins = 100)



raw_values <- ff@exprs
data.table <- melt(ff@exprs)
dataFrame <- as_data_frame(ff@exprs)
dataTable <- as.data.table(ff@exprs)
compare_speed <- list(summary(dataFrame), summary(dataTable))

test1 <- microbenchmarkCore::microbenchmark(summary(dataFrame), times = 2)
test2 <- microbenchmarkCore::microbenchmark(summary(dataTable), times = 2)
test3 <- microbenchmarkCore::microbenchmark(summary(raw_values), times = 2)


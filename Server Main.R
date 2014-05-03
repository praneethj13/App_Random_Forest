# Load libraries -------------------------------------------------------------------
library(shiny)
library(shinyBS)
library(randomForest) # Non-Parametric Model
library(ggplot2)   # Main Graphics
library(caret)     # Main Analysis
library(grid)      # Support for Graphics
library(gridExtra) # Support for Graphics
library(scales)    # Support for Graphics
library(reshape2)  # Data Transformation
library(plyr)      # Data Transformation

# Load Random Forest Model
source("1 Random Forest.R")

# Graphical Parameters ---------------------------------------------------------------------------
# Hardcoded Graphical Parameters
# Temporary only
clrs <- c("#E69F00", "#56B4E9", "#8B4513", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#551A8B", "#999999")
fs <- 20
fs.sub <- 0
cs <- 6
cs.sub <- 1

# Loads Data Preparation Functions
source("2 Data Preparation.R")

# Loads Plot functions
source("3 Graphic Plots.R")


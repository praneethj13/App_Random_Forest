## Load libraries -------------------------------------------------------------------

# This function tests & loads packages required
pkgTest <- function(x)
{
  if (!require(x, character.only = TRUE))
  {
    install.packages(x, dep=TRUE)
    if(!require(x, character.only = TRUE)) stop("Package not found")
  }
}

pkgTest("shiny")
pkgTest("shinyBS")
pkgTest("randomForest") # Non-Parametric Model
pkgTest("ggplot2")   # Main Graphics
pkgTest("caret")     # Main Analysis
pkgTest("grid")      # Support for Graphics
pkgTest("gridExtra") # Support for Graphics
pkgTest("scales")    # Support for Graphics
pkgTest("reshape2")  # Data Transformation
pkgTest("plyr")      # Data Transformation

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
ts <- 30
ts.pdf <- 20

# Loads Data Preparation Functions
source("2 Data Preparation.R")

# Loads Plot functions
source("3 Graphic Plots.R")


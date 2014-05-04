# This is the user-interface model for Random Forest:
library(shiny)
library(shinyBS)

shinyUI(
  navbarPage(
    theme = "bootstrap.css",
    "Random Forest !!", # App Heading
    source("ui_Tab1_Load Data.R", local=TRUE)$value,
    source("ui_Tab2_Classification.R", local=TRUE)$value,
    source("ui_Tab3_Simulator.R", local=TRUE)$value        
  )
)



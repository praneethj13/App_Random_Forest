# Tab3: Random Forest Simulator
tabPanel(
  "Simulator",
  sidebarLayout(
    sidebarPanel(
      bsCollapse(
        # Load Model
        bsCollapsePanel("Upload Random Forest Model",

          fileInput("rfmodel_file", "", accept = ".RData")
          
          ), multiple = FALSE)
      ),
    
    mainPanel(dataTableOutput("org_data_table"))
    )
  )
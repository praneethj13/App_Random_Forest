# Tab3: Random Forest Simulator
tabPanel(
  "Simulator",
  sidebarLayout(
    sidebarPanel(
      bsCollapse(
        # Load RF Model
        bsCollapsePanel(
          "Upload Random Forest Model",
          fileInput("rfmodel_file", "", accept = ".RData")),
        
        # Download Original Data & New Data Format
        bsCollapsePanel(
          "Upload New Data",
          fileInput("file_new_data", "Upload data",
                    accept = c("text/csv",
                               "text/comma-separated-values",
                               "text/tab-separated-values",
                               "text/plain",
                               ".csv",
                               ".tsv")
          )
        ),
        multiple = FALSE)
    ),
    
    mainPanel(
      uiOutput("ui_tab3")
    )
  )
)
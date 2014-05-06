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
          "Download Original Data",
          downloadButton("dl_org_data", label = "Original Data", class = "dl_btn"),
          hr(),
          downloadButton("dl_data_format", label = "New Data Format", class = "dl_btn")
        ),
        
        bsCollapsePanel(
          "Download Predicted Data",
          downloadButton("dl_pred_data", label = "Predicted Data", class = "dl_btn")
        ),
        
        multiple = FALSE)
    ),
    
    mainPanel(
      tabsetPanel(type = "pills",
        tabPanel("Original Data", dataTableOutput("org_data_table")),
        tabPanel("Predicted Data", dataTableOutput("pred_data_table"))
      )
      
    )
  )
)
# Tab1: Loading the Data 
tabPanel(
  "Load Data",
  sidebarLayout(
    # Upload CSV File
    sidebarPanel(
      tags$head(tags$link(rel="stylesheet", type="text/css", href="style.css")),
      
      fileInput("file1", "Upload respondent level data",
                accept = c("text/csv",
                           "text/comma-separated-values",
                           "text/tab-separated-values",
                           "text/plain",
                           ".csv",
                           ".tsv"
                )
      ),
      
      # Comments on Uploading CSV File
      p("Load data in", code(".csv or .tab"), "format only.",
        "If you want a sample", code(".csv"), "to upload, you can first download the",
        a(href = "Sample_Data.csv", "Sample.csv"),
        "file, and then try uploading them."),
      
      p("Please keep", span("Resp ID & Cluster ID", style="color:red"), "variables first,",
        "followed by demographics & other variables."),
      # End Comments
      
      tags$hr(),
      p(strong("Random Forest"), " is one of the top regression/classification model, 
          widely used across several industries. Presently it is the defacto model used for 
          all segment classification(Seg Ident Classification) projects.")
    ),
    # Data shown in the main panel
    mainPanel(dataTableOutput("dataTable"))
  )
  
)
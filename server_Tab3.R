## Display data tables ---------------------------------------------------------
# For displaying the Original Data
rf3 <- reactiveValues()

org_data <- reactive({
  if (is.null(input$rfmodel_file)) return(NULL) else
  {
    load(input$rfmodel_file$datapath)
    rf3 <<- rf2
    v <- rf2$org_data   
    return(v)
  }  
})


# Displays Data Table
output$org_data_table <- renderDataTable({ 
  org_data()}, options = list(iDisplayLength = 10)
)

# Data Inputs. Active once data is loaded
new_dat <- reactive({
  if (is.null(input$file_new_data)) return(NULL)
  read.csv(input$file_new_data$datapath)
})

# For displaying the prediction (class & probability) on new data
pred_data <- reactive({
  if (is.null(input$rfmodel_file)) return(NULL) else
  {
    load(input$rfmodel_file$datapath)
    v <- rf_predict(rf2, new_dat()) # This needs to be changed
    return(v)
  }
  
})

# Displays Uploaded Data Table
output$new_data_table <- renderDataTable({ 
  new_dat()}, options = list(iDisplayLength = 10)
)

# Displays Predicted Data Table
output$pred_data_table <- renderDataTable({ 
  pred_data()}, options = list(iDisplayLength = 10)
)


## Download Data ---------------------------------------------------------------

# Download Original data
output$dl_org_data <- downloadHandler(
  filename = function() {
    paste("Original Data.csv")
  },
  content = function(file) {
    write.csv(rf3$org_data, file)
  }
)

# Download data format
output$dl_data_format <- downloadHandler(
  filename = function() {
    paste("Data Format.csv")
  },
  content = function(file) {
    write.csv(rf3$org_data_wo_class, file)
  }
)

# Download Predicted data
output$dl_pred_data <- downloadHandler(  
  filename = function() {
    paste("Predicted Data.csv")
  },
  content = function(file) {
    write.csv(pred_data(), file)
  }
)


## Dynamic User Interface-------------------------------------------------------
output$ui_tab3 <- renderUI({
  if(!is.null(input$rfmodel_file)){
    dynamic_ui_tab3()
  } else NULL
})

dynamic_ui_tab3 <- reactive({
  tabsetPanel(
    type = "pills",
    # Original Data Tab          
    tabPanel("Original Data", 
             downloadButton("dl_org_data", label = "Original Data", class = "dl_btn2"),
             downloadButton("dl_data_format", label = "Upload Data Format", class = "dl_btn2"),
             dataTableOutput("org_data_table")),
    # Original Data Tab          
    tabPanel("Uploaded Data", dataTableOutput("new_data_table")),
    # Predicted Data Tab
    tabPanel("Predicted Data", 
             downloadButton("dl_pred_data", label = "Predicted Data", class = "dl_btn2"),
             dataTableOutput("pred_data_table"))
    
  )
})

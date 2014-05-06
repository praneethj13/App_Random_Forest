## Display data tables ---------------------------------------------------------
# For displaying the Original Data
org_data <- reactive({
  if (is.null(input$rfmodel_file)) return(NULL) else
  {
    load(input$rfmodel_file$datapath)
    v <- rf2$org_data
    return(v)
  }
  
})

# Displays Data Table
output$org_data_table <- renderDataTable({ 
  org_data()}, options = list(iDisplayLength = 10)
)

# For displaying the prediction (class & probability) on new data
pred_data <- reactive({
  if (is.null(input$rfmodel_file)) return(NULL) else
  {
    load(input$rfmodel_file$datapath)
    v <- rf_predict(rf2, rf2$org_data_wo_class) # This needs to be changed
    return(v)
  }
  
})

# Displays Data Table
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
    write.csv(rf2$org_data, file)
  }
)

# Download data format
output$dl_data_format <- downloadHandler(
  filename = function() {
    paste("Data Format.csv")
  },
  content = function(file) {
    write.csv(rf2$org_data_wo_class, file)
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

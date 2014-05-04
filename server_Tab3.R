# Data Inputs. Active once data is loaded
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

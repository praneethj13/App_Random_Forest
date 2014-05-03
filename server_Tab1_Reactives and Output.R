# Data Inputs. Active once data is loaded
dat <- reactive({
  if (is.null(input$file1)) return(NULL)
  read.csv(input$file1$datapath)
})

# VarNames. Active on data
varNames <- reactive({ 
  if(!is.null(dat())) v <- colnames(dat()) 
  else v <- NULL
})

# Displays Data Table
output$dataTable <- renderDataTable({ 
  dat()}, options = list(iDisplayLength = 10)
)

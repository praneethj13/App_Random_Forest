# Building RF Model -------------------------------------------------
rf1 <- reactive({
  if(!is.null(input$go_model)){
    if(input$go_model==0) return()
    d <- dat()[, -which(colnames(dat()) %in% input$var_Remove)] 
    v <- c(input$var_Keep, input$var_Clus)
    d <- d[, which(colnames(d) %in% v)] 
    isolate(
      rf1 <- rf_model1(data = d, train_size = (input$train_ss/100), 
                       var_clus = input$var_Clus, 
                       rf_ntree = input$rf_ntree, rf_mtry = input$rf_mtry)
      
    )
  } else return()
})

# Create a reactive value rf2 to store the random forest model rf1().
rf2 <- reactiveValues()
observe({
  if(!is.null(rf1()))
  isolate(
    rf2 <<- rf1()
  )
})


# Train Classification Accuracy & Confusion Table -------------------
train_accuracy <- reactive({
  if(!is.null(rf1())){
    v <- rf_accuracy(rf1()$confusion)
  } else v <- NULL
  v
})

train_confusion_table <- reactive({
  if(!is.null(rf1())){
    v <- rf_confusion_table(rf1()$confusion)
  } else v <- NULL
  v
})

# Test Classification Accuracy & Confusion Table -------------------
test_accuracy <- reactive({
  if(!is.null(rf1())){
    v <- rf1()
    v <- rf_accuracy(v$test$confusion)
  } else v <- NULL
  v
})

test_confusion_table <- reactive({
  if(!is.null(rf1())){
    v <- rf1()
    v <- rf_confusion_table(v$test$confusion)
  } else v <- NULL
  v
})

# Importance (Variable Importance) ---------------------------------
rf_importance1 <- reactive({
  if(!is.null(rf1())){
    v <- rf_Importance(importance(rf1()))
  } else v <- NULL
  v
})

# Proximity Data ---------------------------------
# 1. Used for MDS Plot
rf_prox_data1 <- reactive({
  if(!is.null(rf1())){
    v <- rf_prox_data(rf1())
  } else v <- NULL
  v
})

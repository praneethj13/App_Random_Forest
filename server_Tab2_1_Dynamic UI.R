## Tab2: Dynamic UI: Model Inputs & Selection -----------------------------------------

# Data Selection (User Interface)---------------------
output$dataSelection <- renderUI( {
  dynamicUi_ds()
})

dynamicUi_ds <- reactive({    
  list(
    selectInput(inputId = "var_Remove", label = "Select ID Variable", 
                choices = varNames(), selected = varNames()[1], 
                multiple = TRUE, selectize = TRUE),
    
    selectInput(inputId = "var_Clus", label ="Select Clus Variable", 
                choices = varNames(), selected = varNames()[2], 
                selectize = TRUE),
    
    selectInput(inputId = "var_Keep", label = "Select/Unselect independent variables..", 
                choices = varNames(), selected = varNames()[-c(1, 2)],
                multiple = TRUE, selectize = TRUE),
    br(), br(), br()
  )
})

# Model Inputs (User Interface)-----------------------

# # Calculating Optimum Mtry for Classification
# opt_mtry <- reactive({
#   if(!is.null(varNames())){
#     v <- varNames()
#     v <- v[-which(v %in% input$var_Remove)]
#     v <- v[-which(v %in% input$var_Clus)]
#     v <- v[which(v %in% input$var_Keep)]
#     v <- ceiling(sqrt(length(v)))
#   } else V <- NULL
#   v
# })

output$modelInputs <- renderUI( {
  dynamic_mi()
})

dynamic_mi <- reactive({
  list(
    # Size of Training Set
    sliderInput(inputId = "train_ss", label = "Training Set Size(in %)",
                min = 60, max = 80, value = 70, step = 5),
    # No.of Trees
    sliderInput(inputId = "rf_ntree", label = "Ntree",
                min = 100, max = 800, value = 200, step = 100),
    # Mtry
    sliderInput(inputId = "rf_mtry", label ="Mtry",
                min = 4, max = 10 , value = 7, step = 1)
  )
})

# Graphic Selection (User Interface) ------------------

# TabPanel titles
output$tp.acc_train <- renderUI({ if(!is.null(rf1())) h5("Classification Accuracy and confusion matrix (Train)") })
output$tp.acc_test <- renderUI({ if(!is.null(rf1())) h5("Classification Accuracy and confusion matrix (Test)") })
output$tp.impGini <- renderUI({ if(!is.null(rf1())) h5("Variable importance: Mean decrease in node impurity (Gini index)") })
output$tp.impTable <- renderUI({ if(!is.null(rf1())) h5("Variable importance: Predictor-response class importance matrix") })
output$tp.mds <- renderUI({ if(!is.null(rf1())) h5("2-D multi-dimensional scaling plot") })
output$tp.margins <- renderUI({ if(!is.null(rf1())) h5("Classification margins by response class (majority vote)") })
output$tp.pd <- renderUI({ if(!is.null(rf1())) h5("Partial dependence (marginal effect) of a given explanatory variable on a given response class") })
output$tp.outliers <- renderUI({ if(!is.null(rf1())) h5("Outlier measure for all countries") })
output$tp.errorRate <- renderUI({ if(!is.null(rf1())) h5("Response class and OOB error rates") })
output$tp.varsUsed <- renderUI({ if(!is.null(rf1())) h5("Total splits at nodes across all tress") })
output$tp.numVar <- renderUI({ if(!is.null(rf1())) h5("Error reduction performance from nested 5-fold CV on sequentially reduced predictor sets takes approximately one minute per replicate") })

output$mainPlots <- renderUI({
  if(!is.null(input$go_model)){
    dynamic_Plots()
  } else NULL
})

dynamic_Plots <- reactive({
  x <- NULL
  if(!is.null(input$nlp)){
    id <- input$nlp
    if(id=="acc_train"){
      x <- tabPanel("Accuracy (Train)", 
                    div(class="span3", downloadButton("dl_train_accuracy_plot","Download Plot")),
                    plotOutput("train_accuracy_plot", height="auto"), value="tp.acc_train")
    } else if(id=="acc_test"){
      x <- tabPanel("Accuracy (Test)", 
                    div(class="span3", downloadButton("dl_test_accuracy_plot","Download Plot")),
                    plotOutput("test_accuracy_plot", height="auto"), value="tp.acc_test")
    } else if(id=="impGini"){
      x <- tabPanel("Importance: Gini", 
                    div(class="span3", downloadButton("dl_imp_plot","Download Plot")),
                    plotOutput("imp_plot", height="auto"), value="tp.impGini")
    } else if(id=="impTable"){
      x <- tabPanel("Importance: Table", 
                    div(class="span3", downloadButton("dl_imp_table","Download Plot")),
                    plotOutput("imp_table", height="auto"), value="tp.impTable")
    } else if(id=="mds"){
      x <- tabPanel("2-D MDS", 
                    div(class="span3", downloadButton("dl_mds_plot","Download Plot")),
                    plotOutput("mds_plot", height="auto"), value="tp.mds")
    }
    x
  }
})



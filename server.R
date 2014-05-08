# By default, the file size limit is 5MB. It can be changed by
# setting this option. Here we"ll raise limit to 9MB.
options(shiny.maxRequestSize = 12*1024^2)
source("Server Main.R")

shinyServer(function(input, output, session) {
  source("server_Tab1_Reactives and Output.R", local = TRUE)
  source("server_Tab2_1_Dynamic UI.R", local = TRUE)
  source("server_Tab2_1_Reactives.R", local = TRUE)
  source("server_Tab3.R", local = TRUE)
  
  output$train_accuracy_plot <- renderPlot({
    input$go_model
    isolate(
      if(!is.null(input$go_model)) 
        if(input$go_model!=0)
          classAccuracyPlot(accuracy = train_accuracy(), 
                            confusion_table = train_confusion_table(), 
                            celltextsize = cs, fontsize = fs, titlesize = ts, 
                            my_title = "Classification Accuracy & Confusion Table(Train)")
    )
  }, height=1000, width=1600)
  
  
  output$dl_train_accuracy_plot <- downloadHandler( # render plot to pdf for download
    filename = 'Accuracy Plot(Train).pdf',
    content = function(file){
      pdf(file = file, width=11, height=8.5)
      classAccuracyPlot(accuracy = train_accuracy(), 
                        confusion_table = train_confusion_table(), 
                        celltextsize = cs - cs.sub, fontsize = fs - fs.sub, 
                        titlesize = ts.pdf, 
                        my_title = "Classification Accuracy & Confusion Table(Train)")
      dev.off()
    }
  )
  
  output$test_accuracy_plot <- renderPlot({
    input$go_model
    isolate(
      if(!is.null(input$go_model)) 
        if(input$go_model!=0)
          classAccuracyPlot(accuracy = test_accuracy(), 
                            confusion_table = test_confusion_table(), 
                            celltextsize = cs, fontsize = fs, titlesize = ts, 
                            my_title = "Classification Accuracy & Confusion Table(Test)")
    )
  }, height=1000, width=1600)
  
  output$dl_test_accuracy_plot <- downloadHandler( # render plot to pdf for download
    filename = 'Accuracy Plot(Test).pdf',
    content = function(file){
      pdf(file = file, width=11, height=8.5)
      classAccuracyPlot(accuracy = test_accuracy(), 
                        confusion_table = test_confusion_table(), 
                        celltextsize = cs - cs.sub, fontsize = fs - fs.sub, 
                        titlesize = ts.pdf, 
                        my_title = "Classification Accuracy & Confusion Table(Test)")
      dev.off()
    }
  )
  
  output$imp_plot <- renderPlot({
    input$go_model
    isolate(
      if(!is.null(input$go_model)) 
        if(input$go_model!=0)
          importancePlot(rf_importance1(), ylb ="mdg", fontsize = fs, titlesize = ts, 
                         my_title = "Variable importance Plot")
    )
  }, height=1000, width=1600)
  
  output$dl_imp_plot <- downloadHandler( # render plot to pdf for download
    filename = 'Variable Importance Plot.pdf',
    content = function(file){
      pdf(file = file, width=11, height=8.5)
      importancePlot(rf_importance1(), ylb ="mdg", fontsize = fs - fs.sub, titlesize = ts.pdf, 
                     my_title = "Variable importance Plot")
      dev.off()
    }
  )
  
  output$imp_table <- renderPlot({
    input$go_model
    isolate(
      if(!is.null(input$go_model)) 
        if(input$go_model!=0)
          importanceTable(rf_importance1(), colnames(rf_importance1())[-1], 
                          celltextsize = cs, fontsize = fs, titlesize = ts, 
                          my_title = "Variable Importance - All & Segment Level")
    )
  }, height=1000, width=1600)
  
  output$dl_imp_table <- downloadHandler( # render plot to pdf for download
    filename = 'Variable Importance Table.pdf',
    content = function(file){
      pdf(file = file, width=11, height=8.5)
      importanceTable(rf_importance1(), colnames(rf_importance1())[-1], 
                      celltextsize = cs - cs.sub, fontsize = fs - fs.sub, titlesize = ts.pdf, 
                      my_title = "Variable Importance - All & Segment Level")
      dev.off()
    }
  )
  
  output$mds_plot <- renderPlot({
    input$go_model
    isolate(
      if(!is.null(input$go_model)) 
        if(input$go_model!=0)
          mdsPlot(d = rf_prox_data1(), fontsize = fs, titlesize = ts, 
                  my_title = "Multi Dimensional Scaling(MDS) Plot")
    )
  }, height=1000, width=1600)
  
  output$dl_mds_plot <- downloadHandler( # render plot to pdf for download
    filename = 'MDS Plot.pdf',
    content = function(file){
      pdf(file = file, width=11, height=8.5)
      mdsPlot(d = rf_prox_data1(), fontsize = fs - fs.sub, titlesize = ts.pdf, 
              my_title = "Multi Dimensional Scaling(MDS) Plot")
      dev.off()
    }
  )
  
  # Download Random Forest Model
  output$downloadModel <- downloadHandler(
    filename <- function(){
      paste("RF Model.RData")
    },
    
    content = function(file) {
      save(rf2, file = file)
    }
  )
  
  # Download All files
  output$dl_All <- downloadHandler( # render plot to pdf for download
    filename = 'All Plots.pdf',
    content = function(file){
      pdf(file = file, width=20, height=12, onefile = TRUE)
      classAccuracyPlot(accuracy = train_accuracy(), 
                        confusion_table = train_confusion_table(), 
                        celltextsize = cs - cs.sub, fontsize = fs - fs.sub, titlesize = ts.pdf, 
                        my_title = "Classification Accuracy & Confusion Table(Train)")
      classAccuracyPlot(accuracy = test_accuracy(), 
                        confusion_table = test_confusion_table(), 
                        celltextsize = cs - cs.sub, fontsize = fs - fs.sub, titlesize = ts.pdf, 
                        my_title = "Classification Accuracy & Confusion Table(Test)")
      importancePlot(rf_importance1(), ylb ="mdg", fontsize = fs - fs.sub, titlesize = ts.pdf, 
                     my_title = "Variable importance Plot")
      importanceTable(rf_importance1(), colnames(rf_importance1())[-1], 
                      celltextsize = cs - cs.sub, fontsize = fs - fs.sub, titlesize = ts.pdf, 
                      my_title = "Variable Importance - All & Segment Level")
      mdsPlot(d = rf_prox_data1(), fontsize = fs - fs.sub, titlesize = ts.pdf, 
              my_title = "Multi Dimensional Scaling(MDS) Plot")
      dev.off()
    }
  )
  
})


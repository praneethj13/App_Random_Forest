# Tab2: Choosing Model Inputs
tabPanel(    
  "Modeling", 
  ## Variable Selection (UI)
  # Columns 4/12 are used.
  sidebarLayout(
    sidebarPanel(
      bsCollapse(
        
        ## Data Selection
        bsCollapsePanel('Data Selection', 
                        uiOutput("dataSelection")), 
        

        
        ## Model Selection (UI)
        bsCollapsePanel('Model Selection', uiOutput("modelInputs"),
                        bsActionButton("go_model", "Build RF model", block = TRUE)),
        
        ## Plots (UI)
        bsCollapsePanel(
          'Graphics',            
          navlistPanel(
            
            "Classification Information",
            tabPanel("Accuracy (Train)", value="acc_train"),
            tabPanel("Accuracy (Test)", value="acc_test"),
            tabPanel("2-D MDS",value="mds"),
            tabPanel("Partial Dependence", value="pd"),
            tabPanel("Outliers", value="outliers"),
            "Importance Measures",
            tabPanel("Importance: OOB", value="impAcc"),
            tabPanel("Importance: Gini", value="impGini"),
            tabPanel("Importance: Table", value="impTable"),
            "Error and Variable Selection",
            tabPanel("Error Rate", value="errorRate"),
            tabPanel("Variable Use", value="varsUsed"),
            tabPanel("Number of Variables", value="numVar"),
            
            id="nlp",
            well = FALSE
          )
          
        ),
        
        ## Download
        bsCollapsePanel(
          "Download",
          downloadButton('downloadModel', 'Download RF Model', class="dlButton"),
          br(),
          downloadButton('dl_All', 'Download Plots(PDF)', class="dlButton")),
        
        multiple = FALSE)
      
      
      
    ),
    
    mainPanel(
      uiOutput("mainPlots")
    ),
    
    
    
  ))
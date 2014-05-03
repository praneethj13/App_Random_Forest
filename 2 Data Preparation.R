# Data preparation for Graphics(ready to use for graphics)----------------------------------------
# Converts confusion into Accuracy
rf_accuracy <- function(confusion){
  class_accuracy <- data.frame(1- confusion[,'class.error']) # Converting Class Error --> Accuracy
  all_accuracy <- sum(diag(confusion))/sum(confusion)        # All level Accuracy
  accuracy <- rbind(all_accuracy, class_accuracy)            # Combining All & Class Accuracy
  rownames(accuracy)[1] <- "All"
  accuracy <- round(accuracy*100, 1)                         # Rounding Accuracy
  accuracy <- data.frame(rownames(accuracy), accuracy)
  colnames(accuracy) <- c("Segment", "Accuracy")
  return(accuracy)
}

# Converts confusion into confusion table
rf_confusion_table <- function(confusion){
  confusion[,'class.error'] <- round((1 - confusion[,'class.error'])*100, 1) # Converting Error --> Accuracy
  confusion <- data.frame(rownames(confusion), confusion)             # Adding 'Class' names column
  colnames(confusion)[] <- c("Segment", rownames(confusion), "Accuracy")     # Renaming 'Columns'
  
  confusion <- melt(confusion, id=1)
  names(confusion) <- c("Y","X","Count")
  return(confusion)
}

# Importance
rf_Importance <- function(importance){
  importance <- data.frame(rownames(importance), round(importance, 2))
  names(importance)[c(1, ncol(importance)-1, ncol(importance))] <- c("Predictor", "mda", "mdg")
  rownames(importance) <- NULL
  return(importance)
}

# Proximity Data
rf_prox_data <- function(rf1){
  mds <- cmdscale(1 - rf1$proximity, eig=TRUE) ## Do MDS on 1 - proximity 
  d <- data.frame(mds$points, # Dim_1, Dim_2
                  rf1$y, # Classes
                  mds$eig, # Eigen Values
                  as.numeric(margin(rf1)), # Margin
                  outlier(rf1)) # Outliers
  names(d) <- c("Dim.1","Dim.2", "Segments", "Eigen values", "Margin", "Outliers")
  return(d)
}
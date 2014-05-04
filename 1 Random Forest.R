# Random Forest Models --------------------------------------------------------------

# Calculating Training Rows 
train_rows <- function(data, train_size){
  x <- createDataPartition(data, p = train_size, list = FALSE)
  return(x)
}

# Random Forest Model
rf_model1 <- function(data, train_size , var_clus, rf_ntree, rf_mtry){
  
  # Training & Test Set Data 
  train_rows <- train_rows(data = data[, var_clus], train_size = train_size)
  y_train <- data[train_rows, var_clus]
  x_train <- data[train_rows, -which(names(data) %in% var_clus)] 
  y_test <- data[-train_rows, var_clus]
  x_test <- data[-train_rows, -which(names(data) %in% var_clus)] 
  
  rf_model_normal <- randomForest(x = x_train, y = y_train, xtest = x_test, ytest = y_test,
                                  ntree = rf_ntree, mtry = rf_mtry, importance = TRUE,
                                  proximity = TRUE)
  # Adding data to the model
  ln <- length(rf_model_normal)
  rf_model_normal[[ln+1]] <- data
  names(rf_model_normal)[ln+1] <- "org_data"
  
  return(rf_model_normal) # Return random forest object
}

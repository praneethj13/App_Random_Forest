# Random Forest Models ---------------------------------------------------------

# Calculating Training Rows 
train_rows <- function(data, train_size){
  x <- createDataPartition(data, p = train_size, list = FALSE)
  return(x)
}

set.seed(1000)

# Random Forest Model
rf_model1 <- function(data, train_size , var_clus, rf_ntree, rf_mtry){
  
  # Training & Test Set Data 
  train_rows <- train_rows(data = data[, var_clus], train_size = train_size)
  y_train <- data[train_rows, var_clus]
  x_train <- data[train_rows, -which(names(data) %in% var_clus)] 
  y_test <- data[-train_rows, var_clus]
  x_test <- data[-train_rows, -which(names(data) %in% var_clus)] 
  
  # Random forest in normal mode
  rf_model_normal <- randomForest(x = x_train, y = y_train, xtest = x_test, 
                                  ytest = y_test, ntree = rf_ntree, mtry = rf_mtry, 
                                  importance = TRUE, proximity = TRUE, keep.forest = TRUE)
  # Adding data to the model
  ln <- length(rf_model_normal)
  rf_model_normal[[ln+1]] <- data
  rf_model_normal[[ln+2]] <- data[, -which(names(data) %in% var_clus)]
  names(rf_model_normal)[(ln+1):(ln+2)] <- c("org_data", "org_data_wo_class")
  
  return(rf_model_normal) # Return random forest object
}

# RF Prediction Function
rf_predict <- function(rf_model, new_data){
  
  # Predict Final class & Probability
  pred_class <- predict(rf_model, newdata = new_data, type = "class")
  pred_prob <- predict(rf_model, newdata = new_data, type = "prob")
  
  # Combine with new_data
  data <- cbind(pred_class, pred_prob, new_data)
  
  return(data)
}
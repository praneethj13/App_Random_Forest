library(foreach)
model_fn1 <- function(data = read.csv("data/Segmentation_Data.csv"),
                     metaName = c("ID"),
                     clusName = "Cluster",
                     trainSiz = 0.7,
                     model_ntree = 500,
                     model_mtry = 6){
  # Remove columns or variable not required in model
  data <- data[, -which(names(data) %in% metaName)] 
  
  # Seperate Class or Cluster Variable
  clusVar <- data[, which(names(data) %in% clusName)] 
  data <- data[, -which(names(data) %in% clusName)]
  gc()
  
  # Creating Training & Test Data
  trainRows <- createDataPartition(clusVar, times = 1, p = trainSiz, list = FALSE)
  xtrain <- data[trainRows, ]
  xtest <- data[-trainRows, ]
  
  # Random Forest Model
  ytrain <- clusVar[trainRows]
  ytest <- clusVar[-trainRows]
  rm(trainRows)
  
  rf_model <- randomForest(x = xtrain, y = ytrain, xtest = xtest, ytest = ytest,
                           ntree = model_ntree, mtry = model_mtry)
  return(rf_model)
}

model_fn2 <- function(data = read.csv("data/Segmentation_Data.csv"),
                      metaName = c("ID"),
                      clusName = "Cluster",
                      trainSiz = 0.7,
                      model_ntree = 500,
                      model_mtry = 6){
  # Remove columns or variable not required in model
  data <- data[, -which(names(data) %in% metaName)] 
  
  # Seperate Class or Cluster Variable
  clusVar <- data[, which(names(data) %in% clusName)] 
  data <- data[, -which(names(data) %in% clusName)]
  gc()
  
  # Creating Training & Test Data
  trainRows <- createDataPartition(clusVar, times = 1, p = trainSiz, list = FALSE)
  xtrain <- data[trainRows, ]
  xtest <- data[-trainRows, ]
  
  # Random Forest Model
  ytrain <- clusVar[trainRows]
  ytest <- clusVar[-trainRows]
  rm(trainRows)
  return(rf_model)
}

p <- proc.time()
m1 <- model_fn1()
print(proc.time()-p)

p <- proc.time()
m2 <- model_fn2()
print(proc.time()-p)

library(DT)
library(ggplot2)
library(dplyr)
library(xgboost)
library(shinydashboard)

source("inst/iris_xgbm.R")

IrisClass <- xgb.load("inst/IrisClass.model")

# predictions from whole dataset
all_pred <- predict(IrisClass, x)
# convert to matrix with # of cols = to outcomes
all_predm <- matrix(all_pred, ncol = length(table(y)), byrow = T) 

# apply labels based on predictions  
pred_spec <- data.frame(all_predm)
colnames(pred_spec) <- c("setosa", "versicolor", "virginica")

iris_pspec <- function(df){
  preds <- vector("list", nrow(df))
  for (i in 1:nrow(df)) {
    preds[[i]] <- names(which.max(df[i,]))
  }
  return(preds)
}

pred_spec$species_pred <- iris_pspec(pred_spec)
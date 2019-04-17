library(xgboost)

# outcome
y <- as.numeric(iris$Species) - 1

# predictors 
x <- select(iris, -Species)
var.nanmes <- names(x) # save variable names for later
x <- as.matrix(x)

params <- list("objective"= "multi:softprob", "eval_metric"="mlogloss",
               "num_class"= length(table(y)), "eta"= 0.15, 
               "max_depth"= 10, "lambda"=1, 
               "alpha"=0.5, "min_child_weight"= 0.3,
               "subsample"=0.9, "colsample_bytree"=0.6)

IrisClass <- xgboost(params = params, data=x, label=y, missing=NA, nrounds = 100, verbose=F)

xgb.save(IrisClass, "IrisClass.model")

############################################################
# Gaussian Process Regression (GPR)
# ----------------------------------------------------------
# Transfer Learning for Mineral Prospectivity Mapping
#
# This script:
#   1. Loads training, test, and target datasets
#   2. Performs hyperparameter tuning
#   3. Evaluates predictive performance
#   4. Predicts prospectivity for the target area
#   5. Computes permutation-based feature importance
#
# Author:
# MohammadReza Samiei
############################################################

# --------------------------------------------------
# 1. Load libraries
# --------------------------------------------------

library(kernlab)
library(openxlsx)
library(ggplot2)
library(viridis)

# --------------------------------------------------
# 2. Load datasets
# --------------------------------------------------

train_data <- read.xlsx("Train.xlsx")
test_data  <- read.xlsx("Test.xlsx")
f1_data    <- read.xlsx("F1.xlsx")

# --------------------------------------------------
# 3. Define predictor variables
# --------------------------------------------------

features <- c(
  "Fault_LD",
  "Fault_NW",
  "RockType",
  "Cu",
  "RTP",
  "Analytic_signal",
  "K",
  "FeO",
  "Argillic",
  "Phyllic"
)

x_train <- train_data[, features]
y_train <- train_data$Class

x_test <- test_data[, features]
y_test <- test_data$Class

x_f1 <- f1_data[, features]

# --------------------------------------------------
# 4. Hyperparameter tuning
# --------------------------------------------------

sigma_values <- c(0.1, 0.5, 1, 2, 3)
C_values <- c(0.1, 0.5, 1, 2, 3)
kernel_values <- c("rbfdot", "laplacedot")

best_model <- NULL
best_rmse <- Inf
best_params <- NULL
best_metrics <- NULL

for (sigma in sigma_values){
  
  for (C in C_values){
    
    for (kernel in kernel_values){
      
      model <- gausspr(
        x_train,
        y_train,
        sigma = sigma,
        C = C,
        kernel = kernel
      )
      
      pred <- predict(model, x_test)
      
      rmse <- sqrt(mean((y_test - pred)^2))
      mse  <- mean((y_test - pred)^2)
      mae  <- mean(abs(y_test - pred))
      r2   <- cor(y_test, pred)^2
      r    <- cor(y_test, pred)
      
      if(rmse < best_rmse){
        
        best_rmse <- rmse
        best_model <- model
        
        best_params <- list(
          sigma = sigma,
          C = C,
          kernel = kernel
        )
        
        best_metrics <- list(
          R = r,
          R2 = r2,
          RMSE = rmse,
          MSE = mse,
          MAE = mae
        )
        
      }
      
    }
    
  }
  
}

# --------------------------------------------------
# 5. Display best model
# --------------------------------------------------

cat("Best hyperparameters:\n")
print(best_params)

cat("\nEvaluation metrics:\n")
print(best_metrics)

# --------------------------------------------------
# 6. Prediction for target area (F1)
# --------------------------------------------------

f1_predictions <- predict(best_model, x_f1)

f1_data$Prediction <- f1_predictions

write.xlsx(
  f1_data,
  "F1_predictions.xlsx",
  overwrite = TRUE
)

cat("\nPrediction file saved as: F1_predictions.xlsx\n")

# --------------------------------------------------
# 7. Prospectivity map
# --------------------------------------------------

prediction_map <- ggplot(
  f1_data,
  aes(
    x = X,
    y = Y,
    color = Prediction
  )
) +
  geom_point(size = 3) +
  scale_color_viridis(option = "D") +
  labs(
    title = "GPR-based Prospectivity Map",
    x = "X Coordinate",
    y = "Y Coordinate",
    color = "Prediction"
  ) +
  theme_minimal() +
  theme(
    legend.position = "right",
    plot.title = element_text(hjust = 0.5)
  ) +
  coord_fixed(ratio = 1)

print(prediction_map)

ggsave(
  "prospectivity_map.png",
  plot = prediction_map,
  dpi = 300,
  width = 8,
  height = 8
)

# --------------------------------------------------
# 8. Permutation-based feature importance
# --------------------------------------------------

evaluate_feature_impact <- function(model, features, reference_predictions){
  
  baseline_mse <- mean((reference_predictions - predict(model, features))^2)
  
  importance_values <- sapply(colnames(features), function(feature){
    
    shuffled_features <- features
    shuffled_features[[feature]] <- sample(shuffled_features[[feature]])
    
    shuffled_predictions <- predict(model, shuffled_features)
    
    shuffled_mse <- mean((reference_predictions - shuffled_predictions)^2)
    
    shuffled_mse - baseline_mse
    
  })
  
  importance_df <- data.frame(
    
    Feature = names(importance_values),
    Importance = importance_values
    
  )
  
  importance_df <- importance_df[
    order(abs(importance_df$Importance), decreasing = TRUE),
  ]
  
  return(importance_df)
  
}

# Calculate feature importance

feature_importance <- evaluate_feature_impact(
  best_model,
  x_f1,
  f1_predictions
)

print(feature_importance)

# Save feature importance table

write.xlsx(
  feature_importance,
  "Feature_Importance.xlsx",
  overwrite = TRUE
)

# --------------------------------------------------
# 9. Plot feature importance
# --------------------------------------------------

importance_plot <- ggplot(
  feature_importance,
  aes(
    x = reorder(Feature, Importance),
    y = Importance,
    fill = Importance
  )
) +
  
  geom_col(show.legend = FALSE) +
  
  coord_flip() +
  
  scale_fill_viridis(option = "D") +
  
  labs(
    title = "Permutation-based Feature Importance",
    x = "Feature",
    y = "Impact on Prediction Error (MSE)"
  ) +
  
  theme_minimal() +
  
  theme(
    plot.title = element_text(hjust = 0.5)
  )

print(importance_plot)

ggsave(
  "Feature_Importance.png",
  plot = importance_plot,
  dpi = 300,
  width = 8,
  height = 6
)

cat("\nAll outputs have been successfully generated.\n")
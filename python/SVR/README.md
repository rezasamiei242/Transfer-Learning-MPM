# Support Vector Regression (SVR)

This folder contains the Python implementation of the Support Vector Regression (SVR) model used in the transfer learning framework for mineral prospectivity mapping.

## Main functions

The script performs:

- Hyperparameter optimization
- Model training
- Validation using the target-area test dataset
- Prospectivity prediction for the target area
- Permutation-based feature importance analysis

## Required input files

- **Train.xlsx** – Training dataset. This file can contain samples from one or multiple source areas, depending on the transfer learning scenario. It may also contain only target-area training samples if no transfer learning is applied.
- **Test.xlsx** – Validation dataset from the target area. This dataset is used exclusively to evaluate model performance.
- **F1.xlsx** – Predictor dataset covering the target area where mineral prospectivity is estimated.

## Generated outputs

- F1_predictions.xlsx
- Prospectivity map
- Feature importance table
- Feature importance plot

## Notes

The script is flexible and can be applied to different transfer learning scenarios by replacing the contents of **Train.xlsx**. For example:

- Source Area 1 only
- Source Area 2 only
- Combined source areas
- Target-area training samples only (conventional machine learning without transfer learning)

In all cases, **Test.xlsx** should contain validation samples from the target area, while **F1.xlsx** should contain the complete predictor dataset for the target area to be mapped.

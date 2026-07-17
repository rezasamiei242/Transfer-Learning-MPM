# Gaussian Process Regression (GPR)

This folder contains the R implementation of the Gaussian Process Regression (GPR) model used in the transfer learning framework for mineral prospectivity mapping.

## Main functions

The script performs:

- Data loading and preprocessing
- Gaussian Process Regression model training
- Prediction of mineral prospectivity values
- Validation using the target-area test dataset
- Prospectivity prediction for the target area
- Performance evaluation using regression metrics
- Generation of prospectivity maps

## Required input files

**Train.xlsx** – Training dataset.  
This file can contain samples from one or multiple source areas, depending on the transfer learning scenario. It may also contain only target-area training samples if no transfer learning is applied.

**Test.xlsx** – Validation dataset from the target area.  
This dataset is used exclusively for evaluating model performance after training.

**F1.xlsx** – Predictor dataset covering the target area where mineral prospectivity values are estimated.

## Generated outputs

The script generates:

- `F1_predictions.xlsx`
  - Predicted mineral prospectivity values for the target area
  - Spatial coordinates and corresponding prediction results

- Model performance statistics
  - Correlation coefficient (R)
  - Coefficient of determination (R²)
  - Mean Absolute Error (MAE)
  - Mean Squared Error (MSE)
  - Root Mean Squared Error (RMSE)

- Prospectivity map

## Notes

The script is designed to be flexible and can be applied to different transfer learning scenarios by replacing the contents of `Train.xlsx`. For example:

- Source Area 1 only
- Source Area 2 only
- Combined source areas
- Target-area training samples only (conventional machine learning without transfer learning)

In all scenarios:

- `Test.xlsx` should contain validation samples from the target area.
- `F1.xlsx` should contain the complete predictor dataset of the target area where prospectivity is estimated.

The Gaussian Process Regression model is implemented using the `kernlab` package in R.

## Running the script

This script was developed in the R environment.

The sample datasets (`Train.xlsx`, `Test.xlsx`, and `F1.xlsx`) are available in the `data_sample` folder of this repository.

To reproduce the example:

1. Download the sample datasets from the `data_sample` folder.
2. Place the datasets in your working directory.
3. Update the file paths in the script according to the location of your files.
4. Install the required R packages.
5. Run the script.

The same workflow can be applied to custom datasets by replacing the sample files with user-provided `Train.xlsx`, `Test.xlsx`, and `F1.xlsx` datasets.

For transfer learning experiments, `Train.xlsx` should contain training samples from the selected source area(s), while `Test.xlsx` should contain independent validation samples from the target area. The `F1.xlsx` file represents the target area where final prospectivity predictions are generated.

# Artificial Neural Network (ANN-MLP)

This folder contains the Python implementation of the Artificial Neural Network (ANN-MLP) model used in the transfer learning framework for mineral prospectivity mapping.

## Main functions

The script performs:

- Hyperparameter optimization using Grid Search
- Model training
- Validation using the target-area test dataset
- Prospectivity prediction for the target area
- Permutation-based feature importance analysis

## Required input files

- **Train.xlsx** – Training dataset. This file can contain samples from one or multiple source areas depending on the transfer learning scenario. It may also contain only target-area training samples when transfer learning is not used.
- **Test.xlsx** – Validation dataset from the target area used exclusively for performance evaluation.
- **F1.xlsx** – Predictor dataset covering the target area where mineral prospectivity is estimated.

## Generated outputs

- F1_ANN_predictions.xlsx
- ANN_prospectivity_map.png
- Feature_Importance.xlsx
- Feature_Importance.png

## Notes

The script can be applied to different transfer learning scenarios by replacing the contents of **Train.xlsx**. Examples include:

- Source Area 1 only
- Source Area 2 only
- Combined source areas
- Target-area training samples only (conventional machine learning)

In all cases, **Test.xlsx** should contain validation samples from the target area, while **F1.xlsx** should contain the complete predictor dataset for the target area.

## Running the script

This script was originally developed in Google Colab.

The sample datasets (`Train.xlsx`, `Test.xlsx`, and `F1.xlsx`) are available in the `data_sample` folder of this repository.

To reproduce the example:

1. Download the sample datasets from the `data_sample` folder.
2. Upload them to your own Google Drive.
3. Update the `base_path` variable in the script to match the location of your files.
4. Run the script.

The same workflow can also be used with any custom dataset by replacing the sample files with your own `Train.xlsx`, `Test.xlsx`, and `F1.xlsx` datasets.

For transfer learning experiments, the `Train.xlsx` file should contain the training samples from the selected source area(s), whereas `Test.xlsx` should contain the validation samples from the target area. The `F1.xlsx` file represents the target area where prospectivity predictions are generated.

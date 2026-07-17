# Transfer Learning for Mineral Prospectivity Mapping (MPM)

This repository contains the source codes used in the study:

**Transfer learning for mineral prospectivity mapping in limited occurrence areas: Methodological improvement and a case study from the Kerman Cenozoic Magmatic Arc, Iran**

The repository provides the implementations of the machine learning models developed for mineral prospectivity mapping (MPM) under a transfer learning framework. The proposed methodology is designed to improve prospectivity prediction in target areas with limited or no known mineral occurrences.

## Repository Structure

```
Transfer-Learning-MPM/
│
├── Python/
│   ├── SVR/
│   └── ANN/
│
├── R/
│   └── GPR/
│
└── README.md
```

### Python

The **Python** directory contains the implementations of:

- Support Vector Regression (SVR)
- Artificial Neural Network (ANN)

These models were developed using Python and were employed as base learners in the proposed framework.

### R

The **R** directory contains the implementation of:

- Gaussian Process Regression (GPR)

The GPR model was implemented in R and used for probabilistic regression and uncertainty estimation.

## Study Overview

The proposed framework integrates transfer learning with machine learning techniques for mineral prospectivity mapping in areas where mineral occurrence data are limited.

The workflow includes:

- Transfer learning strategy
- Transferable Layer Normalization (TLN)
- Support Vector Regression (SVR)
- Artificial Neural Network (ANN)
- Gaussian Process Regression (GPR)
- Uncertainty quantification

## Citation

If you use this repository in your research, please cite the associated publication.

**Manuscript status:** Under review.

## License

This repository is released under the MIT License.

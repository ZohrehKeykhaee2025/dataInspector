# dataInspector: Intelligent Exploratory Data Analysis for R

https://img.shields.io/badge/R-4.3%252B-blue?style=flat&logo=R
https://img.shields.io/badge/License-MIT-green?style=flat
https://img.shields.io/badge/Version-0.1.0-orange?style=flat

A comprehensive R package designed to streamline exploratory data analysis and provide intelligent modeling recommendations based on dataset characteristics.

# Overview
dataInspector empowers data scientists and analysts with automated exploratory data analysis capabilities, generating detailed data profiles and actionable insights. The package examines your dataset's structure, distribution, and anomalies to recommend appropriate modeling approaches.

# Installation
Install the latest development version from GitHub:

r
# Install devtools if not already installed
if (!require("devtools")) install.packages("devtools")

# Install dataInspector
devtools::install_github("ZohrehKeykhaee2025/dataInspector")

# Load the package
library(dataInspector)
Quick Start
r
# Load the included example dataset
data(example_data)

# Generate a comprehensive data report
data_report <- report_data(example_data)

# Receive modeling recommendations
suggest_approach(data_report)

# Visualize variable distributions
plot_distributions(example_data)
Core Features
Automated Data Profiling
The report_data() function provides a detailed analysis of your dataset including:

Structural overview (dimensions, memory usage)

Missing value analysis with percentages

Data type classification for all variables

Statistical summaries for numeric features (mean, median, skewness, kurtosis)

Frequency analysis for categorical variables

Intelligent Modeling Recommendations
The suggest_approach() function analyzes your data characteristics and provides tailored suggestions:

Identifies need for data transformations

Flags variables with excessive missing values

Recommends appropriate modeling techniques based on data types and distributions

Suggests handling strategies for skewed data and outliers

Automated Visualization
The plot_distributions() function creates appropriate visualizations for different data types:

Histograms for numeric variables

Bar charts for categorical variables

Flexible plotting for individual variables or entire datasets

Example Dataset
The package includes example_data, a synthetic dataset showcasing various data scenarios:

normal_var: Normally distributed numeric variable

skewed_var: Right-skewed numeric variable

category_var: Categorical variable with multiple levels

var_with_missing: Numeric variable with missing values (10%)

Usage Examples
Comprehensive Data Analysis
r
# Analyze the built-in dataset
data_report <- report_data(example_data)

# Display the comprehensive report
print(data_report)
Targeted Modeling Suggestions
r
# Get specific recommendations for data preparation and modeling
recommendations <- suggest_approach(data_report)

# For direct analysis without pre-generated report
suggest_approach(example_data)
Flexible Visualization
r
# Plot distributions for all variables
plot_distributions(example_data)

# Focus on a specific variable
plot_distributions(example_data, "skewed_var")

# Compare distributions across multiple variables
plot_distributions(example_data, c("normal_var", "skewed_var"))
Advanced Applications
Custom Data Analysis
r
# Apply to your own dataset
my_data <- read.csv("your_dataset.csv")
custom_report <- report_data(my_data)

# Export results for documentation
write.csv(custom_report$missing_values, "missing_values_summary.csv")
Integration with Modeling Workflows
r
# Use recommendations to guide model building
suggestions <- suggest_approach(my_data)

if (grepl("log transformation", suggestions[1])) {
  my_data$skewed_var <- log(my_data$skewed_var + 1)
}

# Proceed with modeling based on package recommendations
Technical Details
Dependencies
ggplot2: For advanced visualization capabilities

gridExtra: For multi-plot layouts

moments: For statistical calculations (skewness, kurtosis)

System Requirements
R version 3.5.0 or higher

4GB RAM recommended for large datasets

Contributing
We welcome contributions from the community. Please feel free to:

Report bugs and request features via GitHub Issues

Submit pull requests for improvements

Share use cases and success stories

Citation
If you use dataInspector in your research or publications, please acknowledge it with:

bibtex
@software{dataInspector2023,
  title = {dataInspector: Automated Exploratory Data Analysis for R},
  author = {Keykhaee, Zohreh},
  year = {2023},
  url = {https://github.com/ZohrehKeykhaee2025/dataInspector}
}
License
This package is released under the MIT License. See the LICENSE file for full details.

Author
Developed by Zohreh Keykhaee as part of advanced statistical computing research. For questions or support, please open an issue on the GitHub repository.

dataInspector is designed to enhance your data exploration workflow, providing intelligent insights that help you make informed decisions about your modeling approach.


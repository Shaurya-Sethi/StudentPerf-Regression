# Student Final Grade Prediction

## Overview
This project aims to predict the final grade (`G3`) of students using the UCI Student Performance dataset. A regression model was developed, and extensive exploratory data analysis (EDA), feature selection, and model evaluation were performed. Visualizations and comparisons between different models highlight the most effective approach.

---

## Dataset

### Source
The dataset is obtained from the [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Student+Performance).

### Description
The dataset includes 33 attributes related to student demographics, academic performance, and social factors, with the final grade (`G3`) as the target variable.

- **Instances:** 395
- **Features:** 33
- **Target Variable:** `G3` (Final Grade)

---

## Methodology

### Exploratory Data Analysis (EDA)
1. **Correlation Analysis:**
   - A correlation matrix was plotted to identify relationships between numeric variables.
   - Features strongly correlated with `G3` were highlighted for further modeling.

2. **Target Variable Distribution:**
   - Histogram of `G3` revealed a significant number of students scoring zero or near the maximum, suggesting possible grading patterns.

3. **Visualization Techniques:**
   - Scatter plots, histograms, and advanced visualizations were used to explore data patterns.

---

### Data Preprocessing
1. **Data Splitting:**
   - Data was split into training (70%) and testing (30%) sets using random sampling for reproducibility.

2. **Feature Engineering:**
   - Identified and retained significant predictors using manual selection and stepwise regression techniques.

---

### Modeling

#### 1. Full Model
A linear regression model was built using all features as predictors.

- **Strengths:** Comprehensive analysis of all variables.
- **Weaknesses:** Increased complexity and overfitting potential.

#### 2. Reduced Model
A reduced model was developed by selecting significant predictors (`absences`, `G2`, `age`, `famrel`, `G1`).

- **Strengths:** Simplified model with fewer predictors.
- **Weaknesses:** Potential exclusion of valuable predictors.

#### 3. Stepwise Regression Model
Stepwise regression (combining forward and backward selection) was performed to identify the optimal subset of predictors.

- **Strengths:** Automated feature selection balances simplicity and performance.

---

### Model Evaluation

Models were compared based on the following metrics:

- **Mean Squared Error (MSE):** Measures average squared difference between actual and predicted values.
- **Root Mean Squared Error (RMSE):** Square root of MSE.
- **R-squared (R²):** Proportion of variance in `G3` explained by the model.
- **Residual Analysis:** Checked the distribution of residuals to validate model assumptions.

---

## Results

| Model        | MSE        | RMSE       | R²        |
|--------------|------------|------------|------------|
| Full Model   |  4.123811	|  2.030717  | 0.7979743  |
| Reduced Model|  3.475719	|  1.864328	 | 0.8297244  |
| Stepwise     |  3.940424	|  1.985050	 | 0.8069585  |


- The **reduced model** achieved similar performance to the full model, making it preferable for simplicity.
- The **stepwise model** provided the best balance of accuracy and simplicity.

---
## Actual vs Predicted values Table Data
[View the Interactive Table](https://shaurya-sethi.github.io/StudentPerf-Regression/LostTable.html)

## Visualizations

### Correlation Matrix
![Correlation Matrix](images/correlation_matrix.png)

### Distribution of Final Grades
![G3 Distribution](images/g3_distribution.png)

### Residual plots
![Residual Distribution](images/actual_vs_predicted.png)
![Residuals vs Fitted](images/actual_vs_predicted.png)
![Normal Q-Q](images/actual_vs_predicted.png)
![Scale-Location](images/actual_vs_predicted.png)
![Residual vs Leverage](images/actual_vs_predicted.png)

### Actual vs Predicted Values
![Full vs Reduced](images/actual_vs_predicted.png)
![Model Comparison for all 3](images/actual_vs_predicted.png)

## Conclusion

The project successfully predicts student grades using regression models. Key insights include:

- Feature selection significantly impacts model simplicity and interpretability.
- Reduced and stepwise models are viable alternatives to full models, offering similar performance with reduced complexity.

### Future Work
- Explore non-linear models such as Random Forest or Gradient Boosting.
- Incorporate domain knowledge for feature engineering.
- Expand the dataset for more robust analysis.

---

## Setup Instructions

### Prerequisites
- **R** installed on your system.
- Required packages: `data.table`, `ggplot2`, `plotly`, `dplyr`, `ggthemes`, `corrplot`, `caTools`, `knitr`, `kableExtra`.

### Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/student-grade-prediction.git
   cd student-grade-prediction
   ```
2. Install dependencies in R:
   ```r
   install.packages(c("data.table", "ggplot2", "plotly", "dplyr", "ggthemes", "corrplot", "caTools", "knitr", "kableExtra"))
   ```

### Usage
1. Place the dataset (`student-mat.csv`) in the project directory.
2. Run the analysis script:
   ```r
   source("analysis.R")
   ```
3. Visualizations and results will be displayed.

---

## License
This project is licensed under the [MIT License](LICENSE).

---

## Contact
- **Name:** Shaurya Sethi
- **Email:** shauryaswapansethi@gmail.com

Feel free to contribute or provide feedback!


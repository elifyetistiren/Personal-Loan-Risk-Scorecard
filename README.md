
# 🧮 Loan Applicant Risk Scorecard

A data-driven credit risk scoring pipeline that classifies LendingClub loan applicants into Low, Medium, or High Risk tiers based on FICO score, DTI, income, and purpose. This project supports both rule-based and machine learning scoring strategies, culminating in model evaluation and Power BI dashboards.

---

## 🚀 Project Goals

- Create a clean loan applicant dataset from raw LendingClub data
- Engineer features for risk modeling (FICO, DTI bins, purpose, homeownership)
- Train and evaluate Logistic Regression and XGBoost classifiers
- Implement SMOTE to address High Risk class imbalance
- Compare to a business rule-based scorecard
- Visualize results in an interactive Power BI dashboard

---

## 📁 Project Structure

| Step | Component        | Description                                                 |
|------|------------------|-------------------------------------------------------------|
| 1    | Raw CSVs         | Accepted and Rejected LendingClub loan data                |
| 2    | SQL Cleaning     | Filters missing values, computes FICO average, risk buckets |
| 3    | Python EDA       | FICO vs DTI plots, purpose histograms, correlation matrix   |
| 4    | Risk Modeling    | Logistic Regression, XGBoost, SMOTE balancing               |
| 5    | Power BI         | Pie/bar charts, confusion matrix, scatter plots             |
| 6    | Business Logic   | Rule-based risk tiers (FICO & DTI thresholds)               |

---

## 📊 Model Comparison

| Model              | Accuracy | Macro F1 | High Risk Recall |
|--------------------|----------|----------|------------------|
| Logistic Regression| 0.49     | 0.32     | 0.00             |
| XGBoost (No SMOTE) | 0.49     | 0.31     | 0.00             |
| Rule-Based         | 0.40     | 0.28     | 0.04             |

---

## 🧠 Business Insights

- Low Risk Detection: Logistic and XGBoost models perform well with >80% recall.
- High Risk Missed: Both models fail to identify high-risk borrowers without resampling.
- Rule-Based Tiering: Interpretable but blunt — over-assigns Medium Risk.
- Recommendation:
  - Use model-based classification with SMOTE or class weighting
  - Apply rule-based overrides for specific business exceptions
  - Build a separate binary high-risk detector

---

## 📉 Rule-Based Scorecard Logic (SQL)

CASE
  WHEN fico_avg > 700 AND dti < 15 THEN 'Low Risk'
  WHEN fico_avg BETWEEN 640 AND 700 OR (dti BETWEEN 15 AND 30) THEN 'Medium Risk'
  WHEN fico_avg < 640 OR dti > 30 THEN 'High Risk'
END

---

## 📎 Power BI Dashboard Includes

- ✅ Applicant Distribution by Risk (pie + bar by purpose/state)
- ✅ FICO vs DTI scatterplot by Risk Tier
- ✅ Confusion Matrix with accuracy visualization
- ✅ Optional: Rule vs Model risk comparison visuals

---

## 🛠 Tech Stack

- Python (pandas, scikit-learn, imbalanced-learn, xgboost)
- SQL (PostgreSQL or compatible)
- Power BI
- Jupyter Notebooks

---

## ✅ Status

✔️ Completed  
📦 Ready for review or integration into risk decision systems

---

## 📧 Contact

Elif Yetistiren  
[Insert GitHub or LinkedIn profile link]

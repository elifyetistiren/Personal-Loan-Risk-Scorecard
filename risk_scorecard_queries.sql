
-- Step 1: Create Clean Loans Table
CREATE TABLE clean_loans AS
SELECT
  id,
  annual_inc,
  fico_range_low,
  fico_range_high,
  (fico_range_low + fico_range_high) / 2 AS fico_avg,
  int_rate,
  dti,
  loan_amnt,
  purpose,
  home_ownership,
  CAST(REGEXP_REPLACE(term, '[^0-9]', '', 'g') AS INTEGER) AS term_months,
  loan_status,
  COALESCE(emp_length, 'Unknown') AS emp_length,
  zip_code,
  addr_state,
  application_type,
  CASE
    WHEN loan_status IN ('Charged Off', 'Default') THEN 'High Risk'
    WHEN loan_status IN ('Late (31-120 days)', 'Late (16-30 days)', 'In Grace Period') THEN 'Medium Risk'
    WHEN loan_status = 'Fully Paid' THEN 'Low Risk'
    ELSE 'Medium Risk'
  END AS risk_bucket
FROM accepted_loans
WHERE annual_inc IS NOT NULL
  AND fico_range_low IS NOT NULL
  AND loan_amnt > 0;

-- Step 2: Feature Engineering - Categorical Encoding Example
-- (Optional, usually done in Python or Power BI)
SELECT
  *,
  CASE
    WHEN home_ownership = 'OWN' THEN 1
    WHEN home_ownership = 'MORTGAGE' THEN 2
    WHEN home_ownership = 'RENT' THEN 3
    ELSE 0
  END AS home_ownership_code,
  CASE
    WHEN purpose = 'debt_consolidation' THEN 1
    WHEN purpose = 'credit_card' THEN 2
    WHEN purpose = 'home_improvement' THEN 3
    WHEN purpose = 'small_business' THEN 4
    WHEN purpose = 'major_purchase' THEN 5
    ELSE 0
  END AS purpose_code
FROM clean_loans;

-- Step 6: Business Rule-Based Risk Classification
SELECT
  id,
  fico_avg,
  dti,
  CASE
    WHEN fico_avg > 700 AND dti < 15 THEN 'Low Risk'
    WHEN fico_avg BETWEEN 640 AND 700 OR (dti BETWEEN 15 AND 30) THEN 'Medium Risk'
    WHEN fico_avg < 640 OR dti > 30 THEN 'High Risk'
    ELSE 'Medium Risk'
  END AS business_rule_risk
FROM clean_loans;

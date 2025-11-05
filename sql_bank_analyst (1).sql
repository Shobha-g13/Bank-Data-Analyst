use bank_data;

select*from loan_data;

##1) total funded loan amount 
select sum(funded_amount) as total_loan_amount
from loan_data;

##2) total int_ratae amount 
select sum(int_rate)
from loan_data;

##3) total collection
SELECT SUM(Total_Pymnt) AS total_collection
FROM loan_data;


### tables explationss

##@1)Loan Status-Wise Loan: Breaks down loans by status (active, delinquent, closed). 

SELECT Loan_Status,
       COUNT(*) AS loan_count,
       SUM(Loan_Amount) AS total_loan_amount,
       SUM(Funded_Amount) AS total_funded_amount
FROM loan_data
GROUP BY Loan_Status
ORDER BY loan_count DESC;

##2) age group wise and totalloans and totalloan_amount total_funded_amount
SELECT CASE  WHEN TIMESTAMPDIFF(YEAR, Dateof_Birth, CURDATE()) < 25 THEN '<25'
             WHEN TIMESTAMPDIFF(YEAR, Dateof_Birth, CURDATE()) BETWEEN 25 AND 34 THEN '25-34'
             WHEN TIMESTAMPDIFF(YEAR, Dateof_Birth, CURDATE()) BETWEEN 35 AND 44 THEN '35-44'
             WHEN TIMESTAMPDIFF(YEAR, Dateof_Birth, CURDATE()) BETWEEN 45 AND 54 THEN '45-54'
             ELSE '55+'
		     END AS age_group,
             COUNT(*) AS loan_count,
             SUM(Loan_Amount) AS total_loan_amount,
             SUM(Funded_Amount) AS total_funded_amount
			FROM loan_data
            GROUP BY age_group
            ORDER BY MIN(TIMESTAMPDIFF(YEAR, Dateof_Birth, CURDATE()));

## 3)religion wise and totalloans amount and total loan in this query
SELECT Religion,
    SUM(Loan_Amount) AS total_loan_amount,
    COUNT(*) AS total_loans
FROM loan_data
GROUP BY Religion
ORDER BY total_loan_amount DESC;


-- Branch-Wise Performance and total_int ,total_fees, total_revinue
SELECT 
    Branch_Name,
    SUM(CAST(`Total_Rec_int` AS DECIMAL(15,2))) AS Total_Int,
    SUM(CAST(Total_Fees AS DECIMAL(15,2))) AS Total_Fees,
    SUM(CAST(`Total_Rec_int` AS DECIMAL(15,2)) + CAST(Total_Fees AS DECIMAL(15,2))) AS Total_Revenue
FROM loan_data
GROUP BY Branch_Name
ORDER BY Total_Revenue DESC;




-- Loan Category activeloans in this table
SELECT 
    CASE 
        WHEN `Is_Delinquent_Loan` = 'Yes' THEN 'Delinquent'
        WHEN Loan_Status = 'Closed' THEN 'Closed'
        ELSE 'Active'
    END AS Loan_Category,
    COUNT(Account_ID) AS Total_Loans,
    SUM(CAST(Loan_Amount AS DECIMAL(15,2))) AS Total_Loan_Amount,
    SUM(CAST(Funded_Amount AS DECIMAL(15,2))) AS Total_Funded
FROM loan_data
GROUP BY Loan_Category
ORDER BY Total_Loans DESC;




















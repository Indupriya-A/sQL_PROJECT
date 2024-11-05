SELECT * FROM  credit_card_transactions;
#26 COLUMNS

# 1. TOTAL NUMBER OF TRANSACTIONS
SELECT COUNT(*) AS total_transactions  FROM credit_card_transactions;

#2. Average Transaction Amount by Category
SELECT category, AVG(amt) AS average_amount FROM credit_card_transactions GROUP BY category ORDER BY average_amount DESC;

# 3. TOP 10 MERCHANTS WITH HIGHEST NUMBER OF TRANSACTION
SELECT merchant, COUNT(*) AS transaction_count
FROM credit_card_transactions
GROUP BY merchant
ORDER BY transaction_count DESC
LIMIT 10;

# 4. Number of Fraudulent Transactions by Category
SELECT category, COUNT(*) AS fraud_count
FROM credit_card_transactions
WHERE is_fraud = 1
GROUP BY category
ORDER BY fraud_count DESC;

# 5. Top Cities with Highest Fraud Rate
SELECT city, COUNT(*) AS total_transactions,
       SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_count,
       (SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 1.0 / COUNT(*)) * 100 AS fraud_rate
FROM  credit_card_transactions
GROUP BY city
HAVING fraud_count > 0
ORDER BY fraud_rate DESC
LIMIT 10;

# 6. Age Analysis of Fraudulent Transactions
SELECT TIMESTAMPDIFF(YEAR, dob, CURDATE()) AS age, COUNT(*) AS fraud_count
FROM credit_card_transactions
WHERE is_fraud = 1
GROUP BY age
ORDER BY fraud_count DESC;

# 7. Transaction Volume by Time of Day
SELECT HOUR(trans_date_trans_time) AS transaction_hour, COUNT(*) AS transaction_count
FROM credit_card_transactions
GROUP BY transaction_hour
ORDER BY transaction_hour;

# 8.Average Transaction Amount for Fraud vs. Non-Fraud Transactions
 SELECT is_fraud, AVG(amt) AS average_amount
FROM credit_card_transactions
GROUP BY is_fraud;

#9. Merchant Categories with Highest Fraud Rate
SELECT category, 
       COUNT(*) AS total_transactions,
       SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_count,
       (SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 1.0 / COUNT(*)) * 100 AS fraud_rate
FROM credit_card_transactions
GROUP BY category
HAVING fraud_count > 0
ORDER BY fraud_rate DESC;

#10. Average Transaction Amount and Frequency per Cardholder
SELECT cc_num,
       COUNT(trans_num) AS total_transactions,
       AVG(amt) AS avg_transaction_amount,
       MAX(amt) AS max_transaction_amount
FROM credit_card_transactions
GROUP BY cc_num
HAVING total_transactions > 50  -- adjust threshold based on your analysis needs
   OR avg_transaction_amount > 1000
ORDER BY total_transactions DESC, avg_transaction_amount DESC;













/*

• TO_CHAR() (Oracle/PostgreSQL): Convert number or date to string.
• TO_NUMBER() (Oracle/PostgreSQL): Convert string to number.
• TO_DATE() (Oracle/PostgreSQL): Convert string to date.
• CAST() (SQL Standard): Convert between types.
• CONVERT() (SQL Server): Convert between types.

*/

--1. TO_CHAR() — Convert Number or Date to String

SELECT TO_NUMBER('12345', '99999');  -- returns: 12345

SELECT TO_NUMBER('12,345.67', '99G999D99');  
-- G = group separator, D = decimal point (locale-aware)
-- Example output: 12345.67

SELECT TO_NUMBER('$1,234.56', 'L9G999D99');  
-- L = currency symbol, G = comma, D = dot
-- Output: 1234.56


-- PostgreSQL / Oracle
SELECT TO_CHAR(1234567.89, '9,999,999.99');  -- Output: ' 1,234,567.89'

--2. TO_NUMBER() — Convert String to Number

-- PostgreSQL / Oracle
SELECT TO_CHAR(CURRENT_DATE, 'YYYY-MM-DD');  -- Output: '2025-07-24'

-- PostgreSQL / Oracle
SELECT TO_NUMBER('1,234.56', '9G999D99');  -- Output: 1234.56


SELECT TO_NUMBER('$2,500.75', 'L9G999D99');  -- Output: 2500.75

--3. TO_DATE() — Convert String to Date

-- PostgreSQL / Oracle
SELECT TO_DATE('2025-07-24', 'YYYY-MM-DD');  -- Output: 2025-07-24


SELECT TO_DATE('24-JUL-25', 'DD-MON-RR');  -- Output: 2025-07-24


SELECT CAST('123' AS INTEGER);  -- Output: 123


--4. CAST() — SQL Standard Type Conversion
-- PostgreSQL
SELECT CAST(CURRENT_DATE AS TEXT);  -- Output: '2025-07-24'

-- Oracle
--SELECT CAST(SYSDATE AS VARCHAR2(20)) FROM DUAL;

--5. CONVERT() — SQL Server Only
-- SQL Server
SELECT CONVERT(INT, '123');          -- Output: 123
SELECT CONVERT(VARCHAR, GETDATE());  -- Output: 'Jul 24 2025 11:15AM'


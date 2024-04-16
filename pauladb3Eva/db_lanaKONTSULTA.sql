-- PAULA FRAGA PINTA

select @@autocommit;
set autocommit = 0;

set sql_safe_updates = 0;

-- 1

INSERT INTO offices values 
("8", "Bilbo", "+34 189345432", "Gran via 35", null, null, "EH", "48005", "EMEA"),
("9", "Bartzelona", "+34 234764589", "Mallorca 58", null, null,  "CA", "08004", "EMEA");

commit;

-- 2

UPDATE employees 
SET officeCode = (SELECT officeCode FROM offices WHERE city = "Bilbo")
WHERE officeCode = (SELECT officeCode FROM offices WHERE city = "London")
AND jobTitle = "Sales Rep";

commit; -- GORDE ALDATEKETA 

-- 3

UPDATE customers
SET salesRepEmployeeNumber = (SELECT employeeNumber FROM employees WHERE lastName = "Kato" and firstName = "Yoshimi")
WHERE salesRepEmployeeNumber IN (SELECT employeeNumber FROM employees WHERE officeCode = (SELECT officeCode FROM offices WHERE city = "Sydney"));

UPDATE employees
SET officeCode = (SELECT officeCode FROM offices WHERE city = "Tokyo")
WHERE officeCode = (SELECT officeCode FROM offices WHERE city = "Sydney");

DELETE FROM offices WHERE city = "Sydney";

commit;

-- 4

SELECT o.country, o.city, o.officeCode, concat(e.firstName, " ", e.lastName) as employee
FROM offices o JOIN employees e using (officeCode);

commit;

-- 5

SELECT o.country as "Offices Country", c.country as "Customer country", count(customerNumber) as "Number of customers"
FROM employees e JOIN offices o using	(officeCode)
				JOIN customers c on employeeNumber = salesRepEmployeeNumber
GROUP BY o.country, c.country
ORDER BY 1 ASC;

-- 6

SELECT c.country, c.customerName, c.creditLimit, e.firstName, e.lastName
FROM customers c JOIN employees e on salesRepEmployeeNumber = e.employeeNumber
WHERE c.creditLimit > (SELECT AVG(c2.creditLimit) FROM customers c2 WHERE c.country = c2.country)
ORDER BY c.creditLimit DESC;


-- 7

SELECT e.* 
FROM employees e left outer join customers c on e.employeeNumber = c.salesRepEmployeeNumber
WHERE c.salesRepEmployeeNumber is null;
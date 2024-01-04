# Retrieve a list of user information with their name and date of registration who uses android phones. 
# First look at the structure of the user_info table in database and then write your query.

	SELECT * FROM user_info; 

	SELECT NAME, REGISTRATION_DATE FROM USER_INFO 
	WHERE OPERATING_SYSTEM = 'ANDROID';

# Edit your query above to find out users who have registered on or after 14th of july and sort the list of users in ascending order.

	SELECT NAME, REGISTRATION_DATE FROM USER_INFO 
	WHERE CAST(REGISTRATION_DATE AS DATE) >= '2023-07-14'

	ORDER BY REGISTRATION_DATE ASC;

# Retrieve the total number of orders placed by each user. Display the user's name and the total number of orders they have placed. 
# Sort the results in descending order based on the number of orders.

	SELECT U.NAME AS USER_NAME, COUNT(O.USER_ID) AS ORDER_PLACED 
	FROM USER_INFO U
	LEFT JOIN ORDERS O
	ON U.ID = O.USER_ID
	GROUP BY 1
	ORDER BY 2 DESC;

# Find the average price of menu items for each restaurant. Display the restaurant name and the average menu item price. 
# Sort the results in ascending order based on the restaurant name.

	SELECT R.NAME AS RESTAURANT_NAME, ROUND(AVG(M.PRICE)) AS AVG_ITEM_PRICE
	FROM RESTAURANT_INFO R
	LEFT JOIN MENUITEMS M
	ON R.RESTAURANT_ID = M.RESTAURANT_ID 
	GROUP BY 1
	ORDER BY 1;

# Identify the restaurant with the highest total sales (sum of order amounts). 
# Display the restaurant name and the total sales amount.

	SELECT R.NAME AS RESTAURANT_NAME, SUM(O.TOTAL_AMOUNT) AS TOTAL_SALES
	FROM RESTAURANT_INFO R 
	JOIN ORDERS O 
	ON R.RESTAURANT_ID = O.RESTAURANT_ID
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 1;

# Find the number of orders placed in each city. Display the city name and the number of orders. 
# Sort the results in descending order based on the number of orders.

	SELECT C.CITY_NAME, COUNT(O.ORDER_ID) AS TOTAL_ORDER
	FROM CITY C 
	LEFT JOIN USER_INFO U 
	ON C.CITY_ID = U.CITY_ID
	LEFT JOIN ORDERS O 
	ON U.ID = O.USER_ID
	GROUP BY 1
	ORDER BY 2 DESC;

# Write an SQL query to find the names of restaurants that have at least one menu item with a price greater than $10.
	
    SELECT DISTINCT NAME
	FROM
	(
		SELECT A.NAME, PRICE FROM restaurant_info A, menuitems B
		WHERE A.restaurant_id = B.restaurant_id
	) C
	WHERE price > 10;
    
# Write an SQL query to retrieve the user names and their corresponding orders where the order total is greater than the average order total for all users.
    
	SELECT  USER_NAME, ORDER_ID, TOTAL_AMOUNT AMOUNT 
	FROM 
	(
		SELECT A.NAME USER_NAME, B.TOTAL_AMOUNT, ORDER_ID FROM user_info A, ORDERS B
		WHERE A.ID = B.USER_ID
	) C 
	WHERE TOTAL_AMOUNT> (SELECT AVG(TOTAL_AMOUNT) FROM ORDERS);

# Write an SQL query to list the names of users whose last names start with 'S' or ends with ‘e’.

	SELECT NAME
	FROM USER_INFO
	WHERE UPPER(SUBSTRING_INDEX(NAME, ' ', -1)) LIKE 'S%' 
	OR UPPER(SUBSTRING_INDEX(NAME, ' ', -1)) LIKE '%E';

# Write an SQL query to find the total order amounts for each restaurant. 
# If a restaurant has no orders, display the restaurant name and a total amount of 0. Use the COALESCE function to handle null values.

	SELECT A.NAME, COALESCE(SUM(B.TOTAL_AMOUNT),0)
	FROM restaurant_info A 
	LEFT JOIN ORDERS B
	ON A.restaurant_id = B.restaurant_id
	GROUP BY A.NAME, A.RESTAURANT_ID;

# Write a query to find out how many orders were placed using cash or credit.

	SELECT PT.NAME PAYMENT_TYPE, COUNT(PT.NAME) NO_OF_ORDERS
	FROM PAYMENT_TRANSACTIONS P
	JOIN PAYMENT_TYPE PT ON P.PAY_TYPE_ID = PT.PAY_TYPE_ID
	GROUP BY 1;

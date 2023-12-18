SELECT DISTINCT Category_Grouped
FROM paytm_epurchase_data;

SELECT Top(5) Shipping_City, COUNT(*) AS OrderCount
FROM paytm_epurchase_data
GROUP BY Shipping_City
ORDER BY OrderCount DESC;

SELECT *
FROM paytm_epurchase_data
WHERE Category = 'Electronics';

SELECT *
FROM paytm_epurchase_data
WHERE Sale_Flag LIKE 'Yes';

SELECT Top(1) *
FROM paytm_epurchase_data
ORDER BY Item_Price DESC;

SELECT *,
       CASE
                WHEN Special_Price_effective < 50 THEN 'Below $50'
                ELSE 'Above $50'
       END AS Price_Category
FROM paytm_epurchase_data;

SELECT Category_Grouped, SUM(Item_Price) AS TotalSalesValue
FROM paytm_epurchase_data 
GROUP BY Category_Grouped;

SELECT Category, SUM(Item_Price) AS TotalSalesValue
FROM paytm_epurchase_data
GROUP BY Category;

SELECT Family,COUNT(Family) AS Ordercount
FROM Paytm_Epurchase_data
GROUP BY Family
ORDER BY COUNT(Family) DESC;


UPDATE Paytm_Epurchase_data
SET Payment_Method	=
	CASE
		WHEN Payment_Method NOT IN ('COD','Prepaid') THEN 'Online'
		ELSE Payment_Method
	END;


SELECT Product_Gender,AVG(Quantity) AS AverageQuantitySold
FROM Paytm_Epurchase_data
WHERE Category_Grouped = 'Clothing'
GROUP BY Product_Gender;SELECT TOP(5)*,Value_CM1 / NULLIF(Value_CM2, 0) AS Ratio_Value_CM1_to_CM2FROM Paytm_Epurchase_dataWHERE Value_CM2 <> 0
ORDER BY Ratio_Value_CM1_to_CM2 DESC;
SELECT TOP 3 Class, SUM(Item_Price) AS Sum_of_Item_Price ,SUM(Paid_pr) AS Sum_of_Paid_pr
FROM Paytm_Epurchase_data
GROUP BY Class
ORDER BY SUM(Item_Price) DESC;SELECT ColorFROM Paytm_Epurchase_dataWHERE Item_NM = 'Erik Original Twill Jos Beige Casual Trousers';SELECT
 SUM(coupon_money_effective) AS TotalCouponMoney,
 SUM(Coupon_Percentage) AS TotalCouponPercentage
FROM Paytm_Epurchase_data
WHERE Category_Grouped = 'Electronics';


--SELECT top 1
--    DATEPART(month, YourDateColumn) AS SalesMonth,
--    SUM(Item_Price) AS TotalSales
--FROM Paytm_Epurchase_data 
--GROUP BY DATEPART(month, YourDateColumn)
--ORDER BY TotalSales DESC

SELECT Segment,SUM(Item_Price) AS Sum_of_Item_Price,SUM(Quantity) AS Sum_of_Quantity
FROM Paytm_Epurchase_data
GROUP BY Segment
ORDER BY SUM(Item_Price) DESC;

SELECT AVG(Item_Price) AS AverageItemPrice 
FROM Paytm_Epurchase_data 
WHERE Sale_Flag = 'Yes'; 

SELECT * 
FROM Paytm_Epurchase_data P1 
WHERE Paid_pr > ( 
    SELECT AVG(Paid_pr) 
    FROM Paytm_Epurchase_data P2 
    WHERE P1.Family = P2.Family AND P1.Brand = P2.Brand );
	
SELECT  
    Color, 
    SUM(Item_Price) AS TotalSales 
FROM Paytm_Epurchase_data 
WHERE Category_Grouped = 'Clothing' 
GROUP BY Color;



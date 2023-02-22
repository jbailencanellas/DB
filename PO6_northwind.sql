--1

        select O.OrderID, O.OrderDate, sum(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) as A
        from Orders O, `Order Details` OD
        where OrderDate between '1998-05-01' and '1998-05-31' AND O.OrderID=OD.OrderID
        group by O.OrderID, O.OrderDate
         ;

--2

select year(O.OrderDate) as OrderYear, sum(OD.UnitPrice * OD.Quantity * (1-OD.Discount)) as Subtotal
from Orders O, `Order Details` OD
where OD.OrderID = O.OrderID AND
O.OrderDate between '1996-01-01' and '1998-12-31'
group by year(O.OrderDate);


--3

select O.ShipCountry, sum(OD.UnitPrice * OD.Quantity * (1-OD.Discount)) as Subtotal
from Orders O, `Order Details` OD
WHERE O.OrderID = OD.OrderID
group by O.ShipCountry
;

--4

select E.LastName, E.FirstName, E.EmployeeID, sum(OD.UnitPrice * OD.Quantity * (1-OD.Discount)) as Subtotal
from Employees E, Orders O, `Order Details` OD
where E.EmployeeID = O.EmployeeID
AND OD.OrderID = O.OrderID
GROUP BY E.LastName, E.FirstName
order by Subtotal desc
;

--5

select E.LastName, E.FirstName, E.EmployeeID, O.ShipCountry, sum(OD.UnitPrice * OD.Quantity * (1-OD.Discount)) as Subtotal
from Employees E, Orders O, `Order Details` OD
where E.EmployeeID = O.EmployeeID
and OD.OrderID = O.OrderID
group by E.LastName, E.FirstName, O.ShipCountry
order by O.ShipCountry asc, Subtotal desc
;

--6

select C.CategoryID, C.CategoryName, sum(OD.UnitPrice * OD.Quantity * (1-OD.Discount)) as Subtotal
from Categories C, Products P, `Order Details` OD
where OD.ProductID = P.ProductID
and P.CategoryID = C.CategoryID
group by C.CategoryID
;

--7

select C.CategoryID, C.CategoryName, count(distinct P.ProductID) as `Number`
from Categories C, Products P, `Order Details` OD
where OD.ProductID = P.ProductID
and P.CategoryID = C.CategoryID
group by C.CategoryID
;

--8

select O.OrderID, P.ProductID, P.ProductName, OD.UnitPrice, OD.Quantity, OD.Discount,
sum(OD.UnitPrice * OD.Quantity * (1-OD.Discount)) as Subtotal
from Orders O, Products P, `Order Details` OD
where OD.ProductID = P.ProductID
and O.OrderID = OD.OrderID
and OD.OrderID = 10248
group by OD.ProductID
;

--9

select sum(OD.UnitPrice * OD.Quantity * (1-OD.Discount)) as TotalPrice
from Orders O, Products P, `Order Details` OD
where OD.ProductID = P.ProductID
and O.OrderID = OD.OrderID
and OD.OrderID = 10248
;

--10

select O.OrderID, O.OrderDate, O.RequiredDate, C.CustomerID, C.CompanyName, C.Address, C.City, C.Region, C.PostalCode, C.Country, O.ShippedDate, SP.CompanyName, O.Freight, O.ShipAddress, O.ShipCity, O.ShipRegion, O.ShipPostalCode, O.ShipCountry,
concat(E.FirstName, ' ' , E.LastName) as SalesPerson
from Orders O, Customers C, Suppliers S, Products P, `Order Details` OD, Employees E, Shippers SP
where O.OrderID = OD.OrderID
and OD.ProductID = P.ProductID
and P.SupplierID = S.SupplierID
and O.CustomerID = C.CustomerID
and O.EmployeeID = E.EmployeeID
and SP.ShipperID = O.ShipVia
and O.OrderID = 10248
and E.FirstName = 'Steven'
and E.LastName = 'Buchanan'
group by O.OrderID
;


--11
select P.ProductName, sum(OD.Quantity) as Units
from Products P, `Order Details` OD, Categories C
where P.ProductID = OD.ProductID
and P.CategoryID = C.CategoryID
group by P.ProductName
order by Units desc limit 10;

--12

select P.ProductID, P.UnitPrice, OD.UnitPrice as UnitPriceSold
from Products P, `Order Details` OD
where P.ProductID = OD.ProductID
group by P.ProductID, P.UnitPrice, OD.UnitPrice
order by P.ProductID asc;

--13

select P.ProductID, P.ProductName, P.UnitPrice
from Products P, `Order Details` OD
where P.ProductID = OD.ProductID
group by P.ProductID
order by P.UnitPrice desc limit 10;

--14

 SELECT
distinct OD.ProductID,
year(O.OrderDate) as Year,
P.UnitPrice,
OD.UnitPrice,
(OD.UnitPrice-(OD.UnitPrice * OD.Discount)) as UnitPriceWithDiscount,
(OD.UnitPrice - P.UnitPrice) as profit
from Products P, `Order Details` OD, Orders O
where P.ProductID = OD.ProductID
and OD.OrderID = O.OrderID
order by profit desc, Year
limit 10;

--15

SELECT
P.ProductID,
P.ProductName, 
sum(OD.Quantity * (OD.UnitPrice - P.UnitPrice )) as Total_Profit
from Products P, `Order Details` OD
where P.ProductID = OD.ProductID
group by P.ProductID
order by Total_Profit DESC
limit 10;

--16

SELECT
distinct P.ProductID,
P.ProductName,
P.UnitPrice
from Products P 
where P.UnitPrice > (select avg(P1.UnitPrice) from Products P1)
order by UnitPrice desc
;

--18

SELECT
S.SupplierID,
S.CompanyName,
count(P.ProductID) as qty
from Suppliers S, Products P
where P.SupplierID = S.SupplierID
group by S.SupplierID
order by qty desc, S.CompanyName asc
limit 10;

--19

select count(*) as NumberBCN
from Customers
where City = 'Barcelona'
;

--20

select
CO.CompanyName, count(O.OrderID) as NumOrders
from Customers CO, Orders O
where CO.CustomerID = O.CustomerID
group by CO.CompanyName
having NumOrders > 25
;


--26
































































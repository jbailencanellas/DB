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

select E.LastName, E.FirstName, E.EmployeeID, O.ShipCountry, sum(OD.UnitPrice * OD.Quantity * (1-OD.Discount)) as Subtotal
from Employees E, Orders O, `Order Details` OD
where E.EmployeeID = O.EmployeeID
AND OD.OrderID = O.OrderID
order by Subtotal desc
GROUP BY E.LastName, E.FirstName
order by Subtotal desc;

--5








































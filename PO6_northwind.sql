--1

        select O.OrderID, O.OrderDate, (OD.UnitPrice*OD.Quantity*OD.Discount) as A
        from Orders O, `Order Details` OD
        where OrderDate between '1998-05-01' and '1998-05-31'
         ;

         price*quantity*(1-discount)
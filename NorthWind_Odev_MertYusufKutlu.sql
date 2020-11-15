--1.	Employees tablosundan, çalýþanlara ait ad, soyad, görev ve doðum tarihi bilgilerini listeleyiniz.
SELECT CONCAT_WS('-', FirstName, LastName, Title, BirthDate ) [AD, SOYAD, GÖREV, DOGUM TARÝHÝ] FROM Employees;

--2.	Employees tablosundaki çalýþanlara ait bilgileri listelerken 
--ünvan (TitleOfCourtesy), ad (FirstName) ve soyad (LastName) ayný sütunda olacak þekilde listeleyiniz.
SELECT CONCAT_WS('', Title, FirstName, LastName) [Unvan-Ad-Soyad] FROM Employees;


--3.	Categories tablosuna CategoryName Pideler, Description
--'Ýnce Pide Üzerinde Çeþitli Malzemelerle Piþirilerek Hazýrlanmýþ Yemek Türü' 
--olacak þekilde bir kayýt ekleyiniz.
INSERT INTO Categories(CategoryName, Description) VALUES ('Pideler','Ýnce Pide Üzerinde Çeþitli Malzemelerle Piþirilerek Hazýrlanmýþ Yemek Türü')
SELECT * FROM Categories;

--4.	Shippers tablosuna MNG Kargo, 4440606 ve Yurt içi Kargo, 4449999 kayýtlarýný ekleyiniz.
INSERT INTO Shippers(CompanyName, Phone) VALUES ('MNG Kargo','4440606')
INSERT INTO Shippers(CompanyName, Phone) VALUES ('Yurt içi Kargo','4449999')
SELECT * FROM Shippers;

--5.	Girdiðiniz Yurt içi Kargo kaydýný Yurtiçi Kargo olarak güncelleyiniz.
UPDATE Shippers SET CompanyName ='Yurtiçi Kargo' WHERE CompanyName = 'Yurt içi Kargo'
SELECT * FROM Shippers;

--6.	Customers (Müþteriler) tablosuna  kendi bilgilerinizi içeren bir kayýt giriniz.
INSERT INTO Customers(CustomerID ,CompanyName, ContactName, ContactTitle, City, Region, Country) 
VALUES('MERT' ,'BilgeAdam','Mert Kutlu','Software Developer', 'Ankara', 'TR', 'Turkey');
SELECT * FROM Customers;

--7.	Çalýþanlardan (employees) ünvaný Mr. ve Dr. olanlarý listeleyiniz.
SELECT * FROM Employees WHERE TitleOfCourtesy = 'Mr.' OR TitleOfCourtesy = 'Dr.';

--8.	Çalýþanlar tablosundaki çalýþan sayýsýný getiriniz.
SELECT COUNT(*) FROM Employees 

--9.	Çalýþanlar tablosunda kaç farklý çeþit þehirden (city) kiþi bulunmaktadýr.
SELECT City FROM Employees GROUP BY City;

--10.	Çalýþanlar tablosundaki kiþileri yaþlarýyla birlikte listeleyiniz.
SELECT CONVERT(INT,GETDATE()-BirthDate)/365 FROM Employees;

--11.	Çalýþanlar tablosundaki kiþilerin yaþ ortalamasýný hesaplayýnýz.
SELECT AVG(CONVERT(INT,GETDATE()-BirthDate))/365 FROM Employees;

--12.	Çalýþanlarý önce þehir, sonra ad, sonra soyada göre sýralayýnýz.
SELECT City,FirstName,LastName FROM Employees;

--13.	Çalýþanlarýn ad, soyad alanlarýný listeleyiniz.
--Ve üçüncü bir alan olarak da ülkelerini USA olanlarý 
--"The United States of America" ve UK olanlarý United Kingdom olarak yazarak gösteriniz.
--Diðerleri için ülkeyi aynen býrakýnýz.
SELECT FirstName,LastName, CASE Country 
WHEN 'USA' THEN 'The United States of America' 
WHEN 'UK' THEN  'United Kingdom' END Country
FROM Employees
--14.	Customers ve Orders tablolarý arasýnda CustomerID alanlarý üzerinde iliþki bulunmaktadýr.
--Tüm müþterilerin ID ve Ýletiþim isimleriyle birlikte
--kaçar adet sipariþte bulunduklarýný listeleyiniz.
SELECT c.CustomerID,c.ContactName,Count(o.CustomerID) SiparisSayisi From Customers c 
JOIN Orders o On c.CustomerID=o.CustomerID GROUP BY c.CustomerID,c.ContactName


--****************************************

--ÖDEV BÖLÜM B
--Northwind veritabaný üzerinde aþaðýdaki görevleri yerine getirecek sorgularý yazýnýz..
--1. Amerika'da yaþayan çalýþanlarýn verdiði sipariþleri listeleyiniz.
SELECT Country = 'USA',ShipName FROM Orders 

SELECT e.FirstName, o.OrderID FROM Employees e JOIN Orders o On  e.EmployeeID = o.EmployeeID
WHERE e.Country='USA'

--2. 30 no'lu üründen 30'dan fazla sipariþ veren müþterileri listeleyiniz.
SELECT c.ContactName,od.Quantity,p.ProductID FROM PRODUCTS P JOIN [Order Details] od ON P.ProductID = od.ProductID
JOIN ORDERS O On od.OrderID=O.OrderID
JOIN CUSTOMERS C on c.CustomerID = o.CustomerID WHERE p.ProductID = 30 and od.Quantity > 30 

--3. Soyisimleri D ile baþlayan çalýþanlarýn isimlerini listeleyiniz.
SELECT * FROM Employees WHERE LastName LIKE 'D%'

--4. Adý Tofu olan ve üzerinde hiç indirim uygulanmayan ürünlerin Order Details
--tablosuna ait tüm sütunlarýný listeleyiniz.
SELECT * FROM Products JOIN [Order Details] ON ProductName = 'Tofu' AND Discount <= 0

--5. Alfreds Futterkiste isimli þirketten elde edilen toplam ciroyu gösteriniz.
SELECT SUM((od.UnitPrice-(od.UnitPrice*od.Discount))*od.Quantity) [Endorsement] 
FROM CUSTOMERS c JOIN Orders o ON o.CustomerID=c.CustomerID
JOIN [Order Details] od ON o.OrderID=od.OrderID WHERE c.CompanyName='Alfreds Futterkiste'	

--****************************************

--ÖDEV BÖLÜM C
--Northwind üzerinde aþaðýdaki sorgularý gerçekleþtiriniz:
--1) Ürünlerin isimlerini ve birim baþýna miktarlarýný gösteren sorguyu yazýnýz.
SELECT CONCAT_WS('/' ,ProductName, QuantityPerUnit) [Birim Baþýna] FROM Products;

--2) Devam etmekte olan (discontinued=false) ürünleri (product id ve name) listeleyiniz.
SELECT CONCAT_WS(' / ', ProductID,ProductName,Discontinued) [Ýndirimsiz Ürünler] FROM Products WHERE Discontinued = 0

--3) Devam etmeyen (discontinued=true) ürünleri (product id ve name) listeleyiniz.
SELECT CONCAT_WS(' / ', ProductID,ProductName,Discontinued) [Ýndirimli Ürünler] FROM Products WHERE Discontinued = 1

--4) Ürünleri en pahalýdan en ucuza doðru sýralayan sorguyu yazýnýz.
SELECT ProductName,UnitPrice FROM Products ORDER BY UnitPrice DESC;

--5) Devam etmekte olan ürünlerden fiyatý 20 dolardan aþaðý olanlarý listeleyiniz.
SELECT * FROM Products WHERE UnitPrice < 20 AND UnitsOnOrder > 0

--6) Birim fiyatý 15 ve 25 arasýnda olan devam etmekte olan ürünleri birim fiyatýna göre azalan þekilde sýralayýnýz.
SELECT * FROM Products WHERE UnitPrice BETWEEN 15 AND 25 AND UnitsOnOrder > 0

--7) Fiyatý ortalama fiyatýn üzerinde olan ürünleri listeleyiniz.
SELECT * FROM Products WHERE UnitPrice > 28.8663

--8) En pahalý 10 ürünü fiyatýna göre artan (ucuzdan pahalýya) sýralayan sorguyu yazýnýz.
SELECT TOP 10 * FROM Products  ORDER BY UnitPrice ASC

--9) Toplamda en çok sayýda sipariþ verilmiþ 10 ürünü sipariþ verilme sayýlarýyla birlikte listeleyiniz.
SELECT TOP 10 p.ProductName, COUNT(od.OrderID) [Order Count Total] 
FROM Products p JOIN [Order Details] Od ON p.ProductID = od.ProductID
GROUP BY p.ProductName ORDER BY [Order Count Total]  DESC

--10) Ürünlerin sipariþ verilme sayýlarýný kategori bazlý olarak listeleyiniz.
--ve her kategori için en çok sipariþ verilen ürünü de ayný satýrýnda gösteriniz.
SELECT TOP 10 p.ProductName,ct.CategoryName, COUNT(od.OrderID) [Total Orders] 
FROM Products p JOIN [Order Details] Od ON p.ProductID = od.ProductID
JOIN Categories ct ON p.CategoryID = ct.CategoryID 
GROUP BY ct.CategoryName,p.ProductName ORDER BY [Total Orders] DESC

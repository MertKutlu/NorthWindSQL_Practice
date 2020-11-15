--1.	Employees tablosundan, �al��anlara ait ad, soyad, g�rev ve do�um tarihi bilgilerini listeleyiniz.
SELECT CONCAT_WS('-', FirstName, LastName, Title, BirthDate ) [AD, SOYAD, G�REV, DOGUM TAR�H�] FROM Employees;

--2.	Employees tablosundaki �al��anlara ait bilgileri listelerken 
--�nvan (TitleOfCourtesy), ad (FirstName) ve soyad (LastName) ayn� s�tunda olacak �ekilde listeleyiniz.
SELECT CONCAT_WS('', Title, FirstName, LastName) [Unvan-Ad-Soyad] FROM Employees;


--3.	Categories tablosuna CategoryName Pideler, Description
--'�nce Pide �zerinde �e�itli Malzemelerle Pi�irilerek Haz�rlanm�� Yemek T�r�' 
--olacak �ekilde bir kay�t ekleyiniz.
INSERT INTO Categories(CategoryName, Description) VALUES ('Pideler','�nce Pide �zerinde �e�itli Malzemelerle Pi�irilerek Haz�rlanm�� Yemek T�r�')
SELECT * FROM Categories;

--4.	Shippers tablosuna MNG Kargo, 4440606 ve Yurt i�i Kargo, 4449999 kay�tlar�n� ekleyiniz.
INSERT INTO Shippers(CompanyName, Phone) VALUES ('MNG Kargo','4440606')
INSERT INTO Shippers(CompanyName, Phone) VALUES ('Yurt i�i Kargo','4449999')
SELECT * FROM Shippers;

--5.	Girdi�iniz Yurt i�i Kargo kayd�n� Yurti�i Kargo olarak g�ncelleyiniz.
UPDATE Shippers SET CompanyName ='Yurti�i Kargo' WHERE CompanyName = 'Yurt i�i Kargo'
SELECT * FROM Shippers;

--6.	Customers (M��teriler) tablosuna  kendi bilgilerinizi i�eren bir kay�t giriniz.
INSERT INTO Customers(CustomerID ,CompanyName, ContactName, ContactTitle, City, Region, Country) 
VALUES('MERT' ,'BilgeAdam','Mert Kutlu','Software Developer', 'Ankara', 'TR', 'Turkey');
SELECT * FROM Customers;

--7.	�al��anlardan (employees) �nvan� Mr. ve Dr. olanlar� listeleyiniz.
SELECT * FROM Employees WHERE TitleOfCourtesy = 'Mr.' OR TitleOfCourtesy = 'Dr.';

--8.	�al��anlar tablosundaki �al��an say�s�n� getiriniz.
SELECT COUNT(*) FROM Employees 

--9.	�al��anlar tablosunda ka� farkl� �e�it �ehirden (city) ki�i bulunmaktad�r.
SELECT City FROM Employees GROUP BY City;

--10.	�al��anlar tablosundaki ki�ileri ya�lar�yla birlikte listeleyiniz.
SELECT CONVERT(INT,GETDATE()-BirthDate)/365 FROM Employees;

--11.	�al��anlar tablosundaki ki�ilerin ya� ortalamas�n� hesaplay�n�z.
SELECT AVG(CONVERT(INT,GETDATE()-BirthDate))/365 FROM Employees;

--12.	�al��anlar� �nce �ehir, sonra ad, sonra soyada g�re s�ralay�n�z.
SELECT City,FirstName,LastName FROM Employees;

--13.	�al��anlar�n ad, soyad alanlar�n� listeleyiniz.
--Ve ���nc� bir alan olarak da �lkelerini USA olanlar� 
--"The United States of America" ve UK olanlar� United Kingdom olarak yazarak g�steriniz.
--Di�erleri i�in �lkeyi aynen b�rak�n�z.
SELECT FirstName,LastName, CASE Country 
WHEN 'USA' THEN 'The United States of America' 
WHEN 'UK' THEN  'United Kingdom' END Country
FROM Employees
--14.	Customers ve Orders tablolar� aras�nda CustomerID alanlar� �zerinde ili�ki bulunmaktad�r.
--T�m m��terilerin ID ve �leti�im isimleriyle birlikte
--ka�ar adet sipari�te bulunduklar�n� listeleyiniz.
SELECT c.CustomerID,c.ContactName,Count(o.CustomerID) SiparisSayisi From Customers c 
JOIN Orders o On c.CustomerID=o.CustomerID GROUP BY c.CustomerID,c.ContactName


--****************************************

--�DEV B�L�M B
--Northwind veritaban� �zerinde a�a��daki g�revleri yerine getirecek sorgular� yaz�n�z..
--1. Amerika'da ya�ayan �al��anlar�n verdi�i sipari�leri listeleyiniz.
SELECT Country = 'USA',ShipName FROM Orders 

SELECT e.FirstName, o.OrderID FROM Employees e JOIN Orders o On  e.EmployeeID = o.EmployeeID
WHERE e.Country='USA'

--2. 30 no'lu �r�nden 30'dan fazla sipari� veren m��terileri listeleyiniz.
SELECT c.ContactName,od.Quantity,p.ProductID FROM PRODUCTS P JOIN [Order Details] od ON P.ProductID = od.ProductID
JOIN ORDERS O On od.OrderID=O.OrderID
JOIN CUSTOMERS C on c.CustomerID = o.CustomerID WHERE p.ProductID = 30 and od.Quantity > 30 

--3. Soyisimleri D ile ba�layan �al��anlar�n isimlerini listeleyiniz.
SELECT * FROM Employees WHERE LastName LIKE 'D%'

--4. Ad� Tofu olan ve �zerinde hi� indirim uygulanmayan �r�nlerin Order Details
--tablosuna ait t�m s�tunlar�n� listeleyiniz.
SELECT * FROM Products JOIN [Order Details] ON ProductName = 'Tofu' AND Discount <= 0

--5. Alfreds Futterkiste isimli �irketten elde edilen toplam ciroyu g�steriniz.
SELECT SUM((od.UnitPrice-(od.UnitPrice*od.Discount))*od.Quantity) [Endorsement] 
FROM CUSTOMERS c JOIN Orders o ON o.CustomerID=c.CustomerID
JOIN [Order Details] od ON o.OrderID=od.OrderID WHERE c.CompanyName='Alfreds Futterkiste'	

--****************************************

--�DEV B�L�M C
--Northwind �zerinde a�a��daki sorgular� ger�ekle�tiriniz:
--1) �r�nlerin isimlerini ve birim ba��na miktarlar�n� g�steren sorguyu yaz�n�z.
SELECT CONCAT_WS('/' ,ProductName, QuantityPerUnit) [Birim Ba��na] FROM Products;

--2) Devam etmekte olan (discontinued=false) �r�nleri (product id ve name) listeleyiniz.
SELECT CONCAT_WS(' / ', ProductID,ProductName,Discontinued) [�ndirimsiz �r�nler] FROM Products WHERE Discontinued = 0

--3) Devam etmeyen (discontinued=true) �r�nleri (product id ve name) listeleyiniz.
SELECT CONCAT_WS(' / ', ProductID,ProductName,Discontinued) [�ndirimli �r�nler] FROM Products WHERE Discontinued = 1

--4) �r�nleri en pahal�dan en ucuza do�ru s�ralayan sorguyu yaz�n�z.
SELECT ProductName,UnitPrice FROM Products ORDER BY UnitPrice DESC;

--5) Devam etmekte olan �r�nlerden fiyat� 20 dolardan a�a�� olanlar� listeleyiniz.
SELECT * FROM Products WHERE UnitPrice < 20 AND UnitsOnOrder > 0

--6) Birim fiyat� 15 ve 25 aras�nda olan devam etmekte olan �r�nleri birim fiyat�na g�re azalan �ekilde s�ralay�n�z.
SELECT * FROM Products WHERE UnitPrice BETWEEN 15 AND 25 AND UnitsOnOrder > 0

--7) Fiyat� ortalama fiyat�n �zerinde olan �r�nleri listeleyiniz.
SELECT * FROM Products WHERE UnitPrice > 28.8663

--8) En pahal� 10 �r�n� fiyat�na g�re artan (ucuzdan pahal�ya) s�ralayan sorguyu yaz�n�z.
SELECT TOP 10 * FROM Products  ORDER BY UnitPrice ASC

--9) Toplamda en �ok say�da sipari� verilmi� 10 �r�n� sipari� verilme say�lar�yla birlikte listeleyiniz.
SELECT TOP 10 p.ProductName, COUNT(od.OrderID) [Order Count Total] 
FROM Products p JOIN [Order Details] Od ON p.ProductID = od.ProductID
GROUP BY p.ProductName ORDER BY [Order Count Total]  DESC

--10) �r�nlerin sipari� verilme say�lar�n� kategori bazl� olarak listeleyiniz.
--ve her kategori i�in en �ok sipari� verilen �r�n� de ayn� sat�r�nda g�steriniz.
SELECT TOP 10 p.ProductName,ct.CategoryName, COUNT(od.OrderID) [Total Orders] 
FROM Products p JOIN [Order Details] Od ON p.ProductID = od.ProductID
JOIN Categories ct ON p.CategoryID = ct.CategoryID 
GROUP BY ct.CategoryName,p.ProductName ORDER BY [Total Orders] DESC

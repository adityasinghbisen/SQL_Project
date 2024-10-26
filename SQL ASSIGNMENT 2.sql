select * from customers;
select * from employees;

#Day 7 - question 1-
 select employeenumber , concat(firstname ,' ', lastname ) as salesperson , count(customername) as unique_customer
 from employees join customers on (employeeNumber=salesRepEmployeeNumber) 
 group by employeeNumber
 order by unique_customer desc;
 
 #DAY 7 - question 2 -
select * from orders ;
select * from orderdetails ;
select * from  products ;
select* from customers ;

select  c.customernumber , c.customername ,p.productcode , p.productname ,  sum(od.quantityordered) as  Ordered_Qty ,ifnull(p.quantityinstock,0)as
total_inventory, ifnull(p.quantityinstock-sum(od.quantityordered),0) as left_city  from customers c join orders o on c.customername = c.customername join
orderdetails od on o.ordernumber = od.ordernumber join products p on od.productcode = p.productcode left join products s on p.productcode = s.productcode
group by c.customernumber , p.productcode order by c.customernumber;

/*
select c.customernumber ,c.customername , p.productcode , p.productname , sum(od.quantityordered) as ordered_qty , ifnull(p.quantityinstock,0) as total_inventory,
 ifnull(p.qunatityinstock-sum(od.quantityordered),0) as left_city from customers c join  orders o on c.customername = o.customername 
 join orderdetails od on  o.orderNumber= od.ordernumber join products p on od.productcode=p.productcode left join product s on p.productcode = s.productcode 
 group by c.customername , p.productcode  order by c.customernumber;
  */
  
  #DAY 7 - question 3-
   create table Laptop( Laptop_Name varchar(20));
   insert into  laptop (laptop_name) values("HP") ;
   insert into laptop (laptop_name) values("DELL");
   select * from laptop;
   create table  color( Color_Name varchar(20));
   insert into  color (color_name) values("white") ;
   insert into color (color_name) values("silver");
   insert into color (color_name) values("black");
   select * from  color;
   
   select laptop_name , color_name from laptop cross join color order by Laptop_Name asc  ;
   
   
   #Day 7 -question 4-
   create table project(EmployeesId int , FullName varchar(20), Gender char(1) , ManagerID int );
   insert into project values(1,"pranaya","M", 3); 
   insert into project values(2,"priyanka","F", 1); 
   insert into project values(3,"preety","F", Null); 
   insert into project values(4,"anurag","M", 1); 
   insert into project values(5,"sambit","M", 1); 
   insert into project values(6,"rajesh","M", 3); 
   insert into project values(7,"Heena","F", 3); 
   
    /*select fullname as manager_name,fullname as EMP_Name from project where employeesid in(select ManagerID from project );*/
    
    select p.fullname as managername , pp.fullname as emp_name from project p join project pp on p.EmployeesId = pp.ManagerID;
     
     
# DAY 8 - question 1-
create table facility (Facility_ID int not null,Name varchar(100)  , State varchar(100), country varchar(100) );
alter table  facility add city varchar(100) after name ;
alter table facility modify Facility_ID int primary key auto_increment;
alter table facility modify name varchar(100) not null ;
alter table facility modify city varchar(100) not null ;
desc facility;

#DAY 9 - question 1 -
create table university ( ID int , NAME varchar(100));
insert into  university values(1,"   pune     university   ");
insert into  university values(2,"  mumbai     university   ");
insert into  university values(3," delhi     university   ");
insert into  university values(4,"  madras     university   ");
insert into  university values(5,"  nagpur     university   ");
select * from university;
set sql_safe_updates = 0 ;
 update university set name = replace(name,' ' ,'');
select * from university;


#DAY 10 - question -2-

select * from orderdetails;
select * from orders;
select year(o.orderdate) as year ,  count(od.quantityordered) as value from orders o join orderdetails od on od.ordernumber =  o.ordernumber 
group by year order by value desc ;
select year(o.orderdate) as year ,  count(od.quantityordered), sum(count(od.quantityordered)) over () as value from orders o join orderdetails od on od.ordernumber =  o.ordernumber 
group by year order by value desc ;

create view product_status 
as
select year(o.orderdate) as year ,  count(od.quantityordered), 
concat(round(count(od.quantityordered)/sum(count(od.quantityordered)) over () *100),"%") as value 
from orders o join orderdetails od on od.ordernumber =  o.ordernumber 
group by year order by value desc ;

select * from product_status;

#DAY 11 - question 1 -
select * from customers;

select customernumber , creditlimit ,
case 
when creditlimit >100000 then "platinum"
when creditlimit between 25000 and 100000 then "Gold"
when creditlimit < 25000 then "silver"
end as GetCustomerLevel 
from customers ;

#DAY 11 - question 2-
select *  from customers;
select * from payments;

select year(paymentdate) as year ,country, concat(round(sum(amount)/1000),"K") as amount from customers c join payments p
 on c.customernumber=p.customernumber
group by year,country;


#DAY 12-question 1-
 select * from orders;
 select year(orderdate) as year ,monthname(orderdate) as month ,count(ordernumber) as total_orders , 
 concat(round((count(ordernumber)-lag(count(ordernumber),1,0) over ()) /(lag(count(ordernumber),1,0) over() ) * 100 ),"%") as "% YOY Change"
 from orders  
 group by year,month;
 
 #DAY 12 - question 2 - 
  
 create table emp_udf(empID int , name varchar(24) , DOB date);
 insert into emp_udf (name,DOB) values ("Piyush", "1990-03-30"), ("Aman", "1992-08-15"),
 ("Meena", "1998-07-28"), ("Ketan", "2000-11-21"), ("Sanjay", "1995-05-21");
 select * from emp_udf;
 select row_number() over() as Emp_ID ,name ,DOB , concat(concat(year(curdate())-year(DOB)," years"), concat(month(DOB)," months") )as Age
 from emp_udf;
  
  
  #DAY 13 - question 1 -
  select * from customers;
  select * from orders;
  select customernumber ,customername from customers where customernumber  not in(select customernumber from orders) ;
  
  
  #DAY 13 - question 2 -
  select * from customers;
  select * from orders;
  select c.customernumber , c.customername  ,count(o.orderNumber) as Total_orders from customers c join orders o on (c.customernumber=o.customernumber)
  group by customerNumber; # by inner join 
  # by outer join -
  select c.customernumber , c.customername  ,count(o.orderNumber) as Total_orders from customers c left join orders o on (c.customernumber=o.customernumber)
  group by customerNumber
  union
  select c.customernumber , c.customername  ,count(o.orderNumber) as Total_orders from customers c right join orders o on (c.customernumber=o.customernumber)
  group by customerNumber;
    
  #DAY 13 - question 3 -
  select * from orderdetails ;
  select orderNumber, max(quantityOrdered) from orderdetails as od1 where quantityOrdered<
  (select max(quantityordered) from orderdetails as od2 where od1.ordernumber = od2.ordernumber)
    group by ordernumber  ;
 
 #DAY 13 - question 4 -
 select * from orderdetails;
 select   max(count(quantityordered)) over() as max, min(count(quantityordered)) over() as min from orderdetails 
 group by ordernumber ;
 
 #DAY 13 - question 5 -
 select * from products;
 select productline ,   count(buyprice)	 as Total from products where buyprice > ( select avg(buyprice) from products )
 group by productline 
 order by Total desc;
 
 
 #DAY 14 - question 1 -
 create table EMP_EH ( EMPID int primary key , EMPNAME varchar(25), EmailAddress varchar(45));
 
 #DAY 15 - question 1 -
 create table emp_bit ( name varchar(25) , occupation varchar(30), working_date  date , working_hours int );
 INSERT INTO Emp_BIT VALUES
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', 12),  
('Antonio', 'Business', '2020-10-04', 11);  
  
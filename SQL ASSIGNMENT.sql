# SQL ASSIGNMENT-

#DAY 3- question 1
select * from customers;
 
 select customernumber , customername , state , creditlimit from customers
 where  state is not null 
 and creditlimit between 50000 and 100000 
 order by creditLimit  desc;
   
   
   #DAY 3 - question 2
   select distinct productline from  products;
   select distinct productline from products where productline like "%cars";
	
 #DAY 4 - question 1
 select * from orders;
select  ordernumber , status ,ifnull(comments,"-") as comments  from orders
 where status = "shipped";
 
  #DAY 4 - question 2
  select * from employees;
   select employeenumber ,firstname , jobtitle,
   case
   when jobtitle = "president" then "p"
   when jobtitle like "sales%" then "SM"
   when jobtitle like"sale%" then "SM"
   when jobtitle like "%Rep" then "SR"
   when jobtitle like "VP%" then "VP"
   when jobtitle = " VP Marketing" then "VP"
   end as jobTitle_abbr
   from employees ;
   
   
   #DAY 5 - question 1
   select * from payments;
   select year(paymentDate) as year , min(amount) from payments
   group by year ;
   
   #DAY 5 - question 2
   select* from orders;
   select year(orderdate) as year ,concat("Q", quarter(orderdate)) as quater , count(distinct customerNumber) as uniquecustomer ,
   count(ordernumber) as totalorders from orders
   group by year,quater;
   
   #DAY 5 - question 3
   select * from payments ;
   select monthname(paymentdate) as month ,  concat(round(sum(amount)/1000) ,"K") as formated_amount from payments group by month
   order by formated_amount desc;
   
   
   #DAY 6 - question 1
   create database assignment ;
   use assignment ;
   create table journey(Bus_ID int unique not null, Bus_Name varchar(20) not null , 
   source_station varchar(20) not null, Destination varchar(20) not null , Email varchar(35) unique );
   show tables;
   desc table journey;
   
   
   #DAY 6- qustion 2
   
   create table vendor(Vendor_ID int unique not null ,Name varchar (15) not null ,Email varchar(35) unique not null ,
   country varchar(15)  default 'n/l');
   desc table vendor ;
   
   #DAY 6- qustion 3
   create table movies(Movie_ID int not null unique  , Name varchar(20) not null, Release_year int , 
    Cast varchar(15) not null ,Gender enum('M','F') not null, Noofshows int check(noofshows > 0) );	
    desc table movies ;
    
    
    #DAY 6 - question 4 (A)
    create table product( product_id int primary key , product_name  varchar(20) unique not null , description text ,
    supplier_id int , foreign key(supplier_id) references supplier(supplier_name) );
    
    
    #DAY 6 - question 4 (B) 
    create table supplier(supplier_id int primary key , supplier_name varchar(20),location varchar(35) );
    
    
    #DAY 6 - question 4 (c)
    create table stocks(id int primary key ,  product_id int , foreign key ( product_id) references product(product_id), Balance_stock int);
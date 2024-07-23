create database Library;
use library;
create table Branch (
Branch_No int primary key ,
Manager_Id int ,
Branch_address varchar(20),
Contact_No bigint);

insert into Branch(Branch_No,manager_id,branch_address,contact_no) values 
(10,101,'calicut',9947581625),
(11,102,'balussery',9947710023),
(12,103,'kakkur',9526300311),
(13,104,'malappuram',8301065429);
select*from branch;

create table employee(
emp_Id int primary key,
emp_name varchar (15),
position varchar(20),
salary int,
branch_no int,
foreign key (branch_no) references branch(branch_no)
);
insert into employee values 
(1001,'suresh','librarian',25000,10),
(1002,'anagha','library_assistant',45000,11),
(1003,'arshin','library_clerk',40000,12),
(1004,'alex','archivist',40000,13);
select*from employee;

create table books(
ISBN int primary key,
book_title varchar (20),
category varchar(20),
rental_price int,
status enum('yes','no'),
author varchar(15),
publisher varchar(15));

insert into books values (1245,'Araachar','fiction',29,'yes','K R meera','DC Books'),
(1284,'Randamoozham','fantacy',20,'yes','M T vasudevan','current Books'),
(1352,'Mathilukal','Romance',10,'no','Basheer','green books'),
(1200,'Kaalam','novel',13,'yes','M T Vasudevan','DC Books');
select*from books;

create table customer (
Customer_Id int PRIMARY KEY  ,
Customer_name  varchar(20),
Customer_address  varchar(20),
Reg_date datetime);
select*from customer;
insert into customer values (501,'giri','kinaloor','2015-12-28'),
(502,'sreenish','balussery','2023-10-30'),
(503,'lakshmi','calicut','2024-01-09'),
(504,'arshitha','mysore','2012-12-28');

create table issuestatus (
issue_id int primary key,
issued_cust int ,
foreign key (issued_cust) references customer(customer_id),
Issued_book_name varchar(20),
issue_date datetime,
isbn_book int,
foreign key (isbn_book) references books(isbn));
select*from  issuestatus;
insert into issuestatus values(5001,501,'Araachar','2015-12-28',1245),
(5002,502,'Randamoozham','2023-10-30',1284),
(5003,503,'Mathilukal','2024-01-09',1352),
(5004,504,'Kaalam','2012-12-28',1200);

create table returnStatus (
Return_Id  int PRIMARY KEY  ,
Return_cust  int,
Return_book_name varchar(20), 
Return_date  datetime,
Isbn_book2 int,
 FOREIGN KEY (isbn_book2) references books(isbn) );
 
 insert into returnstatus values (6001,5001,'Araachar','2016-01-01',1245),
 (6002,5002,'Randamoozham','2023-11-01',1284),
 (6003,5003,'Mathilukal','2024-02-01',1352),
 (6004,5004,'Kaalam','2013-01-01',1200);

select*from returnstatus;

select book_title,category,rental_price
from books 
where status='yes';
select emp_name,salary 
from employee 
order by salary desc;
select I.Issued_book_name as 'book_name',C.customer_name 
from issuestatus I 
left join customer C on I.issued_cust=C.customer_id;
select category, count(isbn) as count 
from books 
group by category;
select emp_name,position 
from employee
where salary >50000;
select Customer_name 
from customer
where reg_date < '2022-01-01'
and customer_id not in (select issued_cust from issuestatus);
select B.branch_no,count(*) as 'total_employee' 
from branch B
left join  employee E on B.branch_no=E.branch_no
group by B.branch_no;
select branch_no,count(*) as 'total_employee' 
from branch 
group by branch_no;
select customer_name  
from IssueStatus I
inner join customer C on I.Issued_cust =C.customer_id 
where i.issue_date between '2023-06-01' and '2023-06-30';
select book_title 
from books
where category='History';
select B.branch_no,count(*) as 'count_of_employees'
from branch B
left join employee E
on B.branch_no = E.branch_no
group by B.branch_no
having count(*) > 5;
select E.emp_name, E.branch_no,B.branch_address 
from employee E
inner join branch B on E.Branch_no =B.Branch_no 
where  E.position ='manager';
select c.customer_name 
from customer C
inner join issuestatus I on c.Customer_Id =I.Issued_cust 
inner join books B on  I.Isbn_book = B.ISBN 
where B.Rental_Price > 25;

create table restaurant (name varchar(50), phno int, address varchar(50), PRIMARY KEY (phno));
	insert into restaurant values ('Gazebo',0556227426,'Business Bay, Dubai');
	insert into restaurant values ('Al Madina',0551111111,'Academic City, Dubai');
	insert into restaurant values ('Iris Dubai',0552222222,'Internet City, Dubai');
	insert into restaurant values ('The Gallery',0553333333,'Internet City, Dubai');
	insert into restaurant values ('Chillis',0554444444,'Business Bay, Dubai');

select * from restaurant;


create table manager (managerID varchar(50), name varchar(50), phno int, PRIMARY KEY (managerID), FOREIGN KEY (phno) REFERENCES restaurant(phno));
	insert into manager values (001, 'Parth Poply', 0556227426);
	insert into manager values (002, 'Sujith Sizon', 0551111111);
	insert into manager values (003, 'Somil Mathur', 0552222222);
	insert into manager values (004, 'Jaskanwar Singh', 0553333333);
	insert into manager values (005, 'Tushar Agarwal', 0554444444);

select * from manager;






create table customer (name varchar(50), phno int, address varchar(50), customerID int, PRIMARY KEY (customerID));
	insert into customer values ('Ramu Singh',0556227421,'Business Bay, Dubai', 001);
	insert into customer values ('Zachery Larson',0551111112,'Academic City, Dubai', 002);
	insert into customer values ('Iris West',0552222223,'Internet City, Dubai', 003);
	insert into customer values ('Barry Singh',0553333334,'Internet City, Dubai', 004);
	insert into customer values ('Ayush Chamoli',0554444441,'Business Bay, Dubai', 005);
	insert into customer values ('Piyush',0554444442,'Business Bay, Dubai', 006);
	insert into customer values ('Rahul',0554444443,'Business Bay, Dubai', 007);
	insert into customer values ('Anand',0554444444,'Business Bay, Dubai', 008);

select * from customer;




create table bill (orderDetail varchar(50), billNo int, amount int, customerID int, PRIMARY KEY (billNo), FOREIGN KEY (customerID) REFERENCES bill(customerID));
	insert into bill values ('Hummus and Pita', 0001, 20, 001);
	insert into bill values ('Shish Tawook and Hummus', 0002, 30, 002);
	insert into bill values ('Foul meddamas', 0003, 25, 003);
	insert into bill values ('Baba ghanoush', 0004, 20, 004);
	insert into bill values ('Hummus and Pita', 0007, 20, 007);
	insert into bill values ('Falafel', 0005, 15, 005);
	insert into bill values ('Cheese Manakisk', 0006, 20, 006);
	insert into bill values ('Hummus and Pita', 0008, 20, 008);
	
select * from bill;



create table cashier (billNo int, name varchar(50), transactionID int, PRIMARY KEY (transactionID), FOREIGN KEY (billNo) REFERENCES bill(billNo));
	insert into cashier values (0006,'Abdella Rehman', 00001);
	insert into cashier values (0002,'Ramu Singh', 00002);
	insert into cashier values (0003,'Ramu Singh', 00003);
	insert into cashier values (0001,'Abdella Rehman', 00004);
	insert into cashier values (0004,'Ramu Singh', 00005);
	insert into cashier values (0005,'Abdella Rehman', 00006);
	insert into cashier values (0007,'Ramu Singh', 00007);
	insert into cashier values (0008,'Ramu Singh', 00008);

select * from cashier;	






create table order2 (noOfItems int, orderNo int, customerID int, PRIMARY KEY (orderNo), FOREIGN KEY (customerID) REFERENCES customer(customerID));
	insert into order2 values (1, 101, 001);
	insert into order2 values (1, 102, 002);
	insert into order2 values (2, 103, 003);
	insert into order2 values (1, 104, 004);
	insert into order2 values (1, 105, 005);
	insert into order2 values (3, 106, 006);
	insert into order2 values (1, 107, 007);
	insert into order2 values (2, 108, 008);

select * from order2;	



create table item (itemNo int, orderNo int, amount int, quantity varchar(50), description varchar(50), PRIMARY KEY (itemNo), FOREIGN KEY (orderNo) REFERENCES order2(orderNo), FOREIGN KEY (description) REFERENCES bill(orderDetail));
	insert into item values (201, 101, 10,'1 Hummus', 'Hummus and Pita');
	insert into item values (202, 101, 10,'1 Pita', 'Hummus and Pita');
	insert into item values (203, 107, 10,'1 Hummus', 'Hummus and Pita');
	insert into item values (204, 107, 10,'1 Pita', 'Hummus and Pita');
	insert into item values (205, 102, 20,'1 Shish Tawook', 'Shish Tawook and Hummus');
	insert into item values (206, 102, 10,'1 Hummus', 'Shish Tawook and Hummus');
	insert into item values (207, 103, 25,'1 Foul meddamas', 'Foul meddamas');
	insert into item values (208, 104, 20,'1 Baba ghanoush', 'Baba ghanoush');
	insert into item values (209, 105, 15,'1 Falafel', 'Falafel');
	insert into item values (210, 106, 20,'1 Cheese Manakisk', 'Cheese Manakisk');
	insert into item values (211, 108, 10,'1 Hummus', 'Hummus');

select * from item;	







create table chef (name varchar(50), chefID varchar(50), PRIMARY KEY (chefID));
select * from chef;	


create table waiter (name varchar(50), ID varchar(50), PRIMARY KEY (ID));
select * from waiter;	






update table totalCashier set totalAmount = 115 where name = 'Ramu Singh'; 








create table noOfCustomersInArea (areaName varchar(50), totalNumber int, FOREIGN KEY (areaName) REFERENCES customer(address));
	insert into customer values ('Business Bay, Dubai', 5);
	insert into customer values ('Academic City, Dubai', 1);
	insert into customer values ('Internet City, Dubai', 2);

select * from noOfCustomersInArea;




create table totalCashier (name varchar(50), totalAmount int);
	insert into totalCashier values('Abdella Rehman', 55);
	insert into totalCashier values('Ramu Singh', 115);

select * from totalCashier;


delimiter |
create trigger update_total_cashed
	after insert on cashier
	for each row
	begin
		if new.billNo is not null then
			update totalCashier
			set totalAmount = totalAmount + (Select b.amount from bill b where b.billNo = new.billNo)
			where name = new.name;
		end if;
end |
delimiter ;





delimiter |
create trigger update_restaurant_no
	after update on manager
	for each row
	begin
		if new.phno is not null then
			update restaurant
			set phno = new.phno
			where phno = new.phno;
		end if;
end |
delimiter ;



delimiter //
create procedure giveDiscount (in inp double)
	begin
		declare done int default 0;
		declare bid int;
		declare amnt int;
		declare billrec cursor for select billNo, amount from bill;
		declare continue handler for not found set done = 1;
		open billrec;
		repeat
			fetch billrec into bid, amnt;
			update bill
				set amount = amount - inp
				where billNo = bid;
		until done
		end repeat;
end //

##Updates total cashedIn amount by param1 in totalCashier table
delimiter //
create procedure updateTotalCashedIn (in param1 varchar(50))
	begin
		update totalCashier
			set totalAmount = (select sum(b.amount) from bill b 
								where b.billNo in (select c.billNo from cashier c where c.name = param1))
			where name = param1;
end; //

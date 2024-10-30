create database bookstoredatabasesystem

CREATE TABLE BookTable (
    book_id INT PRIMARY KEY NOT NULL,
    tittle VARCHAR(100) NOT NULL,
    isnb INT NOT NULL,
    language_id INT NOT NULL,
    number_pages INT NOT NULL,
    publications_date DATE NOT NULL,
    publisher_id INT NOT NULL,
    CONSTRAINT fk_publisher_id FOREIGN KEY (publisher_id) REFERENCES PUBLISHER(publisher_id)

)

SELECT * FROM BookTable

CREATE TABLE PUBLISHER (
	PUBLISHER_ID INT PRIMARY KEY NOT NULL,
	PUBLISHER_NAME VARCHAR(100) NOT NULL,
)

select * from PUBLISHER

create table BookAutors  (
	book_id int not null
	CONSTRAINt fk_book_id foreign key(book_id) REFERENCES booktable(book_id),
	author_id  int not null
	constraint fk_author_id foreign key(author_id) references author(author_id)

)

create table author (
	author_id int primary key not null,
	author_name varchar(100) not null
)


create table booklanguage (
	language_id int primary key not null,
	language_code varchar(100) not null,
	language_name varchar(100) not null
)


create table customer (
	customer_id int primary key not null,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email varchar(100) not null
)

create table country (
	country_id int primary key not null,
	country_name varchar(100) not null
)

create table address (
	address_id int primary key not null,
	street_number int not null,
	street_name varchar(100) not null,
	city varchar(100) not null,
	country_id int not null
	constraint fk_country_id foreign key (country_id)  references country(country_Id)

)

create table addressStatus (
	status_id int primary key not null,
	address_status varchar(100) not null
)

create table customer_address (
	customer_id int not null,
	constraint fk_customer_id foreign key(customer_Id) references customer(customer_id),
	address_id int not null,
	constraint fk_address_id foreign key(address_id) references address(address_id)
)

alter table customer_address
add status_id int constraint fk_status_id foreign key(status_id) references addressStatus(status_id)

select * from customer_address

create table orderStatus (
	status_id int primary key not null,
	status_value varchar(200) not null,
)

create table shippingMethod (
	Method_id int primary key not null,
	method_name varchar(150) not null,
	cost decimal not null
)

create table custorder (
	order_id int primary key not null,
	order_date datetime not null,
	customer_id int not null,
	constraint fk_customer_id2 foreign key(customer_id) references customer(customer_id),
	shipping_method_id int not null,
	constraint fk_shipping_method_id foreign key(shipping_method_id) references shippingmethod(method_id),
	dest_address_id int not null,
	constraint fk_dest_address_id foreign key(dest_address_id) references address(address_id)

)





create table orderLine (
	line_id int primary key not null,
	order_id int not null,
	constraint fk_order_id foreign key (order_id) references custorder(order_id),
	book_id int not null,
	constraint fk_book_id2 foreign key (book_id) references booktable(book_Id),
	price decimal not null,
)

create table orderHistory (
	history_id int primary key not null,
	order_id int not null,
	constraint fk_order_id2 foreign key (order_id) references custorder(order_id),
	status_id int not null,
	constraint fk_status_id2 foreign key(status_id) references orderstatus(status_id),
	status_date date not null
)

--james andreson bought the night circus on 01/01/2019
-- michael carter bought whispers in the wind on 01/01/2020
-- ethan davis bought the last ember on 08/15/2019
-- noah parker bought beneath the silver 07/01/2021
-- emily johnson bought shadow of the lost city on 05/19/2020
-- madison brooks bought journey to clarity on 06/10/2021
-- grace taylor bought the power of simple on 02/05/2020
-- olivia mitchell bought voices of change on 04/03/2019
-- emily andreson bought fragments of fate on 03/01/2021
-- benjamin thompson bought the silent on 11/01/2020


-- the night circus published by harper collins 
-- whispers in the wind published by scholastic
-- the last amber published by w.w norton and company
-- beneath the silver published by simon and schuster
-- shadow of the city published by workman publishing company
-- journey to clarity published by crown publishing company
-- voices of change published by abrams books
-- fragments of fate published by tor books
-- the silent published by blackstone publishing company
-- the power of simple published by grove atlantic

select * from PUBLISHER

insert into PUBLISHER values (1,'harper collins '),(2,'scholastic'),(3,'w.w norton and company'),(4,'simon and schuster'),(5,'workman publishing company'),
(6,'crown publishing company'),(7,'abrams books'),(8,'tor books'),(9,'blackstone publishing company'),(10,'grove atlantic')

select * from booklanguage

insert into booklanguage values (1,'en','english'),(2,'hi','hindi'),(3,'ru','russian'),(4,'ja','japanese'),(5,'fr','french'),(6,'it','italian'),(7,'ko','korean'),(8,'es','spanish'),
(9,'de','german'),(10,'tr','turkish')


select * from PUBLISHER
select * from booklanguage
select * from BookTable

insert into BookTable values (1,'the night circus','0001',1,475,'1969-01-01',1),(2,'whispers in the wind','0002',1,350,'1999-01-01',2),(3,'the last ember','0003',1,650,'1989-08-15',3),
(4,'beneath the silver','0004',1,750,'1988-06-16',4),(5,'shadow of the city','0005',1,300,'1978-03-07',5),(6,'journey','0006',1,569,'1989-07-09',6),(7,'voices of change','0007',1,650,'2000-05-06',7),
(8,'fragments of fate','0008',1,800,'2003-08-04',8),(9,'the silent','0009',1,888,'1997-10-10',9),(10,'the power of simple','0010',1,550,'2007-05-03',10)


select * from author

insert into author values (1,'jane austen'),(2,'j.k. rowling'),(3,'mark twain'),(4,'george orwell'),(5,'toni morrison'),(6,'leo tolstory'),(7,'isabel allende'),(8,'chinua achebe'),(9,'james baldwin'),(10,'stephen king')

-- the night circus published  by harper collins, j.k. rowling 
-- whispers in the wind published by scholastic, george orwell
-- the last amber published by w.w norton and company, jane austen
-- beneath the silver published by simon and schuster, toni morrison
-- shadow of the city published by workman publishing company, isable allende
-- journey to clarity published by crown publishing company, stephen king
-- voices of change published by abrams books, chinua achebe
-- fragments of fate published by tor books, james baldwin 
-- the silent published by blackstone publishing company, leo tolstory
-- the power of simple published by grove atlantic, mark twain
 
 select * from BookTable
 select * from author
 select * from BookAutors

 insert into BookAutors values (1,2),(2,4),(3,1),(4,5),(5,7),(6,10),(7,8),(8,9),(9,6),(10,3)

 select * from customer

 insert into customer values (1,'james','andreson','james123@gmail.com'),(2,'michael','carter','mikeo1@gmail.com'),(3,'ethan','davis','davisethan.@gmail.com'),(4,'noah','parker','parkernoah11@gmail.com'),(5,'emily','johnson','amyjohn@gmail.com'),
(6,'madison','brooks','brooksmad2234@gmail.com'),(7,'grace','taylor','taylorgrace@gmail.com'),(8,'olivia','mitchell','mitchellolivia@gmail.com'),(9,'emily','andreson','emilylove10@gmail.com'),(10,'benjamin','thompson','benjamin.T@gmail.com')

insert into country values (1,'usa'),(2,'australia'),(3,'brazil'),(4,'china'),(5,'germany'),(6,'india'),(7,'japan'),(8,'ethiopia'),(9,'united arab emirates'),(10,'turkey')
select * from country

select * from address

insert into address values (1,14615,'portland', 'oregon',1), (2,881,'3rd st washington','district of columbia',1),(3,123,'bussiness road','sydney nsw 2000',2),(4,01234,'avenida paulista','bela vista',3),(5,501,'zhongshan','nanjing',4),
(6,10422,'ankeny st','clakamas',1),(7,122,'mozambique st','addis abeba',8),(9,97233,'plantation oaks','florida',1),(10,20783,'phoebe ln','maryland',1)
insert into address values (11,8825,'pine brunch','seattle',1)
insert into address values (12,27823,'7th parker road','silverspring',1),(13,10108,'takoma park','columbia pike',1)

insert into addressStatus values (1,'active'),(2,'inactive')


select * from customer
select * from address
select * from addressStatus
select * from customer_address

insert into customer_address values (1,2,1),(1,1,2),(2,4,1),(3,9,1),(4,3,1),(5,10,1),(6,4,1),(7,10,1),(7,6,2),(8,11,1),(9,12,1),(10,13,1)

select first_name,last_name,street_number,email street_name, city, address_status from customer
inner join customer_address on customer.customer_id = customer_address.customer_id
inner join address on customer_address.address_id = address.address_id
inner join addressStatus on addressStatus.status_id = customer_address.status_id

select * from shippingMethod
insert into shippingMethod values (001,'standard shipping',9.99),(002,'expedited shipping',19.99),(003,'overnight shipping',24.99),(004,'international shipping',36.00),(005,'free shipping(over $50)',0)

select * from address
select * from shippingMethod
select * from customer_address
select * from customer
select * from custorder

insert into custorder values (1,'2019-01-01',1,3,1),(2,'2020-01-01',2,5,4),(3,'2019-08-15',3,3,9),(4,'2021-07-01',4,1,3),(5,'2020-05-19',5,1,10),(6,'2021-06-10',6,2,4),(7,'2020-05-02',7,1,10),(8,'2019-04-03',8,5,11),
(9,'2021-01-03',9,4,12),(10,'2020-11-01',10,5,13)


select * from BookTable
select * from custorder
select * from orderLine

insert into orderLine values (1,1,1,165),(2,1,2,99),(3,2,3,280),(4,3,4,289),(5,4,5,350),(6,5,6,750),(7,6,7,286),(8,7,8,288),(9,8,9,350),(10,9,10,550)

insert into orderStatus values (1,'shipped'),(2,'delivered'),(3,'cancelled')

select * from orderStatus
select * from orderHistory
select * from custorder

insert  into orderHistory values (1,1,1,'2019-01-15'),(2,2,2,'2020-01-15'),(3,3,1,'2019-08-25'),(4,4,2,'2021-07-10'),(5,5,2,'2020-05-30'),(6,6,1,'2021-06-11'),
(7,7,3,'2020-05-10'),(8,8,3,'2019-04-09'),(9,9,1,'2021-01-13'),(10,10,2,'2020-11-09')
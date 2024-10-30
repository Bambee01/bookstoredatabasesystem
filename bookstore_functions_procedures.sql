CREATE PROCEDURE dbo.insertBookDataWithDuplicateCheck
  @bookTitle varchar(255), 
  @pages int, 
  @publicationDate date, 
  @publisherName varchar(255), 
  @authorName varchar(255)
AS
BEGIN
  DECLARE @book_id int;
  DECLARE @publisher_id int;
  DECLARE @author_id int;

  -- Check if Publisher already exist 
  SELECT @publisher_id = PUBLISHER_ID 
  FROM PUBLISHER 
  WHERE PUBLISHER_NAME = @publisherName;

  IF @publisher_id IS NULL
  BEGIN
      select @publisher_id = (max(PUBLISHER_ID) + 1) from PUBLISHER;
    insert into PUBLISHER values (@publisher_id, @publisherName);
      RETURN;
  END

  select @book_id = (max(book_id) + 1)  from BookTable;
  insert into BookTable values (@book_id, @bookTitle, (199 + @book_id), 1, @pages, @publicationDate, @publisher_id);

  -- Check if Author exist
  select @author_id = author_id from author where author_name = @authorName

  if @author_id is null
  begin 
  select @author_id = (max(author_id) + 1) from author;
  insert into author values (@author_id, @authorName);
  
  end

  insert into BookAutors values (@book_id, @author_id)
  
end;

create procedure dbo.addNewCustomer
  @first_name varchar(150), @last_Name varchar(150), @email varchar(255),@street_number varchar(255),@street_name varchar(255),
   @city varchar(255),@country_name varchar(255)
AS
begin
  declare @customer_id int;
  declare @address_id int;
  declare @country_id int;

  select @customer_id = (max(customer_id) + 1) from customer
  select @address_id = (max(address_id) + 1) from address
  select @country_id = country_id from country where country_name = @country_name

  if @country_id is null
  begin 
    select @country_id = (max(country_id) + 1) from country
    insert into country values (@country_id, @country_name)
  end

  insert into customer values (@customer_id, @first_name, @last_Name, @email)
  insert into address values (@address_id, @street_number, @street_name, @city, @country_id)
  insert into customer_address values (@customer_id, @address_id, 1)
end;


create procedure dbo.addNewAddressForOldCustomer
  @customer_id int, @street_number varchar(15), @street_name varchar(255), @city varchar(255), @country_name varchar(255)
AS
Begin
  declare @address_id int;
  declare @country_id int;
  declare @c_id int;    

  select @c_id = customer_id from customer where customer_id = @customer_id

  if @c_id is not null
  begin 
    select @country_id = country_id from country where country_name = @country_name
    if @country_id is null
    begin
      select @country_id = (max(country_id) + 1) from country
      insert into country values (@country_id, @country_name)
    end
  
    select @address_id = (max(address_id) + 1) from address

    insert into address values(@address_id, @street_number, @street_name, @city, @country_id)

    update customer_address
    set status_id = 2
    where customer_id = @customer_id

    insert into customer_address values (@customer_id, @address_id, 1)
  end

  if @c_id is null
  begin
    print('Error: customer doesnt exist');
  end
  
end;








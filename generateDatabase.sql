# Sagnik Mukherjee
# July 25, 2021
### DROP database IF EXISTS project20; (CAREFUL!) ###

CREATE database IF NOT EXISTS database20;
USE database20;

CREATE TABLE UserAccount(
username varchar(40),
pass varchar(40) NOT NULL,
phone varchar(13),
addressLine1 varchar(150),
addressLine2 varchar(150),
county varchar(40),
state char(2),
zipCode char(5),
firstName varchar(40),
middleName varchar(40),
lastName varchar(40),
age int,
birthday date,
isActive boolean,
lastSeen datetime,
primary key (username)
);

CREATE TABLE Administrator(
email varchar(40),
username varchar(40),
pass varchar(40) NOT NULL,
primary key (email, username),
foreign key (username) references UserAccount (username)
);

CREATE TABLE CustomerRep(
email varchar(40),
username varchar(40),
pass varchar(40) NOT NULL,
primary key (email, username),
foreign key (username) references UserAccount (username)
);

CREATE TABLE EndUser(
email varchar(40),
username varchar(40),
primary key (email, username),
foreign key (username) references UserAccount (username)
);

CREATE TABLE Buyer(
email varchar(40),
username varchar(40),
pass varchar(40) NOT NULL,
primary key (email, username),
foreign key (email, username) references EndUser (email, username)
);

CREATE TABLE Seller(
email varchar(40),
username varchar(40),
pass varchar(40) NOT NULL,
primary key (email, username),
foreign key (email, username) references EndUser (email, username)
);

CREATE TABLE Asks(
CR_email varchar(40),
CR_username varchar(40),
EU_email varchar(40),
EU_username varchar(40),
qID int,
question varchar(250),
answer text,
primary key (CR_email, EU_email),
foreign key (CR_email, CR_username) references CustomerRep (email, username),
foreign key (EU_email, EU_username) references EndUser (email, username)
);

CREATE TABLE Product(
itemNumber int auto_increment,
sellerAccount varchar(40),
damageCondition varchar(40),
color varchar(40),
category varchar(40),
productDescription varchar(40),
weight float,
brand varchar(40),
isSold boolean,
primary key (itemNumber),
foreign key (sellerAccount) references Seller (email)
    on delete cascade
);

CREATE TABLE Type1(
itemNumber int auto_increment,
attributeName varchar(40),
primary key (itemNumber, attributeName),
foreign key (itemNumber) references Product (itemNumber)
    on delete cascade
);

CREATE TABLE Type2(
itemNumber int auto_increment,
attributeName varchar(40),
primary key (itemNumber, attributeName),
foreign key (itemNumber) references Product (itemNumber)
    on delete cascade
);

CREATE TABLE Type3(
itemNumber int auto_increment,
attributeName varchar(40),
primary key (itemNumber, attributeName),
foreign key (itemNumber) references Product (itemNumber)
    on delete cascade
);

CREATE TABLE Bid(
bidNum int,
bidDate date NOT NULL,
bidPrice float NOT NULL,
itemNumber int NOT NULL,
email varchar(40) NOT NULL,
primary key (bidNum),
foreign key (email) references Buyer (email),
foreign key (itemNumber) references Product (itemNumber)
);

CREATE TABLE AutoBidder(
bidNum int,
email varchar(40),
itemNumber int,
upperLimit float NOT NULL,
primary key (bidNum, itemNumber, email),
foreign key (bidNum) references Bid (bidNum),
foreign key (itemNumber) references Product (itemNumber)
	on delete cascade,
foreign key (email) references Buyer (email)
	on delete cascade
    on update cascade
);

CREATE TABLE Auction(
auctionNumber int,
winner varchar(40),
previousBid float,
currentPrice float,
initialPrice float,
reservePrice float,
timeRemaining datetime,
startDate datetime,
endDate datetime,
primary key (auctionNumber),
foreign key (winner) references Buyer (email)
);

CREATE TABLE SalesReport(
email varchar(40),
username varchar(40),
primary key (email, username),
foreign key (email) references Administrator (email),
foreign key (username) references UserAccount (username)
);

CREATE TABLE UserHistory(
email varchar(40),
username varchar(40),
primary key (email, username),
foreign key (email, username) references EndUser (email, username)
);

CREATE TABLE PurchaseHistory(
email varchar(40),
username varchar(40),
primary key (email, username),
foreign key (email, username) references UserHistory (email, username)
);

CREATE TABLE SaleHistory(
email varchar(40),
username varchar(40),
primary key (email, username),
foreign key (email, username) references UserHistory (email, username)
);

CREATE TABLE ProductAlert(
alertID varchar(40),
email varchar(40),
brand varchar(40),
size varchar(40),
category varchar(40),
color varchar(40),
primary key (alertID),
foreign key (email) references EndUser (email)
);

INSERT INTO UserAccount (username, pass) 
    VALUES ('root', 'UN5AW!]x9K{[bP');
    
UPDATE Administrator, UserAccount
    SET Administrator.username = UserAccount.username
    AND Administrator.pass = UserAccount.pass;
 
 INSERT INTO Administrator (email, username, pass) 
    VALUES ('root@root.com', 'root', 'UN5AW!]x9K{[bP');
    
select * from Administrator;
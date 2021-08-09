# Initial database creation.
DROP DATABASE IF EXISTS database20;
CREATE DATABASE IF NOT EXISTS database20;
USE database20;

/*  
    UserAccount table, accessLevel represents all three types
    of possible BuyMe accounts (End User, Customer Rep, Admin).
    Using the BINARY function forces a case-sensitive
    comparison when returning result set.
*/
DROP TABLE IF EXISTS UserAccount;
CREATE TABLE UserAccount(
	username varchar(40),
    password varchar(100) BINARY NOT NULL,
    email varchar(100) NOT NULL,
    firstName varchar(40) BINARY NOT NULL,
    lastName varchar(40) BINARY NOT NULL,
    address varchar(100) NOT NULL,
    isActive boolean NOT NULL,
    accessLevel ENUM('END_USER', 'CUSTOMER_REP', 'ADMIN') NOT NULL,
    primary key(username)
);

# Local session var, ignore referential constraint changes.
SET foreign_key_checks = 0;

/*  
    Product table.
    Using decimal() is preferable to float() for this database,
    as decimal allows for exact value storage.
    Using auto_increment lets the table increment by 1 
    for each new record, starting from 1. 
*/
DROP TABLE IF EXISTS Product;
CREATE TABLE Product(
	productId int AUTO_INCREMENT,
	category varchar(40) NOT NULL,
	brand varchar(40),
	productDescription varchar(40),
    damageCondition ENUM('Poor', 'Fair', 'Like New', 'Original Condition', 'N\A') NOT NULL,
    color varchar(40),
	sellerAccount varchar(40) NOT NULL,
    reservePrice decimal(10, 2) NOT NULL,
	price decimal(10, 2) NOT NULL,
	isSold boolean,
    startDate datetime,
    endDate datetime,
	primary key(productId, sellerAccount)
);

# Check referential constraints again.
SET foreign_key_checks = 1;

/*
    Bid table.
    Each record will represent an auction, to avoid redundancy.
*/
DROP TABLE IF EXISTS Bid;
CREATE TABLE Bid(
	productId int,
	buyerAccount varchar(40),
	currentBid decimal(10, 2),
    datePlaced datetime,
	foreign key (buyerAccount) REFERENCES UserAccount(username)
		ON DELETE CASCADE,
	foreign key (productId) REFERENCES Product(productId)
		ON DELETE CASCADE,
	primary key(productId, currentBid)
);

/*
    BuyingHistory table.
    History of items bought per account.
*/
DROP TABLE IF EXISTS BuyingHistory;
CREATE TABLE BuyingHistory(
	productId int,
	buyerAccount varchar(40),
	price decimal(10, 2) NOT NULL,
	purchaseDate datetime,
	foreign key (buyerAccount) REFERENCES UserAccount(username)
		ON DELETE CASCADE,
	primary key(productId)
);

/*
    SellingHistory table.
    History of items sold per account.
*/
DROP TABLE IF EXISTS SellingHistory;
CREATE TABLE SellingHistory(
	productId int,
	sellerAccount varchar(40),
	price decimal(10, 2) NOT NULL,
	saleDate datetime,
	foreign key (sellerAccount) REFERENCES UserAccount(username)
		ON DELETE CASCADE,
	primary key(productId)
);

/*
    BidHistory table.
    History of bids made per product.
*/
DROP TABLE IF EXISTS BidHistory;
CREATE TABLE BidHistory(
    productId int,
    buyerAccount varchar(40),
	bidPrice decimal(10, 2),
    bidDate datetime,
    foreign key (productId) REFERENCES Product(productId)
		ON DELETE CASCADE,
    primary key(bidPrice, productId)
);

/*
    Alerts table.
    Notifies user of item availability for a set alert.
*/
DROP TABLE IF EXISTS Alerts;
CREATE TABLE Alerts(
	messageId int AUTO_INCREMENT,
    userAcc varchar(40) NOT NULL,
    message varchar(250) NOT NULL,
    seen boolean DEFAULT FALSE,
    foreign key (userAcc) REFERENCES UserAccount(username)
		ON DELETE CASCADE,
    primary key(messageId)
);

/*
    Questions table.
    Stores questions for Customer Reps.
*/
DROP TABLE IF EXISTS Questions;
CREATE TABLE Questions(
	questionId int AUTO_INCREMENT,
    userAcc varchar(40),
    question varchar(250) NOT NULL,
    answer varchar(250) DEFAULT NULL,
    foreign key (userAcc) REFERENCES UserAccount(username)
		ON DELETE CASCADE,
    primary key(questionId)
);

/*
    AlertsList table.
    Tracks wished-for items.
*/
DROP TABLE IF EXISTS AlertsList;
CREATE TABLE AlertsList(
	userAcc varchar(40),
    category varchar(40) NOT NULL,
	brand varchar(25) NOT NULL,
	model varchar(40) NOT NULL,
	damageCondition varchar(40) NOT NULL,
    size int NOT NULL,
    color varchar(20) NOT NULL,
    maxPrice decimal(10, 2) NOT NULL,
    foreign key (userAcc) REFERENCES UserAccount(username)
		ON DELETE CASCADE,
    primary key(userAcc, category, brand, model, damageCondition, size, color)
);

/*
    AutoBidder table.
    Stores auto-bidder functionality per user.
*/
DROP TABLE IF EXISTS AutoBidder;
CREATE TABLE AutoBidder(
	userAcc varchar(40),
    productId int,
    maxPrice decimal(10, 2) NOT NULL,
    foreign key (userAcc) REFERENCES UserAccount(username)
		ON DELETE CASCADE,
	foreign key (productId) REFERENCES Product(productId)
		ON DELETE CASCADE,
	primary key(userAcc, productId)
);

INSERT INTO UserAccount VALUES 
    ('root', 'UN5AW!]x9K{[bP', 'admin@buyme.com', 'Admin', 'Istrator', 
    '57 US Highway 1, New Brunswick, NJ 08901', true, 'ADMIN'),
    ('rep115932', 'HW)<;46jE<E*g,#', 'rep115932@buyme.com', 'John', 'Doe',
    '100 Ryders Ln, Milltown, NJ 08850', true, 'CUSTOMER_REP');

# Use TRIGGERs to have a Procedure that fires upon certain event(s) occuring.
/* 
    Rejects invalid Products, determines if they match any existing Product Alerts.
    Use aliases to avoid ambiguity between current table and NEW table.
*/
DROP TRIGGER IF EXISTS alertListener;
DELIMITER !!!
	CREATE TRIGGER alertListener BEFORE INSERT ON Product FOR EACH ROW
	BEGIN
        # Check for products matching those described in user-defined Product Alerts, if any.
		CREATE TEMPORARY TABLE Temp
        SELECT * FROM AlertsList
            WHERE category = NEW.category AND brand = NEW.brand 
                AND damageCondition = NEW.damageCondition AND color = NEW.color;
        
        # Validation checks.
		IF NEW.price < 0
		THEN
            BEGIN
                SIGNAL SQLSTATE '45000' #generic user-defined error code
                SET MESSAGE_TEXT = 'ERROR - Attempted to insert negatively priced product.';
            END;
        ELSEIF (EXISTS (
            # Look for duplicate ids in current Product table, if any.
			SELECT currentProduct.productId
			FROM Product currentProduct
			WHERE currentProduct.productId = NEW.productId)
        ) THEN
            BEGIN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'ERROR - Attempted to insert product with duplicate productID.';
            END;
		ELSEIF (NEW.startDate > NEW.endDate)
		THEN
			BEGIN
				SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = 'ERROR - Auction endDate precedes startDate.';
            END;
		END IF;
        
        # Product described in user-defined alert has been listed if Temp is non-empty.
		IF ((SELECT COUNT(*) FROM Temp) <> 0) # Number of records in Temp is NOT EQUAL TO 0.
        THEN
			BEGIN
				INSERT INTO Alerts (user, message)
                SELECT user, 'ALERT - A product in your AlertsList has been listed.' FROM AlertsList
                WHERE category = NEW.category AND brand = NEW.brand 
                    AND damageCondition = NEW.damageCondition AND color = NEW.color;
            END;
		END IF;
        DROP TEMPORARY TABLE Temp;
	END; !!!
DELIMITER ;

# If a product is unlisted, trigger a deletion of the corresponding auto-bidder.
DROP TRIGGER IF EXISTS autoBidDeleteOnProductUnlist;
DELIMITER !!!
	CREATE TRIGGER autoBidDeleteOnProductUnlist AFTER DELETE ON Product FOR EACH ROW
    BEGIN
		DELETE FROM AutoBidder WHERE productId = OLD.productId;
    END; !!!
DELIMITER ;

# Upon item being sold in auction, move to buying/selling histories, remove from Bid table.
DROP TRIGGER IF EXISTS itemSoldHandler;
DELIMITER !!!
	CREATE TRIGGER itemSoldHandler AFTER UPDATE ON Product FOR EACH ROW 
    BEGIN
		IF NEW.isSold = true
		THEN
			BEGIN
				# Write product into BuyingHistory.
				INSERT INTO BuyingHistory (productId, buyerAccount, price, purchaseDate)
                    (SELECT b.productId, b.buyerAccount, b.currentBid, NOW() FROM Bid b
                    WHERE b.productId = NEW.productId);
				
                # Write product into SellingHistory.
				INSERT INTO SellingHistory (productId, sellerAccount, price, saleDate)
                    (SELECT p.productId, p.sellerAccount, p.price, NOW() FROM Product p
                    WHERE p.productId = NEW.productId);
                
                # Create Alert for the sellerAccount.
                INSERT INTO Alerts (user, message)
                    (SELECT p.sellerAccount, "ALERT - One of your items was sold in-auction." FROM Product p
                    WHERE p.productId = NEW.productId);
                
                # Create Alert for the buyerAccount.
                INSERT INTO Alerts (user, message)
                    (SELECT b.buyer, "ALERT - Congratulations, you won an auction!" FROM Bid b
                    WHERE b.productId = NEW.productId);
				
                # Remove Bid for current productId.
				DELETE FROM Bid WHERE productId = NEW.productId;
			END;
		END IF;
        
        # Upon product update, if current bid > upper limit on a given autoBidder, remove that entry.
        IF ((SELECT maxPrice FROM AutoBidder
            WHERE productId = NEW.productId) <= NEW.price)
        THEN
			BEGIN
				DELETE FROM AutoBidder WHERE productId = NEW.productId;
            END;
		END IF;
	END; !!!
DELIMITER ;

# Supersede the previous bid with a larger one (must be a greater amount).
DROP TRIGGER IF EXISTS bidUpdater;
DELIMITER !!!
	CREATE TRIGGER bidUpdater AFTER UPDATE ON Bid FOR EACH ROW
    BEGIN
		IF (NEW.currentBid > OLD.currentBid)
		THEN 
			BEGIN
				UPDATE Product SET price = NEW.currentBid
                    WHERE NEW.productId = productId;
			END;
		ELSEIF (NEW.currentBid <= OLD.currentBid)
		THEN
			BEGIN
				SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'ERROR - New bid amount must be greater than the current one.';
			END;
		END IF;
	END; !!!
DELIMITER ;

# Similar to priceUpdater, but for a newly listed item that has no current bids yet.
# The first bid should be greater than the starting price for the product listing.
DROP TRIGGER IF EXISTS firstBidUpdater;
DELIMITER !!!
	CREATE TRIGGER firstBidUpdater BEFORE INSERT ON Bid FOR EACH ROW
    BEGIN
		IF (NEW.currentBid <= (SELECT p.price FROM Product p WHERE p.productId = NEW.productId))
        THEN 
			BEGIN
				SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = 'ERROR - New bid amount must be greater than default price.';
			END;
		ELSE #IF (NEW.currentBid > (SELECT p.price FROM Product p WHERE p.productId = NEW.productId))THEN
			BEGIN
				UPDATE Product SET price = NEW.currentBid WHERE NEW.productId = productId;
                INSERT INTO BidHistory VALUES(NEW.productId, NEW.buyerAccount, NEW.currentBid, NOW());
            END;
		END IF;
	END; !!!
DELIMITER ;

# If an account is deleted, trigger a deletion of the corresponding auto-bidder.
DROP TRIGGER IF EXISTS autoBidDeleteOnAccountRemoval;
DELIMITER !!!
	CREATE TRIGGER autoBidDeleteOnAccountRemoval AFTER UPDATE ON UserAccount FOR EACH ROW
    BEGIN
		IF NEW.isActive = false
        THEN
			BEGIN
				DELETE FROM AutoBiding WHERE userAccount = NEW.username;
			END;
		END IF;
    END; !!!
DELIMITER ;

# Safety check to prevent deletion of the Administrator Account.
DROP TRIGGER IF EXISTS adminChecker;
DELIMITER !!!
	CREATE TRIGGER adminChecker BEFORE DELETE ON UserAccount FOR EACH ROW
    BEGIN
		IF OLD.accessLevel = 'ADMIN'
        THEN
			BEGIN
				SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = 'ERROR - Deletion of the Admin account is forbidden.';
            END;
		END IF; 
	END; !!!
DELIMITER ;

# Daily Event procedure, update sold products, remove products that fall below user-defined reservePrice.
DROP EVENT IF EXISTS PastDue;
DELIMITER !!!
	CREATE EVENT PastDue ON SCHEDULE EVERY 1 HOUR STARTS NOW() DO
		BEGIN
            UPDATE Product SET sold = true WHERE NOW() > endDate AND price >= reservePrice;
			DELETE FROM Product WHERE NOW() > endDate AND price < reservePrice;
		END; !!!
DELIMITER ;

SELECT * FROM UserAccount;
SELECT * FROM Product;
SELECT * FROM Bid;
SELECT * FROM BuyingHistory;
SELECT * FROM SellingHistory;
SELECT * FROM Questions;
SELECT * FROM Alerts;
SELECT * FROM AlertsList;
SELECT * FROM AutoBidder;
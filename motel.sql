CREATE TABLE PostalCode(
	postalCode CHAR(6),
	city CHAR(50),
	PRIMARY KEY (postalCode)
);

CREATE TABLE Owner(
	custID INTEGER,
	email CHAR(50) UNIQUE NOT NULL,
	phone CHAR(10) NOT NULL,
	password CHAR(20) NOT NULL,
	postalCode CHAR(6) NOT NULL,
	street CHAR(50) NOT NULL,
	firstName CHAR(50) NOT NULL,
	lastName CHAR(50) NOT NULL,
	FOREIGN KEY (postalCode) REFERENCES PostalCode(postalCode)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	PRIMARY KEY (custID)
);

CREATE TABLE MakeBooking (
    confirmationID INTEGER,
    custID INTEGER,
    startDate DATE,
    endDate DATE,
    PRIMARY KEY(confirmationID),
    FOREIGN KEY(custID) REFERENCES Owner(custID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE BookingDate (
	startDate DATE,
	endDate DATE,
	duration INTEGER,
	PRIMARY KEY (startDate, endDate)
);

CREATE TABLE Price (
	duration INTEGER,
	price FLOAT,
	PRIMARY KEY (duration)
);

CREATE TABLE Staff(
    staffID INTEGER,
    title CHAR(20) NOT NULL,
    firstName CHAR(20) NOT NULL,
    lastName CHAR(20) NOT NULL,
    email CHAR(30) NOT NULL UNIQUE,
    speciality CHAR(20),
    hasManagerAccess BOOLEAN,
    password CHAR(20) NOT NULL,
    PRIMARY KEY(staffID)
);

CREATE TABLE PerformsService(
    title CHAR(20),
    staffID INTEGER,
    PRIMARY KEY (title, staffID),
    FOREIGN KEY(staffID) REFERENCES Staff (staffID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE Reserves(
    confirmationID INTEGER,
    title CHAR(20) NOT NULL,
    PRIMARY KEY(confirmationID, title),
    FOREIGN KEY(confirmationID) REFERENCES MakeBooking(confirmationID)
    	ON DELETE CASCADE
    	ON UPDATE CASCADE,
   	FOREIGN KEY(title) REFERENCES PerformsService(title)
   	 	ON DELETE CASCADE
    	ON UPDATE CASCADE
);

CREATE TABLE Branch (
	branchID INTEGER,
	phone CHAR(10) NOT NULL,
	postalCode CHAR(6) NOT NULL,
	street CHAR(50) NOT NULL,
	PRIMARY KEY (branchID)
);

CREATE TABLE HasLivingSpace (
	roomNo INTEGER,
	branchID INTEGER,
	PRIMARY KEY (roomNo, branchID),
	FOREIGN KEY (branchID) REFERENCES Branch (branchID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE Pet(
	name CHAR(50) NOT NULL,
	photo CHAR(50),
	weight FLOAT,
	sex CHAR(1),
	age INTEGER,
	species CHAR(50),
	diet CHAR(50),
	petID INTEGER,
	branchID INTEGER,
	roomNo INTEGER,
	ownerID INTEGER,
	FOREIGN KEY (branchID) REFERENCES Branch (branchID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (roomNo) REFERENCES HasLivingSpace (roomNo)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (ownerID) REFERENCES Owner (custID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	PRIMARY KEY (petID)
);

CREATE TABLE Mammal(
	petID INTEGER,
	personality CHAR(50),
	furRoutine CHAR(50),
	nailRoutine CHAR(50),
	FOREIGN KEY (petID) REFERENCES Pet (petID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	PRIMARY KEY (petID)
);

CREATE TABLE Bird(
	petID INTEGER,
	communication CHAR(50),
	featherRoutine CHAR(50),
	socialization BOOLEAN,
	FOREIGN KEY (petID) REFERENCES Pet (petID)
 		ON DELETE CASCADE
		ON UPDATE CASCADE,
	PRIMARY KEY (petID)
);

CREATE TABLE Reptile(
	petID INTEGER,
	tempRequirement CHAR(50),
	isMoulting BOOLEAN,
	lightConditions CHAR(50),
	FOREIGN KEY (petID) REFERENCES Pet (petID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	PRIMARY KEY (petID)
);

CREATE TABLE CarriesMembership (
	custID INTEGER,
	cardNo INTEGER,
	points INTEGER,
	PRIMARY KEY (cardNo),
	FOREIGN KEY (custID) references Owner(custID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE WorksAt (
    branchID INTEGER,
    staffID INTEGER,
    PRIMARY KEY (branchID, staffID),
    FOREIGN KEY (branchID) REFERENCES Branch(branchID)
    ON DELETE CASCADE
        ON UPDATE  CASCADE,
    FOREIGN KEY (staffID) REFERENCES Staff(staffID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE CaresFor (
	petID INTEGER,
	staffID INTEGER,
	PRIMARY KEY (petID, staffID),
	FOREIGN KEY (petID) REFERENCES Pet(petID)
        ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (staffID) REFERENCES Staff(staffID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

Insert into PostalCode values ('V6T2C9', 'Vancouver');
Insert into PostalCode values ('V3J1N4', 'Burnaby');
Insert into PostalCode values ('V7T2W4', 'West Vancouver');
Insert into PostalCode values ('V3B5R5', 'Coquitlam');
Insert into PostalCode values ('V3A7E9', 'Langley');

Insert into Owner values (1, 'swong@gmail.com', 1111, 'pass123', 'V6T2C9', '5959 Student Union Boulevard', 'Spencer', 'Wong');
Insert into Owner values (2, 'jenarnold@gmail.com', 6043217654, 'qwerty', 'V3B5R5', '2929 Barnet Hwy', 'Jennifer', 'Arnold');
Insert into Owner values (3, 'dorah32@gmail.com', 6049876543, 'dragon', 'V7T2W4', '2002 Park Royal South', 'Dora', 'Hicks');
Insert into Owner values (4, 'phelpsjulio@gmail.com', 7781352468, 'baseball', 'V3A7E9', '19705 Fraser Hwy', 'Julio', 'Phelps');
Insert into Owner values (5, 'hamilmichael@gmail.com', 7789987765, 'passw0rd', 'V3B5R5', '2929 Barnet Hwy', 'Michael', 'Hamilton');
Insert into Owner values (6, 'kathryn.cohen@gmail.com', 6045537098, 'superman', 'V3A7E9', '19705 Fraser Hwy', 'Kathryn', 'Cohen');
Insert into Owner values (7, 'betsyjacobs1@gmail.com', 6041345623, 'football', 'V3J1N4', '9855 Austin Ave', 'Betsy', 'Jacobs');
Insert into Owner values (8, 'brian4snyder@gmail.com', 7786431234, 'welcome', 'V7T2W4', '2002 Park Royal South', 'Brian', 'Snyder');
Insert into Owner values (9, 'pmedina@gmail.com', 6044120897, 'princess', 'V3B5R5', '2929 Barnet Hwy', 'Patty', 'Medina');
Insert into Owner values (10, 'charlter@gmail.com', 7786780841, '123qwe', 'V3A7E9', '19705 Fraser Hwy', 'Charlene', 'Terry');
Insert into Owner values (11, 'josephtang81@gmail.com', 7780114675, 'hello', 'V3J1N4', '9855 Austin Ave', 'Joseph', 'Tang');
Insert into Owner values (12, 'linettekahn942@gmail.com',
7788899342, 'whatever', 'V3J1N4', '9855 Austin Ave', 'Linette', 'Kahn');
Insert into Owner values (13, 'tomas.rowe@gmail.com', 6046653341, 'trustno1', 'V3A7E9', '19705 Fraser Hwy', 'Tomas', 'Rowe');
Insert into Owner values (14, 'lunanoel@gmail.com', 6041123344, 'letmein', 'V6T2C9', '5959 Student Union Boulevard', 'Noel', 'Luna');
Insert into Owner values (15, 'jillbishop@gmail.com', 6045321410, 'hellooo', 'V3A7E9', '19705 Fraser Hwy', 'Jill', 'Bishop');
Insert into Owner values (16, 'mindwash@gmail.com', 7784287124, 'whatever', 'V3A7E9', '19705 Fraser Hwy', 'Mindy', 'Washington');
Insert into Owner values (17, 'donnieday@gmail.com', 7786128032, 'hithere', 'V3J1N4', '9855 Austin Ave', 'Donnie', 'Day');

insert into MakeBooking values(100,1,STR_TO_DATE('20,10,2020','%d,%m,%Y'),STR_TO_DATE('10,10,2020','%d,%m,%Y'));
insert into MakeBooking values(101,2,STR_TO_DATE('1,1,2020','%d,%m,%Y'),STR_TO_DATE('10,1,2020','%d,%m,%Y'));
insert into MakeBooking values(102,3,STR_TO_DATE('1,2,2020','%d,%m,%Y'),STR_TO_DATE('10,2,2020','%d,%m,%Y'));
insert into MakeBooking values(103,4,STR_TO_DATE('1,3,2020','%d,%m,%Y'),STR_TO_DATE('10,3,2020','%d,%m,%Y'));
insert into MakeBooking values(104,5,STR_TO_DATE('1,4,2020','%d,%m,%Y'),STR_TO_DATE('10,4,2020','%d,%m,%Y'));

insert into BookingDate values(STR_TO_DATE('1,10,2020','%d,%m,%Y'),STR_TO_DATE('6,10,2020','%d,%m,%Y'), 5);
insert into BookingDate values(STR_TO_DATE('1,10,2020','%d,%m,%Y'),STR_TO_DATE('11,10,2020','%d,%m,%Y'), 10);
insert into BookingDate values(STR_TO_DATE('1,1,2020','%d,%m,%Y'),STR_TO_DATE('16,1,2020','%d,%m,%Y'), 15);
insert into BookingDate values(STR_TO_DATE('1,7,2020','%d,%m,%Y'),STR_TO_DATE('21,7,2020','%d,%m,%Y'), 20);
insert into BookingDate values(STR_TO_DATE('1,6,2020','%d,%m,%Y'),STR_TO_DATE('26,6,2020','%d,%m,%Y'), 25);

insert into Price values(5, 250);
insert into Price values(10, 500);
insert into Price values(15, 750);
insert into Price values(20, 1000);
insert into Price values(25, 1250);

insert into Staff values(747, 'Washing', 'Bob', 'Deelan', 'bd1120@hotmail.com', 'Washer', 0, 'sosadsoverysad0101');
insert into Staff values(360, 'Grooming', 'Mike', 'Jaeger', 'mikejaeger@gmail.com', 'Groomer', 0, 'superfly1121');
insert into Staff values(180, 'Dog walking', 'Milton', 'Keynes', 'mkey@yahoo.com', 'Walker', 0, '304databases');
insert into Staff values(720, 'Nail cutting', 'Amy', 'Beerhouse', 'beerhouse@gmail.com', 'Nail trimmer', 0, 'ellemayoh');
insert into Staff values(240, 'Dog washing', 'Anna', 'Banana', 'annaa@banana.com', 'Washer', 1, 'itsmyfavourite2131');

insert into PerformsService values('Washing', 747);
insert into PerformsService values('Grooming', 360);
insert into PerformsService values('Dog walking', 180);
insert into PerformsService values('Nail cutting', 720);
insert into PerformsService values('Dog washing', 240);

insert into Reserves values(100, 'Grooming');
insert into Reserves values(101, 'Nail cutting');
insert into Reserves values(102, 'Dog walking');
insert into Reserves values(103, 'Dog walking');
insert into Reserves values(104, 'Washing');

Insert into Branch values (1, 7789077930, 'V3B5R5', '2929 Barnet Hwy');
Insert into Branch values (2, 6048889999, 'V3A7E9', '19705 Fraser Hwy');
Insert into Branch values (3, 7780068293, 'V7T2W4', '2002 Park Royal South');
Insert into Branch values (4, 6048820837, 'V6T2C9', '5959 Student Union Boulevard');
Insert into Branch values (5, 6040254361, 'V3J1N4', '9855 Austin Ave');

insert into HasLivingSpace values(101, 1);
insert into HasLivingSpace values(201, 2);
insert into HasLivingSpace values(301, 3);
insert into HasLivingSpace values(401, 4);
insert into HasLivingSpace values(501, 5);

Insert into Pet values ('Angel', '/photos/00000001.jpg', 0.26, 'F', 9, 'Dog', 'Dry', 1, 2, 201, 8);
Insert into Pet values ('Bear', '/photos/00000002.jpg', 30.8, 'M', 3, 'Dog', 'Dry', 2, 2, 201, 6);
Insert into Pet values ('Cherry', '/photos/00000003.jpg', 4.7, 'F', 2, 'Turtle', 'Dry', 3, 4, 401, 9);
Insert into Pet values ('Draco', '/photos/00000004.jpg', 0.53, 'M', 8, 'Bearded Dragon', 'Fresh', 4, 4, 401, 3);
Insert into Pet values ('Harley', '/photos/00000005.jpg', 2, 'F', 2, 'Parrot', 'Seeds', 5, 1, 401, 7);
Insert into Pet values ('Mango', '/photos/00000006.jpg', 1.7, 'F', 3, 'Parrot', 'Fresh', 6, 1, 401, 11);
Insert into Pet values ('Michelangelo', '/photos/00000007.jpg', 7.6, 'M', 3, 'Turtle', 'Fresh', 7, 4, 401, 1);
Insert into Pet values ('Nala', '/photos/00000008.jpg', 4, 'F', 11, 'Cat', 'Wet', 8, 3, 301, 5);
Insert into Pet values ('Pip', '/photos/00000009.jpg', 0.46, 'F', 4, 'Snake', 'Fresh', 9, 5, 501, 12);
Insert into Pet values ('Pocket', '/photos/00000010.jpg', 3.1, 'F', 5, 'Cat', 'Dry', 10, 3, 301, 2);
Insert into Pet values ('Rory', '/photos/00000011.jpg', 35.4, 'F', 8, 'Dog', 'Dry', 11, 2, 201, 13);
Insert into Pet values ('Sapphire', '/photos/00000012.jpg', 0.09, 'F', 3, 'Cockatiel', 'Seeds', 12, 1, 101, 4);
Insert into Pet values ('Simba', '/photos/00000013.jpg', 5.1, 'M', 2, 'Dog', 'Wet', 13, 2, 201, 9);
Insert into Pet values ('Squirt', '/photos/00000014.jpg', 5.2, 'M', 2, 'Turtle', 'Fresh', 14, 4, 401, 14);
Insert into Pet values ('Tweety', '/photos/00000015.jpg', 0.14, 'M', 5, 'Parakeet', 'Seeds', 15, 1, 101, 10);
Insert into Pet values ('Lucy', '/photos/000000016.jpg', 3.4, 'F', 7, 'Dog', 'Dry', 17, 2, 201, 15);
Insert into Pet values ('Bean', '/photos/000000017.jpg', 4.20, 'M', 2, 'Cat', 'Dry', 18, 3, 301, 15);
Insert into Pet values ('Basil', '/photos/000000018.jpg', 5.6, 'M', 13, 'Turtle', 'Fresh', 19, 4, 401, 15);
Insert into Pet values ('Cleo', '/photos/000000019.jpg', 0.16, 'F', 3, 'Parakeet', 'Seeds', 20, 1, 101, 15);
Insert into Pet values ('Fern', '/photos/00000020.jpg', 0.43, 'F', 4, 'Snake', 'Fresh', 201, 5, 501, 15);
Insert into Pet values ('Jersey', '/photos/000000021.jpg', 0.77, 'M', 9, 'Parrot', 'Dry', 21, 1, 101, 16);
Insert into Pet values ('Ollie', '/photos/000000022.jpg', 8.9, 'M', 4, 'Dog', 'Dry', 22, 2, 201, 16);
Insert into Pet values ('Matilda', '/photos/000000023.jpg', 2.1, 'F', 5, 'Cat', 'Dry', 23, 3, 301, 16);
Insert into Pet values ('Mocha', '/photos/000000024.jpg', 2.2, 'F', 5, 'Turtle', 'Fresh', 24, 4, 401, 16);
Insert into Pet values ('Roxy', '/photos/000000025.jpg', 3.2, 'F', 7, 'Turtle', 'Fresh', 25, 5, 501, 16);
Insert into Pet values ('Lucky', '/photos/000000026.jpg', 0.52, 'M', 2, 'Cockatiel', 'Seeds', 26, 1, 101, 17);
Insert into Pet values ('Reese', '/photos/000000027.jpg', 27.2, 'M', 5, 'Dog', 'Dry', 27, 2, 201, 17);
Insert into Pet values ('Tilly', '/photos/000000028.jpg', 17.2, 'F', 7, 'Cat', 'Dry', 28, 3, 301, 17);
Insert into Pet values ('Mia', '/photos/000000029.jpg', 9.2, 'F', 12, 'Turtle', 'Fresh', 29, 4, 401, 17);
Insert into Pet values ('Juliet', '/photos/000000030.jpg', 1.2, 'F', 1, 'Snake', 'Fresh', 30, 5, 501, 17);

Insert into Mammal values (2, 'Aggressive', 'Brush', 'Clip');
Insert into Mammal values (8, 'Shy', 'Brush', 'Paint');
Insert into Mammal values (10, 'Energetic', 'Bathe', NULL);
Insert into Mammal values (11, 'Friendly', NULL, 'Paint');
Insert into Mammal values (13, 'Energetic', 'Bathe', 'Clip');
Insert into Mammal values (17, 'Shy', 'Bathe', 'Paint');
Insert into Mammal values (22, 'Aggressive', NULL, 'Paint');
Insert into Mammal values (23, 'Shy', NULL, NULL);
Insert into Mammal values (27, 'Aggressive', NULL, 'Paint');
Insert into Mammal values (28, 'Energetic', 'Bathe', NULL);

Insert into Bird values (1, 'Vocal', 'Self-preening', 1);
Insert into Bird values (5, 'English', 'Requires assistance', 0);
Insert into Bird values (6, 'Non-vocal', 'Self-preening', 1);
Insert into Bird values (12, 'Non-vocal', 'Self-preening', 1);
Insert into Bird values (15, 'Non-vocal', 'Self-preening', 1);
Insert into Bird values (19, 'Non-vocal', 'Self-preening', 1);
Insert into Bird values (21, 'English', 'Requires assistance', 0);
Insert into Bird values (26, 'Non-vocal', 'Self-preening', 1);

Insert into Reptile values (3, '22 - 25', 0, 12);
Insert into Reptile values (4, '25 - 30', 0, 12);
Insert into Reptile values (7, '22 - 25', 0, 12);
Insert into Reptile values (9, '30 - 35', 1, 24);
Insert into Reptile values (14, '22 - 25', 0, 12);
Insert into Reptile values (18, '22 - 25', 0, 12);
Insert into Reptile values (20, '30 - 35', 0, 24);
Insert into Reptile values (24, '30 - 35', 0, 24);
Insert into Reptile values (25, '22 - 25', 0, 12);
Insert into Reptile values (29, '22 - 25', 0, 12);
Insert into Reptile values (30, '30 - 35', 0, 24);

Insert into CarriesMembership values (1, 11111111, 0);
Insert into CarriesMembership values (3, 11111112, 100);
Insert into CarriesMembership values (5, 11111113, 200);
Insert into CarriesMembership values (6, 11111114, 1000);
Insert into CarriesMembership values (8, 11111115, 0);

Insert into WorksAt values (1, 747);
Insert into WorksAt values (2, 360);
Insert into WorksAt values (3, 180);
Insert into WorksAt values (4, 720);
Insert into WorksAt values (5, 240);

Insert into CaresFor values (1, 747);
Insert into CaresFor values (2, 180);
Insert into CaresFor values (3, 747);
Insert into CaresFor values (4, 747);
Insert into CaresFor values (5, 747);
Insert into CaresFor values (6, 747);
Insert into CaresFor values (7, 747);
Insert into CaresFor values (8, 360);
Insert into CaresFor values (9, 747);
Insert into CaresFor values (10, 720);
Insert into CaresFor values (11, 240);
Insert into CaresFor values (12, 747);
Insert into CaresFor values (13, 747);
Insert into CaresFor values (14, 747);
Insert into CaresFor values (15, 747);
Insert into CaresFor values (17, 180);
Insert into CaresFor values (18, 747);
Insert into CaresFor values (19, 747);
Insert into CaresFor values (20, 747);
Insert into CaresFor values (21, 360);
Insert into CaresFor values (22, 747);
Insert into CaresFor values (23, 720);
Insert into CaresFor values (24, 720);
Insert into CaresFor values (25, 240);
Insert into CaresFor values (26, 720);
Insert into CaresFor values (27, 240);
Insert into CaresFor values (28, 747);
Insert into CaresFor values (29, 747);
Insert into CaresFor values (30, 747);
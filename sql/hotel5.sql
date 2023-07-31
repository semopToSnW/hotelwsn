
/* Drop Triggers */

DROP TRIGGER TRI_CONNCECTION_ID;
DROP TRIGGER TRI_CONNECTION_ID;
DROP TRIGGER TRI_DayRoom_ID;
DROP TRIGGER TRI_Image_ID;
DROP TRIGGER TRI_OLD_DAYROOM_ID;
DROP TRIGGER TRI_OLD_RESERVATION_ID;
DROP TRIGGER TRI_OLD_RES_GROUP_ID;
DROP TRIGGER TRI_PRODUCT_ID;
DROP TRIGGER TRI_Pro_RESERVATION_ID;
DROP TRIGGER TRI_Rank_ID;
DROP TRIGGER TRI_RESERVATION_ID;
DROP TRIGGER TRI_RES_GROUP_ID;
DROP TRIGGER TRI_ROOM_ID;
DROP TRIGGER TRI_STATUS_id;



/* Drop Tables */

DROP TABLE RES_GROUP CASCADE CONSTRAINTS;
DROP TABLE STATUS CASCADE CONSTRAINTS;
DROP TABLE RESERVATION CASCADE CONSTRAINTS;
DROP TABLE OLD_RES_GROUP CASCADE CONSTRAINTS;
DROP TABLE OLD_RESERVATION CASCADE CONSTRAINTS;
DROP TABLE USER CASCADE CONSTRAINTS;
DROP TABLE DAYROOM CASCADE CONSTRAINTS;
DROP TABLE RANK CASCADE CONSTRAINTS;
DROP TABLE ROOM CASCADE CONSTRAINTS;
DROP TABLE CONNECTION CASCADE CONSTRAINTS;
DROP TABLE Image CASCADE CONSTRAINTS;
DROP TABLE PRODUCT CASCADE CONSTRAINTS;
DROP TABLE COMPANY CASCADE CONSTRAINTS;
DROP TABLE OLD_DAYROOM CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE SEQ_CONNCECTION_ID;
DROP SEQUENCE SEQ_CONNECTION_ID;
DROP SEQUENCE SEQ_DayRoom_ID;
DROP SEQUENCE SEQ_Image_ID;
DROP SEQUENCE SEQ_OLD_DAYROOM_ID;
DROP SEQUENCE SEQ_OLD_RESERVATION_ID;
DROP SEQUENCE SEQ_OLD_RES_GROUP_ID;
DROP SEQUENCE SEQ_PRODUCT_ID;
DROP SEQUENCE SEQ_Pro_RESERVATION_ID;
DROP SEQUENCE SEQ_Rank_ID;
DROP SEQUENCE SEQ_RESERVATION_ID;
DROP SEQUENCE SEQ_RES_GROUP_ID;
DROP SEQUENCE SEQ_ROOM_ID;
DROP SEQUENCE SEQ_STATUS_id;




/* Create Sequences */

CREATE SEQUENCE SEQ_CONNECTION_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_DayRoom_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_Image_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_OLD_DAYROOM_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_OLD_RESERVATION_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_OLD_RES_GROUP_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_PRODUCT_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_Pro_RESERVATION_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_Rank_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_RESERVATION_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_RES_GROUP_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_ROOM_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_STATUS_id INCREMENT BY 1 START WITH 1;



/* Create Tables */

CREATE TABLE COMPANY
(
	ID varchar2(50) NOT NULL,
	Name varchar2(50) NOT NULL,
	Group varchar2(50) NOT NULL,
	CEO varchar2(30) NOT NULL,
	Phone varchar2(30) NOT NULL,
	Email varchar2(50) NOT NULL,
	Addr varchar2(100) NOT NULL,
	RegDate date NOT NULL,
	InfoCompleted varchar2(5) NOT NULL,
	PRIMARY KEY (ID)
);


CREATE TABLE CONNECTION
(
	ID number NOT NULL,
	Hotel_ID varchar2(50) NOT NULL,
	OTA_ID varchar2(50) NOT NULL,
	PRIMARY KEY (ID)
);


CREATE TABLE DAYROOM
(
	ID number NOT NULL,
	Date date NOT NULL,
	Hotel_Assign number(4) NOT NULL,
	Tour_Assign number(4) NOT NULL,
	Price number(10) NOT NULL,
	Hotel_OnOff varchar2(3) NOT NULL,
	Tour_OnOff varchar2(3) NOT NULL,
	Room_ID number NOT NULL,
	Rank_Type varchar2(1) NOT NULL,
	PRIMARY KEY (ID)
);


CREATE TABLE Image
(
	ID number NOT NULL,
	Picture blob NOT NULL,
	Explain varchar2(3000),
	Product_ID number NOT NULL,
	PicNum number(2) NOT NULL,
	status varchar2(100),
	filename varchar2(20) NOT NULL,
	PRIMARY KEY (ID)
);


CREATE TABLE OLD_DAYROOM
(
	ID number NOT NULL,
	Date date NOT NULL,
	Hotel_Assign number(4) NOT NULL,
	Tour_Assign number(4) NOT NULL,
	Price number(10) NOT NULL,
	Hotel_OnOff varchar2(3) NOT NULL,
	Tour_OnOff varchar2(3) NOT NULL,
	Rank_Type varchar2(1) NOT NULL,
	room_type varchar2(100) NOT NULL,
	PRIMARY KEY (ID)
);


CREATE TABLE OLD_RESERVATION
(
	ID number NOT NULL,
	CheckIn date NOT NULL,
	CheckOut date NOT NULL,
	Persons nvarchar2(2) NOT NULL,
	RegDate date NOT NULL,
	RenewDate date,
	StayPerson varchar2(50) NOT NULL,
	Res_Person varchar2(50) NOT NULL,
	Nation varchar2(30),
	Phone varchar2(30),
	Memo varchar2(3000),
	RenewPerson varchar2(7) NOT NULL,
	Reg_Person varchar2(7) NOT NULL,
	status varchar2(100) NOT NULL,
	PRIMARY KEY (ID)
);


CREATE TABLE OLD_RES_GROUP
(
	ID number NOT NULL,
	DAYROOM_ID number NOT NULL,
	RESERVATION_ID number NOT NULL,
	hotel_room_count number(4) NOT NULL,
	tour_room_count number(3) NOT NULL,
	price number(10) NOT NULL,
	PRODUCT_ID number NOT NULL,
	PRIMARY KEY (ID)
);


CREATE TABLE PRODUCT
(
	ID number NOT NULL,
	Name varchar2(100) NOT NULL,
	Explain varchar2(3000) NOT NULL,
	MealTypes varchar2(12),
	CheckInTime varchar2(25),
	CheckOutTime varchar2(25),
	Amount number(4),
	Prices varchar2(500) NOT NULL,
	RoomTypes varchar2(50) NOT NULL,
	Company_ID varchar2(50) NOT NULL,
	salestart date NOT NULL,
	salefinish date NOT NULL,
	PRIMARY KEY (ID)
);


CREATE TABLE RANK
(
	ID number NOT NULL,
	Type varchar2(1) NOT NULL,
	Price number(10) NOT NULL,
	Room_ID number NOT NULL,
	PRIMARY KEY (ID)
);


CREATE TABLE RESERVATION
(
	ID number NOT NULL,
	CheckIn date NOT NULL,
	CheckOut date NOT NULL,
	Persons nvarchar2(2) NOT NULL,
	RegDate date NOT NULL,
	RenewDate date,
	StayPerson varchar2(50) NOT NULL,
	Res_Person varchar2(50) NOT NULL,
	Nation varchar2(30),
	Phone varchar2(30),
	Memo varchar2(3000),
	-- 
	-- 
	Reg_Person varchar2(7) NOT NULL,
	-- 
	-- 
	RenewPerson varchar2(7) NOT NULL,
	PRIMARY KEY (ID)
);


CREATE TABLE RES_GROUP
(
	ID number NOT NULL,
	DayRoom_ID number NOT NULL,
	Reservation_ID number NOT NULL,
	hotel_room_count number(4) NOT NULL,
	tour_room_count number(3) NOT NULL,
	price number(10) NOT NULL,
	product_id number NOT NULL,
	PRIMARY KEY (ID)
);


CREATE TABLE ROOM
(
	ID number NOT NULL,
	Type varchar2(50) NOT NULL,
	Amount number(4) NOT NULL,
	Persons number(4) NOT NULL,
	Tour_Assign number(4) NOT NULL,
	Hotel_ID varchar2(50) NOT NULL,
	Hotel_Assign number(4) NOT NULL,
	PRIMARY KEY (ID)
);


CREATE TABLE STATUS
(
	id number NOT NULL,
	status_name varchar2(10) NOT NULL,
	reservation_ID number NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE USER
(
	-- 
	-- 
	ID varchar2(7) NOT NULL,
	PW varchar2(20),
	REGDATE date NOT NULL,
	ContractPeriod number(2),
	Company_ID varchar2(50),
	PRIMARY KEY (ID)
);



/* Create Foreign Keys */

ALTER TABLE USER
	ADD FOREIGN KEY (Company_ID)
	REFERENCES COMPANY (ID)
;


ALTER TABLE ROOM
	ADD FOREIGN KEY (Hotel_ID)
	REFERENCES COMPANY (ID)
;


ALTER TABLE CONNECTION
	ADD FOREIGN KEY (Hotel_ID)
	REFERENCES COMPANY (ID)
;


ALTER TABLE CONNECTION
	ADD FOREIGN KEY (OTA_ID)
	REFERENCES COMPANY (ID)
;


ALTER TABLE PRODUCT
	ADD FOREIGN KEY (Company_ID)
	REFERENCES COMPANY (ID)
;


ALTER TABLE RES_GROUP
	ADD FOREIGN KEY (DayRoom_ID)
	REFERENCES DAYROOM (ID)
;


ALTER TABLE OLD_RES_GROUP
	ADD FOREIGN KEY (DAYROOM_ID)
	REFERENCES OLD_DAYROOM (ID)
;


ALTER TABLE OLD_RES_GROUP
	ADD FOREIGN KEY (RESERVATION_ID)
	REFERENCES OLD_RESERVATION (ID)
;


ALTER TABLE RES_GROUP
	ADD FOREIGN KEY (product_id)
	REFERENCES PRODUCT (ID)
;


ALTER TABLE Image
	ADD FOREIGN KEY (Product_ID)
	REFERENCES PRODUCT (ID)
;


ALTER TABLE OLD_RES_GROUP
	ADD FOREIGN KEY (PRODUCT_ID)
	REFERENCES PRODUCT (ID)
;


ALTER TABLE RES_GROUP
	ADD FOREIGN KEY (Reservation_ID)
	REFERENCES RESERVATION (ID)
;


ALTER TABLE STATUS
	ADD FOREIGN KEY (reservation_ID)
	REFERENCES RESERVATION (ID)
;


ALTER TABLE DAYROOM
	ADD FOREIGN KEY (Room_ID)
	REFERENCES ROOM (ID)
;


ALTER TABLE RANK
	ADD FOREIGN KEY (Room_ID)
	REFERENCES ROOM (ID)
;


ALTER TABLE RESERVATION
	ADD FOREIGN KEY (RenewPerson)
	REFERENCES USER (ID)
;


ALTER TABLE RESERVATION
	ADD FOREIGN KEY (Reg_Person)
	REFERENCES USER (ID)
;


ALTER TABLE OLD_RESERVATION
	ADD FOREIGN KEY (Reg_Person)
	REFERENCES USER (ID)
;



/* Create Triggers */

CREATE OR REPLACE TRIGGER TRI_CONNCECTION_ID BEFORE INSERT ON CONNCECTION
FOR EACH ROW
BEGIN
	SELECT SEQ_CONNCECTION_ID.nextval
	INTO :new.ID
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_CONNECTION_ID BEFORE INSERT ON CONNECTION
FOR EACH ROW
BEGIN
	SELECT SEQ_CONNECTION_ID.nextval
	INTO :new.ID
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_DayRoom_ID BEFORE INSERT ON DayRoom
FOR EACH ROW
BEGIN
	SELECT SEQ_DayRoom_ID.nextval
	INTO :new.ID
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_Image_ID BEFORE INSERT ON Image
FOR EACH ROW
BEGIN
	SELECT SEQ_Image_ID.nextval
	INTO :new.ID
	FROM dual;
END;

/
/*
CREATE OR REPLACE TRIGGER TRI_OLD_DAYROOM_ID BEFORE INSERT ON OLD_DAYROOM
FOR EACH ROW
BEGIN
	SELECT SEQ_OLD_DAYROOM_ID.nextval
	INTO :new.ID
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_OLD_RESERVATION_ID BEFORE INSERT ON OLD_RESERVATION
FOR EACH ROW
BEGIN
	SELECT SEQ_OLD_RESERVATION_ID.nextval
	INTO :new.ID
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_OLD_RES_GROUP_ID BEFORE INSERT ON OLD_RES_GROUP
FOR EACH ROW
BEGIN
	SELECT SEQ_OLD_RES_GROUP_ID.nextval
	INTO :new.ID
	FROM dual;
END;

/
*/
CREATE OR REPLACE TRIGGER TRI_PRODUCT_ID BEFORE INSERT ON PRODUCT
FOR EACH ROW
BEGIN
	SELECT SEQ_PRODUCT_ID.nextval
	INTO :new.ID
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_Pro_RESERVATION_ID BEFORE INSERT ON Pro_RESERVATION
FOR EACH ROW
BEGIN
	SELECT SEQ_Pro_RESERVATION_ID.nextval
	INTO :new.ID
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_Rank_ID BEFORE INSERT ON Rank
FOR EACH ROW
BEGIN
	SELECT SEQ_Rank_ID.nextval
	INTO :new.ID
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_RESERVATION_ID BEFORE INSERT ON RESERVATION
FOR EACH ROW
BEGIN
	SELECT SEQ_RESERVATION_ID.nextval
	INTO :new.ID
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_RES_GROUP_ID BEFORE INSERT ON RES_GROUP
FOR EACH ROW
BEGIN
	SELECT SEQ_RES_GROUP_ID.nextval
	INTO :new.ID
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_ROOM_ID BEFORE INSERT ON ROOM
FOR EACH ROW
BEGIN
	SELECT SEQ_ROOM_ID.nextval
	INTO :new.ID
	FROM dual;
END;

/

/*
CREATE OR REPLACE TRIGGER TRI_STATUS_id BEFORE INSERT ON STATUS
FOR EACH ROW
BEGIN
	SELECT SEQ_STATUS_id.nextval
	INTO :new.id
	FROM dual;
END;

/
 */




/* Comments */

COMMENT ON COLUMN OLD_RESERVATION.RenewPerson IS '
';
COMMENT ON COLUMN OLD_RESERVATION.Reg_Person IS '
';
COMMENT ON COLUMN RESERVATION.Reg_Person IS '
';
COMMENT ON COLUMN RESERVATION.RenewPerson IS '
';
COMMENT ON COLUMN USER.ID IS '
';





/* Drop Triggers */

DROP TRIGGER TRI_CONNECTION_ID;
DROP TRIGGER TRI_DayRoom_ID;
DROP TRIGGER TRI_Image_ID;
DROP TRIGGER TRI_PRODUCT_ID;
DROP TRIGGER TRI_Pro_RESERVATION_ID;
DROP TRIGGER TRI_Rank_ID;
DROP TRIGGER TRI_RESERVATION_ID;
DROP TRIGGER TRI_RES_GROUP_ID;
DROP TRIGGER TRI_ROOM_ID;
DROP TRIGGER TRI_res_group_updates_dayroom ;

/* Drop Tables */

DROP TABLE Image CASCADE CONSTRAINTS;
DROP TABLE Pro_RESERVATION CASCADE CONSTRAINTS;
DROP TABLE PRODUCT CASCADE CONSTRAINTS;
DROP TABLE RES_GROUP CASCADE CONSTRAINTS;
DROP TABLE RESERVATION CASCADE CONSTRAINTS;
DROP TABLE "USER" CASCADE CONSTRAINTS;
DROP TABLE RANK CASCADE CONSTRAINTS;
DROP TABLE DAYROOM CASCADE CONSTRAINTS;
DROP TABLE ROOM CASCADE CONSTRAINTS;
DROP TABLE CONNECTION CASCADE CONSTRAINTS;
DROP TABLE COMPANY CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE SEQ_CONNECTION_ID;
DROP SEQUENCE SEQ_DayRoom_ID;
DROP SEQUENCE SEQ_Image_ID;
DROP SEQUENCE SEQ_PRODUCT_ID;
DROP SEQUENCE SEQ_Pro_RESERVATION_ID;
DROP SEQUENCE SEQ_Rank_ID;
DROP SEQUENCE SEQ_RESERVATION_ID;
DROP SEQUENCE SEQ_RES_GROUP_ID;
DROP SEQUENCE SEQ_ROOM_ID;




/* Create Sequences */

CREATE SEQUENCE SEQ_CONNECTION_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_DayRoom_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_Image_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_PRODUCT_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_Pro_RESERVATION_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_Rank_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_RESERVATION_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_RES_GROUP_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_ROOM_ID INCREMENT BY 1 START WITH 1;



/* Create Tables */

CREATE TABLE COMPANY
(
	ID varchar2(50) NOT NULL,
	Name varchar2(50) NOT NULL,
	"Group" varchar2(50) NOT NULL,
	CEO varchar2(30) NOT NULL,
	Phone varchar2(30) NOT NULL,
	Email varchar2(50) NOT NULL,
	Addr varchar2(100) NOT NULL,
	RegDate date NOT NULL,
	InfoCompleted varchar2(5) default 'false' NOT NULL,
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
	"Date" date NOT NULL,
	Hotel_Assign number(4) NOT NULL check(Hotel_Assign>=0),
	Tour_Assign number(4) NOT NULL check(Tour_Assign>=0),
	Price number(10) NOT NULL,
	Hotel_OnOff varchar2(3) DEFAULT 'on' NOT NULL,
	Tour_OnOff varchar2(3) DEFAULT 'on' NOT NULL,
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
	FileName varchar2(100) NOT NULL,
	PRIMARY KEY (ID)
);


CREATE TABLE PRODUCT
(
	ID number NOT NULL,
	Name varchar2(100) NOT NULL,
	Explain varchar2(3000) NOT NULL,
	SalePeriod varchar2(50) NOT NULL,
	MealTypes varchar2(20),
	CheckInTime varchar2(25),
	CheckOutTime varchar2(25),
	Amount number(4),
	Prices varchar2(500) NOT NULL,
	RoomTypes varchar2(50) NOT NULL,
	Company_ID varchar2(50) NOT NULL,
	PRIMARY KEY (ID)
);


CREATE TABLE Pro_RESERVATION
(
	ID number NOT NULL,
	Reservation_ID number NOT NULL,
	Product_ID number NOT NULL,
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
	Reg_Person varchar2(7) NOT NULL,
	RenewPerson varchar2(7),
	PRIMARY KEY (ID)
);


CREATE TABLE RES_GROUP
(
	ID number NOT NULL,
	DayRoom_ID number NOT NULL,
	Reservation_ID number NOT NULL,
	Hotel_Room_count number(3) not null,
	Tour_Room_count number(3) not null,
	PRICE NUMBER(10) NOT NULL,
	PRIMARY KEY (ID)
);


CREATE TABLE ROOM
(
	ID number NOT NULL,
	Type varchar2(50) NOT NULL,
	Amount number(4) NOT NULL,
	Persons number(4) NOT NULL,
	Hotel_Assign number(4) NOT NULL,
	Tour_Assign number(4) NOT NULL,
	Hotel_ID varchar2(50) NOT NULL,
	PRIMARY KEY (ID)
);


CREATE TABLE "USER"
(
	ID varchar2(7) NOT NULL,
	PW varchar2(20),
	REGDATE date NOT NULL,
	ContractPeriod number(2),
	Company_ID varchar2(50),
	PRIMARY KEY (ID)
);



/* Create Foreign Keys */

ALTER TABLE PRODUCT
	ADD FOREIGN KEY (Company_ID)
	REFERENCES COMPANY (ID)
;


ALTER TABLE "USER"
	ADD FOREIGN KEY (Company_ID)
	REFERENCES COMPANY (ID)
;


ALTER TABLE ROOM
	ADD FOREIGN KEY (Hotel_ID)
	REFERENCES COMPANY (ID)
;


ALTER TABLE CONNECTION
	ADD FOREIGN KEY (OTA_ID)
	REFERENCES COMPANY (ID)
;


ALTER TABLE CONNECTION
	ADD FOREIGN KEY (Hotel_ID)
	REFERENCES COMPANY (ID)
;


ALTER TABLE RES_GROUP
	ADD FOREIGN KEY (DayRoom_ID)
	REFERENCES DAYROOM (ID)
;


ALTER TABLE Image
	ADD FOREIGN KEY (Product_ID)
	REFERENCES PRODUCT (ID)
;


ALTER TABLE Pro_RESERVATION
	ADD FOREIGN KEY (Product_ID)
	REFERENCES PRODUCT (ID)
;


ALTER TABLE RES_GROUP
	ADD FOREIGN KEY (Reservation_ID)
	REFERENCES RESERVATION (ID)
;


ALTER TABLE Pro_RESERVATION
	ADD FOREIGN KEY (Reservation_ID)
	REFERENCES RESERVATION (ID)
;


ALTER TABLE RANK
	ADD FOREIGN KEY (Room_ID)
	REFERENCES ROOM (ID)
;


ALTER TABLE DAYROOM
	ADD FOREIGN KEY (Room_ID)
	REFERENCES ROOM (ID)
;


ALTER TABLE RESERVATION
	ADD FOREIGN KEY (RenewPerson)
	REFERENCES "USER" (ID)
;


ALTER TABLE RESERVATION
	ADD FOREIGN KEY (Reg_Person)
	REFERENCES "USER" (ID)
;



/* Create Triggers */


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

CREATE OR REPLACE TRIGGER TRI_PRODUCT_ID BEFORE INSERT ON PRODUCT
FOR EACH ROW
BEGIN
	SELECT SEQ_PRODUCT_ID.nextval
	INTO :new.ID
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_res_group_updates_dayroom after insert on res_group
FOR EACH ROW
BEGIN
	update dayroom set hotel_assign=hotel_assign-:new.hotel_room_count, tour_assign=tour_assign-:new.tour_room_count
  where id=:new.dayroom_id;
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


insert into "USER" values('AM00001', 'kita', sysdate, null, null);
commit;



  select distinct dayroom."Date", aa.* from dayroom, (select fo."Date", sum(fo.tour_room_count), fo.ota_id, fo.dayroom_id from (select dayroom."Date", res_group.*, connectedcompany.ota_id from res_group, reservation, "USER", company, (select * from connection where hotel_id='HC00001') ConnectedCompany, dayroom
  where reservation_id=reservation.id 
  and reservation.reg_person(+)="USER".id 
  and "USER".COMPANY_ID=COMPANY.ID
  and company.id=ConnectedCompany.ota_id
  and dayroom.id=res_group.dayroom_id
  ) fo group by fo."Date", fo.ota_id, fo.dayroom_id) aa where dayroom.id=aa.dayroom_id  and dayroom."Date" between to_date('15/05/10') and to_date('15/05/10')+14 order by dayroom."Date";
  

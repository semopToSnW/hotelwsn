
DROP TRIGGER TRI_MESSAGE_id;
DROP TABLE MESSAGE CASCADE CONSTRAINTS;
DROP SEQUENCE SEQ_MESSAGE_id;
CREATE SEQUENCE SEQ_MESSAGE_id INCREMENT BY 1 START WITH 1;
CREATE TABLE MESSAGE
(
	id number NOT NULL,
	title varchar2(300) NOT NULL,
	content varchar2(3000),
	"file" blob,
	filename varchar2(300),
	contentType varchar2(30),
	"to" varchar2(50) NOT NULL,
	"from" varchar2(50) NOT NULL,
	inputdate date default sysdate NOT NULL,
	PRIMARY KEY (id)
);

ALTER TABLE MESSAGE
	ADD FOREIGN KEY ("to")
	REFERENCES COMPANY (ID)
;


ALTER TABLE MESSAGE
	ADD FOREIGN KEY ("from")
	REFERENCES COMPANY (ID)
;

CREATE OR REPLACE TRIGGER TRI_MESSAGE_id BEFORE INSERT ON MESSAGE
FOR EACH ROW
BEGIN
	SELECT SEQ_MESSAGE_id.nextval
	INTO :new.id
	FROM dual;
END;

/

/* Drop Triggers */

DROP TRIGGER TRI_CONNECTION_ID;
DROP TRIGGER TRI_DayRoom_ID;
DROP TRIGGER TRI_Image_ID;
DROP TRIGGER TRI_PRODUCT_ID;
DROP TRIGGER TRI_Rank_ID;
DROP TRIGGER TRI_RESERVATION_ID;
DROP TRIGGER TRI_RES_GROUP_ID;
DROP TRIGGER TRI_ROOM_ID;


/* Drop Tables */

DROP TABLE RES_GROUP CASCADE CONSTRAINTS;
DROP TABLE STATUS CASCADE CONSTRAINTS;
DROP TABLE RESERVATION CASCADE CONSTRAINTS;
DROP TABLE "USER" CASCADE CONSTRAINTS;
DROP TABLE DAYROOM CASCADE CONSTRAINTS;
DROP TABLE RANK CASCADE CONSTRAINTS;
DROP TABLE ROOM CASCADE CONSTRAINTS;
DROP TABLE CONNECTION CASCADE CONSTRAINTS;
DROP TABLE Image CASCADE CONSTRAINTS;
DROP TABLE PRODUCT CASCADE CONSTRAINTS;
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
DROP SEQUENCE SEQ_STATUS_id;




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
CREATE SEQUENCE SEQ_STATUS_id INCREMENT BY 1 START WITH 1;



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
	product_id number,
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

CREATE TABLE STATUS
(
	id number NOT NULL,
	status_name varchar2(20) NOT NULL,
	reservation_ID number NOT NULL,
	PRIMARY KEY (id)
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

ALTER TABLE OLD_RES_GROUP
	ADD FOREIGN KEY (PRODUCT_ID)
	REFERENCES PRODUCT (ID)
;

ALTER TABLE RES_GROUP
	ADD FOREIGN KEY (Reservation_ID)
	REFERENCES RESERVATION (ID)
;
ALTER TABLE RES_GROUP
	ADD FOREIGN KEY (product_id)
	REFERENCES product (ID)
;

ALTER TABLE OLD_RES_GROUP
	ADD FOREIGN KEY (DAYROOM_ID)
	REFERENCES OLD_DAYROOM (ID)
;


ALTER TABLE OLD_RES_GROUP
	ADD FOREIGN KEY (RESERVATION_ID)
	REFERENCES OLD_RESERVATION (ID)
;

ALTER TABLE STATUS
	ADD FOREIGN KEY (reservation_ID)
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
ALTER TABLE OLD_RESERVATION
	ADD FOREIGN KEY (Reg_Person)
	REFERENCES USER (ID)
;


/* Create Triggers */
CREATE OR REPLACE TRIGGER TRI_OLD_DAYROOM_ID BEFORE INSERT ON OLD_DAYROOM
FOR EACH ROW
BEGIN
	SELECT SEQ_OLD_DAYROOM_ID.nextval
	INTO :new.ID
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_STATUS_INSERT BEFORE INSERT ON RESERVATION
FOR EACH ROW
BEGIN
	INSERT INTO STATUS(RESERVATION_ID, STATUS_NAME)
	VALUES(:new.id,'예약');
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

CREATE OR REPLACE TRIGGER TRI_STATUS_id BEFORE INSERT ON STATUS
FOR EACH ROW
BEGIN
	SELECT SEQ_STATUS_id.nextval
	INTO :new.id
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

CREATE OR REPLACE TRIGGER TRI_trnasfer_old_dayroom after insert on old_dayroom
FOR EACH ROW
BEGIN
	insert into old_reservation
  (id, checkin, checkout, persons, regdate, renewdate, stayperson, res_person, nation, phone, memo, reg_person, renewPerson, status)
  select reservation.*, status.status_name from status, reservation, old_dayroom, res_group 
  where old_dayroom.id=res_group.dayroom_id and res_group.reservation_id=reservation.id and status.RESERVATION_ID=reservation.id;
END;

/

CREATE OR REPLACE TRIGGER TRI_trnasfer_OLD_RES_GROUP after insert on OLD_RES_GROUP
FOR EACH ROW
BEGIN
	insert into OLD_RES_GROUP
(id, dayroom_id, reservation_id, hotel_room_count, tour_room_count, price, product_id)
select res_group.* from res_group, old_dayroom where res_group.dayroom_id=old_dayroom.id;
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
  
  
  /*지난 데이터 넣는 쿼리 dayroom*/
insert into old_dayroom
(id, "Date", hotel_assign, tour_assign, price, hotel_onoff, tour_onoff, rank_type, room_type) 
select dayroom.id, dayroom."Date", dayroom.hotel_assign, dayroom.tour_assign, dayroom.price, dayroom.hotel_onoff, dayroom.tour_onoff, dayroom.rank_type, room.type
from dayroom, room where dayROOM."Date"<to_char(to_date(sysdate, 'YYYY.fmmm,fmfmdd')-1) and dayroom.room_id=room.id AND room.hotel_id='HC00001';

/*old_reservation*/
insert into old_reservation
(id, checkin, checkout, persons, regdate, renewdate, stayperson, res_person, nation, phone, memo, reg_person, renewPerson, status)
select reservation.*, status.status_name from status, reservation, old_dayroom, res_group 
where old_dayroom.id=res_group.dayroom_id and res_group.reservation_id=reservation.id and status.RESERVATION_ID=reservation.id;

/*old res_group*/
insert into OLD_RES_GROUP
(id, dayroom_id, reservation_id, hotel_room_count, tour_room_count, price, product_id)
select res_group.* from res_group, old_dayroom where res_group.dayroom_id=old_dayroom.id;



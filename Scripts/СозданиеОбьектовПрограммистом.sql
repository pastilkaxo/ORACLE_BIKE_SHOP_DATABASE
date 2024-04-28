ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

---  --------------------- TABLESPACES FOR TABLES: ---------------------
-- USERS
CREATE TABLESPACE TS_USER
    DATAFILE 'C:\Tablecpaces\CourseWork\TS_USER.dbf'
    size 50M
    autoextend on next 5M
    extent management local;

-- ORDERS

CREATE TABLESPACE TS_ORDER
    DATAFILE 'C:\Tablecpaces\CourseWork\TS_ORDER.dbf'
    size 50M
    autoextend on next 5M
    extent management local;

-- CART

CREATE TABLESPACE TS_CART
    DATAFILE 'C:\Tablecpaces\CourseWork\TS_CART.dbf'
    size 50M
    autoextend on next 5M
    extent management local;

CREATE TABLESPACE TS_BIKE 
    DATAFILE 'C:\Tablecpaces\CourseWork\TS_BIKE.dbf'
    SIZE 50M
    AUTOEXTEND ON NEXT 5M
    EXTENT MANAGEMENT LOCAL;
    
    
    ALTER USER DEVELOPER QUOTA UNLIMITED ON  TS_USER;
    ALTER USER DEVELOPER QUOTA UNLIMITED ON  TS_BIKE;
    ALTER USER DEVELOPER QUOTA UNLIMITED ON  TS_ORDER;
    ALTER USER DEVELOPER QUOTA UNLIMITED ON  TS_CART;
    
 -- DROP TABLESPACE TS_BIKE
 -- DROP TABLESPACE TS_USER  
 -- DROP TABLESPACE TS_ORDER
 -- DROP TABLESPACE TS_CART
--      -----------------       TABLES           ---------------


CREATE TABLE ROLES (
ROLE_ID INTEGER  GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
ROLENAME NVARCHAR2(255)
) TABLESPACE TS_USER;


CREATE TABLE USERS (
USER_ID INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
USER_NAME NVARCHAR2(255) NOT NULL,
USER_SURNAME NVARCHAR2(255) NOT NULL,
USER_FATHERNAME NVARCHAR2(255),
USER_EMAIL NVARCHAR2(255) NOT NULL,
PASSWORD NVARCHAR2(255) NOT NULL,
DATE_OF_BIRTH DATE,
ADRESS NVARCHAR2(255) NOT NULL,
ROLE_ID INTEGER NOT NULL,
CONSTRAINT FK_USER_ROLE FOREIGN KEY(ROLE_ID) REFERENCES ROLES(ROLE_ID) 
) TABLESPACE TS_USER;

CREATE TABLE CATEGORIES(
CATEGORY_ID INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
CAT_NAME VARCHAR2(255) NOT NULL,
CONSTRAINT CHECK_CAT CHECK(CAT_NAME = 'MTB' OR CAT_NAME = 'BMX' OR CAT_NAME = 'MOUNTAINT' OR CAT_NAME='KID' OR CAT_NAME = 'DEFAULT')
) TABLESPACE TS_BIKE;

CREATE TABLE BIKES(
BIKE_ID INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
SELLER_ID INTEGER NOT NULL,
BIKE_NAME NVARCHAR2(255) NOT NULL,
PRICE DECIMAL(10,2) NOT NULL,
CATEGORY_ID INTEGER NOT NULL,
CONSTRAINT FK_BIKE_SELLER FOREIGN KEY(SELLER_ID) REFERENCES USERS(USER_ID),
CONSTRAINT FK_BIKE_CATEGORY FOREIGN KEY(CATEGORY_ID) REFERENCES CATEGORIES(CATEGORY_ID)
) TABLESPACE TS_BIKE;


CREATE TABLE DESCRIPTIONS(
DESC_ID INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
BIKE_ID INTEGER NOT NULL,
BIKE_DESC NVARCHAR2(2000) NOT NULL,
BIKE_TYPE NVARCHAR2(100),
MATERIAL NVARCHAR2(50),
WEIGHT FLOAT(5),
HEIGHT FLOAT(5),
CONSTRAINT FK_DESC_BIKE FOREIGN KEY(BIKE_ID) REFERENCES BIKES(BIKE_ID)
) TABLESPACE TS_BIKE;

CREATE TABLE RATINGS(
RATING_ID INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
BIKE_ID INTEGER NOT NULL,
USER_ID INTEGER NOT NULL,
RATING_VALUE NUMBER(2) NOT NULL ,
RATING_MESSAGE NVARCHAR2(100) NOT NULL,
TIME_STAMP TIMESTAMP NOT NULL,
CONSTRAINT FK_RATE_BIKE FOREIGN KEY(BIKE_ID) REFERENCES BIKES(BIKE_ID),
CONSTRAINT FK_RATE_USER FOREIGN KEY(USER_ID) REFERENCES USERS(USER_ID)
) TABLESPACE TS_BIKE;

CREATE TABLE CART(
CART_ID INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
USER_ID INTEGER NOT NULL,
BIKE_ID INTEGER NOT NULL,
QUANTITY NUMBER(6) NOT NULL,
CONSTRAINT FK_CART_USER FOREIGN KEY(USER_ID) REFERENCES USERS(USER_ID),
CONSTRAINT FK_CART_BIKE FOREIGN KEY(BIKE_ID) REFERENCES BIKES(BIKE_ID)
) TABLESPACE TS_CART;

CREATE TABLE ORDERS (
ORDER_ID INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
BUYER_ID INTEGER NOT NULL,
BIKE_ID INTEGER NOT NULL,
QUANTITY NUMBER(6) NOT NULL,
ORDER_DATE DATE NOT NULL,
STATUS NVARCHAR2(40) NOT NULL,
CONSTRAINT FK_ORDER_BIKE FOREIGN KEY(BIKE_ID) REFERENCES BIKES(BIKE_ID),
CONSTRAINT FK_ORDER_BUYER FOREIGN KEY(BUYER_ID) REFERENCES USERS(USER_ID),
CONSTRAINT STATUS_CHECK CHECK(STATUS = 'IN WAY' OR STATUS = 'ARRIVED' OR STATUS = 'COMPLETED' OR STATUS = 'IN ASSEMBLY')
) TABLESPACE TS_ORDER;

--DROP TABLE ROLES; 8
--DROP TABLE USERS; 7
--DROP TABLE BIKES; 5
--DROP TABLE CATEGORIES; 6
--DROP TABLE DESCRIPTIONS; 4
--DROP TABLE RATINGS; 3
--DROP TABLE CART; 2
--DROP TABLE ORDERS; 1



-- -------------------------- USERS_ROLES ----------------------------------

CREATE ROLE USER_ROLE;

GRANT 
CONNECT,
CREATE SESSION
TO USER_ROLE;

CREATE ROLE MANAGER_ROLE;

-- DROP ROLE USER_ROLE;
-- DROP ROLE MANAGER_ROLE
-- -------------------------- USERS_CREATES ----------------------------------
CREATE USER USER_1 IDENTIFIED BY 123;
CREATE USER MANAGER IDENTIFIED BY 123;

-- DROP USER USER_1;
-- DROP USER MANAGER;
-- -------------------------- PROCEDURES/FUNCTIONS ----------------------------------

-- FUNCTIONS.SQL
-- PROCEDURES.SQL


-- -----------------    VIES: ----------------------------

-- VIEWS.SQL


-- -----------------    TRIGGERS: ----------------------------

-- TRIGGERS.SQL


-- INDEXES

-- JSON IMPORT/EXPORT:

-- 100K LINES






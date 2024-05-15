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
ROLENAME VARCHAR2(255)
) TABLESPACE TS_USER;


CREATE TABLE USERS (
USER_ID INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
USER_NAME VARCHAR2(255) NOT NULL,
USER_SURNAME VARCHAR2(255) NOT NULL,
USER_FATHERNAME VARCHAR2(255),
USER_EMAIL VARCHAR2(255) NOT NULL,
PASSWORD NVARCHAR2(255) NOT NULL,
DATE_OF_BIRTH TIMESTAMP(6),
ADRESS VARCHAR2(255) NOT NULL,
ROLE_ID INTEGER NOT NULL,
CONSTRAINT FK_USER_ROLE FOREIGN KEY(ROLE_ID) REFERENCES ROLES(ROLE_ID) 
) TABLESPACE TS_USER;

CREATE TABLE CATEGORIES(
CATEGORY_ID INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
CAT_NAME VARCHAR2(255) NOT NULL,
CONSTRAINT CHECK_CAT CHECK(CAT_NAME = 'MTB' OR CAT_NAME = 'BMX' OR CAT_NAME = 'MOUNTAIN' OR CAT_NAME='KID' OR CAT_NAME = 'DEFAULT')
) TABLESPACE TS_BIKE;

CREATE TABLE BIKES(
BIKE_ID INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
SELLER_ID INTEGER NOT NULL,
BIKE_NAME VARCHAR2(255) NOT NULL,
PRICE DECIMAL(10,2) NOT NULL,
CATEGORY_ID INTEGER NOT NULL,
CONSTRAINT FK_BIKE_SELLER FOREIGN KEY(SELLER_ID) REFERENCES USERS(USER_ID),
CONSTRAINT FK_BIKE_CATEGORY FOREIGN KEY(CATEGORY_ID) REFERENCES CATEGORIES(CATEGORY_ID)
) TABLESPACE TS_BIKE;

CREATE TABLE DESCRIPTIONS(
DESC_ID INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
BIKE_ID INTEGER NOT NULL,
BIKE_DESC VARCHAR2(2000) NOT NULL,
BIKE_TYPE VARCHAR2(100),
MATERIAL VARCHAR2(50),
WEIGHT FLOAT(5),
HEIGHT FLOAT(5),
CONSTRAINT FK_DESC_BIKE FOREIGN KEY(BIKE_ID) REFERENCES BIKES(BIKE_ID)
) TABLESPACE TS_BIKE;

CREATE TABLE RATINGS(
RATING_ID INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
BIKE_ID INTEGER NOT NULL,
USER_ID INTEGER NOT NULL,
RATING_VALUE NUMBER(2) NOT NULL ,
RATING_MESSAGE VARCHAR2(100) NOT NULL,
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
ORDER_DATE TIMESTAMP(6) NOT NULL,
STATUS VARCHAR2(40) NOT NULL,
CONSTRAINT FK_ORDER_BIKE FOREIGN KEY(BIKE_ID) REFERENCES BIKES(BIKE_ID),
CONSTRAINT FK_ORDER_BUYER FOREIGN KEY(BUYER_ID) REFERENCES USERS(USER_ID)
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
/*
CREATE ROLE USER_ROLE;

GRANT execute on ADD_BIKE TO USER_ROLE;
GRANT EXECUTE ON REGISTER TO USER_ROLE;

CREATE ROLE MANAGER_ROLE;
*/
-- DROP ROLE USER_ROLE;
-- DROP ROLE MANAGER_ROLE
-- -------------------------- USERS_CREATES ----------------------------------
CREATE USER USER_1 IDENTIFIED BY 123;
CREATE USER MANAGER IDENTIFIED BY 123;

-- DROP USER USER_1;
-- DROP USER MANAGER;

-- -------------------------- GRANTS TO USER ----------------------------------
GRANT SESSION_PRIV TO USER_1;
GRANT  EXECUTE ON REGISTER TO USER_1;
GRANT  EXECUTE ON LOGIN TO USER_1;
GRANT  EXECUTE ON ADD_BIKE TO USER_1;
GRANT  EXECUTE ON ADD_DESC TO USER_1;
GRANT  EXECUTE ON ADD_ORDER TO USER_1;
GRANT  EXECUTE ON UPDATE_USER TO USER_1;
GRANT  EXECUTE ON ADD_RATE TO USER_1;
GRANT  EXECUTE ON ADD_TO_CART TO USER_1;
GRANT  EXECUTE ON DEL_FROM_CART TO USER_1;
GRANT  EXECUTE ON UPDATE_PASS TO USER_1;
GRANT  EXECUTE ON UPDATE_BIKE TO USER_1;
GRANT  EXECUTE ON DEL_BIKE TO USER_1;
GRANT  EXECUTE ON CLEAR_CART TO USER_1;
GRANT  EXECUTE ON CLEAR_ORDER TO USER_1;
GRANT  EXECUTE ON UPDATE_ORDER TO USER_1;
GRANT  EXECUTE ON DEL_ORDER TO USER_1;
GRANT  EXECUTE ON DEL_DESC TO USER_1;
GRANT  EXECUTE ON UPD_DESC TO USER_1;
GRANT  EXECUTE ON DEL_RATE TO USER_1;
GRANT  EXECUTE ON UPD_RATE TO USER_1;
GRANT  EXECUTE ON DEL_FROM_CART TO USER_1;
GRANT EXECUTE ON AVG_RATE TO USER_1;

-- SORTS AND GETS
GRANT EXECUTE ON SORT_BIKE_BY_CATEGORY TO USER_1;
GRANT EXECUTE ON SORT_BIKE_BY_DESC TO USER_1; 
GRANT EXECUTE ON SORT_BIKE_BY_HEIGHT TO USER_1;
GRANT EXECUTE ON SORT_BIKE_BY_MATERIAL TO USER_1;
GRANT EXECUTE ON SORT_BIKE_BY_NAME TO USER_1;
GRANT EXECUTE ON SORT_BIKE_BY_PRICE TO USER_1;
GRANT EXECUTE ON SORT_BIKE_BY_RATE TO USER_1;
GRANT EXECUTE ON SORT_BIKE_BY_SELLER TO USER_1;
GRANT EXECUTE ON SORT_BIKE_BY_TYPE TO USER_1;
GRANT EXECUTE ON SORT_BIKE_BY_WEIGHT TO USER_1;
GRANT EXECUTE ON SORT_ORDER_BY_DATE TO USER_1;
GRANT EXECUTE ON SORT_ORDER_BY_ID TO USER_1;
GRANT EXECUTE ON SORT_ORDER_BY_QNT TO USER_1;
GRANT EXECUTE ON SORT_ORDER_BY_STATUS TO USER_1;
GRANT EXECUTE ON SORT_USER_BY_BIRTH TO USER_1;
GRANT EXECUTE ON SORT_USER_BY_ID TO USER_1;
GRANT EXECUTE ON SORT_USER_BY_NAME TO USER_1;
GRANT EXECUTE ON SORT_USER_BY_SURNAME TO USER_1;

-- GET ALL INFO
GRANT EXECUTE ON GETUSERS TO USER_1;
GRANT EXECUTE ON GETBIKES TO USER_1;
GRANT EXECUTE ON GETORDERS TO USER_1;
-- VIEWS
GRANT SELECT ON USER_V TO USER_1;
GRANT SELECT ON BIKE_V TO USER_1;
GRANT SELECT ON CART_V TO USER_1;
GRANT SELECT ON ORDER_V TO USER_1;

-- FULL TEXT SEARCH
GRANT EXECUTE ON CONTAINS_BIKE TO USER_1;
GRANT EXECUTE ON CONTAINS_USER_BY_NAME TO USER_1;
GRANT EXECUTE ON CONTAINS_USER_BY_SURNAME TO USER_1;
GRANT EXECUTE ON CONTAINS_USER_BY_FATHERNAME TO USER_1;
GRANT EXECUTE ON CONTAINS_USER_BY_EMAIL TO USER_1;
GRANT EXECUTE ON CONTAINS_USER_BY_ADRESS TO USER_1;
GRANT EXECUTE ON CONTAINS_RATING_MESSAGE TO USER_1;

GRANT EXECUTE ON MATCH_DESC TO USER_1;
GRANT EXECUTE ON MATCHES_TYPE TO USER_1;
GRANT EXECUTE ON MATCHES_RATEMSG TO USER_1;

-- ����� ������

GRANT EXECUTE ON SEARCH_USER_BY_NAME TO USER_1;
GRANT EXECUTE ON SEARCH_USER_BY_SURNAME TO USER_1;
GRANT EXECUTE ON SEARCH_USER_BY_BIRTH TO USER_1;
GRANT EXECUTE ON SEARCH_USER_BY_ID TO USER_1;
GRANT EXECUTE ON SEARCH_BIKE_BY_ID TO USER_1;
GRANT EXECUTE ON SEARCH_BIKE_BY_NAME TO USER_1;
GRANT EXECUTE ON SEARCH_ORDER_BY_ID TO USER_1;

-- -------------------------- GRANTS TO MANAGER ----------------------------------


GRANT SESSION_PRIV TO MANAGER;
GRANT EXECUTE ON USER_PKG_FUNCS TO MANAGER;
GRANT EXECUTE ON USER_PKG_PROC TO MANAGER;
-- SORTS AND GETS

GRANT EXECUTE ON SORT_BIKE_BY_CATEGORY TO MANAGER;
GRANT EXECUTE ON SORT_BIKE_BY_DESC TO MANAGER; 
GRANT EXECUTE ON SORT_BIKE_BY_HEIGHT TO MANAGER;
GRANT EXECUTE ON SORT_BIKE_BY_MATERIAL TO MANAGER;
GRANT EXECUTE ON SORT_BIKE_BY_NAME TO MANAGER;
GRANT EXECUTE ON SORT_BIKE_BY_PRICE TO MANAGER;
GRANT EXECUTE ON SORT_BIKE_BY_RATE TO MANAGER;
GRANT EXECUTE ON SORT_BIKE_BY_SELLER TO MANAGER;
GRANT EXECUTE ON SORT_BIKE_BY_TYPE TO MANAGER;
GRANT EXECUTE ON SORT_BIKE_BY_WEIGHT TO MANAGER;
GRANT EXECUTE ON SORT_ORDER_BY_DATE TO MANAGER;
GRANT EXECUTE ON SORT_ORDER_BY_ID TO MANAGER;
GRANT EXECUTE ON SORT_ORDER_BY_QNT TO MANAGER;
GRANT EXECUTE ON SORT_ORDER_BY_STATUS TO MANAGER;
GRANT EXECUTE ON SORT_USER_BY_BIRTH TO MANAGER;
GRANT EXECUTE ON SORT_USER_BY_ID TO MANAGER;
GRANT EXECUTE ON SORT_USER_BY_NAME TO MANAGER;
GRANT EXECUTE ON SORT_USER_BY_SURNAME TO MANAGER;
-- GET ALL INFO
GRANT EXECUTE ON GETBIKEBYID TO MANAGER;
GRANT EXECUTE ON GETUSERBYID TO MANAGER;
GRANT EXECUTE ON GETORDERBYID TO MANAGER;
GRANT EXECUTE ON GETUSERS TO MANAGER;
GRANT EXECUTE ON GETBIKES TO MANAGER;
GRANT EXECUTE ON GETORDERS TO MANAGER;
-- VIEWS
GRANT SELECT ON USER_V TO MANAGER;
GRANT SELECT ON BIKE_V TO MANAGER;
GRANT SELECT ON CART_V TO MANAGER;
GRANT SELECT ON ORDER_V TO MANAGER;

-- FULL TEXT SEARCH
GRANT EXECUTE ON CONTAINS_BIKE TO MANAGER;
GRANT EXECUTE ON CONTAINS_USER_BY_NAME TO MANAGER;
GRANT EXECUTE ON CONTAINS_USER_BY_SURNAME TO MANAGER;
GRANT EXECUTE ON CONTAINS_USER_BY_FATHERNAME TO MANAGER;
GRANT EXECUTE ON CONTAINS_USER_BY_EMAIL TO MANAGER;
GRANT EXECUTE ON CONTAINS_USER_BY_ADRESS TO MANAGER;
GRANT EXECUTE ON CONTAINS_RATING_MESSAGE TO MANAGER;

GRANT EXECUTE ON MATCH_DESC TO MANAGER;
GRANT EXECUTE ON MATCHES_TYPE TO MANAGER;
GRANT EXECUTE ON MATCHES_RATEMSG TO MANAGER;


-- -------------------------- PROCEDURES/FUNCTIONS ----------------------------------

-- FUNCTIONS.SQL
-- PROCEDURES.SQL


-- -----------------    VIES: ----------------------------

-- VIEWS.SQL


-- -----------------    TRIGGERS: ----------------------------

-- TRIGGERS.SQL

------------------------ INDEXES: --------------------------

-- INDEXES.SQL


--------------------------------------------------
-- 100K LINES


CREATE OR REPLACE PROCEDURE INSERT_100K_LINES 
IS
    v_start_date DATE := TO_DATE('1980-01-01', 'YYYY-MM-DD');
    v_end_date DATE := TO_DATE('2004-01-01', 'YYYY-MM-DD'); 
BEGIN
    FOR i IN 1..100000 LOOP
        INSERT INTO USERS (
            USER_NAME,
            USER_SURNAME,
            USER_FATHERNAME,
            USER_EMAIL,
            PASSWORD,
            DATE_OF_BIRTH,
            ADRESS,
            ROLE_ID
        ) VALUES (
            'User'||i,
            'Surname'||i,
            'Fathername'||i,
            'user'||i||'@example.com',
            HASH_PASS('password'||i),
            v_start_date + DBMS_RANDOM.VALUE * (v_end_date - v_start_date), 
            'Address'||i,
            ROUND(DBMS_RANDOM.VALUE(1, 2))
        );
    END LOOP;
    COMMIT;
END;

BEGIN
    INSERT_100K_LINES();
END;

INSERT INTO CATEGORIES(CAT_NAME) VALUES('BMX');
INSERT INTO CATEGORIES(CAT_NAME) VALUES('MTB');
INSERT INTO CATEGORIES(CAT_NAME) VALUES('MOUNTAIN');
INSERT INTO CATEGORIES(CAT_NAME) VALUES('DEFAULT');
INSERT INTO CATEGORIES(CAT_NAME) VALUES('KID');

 INSERT INTO ROLES(ROLENAME) VALUES('USER');
 INSERT INTO ROLES(ROLENAME) VALUES('MANAGER');
 
 
 BEGIN
    DBMS_OUTPUT.PUT_LINE(REGISTER('ADMIN','ADMIN','ADMIN','BIKESHOP@GMAIL.COM','ADMIN',SYSDATE,'BIKESHOP',2));
 END;

SELECT * FROM USERS



SET TIMING ON;
SELECT * FROM USER_V WHERE USER_V.USER_EMAIL = 'user94025@example.com';
SET TIMING OFF;

SELECT * FROM CATEGORIES;



-- TYPES;



-- USER TYPE

CREATE OR REPLACE TYPE USER_INFO AS OBJECT  (
USER_ID INTEGER ,
USER_NAME NVARCHAR2(255),
USER_SURNAME NVARCHAR2(255),
USER_FATHERNAME NVARCHAR2(255),
USER_EMAIL NVARCHAR2(255),
PASSWORD NVARCHAR2(255),
DATE_OF_BIRTH DATE,
ADRESS NVARCHAR2(255) ,
ROLE_NAME NVARCHAR2(255) 
);

CREATE OR REPLACE TYPE  USER_TABLE_RESULT AS TABLE OF USER_INFO;

--DROP TYPE USER_INFO;
--DROP TYPE USER_TABLE_RESULT;


-- BIKE TYPE

CREATE OR REPLACE TYPE BIKE_INFO AS OBJECT (
BIKE_ID INTEGER ,
SELLER_ID INTEGER ,
BIKE_NAME NVARCHAR2(255) ,
PRICE DECIMAL(10,2) ,
CATEGORY_ID INTEGER,
AVG_RATE DECIMAL,
BIKE_DESC NVARCHAR2(2000),
BIKE_TYPE NVARCHAR2(100),
MATERIAL NVARCHAR2(50),
WEIGHT FLOAT(5),
HEIGHT FLOAT(5)
);

CREATE OR REPLACE TYPE BIKE_TABLE_RESULT AS TABLE OF BIKE_INFO;

-- DROP TYPE BIKE_INFO
-- DROP TYPE BIKE_TABLE_RESULT;


-- ORDER TYPE:


CREATE OR REPLACE TYPE ORDER_INFO AS OBJECT (
ORDER_ID INTEGER ,
BUYER_ID INTEGER ,
BIKE_ID INTEGER ,
QUANTITY NUMBER(6),
ORDER_DATE DATE ,
STATUS NVARCHAR2(40),
USERNAME NVARCHAR2(255),
SURNAME NVARCHAR2(255),
ADRESS NVARCHAR2(255)
);

CREATE OR REPLACE TYPE ORDER_RESULT_TABLE AS TABLE OF ORDER_INFO;

-- DROP TYPE ORDER_INFO;
-- DROP TYPE ORDER_RESULT_TABLE;




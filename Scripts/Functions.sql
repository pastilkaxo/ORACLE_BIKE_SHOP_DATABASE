-- FUNCTIONS:

/*
CREATE SEQUENCE ORDER_ID
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 100000;
DROP SEQUENCE ORDER_ID;
*/

-- AVERAGE RATING

CREATE OR REPLACE FUNCTION AVG_RATE
    (
    BIKE IN INTEGER
    )
    RETURN DECIMAL
IS
        CURSOR RATE_CURS IS SELECT RATING_VALUE FROM RATINGS WHERE BIKE_ID = BIKE;
        RATE RATINGS%ROWTYPE;
        CNT NUMBER := 0;
        SUM_RATE NUMBER := 0;
        AVG_RATE DECIMAL;
BEGIN
    FOR RATE IN RATE_CURS
    LOOP
       SUM_RATE := SUM_RATE + RATE.RATING_VALUE;
       CNT := CNT + 1;
    END LOOP;
    IF CNT > 0 THEN
        AVG_RATE := SUM_RATE / CNT;
    ELSE 
        AVG_RATE := 0;
    END IF;
    RETURN AVG_RATE;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN 0; 
        WHEN TOO_MANY_ROWS THEN
        RETURN 0;
        WHEN OTHERS 
        THEN RETURN 0;
END;

BEGIN
    DBMS_OUTPUT.PUT_LINE(AVG_RATE(2));
END;

-- ENCRYPT PASS

CREATE OR REPLACE FUNCTION HASH_PASS
    (PASSWORD IN NVARCHAR2)
    RETURN NVARCHAR2
IS
BEGIN
    IF PASSWORD IS NULL OR LENGTH(PASSWORD) > 20  THEN 
        RETURN 'FALSE'; 
    ELSE
        RETURN DBMS_CRYPTO.HASH(UTL_I18N.STRING_TO_RAW(PASSWORD,'AL32UTF8'),DBMS_CRYPTO.HASH_SH256);    
    END IF;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN 'FALSE'; 
        WHEN TOO_MANY_ROWS THEN
        RETURN 'FALSE';
        WHEN OTHERS 
        THEN RETURN 'FALSE';
END;

begin
dbms_output.put_line(HASH_PASS('123'));
end;



-- REGISTER
    
CREATE OR REPLACE FUNCTION REGISTER
    (
        NAME IN NVARCHAR2 ,
        SURNAME IN NVARCHAR2 ,
        FATHERNAME IN NVARCHAR2,
        EMAIL IN NVARCHAR2,
        PASSWORD IN NVARCHAR2,
        BIRTH IN DATE,
        USER_ADRESS IN NVARCHAR2,
        ROLE IN INTEGER 
    )
    RETURN INTEGER
IS
    ID INTEGER;
BEGIN
    INSERT INTO USERS(USER_NAME,USER_SURNAME,USER_FATHERNAME,USER_EMAIL,PASSWORD,DATE_OF_BIRTH,ADRESS,ROLE_ID)
    VALUES (NAME , SURNAME ,FATHERNAME,EMAIL,HASH_PASS(PASSWORD),BIRTH,USER_ADRESS,ROLE)
    RETURNING USERS.USER_ID INTO ID;
    RETURN ID;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN 0; 
        WHEN TOO_MANY_ROWS THEN
        RETURN 0;
        WHEN OTHERS 
        THEN RETURN 0;
END;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE(REGISTER('NIKITA','TURCHINOVICH','ALEX','NIKITA.TURCH@GMAIL.COM' , 'ABCD' , '25-05-2004','mINSK' , 1));
END;

-- LOGIN

CREATE OR REPLACE FUNCTION LOGIN
    (
        EMAIL IN NVARCHAR2,
        PASS IN NVARCHAR2
    )
    RETURN INTEGER
IS
    USER USERS%ROWTYPE;
BEGIN
    SELECT * INTO USER FROM USERS  WHERE PASSWORD = HASH_PASS(PASS) AND USER_EMAIL = EMAIL;
    IF PASS IS NULL
        THEN RETURN 0;
    ELSIF USER.USER_ID IS NOT NULL
        THEN
            RETURN USER.USER_ID;
    ELSE 
        RETURN 0;
    END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN 0; 
        WHEN TOO_MANY_ROWS THEN
        RETURN 0;
        WHEN OTHERS 
        THEN RETURN 0;
END;

BEGIN
    DBMS_OUTPUT.PUT_LINE(LOGIN('VLAD.LEMESHOK@GMAIL.COM','12345'));
END;


-- ADD BIKE  

    CREATE OR REPLACE FUNCTION ADD_BIKE 
    (
    SELLER IN INTEGER,
    NAME IN NVARCHAR2,
    PRICE IN DECIMAL,
    CATEGORY  IN INTEGER
    )
    RETURN INTEGER
    IS
    ID BIKES.BIKE_ID%TYPE;
    BEGIN
    INSERT INTO BIKES(SELLER_ID,BIKE_NAME,PRICE,CATEGORY_ID) VALUES(SELLER,NAME , PRICE , CATEGORY )
    RETURNING BIKES.BIKE_ID INTO ID;
    RETURN ID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN 0; 
        WHEN TOO_MANY_ROWS THEN
        RETURN 0;
        WHEN OTHERS 
        THEN RETURN 0;
    END;

BEGIN
    DBMS_OUTPUT.PUT_LINE(ADD_BIKE(2, 'BIKE 131', 1090.99, 1));
END;



-- ADD DESCRIPTION

    CREATE OR REPLACE FUNCTION ADD_DESC
    (
    BIKE IN INTEGER ,
    DESCR IN NVARCHAR2,
    TYPE IN NVARCHAR2,
    MAT IN NVARCHAR2,
    W IN FLOAT,
    H IN FLOAT
    )
    RETURN INTEGER
    IS
    ID DESCRIPTIONS.DESC_ID%TYPE;
    BEGIN
    INSERT INTO DESCRIPTIONS(BIKE_ID,BIKE_DESC,BIKE_TYPE,MATERIAL,WEIGHT,HEIGHT) VALUES(BIKE,DESCR,TYPE,MAT,W,H)
    RETURNING DESCRIPTIONS.DESC_ID INTO ID;
    RETURN ID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN 0; 
        WHEN TOO_MANY_ROWS THEN
        RETURN 0;
        WHEN OTHERS 
        THEN RETURN 0;
    END;

BEGIN
    DBMS_OUTPUT.PUT_LINE(ADD_DESC(2,'BRAND1123123 NEW!','STREET' , 'STEEL' , 8,20));
END;



-- ADD CATEGORY
    
    CREATE OR REPLACE FUNCTION ADD_CATEGORY
    (
    NAME IN VARCHAR2
    )
    RETURN NUMBER
    IS
    ID CATEGORIES.CATEGORY_ID%TYPE;
    BEGIN
    IF NAME IS NOT NULL
        THEN
            INSERT INTO CATEGORIES(CAT_NAME)VALUES(NAME)
            RETURNING CATEGORIES.CATEGORY_ID INTO ID;
            RETURN ID;
    ELSE
        RETURN 0;
    END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN 0; 
        WHEN TOO_MANY_ROWS THEN
        RETURN 0;
        WHEN OTHERS 
        THEN RETURN 0;
    END;

BEGIN
    DBMS_OUTPUT.PUT_LINE(ADD_CATEGORY('BMX'));
END;


-- ADD ROLE
    
    CREATE OR REPLACE FUNCTION ADD_ROLE
    (
    NAME IN NVARCHAR2
    )
    RETURN INTEGER
    IS
    ID ROLES.ROLE_ID%TYPE;
    BEGIN
     IF NAME IS NOT NULL
        THEN 
            INSERT INTO ROLES(ROLENAME) VALUES (NAME) 
            RETURNING ROLES.ROLE_ID INTO ID;
            RETURN ID;
     ELSE
        RETURN 0;
     END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN 0; 
        WHEN TOO_MANY_ROWS THEN
        RETURN 0;
        WHEN OTHERS 
        THEN RETURN 0;
    END;
    
    BEGIN
        DBMS_OUTPUT.PUT_LINE(ADD_ROLE('USER'));
    END;


-- ADD ORDER

    CREATE OR REPLACE FUNCTION ADD_ORDER 
    (
    BUYER IN INTEGER  ,
    ODATE IN DATE  ,
    STAT IN NVARCHAR2  
    )
    RETURN INTEGER
    IS
        CURSOR CART_CURS IS SELECT BIKE_ID , QUANTITY FROM CART WHERE USER_ID = BUYER;
        ID ORDERS.ORDER_ID%TYPE;
        CART_REC CART%ROWTYPE;
    BEGIN
    FOR CART_REC IN CART_CURS LOOP
        INSERT INTO ORDERS(BUYER_ID,BIKE_ID,QUANTITY,ORDER_DATE,STATUS) VALUES(BUYER,CART_REC.BIKE_ID,CART_REC.QUANTITY,ODATE,STAT)
        RETURNING ORDERS.ORDER_ID INTO ID;
    END LOOP;
        CLEAR_CART(BUYER);
        RETURN ID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN 0; 
        WHEN TOO_MANY_ROWS THEN
        RETURN 0;
        WHEN OTHERS 
        THEN RETURN 0;
    END;

BEGIN
    DBMS_OUTPUT.PUT_LINE(ADD_ORDER(2,'25.04.2004','IN WAY'));
END;

SELECT * FROM ORDERS;
-- UPDATE USER

    CREATE OR REPLACE FUNCTION UPDATE_USER
    (
    UID IN INTEGER ,
    NAME IN NVARCHAR2,
    SURNAME IN NVARCHAR2,
    FATHERNAME IN NVARCHAR2,
    EMAIL IN NVARCHAR2,
    PASS IN NVARCHAR2,
    BIRTH IN DATE,
    ADR IN NVARCHAR2,
    ROLE IN INTEGER 
    )
    RETURN INTEGER
    IS
        ID USERS.USER_ID%TYPE;
    BEGIN
        UPDATE USERS 
        SET USER_NAME = NAME ,
         USER_SURNAME = SURNAME, 
         USER_FATHERNAME = FATHERNAME ,
         USER_EMAIL = EMAIL ,
         PASSWORD = HASH_PASS(PASS) ,
         DATE_OF_BIRTH = BIRTH, 
         ADRESS = ADR ,
         ROLE_ID = ROLE  WHERE USER_ID = UID
        RETURNING USERS.USER_ID INTO ID;
        RETURN ID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN 0; 
        WHEN TOO_MANY_ROWS THEN
        RETURN 0;
        WHEN OTHERS 
        THEN RETURN 0;
    END;

-- ADD RATE

    CREATE OR REPLACE FUNCTION ADD_RATE
    (
    BIKE IN INTEGER ,
    USER IN INTEGER ,
    VALUE IN NUMBER ,
    MESSAGE IN NVARCHAR2 ,
    TIMES IN TIMESTAMP 
    )
    RETURN INTEGER
    IS
        ID RATINGS.RATING_ID%TYPE;
    BEGIN
    IF VALUE > 10 OR VALUE < 0
        THEN RETURN 0;
    ELSE
        INSERT INTO RATINGS(BIKE_ID,USER_ID,RATING_VALUE,RATING_MESSAGE,TIME_STAMP) VALUES(BIKE,USER,VALUE,MESSAGE,TIMES)
        RETURNING RATINGS.RATING_ID INTO ID;
        RETURN ID;
    END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN 0; 
        WHEN TOO_MANY_ROWS THEN
        RETURN 0;
        WHEN OTHERS 
        THEN RETURN 0;
    END;

    BEGIN
        DBMS_OUTPUT.PUT_LINE(ADD_RATE(1,2,6,'NOT BAD!',SYSTIMESTAMP));
    END;


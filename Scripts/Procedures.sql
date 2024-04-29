-- PROCEDURES:

-- UPDATE DB


-- ADD BIKE TO CART 

    CREATE OR REPLACE PROCEDURE ADD_TO_CART
    (
    USER INTEGER ,
    BIKE INTEGER ,
    QNT NUMBER
    )
    IS
        ID CART.CART_ID%TYPE;
    BEGIN
        INSERT INTO CART(USER_ID,BIKE_ID,QUANTITY)VALUES(USER,BIKE,QNT)
        RETURNING CART.CART_ID INTO ID;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN TOO_MANY_ROWS THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN OTHERS 
        THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END;

BEGIN
    ADD_TO_CART(2,2,5);
END;



-- DEL BIKE FROM CART

    CREATE OR REPLACE PROCEDURE DEL_FROM_CART
    (
    USER IN INTEGER ,
    BIKE IN INTEGER 
    )
    IS
        ID CART.CART_ID%TYPE;
    BEGIN
        DELETE FROM CART WHERE USER_ID = USER AND BIKE_ID = BIKE
        RETURNING CART.CART_ID INTO ID;
        EXCEPTION
        WHEN OTHERS
            THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END;
    
    BEGIN
        DEL_FROM_CART(2,3);
    END;



-- UPDATE PASSWORD

    CREATE OR REPLACE PROCEDURE UPDATE_PASS
    (
    USER IN INTEGER,
    EMAIL IN NVARCHAR2,
    PASS IN NVARCHAR2
    )
    IS
        ID USERS.USER_ID%TYPE;
    BEGIN
        UPDATE USERS SET PASSWORD = HASH_PASS(PASS) WHERE USERS.USER_ID = USER AND USER_EMAIL = EMAIL
        RETURNING USERS.USER_ID INTO ID
        ;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN TOO_MANY_ROWS THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN OTHERS 
        THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END;
    
BEGIN
    UPDATE_PASS(1,'VLAD.LEMESHOK@GMAIL.COM','ABCDE');
END;


-- UPDATE BIKE 

      CREATE OR REPLACE PROCEDURE UPDATE_BIKE 
    (
    BIKE IN INTEGER,
    NAME IN NVARCHAR2,
    COST IN DECIMAL,
    CAT IN INTEGER
    )
    IS
    ID BIKES.BIKE_ID%TYPE;
    BEGIN
    UPDATE BIKES SET BIKE_NAME = NAME,PRICE=COST,CATEGORY_ID = CAT WHERE BIKE_ID = BIKE
    RETURNING BIKES.BIKE_ID INTO ID;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM); 
        WHEN TOO_MANY_ROWS THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN OTHERS 
        THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END;

BEGIN
    UPDATE_BIKE(2 , 'BIKE NAME2', 1203 ,1);
END;

SELECT * FROM BIKES

-- DELETE USER

    CREATE OR REPLACE PROCEDURE DEL_USER
    (
        USER IN INTEGER
    )
    IS
        CURSOR USER_BIKES IS SELECT BIKE_ID FROM BIKES WHERE SELLER_ID = USER;
        ID USERS.USER_ID%TYPE;
        BID BIKES%ROWTYPE;
    BEGIN
    FOR BID IN USER_BIKES
    LOOP
        DELETE FROM ORDERS WHERE BUYER_ID = USER;
        DELETE FROM CART WHERE USER_ID =  USER;
        DELETE FROM DESCRIPTIONS WHERE BIKE_ID = BID.BIKE_ID;
        DELETE FROM RATINGS WHERE USER_ID = USER;
        DELETE FROM BIKES WHERE SELLER_ID = USER
        RETURNING BIKES.BIKE_ID INTO BID;
        DELETE FROM USERS WHERE USER_ID = USER
        RETURNING USERS.USER_ID INTO ID;
    END LOOP;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN TOO_MANY_ROWS THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN OTHERS 
        THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END;

    BEGIN
        DEL_USER(1);
    END;
-- DELETE BIKE

    CREATE OR REPLACE PROCEDURE DEL_BIKE 
    (
    BIKE IN INTEGER
    )
    IS
        BID BIKES.BIKE_ID%TYPE; 
    BEGIN
        DELETE FROM ORDERS WHERE BIKE_ID = BIKE;
        DELETE FROM CART WHERE BIKE_ID = BIKE;
        DELETE FROM RATINGS WHERE BIKE_ID = BIKE;
        DELETE FROM DESCRIPTIONS WHERE BIKE_ID = BIKE;
        DELETE FROM BIKES WHERE BIKE_ID = BIKE
        RETURNING BIKES.BIKE_ID INTO BID;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN TOO_MANY_ROWS THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN OTHERS 
        THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END;
    
    BEGIN
        DEL_BIKE(2);
    END;
    
    
-- CLEAR CART 

    CREATE OR REPLACE PROCEDURE CLEAR_CART
    (
      USER INTEGER 
    )
    IS
        CURSOR CART_CURS IS SELECT CART_ID ,USER_ID, BIKE_ID , QUANTITY FROM CART;
        CT CART%ROWTYPE;
    BEGIN
        FOR CT IN CART_CURS
        LOOP
            DELETE FROM CART WHERE CART.CART_ID = CT.CART_ID AND CART.USER_ID = USER AND CART.BIKE_ID =  CT.BIKE_ID AND CART.QUANTITY = CT.QUANTITY;
        END LOOP;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN TOO_MANY_ROWS THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN OTHERS 
        THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END;

BEGIN
    CLEAR_CART(1);
END;

-- CLEAR ORDER

CREATE OR REPLACE PROCEDURE CLEAR_ORDER
(
    USER IN INTEGER
)
IS
BEGIN
IF USER IS NOT NULL THEN
    DELETE FROM ORDERS WHERE BUYER_ID = USER ;
ELSE
    RAISE NO_DATA_FOUND;
END IF;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN TOO_MANY_ROWS THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN OTHERS 
        THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;



-- UPDATE ORDER

    CREATE OR REPLACE PROCEDURE UPDATE_ORDER
    (
    ORD IN INTEGER,
    BUYER IN INTEGER  ,
    BIKE IN INTEGER  ,
    QNT IN NUMBER  ,
    ODATE IN DATE  ,
    STAT IN NVARCHAR2  
    )
    IS
        ID ORDERS.ORDER_ID%TYPE;
    BEGIN
        UPDATE ORDERS SET 
        BUYER_ID = BUYER,
        BIKE_ID = BIKE,
        QUANTITY = QNT,
        ORDER_DATE = ODATE,
        STATUS = STAT 
        WHERE ORDER_ID = ORD
        RETURNING ORDERS.ORDER_ID INTO ID;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN TOO_MANY_ROWS THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN OTHERS 
        THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END;

BEGIN
    UPDATE_ORDER(8,1,6,13,'28.04.2024','ARRIVED');
END;


-- DEL ORDER

    CREATE OR REPLACE PROCEDURE DEL_ORDER 
    (
    ORD IN INTEGER
    )
    IS
        OID ORDERS.ORDER_ID%TYPE; 
    BEGIN
        DELETE FROM ORDERS WHERE ORDER_ID = ORD
        RETURNING ORDERS.ORDER_ID INTO OID;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN TOO_MANY_ROWS THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN OTHERS 
        THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END;
    
    BEGIN
        DEL_ORDER(8);
    END;

-- DEL ROLE
CREATE OR REPLACE PROCEDURE DEL_ROLE
(
RID IN INTEGER
)
IS
    ID ROLES.ROLE_ID%TYPE;
BEGIN
   IF RID IS NOT NULL THEN
         DELETE FROM ROLES WHERE ROLE_ID = RID
         RETURNING ROLES.ROLE_ID INTO ID
         ;
   ELSE
       RAISE NO_DATA_FOUND; 
   END IF;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN TOO_MANY_ROWS THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN OTHERS 
        THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

-- UPD ROLE

CREATE OR REPLACE PROCEDURE UPD_ROLE
(
RID IN INTEGER,
RNAME IN NVARCHAR2
)
IS
    ID ROLES.ROLE_ID%TYPE;
BEGIN
   IF RID IS NOT NULL THEN
        UPDATE ROLES SET ROLENAME = RNAME WHERE ROLE_ID = RID
        RETURNING ROLES.ROLE_ID INTO ID;
   ELSE
       RAISE NO_DATA_FOUND; 
   END IF;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN TOO_MANY_ROWS THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN OTHERS 
        THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;


-- DEL CATEGORY

CREATE OR REPLACE PROCEDURE DEL_CATEGORY
(
CID IN INTEGER
)
IS
    BID BIKES.BIKE_ID%TYPE;
BEGIN
    IF CID IS NOT NULL THEN
        FOR order_rec IN (SELECT BIKE_ID FROM BIKES WHERE CATEGORY_ID = CID) LOOP
            DELETE FROM ORDERS WHERE BIKE_ID = order_rec.BIKE_ID;
        END LOOP;
        FOR cart_rec IN (SELECT BIKE_ID FROM BIKES WHERE CATEGORY_ID = CID) LOOP
            DELETE FROM CART WHERE BIKE_ID = cart_rec.BIKE_ID;
        END LOOP;
        FOR desc_rec IN (SELECT BIKE_ID FROM BIKES WHERE CATEGORY_ID = CID) LOOP
            DELETE FROM DESCRIPTIONS WHERE BIKE_ID = desc_rec.BIKE_ID;
        END LOOP;
        FOR rating_rec IN (SELECT BIKE_ID FROM BIKES WHERE CATEGORY_ID = CID) LOOP
            DELETE FROM RATINGS WHERE BIKE_ID = rating_rec.BIKE_ID;
        END LOOP;
        DELETE FROM BIKES WHERE CATEGORY_ID = CID RETURNING BIKE_ID INTO BID;
        DELETE FROM CATEGORIES WHERE CATEGORY_ID = CID;
    ELSE
        RAISE NO_DATA_FOUND;
    END IF;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN TOO_MANY_ROWS THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN OTHERS 
        THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;


BEGIN
DEL_CATEGORY(1);
END;

-- UPD CATEGORY

CREATE OR REPLACE PROCEDURE UPD_CATEGORY
(
CID IN INTEGER,
CNAME IN NVARCHAR2
)
IS
BEGIN
    IF CID IS NOT NULL AND CNAME IS NOT NULL THEN
        UPDATE CATEGORIES SET CAT_NAME = CNAME;
    ELSE
        RAISE NO_DATA_FOUND;
    END IF;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN TOO_MANY_ROWS THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN OTHERS 
        THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

-- DEL DESCRIPTION

CREATE OR REPLACE PROCEDURE DEL_DESC
(
BID IN INTEGER
)
IS
BEGIN
    IF BID IS NOT NULL THEN
        DELETE FROM DESCRIPTIONS WHERE BIKE_ID = BID;
    ELSE 
        RAISE NO_DATA_FOUND;
    END IF;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN TOO_MANY_ROWS THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN OTHERS 
        THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;


-- UPD DESCRIPTION


CREATE OR REPLACE PROCEDURE UPD_DESC
(
DID IN INTEGER,
BIKE IN INTEGER,
DESCR IN NVARCHAR2,
TYPE IN NVARCHAR2,
MAT IN NVARCHAR2,
W IN FLOAT,
H IN FLOAT
)
IS
BEGIN
    IF DID IS NOT NULL AND BIKE IS NOT NULL THEN
        UPDATE DESCRIPTIONS SET BIKE_DESC = DESCR , BIKE_TYPE = TYPE , MATERIAL = MAT , WEIGHT = W , HEIGHT = H;
    ELSE 
        RAISE NO_DATA_FOUND;
    END IF;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN TOO_MANY_ROWS THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN OTHERS 
        THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

-- DEL RATE
 SELECT * FROM RATINGS;
CREATE OR REPLACE PROCEDURE DEL_RATE
(
BIKE IN INTEGER
)
IS
BEGIN
    IF BIKE IS NOT NULL THEN
        DELETE FROM RATINGS WHERE BIKE_ID = BIKE;
    ELSE
        RAISE NO_DATA_FOUND;
    END IF;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN TOO_MANY_ROWS THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN OTHERS 
        THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

-- UPD RATE

CREATE OR REPLACE PROCEDURE UPD_RATE
(
BIKE IN INTEGER,
USER IN INTEGER,
VALUE IN NUMBER,
MSG IN NVARCHAR2,
STAMP IN TIMESTAMP
)
IS
BEGIN
IF BIKE IS NOT NULL AND USER IS NOT NULL THEN
    UPDATE RATINGS SET RATING_VALUE = VALUE , RATING_MESSAGE = MSG ,TIME_STAMP = STAMP WHERE BIKE_ID = BIKE AND USER_ID = USER;
ELSE
    RAISE NO_DATA_FOUND;
END IF;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN TOO_MANY_ROWS THEN
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        WHEN OTHERS 
        THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;






--- Package For User Funcs and Proces

CREATE OR REPLACE PACKAGE USER_PKG_FUNCS  IS
   -- AVERAGE RATING
    FUNCTION AVG_RATE(BIKE IN INTEGER) RETURN DECIMAL;

    -- ENCRYPT PASS
    FUNCTION HASH_PASS(PASSWORD IN NVARCHAR2) RETURN NVARCHAR2;

    -- REGISTER
    FUNCTION REGISTER(
        NAME IN NVARCHAR2,
        SURNAME IN NVARCHAR2,
        FATHERNAME IN NVARCHAR2,
        EMAIL IN NVARCHAR2,
        PASSWORD IN NVARCHAR2,
        BIRTH IN DATE,
        USER_ADRESS IN NVARCHAR2,
        ROLE IN INTEGER) RETURN INTEGER;

    -- LOGIN
    FUNCTION LOGIN(
        EMAIL IN NVARCHAR2,
        PASS IN NVARCHAR2) RETURN INTEGER;

    -- ADD BIKE
    FUNCTION ADD_BIKE(
        SELLER IN INTEGER,
        NAME IN NVARCHAR2,
        PRICE IN DECIMAL,
        CATEGORY IN INTEGER) RETURN INTEGER;

    -- ADD DESCRIPTION
    FUNCTION ADD_DESC(
        BIKE IN INTEGER,
        DESCR IN NVARCHAR2,
        TYPE IN NVARCHAR2,
        MAT IN NVARCHAR2,
        W IN FLOAT,
        H IN FLOAT) RETURN INTEGER;

    -- ADD CATEGORY
    FUNCTION ADD_CATEGORY(
        NAME IN VARCHAR2) RETURN NUMBER;

    -- ADD ROLE
    FUNCTION ADD_ROLE(
        NAME IN NVARCHAR2) RETURN INTEGER;

    -- ADD ORDER
    FUNCTION ADD_ORDER(
        BUYER IN INTEGER,
        ODATE IN DATE,
        STAT IN NVARCHAR2) RETURN INTEGER;

    -- UPDATE USER
    FUNCTION UPDATE_USER(
        UID IN INTEGER,
        NAME IN NVARCHAR2,
        SURNAME IN NVARCHAR2,
        FATHERNAME IN NVARCHAR2,
        EMAIL IN NVARCHAR2,
        PASS IN NVARCHAR2,
        BIRTH IN DATE,
        ADR IN NVARCHAR2,
        ROLE IN INTEGER) RETURN INTEGER;

    -- ADD RATE
    FUNCTION ADD_RATE(
        BIKE IN INTEGER,
        USER IN INTEGER,
        VALUE IN NUMBER,
        MESSAGE IN NVARCHAR2,
        TIMES IN TIMESTAMP) RETURN INTEGER;

END USER_PKG_FUNCS;





--- PROCEDURES


CREATE OR REPLACE PACKAGE USER_PKG_PROC AS
        -- ADD TO CART
   PROCEDURE ADD_TO_CART
    (
    USER INTEGER ,
    BIKE INTEGER ,
    QNT NUMBER
    );

    -- DELETE FROM CART
 PROCEDURE DEL_FROM_CART
    (
    USER IN INTEGER ,
    BIKE IN INTEGER 
    );

    -- UPDATE PASSWORD
  PROCEDURE UPDATE_PASS
    (
    USER IN INTEGER,
    EMAIL IN NVARCHAR2,
    PASS IN NVARCHAR2
    );

    -- UPDATE BIKE
   PROCEDURE UPDATE_BIKE 
    (
    BIKE IN INTEGER,
    NAME IN NVARCHAR2,
    COST IN DECIMAL,
    CAT IN INTEGER
    );

    -- DELETE USER
 PROCEDURE DEL_USER
(
    USER_ID IN INTEGER
);

    -- DELETE BIKE
PROCEDURE DEL_BIKE 
    (
    BIKE IN INTEGER
    );

    -- CLEAR CART
 PROCEDURE CLEAR_CART
    (
      USER INTEGER 
    );

    -- CLEAR ORDER
PROCEDURE CLEAR_ORDER
(
    USER IN INTEGER
);

    -- UPDATE ORDER
 PROCEDURE UPDATE_ORDER
    (
    ORD IN INTEGER,
    BUYER IN INTEGER  ,
    BIKE IN INTEGER  ,
    QNT IN NUMBER  ,
    ODATE IN DATE  ,
    STAT IN NVARCHAR2  
    );

    -- DELETE ORDER
PROCEDURE DEL_ORDER 
    (
    ORD IN INTEGER
    );

    -- DELETE ROLE
    PROCEDURE DEL_ROLE(
        RID IN INTEGER);

    -- UPDATE ROLE
PROCEDURE UPD_ROLE
(
RID IN INTEGER,
RNAME IN NVARCHAR2
);

    -- DELETE CATEGORY
PROCEDURE DEL_CATEGORY
(
CID IN INTEGER
);

    -- UPDATE CATEGORY
PROCEDURE UPD_CATEGORY
(
CID IN INTEGER,
CNAME IN NVARCHAR2
);

    -- DELETE DESCRIPTION
 PROCEDURE DEL_DESC
(
BID IN INTEGER
);

    -- UPDATE DESCRIPTION
PROCEDURE UPD_DESC
(
DID IN INTEGER,
BIKE IN INTEGER,
DESCR IN NVARCHAR2,
TYPE IN NVARCHAR2,
MAT IN NVARCHAR2,
W IN FLOAT,
H IN FLOAT
);

    -- DELETE RATING
PROCEDURE DEL_RATE
(
BIKE IN INTEGER
);

    -- UPDATE RATING
PROCEDURE UPD_RATE
(
BIKE IN INTEGER,
USER IN INTEGER,
VALUE IN NUMBER,
MSG IN NVARCHAR2,
STAMP IN TIMESTAMP
);

END USER_PKG_PROC;



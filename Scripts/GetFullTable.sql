
-- FUNCS TO GET ALL STROKES

-- USERS
CREATE OR REPLACE FUNCTION GETUSERS
RETURN USER_TABLE_RESULT
IS
    U_RESULT USER_TABLE_RESULT := USER_TABLE_RESULT();
BEGIN
    SELECT USER_INFO(
    U.USER_ID,
    U.USER_NAME,
    U.USER_SURNAME,
    U.USER_FATHERNAME,
    U.USER_EMAIL,
    U.PASSWORD,
    U.DATE_OF_BIRTH,
    U.ADRESS,
    R.ROLENAME
    )
    BULK COLLECT INTO U_RESULT
    FROM USERS U
    LEFT JOIN ROLES R ON R.ROLE_ID =  U.ROLE_ID
    ;
    RETURN U_RESULT;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN NULL; 
        WHEN TOO_MANY_ROWS THEN
        RETURN NULL;
        WHEN OTHERS 
        THEN RETURN NULL;
END;

SELECT * FROM TABLE(GETUSERS());

-- BIKES
CREATE OR REPLACE FUNCTION GETBIKES
RETURN BIKE_TABLE_RESULT
IS
 B_RESULT BIKE_TABLE_RESULT := BIKE_TABLE_RESULT();
BEGIN
    SELECT BIKE_INFO
    (
    B.BIKE_ID,
    B.SELLER_ID,
    B.BIKE_NAME,
    B.PRICE,
    B.CATEGORY_ID,
    AVG_RATE(B.BIKE_ID),
    D.BIKE_DESC,
    D.BIKE_TYPE,
    D.MATERIAL,
    D.WEIGHT,
    D.HEIGHT
    )
    BULK COLLECT INTO B_RESULT
    FROM BIKES B
    LEFT JOIN RATINGS R ON R.BIKE_ID = B.BIKE_ID
    LEFT JOIN DESCRIPTIONS D ON D.BIKE_ID = B.BIKE_ID;
    RETURN B_RESULT;
END;

SELECT * FROM TABLE(GETBIKES());


-- ORDERS
CREATE OR REPLACE FUNCTION GETORDERS
RETURN ORDER_RESULT_TABLE
IS
    O_RESULT ORDER_RESULT_TABLE := ORDER_RESULT_TABLE();
BEGIN
SELECT ORDER_INFO(
O.ORDER_ID,
O.BUYER_ID,
O.BIKE_ID,
O.QUANTITY,
O.ORDER_DATE,
O.STATUS,
U.USER_NAME,
U.USER_SURNAME,
U.ADRESS
) 
BULK COLLECT INTO O_RESULT
FROM ORDERS O
LEFT JOIN  USERS U ON U.USER_ID = O.BUYER_ID;
RETURN O_RESULT;
END;

SELECT * FROM TABLE(GETORDERS());


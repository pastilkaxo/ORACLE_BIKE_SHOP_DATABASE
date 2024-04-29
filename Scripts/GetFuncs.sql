-- GET FUNCS;

-- GET USER


CREATE OR REPLACE FUNCTION GETUSERBYID
(
 USER IN INTEGER
)
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
    INNER JOIN ROLES R ON R.ROLE_ID =  U.ROLE_ID
    WHERE U.USER_ID  = USER
    ORDER BY U.USER_ID
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

SELECT * FROM TABLE(GETUSERBYID(21));
-- GET BIKE



CREATE OR REPLACE FUNCTION GETBIKEBYID 
(
    BID IN INTEGER
)
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
    LEFT JOIN DESCRIPTIONS D ON D.BIKE_ID = B.BIKE_ID
    WHERE B.BIKE_ID = BID
    ORDER BY B.BIKE_ID;
    RETURN B_RESULT;
END;

SELECT * FROM TABLE(GETBIKEBYID(1));

-- GET ORDER

CREATE OR REPLACE FUNCTION GETORDERBYID
(
 OR_ID IN INTEGER
)
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
LEFT JOIN  USERS U ON U.USER_ID = O.BUYER_ID
WHERE O.ORDER_ID = OR_ID;
RETURN O_RESULT;
END;

SELECT * FROM TABLE(GETORDERBYID(3))


-- SORT BY NAME , SURNAME , DATE_OF_BIRTH , ID


CREATE OR REPLACE FUNCTION SORT_USER_BY_NAME 
RETURN USER_TABLE_RESULT
IS
    U_SORTED USER_TABLE_RESULT := USER_TABLE_RESULT();
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
    BULK COLLECT INTO U_SORTED
    FROM USERS U
    LEFT JOIN ROLES R ON R.ROLE_ID = U.ROLE_ID
    ORDER BY U.USER_NAME;
    RETURN U_SORTED;
END;

--

CREATE OR REPLACE FUNCTION SORT_USER_BY_SURNAME
RETURN USER_TABLE_RESULT
IS
    U_SORTED USER_TABLE_RESULT := USER_TABLE_RESULT();
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
    BULK COLLECT INTO U_SORTED
    FROM USERS U
    LEFT JOIN ROLES R ON R.ROLE_ID = U.ROLE_ID
    ORDER BY U.USER_SURNAME;
    RETURN U_SORTED;
END;

--

CREATE OR REPLACE FUNCTION SORT_USER_BY_BIRTH 
RETURN USER_TABLE_RESULT
IS
    U_SORTED USER_TABLE_RESULT := USER_TABLE_RESULT();
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
    BULK COLLECT INTO U_SORTED
    FROM USERS U
    LEFT JOIN ROLES R ON R.ROLE_ID = U.ROLE_ID
    ORDER BY U.DATE_OF_BIRTH;
    RETURN U_SORTED;
END;

--

CREATE OR REPLACE FUNCTION SORT_USER_BY_ID
RETURN USER_TABLE_RESULT
IS
    U_SORTED USER_TABLE_RESULT := USER_TABLE_RESULT();
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
    BULK COLLECT INTO U_SORTED
    FROM USERS U
    LEFT JOIN ROLES R ON R.ROLE_ID = U.ROLE_ID
    ORDER BY U.USER_ID;
    RETURN U_SORTED;
END;


SELECT * FROM TABLE(SORT_USER_BY_ID());


-- SORT BIKE BY  ID , SELLER ID , NAME , PRICE , CATEGORY
--  WEIGHT, HEIGHT, MATERIAL , 

SELECT * FROM BIKES;

CREATE OR REPLACE FUNCTION SORT_BIKE_BY_ID
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
    LEFT JOIN DESCRIPTIONS D ON D.BIKE_ID = B.BIKE_ID
    ORDER BY B.BIKE_ID;
    RETURN B_RESULT;
END;


-- 

CREATE OR REPLACE FUNCTION SORT_BIKE_BY_NAME
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
    LEFT JOIN DESCRIPTIONS D ON D.BIKE_ID = B.BIKE_ID
    ORDER BY B.BIKE_NAME;
    RETURN B_RESULT;
END;

--

CREATE OR REPLACE FUNCTION SORT_BIKE_BY_SELLER
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
    LEFT JOIN DESCRIPTIONS D ON D.BIKE_ID = B.BIKE_ID
    ORDER BY B.SELLER_ID;
    RETURN B_RESULT;
END;


--


CREATE OR REPLACE FUNCTION SORT_BIKE_BY_PRICE
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
    LEFT JOIN DESCRIPTIONS D ON D.BIKE_ID = B.BIKE_ID
    ORDER BY B.PRICE;
    RETURN B_RESULT;
END;


--

CREATE OR REPLACE FUNCTION SORT_BIKE_BY_CATEGORY
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
    LEFT JOIN DESCRIPTIONS D ON D.BIKE_ID = B.BIKE_ID
    ORDER BY B.CATEGORY_ID;
    RETURN B_RESULT;
END;

--

CREATE OR REPLACE FUNCTION SORT_BIKE_BY_RATE
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
    LEFT JOIN DESCRIPTIONS D ON D.BIKE_ID = B.BIKE_ID
    ORDER BY AVG_RATE(B.BIKE_ID);
    RETURN B_RESULT;
END;

--


CREATE OR REPLACE FUNCTION SORT_BIKE_BY_DESC
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
    LEFT JOIN DESCRIPTIONS D ON D.BIKE_ID = B.BIKE_ID
    ORDER BY D.BIKE_DESC;
    RETURN B_RESULT;
END;

--

CREATE OR REPLACE FUNCTION SORT_BIKE_BY_TYPE
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
    LEFT JOIN DESCRIPTIONS D ON D.BIKE_ID = B.BIKE_ID
    ORDER BY D.BIKE_TYPE;
    RETURN B_RESULT;
END;

--


CREATE OR REPLACE FUNCTION SORT_BIKE_BY_MATERIAL
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
    LEFT JOIN DESCRIPTIONS D ON D.BIKE_ID = B.BIKE_ID
    ORDER BY D.MATERIAL;
    RETURN B_RESULT;
END;

--


CREATE OR REPLACE FUNCTION SORT_BIKE_BY_WEIGHT
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
    LEFT JOIN DESCRIPTIONS D ON D.BIKE_ID = B.BIKE_ID
    ORDER BY D.WEIGHT;
    RETURN B_RESULT;
END;

--

CREATE OR REPLACE FUNCTION SORT_BIKE_BY_HEIGHT
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
    LEFT JOIN DESCRIPTIONS D ON D.BIKE_ID = B.BIKE_ID
    ORDER BY D.HEIGHT;
    RETURN B_RESULT;
END;


SELECT * FROM TABLE(SORT_BIKE_BY_RATE);


-- SORT ORDER BY ID , QUANTITY , DATE , STATUS

CREATE OR REPLACE FUNCTION SORT_ORDER_BY_ID
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
LEFT JOIN  USERS U ON U.USER_ID = O.BUYER_ID
ORDER BY O.ORDER_ID;
RETURN O_RESULT;
END;

--

CREATE OR REPLACE FUNCTION SORT_ORDER_BY_QNT
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
LEFT JOIN  USERS U ON U.USER_ID = O.BUYER_ID
ORDER BY O.QUANTITY;
RETURN O_RESULT;
END;


--

CREATE OR REPLACE FUNCTION SORT_ORDER_BY_DATE
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
LEFT JOIN  USERS U ON U.USER_ID = O.BUYER_ID
ORDER BY O.ORDER_DATE;
RETURN O_RESULT;
END;

--

CREATE OR REPLACE FUNCTION SORT_ORDER_BY_STATUS
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
LEFT JOIN  USERS U ON U.USER_ID = O.BUYER_ID
ORDER BY O.STATUS;
RETURN O_RESULT;
END;

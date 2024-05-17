
-- USERS

CREATE OR REPLACE PROCEDURE IMPORT_USERS_FROM_JSON
IS
    v_file UTL_FILE.FILE_TYPE;
    v_line VARCHAR2(4000);
BEGIN
    v_file := UTL_FILE.FOPEN('USERS_JSON', 'USERS.JSON', 'R');
    LOOP
        BEGIN
            UTL_FILE.GET_LINE(v_file, v_line);
            EXIT WHEN v_line IS NULL;

            INSERT INTO USERS (USER_NAME, USER_SURNAME, USER_FATHERNAME, USER_EMAIL, PASSWORD, DATE_OF_BIRTH, ADRESS, ROLE_ID)
            SELECT 
                jt.USER_NAME, jt.USER_SURNAME, jt.USER_FATHERNAME, jt.USER_EMAIL, jt.PASSWORD, TO_DATE(SUBSTR(jt.DATE_OF_BIRTH, 1, 10), 'YYYY-MM-DD'), jt.ADRESS, jt.ROLE_ID
            FROM JSON_TABLE(v_line, '$[*]'
                COLUMNS (
                    USER_NAME PATH '$.NAME',
                    USER_SURNAME PATH '$.SURNAME',
                    USER_FATHERNAME PATH '$.FATHERNAME',
                    USER_EMAIL PATH '$.EMAIL',
                    PASSWORD PATH '$.PASSWORD',
                    DATE_OF_BIRTH PATH '$.BIRTH',
                    ADRESS PATH '$.ADRESS',
                    ROLE_ID PATH '$.ROLE'
                )
            ) jt;
                
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                EXIT;
            WHEN OTHERS THEN
                RAISE;
        END;
    END LOOP;
    UTL_FILE.FCLOSE(v_file);
EXCEPTION
    WHEN OTHERS THEN
        IF UTL_FILE.IS_OPEN(v_file) THEN
            UTL_FILE.FCLOSE(v_file);
        END IF;
        RAISE;
END;



BEGIN
    IMPORT_USERS_FROM_JSON();
END;

------------------------------------------



CREATE OR REPLACE PROCEDURE IMPORT_BIKES_FROM_JSON
IS
    v_file UTL_FILE.FILE_TYPE;
    v_line VARCHAR2(4000);
BEGIN
    v_file := UTL_FILE.FOPEN('BIKES_JSON', 'BIKES.JSON', 'R');
    LOOP
        BEGIN
            UTL_FILE.GET_LINE(v_file, v_line);
            EXIT WHEN v_line IS NULL;

            INSERT INTO BIKES (SELLER_ID, BIKE_NAME, PRICE, CATEGORY_ID)
            SELECT jt.SELLER_ID, jt.BIKE_NAME, jt.PRICE, jt.CATEGORY_ID
            FROM JSON_TABLE(v_line, '$[*]'
                COLUMNS (
                    SELLER_ID PATH '$.SELLER',
                    BIKE_NAME PATH '$.NAME',
                    PRICE PATH '$.PRICE',
                    CATEGORY_ID PATH '$.CATEGORY'
                )
            ) jt;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                EXIT;
        END;
    END LOOP;
    UTL_FILE.FCLOSE(v_file);
END;



BEGIN
    IMPORT_BIKES_FROM_JSON();
END;



------------------------------------------



CREATE OR REPLACE PROCEDURE IMPORT_ORDERS_FROM_JSON
IS
    v_file UTL_FILE.FILE_TYPE;
    v_line VARCHAR2(4000);
BEGIN
    v_file := UTL_FILE.FOPEN('ORDERS_JSON', 'ORDERS.JSON', 'R');
    LOOP
        BEGIN
            UTL_FILE.GET_LINE(v_file, v_line);
            EXIT WHEN v_line IS NULL;

            INSERT INTO ORDERS (BUYER_ID, BIKE_ID, QUANTITY, ORDER_DATE,STATUS)
            SELECT jt.BUYER_ID, jt.BIKE_ID, jt.QUANTITY, jt.ORDER_DATE, jt.STATUS
            FROM JSON_TABLE(v_line, '$[*]'
                COLUMNS (
                    BUYER_ID PATH '$.BUYER',
                    BIKE_ID PATH '$.BIKE',
                    QUANTITY PATH '$.QNT',
                    ORDER_DATE PATH '$.DATE',
                    STATUS PATH '$.STATUS'
                )
            ) jt;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                EXIT;
        END;
    END LOOP;
    UTL_FILE.FCLOSE(v_file);
END;



BEGIN
    IMPORT_ORDERS_FROM_JSON();
END;





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
            
            MERGE INTO USERS u
            USING (
                SELECT 
                    JSON_VALUE(v_line, '$.NAME') AS USER_NAME,
                    JSON_VALUE(v_line, '$.SURNAME') AS USER_SURNAME,
                    JSON_VALUE(v_line, '$.FATHERNAME') AS USER_FATHERNAME,
                    JSON_VALUE(v_line, '$.EMAIL') AS USER_EMAIL,
                    JSON_VALUE(v_line, '$.PASSWORD') AS PASSWORD,
                    TO_DATE(JSON_VALUE(v_line, '$.BIRTH'), 'YYYY-MM-DD"T"HH24:MI:SS') AS DATE_OF_BIRTH,
                    JSON_VALUE(v_line, '$.ADRESS') AS ADRESS,
                    JSON_VALUE(v_line, '$.ROLE') AS ROLE_ID
                FROM DUAL
            ) json_data
            ON (u.USER_EMAIL = json_data.USER_EMAIL)
            WHEN NOT MATCHED THEN
                INSERT (USER_NAME, USER_SURNAME, USER_FATHERNAME, USER_EMAIL, PASSWORD, DATE_OF_BIRTH, ADRESS, ROLE_ID)
                VALUES (json_data.USER_NAME, json_data.USER_SURNAME, json_data.USER_FATHERNAME, json_data.USER_EMAIL, json_data.PASSWORD, json_data.DATE_OF_BIRTH, json_data.ADRESS, json_data.ROLE_ID);
                
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                EXIT;
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



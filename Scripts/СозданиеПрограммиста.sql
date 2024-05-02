ALTER SESSION SET "_oracle_script" = TRUE; 



-- �������� ��������� �����������:
/*
create tablespace PROG_TS 
    datafile 'C:\Tablecpaces\CourseWork\PROG_TS.dbf'
    size 20M
    autoextend on next 5M
    extent management local;
    
create temporary tablespace PROG_TEMP_TS
    tempfile 'C:\Tablecpaces\CourseWork\PROG_TEMP_TS.dbf'
    size 5M
    autoextend on next 3M
    extent management local;
*/
-- �������� ���� ADMIN_BD

create role DB_ADMIN;

grant 
ALL PRIVILEGES
to
DB_ADMIN;

CREATE USER COURSE_DB_ADMIN IDENTIFIED BY 123;
GRANT DB_ADMIN ,SYSDBA TO COURSE_DB_ADMIN;
-- �������� ���� 
create role PROGRAMMER;

grant 
CONNECT,
CREATE SESSION,
CREATE TABLE,
CREATE VIEW,
CREATE PROCEDURE,
CREATE ANY INDEX,
CREATE USER,
DROP  USER,
CREATE SEQUENCE,
CREATE TRIGGER,
CREATE ROLE,
CREATE TYPE,
CREATE DIRECTORY
TO
PROGRAMMER
;

-- �������� ������� ������������
/*
CREATE PROFILE PF_PROG LIMIT
    PASSWORD_LIFE_TIME 180
    SESSIONS_PER_USER 3
    FAILED_LOGIN_ATTEMPTS 7
    PASSWORD_LOCK_TIME 1
    PASSWORD_REUSE_TIME 10
    PASSWORD_GRACE_TIME DEFAULT
    CONNECT_TIME 180
    IDLE_TIME 30;
*/
-- �������� ������������ 

CREATE USER DEVELOPER IDENTIFIED BY 12345;
GRANT PROGRAMMER TO DEVELOPER;
GRANT EXECUTE ON DBMS_CRYPTO TO DEVELOPER;


DROP TABLESPACE PROG_TS;
DROP TABLESPACE PROG_TEMP_TS;
DROP PROFILE PF_PROG;
DROP ROLE PROGRAMMER;
DROP ROLE DB_ADMIN;
DROP USER DEVELOPER;
DROP USER COURSE_DB_ADMIN;




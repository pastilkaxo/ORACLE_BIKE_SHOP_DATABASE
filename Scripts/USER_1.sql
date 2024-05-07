

SELECT * FROM DEVELOPER.USER_V;
SELECT * FROM DEVELOPER.BIKE_V;
SELECT * FROM DEVELOPER.ORDER_V;
SELECT * FROM DEVELOPER.CART_V;

-- FUNCS AND PROCES

--�����������
BEGIN
 DBMS_OUTPUT.PUT_LINE(DEVELOPER.REGISTER('VLADISLAV','LEMIASHEUSKY','OLEGOVICH','VLAD.LEMESHOK@GMAIL.COM','12345','25-04-2004','MINSK',2));
 COMMIT;
END;

--�����������

BEGIN
 DBMS_OUTPUT.PUT_LINE(DEVELOPER.LOGIN('VLAD.LEMESHOK@GMAIL.COM','12345'));
 COMMIT;
END;

-- ���������� �����
BEGIN
 DBMS_OUTPUT.PUT_LINE(DEVELOPER.ADD_BIKE(5,'BIKE 1',199.99,1));
 COMMIT;
END;

-- ���������� �������� �����
BEGIN
 DBMS_OUTPUT.PUT_LINE(DEVELOPER.ADD_DESC(8,'BRAND NEW!','STREET','STEEL',8,20));
 COMMIT;
END;

-- ���������� ������

BEGIN
 DBMS_OUTPUT.PUT_LINE(DEVELOPER.ADD_RATE(8,5,7,'NOT BAD!',SYSTIMESTAMP));
 COMMIT;
END;

-- ���������� ������������

BEGIN
    DBMS_OUTPUT.PUT_LINE(DEVELOPER.UPDATE_USER(5,'VLADDDD','LEMESH','OLG','VLAD.LEMESHOK@GMAIL.COM','12345','25-04-2004','MINSK',2));
    COMMIT;
END;

-- ������� ������� ����������

SELECT DEVELOPER.AVG_RATE(8) AS RATE FROM DUAL;

-- �������� ����������

BEGIN
    DEVELOPER.DEL_BIKE(8);
    COMMIT;
END;

-- �������� ��������

BEGIN
    DEVELOPER.DEL_DESC(8);
END;

ROLLBACK;

-- �������� ������

BEGIN
    DEVELOPER.DEL_RATE(8);
END;

-- ���������� ��������

BEGIN
    DEVELOPER.UPD_DESC(1,8,'NEW NOW!','RACING','STEEL',8,20);
END;

-- ���������� ������

BEGIN
    DEVELOPER.UPD_RATE(8,5,4,'BAD!',SYSTIMESTAMP);
END;

-- ���������� �����

BEGIN
    DEVELOPER.UPDATE_BIKE(8,'WTP TRIG',950,1);
END;


-- ���������� ���������� � �������

BEGIN
    DEVELOPER.ADD_TO_CART(5,8,10);
    COMMIT;
END;


-- ������� �������

BEGIN
    DEVELOPER.CLEAR_CART(5);
END;

-- �������� ����� �� �������

BEGIN
    DEVELOPER.DEL_FROM_CART(5,8);
END;

-- ���������� ������

BEGIN
    DBMS_OUTPUT.PUT_LINE(DEVELOPER.ADD_ORDER(5,SYSDATE,'IN WAY'));
    COMMIT;
END;

-- ���������� ������

BEGIN
    DEVELOPER.UPDATE_ORDER(1,5,8,3,SYSDATE,'ARRIVED');
END;

-- ������� �������

BEGIN
    DEVELOPER.CLEAR_ORDER(5);
END;

-- �������� ������

BEGIN
    DEVELOPER.DEL_ORDER(1);
    COMMIT;
END;

-- ��������� ����� �� ������

SELECT * FROM TABLE(DEVELOPER.GETUSERS());

-- ���������� ������

SELECT * FROM TABLE(DEVELOPER.SORT_USER_BY_ID);


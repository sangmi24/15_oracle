/*
    < DCL : DATA CONTROL LANGUAGE >
    ������ ���� ���
    
    �������� �ý��۱��� �Ǵ� ��ü���ٱ����� �ο� (GRNAT) �ϰų� (REVOKE) �ϴ� ��� 
    
    [ ǥ���� ]
    * ���� �ο� ( GRANT )
    GRANT ����, ���� ,..  TO ������;
    
    * ���� ȸ�� ( REVOKE )
     REVOKE ����, ����, ... FROM ������;

*/

/*
   - �ý��� ����
    Ư�� DB �� �����ϴ� ����, ��ü���� ������ �� �ִ� ���� 
    
    - �ý��۱����� ���� 
    CREATE SESSION : ������ ������ �� �ִ� ���� 
    CREATE TABLE : ���̺��� ������ �� �ִ� ���� 
    CREATE VIEW : �並 ������ �� �ִ� ���� -(�ӽ����̺�)
    CREATE SEQUENCE : �������� ������ �� �ִ� ����
    CREATE USER : ������ ������ �� �ִ� ����
    ...
*/
--1. SAMPLE ���� ����
--CREATE USER ������ IDENTIFIED BY ��й�ȣ;  
CREATE USER SAMPLE IDENTIFIED BY SAMPLE; --> ������ ������ ���ٰ�

--2. SAMPLE ������ �����ϱ� ���� CREATE SESSION ������ �ο�
GRANT CREATE SESSION TO SAMPLE;   --> �ϰ��� �����߰�!! �ʷϻ� +

--3_1. SAMPLE ������ ���̺��� ������ �� �ִ� CREATE TABLE ������ �ο�
GRANT CREATE TABLE TO SAMPLE;

--3_2. SAMPLE ������ ���̺����̽��� �Ҵ����ֱ� ( SAMPLE ���� ���� ����) 
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
--QUOTA : ��, �Ҵ��ϴ�.
--2M : 2 MEGA BYTE

--4. SAMPLE ������ �並 ������ �� �ִ� CREATE VIEW ���� �ο�
GRANT CREATE VIEW TO SAMPLE;

-------------------------------------------------------------------------------
/*
     - ��ü���ٱ���  (��ü����)
     Ư�� ��ü���� ���� (DML- SELECT, INSERT, UPDATE, DELETE ) �� �� �ִ� ����
   
     [ ǥ���� ]
     GRNAT �������� ON Ư����ü TO ������;
     
      ��������        |   Ư����ü
     ======================================
     SELECT           |  TABLE, VIEW, SEQUENCE  
     INSERT           |  TABLE, VIEW
     UPDATE          |   TABLE, VIEW
     DELETE           |   TABLE, VIEW
*/

--5. SAMPLE ������ KH.EMPLOYEE ���̺��� ��ȸ�� �� �ִ� ���� �ο� 
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

--6. SAMPLE ������ KH.DEPARTMENT ���̺� ���� ������ �� �ִ� ���� �ο�
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

---------------------------------------------------------------------------------------------

-- �ּ����� ������ �ο��ϰ��� �� ��, CONNECT, RESOURCE �� �ο�
-- GRANT CONNECT, RESOURCE TO ������;
/*
    < �� ROLE > 
    Ư�� ���ѵ��� �ϳ��� �������� ��� ���� ��
    
    CONNECT :  ������ �� �ִ� ���ѵ��� ������� ROLE ( CREATE SESSION) 
    RESOURCE : Ư�� ��ü���� ���� �� ������ �� �ִ� ���ѵ��� ������� ROLE ( CREATE TABLE, CREATE SEQUENCE,...)
    
*/

-- ���� Ȯ���� �� �ִ� ������ ��ųʸ� ��ȸ 
SELECT *
FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT', 'RESOURCE');

-----------------------------------------------------------------------------------------------------------------------

/*
    *���� ȸ�� (REVOKE)
    ������ ȸ���� �� ����ϴ� ��ɾ�
    
    [ ǥ���� ]
    REVOKE ����, ����,  ... FROM ������;
    (ROLL�� ���ѿ� ���� ȸ���� �����ϴ�.) => GRANT �� ����
*/

-- 7. SAMPLE �������� ���̺��� ������ �� ������ ������ ȸ��
REVOKE CREATE TABLE FROM SAMPLE;

-- �ǽ����� --

-- ����ڿ��� �ο��� ���� : CONNECT, RESOURCE
-- ������ �ο����� ������� �̸� : MYTEST
CREATE USER MYTEST IDENTIFIED BY MYTEST;  --1�ܰ� : ���� ����
GRANT CONNECT, RESOURCE TO MYTEST; --2�ܰ� : �ּ����� ������ �ο� 

--MYTEST �������� �����ؼ� �۾�

--������ ���� ���Ѹ� ȸ���ϰ�ʹٸ�? (�� ������ ȸ���� �����ϴ�)
REVOKE RESOURCE FROM MYTEST;


--MYTEST ������ ���̻� ���� ���ٸ� ?-- ���� ������ �ƴϿ��� ���Ű� �����ϴ�.
DROP USER MYTEST;









































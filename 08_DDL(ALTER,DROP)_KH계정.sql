/*
    < DDL : DATA DEFINITION LANGUAGE>
    ������ ���� ��� 
    
      ��ü���� ������ ���� (CREATE) , ���� (ALTER), ���� (DROP) �ϴ� ����
      
      1.  ALTER
      ��ü ������ �����ϴ� ����
      
      < ���̺� ���� > 
      ALTER TABLE ���̺�� �����ҳ���;

      - �����ҳ���
      1)  �÷� �߰� / ���� / ����
      2)  ���� ���� �߰� / ���� => ������ �Ұ� ( �����ϰ��� �Ѵٸ� ���� �� ������ �߰� )
      3)  ���̺�� / �÷��� / �������Ǹ� ����     
*/

-- 1) �÷� �߰� / ���� / ����
-- 1_1) �÷� �߰� ( ADD ) : ADD �߰����÷��� ������Ÿ�� DEFAULT �⺻��   => �����ҳ��뿡 �� 
--                                  (DEFAULT �⺻�� �κ��� ���� ����)
SELECT * FROM DEPT_COPY;

-- CNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20) ;
--���ο� �÷��� �߰��ǰ� �⺻������ NULL ������ ä����

-- LNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';
--���ο� �÷��� ��������� NULL �� �ƴ� DEFAULT ������ ä����

-- [ ������ ] �÷��� ����
ALTER TABLE DEPT_COPY RENAME COLUMN LNAME TO LANAME;

--1_2) �÷� ���� (MODIFY)
--       ������ Ÿ�� ���� : MODIFY �������÷��� �ٲٰ����ϴµ�����Ÿ��
--       DEFAULT �� ���� : MODIFY �������÷���  DEFAULT �ٲٰ����ϴ±⺻��

--DEPT_ID �÷��� ������Ÿ���� CHAR(2) ���� CHAR(3) �� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

-- ���� �����ϰ��� �ϴ� �÷��� �̹� ����ִ°��� ������ �ٸ� Ÿ�����δ� ������ �Ұ��ϴ�.
--��)  ���� -> ���� (X)  / ���ڿ� ������ ��� (X) / ���ڿ� ������ Ȯ�� (��)

--ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
--column to be modified must be empty to change datatype
-- ������ �ٸ� ������Ÿ������ �����ϰ��� �� ��쿡�� ���� ����־�� ��

--ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(8);
-- cannot decrease column length because some value is too big
-- ���� ����ִ� ���� ����� �� ū ��� (��, ��� �Ұ�)

--DEPT_TITLE �÷��� ������Ÿ���� VARCHAR2(40)��
--LOCATION _ID �÷��� ������Ÿ���� VARCHAR2(2) �� 
-- LNAME �÷��� �⺻���� '�̱�'���� 
--ALTER TABLE ���̺�� 
--�ٲܳ����;
--ALTER TABLE DEPT_COPY
--MODIFY �÷��� �ٲܵ�����Ÿ��
--MODIFY �÷��� DEFAULT �ٲܱ⺻��;
ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY LNAME DEFAULT '�̱�';

-- �÷� ������ ���� ���纻 ���̺� �����
--DEPT_COPY�� ���纻
CREATE TABLE DEPT_COPY2 
AS ( SELECT *
       FROM DEPT_COPY );

SELECT * FROM DEPT_COPY2;

--1_3) �÷� ���� (DROP COLUMN) : DROP COLUMN �����ϰ����ϴ��÷���

-- DEPT_COPY2�� ���� DEPT_ID �÷� �����
ALTER TABLE DEPT_COPY2 DROP COLUMN  DEPT_ID;

ROLLBACK;
-- DDL ������ ROLLBACK���� ���� �Ұ��� 

-- ��� �÷��� ���ֺ���
ALTER TABLE DEPT_COPY2 
DROP COLUMN DEPT_TITLE
DROP COLUMN LOCATION_ID
DROP COLUMN CNAME
DROP COLUMN LNAME;  --���� �� �Ѳ����� ���� �Ұ�

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
-- cannot drop all columns in a table 
-- ���̺��� ��� �÷����� ���� ������ �� ����
-- ������ �÷� ������ ���� : ���̺� �ּ� �Ѱ��� �÷��� ���ܾ� ��

--�÷� �߰�/ ����/ ���� �� ���ǻ���
--1. �÷��� �ߺ� �Ұ�
--2. ���� �� ������Ÿ�� �� �Ű� �Ἥ ����
--3. ROLLBACK  �Ұ�
--4. ���̺�� ��� �Ѱ��� �÷��� �־����

--2) ���� ���� �߰� / ����

/*
     2_1) �������� �߰� (ADD/ MODIFY)
     => ��� �÷��� ��� ���������� �߰��Ұ��� ��� 
     
        -PRIMARY KEY: ADD PRIMARY KEY (�÷���)
        -FOREIGN KEY: ADD FOREIGN KEY (�÷���) REFERECES ���������̺�� (�������÷���)
                             => �������÷����� �������� (������, �ڵ����� PRIMARY KEY�� �������÷������� ����)                       
        -UNIQUE: ADD UNIQUE (�÷���)
        -CHECK: ADD CHECK (�÷�����������)
        -NOT NULL: MODIFY �÷��� NOT NULL

       ������ �������Ǹ��� �ο��ϰ��� �Ѵٸ� : CONSTRAINT �������Ǹ��� ������������ �տ� ���� �ȴ�.
       �������Ǹ� �ο� �κ��� CONSTRAINT �������Ǹ��� ���� �����ϴ�. (SYS_C~)
       �������Ǹ��� �ο��� �� ���ǻ��� : ���� ���� ���� ������ ������ �ο��ؾ���
                                                        ( �ƹ��� �ٸ� ���̺��̿��� �������Ǹ��� �ߺ��� �Ұ� )
*/

--DEPT_COPY ���̺�
--DEPT_ID�÷��� PRIMARY KEY �������� �߰�
--DEPT_TITLE �÷��� UNIQUE �������� �߰�
--LNAME �÷��� NOT NULL �������� �߰�

SELECT * FROM DEPT_COPY; -- ������������ ��������NOTNULL�� ����� 

ALTER TABLE DEPT_COPY 
ADD  CONSTRAINT DCOPY_PK PRIMARY KEY (DEPT_ID);

ALTER TABLE DEPT_COPY 
ADD CONSTRAINT DCOPY_UQ UNIQUE (DEPT_TITLE);
--cannot validate (KH.DCOPY_UQ) - duplicate keys found
-- �̹� ����ִ� ������ �ο��ϰ��� �ϴ� �������ǿ� ���谡 �� �����̱� ������ ���� �߻� 

ALTER TABLE DEPT_COPY 
MODIFY LNAME  CONSTRAINT DCOPY_NN NOT NULL;

SELECT *
FROM USER_CONSTRAINTS; --�������ǵ��� ����ִ� ������ ��ųʸ� 

-- EMP_DEPT ���̺�� �ٽ��ѹ� ����
-- EMP_ ID �÷��� PRIMARY KEY �ο�
-- EMP_NAME �÷��� UNIQUE �������� �ο�
-- EMP_NAME �÷��� NOT NULL �������� �ο�

ALTER TABLE EMP_DEPT
ADD CONSTRAINT EDPT_PK  PRIMARY KEY (EMP_ID)
ADD CONSTRAINT EDPT_UQ UNIQUE (EMP_NAME)
MODIFY EMP_NAME CONSTRAINT EDPT_NN NOT NULL;

-- �÷� �߰� �� ���ǻ���
--1. �������Ǹ� �ߺ� �Ұ�
--2. �̹� ��� ������ �ش� ���������� �����ϰ� �ִ��� Ȯ�� �ϰ� ���̱�
--3. ALTER �� �ϳ� ������ ��� �ѹ��� ���� ����

/*
    2_2 ) �������� ���� (DROP CONSTRAINT / MODIFY)
    
    -PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK : DROP CONSTRAINT �������Ǹ�
    -NOT NULL : MODFY �÷��� NULL;
*/
--ALTER TABLE ���̺� �ٲܳ���;
-- EDPT_PK �������� �����
ALTER TABLE  EMP_DEPT DROP CONSTRAINT EDPT_PK;
-- EDPT_UQ �������� �����
-- EDPT_NN �������� ����� ���� �����  
ALTER TABLE  EMP_DEPT
DROP CONSTRAINT EDPT_UQ;
MODIFY EMP_NAME NULL;

--------------------------------------------------------------------------------------------

-- 3)  �÷��� / �������Ǹ� / ���̺�� ���� (RENAME)

--ALTER TABLE ���̺�� �ٲܳ���;
--3_1 ) �÷��� ���� : RENAME COLUMN �����÷��� TO �ٲ��÷���
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO  DEPT_NAME;

SELECT * FROM DEPT_COPY;

--3_2 ) �������Ǹ� ���� : RENAME CONSTRAINT �����������Ǹ� TO �ٲ��������Ǹ�
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007182 TO DEPT_ID_NN;
ALTER TABLE DEPT_COPY RENAME  CONSTRAINT SYS_C007183 TO LOCATION_ID_NN;

--3_3) ���̺�� ����  : RENAME  TO �ٲ����̺��
--                            (�������̺�� ��������, �̹� ALTER TABLE ���̺���� ����ϱ� ������ ���� ����)
ALTER TABLE DEPT_COPY RENAME  TO DEPT_TEST;
ALTER TABLE EMP_SALARY RENAME TO SALARY_EMP;

--RENAME �������̺�� TO �ٲ����̺�� ; ���ε� �����ϴ�.
ALTER TABLE SALARY_EMP RENAME TO EMP_SALARY;
-----------------------------------------------------------------------------------------------------------------
/*
    2. DROP
    ��ü�� �����ϴ� ����
    
    < ���̺� ���� >
    [ ǥ���� ]
    DROP TABLE ���̺��;
    
    < ����� ���� >
    DROP USER ������;   -- �ش� ������ ���� �������̸� ���� �ȵ�  
*/

DROP TABLE DEPT_TEST;
-- DELETE �Ǵ� TRUNCATE �������� ��� ���� �����ϴ°Ŷ��� �ٸ���. (���빰�� ����°�)
-- DROP �� ���̺� ��ü�� ����°�

DROP TABLE DEPARTMENT;
-- unique/primary keys in table referenced by foreign keys
-- ��򰡿��� �����ǰ� �ִ� �θ����̺���� �������� �ʴ´�.
-- ���࿡ �θ����̺��� �����ϰ�ʹٸ�?
-- 1. �ڽ����̺� ���� ����� �� ������ �θ����̺��� ����� ���
DROP TABLE EMPLOYEE_COPY ;--�ڽ����̺��
DROP TABLE DEPARTMENT; --�θ����̺��;

--2. �θ����̺� �����ϴµ�, �¹����ִ� ���������� �Բ� ����� ���
DROP TABLE �θ����̺�� CASCADE CONSTRAINT;














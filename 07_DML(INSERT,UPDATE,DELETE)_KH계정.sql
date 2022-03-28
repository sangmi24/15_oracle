/*
    < DML :  DATA MANIPULATION LANGUAGE   >
    ������ ���� ��� 
    
    ���̺� ���ο� �����͸� ���� (INSERT) �ϰų�, ������ �����Ͱ��� ���� (UPDATE) �ϰų�,
    ������ ������ ���� ���� (DELETE) �ϴ� ����
   
    �߰������� SELECT ���� DML�� ������ �� ����

*/

/*
     1. INSERT :  ���̺� ���ο� ���� �߰��ϴ� ���� (�� ������ �߰�)
     
     [ ǥ���� ]
     1)  INSERT INTO ���̺�� VALUES (��, ��, ��,...) ;
     =>  �ش� ���̺� ��� �÷��� ���� �߰��ϰ��� �ϴ� ���� ���� ���� "���" �����ؼ� 
          �� ����  INSERT �ϰ��� �� �� ����ϴ� ����
          ������ �� : �÷� ������ ���Ѽ� VALUES ��ȣ �ȿ� ���� �����ؾ� ��
          - ������ ������ ���� �������� ��� : NOT ENOUGH VALUE ���� 
          - ���� �÷��� �������� �� ���� �������� ��� : TOO MANY VALUES ���� 
*/

--EMPLOYEE ���̺� INSERT
SELECT * FROM EMPLOYEE;

INSERT INTO EMPLOYEE
VALUES( '900', '�踻��', '870215-2000000','kim_md@kh.or.kr'
             ,'01011112222','D1', 'J7', 'S3', 4000000,0.2, '200', SYSDATE,  NULL, DEFAULT  );

SELECT * FROM EMPLOYEE;

SELECT * 
FROM EMPLOYEE
WHERE EMP_ID = '900';  --> �� �� �ุ ���� �ִ�.

/*
    2) INSERT INTO ���̺�� (�÷���, �÷���, �÷���,..)  VALUES (��, ��,��,..);
     => �ش� ���̺� Ư�� �÷��� �����ؼ� �� �÷��� �߰��� ���� "�κ�������" �����ϰ��� �� �� ���
          �׷��� �� �� ������ �߰��Ǳ� ������ ������ �ȵ� �÷��� ���ؼ��� �⺻������ NULL���� ��
          (��, �⺻�� DEFAULT �� ������ ��쿡�� �� DEFAULT ���� �߰��ȴ� )
          �������� : NOT NULL ���������� �ɷ��ִ� �÷��� �ݵ�� �����ؼ� ���� ���������� ���ø� �ؾ߸� �� => ������
                         ��, NOT NULL ���������� �ɷ��ִ� �÷��̶�� �ϴ���
                          DEFAULT ������ �Բ� �ɷ��ִ� ��쿡�� �÷��� ������ ���ص� �� . 
                          --PRIMARY KEY�� ���������̴�. 
*/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE )
VALUES ('901', '�ڸ���', '990101-1234567', 'D1','J2', 'S1',SYSDATE );

SELECT * FROM EMPLOYEE;

/*
    3) INSERT INTO  ���̺�� ( �������� ); 
    => VALUES  �� ���� ������ �����ϴ°� ��ſ� ���������� ��ȸ�� ���������
         ��°�� INSERT �ϴ� ����
         ( ���� ���� INSERT ��ų �� �ִ�. )
*/
-- ���ο� ���̺� �����
CREATE TABLE EMP_01 (
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)

);

-- ��ü ������� ���, �̸�, �μ����� ��ȸ�� ����� EMP_01 ���̺� ��°�� �߰�
INSERT INTO EMP_01
(  SELECT EMP_ID, EMP_NAME, DEPT_TITLE
   FROM EMPLOYEE , DEPARTMENT 
    WHERE DEPT_CODE= DEPT_ID (+)  --�������� => 25�� ��ȸ
);
--25�� �� ��(��) ���ԵǾ����ϴ�. 
--�������� �̿��ϸ� ��°�� �ѹ��� ���� ���� ���� �߰� �����ϴ�. 

SELECT * FROM EMP_01;

/*
      2. INSERT ALL
      �� �� �̻��� ���̺� ���� INSERT �ϰ� ���� �� ���
      ��,  ���Ǵ� ���������� ������ ��� ���     
*/
 
 -- ���ο� ���̺��� ���� �����
 -- ù��° ���̺� : �޿��� 300���� �̻��� ������� ���, �����, ���޸� ���ؼ� ������ ���̺�
 CREATE TABLE EMP_JOB(
      EMP_ID NUMBER,
      EMP_NAME VARCHAR2(30),
      JOB_NAME VARCHAR2(20)
 );
 
 SELECT * FROM EMP_JOB;

--�ι�° ���̺� : �޿��� 300���� �̻��� ������� ���, �����, �μ��� ���ؼ� ������ ���̺�
CREATE TABLE EMP_DEPT(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);
 SELECT * FROM EMP_DEPT;

-- �޿��� 300���� �̻��� �������, ���, �̸�, ���޸�, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE 
JOIN JOB USING( JOB_CODE )
LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID )
WHERE SALARY >= 3000000;

/*
     1 ) INSERT ALL
          INTO ���̺��1 VALUES (�÷���, �÷���, �÷���,...)
          INTO ���̺��2 VALUES (�÷���, �÷���, �÷���,...)
           (��������);
*/
--EMP_JOB ���̺��� �޿���  300���� �̻��� ������� EMP_ID, EMP_NAME, JOB_NAME �� ����
--EMP_DEPT ���̺��� �޿��� 300���� �̻��� ������� EMP_ID,EMP_NAME, DEPT_TITLE �� ����
INSERT ALL
INTO EMP_JOB VALUES(EMP_ID, EMP_NAME, JOB_NAME )  --9���� ��  INSERT
INTO EMP_DEPT VALUES( EMP_ID,EMP_NAME, DEPT_TITLE  )  --9���� ��  INSERT
  ( SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
    FROM EMPLOYEE 
    JOIN JOB USING( JOB_CODE )
    LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID )
    WHERE SALARY >= 3000000);
--> ���������� ���ؼ� ��ȸ�� ���� ���� : 9���� ��
-->�� ��� ���� �߰��Ǿ����� = ���������� ��ȸ�� ���� ���� * INTO �������� ������ ���̺��� ����    
--> 18�� ���� �߰� ��
SELECT * FROM EMP_JOB ;
SELECT * FROM EMP_DEPT;

-- INSERT ALL �� ������ ����ؼ� �� ���̺� �� INSERT ����
-- ���, �����, �Ի���, �޿� (EMP_OLD ���̺� ����) => ��, 2010�� ������ �Ի��� ���
CREATE TABLE EMP_OLD
AS ( SELECT EMP_ID, EMP_NAME, HIRE_DATE,SALARY
       FROM EMPLOYEE
       WHERE 1=0 );  --Ʋ�� ������

-- ���, �����, �Ի���, �޿�(EMP_NEW ���̺� ���� ) => ��, 2010����� �Ի��� ���
CREATE TABLE EMP_NEW
AS ( SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
       FROM EMPLOYEE
       WHERE 1=0 );

SELECT *FROM EMP_OLD;
SELECT *FROM EMP_NEW;

-- �� ������ �´� ������� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE
--WHERE HIRE_DATE  <'2010/01/01' ;--2010�⵵ ���� �Ի��ڵ鸸 ��ȸ : 9��
WHERE HIRE_DATE >= '2010/01/01' ;--2010�⵵ ���� �Ի��ڵ鸸 ��ȸ :16��

/*
   2) INSERT ALL 
       WHEN ���ǽ�1 THEN
                INTO ���̺�1 VALUES( �÷���, �÷���, ...)
       WHEN ���ǽ�2 THEN
                 INTO ���̺�2 VALUES (�÷���, �÷���,...)
        (���������� ����� ��������);         
*/
INSERT ALL
WHEN HIRE_DATE  <'2010/01/01' THEN
           INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE,SALARY)  --9�� �� INSERT
WHEN HIRE_DATE >= '2010/01/01' THEN
           INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE,SALARY) --15�� �� INSERT
     (SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
      FROM EMPLOYEE);  
--> �� 25���� �� �߰���
--> ���� ���Ե� ���� ���� = �� ���ǿ� �´� ���� ������ �� ���� ��

-----------------------------------------------------------------------------------------------

/*
     3. UPDATE 
     ���̺� ��ϵ� ������ �����͸� �����ϴ� ����
     
     [ ǥ���� ]
     UPDATE ���̺��
            SET �÷��� = �ٲܰ�
                  ,�÷���= �ٲܰ� 
                  ,�÷���= �ٲܰ�  => �������� �÷����� ���ÿ� ���� ���� ( ,�� �����ؾ��� / AND �ƴ�!)
       WHERE  ����; => WHERE ���� ���� ����
                               ��, ���� �� ��ü ��� ���� �����Ͱ� �� ����Ǿ���� (����)   
*/

-- �׽�Ʈ�� ���纻 ���̺��� ������
CREATE TABLE DEPT_COPY
AS ( SELECT *
       FROM DEPARTMENT );

SELECT * FROM DEPT_COPY;

-- DEPT_COPY ���̺��� D9�μ��� �μ����� '������ȹ��' ���� ����
UPDATE DEPT_COPY
       SET DEPT_TITLE='������ȹ��'  --�μ����� '������ȹ��'
 WHERE  DEPT_ID='D9' ; --D9 �μ��ϰ�� ���ǽ��� ���� ��

-- ���ǻ��� ) WHERE ���� �������� ���
UPDATE DEPT_COPY
      SET  DEPT_TITLE='�ѹ���'; 
-- ��ü ���� ��� DEPT_TITLE �� ���� �� �ѹ��η� ����Ǿ����       

--���纻 ���̺�
CREATE TABLE EMP_SALARY
AS ( SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
       FROM  EMPLOYEE  );     

SELECT * FROM EMP_SALARY;

-- EMP_SALARY ���̺� ���ö ����� �޿��� 1000�������� ����
UPDATE EMP_SALARY
       SET    SALARY = 10000000--�޿��� 1000�������� 
    WHERE  EMP_NAME='���ö' ;--�̸��� ���ö�ϰ��  

SELECT *
FROM EMP_SALARY
WHERE EMP_NAME= '���ö';

-- EMP_SALARY ���̺� ������ ����� �޿��� 700��������, ���ʽ��� 0.2�� ����
UPDATE EMP_SALARY
       SET  SALARY=7000000, BONUS=0.2
  WHERE  EMP_NAME='������';   

--��ü ����� �޿��� ���� �޿��� 20���� �λ��� �ݾ����� ���� ( �����޿� *1.2) 
--WHERE���� �Ƚ�� ��ü ��� �޿��� ��� ���� �λ��Ҽ� �ִ�. 
UPDATE EMP_SALARY
       SET SALARY= SALARY*1.2 ;
       
/*
    * UPDATE �ÿ� ���������� ����ϱ� 
    ���������� ������ ��������� �����ϰڴ�. 
    (= ������ �� �κп� ���������� �ְڴ�.)
    
    [ ǥ���� ]
    UPDATE ���̺��
          SET  �÷��� = (��������) -->�̰� ��������Ͽ�
     WHERE  ����;   
*/

-- EMP_SALARY ���̺� �踻�� ����� �μ��ڵ带 ������ ����� �μ��ڵ�� ���� 
--1�ܰ�)������ ����� �μ��ڵ� ���ϱ� -D9
--2�ܰ�) ��ġ�� 
UPDATE EMP_SALARY
   SET DEPT_CODE= ( SELECT DEPT_CODE
                              FROM EMPLOYEE
                              WHERE EMP_NAME = '������' )
WHERE EMP_NAME='�踻��';

SELECT * FROM EMP_SALARY;

-- ���� ����� �޿��� ���ʽ��� ����� ����� �޿��� ���ʽ��� ���� =>������ ���߿�
--1�ܰ�) ����� ����� �޿��� ���ʽ��� ���ϱ�  -4080000 / 0.2
--2�ܰ�) ��ġ��
UPDATE EMP_SALARY
SET (SALARY,BONUS)= (SELECT SALARY, BONUS
                                    FROM EMP_SALARY  --20���� �λ�� �޿��� ��ȸ 
                                    WHERE EMP_NAME='�����')
WHERE EMP_NAME='����';                                    

SELECT *
FROM EMP_SALARY
WHERE EMP_NAME IN ('����', '�����');

-- [ ���� ] UPDATE �ÿ��� ������ ���� �־ �ش� �÷��� ���� �������ǿ� ����Ǹ� �ȵ�

-- ���߱� ����� ����� 200������ ����
SELECT * FROM EMPLOYEE;

UPDATE EMPLOYEE
       SET EMP_ID = '200'
WHERE  EMP_NAME='������';
--unique constraint (KH.EMPLOYEE_PK) violated
--PRIMARY KEY �������ǿ� ����  �ߺ� �ȵ�

--����� 200���� ����� �̸��� NULL �� ����
UPDATE EMPLOYEE
       SET EMP_NAME=NULL
 WHERE EMP_ID='200';    
--cannot update ("KH"."EMPLOYEE"."EMP_NAME") to NULL
-- NOT NULL �������ǿ� ���� 

--���±��� �����ߴ� ������� Ȯ�����ڴ�.
COMMIT;
--Ŀ�� �Ϸ�.

----------------------------------------------------------------------------------------------------------------------------
/*
     4.  DELETE
      ���̺� ��ϵ� �����͸� �����ϴ� ����
      
      [ ǥ���� ]
      DELETE FROM ���̺��
      WHERE ����;   => WHERE ���� ���� ����
                                ��, ������ ��� �࿡ ���ؼ� ���� �� ���� (����)
*/
-- EMPLOYEE ���̺��� ��� ����� ����
SELECT * FROM EMPLOYEE;

DELETE FROM EMPLOYEE;
ROLLBACK; --������ COMMIT �������� ����  
--DROP BY �� �ุ ����°� (�ٽ� �˾ƺ���)

--�踻�˰� �ڸ��� ����� ����
DELETE FROM EMPLOYEE
WHERE EMP_NAME IN ('�踻��','�ڸ���');

COMMIT; --23���� ������� Ȯ�� 










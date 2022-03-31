/*
     <  VIEW �� >
     
     SELECT  (��ȸ��������) �� �����ص� �� �ִ� ǥ ������ ��ü
     ( ���� ���Ϲ��� �� SELECT ���� �����صθ� �� �� SELECT ���� �Ź� �ۼ��ؼ� �ٽ� ��ȸ�� �ʿ䰡 ����)
     �ӽ����̺� ���� ���� ( ���� �����Ͱ� ����ִ°��� �ƴϴ�)
*/

--------------�ǽ�����-----------------

-- '�ѱ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ�������, ���޸� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME  , DEPT_TITLE , SALARY , NATIONAL_NAME ,  JOB_NAME 
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N, JOB J
WHERE E.DEPT_CODE= D.DEPT_ID(+)     --������� ���� ����
   AND D.LOCATION_ID=L.LOCAL_CODE(+) 
   AND L.NATIONAL_CODE=N.NATIONAL_CODE(+)
   AND E.JOB_CODE=J.JOB_CODE
   AND N.NATIONAL_NAME='�ѱ�';   --�߰����� ����

-->> ANSI ����
SELECT EMP_ID , EMP_NAME , DEPT_TITLE , SALARY , NATIONAL_NAME,  JOB_NAME 
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE= D.DEPT_ID)
LEFT JOIN LOCATION L ON( D.LOCATION_ID=L.LOCAL_CODE)
LEFT JOIN NATIONAL N USING(NATIONAL_CODE)
       JOIN JOB J USING (JOB_CODE)
WHERE N.NATIONAL_NAME='�ѱ�';

--------------------------------------------------------------------------------------------------------------------

/*
      1.  VIEW ���� ���
      
      [  ǥ���� ]
      CREATE VIEW ���
      AS ( �������� );
      => �ܼ��� �並 �����ϴ� ����
      
      CREATE OR REPLACE VIEW ���
      AS (��������);
      => �� ������ ������ �ߺ��� �̸��� �䰡 ���ٸ� ������ �並 �߰��ϰ�
                         ������ �ߺ��� �̸��� �䰡 �ִٸ� �ش� �並 ���� �ϴ� �ɼ� (OR REPLACE)      
*/

-- [ ���� ] => �ζ��� �� (71��°���� SELECT * FROM VW_EMPLOYEE; �� ����.  )
SELECT * 
FROM (SELECT EMP_ID, EMP_NAME  , DEPT_TITLE , SALARY , NATIONAL_NAME ,  JOB_NAME 
           FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N, JOB J
          WHERE E.DEPT_CODE= D.DEPT_ID(+)     
              AND D.LOCATION_ID=L.LOCAL_CODE(+) 
              AND L.NATIONAL_CODE=N.NATIONAL_CODE(+)
              AND E.JOB_CODE=J.JOB_CODE   );
            
--���� ������ SELECT ���� �������� ��� �� ����
CREATE VIEW VW_EMPLOYEE
AS (SELECT EMP_ID, EMP_NAME  ,DEPT_TITLE , SALARY , NATIONAL_NAME ,  JOB_NAME 
      FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N, JOB J
      WHERE E.DEPT_CODE= D.DEPT_ID(+)     
          AND D.LOCATION_ID=L.LOCAL_CODE(+) 
          AND L.NATIONAL_CODE=N.NATIONAL_CODE(+)
          AND E.JOB_CODE=J.JOB_CODE );   --�������� �κп� '�ѱ�'���� �ٹ��ϴ� ������ ����
--insufficient privileges 
-- ���� KH ������ CREATE VIEW ������ ��� ���� �߻�
-- �ذ��� : �����ڰ������� �����ؼ� GRANT CREATE VIEW TO KH;

-- �� �κи� ������ �������� �����ؼ� ����--
GRANT CREATE VIEW TO KH;
---------------------------------------------------

SELECT * FROM VW_EMPLOYEE;
-- ���� ���� ������ ���������� �̿��Ͽ� �׶��׶� �ʿ��� �����͵鸸 ��ȸ�ϴ� �ͺ���
-- �ѹ� ���������� �並 ���� �� �ش� ������� SELECT ���� �̿��Ͽ� �����ϰ� ��ȸ �����ϴ�.

--'�ѱ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ�������, ���޸� ��ȸ�Ͻÿ� 
SELECT * 
FROM VW_EMPLOYEE
WHERE  NATIONAL_NAME='�ѱ�';

-- '���þ�' ���� �ٹ��ϴ� ���
SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME='���þ�';

--'���þ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ�������, ���޸�, ���ʽ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME, BONUS
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME='���þ�';
--VW_EMPLOYEE �信 BONUS �÷��� ���� ������ ���� �߻�

-- ���ʽ� �÷��� ���� �信�� ���ʽ��� ��ȸ�ϰ� ���� ���
-- CREATE OR REPLACE VIEW ��ɾ ����.
CREATE OR REPLACE VIEW VW_EMPLOYEE
AS ( SELECT EMP_ID, EMP_NAME  , DEPT_TITLE , SALARY , NATIONAL_NAME ,  JOB_NAME ,BONUS
      FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N, JOB J
      WHERE E.DEPT_CODE= D.DEPT_ID(+)     
          AND D.LOCATION_ID=L.LOCAL_CODE(+) 
          AND L.NATIONAL_CODE=N.NATIONAL_CODE(+)
          AND E.JOB_CODE=J.JOB_CODE );

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME, BONUS
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME='���þ�';
--������ �� ���� �� ������ �����

-- ��� ������ �������̺� => ���������� �����͸� �����ϰ� ���� ����
-- ( ���� ���� ��ü�� SELECT���� ���� == �ܼ��� �������� TEXT������ ����Ǿ�����)
--  USER_VIEWS ������ ��ųʸ� : �ش� ������ ������ �ִ� VIEW �鿡 ���� �������� ������ �ִ� ������ ���̺�
SELECT *
FROM USER_VIEWS;

-----------------------------------------------------------------------------------------------------------------------------

/*
    *  �� �÷��� ��Ī �ο�
    ���������� SELECT ���� �Լ��� ��������� ����Ǿ��ִ� ��� �ݵ�� ��Ī ����
*/

-- ����� ���, �̸�, ���޸�, ����, �ٹ������ ��ȸ�� �� �ִ� SELECT���� ��� ����
CREATE OR REPLACE VIEW VW_EMP_JOB
AS ( SELECT EMP_ID, EMP_NAME, JOB_NAME
                 ,DECODE(SUBSTR(EMP_NO,8,1), '1', '��', '2','��')
                 ,EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 
       FROM EMPLOYEE
       JOIN JOB USING (JOB_CODE));
-- ��Ī�� �������� �ʾƼ� ���� �߻�
-- must name this expression with a column alias
-- ALIAS  : ��Ī
CREATE OR REPLACE VIEW VW_EMP_JOB
AS ( SELECT EMP_ID, EMP_NAME, JOB_NAME
                 ,DECODE(SUBSTR(EMP_NO,8,1), '1', '��', '2','��') "����"
                 ,EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "�ٹ����" 
       FROM EMPLOYEE
       JOIN JOB USING (JOB_CODE));
-- �� ���� ����

SELECT * FROM VW_EMP_JOB;

-- �� �ٸ� ������� ��Ī �ο� ���� ( ��,  ��� �÷��� ���� ��Ī�� �� ����ؾ���)
CREATE OR REPLACE VIEW VW_EMP_JOB (���, �̸�, ���޸�, ����, �ٹ����)
AS ( SELECT EMP_ID, EMP_NAME, JOB_NAME
                 ,DECODE(SUBSTR(EMP_NO,8,1), '1', '��', '2','��')
                 ,EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 
       FROM EMPLOYEE
       JOIN JOB USING (JOB_CODE));

SELECT * FROM VW_EMP_JOB;

SELECT ���, �ٹ����
FROM VW_EMP_JOB;

SELECT ���, �̸�, ���޸�
FROM VW_EMP_JOB
WHERE ���� = '��';

SELECT *
FROM VW_EMP_JOB
WHERE �ٹ���� >= 20;

-- �並 �����ϰ� �ʹٸ�?
DROP VIEW VW_EMP_JOB;

------------------------------------------------------------------------------------------------------
/*
    * ������ �並 �̿��ؼ� DML ( INSERT, UPDATE, DELETE) ��� ����
      ��, �並 ���ؼ� �����ϰ� �Ǹ� ���� ���� �����Ͱ� ����ִ�
      �������� ���̺�(���̽����̺�) ���� ������ �ȴ�. 
*/

CREATE OR REPLACE VIEW VW_JOB
AS ( SELECT * FROM JOB );

SELECT * FROM VW_JOB;
SELECT * FROM JOB;

-- �信 INSERT 
INSERT INTO VW_JOB
VALUES( 'J8', '����');

--���̽����̺� (JOB) ���� ���� INSERT �� ���� Ȯ�� ����

--�信 UPDATE
--JOB_CODE�� J8�� JOB_NAME �� �˹ٷ� UPDATE
UPDATE  VW_JOB
      SET  JOB_NAME = '�˹�'
      WHERE JOB_CODE = 'J8';

--���̽����̺� (JOB)���� ���� UPDATE �Ȱ��� Ȯ�� ����

--�信 DELETE
--JOB_CODE�� J8�� ���� ����
DELETE FROM VW_JOB
WHERE JOB_CODE = 'J8';
 --���̽����̺� (JOB) ���� ���� DELETE �Ȱ��� Ȯ�� ���� 
 
 -----------------------------------------------------------------------------------------------------
 
 /*
     * ������ �並 ������ DML�� �Ұ����� ��찡 �� ����
     
     1) �信 ���ǵǾ����� ���� �÷��� �����ϴ� ���
     2) �信 ���ǵǾ����� ���� �÷� �߿� ���̽����̺� �� NOT NULL ���������� ������ ���
     3) �������� �Ǵ� �Լ��� ���ؼ� ���ǵǾ��ִ� ���
     4) �׷��Լ��� GROUP BY ���� ���ԵǾ����� ���
     5) DISTINCT ������ ���Ե� ���
     6) JOIN �� �̿��ؼ� ���� ���̺��� ��Ī���ѳ��� ���
     
 */
 
 --1) �信 ���ǵǾ����� ���� �÷��� �����ϴ� ���
 CREATE OR REPLACE VIEW VW_JOB
 AS (SELECT JOB_CODE FROM JOB);
 
 SELECT * FROM VW_JOB;
 
--INSERT (����)
INSERT INTO VW_JOB (JOB_CODE, JOB_NAME)
VALUES ( 'J8', '����');

--UPDATE (����)
UPDATE VW_JOB
      SET JOB_NAME = '����'
WHERE  JOB_CODE = 'J7'; 

--DELETE (����)
DELETE FROM VW_JOB
WHERE JOB_NAME='���';

-- ���� VW_JOB �信 �������� �ʴ� JOB_NAME �÷��� ���� �߰�, ����, �����ϰ��� �Ͽ� ���� �߻�
-- "JOB_NAME": invalid identifier

------------------------------------------------------------------------

--2) �信 ���ǵǾ����� ���� �÷� �߿� ���̽����̺� �� NOT NULL ���������� ������ ���
CREATE OR REPLACE VIEW VW_JOB
AS ( SELECT JOB_NAME FROM JOB);

SELECT * FROM VW_JOB;
SELECT * FROM JOB;

--INSERT (����)
INSERT INTO VW_JOB VALUES ('����');  --JOB ���̺� (NULL , '����') ���ԵǷ��� ��
--cannot insert NULL into (NULL ���� ���� ����.)=>JOB_CODE�� NULL �� �ǰ� ��������ϴϱ� 

-- UPDATE (����)
UPDATE VW_JOB
      SET JOB_NAME ='�˹�'
WHERE  JOB_NAME= '���';

-- UPDATE (����)
UPDATE VW_JOB
      SET JOB_CODE = NULL --> NOT NULL�� �����
WHERE JOB_NAME = '�˹�';  
--> VW_JOB�� JOB_CODE �÷��� ���� �Ӹ� �ƴ϶� NOT NULL���������ε� NULL�� �ְ����ؼ� ����

--DELETE (����)
DELETE FROM VW_JOB
WHERE JOB_NAME = '�븮';
--child record found 
--> J6 ���� �����͸� ����� ���� �ִ� �ڽ� �����Ͱ� �ֱ� ������ ���� �Ұ�

DELETE FROM VW_JOB
WHERE JOB_NAME = '�˹�';
--child record found 
--���࿡ J8 �����ڵ忴�ٸ� �ڽĵ����Ͱ� ���� ������ ������ ������������!

---------------------------------------------------------------------

--3) �������� �Ǵ� �Լ��� ���ؼ� ���ǵǾ��ִ� ���
--����� ���, �̸�, �޿�, ������ ���ؼ� ��ȸ�ϴ� ��
CREATE OR  REPLACE VIEW VW_EMP_SAL
AS (SELECT EMP_ID, EMP_NAME, SALARY, SALARY *12 "����"
      FROM EMPLOYEE);

SELECT * FROM VW_EMP_SAL;
SELECT * FROM EMPLOYEE;

-- INSERT (����)
INSERT INTO VW_EMP_SAL
VALUES ( 400, '������', 3000000, 36000000);
--virtual column not allowed here

-- UPDATE (����)
UPDATE VW_EMP_SAL
       SET ���� = 80000000
 WHERE  EMP_ID =200;   
--virtual column not allowed here

--UPDATE (����) 
UPDATE VW_EMP_SAL
       SET SALARY = 7000000
 WHERE EMP_ID=200;  

--DELETE 
DELETE FROM VW_EMP_SAL
WHERE ���� = 72000000;  
-- �������̺� ���� ���� �÷����� ������ ����������
-- �� ������ ���� ������ �Ϸ��� �ô��� ������ ����� �ִ� ���� �����ϱ� ������ ������ ������ ������

SELECT * FROM EMPLOYEE;

ROLLBACK;
-----------------------------------------------------------------

--4) �׷��Լ��� GROUP BY ���� ���ԵǾ����� ���
-- �μ��� �޿���, ��ձ޿��� ��ȸ�ϴ� ��
CREATE OR REPLACE VIEW VW_GROUPDEPT
AS ( SELECT DEPT_CODE, SUM(SALARY) "�޿���", FLOOR(AVG( SALARY)) "��ձ޿�"
       FROM EMPLOYEE
       GROUP BY DEPT_CODE );

SELECT * FROM VW_GROUPDEPT;

-- INSERT ( ���� )
INSERT INTO VW_GROUPDEPT
VALUES ( 'D0', 80000000, 4000000 );
--virtual column not allowed here
--UPDATE ( ���� )
UPDATE VW_GROUPDEPT
       SET �޿��� = 8000000
    WHERE DEPT_CODE = 'D1';   
-- data manipulation operation not legal on this view"
--UPDATE (����)
UPDATE VW_GROUPDEPT
       SET DEPT_CODE = 'D0'
   WHERE DEPT_CODE = 'D1' ;  
-- data manipulation operation not legal on this view"
--DELETE (����)
DELETE FROM VW_GROUPDEPT
WHERE DEPT_CODE = 'D1';
--data manipulation operation not legal on this view"
--------------------------------------------------------------
--5) DISTINCT ������ ���Ե� ���
CREATE OR REPLACE VIEW VW_DT_JOB
AS ( SELECT DISTINCT JOB_CODE
       FROM EMPLOYEE);

SELECT * FROM VW_DT_JOB;

-- INSERT  (����)
INSERT INTO VW_DT_JOB VALUES ('J8');
--data manipulation operation not legal on this view"
-- UPDATE (����)
UPDATE VW_DT_JOB
       SET JOB_CODE = 'J8'
 WHERE  JOB_CODE='J7';    
 --data manipulation operation not legal on this view"       
-- DELETE (����)
DELETE FROM VW_DT_JOB
WHERE JOB_CODE= 'J7';
 --data manipulation operation not legal on this view"
 ------------------------------------------------------------------
 --6) JOIN �� �̿��ؼ� ���� ���̺��� ��Ī���ѳ��� ���
 CREATE OR REPLACE VIEW VW_JOINEMP
 AS ( SELECT EMP_ID, EMP_NAME, DEPT_TITLE
        FROM EMPLOYEE 
        JOIN DEPARTMENT ON(DEPT_CODE= DEPT_ID));
 
 SELECT * FROM VW_JOINEMP;
 
 --INSERT(����)
 INSERT INTO VW_JOINEMP VALUES(888, '������', '�ѹ���');
 --cannot modify more than �������� ���̺��� ���ε� ��� INSERT�� ���� ����

 --UPDATE (����)
 UPDATE VW_JOINEMP
        SET EMP_NAME= '������'
  WHERE EMP_ID= 200;   
 --EMPLOYEE ���̺��� �ݿ� ������  UPDATE���̶� ���� ���� ( Ư�����̽�)
 
 SELECT * FROM EMPLOYEE;
 
 --DELETE(����)
 DELETE FROM VW_JOINEMP
 WHERE EMP_ID =200;
 
 DELETE FROM VW_JOINEMP
 WHERE DEPT_TITLE='�ѹ���';
 
 
 SELECT * FROM  VW_JOINEMP;
 SELECT * FROM EMPLOYEE;  -- �������̺� �������� DML �����
 SELECT * FROM DEPARTMENT; 

ROLLBACK;

-------------------------------------------------------------------------------

/*
    * VIEW �ɼ�
    
    [  ��ǥ���� ]
    CREATE OR REPLACE  [FORCE /NOFORCE]   VIEW ���
    AS ( �������� )
    WITH CHECK OPTION
    WITH READ ONLY;
    
    1) FORCE / NOFORCE
      - FORCE : ���������� ����� ���̺��� �������� �ʴ��� �並 �����ϰڴ�.
      - NOFORCE : ���������� ����� ���̺��� �ݵ�� �����ؾ߸� �並 �����ϰڴ�.  (������ �⺻��)
      
    2) WITH CHECK OPTION : ���������� �������� ����� ���뿡 �����ϴ� �����θ� DML �� ����
                                       ���ǿ� �������� �ʴ� ������ �����ϴ� ��� ���� �߻�
             
    3) WITH READ ONLY : �信 ���� ��ȸ�� ����                                  
    
*/

--1) FORCE / NOFORCE
CREATE OR REPLACE /*NOFORCE*/VIEW VW_TEST
AS ( SELECT TCODE, TNAME, TCONTENT  
       FROM TT);
--TT��� ���̺��� �������� �ʾƼ� ���� �߻�
--table or view does not exist
CREATE OR REPLACE FORCE VIEW VW_TEST
AS ( SELECT TCODE, TNAME, TCONTENT  
       FROM TT);
--���: ������ ������ �Բ� �䰡 �����Ǿ����ϴ�.

SELECT * FROM VW_TEST;

--��, �ش� TT��� �̸��� ���̺��� ������ ���ĺ��ʹ� �ش� �� ��� ����
CREATE TABLE TT (
     TCODE NUMBER,
     TNAME VARCHAR2(30),
     TCONTENT VARCHAR2(50)
);

SELECT * FROM VW_TEST;

-- 2) WITH CHECK OPTION 
CREATE OR REPLACE VIEW VW_EMP
AS ( SELECT *
      FROM EMPLOYEE
      WHERE  SALARY >=3000000)
WITH CHECK OPTION ;

SELECT * FROM VW_EMP;
-- ���� �� ���� ��Ȳ : ������ 300���� �̻��� ������� ������ ����

UPDATE VW_EMP
     SET  SALARY = 2000000
WHERE EMP_ID = 200; 
--view WITH CHECK OPTION where-clause violation
--���������� ����� ���ǿ� �������� �ʰԲ� ������ �õ��߱� ������ ���� �Ұ�
UPDATE VW_EMP
     SET  SALARY = 4000000
WHERE EMP_ID = 200; 
--���������� ����� ���ǿ� �����ؼ� ������ ����

SELECT * FROM EMPLOYEE;  --������ �ٲ��.

ROLLBACK;

-- 3) WITH READ ONLY 
CREATE OR REPLACE VIEW VW_EMPBONUS
AS ( SELECT EMP_ID, EMP_NAME, BONUS
       FROM EMPLOYEE
       WHERE BONUS IS NOT NULL)
WITH READ ONLY  ;

SELECT * FROM VW_EMPBONUS;

DELETE FROM VW_EMPBONUS
WHERE EMP_ID = 204;
-- ������ �Ұ�
-- cannot perform a DML operation on a read-only view 

/*
     *  ���λ�
     ������ �̸��� ���϶� �ǹ̺ο��� �ϴµ�
     ��� ������ ��ü�� �̸����� ���λ縦 ����
     
     - ���̺�� : TB_XXXX 
     - �������� : SEQ_XXX
     - ��� :  VW_XXXX
*/





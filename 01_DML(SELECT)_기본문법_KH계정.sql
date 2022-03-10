/*
      <  SELECT >
      �����͸� ��ȸ�ϰų� �˻��� �� ����ϴ� ��ɾ�
      
      -  ResultSet : SELECT ������ ���� ��ȸ�� �����͵��� ������� �ǹ�
                           ��, ��ȸ�� ����� ����
                           
          [ ǥ���� ]
          SELECT ��ȸ�ϰ����ϴ��÷���, �÷���2, �÷���3, .... 
          FROM ���̺��;
*/
    
 -- EMPLOYEE ���̺��� ��ü ������� ���, �̸�, �޿� �÷����� ��ȸ
 SELECT EMP_ID, EMP_NAME, SALARY
 FROM  EMPLOYEE;
 
 --  ��ɾ�, Ű���� , ���̺��, �÷��� ���� ��ҹ��ڸ� ������ ����
 --  �ҹ��ڷ� �ᵵ ����, ��, ����ڷ� ����� ����! 
 
 --EMPLOYEE ���̺��� ��ü ������� ��� �÷��� ��ȸ
 SELECT EMP_ID, EMP_NAME, EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,SAL_LEVEL,
              SALARY,BONUS,MANAGER_ID,HIRE_DATE,ENT_DATE,ENT_YN
 FROM  EMPLOYEE;
 
 --��� �÷��� ��ȸ�� ��쿡�� SELECT  *�� �����ش�. 
 SELECT *
FROM EMPLOYEE;

-- JOB ���̺��� ��� �÷��� ��ȸ
SELECT *
FROM JOB;

-- JOB ���̺��� ���޸� �÷��� ��ȸ
SELECT JOB_NAME
FROM JOB;

------- �ǽ����� -----------
--1. DEPARTMENT ���̺��� ��� �÷� ��ȸ
SELECT *
FROM DEPARTMENT;

--2. EMPLOYEE ���̺��� ������,�̸���,��ȭ��ȣ,�Ի��� �÷��� ��ȸ
SELECT EMP_NAME,  EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

--3. EMPLOYEE ���̺��� �Ի���, ������, �޿� �÷��� ��ȸ
 SELECT HIRE_DATE, EMP_NAME, SALARY
 FROM EMPLOYEE;
 
 -------------------------------------------------------------
 
 /*
      < �÷����� ���� ������� >
      ��ȸ�ϰ��� �ϴ� �÷����� �����ϴ� SELECT���� �������( + - / *)�� ����ؼ� ����� ��ȸ�� �� �ִ�. 
 */
  
-- EMPLOYEE ���̺�κ��� ������, ���� , ���� (==���� * 12 )
SELECT EMP_NAME,  SALARY , SALARY*12
FROM EMPLOYEE;
 
-- EMPLOYEE ���̺�κ��� ������, ����, ���ʽ�,  ���ʽ��� ���Ե� ����( == ( ���� +( ����*���ʽ�) ) *12   )
SELECT EMP_NAME,  SALARY,  BONUS,  (SALARY+(SALARY*BONUS))*12
FROM EMPLOYEE;
 
 --> ��� ���� ������ NULL ���� �����Ѵٸ� ��� ���� ���������  NULL �� ����!
 
 -- EMPLOYEE ���̺�κ��� ������, �Ի���, �ٹ��ϼ�(���ó�¥ - �Ի���) ��ȸ
 -- DATE Ÿ�Գ����� ���� ���� (DATE => ��, ��, ��, �� , ��, �� )
 -- ���� ��¥ : SYSDATE
 
 SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE   
 FROM EMPLOYEE;
 -- ������� �ϼ� ������ ����
 -- ���� �������� ������  DATE Ÿ�Կ� ���ԵǾ� �ִ� ��/��/�� �� ���� ������� �����ϱ� ����
 
 --------------------------------------------------------------------------------
 
 /*
     < �÷��� ��Ī �ο��ϱ� >
     [ ǥ���� ]
     �÷��� AS ��Ī, �÷��� AS "��Ī",  �÷��� ��Ī,  �÷��� "��Ī"
     
     AS �� ���̵� �Ⱥ��̵� ���� 
     ��Ī�� Ư�����ڳ� ���Ⱑ ���Ե� ��� �ݵ�� ""��  ��� ǥ���ؾ� ��
 */
 
 -- EMPLOYEE  ���̺�κ��� �̸�, �� �޿�, ���ʽ�, ���ʽ��� ���Ե� �� �ҵ��� ��ȸ
SELECT EMP_NAME AS �̸�,  SALARY AS "�޿�(��)" , BONUS ���ʽ� , ( SALARY+(SALARY*BONUS) )*12 "�� �ҵ�"
FROM EMPLOYEE;
 
 --------------------------------------------------------------------------------
 
 /*
            < ���ͷ� > ==��
            ���Ƿ� ������ ���ڿ� (' ') , ����, ��¥ �� SELECT ���� ����ϸ�
            ���� �� ���̺� �����ϴ� ������ó�� ResultSet���� ��ȸ�� �����ϴ�.
 */
 
 -- EMPLOYEE ���̺�κ��� ���, �����, �޿�, ���� ��ȸ�ϱ�
 SELECT EMP_ID AS ���,  EMP_NAME "�����", SALARY AS "�޿�", '��'  "����"
 FROM EMPLOYEE;
 --> SELECT ���� ������ ���ͷ� ���� ��ȸ����� ResultSet �� ��� �࿡ �ݺ������� ��µ�
 
 ---------------------------------------------------------------------------------
 
 /*
          <  DISTINCT >
          ��ȸ�ϰ��� �ϴ� �÷��� �ߺ��� ���� �� �ѹ����� ��ȸ�ϰ� ���� �� ���
          �ش� �÷��� �տ� ���
          
          [ ǥ���� ]
          DISTINCT �÷���
          
          ��, SELECT ���� DISTINCT  ������ �� �Ѱ��� �ۼ� �����ϴ�.
 */
 
 -- EMPLOYEE ���̺�κ��� �μ��ڵ���� ��ȸ
 SELECT DISTINCT DEPT_CODE
 FROM EMPLOYEE;
 
 -- EMPLOYEE ���̺�κ��� �����ڵ���� ��ȸ
 SELECT DISTINCT JOB_CODE
 FROM EMPLOYEE;
 
 -- DEPT_CODE, JOB_CODE �÷��� ���� ��Ʈ�� ��� �ߺ� �Ǻ�
 SELECT DISTINCT DEPT_CODE, JOB_CODE
 FROM EMPLOYEE;
 
 ---------------------------------------------------------------------
 
 /*
     <  WHERE �� >  => ���� �����ϴ� ��(������)
     ��ȸ�ϰ��� �ϴ� ���̺� Ư�� ������ �����ؼ� 
     �� ���ǿ� �����ϴ� �����͸��� ��ȸ�ϰ��� �� �� ����ϴ� ����
       
     
     [ ǥ���� ]
     SELECT �÷���1, �÷���2,  ...
     FROM  ���̺��
     WHERE ���ǽ�;
     
     ������� : FROM�� -> WHERE�� ->SELECT ��
     
     - ���ǽĿ� �پ��� �����ڵ� ��� ����
     
     < �� ������ >
     > , < , >= , <=   (��� ��)
     =    (��ġ�ϴ°�? : �����, �ڹٿ��� ����񱳴� == �̿���)
     != , ^= , <>  (��ġ���� �ʴ°�?)                                        
 */
 
 -- EMPLOYEE  ���̺�κ��� / �޿���  400���� �̻��� �������/ ��� �÷��� ��ȸ 
 SELECT *
 FROM EMPLOYEE
 WHERE  SALARY >= 4000000;
 
 -- EMPLOYEE ���̺�κ��� /�μ��ڵ尡 D9�� ������� /�����, �μ��ڵ�, �޿� ��ȸ
 SELECT  EMP_NAME, DEPT_CODE, SALARY
 FROM EMPLOYEE
 WHERE  DEPT_CODE  = 'D9' ;  -- 23�� �� 3�� ��ȸ /WHERE  �μ��ڵ� �÷��� ���� ����  D9 �� ��ġ�ϴ� ���;
 
 --EMPLOYEE  ���̺�κ���/ �μ��ڵ尡 D9�� �ƴ� ������� /�����, �μ��ڵ�, �޿� ��ȸ
 SELECT EMP_NAME, DEPT_CODE , SALARY
 FROM EMPLOYEE
 WHERE DEPT_CODE != 'D9' ; --23�� �� 20�� ��ȸ?  (NULL �� �����ϰ� 18�� ��ȸ)
 
 -----------     �ǽ����� --------------
 ---1. EMPLOYEE ���̺�κ��� �޿��� 300���� �̻��� ������� �̸�, �޿�, �Ի��� ��ȸ
 SELECT EMP_NAME "�̸�", SALARY "�޿�", HIRE_DATE "�Ի���"
 FROM EMPLOYEE
 WHERE SALARY >= 3000000;
 
 ---2. EMPLOYEE ���̺�κ��� �����ڵ尡 J2�� ������� �̸�, �޿�, ���ʽ� ��ȸ
 SELECT EMP_NAME "�̸�", SALARY "�޿�", BONUS "���ʽ�"
 FROM EMPLOYEE 
 WHERE  JOB_CODE = 'J2';
 
 ---3.EMPLOYEE ���̺�κ��� ���� �������� �����(ENT_YN�� 'N')�� ���,�̸�, �Ի��� ��ȸ
 SELECT EMP_ID "���" , EMP_NAME "�̸�", HIRE_DATE "�Ի���"
 FROM  EMPLOYEE 
 WHERE ENT_YN ='N';
 
 ---4. EMPLOYEE ���̺�κ��� ����(==�޿� *12) �� 5000���� �̻��� ������� �̸�, �޿�, ����, �Ի��� ��ȸ 
 SELECT  EMP_NAME "�̸�", SALARY "�޿�", SALARY*12  "����", HIRE_DATE "�Ի���"
 FROM   EMPLOYEE 
 WHERE  ( SALARY*12 )  >=50000000;   
 --> SELECT  ���� �ο��� ��Ī "����" ��  WHERE ������ �� �� ����!! (��? ���� ���������� )
 
 ---------------------------------------------------------------------------------
 
 /*
       < ��������  >
       ���� ���� ������ ���� �� ���
       
       ~�̸鼭, �׸��� :  AND (�ڹٿ����� && )
       ~�̰ų�, �Ǵ� :  OR (�ڹٿ�����  || )
 */
 
 --EMPLOYEE ���̺�κ��� /�μ��ڵ尡 'D9'�̸鼭 �޿��� 500���� �̻��� /������� �̸�, �μ��ڵ�, �޿� ��ȸ
 SELECT   EMP_NAME, DEPT_CODE, SALARY
 FROM EMPLOYEE
 WHERE DEPT_CODE='D9' AND SALARY >= 5000000;
 
 --EMPLOYEE ���̺�κ��� �μ��ڵ尡 'D6'�̰ų� �޿��� 300���� �̻��� ������� �̸�, �μ��ڵ�, �޿� ��ȸ
 SELECT EMP_NAME, DEPT_CODE, SALARY
 FROM EMPLOYEE
 WHERE DEPT_CODE='D6' OR SALARY >= 3000000;
 
 -- EMPLOYEE ���̺�κ��� �޿��� 350���� �̻��̰� 600���� ������ ������� �̸�, ���, �޿�, �����ڵ� ��ȸ
 SELECT EMP_NAME,EMP_ID,SALARY, JOB_CODE
 FROM EMPLOYEE
 WHERE SALARY >= 3500000 AND SALARY <=6000000;   
 -- WHERE  3500000 <= SALARY <=6000000;  �ȵ�   
 --> ����Ŭ�� ���������� �ڹ�ó�� �ε�ȣ�� ���޾Ƽ� ��� �Ұ�!
 
 ---------------------------------------------------------------------------------------
 
 /*
      <  BETWEEN AND ������ >
      �� �̻� �� ������ ������ ���� ������ ������ �� �ִ� ������
      
      [ ǥ���� ]
      �񱳴���÷��� BETWEEN  ���Ѱ�(�̻�) AND ���Ѱ�(����)
      
      (�񱳴���÷��� ���� ���� ���Ѱ� �̻� �׸��� ���Ѱ� ���ϸ� �����ϴ� ���)    
 */
  -- EMPLOYEE ���̺�κ��� �޿��� 350���� �̻��̰� 600���� ������ ������� �̸�, ���, �޿�, �����ڵ� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE 
WHERE SALARY BETWEEN 3500000 AND 6000000;
 
 
 
 
 
 
 
 
 
 
 
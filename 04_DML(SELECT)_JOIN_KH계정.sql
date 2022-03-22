/*
     < JOIN >
     
     �� �� �̻��� ���̺��� �����͸� ���� ��ȸ�ϰ��� �� �� ���Ǵ� ����
     ��ȸ ����� �ϳ��� �����( ResultSet ) �� ����
     
     ������ �����ͺ��̽������� �ּ����� �����ͷ� ������ ���̺� �����͸� �����ϰ� ����
     ( �ߺ��� �ּ�ȭ�ϱ� ���ؼ� �ִ��� �ɰ��� ������)
     => ��, JOIN ������ �̿��ؼ� �������� ���̺� �� "����"�� �ξ ���� ��ȸ�ؾ� ��
     => ��, ������ JOIN ������ �̿��ؼ� ��ȸ�� �ϴ°� �ƴ϶�
          ���̺� ���� "�����"�� �ش��ϴ� �÷��� ��Ī���Ѽ� ��ȸ�ؾ� ��

       JOIN �� ũ�� "����Ŭ ���� ����"  �� "ANSI(�̱�����ǥ����ȸ) ����"���� ������. 

                 ����Ŭ ���� ����                  |                  ANSI (����Ŭ + �ٸ� DBMS)  ����
     =====================================================================
                    �����                          |        �������� (INNER JOIN) -> JOIN USING / ON                   
                (EQUAL JOIN)                       |       �ܺ�����  ( OUTER JOIN ) -> JOIN USING
     --------------------------------------------------------------------------------------------------------------------           
                    ��������                          |         ���� �ܺ�����   (LEFT OUTER JOIN)
            ( LEFT OUTER JOIN )                  |         ������ �ܺ�����  (RIGHT OUTER JOIN)
            ( RIGHT OUTER JOIN )                |         ��ü �ܺ�����     (FULL OUTER JOIN) => ����Ŭ������ �Ұ�
     ---------------------------------------------------------------------------------------------------------------------
     ī�׽þ� �� (CARTESIAN PRODUCT)     |       �������� (CROSS JOIN)
     ---------------------------------------------------------------------------------------------------------------------
             ��ü���� ( SELF JOIN)                 |              JOIN ON ���� �̿�
        ������ ( NON EQUAL JOIN)        |
     ----------------------------------------------------------------------------------------------------------------------
*/

-- ��ü ������� ���, �����, �μ��ڵ�, �μ������ �˾Ƴ����� �Ѵٸ�? 
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE; --> EMPLOYEE ���̺��� DEPT_CODE �÷�

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT; --> DEPARTMENT ���̺��� DEPT_ID �÷�

-- ��ü ������� ���, �����, �����ڵ�, ���޸��� �˾Ƴ����� �Ѵٸ�?
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE; --> EMPLOYEE  ���̺��� JOB_CODE �÷�

SELECT JOB_CODE, JOB_NAME
FROM JOB;  --> JOB���̺��� JOB_CODE �÷�

--> ������ ���ؼ� ������� �ش�Ǵ� �÷��� ����� ��Ī��Ų�ٸ� ��ġ �ϳ��� ������� ��ȸ �����ϴ�.
-----------------------------------------------------------------------------------------------------------------
 /*
        1.  ����� (EQUAL JOIN)   /   �������� (INNER JOIN)
        �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 �����ؼ� ��ȸ
        (== ��ġ���� �ʴ� ������ ��ȸ�ؼ� ���� )       
 */

-- >> ����Ŭ ���� ����
-- FROM ���� ��ȸ�ϰ����ϴ� ���̺����� ���� ( , �� ���� )
-- WHERE ���� ��Ī��ų �÷��� (�����) �� ���� ������ ������

-- ��ü ������� ���, �����, �μ��ڵ�, �μ����� ���� ��ȸ
--1)  ���� �� �� �÷����� �ٸ� ��� (EMPLOYEE ���̺��� DEPT_CODE / DEPARTMENT ���̺��� DEPT_ID)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID ;
-- >23 ��  21���� ������ ��ȸ��
--> ��? ��ġ���� �ʴ� ���� ��ȸ���� ���ܵ�
--> �� ��쿡���� DEPT_CODE ���� NULL �̿��� 2���� ��������ʹ� ��ȸ�� ���ʿ� �ȵȰ�!
--> DEPARTMENT ���̺��� DEPT_ID �÷���  NULL���� �������� �ʱ� ����
--> �߰������� D3, D4, D7 �μ��ڵ忡 �ش�Ǵ� ������� �������� �ʱ� ������ D3, D4,D7�� ���� �μ��� ������ �ʴ´�!

--���, �����, �����ڵ�, ���޸�
--2) ���� �� �� �÷����� ���� ��� (EMPLOYEE ���̺��� JOB_CODE/ JOB���̺��� JOB_CODE )
/*
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE JOB_CODE=JOB_CODE ;
*/
-- ���� :  ambiguously (�ָ��ϴ�. ��ȣ�ϴ�.) => Ȯ���� �� �÷��� ��� ���̺�κ��� �Դ����� �������� �Ѵ�. 

--���1. ���̺���� ������ִ� ���
-- ���̺��.�÷��� 
SELECT EMP_ID, EMP_NAME, EMPLOYEE. JOB_CODE,  JOB. JOB_CODE, JOB_NAME
FROM EMPLOYEE , JOB
WHERE  EMPLOYEE. JOB_CODE = JOB. JOB_CODE;

-- ���2. ���̺��ٰ� ��Ī�� �ٿ��� �� ��Ī�� ������ִ� ���
--���̺��Ǻ�Ī.�÷���
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, J.JOB_CODE, JOB_NAME
FROM EMPLOYEE E , JOB J  --���̺�� ��Ī
WHERE E. JOB_CODE = J. JOB_CODE;

-->> ANSI ����
-- FROM����  ���̺���� �� �ϳ��� �ۼ� ( ���� ���̺��� ���ؼ� �ۼ�)
-- �� �ڿ��ٰ� JOIN�� �ۼ��Ͽ� ���� ��ȸ�ϰ��� �ϴ� ���̺��� ���, ���� ��Ī��ų �÷� ( �����) �� ���� ���ǵ� ���� ���
-- JOIN ������ ON���� �Ǵ� USING �������� ������� ���� ������ ����Ѵ�. 

--���, �����, �μ��ڵ�, �μ���
-- 1) ������ �� �÷����� �ٸ���� ( EMPLOYEE ���̺��� DEPT_CODE/ DEPARTEMENT ���̺��� DEPT_ID)
-- => �� ���� ������ ON ������ ��밡��
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE  
/* INNER */ JOIN DEPARTMENT ON ( DEPT_CODE=DEPT_ID ); --INNER�� ���� ����

--���, �����, �����ڵ�, ���޸�
-- 2) ������ �� �÷����� ������� (EMPLOYEE���̺��� JOB_CODE / JOB���̺��� JOB_CODE )
--=> ON ����,  USING ���� �� �� ��� ����
-- 2_1) ON ���� ���� : ambiguously �� �߻� �� �� �ۿ� ����.  Ȯ���ϰ� ��ø� ����� ��! (���̺���̵� ��Ī�̵� ���� )
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE=J.JOB_CODE);

--2_2) USING ���� ���� : �÷��� �����ϴ� ���� ( ���ʿ� �÷����� ������ ��쿡�� ��� ������ ����)
--                                 ambiguously�� �߻����� �ʱ� ������ ������ �÷��� �˾Ƽ� ���ָ� ������ ��!
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE) ;

-- [ ���� ] ���� USING ���� ���� �� ���ô�  NATURAL JOIN (�ڿ�����) �̶�� �������ε� ���� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB ;
-- �� ���� ���̺�� ������ ����
-- �� ���Ե� �ΰ��� ���̺� ��ġ�ϴ� �÷��� �����ϰ� �Ѱ� �����ϴ� ���  (JOB_CODE)
--=> �˾Ƽ� ��Ī�� 

-- �߰����� ������ ���� ���� (WHERE �� ���)
-- ������ �븮�� ������� ������ ��ȸ
-->> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE  -- ������ �Ͼ ��� �� ������ �ʼ���
    AND JOB_NAME= '�븮'  ;
-- ���� �� �������� ���̱� ���� ������ ���� �ϳ��� ���� + �鿩���⸦ �־��ش�.  

-->> ANSI ����
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
FROM EMPLOYEE E
--JOIN JOB USING (JOB_CODE)
JOIN JOB J ON(E.JOB_CODE =J.JOB_CODE)
WHERE JOB_NAME='�븮' ;

------------- �ǽ����� ----------------------
--1. �μ��� '�λ������' �� ������� ���, �����, ���ʽ��� ��ȸ
-->> ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE  , DEPARTMENT 
WHERE  DEPT_CODE = DEPT_ID -- ������� ���� ����
    AND DEPT_TITLE ='�λ������';
-->> ANSI ����
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE 
JOIN DEPARTMENT  ON (DEPT_CODE=DEPT_ID)
WHERE DEPT_TITLE='�λ������' ;
--2. �μ��� '�ѹ���'�� �ƴ� ������� �����, �޿�, �Ի����� ��ȸ
--> ����Ŭ ���뱸��
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE=DEPT_ID  -- ������� ���� ����
     AND DEPT_TITLE != '�ѹ���';

--> ANSI ����
SELECT EMP_NAME,SALARY, HIRE_DATE
FROM EMPLOYEE 
JOIN DEPARTMENT  ON (DEPT_CODE=DEPT_ID)
WHERE  DEPT_TITLE !='�ѹ���';

--3. ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
--> ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE= DEPT_ID --  ������� ���� ����
    AND BONUS IS NOT NULL;

--> ANSI ����
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE 
JOIN DEPARTMENT  ON (DEPT_CODE=DEPT_ID)
WHERE BONUS IS NOT NULL;

--4. �Ʒ��� �� ���̺��� �����ؼ� �μ��ڵ� , �μ���, �����ڵ�, ������(LOCAL_NAME)�� ��ȸ
--��Ʈ:
SELECT  * FROM DEPARTMENT; --LOCATION_ID(  �ش� �μ��� ��� ������ �ִ����� �ڵ�ν� �˷��ִ� �÷�)
                                          
SELECT * FROM LOCATION; -- LOCAL_NAME ( �ش� ������ �������� ���� �����ڵ尪�� ���� �÷�)

--> ����Ŭ ���� ����
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT  , LOCATION 
WHERE LOCATION_ID=LOCAL_CODE ;  -- ������� ���� ����

--> ANSI ����
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT 
JOIN LOCATION  ON ( LOCATION_ID=LOCAL_CODE);

-- ���������� �� (���̺� 3�� �̻��� ����)
-- ���, �����, �μ���, ���޸� 
SELECT * FROM EMPLOYEE;      --DEPT_CODE /  JOB_CODE => �����
SELECT * FROM DEPARTMENT;  -- DEPT_ID 
SELECT* FROM JOB;                 --                   JOB_CODE

-->> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E , DEPARTMENT, JOB J
WHERE  DEPT_CODE=DEPT_ID           --������� ���� ����1
     AND E.JOB_CODE= J.JOB_CODE  ;  --������� ���� ����2

-->> ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID) --EMPLOYEE ���̺� DEPARTMENT���̺� ���� ����
JOIN JOB USING (JOB_CODE); -- ��  ������ EMPLOYEE ���̺� JOB�� ���� ����

-- ����� / �������� : ��ġ���� �ʴ� ����� ���ʿ� ��ȸ�� ���� �ʴ´�.
--��) �μ����̺�� ���� �Ҷ� ������̺��� �μ��ڵ尡 NULL�� �ϵ���, �̿��� ����� �����ϰ� ��ȸ�� ��
--     �ش� �μ��� �Ҽ� ����� ���� ���� ���� ������� Ȯ���� �Ұ���


-------------------------------------------------------------------------------------------------------------------
/*
     2. �������� / �ܺ����� ( OUTER JOIN )
     ���̺��� JOIN �� ��ġ���� �ʴ� ��鵵 ���Խ��Ѽ� ��ȸ ����
     ��, LEFT / RIGHT �� �����ؾ� �� ( ������ LEFT / RIGHT  ������ �����϶�� ��)
*/

-- "��ü" ������� �����, �޿�, �μ��� ��ȸ
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON( DEPT_CODE = DEPT_ID);
-- DEPT_CODE�� NULL �� ������� ������ ����
-- �μ��� ������ ����� ���� ��� ( D3, D4, D7) �μ����� ����

-- 1) LEFT OUTER JOIN : �� ���̺� �� ���� ����� ���̺��� �������� JOIN�� �ϰڴ�. 
--                               ��, ���� �Ǿ��� ���� ���� ����� ���� ���̺��� �����ʹ� ������ ��ȸ�ϰ� ��
--                              (��ġ�ϴ°��� ã�� ���ϴ���) 
-->> ANSI  ����
SELECT EMP_NAME, SALARY,DEPT_TITLE
FROM EMPLOYEE 
LEFT /* OUTER */ JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID); --OUTER�� ���� �����ϴ�. 
-- EMPLOYEE ���̺��� �������� ��ȸ�� �߱� ������ EMPLOYEE ���̺� �����ϴ� �����ʹ� ���� �Ǿ��� ���� �ѹ��� �� ��ȸ�ǰԲ� ��

-->> ����Ŭ ���� ����
SELECT EMP_NAME, SALARY,DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE  DEPT_CODE= DEPT_ID(+) ;--������� ���� ����
-- ���� �������� ���� ���̺��� �÷����� �ƴ� �ݴ� ���̺��� �÷��� �ڿ��ٰ� (+)��ȣ�� �ٿ��ش�. 

-- 2) RIGHT OUTER JOIN : �� ���̺� �� ������ ����� ���̺��� �������� JOIN 
--                                  ��, ���� �Ǿ��� ���� ������ ����� ���� ���̺��� �����ʹ� ������ ��ȸ�ϰڴ�.
--                                 (��ġ�ϴ°��� ã�� ���ϴ���)
-->> ANSI  ����
SELECT EMP_NAME, SALARY, DEPT_ID ,DEPT_TITLE
FROM EMPLOYEE
RIGHT  /*OUTER*/   JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);

--> ����Ŭ ���� ����
SELECT EMP_NAME, SALARY, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE  DEPT_CODE(+)= DEPT_ID; -- ������� ���� ����

--LEFT / RIGHT OUTER JOIN �� �⺻������ �/ �������� �� ��� + �������̺��� ������ ����

--3) FULL OUTER JOIN : �� ���̺��� ���� ������� ��ȸ�� �� �ְ� JOIN 
--                               ��, ����Ŭ ���� ���������� �Ұ�
-->> ANSI ����
SELECT EMP_NAME, SALARY, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE
FULL /*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);

-- FULL OUTER JOIN�� �⺻������ � / �������� �� ��� + �������̺��� ������ ���� + ���������̺��� ������ ���� 

-- �������� : ��ġ�ϴ°� + �����Ȱ�  ( ���ؿ� ���� ����� �����Ȱ��� �߰������� �ٸ�)

-->> ����Ŭ ���� ����
SELECT EMP_NAME, SALARY,DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE  DEPT_CODE(+)= DEPT_ID(+); -- ������� ���� ����
-- only one outer-joined table  : �������� �� ������ �Ǵ� ���̺��� �ϳ��� �־�� �Ѵ� ��� ��
-- ����Ŭ ���� ������ FULL OUTER JOIN  �� �Ұ��ϴ�. 

------------------------------------------------------------------------------------------------------------
/*
     3. ī�׽þ� �� (CARTESIAN PRODUCT) /  �������� (CROSS JOIN)
     ��� ���̺��� �� ����� ���μ��� ���ε� ����� ��ȸ�� ( ��� ����� ���� �� ��ڴ�. ������)
     �� ���̺��� ����� ��� ������ ����� ������ �� ��� => ����� ������ ��� => �������� ����
     
     ��) EMPLOYEE ���̺� �� 23���� �� / DEPARTMENT ���̺� �� 9���� ��
     ==> ī�׽þ� �� ( �������� ) �� ��� 
             23 * 9 =207���� �� �� ����� ���� 
*/

-- �����, �μ���
-->> ����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE 
FROM EMPLOYEE, DEPARTMENT; -- 23 * 9 = 207 
-- ī�׽þ� ���� �ַ�  WHERE���� ������� ������ �Ǽ��� �������� ��� �ַ� �߻�
-- (������� ���� ������ �����ߴٴ°��� �׳� ������ ����� ���� �� ��ڴٶ�� ��)

-->> ANSI ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT ; 

-------------------------------------------------------------------------------------------------------------------

/*
     4. ������ (NON EQUAL JOIN)
        '='  (��ȣ, ����񱳿����� ) �� ���� ��� , ��ȣ�� ������� �ʴ� JOIN
       ������ �÷����� ��ġ�ϴ� ��찡 �ƴ϶� , "����"�� ���ԵǴ� ���� �� ��ȸ�ϰڴ�.
*/

-- �����, �޿�
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;

SELECT *
FROM SAL_GRADE;

-- �����, �޿�, �޿���� ( SAL_LEVEL)
-->> ����Ŭ ���� ����
SELECT EMP_NAME, SALARY, SAL_GRADE.SAL_LEVEL , MIN_SAL, MAX_SAL
FROM EMPLOYEE, SAL_GRADE 
--WHERE SALARY >= MIN_SAL  AND  SALARY <=MAX_SAL;    --������� ���� ����
--WHERE SALARY BETWEEN  ���Ѱ� AND ���Ѱ�;
WHERE SALARY BETWEEN  MIN_SAL AND MAX_SAL;

-->> ANSI ����
SELECT EMP_NAME, SALARY, SAL_GRADE.SAL_LEVEL , MIN_SAL, MAX_SAL
FROM EMPLOYEE
JOIN SAL_GRADE ON ( SALARY BETWEEN MIN_SAL AND MAX_SAL ); --���ǽ�
--���ǽ��� ������� �ϱ� ������ ON ������ ����Ѵ�. USING�� �Ⱦ��� 

--������ : �ַ� ������� ���� ���ǽ����� > , < , >=, <=, BETWEEN AND �� �� 

--------------------------------------------------------------------------------------------------------
/*
    5.  ��ü����  (SELF JOIN)
    ���� ���̺��� �ٽ� �ѹ� �����ϴ� ���
    ��,  �ڱ� �ڽ��� ���̺�� �ٽ� ������ �ϴ� ���
*/

SELECT EMP_ID "���",  EMP_NAME "�����", SALARY "�޿�", MANAGER_ID "����� ���"
FROM EMPLOYEE;

-- ��ü���� ���ǻ��� : ���̺���� ������  => �ָŸ�ȣ��!!
--                             �׻� ���̺�� ��Ī�� �ٸ��� �ο��� ������ ����
SELECT * FROM EMPLOYEE E;  -- ����� ���� ������ ��ȸ�� �� E��� ���̺� 
SELECT * FROM EMPLOYEE M; -- ����� ���� ������ ��ȸ�� �� M�̶�� ���̺�

-- ��ü���� ����










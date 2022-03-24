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
-- ����� ���, �����, �μ��ڵ�, �޿� (E�κ���)
-- ����� ���, �����, �μ��ڵ�, �޿� (M���κ���)
-->> ����Ŭ ���� ����
SELECT E.EMP_ID "����� ���" , E.EMP_NAME "�����",E.DEPT_CODE "�μ��ڵ�", E.SALARY"�޿�"
           , M.EMP_ID"����� ���", M.EMP_NAME "�����",M.DEPT_CODE "�μ��ڵ�", M.SALARY "�޿�"
FROM EMPLOYEE E, EMPLOYEE M
WHERE   E.MANAGER_ID = M.EMP_ID(+)  ;--���������������  (������ E���̺��̶�)-> ��������

-->> ANSI ����
SELECT E.EMP_ID "����� ���" , E.EMP_NAME "�����",E.DEPT_CODE "�μ��ڵ�", E.SALARY"�޿�"
           , M.EMP_ID"����� ���", M.EMP_NAME "�����",M.DEPT_CODE "�μ��ڵ�", M.SALARY "�޿�"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M  ON ( E.MANAGER_ID = M.EMP_ID  )  ; --����  (���.����ǻ�� = ���.��� ) -> ���������̶� LEFT �߰� ������ ����!(���)

--�÷� �߰� ����
-- ����� ���, �����, �μ��ڵ�, �μ���, �޿�  (E�κ���)
-- ����� ���, �����, �μ��ڵ�, �μ���, �޿�  (M���κ���)
--  �� 4���� ���̺��� ���� (EMPLOYEE E M, DEPARTMENT D1 D2) 
SELECT E.EMP_ID "����� ���" , E.EMP_NAME "�����",  E.DEPT_CODE "�μ��ڵ�", D1.DEPT_TITLE "��� �μ���",  E.SALARY"�޿�"
         , M.EMP_ID"����� ���", M.EMP_NAME "�����",  M.DEPT_CODE "�μ��ڵ�", D2.DEPT_TITLE "��� �μ���", M.SALARY "�޿�"
FROM EMPLOYEE E 
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID)
LEFT JOIN  DEPARTMENT D1 ON (E.DEPT_CODE=D1.DEPT_ID) --��������̺� D1
LEFT JOIN  DEPARTMENT D2 ON (M.DEPT_CODE=D2.DEPT_ID)  ; --��������̺� D2 LEFT���� ����� ������� �� ���´�. 

----------------------------------------------------------------------------------------------------------------------

/*
     <  ���� JOIN >
     3�� �̻��� ���̺��� �����ϴ� ��
*/
-- ���, �����, �μ���, ���޸�, ������ (LOCAL_NAME)
--EMP_ID,  EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME
SELECT  * FROM EMPLOYEE;      -- DEPT_CODE,  JOB_CODE                      --����� 
SELECT * FROM DEPARTMENT;   -- DEPT_ID ,                      LOCATION_ID
SELECT * FROM JOB;                 --                   JOB_CODE
SELECT * FROM LOCATION;       --                                    LOCAL_CODE

-->>  ����Ŭ ���� ����
SELECT EMP_ID "���",  EMP_NAME "�����"  , DEPT_TITLE "�μ���" , JOB_NAME  "���޸�", LOCAL_NAME "�ٹ�������"
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L
WHERE    E.DEPT_CODE= D.DEPT_ID (+)               --E���̺� DEPT_CODE��  NULL ���� �����Ѵ�.
    AND    E.JOB_CODE=J.JOB_CODE  (+)              --��ġ�ϴ°��� �� ã�Ҵµ� ��ħ �� ��ġ�ؼ� 23���� ���°�=>����� (LEFT���ξ��ص� �ȴ�. ���ǻ� LEFT����)
    AND    D.LOCATION_ID = L.LOCAL_CODE(+)  ;   --E�� D��  LEFT�������� �� ���¿���  D �� L�� �����ϸ� �� ����=>LEFT�������� �ٲ�
    --������� ���� ���� => LEFT �������� �ٲ۴�.

-->> ANSI ���� 
SELECT EMP_ID "���",  EMP_NAME "�����"  , DEPT_TITLE "�μ���" , JOB_NAME  "���޸�", LOCAL_NAME "�ٹ�������"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON( E.DEPT_CODE=D.DEPT_ID) 
LEFT JOIN JOB J USING ( JOB_CODE )                 --ON( E.JOB_CODE=J.JOB_CODE ) �������ο����� USING ����! , INNER���ε� �����ϴ�. (���ǻ� LEFT����) 
LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE); 
--DEPARTMENT���̺��� �������� ������ �Ǳ� ������ DEPARTMENT ���̺� ���ι� ���Ŀ� �ۼ�!
-- >> ANSI �������� ���������� �ۼ��� ��쿡�� JOIN�� ������ �߿��ϴ�.
-- (LOCATION ���̺��� DEPARTMENT���̺��� ���� ���εǸ� ���� �߻�)

--���, �����, �μ���, ���޸�, �ٹ�������, �ٹ�������, �޿���� (SAL_GRADE ���̺�κ���)
--EMP_ID,  EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, SAL_LEVEL
SELECT  * FROM EMPLOYEE;      -- DEPT_CODE,  JOB_CODE                                                         SALARY         --����� 
SELECT * FROM DEPARTMENT;   -- DEPT_ID ,                      LOCATION_ID
SELECT * FROM JOB;                 --                   JOB_CODE
SELECT * FROM LOCATION;       --                                    LOCAL_CODE       NATIONAL_CODE
SELECT * FROM NATIONAL;       --                                                             NATIONAL_CODE
SELECT * FROM SAL_GRADE;      --                                                                                             MIN_SAL/MAX_SAL  

--DEPT_CODE(����) =DEPT_ID
--JOB_CODE(����)=JOB_CODE
--LOCATION_ID(����)=LOCAL_CODE   => �μ����̺� ���� �ڿ� �ۼ�
--NATIONAL_CODE(����)=NATIONAL_CODE
--SALARY BETWEEN MIN_SAL AND MAX_SAL  (������)

-->> ANSI ����
SELECT E.EMP_ID "���"
           , E.EMP_NAME "�����"
           , D.DEPT_TITLE "�μ���"
           , J.JOB_NAME "���޸�"
           , L. LOCAL_NAME "�ٹ�������"
           , N. NATIONAL_NAME "�ٹ�������"
           , S. SAL_LEVEL"�޿����"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE =D.DEPT_ID)
LEFT JOIN JOB J ON (E.JOB_CODE=J.JOB_CODE)
LEFT JOIN LOCATION L ON (D.LOCATION_ID=L.LOCAL_CODE)
LEFT JOIN NATIONAL N ON(L.NATIONAL_CODE=N.NATIONAL_CODE)  --���� ����!
       JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);

---------------------- JOIN ���� �ǽ����� ----------------------
-- 1. ������ �븮�̸鼭 ASIA ������ �ٹ��ϴ� ��������
--    ���, �����, ���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����

SELECT E.EMP_ID "���"
           ,E.EMP_NAME "�����"
           ,J.JOB_NAME "���޸�"
           ,D.DEPT_TITLE "�μ���"
           ,L.LOCAL_NAME "�ٹ�������"
           ,E.SALARY "�޿�"
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L
WHERE  E.JOB_CODE=J.JOB_CODE --������� ���޸�
AND E.DEPT_CODE=D.DEPT_ID (+)   --�μ���
AND D.LOCATION_ID=L.LOCAL_CODE (+)--�ٹ�������
AND J.JOB_NAME= '�븮' AND L.LOCAL_NAME LIKE 'ASIA%';

-->> ANSI ����
SELECT E.EMP_ID "���"
           , E.EMP_NAME "�����"
           , J.JOB_NAME "���޸�"
           , D.DEPT_TITLE "�μ���"
           , L.LOCAL_NAME "�ٹ�������"
           , E.SALARY "�޿�"
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE=J.JOB_CODE)
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
LEFT JOIN LOCATION L ON (D.LOCATION_ID=L.LOCAL_CODE)
WHERE J.JOB_NAME = '�븮' AND L.LOCAL_NAME LIKE 'ASIA%';  --���� ����!
 
-- 2. 70�����̸鼭 �����̰�, ���� ������ ��������
--   �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT  E.EMP_NAME "�����"
           , E.EMP_NO "�ֹι�ȣ"
           , D.DEPT_TITLE "�μ���"
           , J.JOB_NAME "���޸�"
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE  E.DEPT_CODE=D.DEPT_ID (+)   --����� --�μ���  
AND     E.JOB_CODE=J.JOB_CODE   --�����ڵ� 
AND E.EMP_NO LIKE  '7%'  
AND SUBSTR(E.EMP_NO,8,1)  IN ('2','4')
AND E.EMP_NAME LIKE '��%' ;
-->> ANSI ����
SELECT  E.EMP_NAME "�����"
           , E.EMP_NO "�ֹι�ȣ"
           , D.DEPT_TITLE "�μ���"
           , J.JOB_NAME "���޸�"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID )--�����
LEFT JOIN JOB J ON(E.JOB_CODE=J.JOB_CODE)
WHERE E.EMP_NO LIKE  '7%'  AND SUBSTR(E.EMP_NO,8,1) IN ('2','4')
AND E.EMP_NAME LIKE '��%' ;

-- 3. �̸��� '��'�ڰ� ����ִ� �������� 
--    ���, �����, ���޸��� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT E.EMP_ID "���"
           ,E.EMP_NAME "�����"
           , J.JOB_NAME "���޸�"
FROM EMPLOYEE E, JOB J
WHERE  E.JOB_CODE=J.JOB_CODE  --�����
AND E.EMP_NAME LIKE '%��%';
-->> ANSI ����
SELECT E.EMP_ID "���"
           ,E.EMP_NAME "�����"
           , J.JOB_NAME "���޸�"
FROM EMPLOYEE E
LEFT JOIN JOB J ON( E.JOB_CODE=J.JOB_CODE )
WHERE  E.EMP_NAME LIKE '%��%';

-- 4. �ؿܿ������� �ٹ��ϴ� ��������
--    �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT  E.EMP_NAME "�����"
           , J.JOB_NAME "���޸�"
           , E.DEPT_CODE "�μ��ڵ�"
           , D.DEPT_TITLE "�μ���"
FROM EMPLOYEE E , JOB J, DEPARTMENT D
WHERE E.JOB_CODE=J.JOB_CODE  --�����
   AND  E.DEPT_CODE=D.DEPT_ID (+)
   AND D.DEPT_TITLE LIKE '�ؿܿ���%'; 
-->> ANSI ����
SELECT  E.EMP_NAME "�����"
           , J.JOB_NAME "���޸�"
           , E.DEPT_CODE "�μ��ڵ�"
           , D.DEPT_TITLE "�μ���"
FROM  EMPLOYEE E 
LEFT JOIN JOB J USING(JOB_CODE )
LEFT JOIN DEPARTMENT D ON(  E.DEPT_CODE=D.DEPT_ID)
WHERE D.DEPT_TITLE LIKE '�ؿܿ���%'; 

-- 5. ���ʽ��� �޴� ��������
--    �����, ���ʽ�, ����, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT  E.EMP_NAME "�����"
           , E.BONUS "���ʽ�"
           , (E.SALARY+(E.SALARY*E.BONUS))*12 "����"
           , D.DEPT_TITLE "�μ���"
           , L.LOCAL_NAME "�ٹ�������"
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE  DEPT_CODE=DEPT_ID (+) --�����
AND    LOCATION_ID=LOCAL_CODE (+) --��������� ������
AND    BONUS IS NOT NULL ; --���ʽ� �޴� ����  

-->> ANSI ����
SELECT E.EMP_NAME "�����"
           , E.BONUS "���ʽ�"
           , E.SALARY+(E.SALARY*E.BONUS) "����"
           , D.DEPT_TITLE "�μ���"
           , L.LOCAL_NAME "�ٹ�������"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(DEPT_CODE=DEPT_ID)  --�����
LEFT JOIN LOCATION L ON(LOCATION_ID=LOCAL_CODE ) --�����
WHERE BONUS IS NOT NULL ;

-- 6. �μ��� �ִ� ��������
--    �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT E.EMP_NAME "�����"
          , J.JOB_NAME "���޸�"
           , D.DEPT_TITLE "�μ���"
           , L.LOCAL_NAME "�ٹ�������"
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L -- ���̺�
WHERE E.JOB_CODE=J.JOB_CODE 
  AND  E.DEPT_CODE= D.DEPT_ID 
  AND  D.LOCATION_ID = L.LOCAL_CODE ; --����� ����������
 -- AND  DEPT_TITLE IS NOT NULL;  --����
  
-->> ANSI ����

SELECT E.EMP_NAME "�����"
          , J.JOB_NAME "���޸�"
           , D.DEPT_TITLE "�μ���"
           , L.LOCAL_NAME "�ٹ�������"
FROM  EMPLOYEE E
 JOIN JOB J ON (E.JOB_CODE=J.JOB_CODE)  --����� ������
 JOIN DEPARTMENT D ON( E.DEPT_CODE= D.DEPT_ID )
 JOIN LOCATION L ON ( D.LOCATION_ID = L.LOCAL_CODE  );
--WHERE  DEPT_TITLE IS NOT NULL; 

-- 7. '�ѱ�' �� '�Ϻ�' �� �ٹ��ϴ� ��������
--    �����, �μ���, �ٹ�������, �ٹ��������� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT  E.EMP_NAME "�����"
           , D.DEPT_TITLE "�μ���"
           , L.LOCAL_NAME "�ٹ�������"
           , N.NATIONAL_NAME "�ٹ�������"
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N 
WHERE  E.DEPT_CODE=D.DEPT_ID (+) --����� ������
  AND    D.LOCATION_ID = L.LOCAL_CODE 
  AND   L.NATIONAL_CODE=N.NATIONAL_CODE 
  AND  N.NATIONAL_NAME IN ('�ѱ�', '�Ϻ�'); --���� IN�� (OR�� =)

-->> ANSI ����
SELECT E.EMP_NAME "�����"
           , D.DEPT_TITLE "�μ���"
           , L.LOCAL_NAME "�ٹ�������"
           , N.NATIONAL_NAME "�ٹ�������"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON ( DEPT_CODE=DEPT_ID ) --����� ������
JOIN LOCATION L ON ( LOCATION_ID = LOCAL_CODE  )
JOIN NATIONAL N USING(NATIONAL_CODE )
WHERE NATIONAL_NAME IN ('�ѱ�', '�Ϻ�');    --����


-- 8. ���ʽ��� ���� �ʴ� ������ �� �����ڵ尡 J4 �Ǵ� J7 �� ��������
--    �����, ���޸�, �޿��� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT E.EMP_NAME "�����"
           , J.JOB_NAME "���޸�"
           , E.SALARY "�޿�"
FROM EMPLOYEE E, JOB J
WHERE  E.JOB_CODE= J.JOB_CODE --�����
  AND  E.BONUS IS NULL    --����
  AND E.JOB_CODE IN ('J4', 'J7');

-->> ANSI ����
SELECT E.EMP_NAME "�����"
           , J.JOB_NAME "���޸�"
           , E.SALARY "�޿�"
FROM EMPLOYEE E
JOIN JOB J USING (JOB_CODE)
WHERE BONUS IS NULL 
AND  JOB_CODE IN ('J4', 'J7');

-- 9. ���, �����, ���޸�, �޿����, ������ ��ȸ�ϴµ�
--    �� ��, ���п� �ش��ϴ� ����
--    �޿������ S1, S2 �� ��� '���'
--    �޿������ S3, S4 �� ��� '�߱�'
--    �޿������ S5, S6 �� ��� '�ʱ�' ���� ��ȸ�ǰ� �Ͻÿ�
-->> ����Ŭ ���� ����
SELECT   E.EMP_ID "���"
             ,E.EMP_NAME "�����"
            , J.JOB_NAME "���޸�"
            ,DECODE(SAL_LEVEL ,'S1','���','S2', '���'  ,
                          'S3',' �߱�','S4', '�߱�' ,'S5','�ʱ�','S6' ,'�ʱ�') "�޿����"
FROM EMPLOYEE E, JOB J
WHERE  E.JOB_CODE = J.JOB_CODE;  --�����
--AND   E.SAL_LEVEL = S.SAL_LEVEL
--AND  E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL ; 

-->> ANSI ����
SELECT  E.EMP_ID "���"
             ,E.EMP_NAME "�����"
            , J.JOB_NAME "���޸�"
            ,DECODE(SAL_LEVEL ,'S1','���','S2', '���'  ,
                          'S3',' �߱�','S4', '�߱�' ,'S5','�ʱ�','S6' ,'�ʱ�') "�޿����"
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE );
--JOIN SAL_GRADE S ON(E.SAL_LEVEL = S.SAL_LEVEL)
--WHERE E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL ;  
--�� Ʋ������?? USING �Ⱦ��� ON�� ���� �ذ��

-- 10. �� �μ��� �� �޿����� ��ȸ�ϵ�
--     �� ��, �� �޿����� 1000���� �̻��� �μ���, �޿����� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT NVL(DEPT_TITLE,'����') , SUM(SALARY)
FROM EMPLOYEE   , DEPARTMENT  
WHERE DEPT_CODE= DEPT_ID (+)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) >= 10000000;
-- GROUP BY�� DEPT_CODE�� �ؼ� �� �������� �����µ� DEPT_TITLE�� �ϴϱ� �ذ��

-->> ANSI ����
SELECT NVL(DEPT_TITLE,'��ġ���� ����'), SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE= DEPT_ID) --�����
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) >= 10000000;

-- 11. �� �μ��� ��ձ޿��� ��ȸ�Ͽ� �μ���, ��ձ޿� (����ó��) �� ��ȸ�Ͻÿ�
--     ��, �μ���ġ�� �ȵ� ������� ��յ� ���� �����Բ� �Ͻÿ�
--> ����Ŭ ���� ����
SELECT D.DEPT_TITLE, FLOOR(AVG(E.SALARY))
FROM EMPLOYEE  E, DEPARTMENT D
WHERE E.DEPT_CODE=D.DEPT_ID 
GROUP BY D.DEPT_TITLE ;
--HAVING �������� ��µ� ������ . =>WHERE���� �ٲ�

-->> ANSI ����
SELECT D.DEPT_TITLE, ROUND(AVG(E.SALARY))
FROM EMPLOYEE  E
JOIN DEPARTMENT D ON(E.DEPT_CODE=D.DEPT_ID )
GROUP BY D.DEPT_TITLE ;


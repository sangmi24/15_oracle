/*
   < SUBQUERY ��������>
   
   �ϳ��� �ֵ� SQL �� (SELECT, INSERT, UPDATE, CREATE, ... )�ȿ� ���Ե� SELECT  ��
   ���� SQL���� ���� ���� ������ �ϴ� ������
*/

-- ���� �������� ����
-- ���ö ����� ���� �μ��� �����
--1) ���� ���ö ����� �μ��ڵ带 ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME='���ö'; --���ö ����� �μ��ڵ�� D9���� �˾Ƴ�

--2) �μ��ڵ尡 D9�� ������� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE='D9';

--3) ���� �� �������� ��ü
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE=( SELECT DEPT_CODE
                               FROM EMPLOYEE
                                WHERE EMP_NAME='���ö');
                                
--���� �������� ���� 2
--��ü ����� ��� �޿����� �� ���� �޿��� �ް��ִ� ������� ���, �̸�, �����ڵ� ��ȸ
--1) ��ü ����� ��� �޿��� �켱 ���ϰڴ�.
SELECT AVG(SALARY)
FROM EMPLOYEE; --�뷫������ 3,047,662�� ����

--2) �޿��� �뷫 3,047,662�� ���� �̻��� ����鸸 ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3047662 ;

--3) ���� �� �ܰ踦 ��ü��Ű��
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM  EMPLOYEE
WHERE SALARY >=(SELECT AVG(SALARY)
                            FROM EMPLOYEE);
------------------------------------------------------------------------------------------------
/*
      �������� ����
      ���������� ������ ������� ���� ��̳Ŀ� ���� �з���
      
      -  ������ ���Ͽ� �������� :  �������� �κ��� ������ ������� ������ 1���϶�  
      -  ������ ���Ͽ� �������� :  �������� �κ��� ������ ������� ���� ���϶� (������)
      -  ������ ���߿� �������� :  �������� �κ��� ������ ������� ���� ���϶� (������)
      -  ������ ���߿� �������� :  �������� �κ��� ������ ������� ���� �� , ���� ���϶� 
      
      => ���������� �⺻������ WHERE ��, HAVING ���� ���� ������  (WHERE ��,HAVING�� �� ���ǽ� ����) 
           ���������� ������ ����� ���� ��̳Ŀ� ���� ��� ������ �������� ������ �޶�����. 
      
      �߰������� ) "�ζ��� ��" => ���������� ���������ε� FROM ���� ���� ��������
            
*/

/*
        1.  ������ ���Ͽ� ��������  (SINGLE ROW SUBQUERY)
         ���������� ��ȸ ����� ������ 1���� ��� (1ĭ)
         
         �Ϲ� ������ ��� �� ���� (=, !=, <=, >=, IS NULL, ....)
*/

-- �� ������ ��� �޿����� �� ���� �޴� ������� �����, �����ڵ�, �޿� ��ȸ
--1) �켱������ ��� �޿��� ���ϱ� (�������� �κ�)
SELECT AVG(SALARY)
FROM EMPLOYEE;  --3047662
--> ������� 1�� 1��, ������ 1���� ��

--2) �޿��� 3047662�� �̸��� ������� �����, �����ڵ� , �޿� ��ȸ  (�������� �κ�)
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY  < 3047662 ;

--3) ��ġ��
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY  < (SELECT AVG(SALARY)
                            FROM EMPLOYEE ) ;

-- �����޿��� �޴� ����� ���, �����, �����ڵ�, �޿�, �Ի��� ��ȸ
--1) �����޿����� ������ (�������� �κ�)
SELECT MIN(SALARY)
FROM EMPLOYEE; --1380000
--> ������� 1��1��, ������ 1���� ��

--2) ������ 1380000�� ����� ���� ���ϱ� (�������� �κ�)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY =1380000 ;

--3) ��ġ��
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY =(SELECT MIN(SALARY)
                          FROM EMPLOYEE) ;

--���ö ����� �޿����� �� ���� �޴� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
--1) �켱 ���ö ����� �޿��� ���ϱ� (��������)
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME='���ö'; --3700000
--> ����� 1�� 1��, ������ 1���� ��

--2) ������ 3700000���� ū ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ (��������)
SELECT EMP_ID, EMP_NAME, DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY > 3700000;

--3) ��ġ��
SELECT EMP_ID, EMP_NAME, DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY > ( SELECT SALARY
                            FROM EMPLOYEE
                            WHERE EMP_NAME='���ö');

-- ���ö ����� �޿����� �� ���� �޴� ������� ���, �̸�, �μ���, �޿� ��ȸ
--1) �켱 ���ö ����� �޿��� ���ϱ� (��������)
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME='���ö';  --3700000
--> ����� 1�� 1��, ������ 1���� ��

--2) ������ 3700000���� ū ������� ���, �̸�, �μ���, �޿� ��ȸ (�������� �κ�)
-->> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE , DEPARTMENT 
WHERE DEPT_CODE=DEPT_ID(+)  --������� ���� ���� , LEFT����
   AND SALARY >3700000;      

--3) ��ġ��
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE , DEPARTMENT 
WHERE DEPT_CODE=DEPT_ID(+)  
   AND SALARY >(SELECT SALARY
                         FROM EMPLOYEE
                         WHERE EMP_NAME='���ö');      
-- ���ε� �Բ� �����ϴ�

-->> ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE 
LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
WHERE  SALARY >(SELECT SALARY
                          FROM EMPLOYEE
                          WHERE EMP_NAME='���ö');  
                          
-- ������ ����̶� ���� �μ��� ������� ���, �̸�, �޴�����ȣ, ���޸� ��ȸ
--��, ������ ��� ������ �����ϰ� ��ȸ�Ұ�
--1) �켱 ������ ����� �μ�  (�������� �κ�)
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������'; --D1


--2) �μ��ڵ尡 D1�� ������� ���, �̸�, �޴�����ȣ, ���޸� ��ȸ
-->����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, PHONE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE=J.JOB_CODE  --������� ���� ���� (���ʴ� NULL �� ���� ������ ����θ� ���ָ� ��)
  AND   DEPT_CODE= 'D1'      --�߰����� ����1
  AND EMP_NAME  != '������';   --�߰����� ����2

--3) ��ġ��
SELECT EMP_ID, EMP_NAME, PHONE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE=J.JOB_CODE     --������� ���� ����
AND   DEPT_CODE= ( SELECT DEPT_CODE    --�߰����� ���� 1
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '������')      
AND EMP_NAME  != '������';                 --�߰����� ����2

-->>ANSI ����
SELECT EMP_ID, EMP_NAME, PHONE, JOB_NAME
FROM EMPLOYEE 
JOIN JOB USING (JOB_CODE ) --(���ʴ� NULL �� ���� ������ ����θ� ���ָ� ��)
WHERE DEPT_CODE= ( SELECT DEPT_CODE    --�߰����� ���� 1
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '������')      
AND EMP_NAME  != '������'; 

-- �μ��� �޿� ���� ���� ū �μ� �ϳ����� ��ȸ ( �μ��ڵ�, �μ���, �޿� ��)
--0) �μ��� �޿� ��
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--1) �μ��� �޿� ���� �ִ�  (�������� �κ�)
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;  -- 17700000

--2) �޿� ���� 17700000�� �ϳ����� ��ȸ (�μ��ڵ�, �μ���, �޿� ��)
-->> ����Ŭ ���� ����
SELECT DEPT_CODE, DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE , DEPARTMENT 
WHERE DEPT_CODE=DEPT_ID(+)   --������� ���� ����
GROUP BY DEPT_CODE , DEPT_TITLE
HAVING SUM(SALARY) = '17700000' ; --�߰����� ���� (�׷��Լ��� ������ ���ǽ��̶� HAVING���� �ۼ�)

--3) ��ġ��
SELECT DEPT_CODE, DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE , DEPARTMENT 
WHERE DEPT_CODE=DEPT_ID(+)   --������� ���� ����
GROUP BY DEPT_CODE , DEPT_TITLE
HAVING SUM(SALARY) = ( SELECT MAX(SUM(SALARY))
                                      FROM EMPLOYEE
                                      GROUP BY DEPT_CODE) ;--�߰����� ���� (�׷��Լ��� ������ ���ǽ��̶� HAVING���� �ۼ�)

-->> ANSI ����
SELECT DEPT_CODE, DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
GROUP BY DEPT_CODE , DEPT_TITLE
HAVING SUM(SALARY) = ( SELECT MAX(SUM(SALARY))
                                      FROM EMPLOYEE
                                      GROUP BY DEPT_CODE) ;

------------------------------------------------------------------------------------------------------------
/*
    2. ������ ���Ͽ� ��������  (MULTI ROW SUBQUERY)
    ���������� ��ȸ ������� �������� ��
       --IN�����ڴ� OR�� ����񱳸� ���Ѵ�. /    ( )�ȿ� ���������� ���� �ȴ�.
                      
       IN : ��ġ�� �ǹ�       
     - �÷��� IN( 10,20,30,40 )  �������� : �������� ����� �߿��� �԰��� ��ġ�ϴ� ���� �ִٸ� /
                                              NOT IN (~~)  ��ġ�ϴ� ���� ������ �̶�� �ǹ�
       ANY : �ϳ����� �ǹ�                                       
     - �÷��� > ANY (10,20,30 ) �������� : �������� ����� �߿��� "�ϳ���" Ŭ ���
                                                          ��, �������� ����� �߿��� ���� ���������� Ŭ ���
     - �÷��� < ANY (10,20,30 ) �������� : �������� ����� �߿��� "�ϳ���" ���� ���
                                                         ��, �������� ����� �߿��� ���� ū������ ���� ���
      ALL : ����� �ǹ�
     - �÷��� > ALL  (10,20,30) �������� : �������� ������� "���" ������ Ŭ ���
                                                         ��, �������� ����� �߿��� ���� ū ������ Ŭ ���
     - �÷��� < ALL (10,20,30 ) �������� : �������� ������� "���"������ ���� ���
                                                         ��, �������� ����� �߿��� ���� ���������� ���� ���                             
*/

-- �� �μ��� �ְ�޿��� �޴� ����� �̸�, �����ڵ�, �޿� ��ȸ
--1) �켱������ �� �μ��� �ְ�޿� �÷����� ��ȸ�ؾ���  (�������� �κ�)
       --=> ������ ���Ͽ��� ������ �ϱ� ������ 
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- ( 2890000,3660000,8000000,3760000,3900000,2490000,2550000 ) =>���߿� �Ұ�ȣ �ȿ� �� ����
--> ������� 7�� 1�� , �� 7���� ��

--2) ���� �޿��� �޴� ������� ��ȸ  (�������� �κ�) 
SELECT EMP_NAME,JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (2890000,3660000,8000000,3760000,3900000,2490000,2550000 ) ;
/*WHERE SALARY = 2890000
     OR SALARY = 3660000
     OR SALARY =8000000
    ....  OR�� =�� =>IN  */
 
 --3) ��ġ��
 SELECT EMP_NAME,JOB_CODE, SALARY
 FROM EMPLOYEE
 WHERE SALARY IN (SELECT MAX(SALARY)
                            FROM EMPLOYEE
                            GROUP BY DEPT_CODE);

-- ������ �Ǵ� ����� ����� ���� �μ��� ������� ��ȸ�Ͻÿ� (�����, �μ��ڵ�, �޿�)
--1) ������ �Ǵ� ����� ����� �μ��ڵ� ��ȸ (�������� �κ�)
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN( '������' , '�����'); 
          --EMP_NAME='������' OR EMP_NAME='�����' ;--'D9' , 'D6' =>�Ұ�ȣ �ȿ�
--> ������� 2�� 1��, �� 2���� �����

--2) �μ��� 'D9'�̰ų� 'D6' �� ������� ��ȸ (�������� �κ�)
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D9', 'D6');
--WHERE DEPT_CODE = 'D9' OR DEPT_CODE='D6';

--3) ��ġ��
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN (  SELECT DEPT_CODE
                                    FROM EMPLOYEE
                                    WHERE EMP_NAME IN( '������' , '�����') );

-->> ����Ŭ �������� ǰ
-- ��� < �븮 < ���� < ���� < ����
--�븮 �����ӿ��� �ұ��ϰ� ���� ���޺��� �޿��� �� ���� �޴� �������� ��ȸ (���, �̸�, ���޸�, �޿�)

--1) �켱������ ���� ���޵��� �޿��� �� �߷����� �� (�������� �κ�)
SELECT SALARY
FROM EMPLOYEE E , JOB J
WHERE  E.JOB_CODE= J.JOB_CODE-- ������� ���� ����
    AND  J.JOB_NAME= '����';    --�߰����� ���� (���޸��� ������ ���) --2200000, 2500000,3760000=> �Ұ�ȣ �ȿ� 
 --> ������� 3�� 1��, �� 3���� �����
 
--2_1)  ���� �޿����� ���� �޿��� �޴� ������� ��ȸ (�������� �κ�_1)   
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE= J.JOB_CODE  -- ������� ���� ����
  AND  SALARY > ANY (  2200000, 2500000,3760000) ; -- �߰����� ���� (�ϳ��� ���� ���������� Ŭ���� �� ��ȸ�ϰڴ�.)

--2_2) ���޸��� �븮 ���� �߰� (�������� �κ� �ϼ�)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE= J.JOB_CODE  -- ������� ���� ����
  AND  SALARY > ANY (  2200000, 2500000,3760000)  -- �߰����� ���� (�ϳ��� ���� ���������� Ŭ���� �� ��ȸ�ϰڴ�.)
  AND J.JOB_NAME= '�븮'; --�߰����� ����2
  
--3)   ��ġ��
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE= J.JOB_CODE  --������� ���� ����
 AND   SALARY > ANY (  SELECT SALARY
                                    FROM EMPLOYEE E , JOB J
                                    WHERE  E.JOB_CODE= J.JOB_CODE --�������� �������� ������� ���� ����
                                    AND  J.JOB_NAME= '����' ) -- �߰����� ����1
AND  J.JOB_NAME= '�븮';         --�߰����� ����2                  

-->> ANSI�������� ǰ
--���� �����ӿ��� �ұ��ϰ� ��� ���� ������ �޿����ٵ� �� ���� �޴� �������� ��ȸ ( ���, �̸�, ���޸�, �޿�)
-- 1) �켱������ ���� ���޵��� �޿��� �˾ƾ� �� (�������� �κ�)
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME= '����'; --2800000,1550000,2490000,2480000 => �Ұ�ȣ �ȿ� 
--> ������� 4�� 1��, �� ������� ������ 4�� 

--2)  ���� �����ӿ��� �Ұ��ϰ� ���� �޿����� ��� ū �ݾ��� �޿��� �޴� ������� ��ȸ(�������� �κ�)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME='����'
  AND  SALARY > ALL( 2800000,1550000,2490000,2480000);

--3) ��ġ��
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME='����'
  AND  SALARY > ALL( SELECT SALARY
                                FROM EMPLOYEE
                                JOIN JOB USING (JOB_CODE)
                                WHERE JOB_NAME= '����');

--������ �ȴٸ� ������ ���Ͽ� �������ε� �ٲ㺸��, ���� ���� ���� �ٲ㼭�� �غ���

--------------------------------------------------------------------------------------------------------------

/*
         3. ������ ���߿� �������� 
         ��ȸ ������� �� �������� ������ �÷� ���� ���� �� �϶�
         (������ )= (������)
         (���� �÷��� ) = (���������κ�)
        => ������ �¾� �������� �� 
*/

--������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش�Ǵ� ������� ��ȸ ( �����, �μ���, �����ڵ�, �Ի���)

--1) �켱������ ����������� �μ��ڵ�, �����ڵ带 �˾Ƴ��� �� (��������)
SELECT DEPT_CODE , JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME= '������';  -- 'D5' , 'J5'
--> ������� 1�� 2�� , ������� 2�� 

--2) �μ��ڵ尡 D5�̰� �����ڵ尡 J5�� ������� �̸�, �μ��ڵ�, �����ڵ�, �Ի��� (�������� �κ�)
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE='D5' 
      AND JOB_CODE= 'J5';

--���� ) ��ġ�� => ������ ���Ͽ� �������� ���� (��, ���ǿ� ���� ���������� ������ �þ)
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE=  (SELECT DEPT_CODE
                                 FROM EMPLOYEE
                                  WHERE EMP_NAME='������' )  --(����������� �μ��ڵ带 �����ִ� ������) 
      AND JOB_CODE= (SELECT JOB_CODE
                                FROM EMPLOYEE
                                WHERE EMP_NAME= '������' ) ;--(����������� �����ڵ带 �����ִ� ������)

--3) ��ġ�� => ������ ���߿� �������� ����
SELECT  EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE ( DEPT_CODE, JOB_CODE ) = (SELECT DEPT_CODE , JOB_CODE
                                                    FROM EMPLOYEE
                                                    WHERE EMP_NAME= '������');   --�ݵ�� ������ �� ������� ��!
 
 /*
 SELECT  EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE ( DEPT_CODE, JOB_CODE ) = ('D5','J5');
  */                                                                                          
-- ������ �� ������ ��ȿ���� �ʱ� ������ ��ĥ �� ������ �����ؼ� ������ ��!

-- �ڳ��� ����� ���� �����ڵ�, ���� �������� ���� ������� ���, �̸�, �����ڵ�, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE --(�����ڵ�, ������) =(�ڳ������� �����ڵ�, �������� ��ȸ�ϴ� ������)
        (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                                  FROM EMPLOYEE
                                                 WHERE EMP_NAME ='�ڳ���'); 

--------------------------------------------------------------------------------------------------------------------------------------

/*
      4. ������ ���߿� ��������
      �������� ��ȸ ������� ������ �������� ���
      (������ )   IN  (������)
      (�����÷��� )   IN  (��������)
      => ������ ���缭 �ۼ��ؾ���
*/
-- �� ���޺� �ּ� �޿��� �޴� ����� ��ȸ ( ���, �̸�, �����ڵ�, �޿�)
--1) �켱 �� ���޺� �ּ� �޿��� ��ȸ  (�������� �κ�)
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;
-- ('J2', 3700000), ('J7',1380000),('J3',3400000),('J6',2000000),('J5',2200000),('J1',8000000)('J4',1550000)
--> ������� 7��2��, �� ������� 14�� => �ະ�� ���� ó���ߴ��� �� 7���� ���� 

--2) ���� ��ϵ� �߿��� ��ġ�ϴ� ���
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) = ('J2', 3700000)
    OR  (JOB_CODE, SALARY) = ('J7',1380000)
    OR  (JOB_CODE, SALARY) = ('J3',3400000)
    OR  (JOB_CODE, SALARY) = ('J6',2000000)
    OR  (JOB_CODE, SALARY) = ('J5',2200000)
    OR  (JOB_CODE, SALARY) = ('J1',8000000)
    OR  (JOB_CODE, SALARY) = ('J4',1550000)
--�ǹ̴� �ľ��� �ǳ� ������ ���� �ʴ� ���� 

--���� ������  IN ������ �������� �ٲ㺸�� (�������� �κ�)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (('J2', 3700000), ('J7',1380000),('J3',3400000)
                                              ,('J6',2000000),('J5',2200000),('J1',8000000),('J4',1550000));
--IN�����ڷδ� �ٴ�� �񱳰� ���� 

--3)��ġ��
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN ( SELECT JOB_CODE, MIN(SALARY)
                                                FROM EMPLOYEE
                                                GROUP BY JOB_CODE);

--�� �μ��� �ְ� �޿��� �޴� ����� ��ȸ ( ���, �̸� , �μ��ڵ�, �޿�)
--1) �켱������ �� �μ��� �ְ� �޿��� ���ؾ� �� (�������� �κ�)
SELECT NVL(DEPT_CODE,'����'), MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
--('����',2890000) ,('D1',3660000),('D9',8000000),('D5',3760000),('D6',3900000),('D2',2490000),('D8',	2550000)
--> 7�� 2�� , ��14�� => ���� �������� �������� ������ �� �� 7����

--2) �� �μ��� ���� �޿����� �޴� ����� ��ȸ (�������� �κ�)
SELECT EMP_ID, EMP_NAME, NVL(DEPT_CODE,'����'), SALARY
FROM EMPLOYEE
WHERE (NVL (DEPT_CODE,'����'),  SALARY ) IN ( ('����',2890000) ,('D1',3660000),('D9',8000000)
                                                                  ,('D5',3760000),('D6',3900000),('D2',2490000),('D8',	2550000));

--3) ��ġ��
SELECT EMP_ID, EMP_NAME, NVL(DEPT_CODE,'����'), SALARY
FROM EMPLOYEE
WHERE  (NVL (DEPT_CODE,'����'),  SALARY ) IN (SELECT NVL(DEPT_CODE,'����'), MAX(SALARY)
                                                                    FROM EMPLOYEE
                                                                    GROUP BY DEPT_CODE) 
ORDER BY SALARY DESC;       --�������̸� ���� ���� ����( �׻� �������� �����)
                                          --���������� ORDER BY �� �ۼ�!

/*                                                                    
SELECT EMP_ID, EMP_NAME, NVL(DEPT_CODE,'����'), SALARY
FROM EMPLOYEE
WHERE  (DEPT_CODE,  SALARY ) IN (SELECT DEPT_CODE, MAX(SALARY)
                                                                    FROM EMPLOYEE
                                                                    GROUP BY DEPT_CODE) ;     
*/                                                                    
-- �������� : NULL  ���� ���Ե� ��� �ݵ�� NVL�Լ� ó���� ���� 

---------------------------------------------------------------------------------------------------

/*
       5. �ζ��� �� (INLINE VIEW)
       FROM ���� ���������� �����ϴ� ��
       
       FROM ���̺��
       FROM ( �������� ) => FROM ResultSet
       
       ���������� ������ ��� (ResultSet) �� ���̺� ��ſ� �����
*/

-- ���ʽ� ���� ������ 3000���� �̻��� ������� ���, �̸�, ���ʽ��� ������ ����, �μ��ڵ带 ��ȸ
--1) �ζ��κ並 �� �� ���� (���̺�κ��� ��ȸ�ϰڴ�) 
SELECT EMP_ID "���", EMP_NAME "�̸�", (SALARY +(SALARY*NVL(BONUS,0)))*12 "���ʽ� ���� ����", DEPT_CODE "�μ��ڵ�"
FROM EMPLOYEE
WHERE  (SALARY +(SALARY*NVL(BONUS,0)))*12 >= 30000000;

--2) �ζ��κ並 �� ���� ( ����Ʈ�����κ��� ��ȸ�ϰڴ�.)
SELECT "���" , "�̸�", "���ʽ� ���� ����", "�μ��ڵ�"
FROM (SELECT EMP_ID "���", EMP_NAME "�̸�", (SALARY +(SALARY*NVL(BONUS,0)))*12 "���ʽ� ���� ����", DEPT_CODE "�μ��ڵ�"
           FROM EMPLOYEE )
WHERE  "���ʽ� ���� ����" >= 30000000;

-->> �ζ��κ並 �ַ� ����ϴ� ��
-- TOP-N �м� : �����ͺ��̽� ���� �ִ� �ڷ� �� �ֻ��� �� ���� �ڷḦ ���� ���� ����ϴ� �м� ���

-- �� ���� �� �޿��� ���� ���� ���� 5���� �̸�, �޿��� ��ȸ
-- * ROWNUM : ����Ŭ���� �����ϴ� �÷�,  ��ȸ�� ������� 1���� ������ �ο����ִ� �÷� 
SELECT ROWNUM, EMP_NAME, SALARY   --3      
FROM EMPLOYEE                                   -- 1
WHERE  ROWNUM <= 5                        -- 2
--5�� �ȿ� ���==��ȣǥ���ڰ� 5���ϴ�.  
ORDER BY SALARY DESC;                        --4
--> ������ ����� �ٸ��� ���׹��� ���´�. 

-- �������� : TOP-N  �м��� �Ϸ��� �ϴ� ������ �ϰ� �� ������ ��ȣǥ�� �ο������ �ϴµ� SELECT���� ���� ���� �� �� ������ �ٲ�� �ֱ� ����
-- �ذ��� : ������ ���� �Ͼ�Բ� �������� ����

SELECT ROWNUM "����" ,EMP_NAME "�̸�" , SALARY "�޿�"  --SELECT�� 4
FROM ( SELECT *                                --�������� �κ�  1 / ���������� ������ FROM�� 2
           FROM EMPLOYEE
           ORDER BY SALARY DESC)         -- ��������� ORDER BY���� SELECT������ ���� ����ǰԲ� ���ִ� ȿ��
WHERE ROWNUM <=5;                      -- WHERE�� 3

-- FROM ���� �ζ��κ信 ��Ī ���� �ο� ������
--�� ��, ���� ������ SELECT ���� ��Ī.*  �� �ۼ��ϸ� �ش� �ζ��κ��� ��� �÷��� ������ �� �ִ�. 
SELECT ROWNUM, E.*
 FROM (SELECT *
           FROM EMPLOYEE
           ORDER BY SALARY DESC ) E
WHERE ROWNUM <= 5;

--FROM ���� �ζ��κ信 �׷��Լ����� ���Եȴٸ� �׻� ��Ī�� �ٿ���� �Ѵ�. 
-- �� �μ��� ��� �޿��� ���� 3���� �μ��� �μ��ڵ�, ��� �޿� ��ȸ
SELECT ROWNUM, DEPT_CODE, "��� �޿�"
FROM( SELECT DEPT_CODE, AVG (SALARY) "��� �޿�"  -- �׷��Լ� �̿�� ��Ī�� �� ������!
           FROM EMPLOYEE
           GROUP BY DEPT_CODE 
           ORDER BY AVG(SALARY) DESC )
WHERE ROWNUM <= 3;

-- ���� �ֱٿ� �Ի��� ��� 5�� ��ȸ (�����, �޿�, �Ի���)
SELECT ROWNUM "����", E.*
FROM(   SELECT EMP_NAME "�����", SALARY "�޿�", HIRE_DATE "�Ի���"
             FROM EMPLOYEE
             ORDER BY HIRE_DATE DESC ) E
WHERE ROWNUM <=5;             

-- TOP-N �м� ���ǻ��� : �׻� ���� ( ORDER BY ) �Ŀ� �����ű�� (ROWNUM)�� �ؾ���!
--  ORDER BY ���� �׻� ��������� �������̶�
--  ���� �����ų���� �ζ��κ信 �ۼ������ �Ѵٶ�� ��

------------------------------------------------------------------------------------------

/*
     6.  ���� �ű�� �Լ�
     RANK( )  OVER (���ı���) 
     DENSE_RANK( ) OVER (���ı���)
     
     - RANK( ) OVER (���ı���) : ���� 1���� 3���̶�� �Ѵٸ� �� ���� ������ 4���� �ϰڴ�. (���� N���� M���̸� ���������� N+M��)
     - DENSE_RANK( ) OVER(���ı���) :  ����1 ���� 3���̶�� �Ѵٸ� �� ���� ������ ������ 2���� �ϰڴ�. (���� N���� M���̾ ���������� N+1)
     
     ���ǻ��� : SELECT������ �ۼ����� 
*/

-- ������� �޿��� ���� ������� �Űܼ� �����, �޿�, ���� ��ȸ
-- �����ű�� �Լ� �Ⱦ� ����
SELECT EMP_NAME, SALARY, ROWNUM "����"
FROM ( SELECT EMP_NAME, SALARY
            FROM EMPLOYEE
            ORDER BY SALARY DESC );

-- �����ű�� �Լ��� ����� ����
--1) RANK( ) OVER (���ı���) �Լ� ���
SELECT EMP_NAME, SALARY, RANK() OVER( ORDER BY SALARY DESC )"����"
FROM EMPLOYEE;
--> ���� 19�� 2��, �� ���� ������ 21��

--2) DENSE_RANK() OVER(���ı���) �Լ� ���
SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE;

--> ���� 19���� 2��, �� ���� ������  20��

-- 5�������� ��ȸ�ϰڴ�. 
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE
WHERE RANK()  OVER(ORDER BY SALARY DESC) <= 5; 
--> ���� : ������ �Լ��� WHERE���� �ۼ� �Ұ�

-- �ζ��κ信���� ����
SELECT  *
FROM (SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "����"
          FROM EMPLOYEE)
WHERE "����" <= 5 ; 

-- ����) SELECT�� ���������� ������ ��  (* ����)
SELECT EMP_ID, EMP_NAME, *
FROM EMPLOYEE; --����

SELECT  ROWNUM, E.*
FROM (SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "����"
          FROM EMPLOYEE) E
WHERE "����" <= 5 ; 

                                

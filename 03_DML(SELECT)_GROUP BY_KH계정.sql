/*
        < GROUP BY ��>
        �׷��� ������ ������ ������ �� �ִ� ����
        => �ش� ���õ� ���غ��� �׷��� ���� �� ����
        
        �������� ������ �ϳ��� �׷����� ��� ó���� �������� ���
*/

-- ��ü ����� �� �޿���
SELECT SUM(SALARY)
FROM EMPLOYEE;
--> ���� ��ȸ�� ��ü ������� �ϳ��� ��� �� ���� ���� ���

--�� �μ��� �� �޿���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- ��ü�����
SELECT COUNT(*)
FROM EMPLOYEE;

-- �� �μ��� �����
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �� �μ��� �� �޿� ���� �μ��� �������� �����ؼ� ��ȸ
SELECT DEPT_CODE, SUM(SALARY) --3.SELECT��
FROM EMPLOYEE    --1. FROM��
GROUP BY DEPT_CODE --2.GROUP BY�� (������ ���� ����� ->SELECT ��)
ORDER BY DEPT_CODE ASC  NULLS FIRST; --4. ORDER BY��
--ORDER BY DEPT_CODE ASC ; --NULL���� ���� ������

-- �� ���޺� �����ڵ�, �� �޿��� ��, ��� ��,  ���ʽ��� �޴� ����� ��, ����� �ִ� ������� ��ȸ
SELECT JOB_CODE, SUM(SALARY) "�޿���" , COUNT(*) "����� "
         , COUNT(BONUS) "���ʽ� �޴� ���", COUNT (MANAGER_ID) "����ִ� ���"
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- �� �μ��� �μ��ڵ�, �����, �ѱ޿���, ��ձ޿�, �ְ�޿�, �ּұ޿� (��, �μ��ڵ庰�� ��������)
SELECT DEPT_CODE "�μ��ڵ�", COUNT(*) "�����", SUM(SALARY) "�ѱ޿���"
           ,ROUND(AVG(SALARY)) "��ձ޿�", MAX(SALARY) "�ְ�޿�", MIN(SALARY) "�ּұ޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;
           
 --���� �� �����
 SELECT DECODE(SUBSTR(EMP_NO,8,1), '1', '��' ,'2','��')  "����" ,COUNT(*) "�����"
 FROM EMPLOYEE
 GROUP BY  SUBSTR(EMP_NO,8,1) ;  --�Լ���, ����� ����
 --GROUP BY "����";  -- GROUP BY�� ��������� �����̱� ������ SELECT������ ������ ��Ī ����� �Ұ��ϴ�!
 
 -------------------------------------------------------------------------------------------

 /*
     < HAVING ��>
      "�׷��Լ��� ����" ������ �����ϰ��� �� �� ���Ǵ� ����
       (�ַ� �׷��Լ��� ������ ������ ��������)
 */

-- �� �μ��� ��� �޿��� 300���� �̻��� �μ��鸸 ��ȸ 
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
WHERE AVG(SALARY) >= 3000000
GROUP BY DEPT_CODE;  --���� ��

SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;
--> WHERE���� HAVING ���� ������: ���ǽĿ� �׷��Լ��� ���� ������ ����!

--�� ���޺� �� �޿� ���� 1000���� �̻��� ���� �ڵ�, �޿� ���� ��ȸ
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >=10000000;

--�� �μ����� ���ʽ��� �޴� ����� ���� �μ����� ��ȸ (BONUS �÷� �������� ����� ������ 0�� ���;� ��)
SELECT DEPT_CODE , COUNT(BONUS) , COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;
 
 --------------------------------------------------------------------------------------------------
 /*
       < ���� ���� >
       * �� ���� �ۼ� ������� �ʱ�
       
    5.   SELECT  * /��ȸ�ϰ����ϴ��÷��� / ���ͷ� / ��������  / �Լ���  AS  "��Ī"
    1.   FROM ��ȸ�ϰ����ϴ����̺��  /  DUAL(�������̺�)
    2.   WHERE ���ǽ�( ���ǻ������δ� ���ǽĿ� �׷��Լ��� ���ԵǸ� �ȵȴٴ� ��)
    3.   GROUP BY �׷���ؿ��ش�Ǵ��÷���  / �Լ���
    4.   HAVING  �׷��Լ��������������ǽ�
    6.   ORDER BY [ ���ı��ؿ��´��÷��� / ��Ī��/ �÷�����]   [ASC/DESC (��������)] [NULLS FIRST/ NULLS LAST  (��������)]   
 
 */
 
 ---------------------------------------------------------------------------------------------------------------------------------------
 
 /*
        < ���� ������ SET OPEARATOR>
        
        ���� ���� SELECT���� ������ �ϳ��� ���������� ����� ������ 
        
        - UNION : ������ (  �� �������� ������ ������� ��� ���� �� �ߺ��Ǵ� �κ��� �ѹ� �� ����) , OR ����
        - INTERSECT : ������ (�� �������� ������ ������� �ߺ��� ����� �κ�), AND  ����
        - UNION ALL : ������ ����� ������ ������ ����
                            (�� �������� ����� �׳� ��ġ�� �ߺ����Ŵ� ���� => �ߺ��� ����� �ι��� ��ȸ�� �� ���� )
        - MINUS : ������ ( ���� ������ ����� ���� ���� ������ ������� ���)
           
         Ư�̻��� : UNION ���꺸�� UNION ALL ������ �ӵ��� �� ���� (�ߺ��� ���� ������ �Ͼ�� �ʱ� ������)
         
         ���ǻ��� : �׻� SELECT ���� �����ؾ� �Ѵ�!
 */
 
 -- 1. UNION ( ������ - �� �������� ������ ������� �������� �ߺ��Ǵ� ����� �ѹ��� ��ȸ )
 -- �μ��ڵ尡 D5�̰ų� �Ǵ� �޿��� 300���� �ʰ��� ������� ��ȸ ( ���, �����, �μ��ڵ�, �޿�)
 
 -- �μ��ڵ尡 D5�� ����鸸 ��ȸ
 SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
 FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5'; --> 6�� ��ȸ( �ڳ���, ������,���ؼ�,�ɺ���,������,���ȥ)
 
 -- �޿��� 300���� �ʰ��� ������� ��ȸ
 SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
 FROM EMPLOYEE
 WHERE SALARY > 3000000; --> 8�� ��ȸ(������,������,���ö,�����,������,�ɺ���,���ȥ,������)
 
  -- �μ��ڵ尡 D5�̰ų� �Ǵ� �޿��� 300���� �ʰ��� ������� ��ȸ ( ���, �����, �μ��ڵ�, �޿�)
 -- UNION �����ڸ� �̿��ؼ� ���� �������� ��ü
 SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
 FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5'
 UNION
 SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
 FROM EMPLOYEE
 WHERE SALARY > 3000000; -->12�� ��ȸ (������,������,���ö,�����,������,�ڳ���,������,���ؼ�,�ɺ���,������,���ȥ,������)
--  12  :  6  +  8  -  2
-- �� ������ SELECT ���� ���ƾ� �Ѵ�!!

-- �μ��ڵ尡 D5�̰ų� �Ǵ� �޿��� 300���� �ʰ��� ������� ��ȸ ( ���, �����, �μ��ڵ�, �޿�)
-- ���� UNION ���� ��� �ϳ��� SELECT ������ ǥ�� ( OR ������ ���)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY >3000000;
--> OR �����ڷ� �� ���� ������ ��� ��ȸ�ϸ� ����� ����!

-- 2. UNION ALL ( �����տ��� �ߺ��� �������� ���� ���� == ������ �κ��� �ι� ��ȸ�� )
-- �μ��ڵ尡 D5�̰ų� �Ǵ� �޿��� 300���� �ʰ��� ������� ��ȸ ( ���, �����, �μ��ڵ�, �޿�) => �ߺ����� X
 -- UNION ALL �����ڸ� �̿��ؼ� ���� �������� ��ü
 SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
 FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5'
 UNION ALL
 SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
 FROM EMPLOYEE
 WHERE SALARY > 3000000; 
 -->14�� ��ȸ ( �ڳ���, ������, ���ؼ�, �ɺ���, ������,���ȥ,������,������,���ö,�����,������,�ɺ���,���ȥ,������)
--  14  :  6  +  8  
--�ߺ����Ÿ� ���� �ʱ� ������ OR������ ��� ����

-- 3. INTERSECT ( ������ - ���� ���� ����� �ߺ��� ������� ��ȸ)
-- �μ� �ڵ尡 D5 �̸鼭 �׸��� �޿� ���� 300���� �ʰ��� ������� ��ȸ (���, �����, �μ��ڵ�, �޿�)
-- INTERSECT �����ڸ� �̿��Ͽ� �ΰ��� ������ ��ģ ����
-- �μ� �ڵ尡 D5�� �����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5'
INTERSECT
-- �޿��� 300���� �ʰ��� �����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;  --> 2�� ��ȸ (�ɺ���, ���ȥ)

-- �Ʒ�ó���� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5'  AND SALARY >3000000;

-- 4. MINUS ( ������ - ���� ���� ������� ���� ���� ����� �� ������ , ���� �߿� )
-- �μ� �ڵ尡 D5�� ����� �߿��� �޿��� 300���� �ʰ��� ������� �����ؼ� ��ȸ (���, �����, �μ��ڵ�, �޿�)
-- MINUS  �����ڸ� �̿��ؼ� �� ������ ��ü
-- �μ� �ڵ尡 D5�� ����� (���� ����)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' --> 6�� ��ȸ( �ڳ���, ������,���ؼ�,�ɺ���,������,���ȥ)
MINUS
-- �޿��� 300���� �ʰ��� ����� (���� ����)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000 ; --> 8�� ��ȸ(������,������,���ö,�����,������,�ɺ���,���ȥ,������)
--> ���� 4�� ��ȸ ( �ڳ���, ������, ���ؼ�, ������)
-- ���� ������ ��� 6�� �߿��� ��ġ�� 2���� �����ϰ� 4���� ��ȸ�Ǿ���. 

-- ���� ���� ���� �ٲ㼭 �׽�Ʈ
-- �޿��� 300���� �ʰ��� ����� (���� ����)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000  --> 8�� ��ȸ(������,������,���ö,�����,������,�ɺ���,���ȥ,������)
MINUS
-- �μ� �ڵ尡 D5�� ����� (���� ����)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' ;--> 6�� ��ȸ( �ڳ���, ������,���ؼ�,�ɺ���,������,���ȥ)
--> ���� 6�� ��ȸ ( ������, ������, ���ö,�����,������,������)
--> ���� ������ ��� 8�� �߿��� ��ġ�� 2���� �����ϰ� 6���� ��ȸ�Ǿ���.

--�Ʒ�ó���� ����
-- �μ� �ڵ尡 D5 �� ����� �߿��� �޿��� 300���� �ʰ��� ������� �����ؼ� ��ȸ (���, �����, �μ��ڵ�, �޿�)
-- �μ� �ڵ尡 D5 �� ����� �߿��� �޿��� 300���� ������ ����鸸 ��ȸ (���, �����, �μ��ڵ�, �޿�)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND SALARY <= 3000000;
--> ���� 4�� ��ȸ ( �ڳ���, ������, ���ؼ�, ������)











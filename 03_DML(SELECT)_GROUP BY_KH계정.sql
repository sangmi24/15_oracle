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
 






















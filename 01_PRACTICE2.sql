--����1
--EMPLOYEE ���̺��� 12�� �����ڿ��� ���� �޼��� ������
--���: OOO�� 12�� OO�� ������ �����մϴ�! 
SELECT EMP_NAME || '�� 12��' || SUBSTR(EMP_NO,5,2) || '�� ������ �����մϴ�'
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,3,2)='12';

--���� 2
--EMP ���̺��� �μ��ڵ�(DEPT_CODE)�� DEPT(DEPT_ID) ���̺��� �����Ͽ� �� �μ��� �ٹ��� ��ġ�� ��ȸ
--�����, �μ��ڵ�, �μ���, �ٹ��� ��ġ ���
--����Ŭ
SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCATION_ID
FROM EMPLOYEE, DEPARTMENT,LOCATION
WHERE DEPT_CODE = DEPT_ID;
--ANSI
SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCATION_ID
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--����3
--EMPLOYEE ���̺��� ���� 200���� �̻� 300���� ������ ����� 
--���, �����, �Ի���, �μ��ڵ�, ���� ��ȸ (��, ������ BONUS ���� �� \999,999,999�� ��ȸ)
SELECT EMP_ID ���, EMP_NAME �����, HIRE_DATE �Ի��� , DEPT_CODE �μ��ڵ�
           ,TO_CHAR( (SALARY+SALARY*NVL(BONUS,0))*12, 'L999,999,999') ����
           -- BONUS�� ���� ��쿡�� �ƿ� ����� ���� �ʾҴ�. 
           --=> NVL(�÷���, �ش��÷�����NULL�� ��� ��ȯ��)���� �ذ�
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000 ;

--����4
--EMPLOYEE ���̺��� ���� PHONE ��ȣ�� 011���� �����ϴ� �����
--�̸�, ���, PHONE, �μ��ڵ带 ��ȸ
SELECT EMP_NAME �̸�, EMP_ID ���,PHONE ����ȣ, DEPT_CODE �μ��ڵ�
FROM EMPLOYEE
WHERE SUBSTR(PHONE,1,3)='011';

--���� 5
--80������ ���� ������ �� ���� '��'���� ����� �ֹι�ȣ, ������ ��ȸ
--��, �ֹι�ȣ�� [888888-2******] ���·� ��ȸ �� ���������� �������� ����
SELECT RPAD(SUBSTR(EMP_NO,1,8),14,'*') �ֹι�ȣ, EMP_NAME ������
FROM EMPLOYEE
WHERE SUBSTR(EMP_NAME,1,1)='��'
ORDER BY ������ ASC;

--����6
--EMPLOYEE ���̺��� �����ڵ带 �ߺ� ����, "���� ����" ��� ��Ī�� �ο��ϰ�
--"���� ����" ������������ �����ؼ� ��ȸ
SELECT DISTINCT JOB_CODE "���� ����"
FROM EMPLOYEE
ORDER BY "���� ����" ASC;

--����7  �𸣰Ծ�!!
--�μ��� �޿� �հ谡 �μ� �޿� ������ 10%���� ���� �μ��� �μ����, �μ��޿� �հ� ��ȸ
--�Ϲ� ������ �������� ���
--�μ���=> DEPARTMENT(DEPT_TITLE) �μ��ڵ� =>DEPT_ID
--�μ��ڵ�=> EMPLOYEE( DEPT_CODE)
--�μ��޿� �հ� => SUM(SALARY) 
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY)> SUM(SALARY)*1.1;











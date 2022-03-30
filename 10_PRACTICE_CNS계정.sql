--BASIC SELECT
-- 1. �� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. ��, ��� �ش��� "�а���", "�迭"���� ǥ���ϵ��� �Ѵ�.
SELECT DEPARTMENT_NAME "�а� ��", CATEGORY "�迭"
FROM TB_DEPARTMENT;

-- 2. �а��� �а� ������ ������ ���� ���·� ȭ�鿡 �������.
SELECT DEPARTMENT_NAME || '�� ������ ' || CAPACITY || '�� �Դϴ�.' "�а��� ����"
FROM TB_DEPARTMENT;

--3. "������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û�� ���Դ�.
--�����ΰ�? (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�� ������ ����)
SELECT STUDENT_NAME "�������ο��л�"
FROM TB_STUDENT S , TB_DEPARTMENT D
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO(+)
AND D.DEPARTMENT_NAME='������а�'
AND S.ABSENCE_YN='Y'
AND SUBSTR(S.STUDENT_SSN,8,1) IN (2,4);

--4. ���������� ���� ���� ��� ��ü�� ���� ã�� �̸��� �Խ��ϰ��� �Ѵ�.
--�� ����ڵ��� �й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�.
--A513079, A513090, A513091, A513110, A513119
SELECT STUDENT_NAME "������⿬ü��"
FROM TB_STUDENT 
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
ORDER BY STUDENT_NAME DESC;

--5. ���������� 20 �� �̻� 30 �� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.
SELECT DEPARTMENT_NAME  �а��̸� , CATEGORY �迭
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

--6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�.
--�׷� �� ������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL; -- = ���� ���ߴµ� NULL���� ���Ϸ��� IS�� ���ؾ� �Ѵ�.

--7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� �Ѵ�.
--��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

--8. ������û�� �Ϸ��� �Ѵ�. �������� ���θ� Ȯ���ؾ� �ϴµ�,
--���������� �����ϴ� ������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

--9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.
SELECT  DISTINCT CATEGORY -- �ߺ��� ���� 
FROM TB_DEPARTMENT
ORDER BY CATEGORY ASC;

--10. 02 �й� ���� �����ڵ��� ������ ������� �Ѵ�.
--������ ������� ������ �������� �л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN='N'
AND STUDENT_NO LIKE 'A2%' --�й��� A2=>�̰��� 02�й�
AND STUDENT_ADDRESS LIKE '%����%';

--1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ���� ������ 
--ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.( ��, ����� "�й�", "�̸�", "���г⵵" �� ǥ�õǵ��� �Ѵ�.)
SELECT STUDENT_NO "�й�", STUDENT_NAME "�̸�", ENTRANCE_DATE "���г⵵"
FROM TB_STUDENT
WHERE DEPARTMENT_NO =002
ORDER BY ENTRANCE_DATE ASC; --�������� ASC�� ��

--2.�� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� �Ѵ�.
--�� ������ �̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����. 
--(* �̶� �ùٸ��� �ۼ���  SQL ������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) != 3; --���̸� ���ϴ°�! LENGTH

--3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. 
--�� �̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�. 
--(��, ���� �� 2000 �� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� �Ѵ�. ���̴� ���������� ����Ѵ�.)
SELECT PROFESSOR_NAME �����̸�,
           FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE('19' || SUBSTR(PROFESSOR_SSN, 1, 6), 'YYYYMMDD')) / 12 ) ����
FROM TB_PROFESSOR 
WHERE SUBSTR(PROFESSOR_SSN,8,1)='1'
ORDER BY ���� ASC;

--4.�������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. 
--��� ����� ?"�̸�"�� �������� �Ѵ�. (���� 2 ���� ���� ������ ���ٰ� �����Ͻÿ�.)
SELECT SUBSTR(PROFESSOR_NAME,2) �̸�
FROM TB_PROFESSOR;

--5.�� ������б��� ����� �����ڸ� ���Ϸ��� �Ѵ�. ��� ã�Ƴ� ���ΰ�? 
--�̶�, 19 �쿡 �����ϸ� ����� ���� ���� ������ �����Ѵ�.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) 
          - LPAD(SUBSTR( STUDENT_SSN,1,2) ,4, '19' ) >=20;

--6. 2020 �� ũ���������� ���� �����ΰ�?
SELECT TO_CHAR(TO_DATE(20201225), 'DAY') ����  --DAY�� ���Ϸ� ����°�
FROM DUAL;

--7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD')  
--�� ���� �� �� �� �� �� ���� �ǹ��ұ�? �� TO_DATE('99/10/11','RR/MM/DD'), 
--TO_DATE('49/10/11','RR/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ��ұ�?

SELECT TO_DATE('99/10/11', 'YY/MM/DD') 
FROM DUAL;  --2099/10/11

SELECT TO_DATE('49/10/11','YY/MM/DD')  
FROM DUAL; --2049/10/11

SELECT TO_DATE('99/10/11', 'RR/MM/DD')
FROM DUAL; --1999/10/11

SELECT TO_DATE('49/10/11','RR/MM/DD') 
FROM DUAL;  --2049/10/11

--8. �� ������б��� 2000�⵵ ���� �����ڵ��� �й��� A �� �����ϰ� �Ǿ��ִ�. 
--2000 �⵵ ���� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

--9. �й��� A517178 �� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. 
--��, �̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� �� �ڸ������� ǥ���Ѵ�.
SELECT ROUND(AVG(POINT),1) ����
FROM TB_GRADE
WHERE STUDENT_NO='A517178'
ORDER BY AVG(POINT);









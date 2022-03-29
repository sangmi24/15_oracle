-- CREATE TABLE ���� �ο��ޱ� ��
CREATE TABLE TEST(
    TEST_ID NUMBER

);
-- 3_1 .  SAMPLE ������ ���̺��� ������ �� �ִ� ������ ���� ������ ���� �߻�
-- insufficient privileges 
-- ������ ����� �ο����� ������ ��Ÿ���� ����

--CREATE TABLE ���� �ο����� ��
CREATE TABLE TEST(
  TEST_ID NUMBER
);
-- 3_2. TABLE SPACE ( ���̺���� ���ִ� ���� )�� �Ҵ� ���� �ʾƼ� ���� �߻�
-- no privileges on tablespace 'SYSTEM' 

--TABLE SPACE �� �Ҵ� ���� ��
CREATE TABLE TEST(
   TEST_ID NUMBER
);
-- ���̺� ���� �Ϸ� 

-- ���� ���̺� ���� ���� (CREATE TABLE) �� �ο��ް� �Ǹ�
-- �ش� ������ ������ �ִ� ���̺���� ����( DML)�ϴ� �͵� ��������
SELECT * FROM TEST;
INSERT INTO TEST VALUES (1);

-- �� ������
--CREATE VIEW ���̸�
--AS (��������);
CREATE VIEW V_TEST
AS (SELECT * FROM TEST);
--4. �� ��ü�� ������ �� �ִ� CREATE VIEW ������ ���� ������ ���� �߻�
-- insufficient privileges

--CREATE VIEW ���� �ο����� ��
CREATE VIEW V_TEST
AS (SELECT * FROM TEST);
-- �� ���� �Ϸ� 

-- SAMLE �������� KH ������ ���̺� �����ؼ� ��ȸ�غ���
SELECT *
FROM KH.EMPLOYEE;
-- 5. KH ������ ���̺� �����ؼ� ��ȸ�� �� �ִ� ������ ���� ������ ���� �߻�
-- table or view does not exist
-- SAMPLE ���� ���忡���� "KH.EMPLOYEE"��� �̸��� ���̺��� �������� �ʱ� ������ ���� ���� �߻�

--SELECT ON ���� �ο� ��
SELECT *
FROM KH.EMPLOYEE;
--EMPLOYEE ���̺� ��ȸ ����

SELECT * 
FROM KH.DEPARTMENT;
--KH ������ DEPARTMENT ���̺� ������ �� �ִ� ������ ���� ������ ���� 

-- SAMPLE �������� KH������ ���̺� �����ؼ� �� �����غ���
INSERT INTO KH.DEPARTMENT VALUES('D0','ȸ���','L2'  );
--6. KH ������ ���̺� �����ؼ� ������ �� �ִ� ������ ���� ������ ���� �߻� 
--table or view does not exist

-- INSERT ON ���� �ο���
INSERT INTO KH.DEPARTMENT VALUES ('D0','ȸ���','L2'  );
--KH.DEPARTMENT ���̺� �� INSERT ����

--Ȯ������ ����� INSERT �� ������ �Ϸ��
COMMIT;

-- ���̺� ������
CREATE TABLE TEST2 (
      TEST_ID NUMBER
);
--7. SAMPLE �������� ���̺��� ������ �� �ִ� ������ ȸ�� �߱� ������ ���� �߻�
--insufficient privileges






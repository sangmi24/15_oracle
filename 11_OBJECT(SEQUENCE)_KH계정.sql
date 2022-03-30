/*
    < ������ SEQUENCE >
    �ڵ����� ��ȣ�� �߻������ִ� ������ �ϴ� ��ü
    �������� �ڵ����� ���������� ��������
    
    ��) ȸ����ȣ, ���, �Խñ۹�ȣ ��� ä�� �� �� �ַ� ���
    
    1. ������ ��ü ���� ����
    [ ǥ���� ]
    CREATE SEQUENCE ��������
    START WITH ���ۼ���                => ó�� �߻���ų ���۰��� ���� 
    INCREMENT BY ������               => �ѹ��� � ������ų���� ����           
    MAXVALUE �ִ밪                    => �ִ밪 ����
    MINVALUE  �ּҰ�                    => �ּҰ� ����     
    CYCLE / NOCYCLE                     => ���� ��ȯ ���� ���� ( CYCLE �� ��ȭ�ϰڴ�. NOCYCLE�� ��ȯ ���ϰڴ�.)
    CACHE ����Ʈũ�� / NOCACHE;  =>ĳ�ø޸� ��� ���� ����
                                                     (CACHE  ����Ʈũ��� ����Ʈũ�⸸ŭ�� ĳ�ø޸𸮸� ����ϰڴ�.
                                                      NOCACHE ĳ�ø޸𸮸� �����ϰڴ�)
     �������� : ��� �������� ���� ����
     
     * ĳ�ø޸� : �̸� �߻��� ������ �����ؼ� �����صδ� �ӽ� �޸� ����
                         �Ź� ȣ���� ������ ������ ��ȣ�� �����ϴ°ͺ���
                         ĳ�ø޸� ������ �̸� ������ ��ȣ���� �����ص״ٰ� ������ ���ԵǸ� �ӵ��� �� ����
                         ��, DB ������ ����� ������ ����Ǿ��ִ� ������ �� ���� (�ӽ� �޸� �����̶�)-��ȸ��!
                         
*/

CREATE SEQUENCE SEQ_TEST;

SELECT *FROM USER_SEQUENCES;
--USER_SEQUENCES : ���� ������ ������ �����ϰ� �ִ� �������鿡 ���� ���� ��ȸ�� ������ ��ųʸ�
-- �⺻ ������
-- MIN_VALUE : 1
-- MAX_VALUE :  9999999999999999999999999999
-- INCREMENT_BY : 1
-- CYCLE_FLAG : N
-- CACHE_SIZE : 20

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*
    2. ������ ��� ����
    ��ȣ�� �߻���Ű�� ����
    
    ��������.CURRVAL : ���� �������� ��  ( ���� ���������� ���������� �߻��� NEXTVAL ���� �� CURRVAL�� �ȴ�)
    ��������.NEXTVAL :  ���������� ������Ű�� ������ �������� ��
                                 ������ ������ ������ INCREMENT BY ����ŭ ������ ��
                                ( ��������.CURRVAL + INCREMENT BY ������ == ��������.NEXTVAL)
    ���ǻ���
    1) ������ ���� �� ù CURRVAL ����? �Ұ���
    2) ������ ���� �� ù NEXTVAL ���� ���۰����� ����
    3) CURRVAL�� ���� �������� ���������� ������ NEXTVAL���� ��Ƶδ� ������ ����!
    4) MAXVALUE, MINVALUE ������ ��� ���� �߻���ų �� ����. 
*/

SELECT SEQ_EMPNO.CURRVAL
FROM DUAL;
-- sequence SEQ_EMPNO.CURRVAL is not yet defined in this session
-- �ѹ��̶� NEXTVAL �� �������� �ʴ� �̻� CURRVAL �� ������ �� ����
-- (CURRVAL �� ���������� ���������� ����� NEXTVAL �� ���� �����ؼ� �����ִ� �ӽð��̱� ������)-��������

SELECT SEQ_EMPNO.NEXTVAL
FROM DUAL; -- 300 
-- NEXTVAL �� ó�� �����ϸ� START WITH ���۰��� ���´�.
-- �������� CURRVAL ���� 300���� ����ɰ�

SELECT SEQ_EMPNO.CURRVAL
FROM DUAL;  --300

SELECT SEQ_EMPNO.CURRVAL
FROM DUAL;  --300  (CURRVAL�� �������� �ʴ´�!0

SELECT SEQ_EMPNO.NEXTVAL
FROM DUAL;  --305

SELECT SEQ_EMPNO.CURRVAL
FROM DUAL;  --305

SELECT * FROM USER_SEQUENCES;
--LAST_NUMBER : ���� ��Ȳ���� NEXTVAL �� ������ ����� ���� ��

--������ : 310
--���簪 : 305
--������ : 5
SELECT SEQ_EMPNO.NEXTVAL
FROM DUAL;  --310

--���簪 : 310
--������ : ������ζ�� 315
--�ִ밪 : 310
SELECT SEQ_EMPNO.NEXTVAL
FROM DUAL;  
-- sequence SEQ_EMPNO.NEXTVAL exceeds MAXVALUE and cannot be instantiated
-- ������ MAXVALUE ��(310)�� �ʰ��߱� ������ ���� �߻�

SELECT SEQ_EMPNO.CURRVAL
FROM DUAL; --310
-- ��������  "����������" �߻��� NEXTVAL ��

/*
    3. ������ ���� ����
    
     [ ǥ���� ]
     ALTER SEQUENCE ��������
     INCREMENT BY ������
     MAXVALUE �ִ밪
     MINVALUE �ּҰ�
     CYCLE / NOCYCLE
     CACHE ����Ʈũ�� / NOCACHE;
     
     * START WITH �� ���� �Ұ� =>�� �ٲٰ� �ʹٸ� ���� �������� �����ߴٰ� �ٽ� ���� 
*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

--�� �ٲ���� ������ ��ųʸ� ��ȸ
SELECT * FROM USER_SEQUENCES;

SELECT  SEQ_EMPNO.CURRVAL
FROM DUAL; --310

--���� : 320
SELECT SEQ_EMPNO.NEXTVAL
FROM DUAL; --320

-- �� �������� CURRVAL �� 320

-- SEQUENCE �����ϱ�
DROP SEQUENCE SEQ_EMPNO;

-------------------������ ��� ���� --------------------------

-- �Ź� ���ο� ����� �߻��Ǵ� ������ ����
CREATE SEQUENCE SEQ_EID
START WITH 300;

-- �� �������� CURRVAL : �ȳ���
-- �� �������� NEXTVAL : 300

-- ����� �߰��� �� EMPLOYEE ���̺� INSERT 
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO,JOB_CODE,SAL_LEVEL,HIRE_DATE)
VALUES( SEQ_EID.NEXTVAL, 'ȫ�浿', '111111-1111111','J2','S3',SYSDATE);

SELECT * FROM EMPLOYEE;

SELECT SEQ_EID.CURRVAL
FROM DUAL; --300

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO,JOB_CODE,SAL_LEVEL,HIRE_DATE)
VALUES( SEQ_EID.NEXTVAL, '��浿', '111111-1111111','J2','S3',SYSDATE);

SELECT SEQ_EID.CURRVAL
FROM DUAL; --301

SELECT SEQ_EID.NEXTVAL
FROM DUAL; --302 => NEXT���� 302�� ���ؼ� �ǵ����� ����. 

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO,JOB_CODE,SAL_LEVEL,HIRE_DATE)
VALUES( SEQ_EID.NEXTVAL, '��浿', '111111-1111111','J2','S3',SYSDATE);

SELECT SEQ_EID.CURRVAL
FROM DUAL; --303

--�ַ� INSERT �������� NEXTVAL�� ���� ����. 


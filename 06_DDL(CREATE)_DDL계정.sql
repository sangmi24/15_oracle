/*
     * DDL  (DATA DEFINITION LANGUAFE)
      ������ ���� ���
     
     ����Ŭ���� �����ϴ� ��ü ( OBJECT )��
     ������ ����� (CREATE), ������ �����ϰ� (ALTER), ���� ��ü�� �����ϴ� (DROP) ��ɹ�
     ��, ���� ��ü�� �����ϴ� ���� �ַ� DB�����ڳ� �����ڰ� �����
     
     ����Ŭ������ ��ü : ���̺� (TABLE) , �� (VIEW), ������ (SEQUENCE), ����� (USER),
                                 ��Ű�� (PACKAGE), Ʈ���� (TRIGGER),  ���ν��� (PROCEDURE), �Լ� (FUNCTION),
                                 ���Ǿ� (SYNONYM) 
*/
/*
     < CREATE TABLE >
     
     ���̺��̶�? :  ��(ROW)�� �� (COLUMN) �� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
                         �׻� ��� �����ʹ� ���̺��� ���ؼ� �����
                         ��, �����͸� �����ϰ��� �Ѵٸ� ���̺��� �����߸� ��
                    
     [  ǥ���� ]   --�ڹٿ����� �ڷ��� �÷����̿��� (����Ŭ�� �ݴ�!)
     CREATE TABLE ���̺�� (   
          �÷��� �ڷ���, 
          �÷��� �ڷ���,
          �÷��� �ڷ���,
          ...   
       ) ;
     
     < �ڷ��� >
     - ���� ( CHAR (������)  / VARCHAR2(������)  ) : ũ��� BYTE ���̴�.
                                                                       ( ����, ������, Ư������ => 1���� �� 1BYTE
                                                                                                  �ѱ� => 1���� �� 3BYTE)
                                                                                                  
                CHAR(����Ʈ��)  :  �������� ���ڿ� (�ƹ��� ���� ���� ������ �������� ä���� ó�� �Ҵ��� ũ�� ����)
                                           �ִ� 2000BYTE ���� ���� ������
                                           => �ַ� ���� ���� ���ڼ��� ���������� �� ����Ѵ�. 
                                           ��) ���� : �� / ��  (3BYTE) , M/F (1BYTE)
                                                �ֹι�ȣ : �������6���� -7����  (14BYTE)
                                                
                VARCHAR2(����Ʈ��) :  �������� ���ڿ� ( �ƹ��� ���� ���� ���� �� ��� ���� ���缭 ũ�Ⱑ �پ��) 
                                                �ִ� 4000BYTE ���� ���� ������
                                                (  VAR�� '����'�� �ǹ��ϰ�, 2�� '�ι�' �� �ǹ��� )
                                                => ���� ���� ���ڼ��� ��Ȯ�ϰ� ���������� ���� �� ����Ѵ�.
                                                ��) �̸�, �̸����ּ�, ���ּ�, ..
     
     - ���� ( NUMBER) : ���� / �Ǽ� ������� NUMBER �̴�.
     
     - ��¥ ( DATE) : ��, ��, ��, ��, ��, �� �� ������ �� �ڷ���
     
     
*/

--  ȸ������ �����͸� ���� �� �ִ� ���̺� �����
--  ���̺�� : MEMBER
--  �÷����� : ���̵�, ��й�ȣ, �̸�, ȸ��������
CREATE TABLE MEMBER (
     MEMBER_ID  VARCHAR2(20) /*��������*/, --�÷��� �ڷ���,  --����Ŭ������ ��ҹ��� ����X, ��Ÿ��ǥ����� �Ұ��ϹǷ� ����ٷ� �ܾ� ���̸� ����
     MEMBER_PWD VARCHAR2(16) ,
     MEMBER_NAME VARCHAR2(15) ,
     MEMBER_DATE DATE
     --���̵𿡴ٰ� � ���������� �߰��ϰڴ� 
);

SELECT * FROM MEMBER; -- ���̺���� �� �ۼ��ߴٸ� ���빰�� ���� ���·� ��ȸ
SELECT * FROM MEMBER2; -- table or view does not exist : ���� ���̺���� ��ȸ�ϰ��� ���� �� �߻��ϴ� ����

/*
    �÷��� �ּ� �ޱ� ( �÷��� ���� ����)
    
    [ ǥ���� ]
    COMMENT ON COLUMN ���̺�.�÷��� IS '�ּ�����' ;
     
*/

COMMENT ON COLUMN MEMBER.MEMBER_ID IS '���̵�';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN MEMBER.MEMBER_DATE IS 'ȸ��������';

-- ����) �ش� ������ � ���̺���� �����ϴ���, � �÷������ �����ϴ��� �� �� �ִ� ���
-- ������ ��ųʸ� : �پ��� ��ü���� ������ �����ϰ� �ִ� �ý��� ���̺� (������)
SELECT * FROM USER_TABLES;
--USER_TABLES : ���� �� ������ ������ �ִ� ���̺���� �������� ������ Ȯ���� �� �ִ� ������ ��ųʸ�

SELECT *FROM USER_TAB_COLUMNS;
-- USER_TAB_COLUMNS :  ���� �� ������ ������ �ִ� ���̺���� ��� �÷����� ������ ��ȸ�� �� �ִ� ������ ��ųʸ�

SELECT* FROM MEMBER;

-- �����͸� �߰��� �� �ִ� ���� ( INSERT : �� �� ������ �߰� , ���� ������ �� ���缭 �ۼ� )
-- INSERT INTO ���̺�� VALUES (ù��°�÷��ǰ�, �ι�°�÷��ǰ�, ����°�÷��ǰ�, ...);
INSERT INTO MEMBER VALUES ('user01', 'pass01', 'ȫ�浿', '2021-02-01' );
INSERT INTO MEMBER VALUES('user02','pass02','�踻��','21/02/02');
INSERT INTO MEMBER VALUES('user03','pass03','�ڰ���',SYSDATE);

--���ʿ� ������ �߻��ؼ� �����Ͱ� ���� ����
INSERT INTO MEMBER VALUES('�����ٶ󸶹ٻ�','PASS04', '�谩��',SYSDATE);
--value too large for column "DDL"."MEMBER"."MEMBER_ID" (actual: 21, maximum: 20)
-- �ִ� 20����Ʈ���� ���� �����ѵ� 21����Ʈ¥�� ���� �־��� �� �߻�

-- ������ �߻����� ����, ��, ��ȿ�� ���� �ƴ� ������ ���� ��Ȳ => ū ���� 
INSERT INTO MEMBER VALUES('user04',NULL, NULL, SYSDATE);
INSERT INTO MEMBER VALUES(NULL,NULL,NULL,SYSDATE);
-- ���̵�, ��й�ȣ, �̸��� NULL  ���� �����ؼ��� �ȵ�

INSERT INTO MEMBER VALUES('user03','pass03','��浿',SYSDATE);
-- �ߺ��� ���̵�� �����ؼ��� �ȵ� 

-- ���� NULL���̳� �ߺ��� ���̵��� ��ȿ���� ���� �����̴�. 
-- ��ȿ�� �����Ͱ��� �����ϱ� ���ؼ��� "��������" �� �ɾ���� �Ѵ�. 

------------------------------------------------------------------------------------------

/*
      < �������� CONSTRAINTS >
      
      - ���ϴ� �����Ͱ��� �����ϱ� ���ؼ� (��ȿ�� ���鸸 �����ϱ� ���ؼ�) Ư�� �÷����� �����ϴ� ����
         ( �ִ� ���� : ������ ���Ἲ ������ �������� �Ѵ� )
      - ���ʿ� ���������� �ο��� �÷��� ���� �����Ϳ� ������ �ִ��� ������ �켱������ �˻��� ����
     
     - ���� : NOT NULL, UNIQUE(���ϳ���), CHECK, PRIMARY KEY(NOT NULL+UNIQUE ��ģ��),  FOREIGN KEY (�ܷ�Ű,(�����) )

     - �÷��� ���������� �ο��ϴ� ��� : �÷����� / ���̺���
*/

/*
      1. NOT NULL ��������
      �ش� �÷�(������) �� �ݵ�� ���� �����ؾ��� ��쿡 ���
      (��, NULL���� ����� ���ͼ��� �ȵǴ� �÷��� �ο�)
      INSERT �� �� / UPDATE �Ҷ��� ����������  NULL ���� ������� �ʵ��� ���� 
      
      ��, NOT NULL ���������� �÷����� ��� �ۿ� �ȵ�
*/

-- NOT NULL �������Ǹ� ������ ���̺� ����� ( ȸ����ȣ, ���̵�, ��й�ȣ, �̸�)
-- �÷����� ��� : �÷��� �ڷ��� �������� => ���������� �ο��ϰ����ϴ� �÷� �ڿ� ��ٷ� ���
CREATE TABLE MEM_NOTNULL (
     MEM_NO  NUMBER NOT NULL  ,
     MEM_ID  VARCHAR2(20) NOT NULL,
     MEM_PWD VARCHAR2(20) NOT NULL,
     MEM_NAME VARCHAR2(20) NOT NULL,
     GENDER CHAR(3) ,
     PHONE VARCHAR2(15) ,
     EMAIL VARCHAR2(30)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1, 'user01','pass01','ȫ�浿','��','010-1111-2222','aaa@naver.com' );

INSERT INTO MEM_NOTNULL VALUES(2, NULL, NULL,NULL,NULL,NULL,NULL);
-- cannot insert NULL into ("DDL"."MEM_NOTNULL"."MEM_ID")
-- NOT NULL  �������ǿ� ����Ǿ� ���� �߻�

INSERT INTO MEM_NOTNULL VALUES(2, 'user02','pass02','�踻��', NULL, NULL,NULL );
INSERT INTO MEM_NOTNULL VALUES(3,'user03','pass03','�ڰ���','��',NULL, NULL);
-- NOT NULL ���������� �ο��Ǿ� �ִ� �÷����� �ݵ�� ���� �����ؾ� ��

-------------------------------------------------------------------------------------------------------

/*
     2. UNIQUE ��������
     �÷��� �ߺ����� �����ϴ� ��������
     ���� (INSERT) / ���� (UPDATE) �� ������ �ش� �÷��� �߿� �ߺ����� ���� ���
     �߰� �Ǵ� ������ ���� �ʰԲ� ����
     
     �÷����� / ���̺��� ��� �� �� ����
*/

--UNIQUE ���������� �߰��� ���̺� ����
--�÷����� ���
CREATE TABLE MEM_UNIQUE (
     MEM_NO NUMBER NOT NULL,
     MEM_ID  VARCHAR2(20) NOT NULL UNIQUE, --�÷����� ��� (������ �� ��� ����� ����) ���� �������
     MEM_PWD VARCHAR2(20) NOT NULL ,
     MEM_NAME VARCHAR2(20) NOT NULL ,
     GENDER CHAR(3),
     PHONE VARCHAR2(15),
     EMAIL VARCHAR2(30)
 );

-- ���̺��� ���
CREATE TABLE MEM_UNIQUE (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    UNIQUE (MEM_ID)   --���̺��� ��� --�������� (�÷���) ����÷��� ��������������ɰ���,
                
 );

--  name is already used by an existing object
--  ���̺�� �ߺ��� �ش� ������ �߻�

-- ���̺��� ������ų �� �ִ� ����
DROP TABLE  MEM_UNIQUE;

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-1234', 'abc@gmail.com');
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '�踻��',NULL, NULL, NULL);

INSERT INTO MEM_UNIQUE VALUES(3, 'user02', 'pass02', '����',NULL, NULL, NULL);
-- unique constraint (DDL.SYS_C007066) violated 
-- UNIQUE �������ǿ� ����Ǿ����Ƿ� INSERT ����
-- �ش� ������������ �������Ǹ��� �˷��� ( ��Ȯ�ϰ� � �÷��� ������ �߻��ߴ��� �÷������� �˷����� ����)
-- => ���� ������ �ľ��ϱ� �����
-- => �������� �ο� �� ���� �������Ǹ��� ���������� ������ �ý��ۿ��� �˾Ƽ� ������ �������Ǹ��� �ο�����
--       (SYS_C~~~)

/*
        *  �������� �ο��� �������Ǹ� �����ϴ� ǥ������
        
        - �÷����� ����� ���
        CREATE TABLE ���̺��  (
            �÷��� �ڷ���  CONSTRAINT �������Ǹ� ��������,
            �÷��� �ڷ��� ,
            ...
        );
        
        - ���̺��� ����� ���
        CREATE TABLE ���̺�� (
            �÷���  �ڷ���,
            �÷���  �ڷ���,
            ...
            �÷���  �ڷ���,
            CONSTRAINT �������Ǹ� �������� (�÷���)
        );
        
      �� ��, �� ��� ��� CONSTRAINT �������Ǹ� �κ��� ���� �����ϴ�.  (SYS_C~~)  
*/

-- �������Ǹ� ���̴� ����
CREATE TABLE MEM_CON_NM (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NN  NOT NULL, --�÷����� ���
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    CONSTRAINT MEM_ID_UQ UNIQUE (MEM_ID) --���̺��� ���
 );

SELECT * FROM MEM_CON_NM;

INSERT INTO MEM_CON_NM VALUES ( 1, 'user01', 'pass01', 'ȫ�浿' ,NULL, NULL, NULL  );
INSERT INTO MEM_CON_NM VALUES( 2, 'user01', 'pass02', '��浿', NULL, NULL, NULL);
-- unique constraint (DDL.MEM_ID_UQ) violated
-- �������Ǹ��� ������ ��쿡�� �÷���, ���������� ������ ������ ��� �����ִ� ���� ���� �ľǿ� �� ������ ��

SELECT * FROM MEM_CON_NM;

INSERT INTO MEM_CON_NM VALUES( 2, 'user02', 'pass02', 'ȫ�浿' , '��' , NULL, NULL  );
--GENDER �÷��� '��' �Ǵ� '��'�� ���Բ� �ϰ� ����

----------------------------------------------------------------------------------------------------

/*
    3. CHECK ��������
    �÷��� ��ϵ� �� �ִ� ���� ���� ������ ������ �� �� �ִ� ��������
    
    CHECK ( ���ǽ�)
*/

-- CHECK ���������� �߰��� ���̺�
CREATE TABLE MEM_CHECK (
   MEM_NO NUMBER NOT NULL,
   MEM_ID  VARCHAR2 (20) NOT NULL UNIQUE,
   MEM_PWD VARCHAR2(20) NOT NULL,
   MEM_NAME VARCHAR2(20) NOT NULL,
   GENDER CHAR(3) CHECK ( GENDER IN('��','��') ),  --GENDER�÷����� '��' �Ǵ� '��' �� ���� �Ѵ�. 
   PHONE VARCHAR2(15),
   EMAIL VARCHAR2(30),
   MEM_DATE DATE NOT NULL
);

SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK VALUES( 1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-1111',NULL, SYSDATE );

INSERT INTO MEM_CHECK VALUES ( 2, 'user02','pass02','�谩��',NULL,NULL, NULL,SYSDATE  );
-- CHECK  �������ǿ� NULL���� INSERT�� ������
-- ���࿡ NULL ���� �������� ���� �ʹٸ� ? NOT NULL�߰�
CREATE TABLE MEM_CHECK2 (
   MEM_NO NUMBER NOT NULL,
   MEM_ID  VARCHAR2 (20) NOT NULL UNIQUE,
   MEM_PWD VARCHAR2(20) NOT NULL,
   MEM_NAME VARCHAR2(20) NOT NULL,
   GENDER CHAR(3) CHECK ( GENDER IN('��','��') ) NOT NULL , --�÷� �������� ������ �ο��� ��� ���� ���� 
   PHONE VARCHAR2(15),
   EMAIL VARCHAR2(30),
   MEM_DATE DATE NOT NULL
 );

INSERT INTO MEM_CHECK VALUES( 3, 'user03', 'pass03', '�踻��', '��', NULL, NULL, SYSDATE);
-- check constraint (DDL.SYS_C007077) violated
-- CHECK ���������� �������� ��� ���� ���� �߻�

SELECT * FROM MEM_CHECK;

-- ȸ���������� �׻� SYSDATE ������ �ް� ���� ��� ���̺� ������ ���� �����ϴ�. (�⺻�� ���� �ɼ�)

/*
     * Ư�� �÷��� ���� ���� ���� �⺻���� ���� �����ϴ�. => DEFAULT 
     (��, ��� �������� ������ �ƴ�)  
*/

-- MEM_CHECK ���̺� ����
DROP TABLE MEM_CHECK;

-- ������ MEM_CHECK ���̺� DEFAULT �������� �߰�
CREATE TABLE MEM_CHECK (
   MEM_NO NUMBER NOT NULL,
   MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
   MEM_PWD VARCHAR2(20) NOT NULL,
   MEM_NAME VARCHAR2(20) NOT NULL,
   GENDER CHAR(3) CHECK (GENDER IN('��', '��')),
   PHONE VARCHAR2 (15),
   EMAIL VARCHAR2 (30),
   MEM_DATE DATE DEFAULT SYSDATE NOT NULL--'���ͷ�' �̷� �������� ������ �ִ�.
   
);

/*
   INSERT INTO ���̺�� VALUES (��1, ��2, ... ); => �׻� ������ ������ �ش� �÷��� ������ ��ġ, ������ ��ġ
  
   INSERT INTO ���̺��(�÷���1, �÷���2, �÷���3 )
   VALUES ( ��1, ��2, ��3 ) ;  => �Ϻ� �÷��鸸 �����ؼ� ���� ���� �� �ִ� ����
*/

INSERT INTO MEM_CHECK VALUES ( 1, 'user01', 'pass01', 'ȫ�浿', '��' , NULL, NULL);
--not enough values
--������ ������ ������� �ʴ�. (���� �÷��� 8��, ������ ���� 7���� �߻��� ���� )

INSERT INTO MEM_CHECK ( MEM_NO, MEM_ID, MEM_PWD, MEM_NAME ) --NOT NULL�� �͵�
VALUES ( 1, 'user01', 'pass01','ȫ�浿' );
-- ������ �ȵ� �÷����� �⺻������ NULL �� ä������ �� ���� �߰���
-- NOT NULL�� �⺻������ ������ ����� �Ѵ�.
-- ���࿡ DEFAULT ������ �Ǿ��ִٸ� NULL���� �ƴ϶� DEFAULT ���� �߰��Ǵ� ���� Ȯ�� �� �� �ִ�!

-- �׷��� DEFAULT ���� ���� �� ó�� ��� ���� �������� INSERT  �ϰ� �ʹٸ�?
INSERT INTO MEM_CHECK VALUES (2, 'user02','pass02','��浿', NULL,NULL,NULL,DEFAULT);
-- DEFAULT ������ �κп� DEFAULT ��� �����ָ� ��

--DEFAULT ������ �ٸ� ���� ��Ƶ� ���� (�׷��� �����������δ� �з����� ����)
INSERT INTO MEM_CHECK VALUES (3, 'user03','pass03','�踻��', NULL,NULL,NULL, '21/03/25');

SELECT * FROM MEM_CHECK;

-----------------------------------------------------------------------------------------------------------------

/*
      4. PRIMARY KEY ( �⺻Ű ) ��������
      ���̺��� �� ����� ������ �����ϰ� �ĺ����� �� �ִ� �÷��� �ο��ϴ� ��������
      => �� �� ���� ���� ���� ������ �� �ִ� �ĺ����� ���� ( JAVA����  MAP��  Ű ��)
      ��) ���, �й�, �����ȣ, �ֹ���ȣ , ���̵�, ȸ����ȣ 
      => �ߺ����� �ʰ� ���� �����ؾ߸� �ϴ� �÷��� PRIMARY KEY �ο� ( UNIQUE + NOT NULL)
      
      ��, �� ���̺� �� �Ѱ��� PRIMARY KEY �������Ǹ� �����ؾ� ��
      -  PRIMARY KEY ���������� �÷� �Ѱ����ٰ��� �Ŵ°�    : �⺻Ű
      -  PRIMARY KEY ���������� �÷� �������� ��� �ѹ��� �Ŵ� �� : ����Ű     
*/

-- PRIMARY KEY ���������� �߰��� ���̺� ���� ( �÷����� ���)
 CREATE TABLE MEM_PRIMARY1 (  --MEM_PRIMARYKEY1��� �ؾ� �ϴµ� �߸� ��(����ǹ����� �׳� ��)
     MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY,  --�÷����� ��� 
     MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
     MEM_PWD VARCHAR2(20) NOT NULL,
     MEM_NAME VARCHAR2(20) NOT NULL,
     GENDER CHAR (3) CHECK (GENDER IN ('��','��' )),
     PHONE VARCHAR2(15),
     EMAIL VARCHAR2(30),
     MEM_DATE DATE DEFAULT SYSDATE --DEFAULT ���� �� ���� NOT NULL �� �ȳ־ ��

 );

SELECT * FROM MEM_PRIMARY1; 

INSERT INTO MEM_PRIMARY1
VALUES(1, 'user1', 'pass01','ȫ�浿', '��',NULL, NULL,DEFAULT);

--�ߺ����� ���ǳ�?
INSERT INTO MEM_PRIMARY1
VALUES(1,'user2','pass02','�踻��',NULL,NULL,NULL,DEFAULT);
-- unique constraint (DDL.MEM_PK) violated
-- �⺻Ű �÷��� �ߺ����� �� ��� UNIQUE ���������� �����ߴٰ� ���� �߻�
-- �� ���, �������Ǹ��� ���� ��Ȯ�� UNIQUE �� �����Ѱ��� PRIMARY KEY �� �����Ѱ��� ã�ư��� ��
-- �׷��� PRIMARY KEY �� ��� �������Ǹ��� ���̴� ������ ������ ! (������ ���̺��_PK)

--NULL ���� ���ǳ�?
INSERT INTO MEM_PRIMARY1
VALUES(NULL, 'user2','pass02','�踻��',NULL, NULL,NULL, DEFAULT);
--cannot insert NULL into ("DDL"."MEM_PRIMARY1"."MEM_NO")
-- �⺻Ű �÷��� NULL���� �� ���  NOT NULL���������� �����ߴٰ� ���� �߻�
-- (������. ���̺��.�÷��� )

INSERT INTO MEM_PRIMARY1
VALUES(2,'user2', 'pass02', '�踻��', NULL, NULL,NULL,DEFAULT);

--���̺��� ������� PRIMARY KEY �������� �ɱ�
CREATE TABLE MEM_PRIMARYKEY2(
      MEM_NO NUMBER,
      MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
      MEM_PWD VARCHAR2(20) NOT NULL,
      MEM_NAME VARCHAR2(20) NOT NULL,
      GENDER CHAR(3) CHECK (GENDER IN ('��', '��')),
      PHONE VARCHAR2(15),
      EMAIL VARCHAR2(30),
      MEM_DATE DATE DEFAULT SYSDATE,
      CONSTRAINT MEM_PK2  PRIMARY KEY (MEM_NO) --���̺��� ���  (�÷���)     
);
--name already used by an existing constraint
--�ƹ��� �ٸ� ���̺��� �������� �̴��� �������Ǹ��� �ߺ��Ǽ��� �ȵ�

-- ����Ű : ���� �÷��� ��� �ѹ��� PRIMARY KEY ���������� �ִ� ��
CREATE TABLE MEM_PRIMARYKEY3(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE

 );
-- table can have only one primary key
-- PRIMARY KEY �� �� ���̺� �ΰ��� �� �� ����. 
-- ��, �� �÷��� �ϳ��� ���  PRIMARY  KEY  �ϳ��� ���� �����ϴ�.

CREATE TABLE MEM_PRIMARYKEY3(
     MEM_NO NUMBER,
     MEM_ID VARCHAR2(20),
     MEM_PWD VARCHAR2(20) NOT NULL,
     MEM_NAME VARCHAR2(20) NOT NULL,
     GENDER CHAR(3) CHECK (GENDER IN ('��', '��')),
     PHONE VARCHAR2(15),
     EMAIL VARCHAR2(30),
     MEM_DATE DATE DEFAULT SYSDATE,
     PRIMARY KEY (MEM_NO, MEM_ID) --�÷��� ��� PRIMARY  KEY �ϳ��� ���� : ����Ű
                                              --CONSTRANINT�� ���� �����ϸ� ������ SYS ��¼�� �� ����
);

INSERT INTO MEM_PRIMARYKEY3
VALUES (1, 'user01','pass01','ȫ�浿' ,NULL, NULL, NULL, DEFAULT);

SELECT * FROM MEM_PRIMARYKEY3;

INSERT INTO MEM_PRIMARYKEY3
VALUES (1, 'user02','pass02','�迵��', NULL, NULL, NULL, DEFAULT);
--���� �ȳ� (MEM_NO, MEM_ID)�� ��� PRIMARY KEY�� ���⶧����
--����Ű�� ��� �ش� �÷��� ���� ������ ������ �� ��ġ�ؾ߸� �ߺ����� �Ǻ�
--���� �ϳ��� ���� �ٸ���쿡�� �ߺ����� �Ǻ��� �ȵ�!

INSERT INTO MEM_PRIMARYKEY3
VALUES (2, NULL, 'pass02', '�迵��',NULL, NULL, NULL, DEFAULT);
-- cannot insert NULL into ("DDL"."MEM_PRIMARYKEY3"."MEM_ID")
-- ����Ű�� ��� ����Ű�� �ش��ϴ� �÷����� �߿��� �ϳ��� NULL  �� ���� �ȵ�

---------------------------------------------------------------------------------------------------------

/*
    5. FOREIGN KEY (�ܷ�Ű ) ��������
    �ش� �÷��� �ٸ� ���̺� �����ϴ� ���� ���;ߵǴ� �÷��� �ο��ϴ� �������� (������� �����)
    
    ����) KH  �������� EMPLOYEE ���̺��� JOB_CODE �÷��� ���� ������
            �ݵ�� JOB ���̺��� JOB_CODE �÷��� ���� ����� �̷���� �־�� �Ѵ�. (�� �̿ܿ� ���� ������ �ȵ�)
            -> EMPLOYEE ���̺� ���忡�� JOB ���̺��� �÷����� ����� ���� ���� ( == �����Ѵ�)
            -> EMPLOYEE ���̺� ���忡�� JOB ���̺��� �θ����̺� �̶�� ǥ�� ����
            -> JOB ���̺� ���忡�� EMPLOYEE ���̺��� �ڽ����̺��̶�� ǥ�� ���� 

       =>  "�ٸ� ���̺� ( �θ����̺�)�� �����Ѵ�" ��� ǥ��   (REFERENCES ��� Ű���带 ���)   
             ��, ������ �ٸ� ���̺��� �����ϰ� �ִ� ���� �ش� �ܷ�Ű ���������� �ɷ��ִ� �÷��� ���� �� �ִ�. 
       =>  FOREIGN KEY ������������ �ٸ� ���̺���� ���踦 ���� �� �� �ִ�. (== JOIN �� ����)     
          
          [ ǥ���� ]
          - �÷����� ���
          �÷��� �ڷ��� CONSTRAINT �������Ǹ� REFERENCES ���������̺��(�������÷���)   --�θ����̺�
                                        -- CONSTRAINT �������Ǹ� �� ���� �����ϴ� ->SYS~                                    
           
          - ���̺��� ���
          CONSTRAINT �������Ǹ� FOREIGN KEY (�������������÷���) REFERENCES ���������̺�� (�������÷���)
          
          ��, �� ��� ��� �������÷����� ���� �����ϴ�.
          �� ��� �⺻������ ���������̺��� PRIMARY KEY �÷����� �������÷����� �ڵ����� ������. 
          CONSTRAINT �������Ǹ��� ���� �����ϴ�. (SYS_C~)
          
*/

-- �׽�Ʈ�� ���� �θ� ���̺� ����
-- ȸ�� ��޿� ���� ������ (����ڵ�, ��޸�) �� �����ϴ� ���̺�
CREATE TABLE MEM_GRADE (
        GRADE_CODE  CHAR(2) PRIMARY KEY,
        GRADE_NAME  VARCHAR2(20) NOT NULL

);

INSERT INTO MEM_GRADE VALUES( 'G1' ,  '�Ϲ�ȸ��' );
INSERT INTO MEM_GRADE VALUES( 'G2' ,  '���ȸ��');
INSERT INTO MEM_GRADE VALUES( 'G3' ,  'Ư��ȸ��');

SELECT * FROM MEM_GRADE;

--�ڽ����̺� (�ܷ�Ű �������� �ɾ��)
CREATE TABLE MEM (
   MEM_NO NUMBER PRIMARY KEY,
   MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
   MEM_PWD VARCHAR2(20) NOT NULL,
   MEM_NAME VARCHAR2(20) NOT NULL,
   GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE),  --�÷����� ���
   GENDER CHAR(3) CHECK (GENDER IN ('��', '��') ),
   PHONE VARCHAR2(15),
   EMAIL VARCHAR2(30),
   MEM_DATE DATE DEFAULT SYSDATE

);

INSERT INTO MEM
VALUES(1,'user01', 'pass01', 'ȫ�浿', 'G1', NULL, NULL, NULL, DEFAULT);

INSERT INTO MEM
VALUES(2,  'user02', 'pass02', '�踻��', 'G2', NULL, NULL, NULL, DEFAULT);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '����', 'G1', NULL, NULL, NULL, DEFAULT);

SELECT *FROM MEM;

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '�ڰ���', NULL, NULL, NULL, NULL, DEFAULT);
--�ܷ�Ű ���������� �ɷ��ִ� �÷����� �⺻������  NULL ���� �� �� �ִ�. 
--�����Ҷ��� NULL���� �ȳ��´�. (�θ����̺���  NULL���� �����ϱ�)

INSERT INTO MEM
VALUES(5, 'user05', 'pass05', '��浿', 'G5', NULL, NULL, NULL, DEFAULT);
-- integrity constraint (DDL.SYS_C007140) violated - parent key not found
-- parent key not found
-- G5 ����� �θ����̺��� MEM_GRADE ���̺��� GRADE_CODE�÷����� �����ϴ� ���� �ƴϱ� ������ ���� �߻�

SELECT * FROM MEM;

-- ���� )  �θ����̺� (MEM_GRADE) ���� �����Ͱ��� �����ȴٸ�?
--MEM_GRADE ���̺�κ��� GRADE_CODE �� G1�� �����͸� �����
DELETE FROM  MEM_GRADE--���̺��
WHERE  GRADE_CODE='G1' ;--��������������;
-- integrity constraint (DDL.SYS_C007140) violated - child record found
-- child record found 
-- �ڽ����̺� (MEM) �߿� G1�̶�� ���� ����ϰ� �ִ� ����� �����ϱ� ������ �θ� ���� ������ ���� ����
-- ���� �ܷ�Ű �������� �ο� �� �߰������� �����ɼ��� �ο����� �ʾ���
-- �ڽ����̺��� ����ϰ� �ִ� ���� ���� ��� ������ ���� �ʴ� "���� ���� �ɼ�"�� �⺻������ �ɷ�����

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G3';  --�ڽ����̺��� ���ǰ� �ִ� ���� �ƴϱ� ������ ������ ������

SELECT * FROM MEM_GRADE; --G3�� �����Ǿ���. 

-- �׵��� �׽�Ʈ�ߴ��� �ǵ�����
ROLLBACK;

-- MEM ���̺� ����
DROP TABLE  MEM;  --���̺��;

/*
     * �ڽ� ���̺��� ���� �� ( �ܷ�Ű ���������� �ο� �� )
       �θ� ���̺��� �����Ͱ� �����Ǿ��� �� �ڽ����̺����� ��� ������ ���� ���ؼ� ó���� �� ��������
       �ɼ����� ���س��� �� ����
       
       *FOREIGN KEY ���� �ɼ�
       - ON DELETE RESTRICTED :  ���� �ɼ��� ������ �������� �ʾ��� �� ( �⺻�� ) => ���� ����
       - ON DELETE SET NULL : �θ����͸� ���� �� �ش� �����͸� ����ϰ� �ִ� �ڽĵ����͸� NULL�� ����
       - ON DELETE CASCADE : �θ����͸� ���� �� �ش� �����͸� ����ϰ� �ִ� �ڽĵ����͵� ���� ����
*/

-- 1)  ON DELETE SET NULL : �θ����� ���� �� �ش� �����͸� ����ϰ� �ִ� �ڽĵ����͸� NULL�� �����ϴ� �ɼ�
CREATE TABLE MEM(
   MEM_NO NUMBER PRIMARY KEY,
   MEM_ID  VARCHAR2(20)  NOT NULL UNIQUE,
   MEM_PWD VARCHAR2(20) NOT NULL,
   MEM_NAME VARCHAR2(20) NOT NULL,
   GRADE_ID CHAR(2) ,
   GENDER CHAR(3) CHECK (GENDER IN ('��', '��')),
   PHONE VARCHAR2(15),
   EMAIL VARCHAR2(30),
   MEM_DATE DATE DEFAULT SYSDATE,
   FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)  ON DELETE SET NULL     --���̺��� ���
);

INSERT INTO MEM
VALUES(1,'user01', 'pass01', 'ȫ�浿', 'G1', NULL, NULL, NULL, DEFAULT);

INSERT INTO MEM
VALUES(2,  'user02', 'pass02', '�踻��', 'G2', NULL, NULL, NULL, DEFAULT);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '����', 'G1', NULL, NULL, NULL, DEFAULT);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '�ڰ���', NULL, NULL, NULL, NULL, DEFAULT);

SELECT * FROM MEM;

-- �θ����̺�(MEM_GRADE)�� GRADE_CODE�� G1�� ������ ����
DELETE FROM MEM_GRADE
WHERE GRADE_CODE='G1';
--�������� �� ������ ��
--�ڽ����̺�(MEM) �� GRADE_ID�� G1�� �κ���?
SELECT * FROM MEM; --> NULL������ �ٲ�

SELECT * FROM MEM_GRADE;

--�׵��� �׽�Ʈ�ߴ��� �ǵ�����
ROLLBACK; --����Ȱ��� �ٽ� ������ (G1�����ߴ����� �ٽ� ���ƿ� )

-- MEM ���̺� ����
DROP TABLE MEM;

--2) ON DELETE CASCADE : �θ����͸� ���� �� �ش� �����͸� ����ϰ� �ִ� �ڽ� �����͵� ���� �����ϴ� �ɼ�
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
   MEM_ID  VARCHAR2(20)  NOT NULL UNIQUE,
   MEM_PWD VARCHAR2(20) NOT NULL,
   MEM_NAME VARCHAR2(20) NOT NULL,
   GRADE_ID CHAR(2) ,
   GENDER CHAR(3) CHECK (GENDER IN ('��', '��')),
   PHONE VARCHAR2(15),
   EMAIL VARCHAR2(30),
   MEM_DATE DATE DEFAULT SYSDATE,
   FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE --���̺��� ���

);

INSERT INTO MEM
VALUES(1,'user01', 'pass01', 'ȫ�浿', 'G1', NULL, NULL, NULL, DEFAULT);

INSERT INTO MEM
VALUES(2,  'user02', 'pass02', '�踻��', 'G2', NULL, NULL, NULL, DEFAULT);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '����', 'G1', NULL, NULL, NULL, DEFAULT);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '�ڰ���', NULL, NULL, NULL, NULL, DEFAULT);



--  �θ����̺� (MEM_GRADE) �� G1�� ����
DELETE FROM MEM_GRADE
WHERE GRADE_CODE='G1' ; --�θ����̺� �ȿ� �ִ� GRADE_CODE��
-- �������� �� ������
-- �ڽ����̺� (MEM) �� GRADE_ID �� G1�� �����?
SELECT * FROM MEM; -- �Բ� ������ �Ǿ���� 

SELECT * FROM MEM_GRADE;

--[ ���� ]
-- �ܷ�Ű�� ����  
-- ��ü ȸ���� ȸ����ȣ, ���̵�, ��й�ȣ, �̸�, ��޸� ��ȸ
-->> ����Ŭ ���� ����
SELECT MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GRADE_NAME
FROM MEM, MEM_GRADE
WHERE  GRADE_ID= GRADE_CODE (+); --������� ���� ����
-->> ANSI ����
SELECT MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GRADE_NAME
FROM MEM
LEFT JOIN MEM_GRADE ON (GRADE_ID= GRADE_CODE);

/*
    ���� �ܷ�Ű ���������� �ɷ����� �ʴ��� JOIN�� ������
    �ٸ�, �� �÷��� ������ �ǹ��� �����͸� ����ִٸ� ��Ī�ؼ� JOIN�ؼ� ��ȸ ������
*/

ROLLBACK; --��������

DROP TABLE MEM; --����

--   [  ���� ]  ���������� �̿��� ���̺� ���� ( ���̺� ������ ���� )
/*
   --- ���⼭���ʹ� KH�������� �����ؼ� �׽�Ʈ ---
   
   * SUBQUERY �� �̿��� ���̺� ���� (���̺� ���� �ߴ� ����) ������ ���� ��
   �������� : ���� SQL �� (SELECT, CREATE, INSERT, UPDATE) �� �������� �ϴ� ������ (SELECT)
   
   [ ǥ���� ]
   CREATE TABLE ���̺�� 
   AS (��������);
   
   �ش� ���������� ������ ����� �̿��ؼ� ������ ���̺��� �����ϴ� ���� 

*/

-- EMPLOYEE ���̺��� ������ ���ο� ���̺� ���� (EMPLOYEE_COPY)
CREATE TABLE EMPLOYEE_COPY 
AS ( SELECT *
       FROM EMPLOYEE  );
-- > �÷���, ��ȸ����� �����Ͱ����� �� ����� + ���������� ��쿡�� NOT NULL�� ���簡 ��

SELECT * FROM EMPLOYEE_COPY;

--EMPLOYEE ���̺� �ִ� �÷��� ������ �����ϰ����. �����Ͱ��� �ʿ� ���� ���
/*
CREATE TABLE EMPLOYEE_COPY2(
   EMP_ID NUMBER,
   EMP_NAME VARCHAR2(20),
   ...
);
*/
CREATE TABLE  EMPLOYEE_COPY2
AS ( SELECT *
       FROM EMPLOYEE 
       WHERE 1 = 0  );  -- 1  = 0 �� ���ʿ� ���� ������ �ǹ���
               --0���� ���� ���;��� /  ����FALSE�� ���;� �� ����� ���� ������ ���� ����

SELECT * FROM EMPLOYEE_COPY2;

-- ��ü ����� �� �޿��� 300���� �̻��� ������� ���, �̸�, �μ��ڵ�, �޿� �÷��� ����
CREATE TABLE EMPLOYEE_COPY3
AS ( SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
      FROM EMPLOYEE 
      WHERE SALARY >= 3000000 ) ;

SELECT * FROM EMPLOYEE_COPY3;

-- ��ü����� ���, �����, �޿�, ���� ��ȸ ��� ���̺��� ����
CREATE TABLE EMPLOYEE_COPY4
AS   (SELECT EMP_ID, EMP_NAME, SALARY, SALARY *12
        FROM EMPLOYEE );
-- must name this expression with a column alias
-- ���������� SELECT �� �κп� ������� �Ǵ� �Լ����� ����� ��� ��Ī �ο��� �ؾ���

CREATE TABLE EMPLOYEE_COPY4
AS   (SELECT EMP_ID , EMP_NAME, SALARY, SALARY *12 "����"
        FROM EMPLOYEE );

SELECT * FROM EMPLOYEE_COPY4;

-- [ ���� ] ���� ���̺� ���������� �߰��ϴ� ���
/*
       * ���̺��� �̹� �� ������ �� �ڴʰ� ���������� �߰� ( ALTER TABLE ���̺�� XXXX)
       
       - PRIMARY KEY : ADD PRIMARY KEY (�÷���);
       - FOREIGN KEY : ADD FOREIGN KEY (�÷���) REFERENCES ���������̺�� (�������÷���);
                             -> �������÷����� ��������, �� ��� ���������̺���� PRIMARY KEY�� ������.
       - UNIQUE : ADD UNIQUE (�÷���);
       - CHECK: ADD CHECK(�÷����������ǽ�);
       - NOT NULL : MODIFY �÷��� NOT NULL;
       
*/

--EMPLOYEE_COPY ���̺� ���� PRIMARY KEY ���������� �߰� (EMP_ID)
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY (EMP_ID);

-- EMPLOYEE_COPY ���̺� DEPT_CODE �÷��� �ܷ�Ű ���������� �߰� (DEPARTMENT �� DEPT_ID�÷��� ����)->�갡 �θ�
ALTER TABLE  EMPLOYEE_COPY ADD FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT (DEPT_ID);

-- EMPLOYEE_COPY ���̺� JOB_CODE�÷��� �ܷ�Ű ���������� �߰� ( JOB�� JOB_CODE�÷��� ����)->�갡 �θ�
ALTER TABLE EMPLOYEE_COPY ADD FOREIGN KEY (JOB_CODE) REFERENCES JOB (JOB_CODE);









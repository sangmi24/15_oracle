-- �ǽ� ���� --
-- �������� ���α׷��� ����� ���� ���̺�� ����� --
-- �̶�, �������ǿ� �̸��� �ο��Ұ�
-- �� �÷��� �ּ� �ޱ�

-- 1. ���ǻ�鿡 ���� �����͸� ��� ���� ���ǻ� ���̺� (TB_PUBLISHER)
-- �÷� : PUB_NO (���ǻ��ȣ) -- �⺻Ű (PUBLISHER_PK)
--        PUB_NAME (���ǻ��) -- NOT NULL (PUBLISHER_NN)
--        PHONE (���ǻ���ȭ��ȣ) -- �������� ����

CREATE TABLE TB_PUBLISHER (
     PUB_NO NUMBER CONSTRAINT PUBLISHER_PK  PRIMARY KEY ,
     PUB_NAME VARCHAR2(20) CONSTRAINT PUBLISHER_NN NOT NULL ,
     PHONE VARCHAR2(15)
);
--�ּ� �ޱ�
COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS '���ǻ��ȣ';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS '���ǻ��';
COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '���ǻ���ȭ��ȣ';
-- 3�� ������ ���� ������ �߰��ϱ�
INSERT INTO TB_PUBLISHER
VALUES( 1, '�����ǻ�','02-1111-2222');
INSERT INTO TB_PUBLISHER
VALUES( 2, 'å���ǻ�','02-2222-3333');
INSERT INTO TB_PUBLISHER
VALUES( 3, '�������ǻ�','02-3333-4444');
SELECT * FROM TB_PUBLISHER;

-- 2. �����鿡 ���� �����͸� ��� ���� ���� ���̺� (TB_BOOK)
-- �÷� : BK_NO (������ȣ) -- �⺻Ű (BOOK_PK)
--        BK_TITLE (������) -- NOT NULL (BOOK_NN_TITLE)
--        BK_AUTHOR (���ڸ�) -- NOT NULL (BOOK_NN_AUTHOR)
--        BK_PRICE (����)
--        BK_PUB_NO (���ǻ��ȣ) -- �ܷ�Ű(BOOK_FK) (TB_PUBLISHER ���̺��� �����ϵ���)
--                                 �� ��, �����ϰ� �ִ� �θ����� ���� �� �ڽ� �����͵� ���� �ǵ��� �Ѵ�.
CREATE TABLE TB_BOOK (
     BK_NO NUMBER CONSTRAINT BOOK_PK  PRIMARY KEY, --�⺻Ű
     BK_TITLE VARCHAR2(30) CONSTRAINT BOOK_NN_TITLE NOT NULL ,
     BK_AUTHOR VARCHAR2(20) CONSTRAINT BOOK_NN_AUTHOR NOT NULL ,
     BK_PRICE NUMBER ,
     BK_PUB_NO NUMBER  CONSTRAINT BOOK_FK 
     REFERENCES  TB_PUBLISHER(PUB_NO)  ON DELETE CASCADE  --�ܷ�Ű
);
--�ּ��ޱ�
COMMENT ON COLUMN TB_BOOK.BK_NO IS '������ȣ';
COMMENT ON COLUMN TB_BOOK.BK_TITLE IS '������';
COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS '���ڸ�';
COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '����';
COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '���ǻ��ȣ';
-- 5�� ������ ���� ������ �߰��ϱ�
INSERT INTO  TB_BOOK
VALUES( 1, '���Ҽ�����','����',16000,1);

INSERT INTO TB_BOOK
VALUES(2,'������������','��ȣ��',14000,2);

INSERT INTO  TB_BOOK
VALUES(3,'�����԰���','����ȯ',16000,3);

INSERT INTO TB_BOOK
VALUES(4,'�Ƹ��','�տ���',12000,1);

INSERT INTO  TB_BOOK
VALUES(5,'����','�縮',11500,2);

SELECT * FROM TB_BOOK;

-- 3. ȸ���� ���� �����͸� ��� ���� ȸ�� ���̺� (TB_MEMBER)
-- �÷��� : MEMBER_NO (ȸ����ȣ) -- �⺻Ű (MEMBER_PK)
--         MEMBER_ID (���̵�) -- �ߺ����� (MEMBER_UQ)
--         MEMBER_PWD (��й�ȣ) -- NOT NULL (MEMBER_NN_PWD)
--         MEMBER_NAME (ȸ����) -- NOT NULL (MEMBER_NN_NAME)
--         GENDER (����) -- 'M' �Ǵ� 'F' �� �Էµǵ��� ���� (MEMBER_CK_GEN)
--         ADDRESS (�ּ�)
--         PHONE (����ó)
--         STATUS (Ż�𿩺�) -- �⺻������ 'N' ���� ����, �׸��� 'Y' Ȥ�� 'N' ���θ� �Էµǵ��� �������� (MEMBER_CK_ST)
--         ENROLL_DATE (������) -- �⺻������ SYSDATE, NOT NULL �������� (MEMBER_NN_EN)
CREATE TABLE TB_MEMBER (
     MEMBER_NO NUMBER CONSTRAINT MEMBER_PK  PRIMARY KEY,
     MEMBER_ID VARCHAR2(20) CONSTRAINT MEMBER_UQ NOT NULL ,
     MEMBER_PWD  VARCHAR2(20) CONSTRAINT MEMBER_NN_PWD NOT NULL ,
     MEMBER_NAME  VARCHAR2(20)  CONSTRAINT MEMBER_NN_NAME NOT NULL,
     GENDER CHAR(3)  CONSTRAINT MEMBER_CK_GEN CHECK (GENDER IN ('M', 'F')) ,
     ADDRESS VARCHAR2(30),
     PHONE VARCHAR2(15),
     STATUS CHAR(1) DEFAULT 'N' CONSTRAINT MEMBER_CK_ST CHECK (STATUS IN ('Y','N')), 
     ENROLL_DATE DATE DEFAULT SYSDATE CONSTRAINT MEM_NN_EN NOT NULL
);
--�ּ��ޱ�
COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '���̵�';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '��й�ȣ';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS 'ȸ����';
COMMENT ON COLUMN TB_MEMBER.GENDER IS '����';
COMMENT ON COLUMN TB_MEMBER.ADDRESS IS '�ּ�';
COMMENT ON COLUMN TB_MEMBER.PHONE  IS '����ó';
COMMENT ON COLUMN TB_MEMBER.STATUS IS 'Ż�𿩺�';
COMMENT ON COLUMN TB_MEMBER.ENROLL_DATE IS '������';

-- 5�� ������ ���� ������ �߰��ϱ�
INSERT INTO  TB_MEMBER
VALUES( 1, 'user01','1111','������','M','�����1','02-1111-1111','N','01/03/09');

INSERT INTO  TB_MEMBER
VALUES( 2, 'user02','2222','������','M','�����2','02-2222-2222','N',SYSDATE);

INSERT INTO  TB_MEMBER
VALUES( 3, 'user03','3333','���ö','M','�����3','02-3333-3333','Y','20/03/28');

INSERT INTO  TB_MEMBER
VALUES( 4, 'user04','4444','������','F','�����4','02-4444-4444','N',SYSDATE);

INSERT INTO  TB_MEMBER
VALUES( 5, 'user05','5555','�����','M','�����5','02-5555-5555','N',DEFAULT);

SELECT * FROM TB_MEMBER;
-- 4. � ȸ���� � ������ �뿩�ߴ����� ���� �뿩��� ���̺� (TB_RENT)
-- �÷� : RENT_NO (�뿩��ȣ) -- �⺻Ű (RENT_PK)
--        RENT_MEM_NO (�뿩ȸ����ȣ) -- �ܷ�Ű (RENT_FK_MEM) TB_MEMBER �� �����ϵ���
--                                    �� ��, �θ� ������ ���� �� �ڽ� ������ ���� NULL �� �ǵ��� �ɼ� ����
--        RENT_BOOK_NO (�뿩������ȣ) -- DHLFOZL (RENT_FK_BOOK) TB_BOOK �� �����ϵ���
--                                     �� ��, �θ� ������ ���� �� �ڽ� ������ ���� NULL ���� �ǵ��� �ɼ� ����
--        RENT_DATE (�뿩��) -- �⺻�� SYSDATE
--4��
CREATE TABLE TB_RENT (
     RENT_NO NUMBER CONSTRAINT RENT_PK  PRIMARY KEY,
     RENT_MEM_NO NUMBER ,
     RENT_BOOK_NO NUMBER,  
     RENT_DATE DATE DEFAULT SYSDATE,
     CONSTRAINT RENT_FK_MEM FOREIGN KEY (RENT_MEM_NO) REFERENCES TB_MEMBER(MEMBER_NO) ON DELETE SET NULL, 
     CONSTRAINT RENT_FK_BOOK FOREIGN KEY (RENT_BOOK_NO) REFERENCES TB_BOOK(BK_NO) ON DELETE SET NULL
);    --NULL�ǵ���  FOREIGN KEY���� (���̺�������) 
--�ּ��ޱ�
COMMENT ON COLUMN TB_RENT. RENT_NO IS '�뿩��ȣ';
COMMENT ON COLUMN TB_RENT. RENT_MEM_NO IS '�뿩ȸ����ȣ';
COMMENT ON COLUMN TB_RENT. RENT_BOOK_NO IS '�뿩������ȣ';
COMMENT ON COLUMN TB_RENT. RENT_DATE IS '�뿩��';
-- 3�� ������ ���� ������ �߰��ϱ�
INSERT INTO  TB_RENT
VALUES( 1, 1, 1, SYSDATE);

INSERT INTO  TB_RENT
VALUES( 2, 2, 2, DEFAULT);

INSERT INTO  TB_RENT
VALUES( 3, 3, 3, '21/01/01');

INSERT INTO  TB_RENT
VALUES( 4, 4, 4, SYSDATE);

SELECT * FROM TB_RENT;

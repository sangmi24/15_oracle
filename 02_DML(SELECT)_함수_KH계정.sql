/*
     < �Լ� FUNCTION >
     �ڹ��� �޼ҵ�� ���� ���� 
     ���޵� ������ �о ����� ����� ��ȯ
     
     - ������ �Լ� :  N���� ���� �о N���� ����� ����  ( �� �ึ�� �ݺ������� �Լ��� ������ ��� ��ȯ )
     - �׷� �Լ� :  N���� ���� �о 1���� ����� ���� ( �ϳ��� �׷캰�� �Լ� ���� �� ��� ��ȯ ) => ��)SUM
     
     ���ǻ���  : ������ �Լ��� �׷� �Լ��� �Բ� ���� �� ���� ( ���ʿ� ��� ���� ������ �ٸ��� ����)     
*/

----------<������ �Լ� >--------------

/*
        <���ڿ��� ���õ� �Լ�>
        LENGTH /  LENGTHB
        
        -LENGTH (STR) :  �ش� ���޵� ���ڿ��� ���� �� ��ȯ 
        -LENGTHB (STR) : �ش� ���޵� ���ڿ��� ����Ʈ �� ��ȯ
        
        ������� NUMBER Ÿ������ ��ȯ
        STR  :  '���ڿ� ���ͷ�'  / ���ڿ��� �ش�Ǵ� �÷�
        
        �ѱ� :  '��' , '��', '��', '��' , .. => �� ���� �� 3BYTE �� ���
        ����, ����, Ư������ :  ' ! ', ' ~ ', 'A' , ' a ' , '1' => �� ���� �� 1BYTE �� ���        
*/

SELECT LENGTH('����Ŭ!'), LENGTHB('����Ŭ!') 
FROM DUAL;  -- �������̺� (DUMMY TABLE) : ��� �����̳� ���� �÷� ���� ���� �ѹ��� ����ϰ� ���� �� ����ϴ� ���� ���̺�

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL), 
             EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;

-------------------------------------------------------------------------------------------------------------------

/*
       INSTR
       
       -INSTR (STR, 'Ư������' , ã����ġ�ǽ��۰�,  ����   ) :  ���ڿ��κ��� Ư�� ������ ��ġ�� ��ȯ
       
       ������� NUMBER Ÿ������ ��ȯ
       ã����ġ�ǽ��۰�, ������ ���� ���� ( DEFAULT  ���� �ִ�.)
       
       STR  :  '���ڿ� ���ͷ�'  / ���ڿ��� �ش�Ǵ� �÷�
       
       ã����ġ�ǽ��۰�
       1  :  'Ư������'�� �տ������� ã�ڴ� . (������ �⺻��)
       -1 :  'Ư������'�� �ڿ������� ã�ڴ�.     
       
       ���� ���� �� �⺻���� 1�� �ȴ� !
*/

SELECT INSTR('AABAACAABBAA', 'B')
FROM DUAL;  -- 3 :  �⺻������ �տ������� �ش� 'Ư������'�� ù ��° ������ ��ġ�� ��ȯ
 
SELECT INSTR('AABAACAABBAA', 'B' , 1)
FROM DUAL;  --  3   : �տ������� ù��°�� ��ġ�ϴ� 'B' �� ��ġ���� �˷��� ��

SELECT INSTR('AABAACAABBAA' , 'B', -1)
FROM DUAL; --  10  : �ڿ������� ù��°�� ��ġ�ϴ� 'B'�� ��ġ���� �տ������� ���� �˷��� ��

SELECT INSTR('AABAACAABBAA' , 'B', 1 , 2 )
FROM DUAL;  -- 9  : �տ������� �ι�°�� ��ġ�ϴ� 'B'�� ��ġ���� �տ������� ���� �˷��� ��

SELECT INSTR('AABAACAABBAA' , 'B', -1, 2 )
FROM DUAL; --   : �ڿ������� �ι�°�� ��ġ�ϴ� 'B'�� ��ġ���� �տ������� ���� �˷��� �� (1���� ��)

--  EMAIL �÷����� '@' �� ��ġ�� ã�ƺ���
SELECT EMAIL, INSTR (EMAIL, '@') AS "@�� ��ġ"
FROM EMPLOYEE;

-- ������ �������� �ʴ� ��� 0�� ��ȯ��
-- �ڹٿ��� INDEXOF �� ����ϴ� (��� 0���� ��) / INSTR�� 1���� ��
---------------------------------------------------------------------------------------

/*
     SUBSTR
     
     - SUBSTR ( STR, POSITION, LENGTH )   :  ���ڿ��κ��� Ư�� ���ڿ��� �����ؼ� ��ȯ
                                                                      (�ڹٷ� ġ�� ���ڿ�.substring () �޼ҵ�� ����)
      ������� CHARACTER Ÿ������ ��ȯ (���ڿ� ����)
      LENGTH  ���� ���� ( ���� �� ������ �߶� )
      
      - STR : '���ڿ� ���ͷ�'  / ���ڿ� Ÿ���� �÷���
      -POSITION : ���ڿ� ������ ������ ��ġ��, POSITION ��° ���ں��� �����ϰڴ�.
      -LENGTH : ������ ���� ���� 
  
*/

SELECT SUBSTR('SHOWMETHEMONEY',7)
FROM DUAL; -- 'THEMONEY'  :  7��° ���ں��� ������ �����ϰڴ�.

SELECT SUBSTR('SHOWMETHEMONEY',5,2)
FROM DUAL; -- 'ME' : 5��° ���ں��� 2���� �����ϰڴ�.

SELECT SUBSTR('SHOWMETHEMONEY', 1, 6)
FROM DUAL; --'SHOWME' :  ���� ��ġ ���� �� 1���� ����!

SELECT SUBSTR('SHOWMETHEMONEY', -8 , 3)
FROM DUAL; --'THE' : �ڿ������� 8��° ���ڿ��� 3���� �����ϰڴ�.

-- POSITION �� ������ ��� �ڿ������� N��° ���ڿ������� ���ڸ� �����Ѵ� ��� ��!

-- �ֹε�Ϲ�ȣ���� ���� �κ��� �����ؼ� ���� (1,3) / ����(2,4) �� üũ
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1) AS "����" 
FROM EMPLOYEE;

--���ڻ���鸸 ��ȸ (�����, �޿�)
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8, 1) = '1'  OR SUBSTR(EMP_NO, 8, 1) = '3' ;
WHERE  SUBSTR(EMP_NO, 8, 1)  IN ('1','3') ;

--���ڻ���鸸 ��ȸ (�����, �޿�)
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ( '2' ,'4' );

-- ��ø�ؼ� �Լ��� ��� ����
-- �̸��Ͽ��� ID  �κи� �����ؼ� ��ȸ
--SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, ù��° ����, �������ġ-1 ) AS "ID"
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL,'@' ) -1 ) AS "ID"
FROM EMPLOYEE;

----------------------------------------------------------------------------------------------------------

/*
      LPAD  / RPAD
      
      -LPAD/ RPAD ( STR, ���������ι�ȯ�ҹ��ڿ��Ǳ���(����Ʈ), '�����̰����ϴ¹���' )
      :  ������ ���ڿ��� ������ ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� ���� N ���̸�ŭ�� ���ڿ��� ��ȯ
      
      ������� CHARACTER  Ÿ������ ��ȯ (���ڿ� ����)
      '�����̰����ϴ¹���'�� ���� ���� ( DEFAULT ���� ����)
      
      -STR : '���ڿ� ���ͷ�' / ���ڿ� Ÿ���� �÷���
*/

--SELECT LPAD(EMAIL, 16) -- '�����̰����ϴ¹���'�� ������ ��� ������ �⺻������ ��
SELECT LPAD(EMAIL , 16, ' ')
FROM EMPLOYEE; -- �� 16(BYTE) ����¥�� ���ڿ��� ��ȯ�ϰڴ�. ��, ������ ���빰�� ���ʿ� �����̰ڴ�. 

SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE; --�� 20(BYTE) ����¥�� ���ڿ��� ��ȯ�ϰڴ�. ��, ������ ���빰�� �����ʿ� �����̰ڴ�. 

--  850918-2****** => ����ŷó���� ���·� �ֹε�Ϲ�ȣ(�� 14����) �����ֱ� 
--SELECT RPAD (���ڿ�, �Ѹ����, �����Ϲ���)
SELECT RPAD ('850918-2', 14, '*')
FROM EMPLOYEE;

--��� ������ �ֹε�Ϲ�ȣ �� 6�ڸ��� ����ŷó���ؼ� ǥ��
--1�ܰ�.  SUBSTR �̿��ؼ� �ֹε�Ϲ�ȣ �� 8�ڸ��� ����
SELECT EMP_NAME,  SUBSTR(EMP_NO,1,8)
FROM EMPLOYEE;
--2�ܰ�. RPAD �̿��ؼ� * �����̱�
SELECT EMP_NAME,  RPAD(SUBSTR(EMP_NO,1,8), 14, '*' )
FROM EMPLOYEE;

-------------------------------------------------------------------------------------------------------------

/*
        LTRIM   /  RTRIM
        
        - LTRIM / RTRIM (STR,  '���Ž�Ű�����ϴ¹���' )
        
        �������  CHARACTER Ÿ������ ��ȯ (���ڿ� ����)
        '���Ž�Ű�����ϴ¹���' �� ���� ���� (DEFAULT ���� ����)
        
        -STR : '���ڿ� ���ͷ�'  / ���ڿ� Ÿ���� �÷���
        
*/

SELECT LTRIM ('       K       H')
FROM DUAL; --  '���Ž�Ű�����ϴ¹���' ���� �� ������ �ǹ�

SELECT RTRIM('K      H        ')
FROM DUAL;

SELECT LTRIM( '0001230456000' , '0' )
FROM DUAL; -- '1230456000'

SELECT RTRIM( '0001230456000' , '0' )
FROM DUAL; --'0001230456'

SELECT LTRIM( '123123KH123', '123' )
FROM DUAL; -- 'KH123'

SELECT LTRIM( 'ACABACCKH', 'ABC' )
FROM DUAL; -- 'KH'

-- �������ִ� ���ڿ��� ������ �����ִ°� �ƴ϶� ���� �ϳ��ϳ��� �� �����ϸ� �� �����ִ� ���� 

-----------------------------------------------------------------------------

/*
       TRIM
   
        -TRIM( BOTH /LEADING / TRALLING   '���Ž�Ű�����ϴ¹���'   FROM STR)
       :  ���ڿ��� ����/ ����/ ���ʿ� �ִ� Ư�� ���ڸ� ������ ������ ���ڿ��� ��ȯ  
        '���Ž�Ű�����ϴ¹���' ���� �� ������ �ǹ�
       ������� CARACTER Ÿ������ ��ȯ ( ���ڿ� ����)
      BOTH:  ���ʿ� �ִ� ���� �� �����ϰڴ�. (������ �⺻��)
      LEADING(����):  ���ʿ� �ִ� �ش繮�ڸ� �� �����ϰڴ�.  (LTRIM �� ������ ����)
      TRALLING (�i��): ���ʿ� �ִ� �ش繮�ڸ� �� �����ϰڴ�. (RTRIM �� ������ ����) 
      
        -STR: '���ڿ� ���ͷ�'  / ���ڿ� ������ �÷���
    
*/

--�⺻������ ���ʿ� �ִ� ���� ����
SELECT TRIM('         K     H    ')
FROM DUAL;
  
-- BOTH / LEADING / TRALLING ���� �� �⺻�� BOTH
SELECT TRIM( 'Z'    FROM  'ZZZKHZZZ')
FROM DUAL;
 
 SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ')
 FROM DUAL;  -- BOTH : ���� (���� �� �⺻��)
 
 SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ')
 FROM DUAL;   --LEADING :  ���� (LTRIM �Լ��� ����)
 
 SELECT TRIM (TRAILING 'Z'  FROM 'ZZZKHZZZ')
 FROM DUAL; -- TRAILING : ���� (RTRIM  �Լ��� ����)
 
 -- �Ű������� ������ �������� �Ѱ��� �����Ǿ ��!
 
  ------------------------------------------------------------------------------------------------------------------------------------
  /*
          LOWER  /  UPPER  / INITCAP
          
          - LOWER ( STR )  : �� �ҹ��ڷ� ����
          - UPPER ( STR )  : �� �빮�ڷ� ����
          - INITCAP( STR ) :  �� �ܾ� �ձ��ڸ� �빮�ڷ� ���� (���� ����,  ���� ���� x)
          
          ������� CHARACTER Ÿ������ ��ȯ (���ڿ� ����)
          
          - STR : '���ڿ� ���ͷ�'  / ���ڿ� Ÿ���� �÷���       
  */
  
  SELECT LOWER('Welcome To My World!')
  FROM DUAL;
  
  SELECT UPPER('Welcome To My World!')
  FROM DUAL;
  
  SELECT INITCAP('welcome to myworld!')
  FROM DUAL; 
  
  ---------------------------------------------------------------------------------------------------------------------------------------------
  
  /*
          CONCAT
          
          - CONCAT ( STR1, STR2 )  :  ���޵� �ΰ��� ���ڿ��� �ϳ��� ��ģ ����� ��ȯ
          
          ������� CHARACTER Ÿ������ ��ȯ (���ڿ� ����)
          
          - STR1, STR2 : '���ڿ� ���ͷ�'  / ���ڿ� Ÿ���� �÷���
          
  */
  
  SELECT CONCAT('������' , 'ABC')
  FROM DUAL;
  
  SELECT '������'  ||   'ABC'
  FROM DUAL;
  
  SELECT '������'  ||  'ABC' ||  'DEF'
  FROM DUAL;
  
  SELECT CONCAT( '������', 'ABC', 'DEF')
  FROM DUAL;  -- ���� : �� ���� ���ڿ��� ���� ����
  
  -- �Լ��� ��ø�ؼ� ������ �̷����ϼ� �ִ�.
  SELECT CONCAT('������',  CONCAT('ABC' ,  'DEF') )
  FROM DUAL;
  ------------------------------------------------------------------------------------------------
  
  /*
     REPLACE
      
      -REPLACE( STR,  'ã������' , '�ٲܹ���' )
      : STR �κ��� 'ã������'�� ã�Ƽ� '�ٲܹ���' �� �ٲ� ���ڿ��� ��ȯ
      
      ������� CHARACTER Ÿ������ ��ȯ
      
      - STR : '���ڿ� ���ͷ�'  / ���ڿ� Ÿ���� �÷���   
  */
  
  SELECT REPLACE ('����� ������ ���ﵿ' , '���ﵿ', '�Ｚ��')
  FROM  DUAL;
  
  --�̸����� �������� kh.co.kr  ���� iei.com ���� ����
  SELECT EMP_NAME,  EMAIL , REPLACE (EMAIL, 'kh.or.kr',  'iei.com')
  FROM EMPLOYEE;
  
  ---------------------------------------------------------------------------------------------------------------
  
  /*
          <    ���ڿ� ���õ� �Լ�    > => �ڹٿ���MATH Ŭ����
         
         ABS
         
         -  ABS ( NUMBER )  :  ���밪�� �����ִ� �Լ�  
  */
  
  SELECT ABS(-10)
  FROM DUAL;  -- 10
  
  SELECT ABS(-10.9)
  FROM DUAL; --  10.9
  
  ------------------------------------------------------------------------------------------------------------------------
  
  /*
      MOD
      
      - MOD( NUMBER1  , NUMBER2 ) : �� ���� ���� ���������� ��ȯ���ִ� �Լ�  
  */
  SELECT MOD( 10, 3 )
  FROM DUAL;  --  1
  
  SELECT MOD( -10, 3)
  FROM DUAL ;  --  -1
  
  SELECT MOD(10.9 , 3)
  FROM DUAL;  -- 1.9
  
  --------------------------------------------------------------------------------------------------------------------------------
  
  /*
       ROUND
       
       - ROUND(NUMBER , ��ġ ) : �ݿø� ó���� ���ִ� �Լ�
       
       ��ġ : �Ҽ��� �Ʒ�  N ��° ������ �ݿø��ϰڴ�.
                  ��ġ�� ���� ����, ���� �� �⺻���� 0 
  */
  SELECT ROUND(123.456)
  FROM DUAL;   --123  : ��ġ ������ �⺻���� 0
  
  SELECT ROUND (123.456 , 1)
  FROM DUAL;  --123.5
  
  SELECT ROUND (123.456 , 2)
  FROM DUAL;  --123.46
  
  SELECT ROUND(123.456 , 3)
  FROM DUAL; --123.456
  
  SELECT ROUND(123.456 , 4)
  FROM DUAL; --123.456
  
  SELECT ROUND (123.456, -1)
  FROM DUAL;  --120
  
  SELECT ROUND( 123.456, -2)
  FROM DUAL;  --100
  --  -1 , -2 �����̸� �Ҽ��� ���� �ݿø�ȭ�� �ȴ�. 
  
 -------------------------------------------------------------------------------------------------------------------------------------
 
 /*
       CELL
       
       -CELL (NUMBER) :  �Ҽ��� �Ʒ��� ���� ������ �ø�ó�� ���ִ� �Լ�
 */
  
  SELECT CEIL(123.156)
  FROM DUAL;  --124 (������ �ʰ� ������ �ø�)
  
  SELECT CEIL(251.999)
  FROM DUAL;  --252
  
  ----------------------------------------------------------------------------------------------------------------------------------
  
  /*
         FLOOR
         
         - FLOOR(NUMBER)   : �Ҽ��� �Ʒ��� ���� ������ ����ó�� ���ִ� �Լ� ( �Ҽ��� ����) 
  */
  
  SELECT FLOOR( 123.956 )
  FROM DUAL;  --123
  
  SELECT FLOOR(207.68)
  FROM DUAL;  --207
  
  ---�� �������� ����Ϸκ��� ���ñ���  �ٹ��ϼ� (���ó�¥-�Ի��� )�� ��ȸ
  -- �ٹ��ϼ� �ڿ� '��' �̶�� ��¥�� ���� , �ٹ��ϼ���� �÷���(��Ī)�� �߰�
  
  --SELECT EMP_NAME, FLOOR(SYSDATE- HIRE_DATE ) || '��'   "�ٹ��ϼ�"
 SELECT EMP_NAME, CONCAT(FLOOR(SYSDATE- HIRE_DATE),    '��')  "�ٹ��ϼ�"
  FROM EMPLOYEE;
  
  -------------------------------------------------------------------------------------------------
  
  /*
     TRUNC
     
     -TRUNC ( NUMBER, ��ġ ) : ��ġ ���������� ���� ó���� ���ִ� �Լ� 
     
     ��ġ��  ���� ����, ���� ��  �⺻���� 0  (�Ҽ��� ���� �� �߶󳻰ڴ�.) 
     �Ҽ��� �Ʒ��� ��ġ ������ ���ܳ��� ����ó���ϰڴ�.
  */
  
  SELECT TRUNC(123.756)
  FROM DUAL;   -- 123 (FLOOR�� ����)
  
  SELECT TRUNC(123.756 , 1)
  FROM DUAL;  -- 123.7
  
  SELECT TRUNC(123.756 , -1)
  FROM DUAL;  -- 120
  
  -----------------------------------------------------------------------------------------------------------------------------
  /*
         <  ��¥  ���� �Լ�  >
     
      DATE Ÿ�� :  ��, ��, ��, ��, ��, �� �� �� ������ �ڷ���     
  */
  
  -- SYSDATE  :  ���ó�¥, ���� �� ��ǻ���� �ý��� ��¥ 
  SELECT SYSDATE
  FROM DUAL;
  
  -- MONTHS_BETWEEN (DATE1, DATE2)  : �� ��¥ ������ ������ ��ȯ  , NUMBER  Ÿ�� ��ȯ
 --                                                                            ��, ��, ��, �� �� �Ҽ������� ����!                                                                           
  --  �� �������� ����Ϸκ��� ���ñ����� �ٹ��ϼ�, �ٹ� �������� ��ȸ
  --SELECT EMP_NAME, �ٹ��ϼ� , �ٹ�������
  SELECT EMP_NAME, 
                   FLOOR(SYSDATE -  HIRE_DATE) ||  '��'  "�ٹ��ϼ�",
                   FLOOR(MONTHS_BETWEEN(SYSDATE,  HIRE_DATE))  || '����'  "�ٹ�������"
  FROM EMPLOYEE;
  -- DATE1 �� �� �̷������� ��� ����� ���� 
  -- DATE2 ��  �̷��ϰ�� ������ ����� ����  
  
  -- ADD_MONTHS( DATE, NUMBER ) : Ư�� ��¥�� �ش� ���ڸ�ŭ�� �������� ���� ��¥�� ��ȯ , DATE Ÿ�� ��ȯ
  -- ���� ��¥�κ��� 5���� ��
  SELECT ADD_MONTHS(SYSDATE, 5)
  FROM DUAL;   
  
  -- ��ü ������� ������, �Ի���, �Ի� �� 6������ �귶�� ���� ��¥  ��ȸ
  SELECT EMP_NAME,  HIRE_DATE,  ADD_MONTHS(HIRE_DATE,  6)
  FROM EMPLOYEE;
  
  -- ������ �����ϸ�?
  SELECT ADD_MONTHS(SYSDATE, -5)
  FROM DUAL;
  
  --NEXT_DAY ( DATE, ����( ����/ ���� ) ) :  Ư�� ��¥���� ���� ����� �ش� ������ ã�Ƽ� �� ��¥�� ��ȯ
  SELECT NEXT_DAY(SYSDATE, '�Ͽ���')
  FROM DUAL;   --22/03/20
  
  SELECT NEXT_DAY(SYSDATE, '��')
  FROM DUAL;  --22/03/20
  
  -- 1 :  �Ͽ��� , 2 : ������ , 3 : ȭ���� , .... 6: �ݿ��� , 7 : �����
  SELECT NEXT_DAY(SYSDATE, 7)
  FROM DUAL; --22/03/19
  
  -- ���� ��  KOREAN  �̱� ������ ������ ����.
  SELECT NEXT_DAY(SYSDATE, 'SUNDAY')
  FROM DUAL;
  
  --��� ����
  ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
  
  -- SUNDAY �� �ٽ� ��ȸ
  SELECT NEXT_DAY(SYSDATE, 'SUNDAY')
  FROM DUAL; --22/03/20
  
  --�Ͽ��Ϸ� �ٽ� ��ȸ
 SELECT NEXT_DAY(SYSDATE, '�Ͽ���')
  FROM DUAL; 
  
  -- �׻� ������ ���� �������� ��Ÿ������ �� ������ ���� ��� ���Ŀ� �°� ���ø� �ؾ� ��!
  
  --  �ѱ۷� ����
  ALTER SESSION SET NLS_LANGUAGE=KOREAN;
  
  -- LAST_DAY ( DATE ) : Ư�� ��¥�� ���� ���� ������ ��¥�� ���ؼ� ��ȯ, DATE Ÿ�� ��ȯ
  SELECT LAST_DAY(SYSDATE)
  FROM DUAL; --22/03/31
  
  --�̸�, �Ի���, �Ի��� ���� ������ ��¥ ��ȸ
  SELECT EMP_NAME, HIRE_DATE,  LAST_DAY(HIRE_DATE)
  FROM EMPLOYEE;
  
  /*
       EXTRACT :  �⵵ �Ǵ� �� �Ǵ� �� ������ �����ؼ� ��ȯ  ( NUMBER Ÿ�� ��ȯ)
       
       - EXTRACT( YEAR FROM DATE ) : Ư�� ��¥�κ��� �⵵�� ����
       - EXTRACT (MONTH FROM DATE) : Ư�� ��¥�κ��� ���� ����
       - EXTRACT (DAY FROM DATE )  : Ư�� ��¥�κ��� �ϸ� ����
  */
  
  -- ���� ��¥ �������� EXTRACT �Լ� ����
  SELECT EXTRACT (YEAR FROM SYSDATE),
                  EXTRACT ( MONTH FROM SYSDATE),
                 EXTRACT  ( DAY FROM SYSDATE)
  FROM DUAL;               
  
  -- �����, �Ի�⵵, �Ի��, �Ի��� ��ȸ
  SELECT EMP_NAME, 
                  EXTRACT( YEAR FROM HIRE_DATE)  "�Ի�⵵",
                  EXTRACT( MONTH FROM HIRE_DATE)  "�Ի��",
                  EXTRACT( DAY FROM HIRE_DATE) "�Ի���"
  FROM EMPLOYEE      
  ORDER BY "�Ի�⵵" , "�Ի��" , "�Ի���";  --ASC�� ������ ��           
                
  ------------------------------------------------------------------------------------------------------------------------------------------
  
  /*
        <  ����ȯ �Լ� >
        
        NUMBER / DATE => CHARACTER
       
       - TO_CHAR ( NUMBER  / DATE ,  '����' ) --> �ڹٿ��� simpledate ����  �̶� ����ϴ�
         : ������ �Ǵ� ��¥�� �����͸� ������ Ÿ������ ��ȯ (CHARACTER Ÿ�� ��ȯ)     
  */
 
 SELECT 1234 ,TO_CHAR(1234 )
 FROM DUAL;  --  1234 => '1234'
 
 SELECT TO_CHAR (1234,  '00000')
 FROM DUAL; --  1234 => '01234'  :  ��ĭ��  0���� ä��.
 
 SELECT TO_CHAR(1234,  '99999')
 FROM DUAL;  -- 1234 => ' 1234' : ��ĭ�� �������� ä��  
  
 SELECT TO_CHAR(1234,  'L00000')
 FROM DUAL;  --1234 =>  '��01234' : ���� ������ ����(LOCAL)�� ȭ�����
 
SELECT TO_CHAR(1234, 'L99999')
FROM DUAL; --1234 =>  '��1234' : ���� ������ ����(LOCAL)�� ȭ����� , ���� ������. 

SELECT TO_CHAR(1234, '$99999')
FROM DUAL;  --1234 =>  '$1234'

SELECT TO_CHAR(1234,  'L99,999')
FROM DUAL; --1234 => ' ��1,234' : 3�ڸ�����  , �� ����

-- �޿������� 3�ڸ�����  , �� �����Ͽ� ��� + ȭ�����
SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999') "�޿�����"
FROM EMPLOYEE;

--������� TO_CHAR �Լ��� �̿��ؼ� ���ڸ� ������������ �ٲ� ��

-- DATE( ����Ͻú��� ) => CHARACTER
SELECT SYSDATE
FROM DUAL;    --��¥����

SELECT TO_CHAR(SYSDATE)
FROM DUAL;    --��������   '22/03/14'

-- ������ ���� ���� ��쿡�� YY/MM/DD �������� ����

-- 'YYYY-MM-DD'  ��������   ��������  �ʹ�!
SELECT TO_CHAR(SYSDATE,   'YYYY-MM-DD')
FROM DUAL;   -- ��������  '2022-03-14'
 
  
  --3/21 ������ ���� ����
 -- �� �� �ʸ� ǥ���غ���
 --24�ð� => ����/���� 1��~~, 13��/14��~~
 SELECT TO_CHAR(SYSDATE, 'PM HH : MI : SS')
 FROM DUAL; -- PM�� ����/���� �� ������ִ� ����
  
 SELECT TO_CHAR(SYSDATE, 'HH24: MI: SS')
 FROM DUAL;  -- HH24�� �ð��� 24�ð� �������� �������Բ� ���ִ� ����
 
 --���� ���ϴ� �������� Ŀ���͸���¡ ����
 SELECT TO_CHAR(SYSDATE, ' MON DY, YYYY ' )
 FROM DUAL; --3�� ��, 2022 : MON=> ��� ����  / DY=> ���� Ű���带 �� ���� ����  / YYYY => 4�ڸ� �⵵
 
 -- ����� �� �ִ� ���˵�
 -- �⵵�ν� �� �� �ִ� ����
 SELECT TO_CHAR(SYSDATE, ' YYYY')
           ,TO_CHAR(SYSDATE, 'RRRR') --�ݿø�(�ݴ������)
           ,TO_CHAR(SYSDATE, 'YY')
           ,TO_CHAR(SYSDATE, 'RR')
           ,TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL; --YEAR�� ����� �⵵���� ���

--���ν� �� �� �ִ� ����
SELECT TO_CHAR(SYSDATE, 'MM')
          , TO_CHAR(SYSDATE, 'MON')
          ,TO_CHAR(SYSDATE, 'MONTH')
          ,TO_CHAR(SYSDATE, 'RM') 
FROM DUAL;   --RM�� �θ����ڷ� ǥ��

-- �Ϸν� �� �� �ִ� ����
SELECT TO_CHAR(SYSDATE,'D')
         ,TO_CHAR(SYSDATE,'DD')
         ,TO_CHAR(SYSDATE,'DDD')
FROM DUAL;         
-- D�� 1���� �������� ����°���� (�Ͽ��Ϻ���) , DD�� 1�� �������� ����°����, DDD�� 1�� �������� ����°���� �˷��ִ� ����
  
-- ���Ϸν� �� �� �ִ� ����
SELECT TO_CHAR(SYSDATE, 'DY')
         , TO_CHAR(SYSDATE, 'DAY')
FROM DUAL;         
--DY�� '����'�� �� ���·� ���( ��, ȭ,��,��,...) , DAY�� '����'�� �ٿ��� ���(������, ȭ����, ������,...)

-- 2022�� 03�� 21�� (��)
SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��" (DY) ')
FROM DUAL;
--�ֵ���ǥ�� "��" , "��", "��" �κ��� �����ش�. 

--�����, �Ի���(���� ���� ����)
SELECT EMP_NAME,TO_CHAR(HIRE_DATE, 'YYYY "��" MM "��" DD"��" (DY) ') "�Ի���"
FROM EMPLOYEE;
  
 --"2010�� ���Ŀ� �Ի���" �����, �Ի���(���� ���� ����)
 --��Ʈ) �⵵���� �̾Ƴ��� ��Һ�
 SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY "��" MM "��" DD"��" (DY) ') "�Ի���"
 FROM EMPLOYEE
 WHERE EXTRACT (YEAR FROM HIRE_DATE) >2010;
-- WHERE SUBSTR(HIRE_DATE,1,2) >10; --�̷� ����� ����!
 ----------------------------------------------------------------------------------------
 
 /*
      NUMBER/ CHARACTER => DATE
      
      - TO_DATE(NUMBER/CHARACTER, '����' ) : ������ �Ǵ� ������ �����͸� ��¥������ ��ȯ, DATE Ÿ�� ��ȯ
 */
 SELECT TO_DATE(20210101)
 FROM DUAL;
 --�⺻ ������ YY/MM/DD �� �����ȴ�.
 
 SELECT TO_DATE('20210101')
 FROM DUAL;
-- �⺻ ������ YY/MM/DD �� �����ȴ�.
 
 SELECT TO_DATE(000101)
 FROM DUAL;
  -- 000101 �� 0���� �����ϴ� ���ڷ� �ν��Ͽ� ���� �߻�
  SELECT TO_DATE('000101')
  FROM DUAL;
 --0���� �����ϴ� �⵵�� �ݵ�� '000101'ó�� ��������ǥ�� ������� �Ѵ�.  
 
 SELECT TO_DATE('20100101', 'YYYYMMDD')
 FROM DUAL;
 --YY/MM/DD�������� �������� �� ���� â�� ���� �� �����Ǿ�����!
 
 SELECT TO_DATE('041030 143021', 'YYMMDD HH24MISS')
 FROM DUAL;
 --�������ϸ� �ð��� �� ���� (���ǻ��� 25��,61�� 61�� �̻� ������ �������� )
 
 SELECT TO_DATE('140630', 'YYMMDD')
 FROM DUAL;
 --2014.�� 06�� 30��
 
 SELECT TO_DATE('980630', 'YYMMDD')
 FROM DUAL;
 --2098�� 06�� 30�� 
 -- TO_DATE �Լ��� �̿��ؼ� DATE�������� ��ȯ ��
 --���ڸ� �⵵�� ���ؼ� YY������ ��������� ��� => ���� ����� ��Ÿ�� (98�� �������� �� 2098������ ���´�)
 
 SELECT TO_DATE('140630', 'RRMMDD')
 FROM DUAL;
--2014�⵵

SELECT TO_DATE('980630','RRMMDD')
FROM DUAL;
--1998�⵵
-- ���ڸ� �⵵�� ���ؼ� RR������ ��������� ��� 50�̻��̸� ��������� , 50�̸��̸� ���缼��� ��Ÿ��

------------------------------------------------------------------------------------------------------------
/*
      CHARACTER  => NUMBER
      
      -TO_NUMBER(CHRACTER, '����')  : ������ �����͸� ���������� ��ȯ, NUMBER Ÿ�� ��ȯ  
*/
 
 SELECT '123' + '123'
 FROM DUAL; --246 : �ڵ�����ȯ �� ���������� ����
 
 SELECT '10,000,000' +'550,000'
 FROM DUAL; -- ����(,)�� ���ԵǾ��ֱ� ������ �ڵ�����ȯ�� ������� ����
 
 SELECT TO_NUMBER('10,000,000' , '999,999,999' ) +TO_NUMBER('550,000', '999,999')
 FROM DUAL; --����� 99,999,999�� ������ �ʴ´�./ ��������Ҷ� TO_NUMBER�� ���δ�. 
 
 SELECT TO_NUMBER('000123')
 FROM DUAL; --123 ���ڷ� ���´�. 0�� �����
 
 --------------------------------------------------------------------------------------------------------------
 
 /*
      < NULL ó�� �Լ�>
      
 */
 
 --NVL(�÷���, �ش��÷�����NULL�ϰ���ȯ�ҹ�ȯ��)  /��ȯ��=��ü��
 --�ش� �÷����� ������ ���(NULL�̾ƴҰ��) ������ �÷����� ��ȯ,  �ش� �÷����� NULL�� ��� ���� ������ Ư������ ��ȯ
 
 --�����, ���ʽ�, ���ʽ��� ���� ���� 0���� ���
 SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
 FROM EMPLOYEE;
 
 --�����, ���ʽ��� ������ ���� ��ȸ
 SELECT EMP_NAME, (SALARY+(SALARY* NVL(BONUS,0) ))*12 
 FROM EMPLOYEE;
 
 --�����, �μ��ڵ� (�μ��ڵ尡 ���� ��쿡�� '����') ��ȸ
 SELECT EMP_NAME, NVL(DEPT_CODE, '����')
 FROM EMPLOYEE;
 
 --NVL2(�÷���, �����1, �����2)
 --�ش� �÷����� ������ ��� �����1 ��ȯ
 --�ش� �÷�����  NULL �� ��� �����2 ��ȯ
 
 --���ʽ��� �ִ� ��쿡�� '����' ���� ��쿡�� '����' ���
 SELECT EMP_NAME, BONUS, NVL2(BONUS, '����' , '����' )
 FROM EMPLOYEE;
 
 --�����, �μ��ڵ� ( �μ��ڵ尡 ���� ��� '�μ���ġ�Ϸ�', �μ��ڵ尡 ���� ��� '�μ���ġ����' ) ��ȸ
 SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE,'�μ���ġ�Ϸ�','�μ���ġ����')
 FROM EMPLOYEE;
 
 -- NULLIF(�񱳴��1, �񱳴��2)
 -- �񱳴��1�� �񱳴��2�� ������ ���� NULL �� ��ü�� ��ȯ
 -- �ΰ��� ���� �������� ���� ��쿡�� �񱳴��1���� ��ȯ
 
 SELECT NULLIF('123' , '123')
 FROM DUAL;
 
 SELECT NULLIF('123' ,'456')
 FROM DUAL;

SELECT NULLIF(123, 456)
FROM DUAL;
 
----------------------------------------------------------

/*
    < ���� �Լ�>
    DECODE(�񱳴��, ���ǰ�1, �����1, ���ǰ�2, �����2, ,...,���ǰ�N,�����N, �����)
    --> ������ ����� �Ѵ�. 
    (�տ� ������ �ȸ´ٸ� ������ ��������� ���´�. => �ڹٿ��� default��)  ���ٸ� ���� �� �ᵵ ��
    �ڹٿ��� ����񱳸� �����ϴ� SWITCH ���� ����
     switch(�񱳴��) {
     
     case ���ǰ�1 : �����1
     case ���ǰ�2 : �����2
     ...
     case ���ǰ�n : �����n
     default : �����;
     
     }
*/
--���, �����, �ֹε�Ϲ�ȣ�κ��� ���� �ڸ��� ����
--��, ���� �ڸ��� �����ؼ� '1'�Ǵ� '3'�̸� '��', '2'�Ǵ� '4'�� '�� ' ���
SELECT EMP_ID, EMP_NAME, DECODE( SUBSTR(EMP_NO,8,1), '1', '��', 
                                                                                     '2', '��',
                                                                                     '3', '��',
                                                                                     '4', '��') "����"
FROM EMPLOYEE;

-- �������� �޿��� �λ���Ѽ� ��ȸ
-- �����ڵ尡 'J7'�� ����� �޿��� 10���� �λ��ؼ� ��ȸ
-- �����ڵ尡 'J6'�� ����� �޿��� 15���� �λ��ؼ� ��ȸ
-- �����ڵ尡 'J5'�� ����� �޿��� 20���� �λ��ؼ� ��ȸ
-- �� �̿��� �����ڵ��� ������� �޿��� 5���� �λ��ؼ� ��ȸ
SELECT EMP_NAME
           ,JOB_CODE
           ,SALARY "�λ� ��"
           ,DECODE(JOB_CODE,'J7', SALARY+(SALARY*0.1)
                                      ,'J6', SALARY*1.15               
                                      ,'J5', SALARY*1.2 
                                      , SALARY*1.05 ) "�λ� ��"
FROM EMPLOYEE;           
--���� �ø��� ����: N���� �λ�=>  SALARY+( SALARY*0.N ) ==  SALARY*1.N

SELECT SALARY
FROM EMPLOYEE; --�������� �ٲ��� �ʴ´�!
 
 --------------------------------------------------------------------------------------
 
 /*
     CASE WHEN THEN ����
     -DECODE �����Լ��� ���ϸ� DECODE�� �ش� ���ǰ˻� �� ����񱳸��� �����Ѵٸ�
      CASE WHEN THEN �������δ� Ư�� ���� ���ý� �� ����� ���ǽ��� ��� ������ ����
      
      �ڹٿ����� IF-ELSE IF �� ���� ����
      
      [ ǥ���� ]
      CASE WHEN ���ǽ�1 THEN �����1
              WHEN ���ǽ�2 THEN �����2
              ...
              WHEN ���ǽ�N THEN �����N
              ELSE �����
      END
     
     �ڹ��� if-else if�� 
    if(���ǽ�1 {
          �����1;
     } else if(���ǽ�2) {
         �����2;
     } ....
     else{
        �����;
    }
 
 */
 
 -- ���, �����, �ֹε�Ϲ�ȣ�κ��� ���� �ڸ��� �����ؼ� �������Բ� 
 --DECODE �Լ� ����
 SELECT EMP_ID, EMP_NAME, DECODE( SUBSTR(EMP_NO,8,1), '1', '��'
                                                                                      ,'2','��'
                                                                                      ,'3', '��'
                                                                                      ,'4','��' ) "����"                                                                                                                
 FROM EMPLOYEE;
 
 --CASE WHEN THEN ���� ����
 /*
 SELECT EMP_ID
           ,EMP_NAME
           ,CASE WHEN SUBSTR(EMP_NO,8,1)='1' THEN '��'
                    WHEN SUBSTR(EMP_NO,8,1)= '2' THEN '��'
                    WHEN SUBSTR(EMP_NO,8,1)= '3' THEN  '��'
                    WHEN SUBSTR(EMP_NO,8,1)= '4' THEN '��'                     
            END "����"        
FROM EMPLOYEE;           
 */
  SELECT EMP_ID
           ,EMP_NAME
           ,CASE WHEN SUBSTR(EMP_NO,8,1)='1' OR  SUBSTR(EMP_NO,8,1)= '3' THEN  '��'
                    ELSE '��'                              
            END "����"        
FROM EMPLOYEE;  
 
 --�����, �޿�, �޿���� ( ���, �߱�, �ʱ�) 
 -- SALARY �÷��� �������� 
 --������ 500���� �ʰ��� ��쿡�� '���' => SALARY >5000000
 --������ 500���� ���� 350���� �ʰ��� ��쿡�� '�߱�'=> SALARY <=5000000 AND SALARY>3500000
 --������ 350���� ������ ��쿡�� '�ʱ�'=> SALARY<= 3500000
 SELECT EMP_NAME
            , SALARY
            , CASE WHEN SALARY> 5000000 THEN '���'
                      WHEN SALARY<=5000000 AND SALARY>3500000  THEN '�߱�'
                     -- WHEN SALARY<=3500000 THEN '�ʱ�' 
                      ELSE '�ʱ�'
               END "�޿����"  
 FROM EMPLOYEE;
            
 -------------------------------------------------------------------------------------------------------------------
 
 ----------------<�׷� �Լ�>-----------------------
 /*
    
    N���� ���� �о 1���� ����� ��ȯ (�ϳ��� �׷캰�� �Լ� ���� ����� ��ȯ�ϰڴ�.)
 
 */
 --1. SUM(����Ÿ�����÷���) : �ش� �÷������� �� �հ踦 ��ȯ���ִ� �Լ�
 --��ü ������� �� �޿� �հ�
 SELECT SUM(SALARY)
 FROM EMPLOYEE;
 
 --�μ� �ڵ尡 'D5'�� ������� �� �޿� ��
  SELECT SUM(SALARY)
  FROM EMPLOYEE
  WHERE DEPT_CODE='D5';
 
 --���ڻ������ �� �޿� ��
 SELECT SUM(SALARY)
 FROM EMPLOYEE
 WHERE SUBSTR(EMP_NO,8,1)='1' OR SUBSTR(EMP_NO,8,1)= '3'; --���ڻ����
 
 --2.AVG(����Ÿ�����÷���) : �ش� �÷������� ��հ��� ���ؼ� ��ȯ
 --��ü ������� ��� �޿�
SELECT  AVG(SALARY)
FROM EMPLOYEE;

-- ��ü ������� ��� �޿�(�ݿø�)
SELECT '�뷫' || ROUND( AVG(SALARY), -4 ) || '��' --ROUND ��ġ ���� ����
FROM EMPLOYEE;
 
 --3. MIN(�ƹ�Ÿ���÷���) : �ش� �÷����� �߿� ���� �������� ��ȯ
 -- ��ü ����� �� �����޿�, �������� �̸���, �������� �̸��ϰ�, ���� ������ �Ի��� ��¥ ���ϱ�
 SELECT MIN(SALARY), MIN(EMP_NAME), MIN(EMAIL), MIN(HIRE_DATE)
 FROM EMPLOYEE;
 
 SELECT *
 FROM EMPLOYEE
 ORDER BY EMP_NAME;
 --> MIN �Լ� ��ü�� �������� ���� �� ���� ���� ���� �����ش�. (�ݵ�� ������ �ʿ�� ����. ���ڵ� ����!)
 
 --4. MAX(�ƹ�Ÿ���÷���) : �ش� �÷����� �߿� ���� ū���� ��ȯ
 SELECT MAX(SALARY), MAX(EMP_NAME), MAX(EMAIL), MAX(HIRE_DATE)
 FROM EMPLOYEE;
 
 SELECT *
 FROM EMPLOYEE
 ORDER BY EMP_NAME DESC;
 --> MAX �Լ� ��ü�� �������� ���� �� ���� ���� ���� �����ش�.
 
 --5. COUNT( */ �÷���/ DISTINCT �÷��� ) : ��ȸ�� ���� ������ ���� ��ȯ DISTINCT: �ߺ� ����
 --COUNT (*) : ��ȸ ����� �ش��ϴ� ��� ���� ������ ���� ��ȯ�ϰڴ�. (�� = ������ ����)
--COUNT(�÷���) : ���� ������ �ش�  �÷����� NULL �� �ƴѰ͸� ���� ������ ���� ��ȯ�ϰڴ�.
 --COUNT(DISTINCT �÷���) : ������ �÷����� �ߺ����� ���� ��쿡�� �ϳ��θ� ���� ���� ������ ��ȯ�ϰڴ�. ��, NULL ����X
 
 -- ��ü ������� ���ؼ� ��ȸ
 SELECT COUNT(*)
 FROM EMPLOYEE; 
 
 SELECT COUNT(EMP_ID)
 FROM EMPLOYEE;
 --NULL���� ���� �÷��� �����Ͽ� ��ü ������� �˾Ƴ� ���� �ִ�. 
 
 -- ���� ������� ��ȸ
 SELECT COUNT (*)
 FROM EMPLOYEE
 WHERE SUBSTR(EMP_NO,8,1)='2' OR SUBSTR(EMP_NO,8,1)='4';
 
 --�μ���ġ�� �� ������� ��ȸ
 --���1)  WHERE ���� ���� �� �����ϴ� ���
 SELECT COUNT(*)
 FROM EMPLOYEE
 WHERE DEPT_CODE IS NOT NULL ;
 
 --���2) ���ʿ� COUNT �� �÷����� �����ؼ� NULL�� �ƴ� ������ ���� ���
 SELECT COUNT(DEPT_CODE)
 FROM EMPLOYEE;
 
 -- �μ���ġ�� �� ���ڻ�� ��
 --���1)
 SELECT COUNT(*)
 FROM EMPLOYEE
 WHERE DEPT_CODE IS NOT NULL AND (SUBSTR(EMP_NO,8,1)='2' OR SUBSTR(EMP_NO,8,1)='4' ) ;
 --���2)
 SELECT COUNT(DEPT_CODE)
 FROM EMPLOYEE
 WHERE SUBSTR(EMP_NO,8,1)='2' OR SUBSTR(EMP_NO,8,1)='4' ;
 
 -- ����� �ִ� ����� ��(MANAGER_ID �÷�)
 --���1)
 SELECT COUNT(*)
 FROM EMPLOYEE
 WHERE  MANAGER_ID IS NOT NULL;
 --���2)
 SELECT COUNT(MANAGER_ID)
 FROM EMPLOYEE;
 
 --���� ������� �����ִ� �μ��� ����
 SELECT COUNT(DISTINCT DEPT_CODE)
 FROM EMPLOYEE;
 
 SELECT COUNT(*)
 FROM DEPARTMENT;
 --�Ѹ� �������� �ʴ� �μ��� ���� ���� �־ �� ����� ����
 
 
 
 
 
 
 
 
 
/*
     * DDL  (DATA DEFINITION LANGUAFE)
      데이터 정의 언어
     
     오라클에서 제공하는 객체 ( OBJECT )를
     새로이 만들고 (CREATE), 구조를 변경하고 (ALTER), 구조 자체를 삭제하는 (DROP) 명령문
     즉, 구조 자체를 정의하는 언어로 주로 DB관리자나 설계자가 사용함
     
     오라클에서의 객체 : 테이블 (TABLE) , 뷰 (VIEW), 시퀀스 (SEQUENCE), 사용자 (USER),
                                 패키지 (PACKAGE), 트리거 (TRIGGER),  프로시저 (PROCEDURE), 함수 (FUNCTION),
                                 동의어 (SYNONYM) 
*/
/*
     < CREATE TABLE >
     
     테이블이란? :  행(ROW)과 열 (COLUMN) 로 구성되는 가장 기본적인 데이터베이스 객체
                         항상 모든 데이터는 테이블을 통해서 저장됨
                         즉, 데이터를 보관하고자 한다면 테이블을 만들어야만 함
                    
     [  표현법 ]   --자바에서는 자료형 컬럼명이였다 (오라클과 반대!)
     CREATE TABLE 테이블명 (   
          컬럼명 자료형, 
          컬럼명 자료형,
          컬럼명 자료형,
          ...   
       ) ;
     
     < 자료형 >
     - 문자 ( CHAR (사이즈)  / VARCHAR2(사이즈)  ) : 크기는 BYTE 수이다.
                                                                       ( 숫자, 영문자, 특수문자 => 1글자 당 1BYTE
                                                                                                  한글 => 1글자 당 3BYTE)
                                                                                                  
                CHAR(바이트수)  :  고정길이 문자열 (아무리 적은 값이 들어가더라도 공백으로 채워서 처음 할당한 크기 유지)
                                           최대 2000BYTE 까지 지정 가능함
                                           => 주로 들어올 값의 글자수가 정해져있을 때 사용한다. 
                                           예) 성별 : 남 / 여  (3BYTE) , M/F (1BYTE)
                                                주민번호 : 생년월일6숫자 -7숫자  (14BYTE)
                                                
                VARCHAR2(바이트수) :  가변길이 문자열 ( 아무리 적은 값이 들어가도 그 담긴 값에 맞춰서 크기가 줄어듬) 
                                                최대 4000BYTE 까지 지정 가능함
                                                (  VAR는 '가변'을 의미하고, 2는 '두배' 를 의미함 )
                                                => 들어올 값의 글자수가 명확하게 정해져있지 않을 때 사용한다.
                                                예) 이름, 이메일주소, 집주소, ..
     
     - 숫자 ( NUMBER) : 정수 / 실수 상관없이 NUMBER 이다.
     
     - 날짜 ( DATE) : 년, 월, 일, 시, 분, 초 의 개념이 들어간 자료형
     
     
*/

--  회원들의 데이터를 담을 수 있는 테이블 만들기
--  테이블명 : MEMBER
--  컬럼종류 : 아이디, 비밀번호, 이름, 회원가입일
CREATE TABLE MEMBER (
     MEMBER_ID  VARCHAR2(20) /*제약조건*/, --컬럼명 자료형,  --오라클에서는 대소문자 구분X, 낙타봉표기법이 불가하므로 언더바로 단어 사이를 구분
     MEMBER_PWD VARCHAR2(16) ,
     MEMBER_NAME VARCHAR2(15) ,
     MEMBER_DATE DATE
     --아이디에다가 어떤 제약조건을 추가하겠다 
);

SELECT * FROM MEMBER; -- 테이블명을 잘 작성했다면 내용물이 없는 상태로 조회
SELECT * FROM MEMBER2; -- table or view does not exist : 없는 테이블명을 조회하고자 했을 때 발생하는 오류

/*
    컬럼에 주석 달기 ( 컬럼에 대한 설명)
    
    [ 표현법 ]
    COMMENT ON COLUMN 테이블.컬럼명 IS '주석내용' ;
     
*/

COMMENT ON COLUMN MEMBER.MEMBER_ID IS '아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.MEMBER_DATE IS '회원가입일';

-- 참고) 해당 계정에 어떤 테이블들이 존재하는지, 어떤 컬럼명들이 존재하는지 알 수 있는 방법
-- 데이터 딕셔너리 : 다양한 객체들의 정보를 저장하고 있는 시스켐 테이블 (관리용)
SELECT * FROM USER_TABLES;
--USER_TABLES : 현재 이 계정이 가지고 있는 테이블들의 전반적인 구조를 확인할 수 있는 데이터 딕셔너리

SELECT *FROM USER_TAB_COLUMNS;
-- USER_TAB_COLUMNS :  현재 이 계정이 가지고 있는 테이블들의 모든 컬럼들의 정보를 조회할 수 있는 데이터 딕셔너리

SELECT* FROM MEMBER;

-- 데이터를 추가할 수 있는 구문 ( INSERT : 한 행 단위로 추가 , 값의 순서를 잘 맞춰서 작성 )
-- INSERT INTO 테이블명 VALUES (첫번째컬럼의값, 두번째컬럼의값, 세번째컬럼의값, ...);
INSERT INTO MEMBER VALUES ('user01', 'pass01', '홍길동', '2021-02-01' );
INSERT INTO MEMBER VALUES('user02','pass02','김말똥','21/02/02');
INSERT INTO MEMBER VALUES('user03','pass03','박개똥',SYSDATE);

--애초에 오류가 발생해서 데이터가 들어가지 않음
INSERT INTO MEMBER VALUES('가나다라마바사','PASS04', '김갑생',SYSDATE);
--value too large for column "DDL"."MEMBER"."MEMBER_ID" (actual: 21, maximum: 20)
-- 최대 20바이트까지 저장 가능한데 21바이트짜리 값을 넣었을 때 발생

-- 오류가 발생하지 않음, 단, 유효한 값이 아닌 값들이 들어가는 상황 => 큰 문제 
INSERT INTO MEMBER VALUES('user04',NULL, NULL, SYSDATE);
INSERT INTO MEMBER VALUES(NULL,NULL,NULL,SYSDATE);
-- 아이디, 비밀번호, 이름에 NULL  값이 존재해서는 안됨

INSERT INTO MEMBER VALUES('user03','pass03','고길동',SYSDATE);
-- 중복된 아이디는 존재해서는 안됨 

-- 위의 NULL값이나 중복된 아이디값은 유효하지 않은 값들이다. 
-- 유효한 데이터값을 유지하기 위해서는 "제약조건" 을 걸어줘야 한다. 

------------------------------------------------------------------------------------------

/*
      < 제약조건 CONSTRAINTS >
      
      - 원하는 데이터값만 유지하기 위해서 (유효한 값들만 보관하기 위해서) 특정 컬럼마다 설정하는 제약
         ( 최대 목적 : 데이터 무결성 보장을 목적으로 한다 )
      - 애초에 제약조건이 부여된 컬럼에 들어올 데이터에 문제가 있는지 없는지 우선적으로 검사할 목적
     
     - 종류 : NOT NULL, UNIQUE(단하나만), CHECK, PRIMARY KEY(NOT NULL+UNIQUE 합친거),  FOREIGN KEY (외래키,(연결고리) )

     - 컬럼에 제약조건을 부여하는 방식 : 컬럼레벨 / 테이블레벨
*/

/*
      1. NOT NULL 제약조건
      해당 컬럼(세로줄) 에 반드시 값이 존재해야할 경우에 사용
      (즉, NULL값이 절대로 들어와서는 안되는 컬럼에 부여)
      INSERT 할 때 / UPDATE 할때도 마찬가지로  NULL 값을 허용하지 않도록 제한 
      
      단, NOT NULL 제약조건은 컬럼레벨 방식 밖에 안됨
*/

-- NOT NULL 제약조건만 설정한 테이블 만들기 ( 회원번호, 아이디, 비밀번호, 이름)
-- 컬럼레벨 방식 : 컬럼명 자료형 제약조건 => 제약조건을 부여하고자하는 컬럼 뒤에 곧바로 기술
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

INSERT INTO MEM_NOTNULL VALUES(1, 'user01','pass01','홍길동','남','010-1111-2222','aaa@naver.com' );

INSERT INTO MEM_NOTNULL VALUES(2, NULL, NULL,NULL,NULL,NULL,NULL);
-- cannot insert NULL into ("DDL"."MEM_NOTNULL"."MEM_ID")
-- NOT NULL  제약조건에 위배되어 오류 발생

INSERT INTO MEM_NOTNULL VALUES(2, 'user02','pass02','김말똥', NULL, NULL,NULL );
INSERT INTO MEM_NOTNULL VALUES(3,'user03','pass03','박개똥','여',NULL, NULL);
-- NOT NULL 제약조건이 부여되어 있는 컬럼에는 반드시 값이 존재해야 함

-------------------------------------------------------------------------------------------------------

/*
     2. UNIQUE 제약조건
     컬럼에 중복값을 제한하는 제약조건
     삽입 (INSERT) / 수정 (UPDATE) 시 기존에 해당 컬럼값 중에 중복값이 있을 경우
     추가 또는 수정이 되지 않게끔 제약
     
     컬럼레벨 / 테이블레벨 방식 둘 다 가능
*/

--UNIQUE 제약조건을 추가한 테이블 생성
--컬럼레벨 방식
CREATE TABLE MEM_UNIQUE (
     MEM_NO NUMBER NOT NULL,
     MEM_ID  VARCHAR2(20) NOT NULL UNIQUE, --컬럼레벨 방식 (여러개 걸 경우 띄어쓰기로 나열) 순서 상관없음
     MEM_PWD VARCHAR2(20) NOT NULL ,
     MEM_NAME VARCHAR2(20) NOT NULL ,
     GENDER CHAR(3),
     PHONE VARCHAR2(15),
     EMAIL VARCHAR2(30)
 );

-- 테이블레벨 방식
CREATE TABLE MEM_UNIQUE (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    UNIQUE (MEM_ID)   --테이블레벨 방식 --제약조건 (컬럼명) 어느컬럼에 어느제약조건을걸건지,
                
 );

--  name is already used by an existing object
--  테이블명 중복시 해당 오류가 발생

-- 테이블을 삭제시킬 수 있는 구문
DROP TABLE  MEM_UNIQUE;

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-1234', 'abc@gmail.com');
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '김말똥',NULL, NULL, NULL);

INSERT INTO MEM_UNIQUE VALUES(3, 'user02', 'pass02', '고영희',NULL, NULL, NULL);
-- unique constraint (DDL.SYS_C007066) violated 
-- UNIQUE 제약조건에 위배되었으므로 INSERT 실패
-- 해당 오류구문으로 제약조건명을 알려줌 ( 정확하게 어떤 컬럼에 문제가 발생했는지 컬럼명으로 알려주지 않음)
-- => 쉽게 오류를 파악하기 어려움
-- => 제약조건 부여 시 직접 제약조건명을 지정해주지 않으면 시스템에서 알아서 임의의 제약조건명을 부여해줌
--       (SYS_C~~~)

/*
        *  제약조건 부여시 제약조건명도 지정하는 표현법들
        
        - 컬럼레벨 방식일 경우
        CREATE TABLE 테이블명  (
            컬럼명 자료형  CONSTRAINT 제약조건명 제약조건,
            컬럼명 자료형 ,
            ...
        );
        
        - 테이블레벨 방식일 경우
        CREATE TABLE 테이블명 (
            컬럼명  자료형,
            컬럼명  자료형,
            ...
            컬럼명  자료형,
            CONSTRAINT 제약조건명 제약조건 (컬럼명)
        );
        
      이 때, 두 방식 모두 CONSTRAINT 제약조건명 부분은 생략 가능하다.  (SYS_C~~)  
*/

-- 제약조건명 붙이는 연습
CREATE TABLE MEM_CON_NM (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NN  NOT NULL, --컬럼레벨 방식
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    CONSTRAINT MEM_ID_UQ UNIQUE (MEM_ID) --테이블레벨 방식
 );

SELECT * FROM MEM_CON_NM;

INSERT INTO MEM_CON_NM VALUES ( 1, 'user01', 'pass01', '홍길동' ,NULL, NULL, NULL  );
INSERT INTO MEM_CON_NM VALUES( 2, 'user01', 'pass02', '고길동', NULL, NULL, NULL);
-- unique constraint (DDL.MEM_ID_UQ) violated
-- 제약조건명을 지어줄 경우에는 컬럼명, 제약조건의 종류를 적절히 섞어서 지어주는 것이 오류 파악에 더 도움이 됨

SELECT * FROM MEM_CON_NM;

INSERT INTO MEM_CON_NM VALUES( 2, 'user02', 'pass02', '홍길동' , '가' , NULL, NULL  );
--GENDER 컬럼에 '남' 또는 '여'만 들어가게끔 하고 싶음

----------------------------------------------------------------------------------------------------

/*
    3. CHECK 제약조건
    컬럼에 기록될 수 있는 값에 대한 조건을 설정해 둘 수 있는 제약조건
    
    CHECK ( 조건식)
*/

-- CHECK 제약조건이 추가된 테이블
CREATE TABLE MEM_CHECK (
   MEM_NO NUMBER NOT NULL,
   MEM_ID  VARCHAR2 (20) NOT NULL UNIQUE,
   MEM_PWD VARCHAR2(20) NOT NULL,
   MEM_NAME VARCHAR2(20) NOT NULL,
   GENDER CHAR(3) CHECK ( GENDER IN('남','여') ),  --GENDER컬럼에는 '남' 또는 '여' 만 들어가야 한다. 
   PHONE VARCHAR2(15),
   EMAIL VARCHAR2(30),
   MEM_DATE DATE NOT NULL
);

SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK VALUES( 1, 'user01', 'pass01', '홍길동', '남', '010-1111-1111',NULL, SYSDATE );

INSERT INTO MEM_CHECK VALUES ( 2, 'user02','pass02','김갑생',NULL,NULL, NULL,SYSDATE  );
-- CHECK  제약조건에 NULL값도 INSERT가 가능함
-- 만약에 NULL 값이 못들어오게 막고 싶다면 ? NOT NULL추가
CREATE TABLE MEM_CHECK2 (
   MEM_NO NUMBER NOT NULL,
   MEM_ID  VARCHAR2 (20) NOT NULL UNIQUE,
   MEM_PWD VARCHAR2(20) NOT NULL,
   MEM_NAME VARCHAR2(20) NOT NULL,
   GENDER CHAR(3) CHECK ( GENDER IN('남','여') ) NOT NULL , --컬럼 제약조건 여러개 부여할 경우 순서 무관 
   PHONE VARCHAR2(15),
   EMAIL VARCHAR2(30),
   MEM_DATE DATE NOT NULL
 );

INSERT INTO MEM_CHECK VALUES( 3, 'user03', 'pass03', '김말똥', '가', NULL, NULL, SYSDATE);
-- check constraint (DDL.SYS_C007077) violated
-- CHECK 제약조건을 위배했을 경우 위의 오류 발생

SELECT * FROM MEM_CHECK;

-- 회원가입일을 항상 SYSDATE 값으로 받고 싶은 경우 테이블 생성시 지정 가능하다. (기본값 설정 옵션)

/*
     * 특정 컬럼에 들어올 값에 대해 기본값을 설정 가능하다. => DEFAULT 
     (단, 얘는 제약조건 종류는 아님)  
*/

-- MEM_CHECK 테이블 삭제
DROP TABLE MEM_CHECK;

-- 기존의 MEM_CHECK 테이블에 DEFAULT 설정까지 추가
CREATE TABLE MEM_CHECK (
   MEM_NO NUMBER NOT NULL,
   MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
   MEM_PWD VARCHAR2(20) NOT NULL,
   MEM_NAME VARCHAR2(20) NOT NULL,
   GENDER CHAR(3) CHECK (GENDER IN('남', '여')),
   PHONE VARCHAR2 (15),
   EMAIL VARCHAR2 (30),
   MEM_DATE DATE DEFAULT SYSDATE NOT NULL--'리터럴' 이런 형식으로 넣을수 있다.
   
);

/*
   INSERT INTO 테이블명 VALUES (값1, 값2, ... ); => 항상 값들의 갯수는 해당 컬럼의 갯수와 일치, 순서도 일치
  
   INSERT INTO 테이블명(컬럼명1, 컬럼명2, 컬럼명3 )
   VALUES ( 값1, 값2, 값3 ) ;  => 일부 컬럼들만 지정해서 값을 넣을 수 있는 구문
*/

INSERT INTO MEM_CHECK VALUES ( 1, 'user01', 'pass01', '홍길동', '남' , NULL, NULL);
--not enough values
--값들의 갯수가 충분하지 않다. (실제 컬럼은 8개, 제시한 값은 7개라서 발생한 오류 )

INSERT INTO MEM_CHECK ( MEM_NO, MEM_ID, MEM_PWD, MEM_NAME ) --NOT NULL인 것들
VALUES ( 1, 'user01', 'pass01','홍길동' );
-- 지정이 안된 컬럼에는 기본적으로 NULL 이 채워져서 한 행이 추가됨
-- NOT NULL은 기본적으로 지정을 해줘야 한다.
-- 만약에 DEFAULT 설정이 되어있다면 NULL값이 아니라 DEFAULT 값이 추가되는 것을 확인 할 수 있다!

-- 그러면 DEFAULT 설정 했을 때 처음 배운 구문 형식으로 INSERT  하고 싶다면?
INSERT INTO MEM_CHECK VALUES (2, 'user02','pass02','고길동', NULL,NULL,NULL,DEFAULT);
-- DEFAULT 설정값 부분에 DEFAULT 라고 적어주면 됨

--DEFAULT 설정시 다른 값을 담아도 무관 (그래서 제약조건으로는 분류하지 않음)
INSERT INTO MEM_CHECK VALUES (3, 'user03','pass03','김말똥', NULL,NULL,NULL, '21/03/25');

SELECT * FROM MEM_CHECK;

-----------------------------------------------------------------------------------------------------------------

/*
      4. PRIMARY KEY ( 기본키 ) 제약조건
      테이블에서 각 행들의 정보를 유일하게 식별해줄 수 있는 컬럼에 부여하는 제약조건
      => 각 행 한줄 한줄 마다 구분할 수 있는 식별자의 역할 ( JAVA에서  MAP의  키 값)
      예) 사번, 학번, 예약번호, 주문번호 , 아이디, 회원번호 
      => 중복되지 않고 값이 존재해야만 하는 컬럼에 PRIMARY KEY 부여 ( UNIQUE + NOT NULL)
      
      단, 한 테이블 당 한개의 PRIMARY KEY 제약조건만 존재해야 함
      -  PRIMARY KEY 제약조건을 컬럼 한개에다가만 거는것    : 기본키
      -  PRIMARY KEY 제약조건을 컬럼 여러개를 묶어서 한번에 거는 것 : 복합키     
*/

-- PRIMARY KEY 제약조건을 추가한 테이블 생성 ( 컬럼레벨 방식)
 CREATE TABLE MEM_PRIMARY1 (  --MEM_PRIMARYKEY1라고 해야 하는데 잘못 씀(저장되버려서 그냥 씀)
     MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY,  --컬럼레벨 방식 
     MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
     MEM_PWD VARCHAR2(20) NOT NULL,
     MEM_NAME VARCHAR2(20) NOT NULL,
     GENDER CHAR (3) CHECK (GENDER IN ('남','여' )),
     PHONE VARCHAR2(15),
     EMAIL VARCHAR2(30),
     MEM_DATE DATE DEFAULT SYSDATE --DEFAULT 설정 시 굳이 NOT NULL 을 안넣어도 됨

 );

SELECT * FROM MEM_PRIMARY1; 

INSERT INTO MEM_PRIMARY1
VALUES(1, 'user1', 'pass01','홍길동', '남',NULL, NULL,DEFAULT);

--중복값이 허용되나?
INSERT INTO MEM_PRIMARY1
VALUES(1,'user2','pass02','김말똥',NULL,NULL,NULL,DEFAULT);
-- unique constraint (DDL.MEM_PK) violated
-- 기본키 컬럼에 중복값이 들어갈 경우 UNIQUE 제약조건을 위배했다고 오류 발생
-- 이 경우, 제약조건명을 갖고 정확히 UNIQUE 를 위배한건지 PRIMARY KEY 를 위배한건지 찾아가야 함
-- 그래서 PRIMARY KEY 의 경우 제약조건명을 붙이는 습관을 들이자 ! (보통은 테이블명_PK)

--NULL 값이 허용되나?
INSERT INTO MEM_PRIMARY1
VALUES(NULL, 'user2','pass02','김말똥',NULL, NULL,NULL, DEFAULT);
--cannot insert NULL into ("DDL"."MEM_PRIMARY1"."MEM_NO")
-- 기본키 컬럼에 NULL값이 들어갈 경우  NOT NULL제약조건을 위배했다고 오류 발생
-- (계정명. 테이블명.컬럼명 )

INSERT INTO MEM_PRIMARY1
VALUES(2,'user2', 'pass02', '김말똥', NULL, NULL,NULL,DEFAULT);

--테이블레벨 방식으로 PRIMARY KEY 제약조건 걸기
CREATE TABLE MEM_PRIMARYKEY2(
      MEM_NO NUMBER,
      MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
      MEM_PWD VARCHAR2(20) NOT NULL,
      MEM_NAME VARCHAR2(20) NOT NULL,
      GENDER CHAR(3) CHECK (GENDER IN ('남', '여')),
      PHONE VARCHAR2(15),
      EMAIL VARCHAR2(30),
      MEM_DATE DATE DEFAULT SYSDATE,
      CONSTRAINT MEM_PK2  PRIMARY KEY (MEM_NO) --테이블레벨 방식  (컬럼명)     
);
--name already used by an existing constraint
--아무리 다른 테이블의 제약조건 이더라도 제약조건명이 중복되서는 안됨

-- 복합키 : 여러 컬럼을 묶어서 한번에 PRIMARY KEY 제약조건을 주는 것
CREATE TABLE MEM_PRIMARYKEY3(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE

 );
-- table can have only one primary key
-- PRIMARY KEY 가 한 테이블에 두개가 될 수 없다. 
-- 단, 두 컬럼을 하나로 묶어서  PRIMARY  KEY  하나로 설정 가능하다.

CREATE TABLE MEM_PRIMARYKEY3(
     MEM_NO NUMBER,
     MEM_ID VARCHAR2(20),
     MEM_PWD VARCHAR2(20) NOT NULL,
     MEM_NAME VARCHAR2(20) NOT NULL,
     GENDER CHAR(3) CHECK (GENDER IN ('남', '여')),
     PHONE VARCHAR2(15),
     EMAIL VARCHAR2(30),
     MEM_DATE DATE DEFAULT SYSDATE,
     PRIMARY KEY (MEM_NO, MEM_ID) --컬럼을 묶어서 PRIMARY  KEY 하나로 설정 : 복합키
                                              --CONSTRANINT는 생략 가능하면 기존의 SYS 어쩌고 로 나옴
);

INSERT INTO MEM_PRIMARYKEY3
VALUES (1, 'user01','pass01','홍길동' ,NULL, NULL, NULL, DEFAULT);

SELECT * FROM MEM_PRIMARYKEY3;

INSERT INTO MEM_PRIMARYKEY3
VALUES (1, 'user02','pass02','김영희', NULL, NULL, NULL, DEFAULT);
--오류 안남 (MEM_NO, MEM_ID)를 묶어서 PRIMARY KEY를 썻기때문에
--복합키의 경우 해당 컬럼에 들은 값들이 완전히 다 일치해야만 중복으로 판별
--만일 하나라도 값이 다를경우에는 중복으로 판별이 안됨!

INSERT INTO MEM_PRIMARYKEY3
VALUES (2, NULL, 'pass02', '김영희',NULL, NULL, NULL, DEFAULT);
-- cannot insert NULL into ("DDL"."MEM_PRIMARYKEY3"."MEM_ID")
-- 복합키의 경우 복합키에 해당하는 컬럼값들 중에서 하나라도 NULL  이 들어가면 안됨

---------------------------------------------------------------------------------------------------------

/*
    5. FOREIGN KEY (외래키 ) 제약조건
    해당 컬럼에 다른 테이블에 존재하는 값만 들어와야되는 컬럼에 부여하는 제약조건 (연결고리랑 비슷함)
    
    예시) KH  계정에서 EMPLOYEE 테이블의 JOB_CODE 컬럼에 들은 값들은
            반드시 JOB 테이블의 JOB_CODE 컬럼에 들은 값들로 이루어져 있어야 한다. (그 이외에 값이 들어오면 안됨)
            -> EMPLOYEE 테이블 입장에서 JOB 테이블의 컬럼값을 끌어다 쓰는 개념 ( == 참조한다)
            -> EMPLOYEE 테이블 입장에서 JOB 테이블을 부모테이블 이라고 표현 가능
            -> JOB 테이블 입장에서 EMPLOYEE 테이블을 자식테이블이라고 표현 가능 

       =>  "다른 테이블 ( 부모테이블)을 참조한다" 라고 표현   (REFERENCES 라는 키워드를 사용)   
             즉, 참조된 다른 테이블이 제공하고 있는 값만 해당 외래키 제약조건이 걸려있는 컬럼에 들어올 수 있다. 
       =>  FOREIGN KEY 제약조건으로 다른 테이블관의 관계를 형성 할 수 있다. (== JOIN 의 개념)     
          
          [ 표현법 ]
          - 컬럼레벨 방식
          컬럼명 자료형 CONSTRAINT 제약조건명 REFERENCES 참조할테이블명(참조할컬럼명)   --부모테이블
                                        -- CONSTRAINT 제약조건명 은 생략 가능하다 ->SYS~                                    
           
          - 테이블레벨 방식
          CONSTRAINT 제약조건명 FOREIGN KEY (제약조건을걸컬럼명) REFERENCES 참조할테이블명 (참조할컬럼명)
          
          단, 두 방식 모두 참조할컬럼명은 생략 가능하다.
          이 경우 기본적으로 참조할테이블의 PRIMARY KEY 컬럼으로 참조할컬럼명이 자동으로 잡힌다. 
          CONSTRAINT 제약조건명은 생략 가능하다. (SYS_C~)
          
*/

-- 테스트를 위한 부모 테이블 생성
-- 회원 등급에 대한 데이터 (등급코드, 등급명) 를 보관하는 테이블
CREATE TABLE MEM_GRADE (
        GRADE_CODE  CHAR(2) PRIMARY KEY,
        GRADE_NAME  VARCHAR2(20) NOT NULL

);

INSERT INTO MEM_GRADE VALUES( 'G1' ,  '일반회원' );
INSERT INTO MEM_GRADE VALUES( 'G2' ,  '우수회원');
INSERT INTO MEM_GRADE VALUES( 'G3' ,  '특별회원');

SELECT * FROM MEM_GRADE;

--자식테이블 (외래키 제약조건 걸어보기)
CREATE TABLE MEM (
   MEM_NO NUMBER PRIMARY KEY,
   MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
   MEM_PWD VARCHAR2(20) NOT NULL,
   MEM_NAME VARCHAR2(20) NOT NULL,
   GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE),  --컬럼레벨 방식
   GENDER CHAR(3) CHECK (GENDER IN ('남', '여') ),
   PHONE VARCHAR2(15),
   EMAIL VARCHAR2(30),
   MEM_DATE DATE DEFAULT SYSDATE

);

INSERT INTO MEM
VALUES(1,'user01', 'pass01', '홍길동', 'G1', NULL, NULL, NULL, DEFAULT);

INSERT INTO MEM
VALUES(2,  'user02', 'pass02', '김말똥', 'G2', NULL, NULL, NULL, DEFAULT);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '고영희', 'G1', NULL, NULL, NULL, DEFAULT);

SELECT *FROM MEM;

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '박개똥', NULL, NULL, NULL, NULL, DEFAULT);
--외래키 제약조건이 걸려있는 컬럼에는 기본적으로  NULL 값이 들어갈 수 있다. 
--조인할때는 NULL값이 안나온다. (부모테이블에는  NULL값이 없으니까)

INSERT INTO MEM
VALUES(5, 'user05', 'pass05', '고길동', 'G5', NULL, NULL, NULL, DEFAULT);
-- integrity constraint (DDL.SYS_C007140) violated - parent key not found
-- parent key not found
-- G5 등급이 부모테이블인 MEM_GRADE 테이블의 GRADE_CODE컬럼에서 제공하는 값이 아니기 때문에 오류 발생

SELECT * FROM MEM;

-- 문제 )  부모테이블 (MEM_GRADE) 에서 데이터값이 삭제된다면?
--MEM_GRADE 테이블로부터 GRADE_CODE 가 G1인 데이터를 지우기
DELETE FROM  MEM_GRADE--테이블명
WHERE  GRADE_CODE='G1' ;--어느행을지울건지;
-- integrity constraint (DDL.SYS_C007140) violated - child record found
-- child record found 
-- 자식테이블 (MEM) 중에 G1이라는 값을 사용하고 있는 행들이 존재하기 때문에 부모 값을 삭제할 수가 없음
-- 현재 외래키 제약조건 부여 시 추가적으로 삭제옵션을 부여하지 않았음
-- 자식테이블에서 사용하고 있는 값이 있을 경우 삭제가 되지 않는 "삭제 제한 옵션"이 기본적으로 걸려있음

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G3';  --자식테이블에서 사용되고 있는 값이 아니기 때문에 삭제가 가능함

SELECT * FROM MEM_GRADE; --G3이 삭제되었다. 

-- 그동안 테스트했던거 되돌리기
ROLLBACK;

-- MEM 테이블 삭제
DROP TABLE  MEM;  --테이블명;

/*
     * 자식 테이블을 생성 시 ( 외래키 제약조건을 부여 시 )
       부모 테이블의 데이터가 삭제되었을 때 자식테이블에서는 어떻게 삭제된 값에 대해서 처리를 할 것인지를
       옵션으로 정해놓을 수 있음
       
       *FOREIGN KEY 삭제 옵션
       - ON DELETE RESTRICTED :  삭제 옵션을 별도로 제시하지 않았을 때 ( 기본값 ) => 삭제 제한
       - ON DELETE SET NULL : 부모데이터를 삭제 시 해당 데이터를 사용하고 있는 자식데이터를 NULL로 변경
       - ON DELETE CASCADE : 부모데이터를 삭제 시 해당 데이터를 사용하고 있는 자식데이터도 같이 삭제
*/

-- 1)  ON DELETE SET NULL : 부모데이터 삭제 시 해당 데이터를 사용하고 있는 자식데이터를 NULL로 변경하는 옵션
CREATE TABLE MEM(
   MEM_NO NUMBER PRIMARY KEY,
   MEM_ID  VARCHAR2(20)  NOT NULL UNIQUE,
   MEM_PWD VARCHAR2(20) NOT NULL,
   MEM_NAME VARCHAR2(20) NOT NULL,
   GRADE_ID CHAR(2) ,
   GENDER CHAR(3) CHECK (GENDER IN ('남', '여')),
   PHONE VARCHAR2(15),
   EMAIL VARCHAR2(30),
   MEM_DATE DATE DEFAULT SYSDATE,
   FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)  ON DELETE SET NULL     --테이블레벨 방식
);

INSERT INTO MEM
VALUES(1,'user01', 'pass01', '홍길동', 'G1', NULL, NULL, NULL, DEFAULT);

INSERT INTO MEM
VALUES(2,  'user02', 'pass02', '김말똥', 'G2', NULL, NULL, NULL, DEFAULT);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '고영희', 'G1', NULL, NULL, NULL, DEFAULT);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '박개똥', NULL, NULL, NULL, NULL, DEFAULT);

SELECT * FROM MEM;

-- 부모테이블(MEM_GRADE)의 GRADE_CODE가 G1인 데이터 삭제
DELETE FROM MEM_GRADE
WHERE GRADE_CODE='G1';
--문제없이 잘 삭제가 됨
--자식테이블(MEM) 의 GRADE_ID가 G1인 부분은?
SELECT * FROM MEM; --> NULL값으로 바뀜

SELECT * FROM MEM_GRADE;

--그동안 테스트했던거 되돌리기
ROLLBACK; --변경된것이 다시 복원됨 (G1삭제했던것이 다시 돌아옴 )

-- MEM 테이블 삭제
DROP TABLE MEM;

--2) ON DELETE CASCADE : 부모데이터를 삭제 시 해당 데이터를 사용하고 있는 자식 데이터도 같이 삭제하는 옵션
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
   MEM_ID  VARCHAR2(20)  NOT NULL UNIQUE,
   MEM_PWD VARCHAR2(20) NOT NULL,
   MEM_NAME VARCHAR2(20) NOT NULL,
   GRADE_ID CHAR(2) ,
   GENDER CHAR(3) CHECK (GENDER IN ('남', '여')),
   PHONE VARCHAR2(15),
   EMAIL VARCHAR2(30),
   MEM_DATE DATE DEFAULT SYSDATE,
   FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE --테이블레벨 방식

);

INSERT INTO MEM
VALUES(1,'user01', 'pass01', '홍길동', 'G1', NULL, NULL, NULL, DEFAULT);

INSERT INTO MEM
VALUES(2,  'user02', 'pass02', '김말똥', 'G2', NULL, NULL, NULL, DEFAULT);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '고영희', 'G1', NULL, NULL, NULL, DEFAULT);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '박개똥', NULL, NULL, NULL, NULL, DEFAULT);



--  부모테이블 (MEM_GRADE) 의 G1을 삭제
DELETE FROM MEM_GRADE
WHERE GRADE_CODE='G1' ; --부모테이블 안에 있는 GRADE_CODE임
-- 문제없이 잘 삭제됨
-- 자식테이블 (MEM) 의 GRADE_ID 가 G1인 행들은?
SELECT * FROM MEM; -- 함께 삭제가 되어버림 

SELECT * FROM MEM_GRADE;

--[ 참고 ]
-- 외래키와 조인  
-- 전체 회원의 회원번호, 아이디, 비밀번호, 이름, 등급명 조회
-->> 오라클 전용 구문
SELECT MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GRADE_NAME
FROM MEM, MEM_GRADE
WHERE  GRADE_ID= GRADE_CODE (+); --연결고리에 대한 조건
-->> ANSI 구문
SELECT MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GRADE_NAME
FROM MEM
LEFT JOIN MEM_GRADE ON (GRADE_ID= GRADE_CODE);

/*
    굳이 외래키 제약조건이 걸려있지 않더라도 JOIN이 가능함
    다만, 두 컬럼에 동일한 의미의 데이터만 담겨있다면 매칭해서 JOIN해서 조회 가능함
*/

ROLLBACK; --돌려놓기

DROP TABLE MEM; --삭제

--   [  참고 ]  서브쿼리를 이용한 테이블 생성 ( 테이블 복사의 개념 )
/*
   --- 여기서부터는 KH계정으로 접속해서 테스트 ---
   
   * SUBQUERY 를 이용한 테이블 생성 (테이블 복사 뜨는 개념) 통으로 복사 됨
   서브쿼리 : 메인 SQL 문 (SELECT, CREATE, INSERT, UPDATE) 를 보조역할 하는 쿼리문 (SELECT)
   
   [ 표현법 ]
   CREATE TABLE 테이블명 
   AS (서브쿼리);
   
   해당 서브쿼리를 실행한 결과를 이용해서 새로이 테이블을 생성하는 개념 

*/

-- EMPLOYEE 테이블을 복제한 새로운 테이블 생성 (EMPLOYEE_COPY)
CREATE TABLE EMPLOYEE_COPY 
AS ( SELECT *
       FROM EMPLOYEE  );
-- > 컬럼들, 조회결과의 데이터값들이 잘 복사됨 + 제약조건의 경우에는 NOT NULL만 복사가 됨

SELECT * FROM EMPLOYEE_COPY;

--EMPLOYEE 테이블에 있는 컬럼의 구조만 복사하고싶음. 데이터값은 필요 없는 경우
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
       WHERE 1 = 0  );  -- 1  = 0 은 애초에 거짓 조건을 의미함
               --0개의 행이 나와야함 /  거짓FALSE가 나와야 함 대놓고 쓸수 없으니 식을 넣음

SELECT * FROM EMPLOYEE_COPY2;

-- 전체 사원들 중 급여가 300만원 이상인 사원들의 사번, 이름, 부서코드, 급여 컬럼을 복제
CREATE TABLE EMPLOYEE_COPY3
AS ( SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
      FROM EMPLOYEE 
      WHERE SALARY >= 3000000 ) ;

SELECT * FROM EMPLOYEE_COPY3;

-- 전체사원의 사번, 사원명, 급여, 연봉 조회 결과 테이블을 생성
CREATE TABLE EMPLOYEE_COPY4
AS   (SELECT EMP_ID, EMP_NAME, SALARY, SALARY *12
        FROM EMPLOYEE );
-- must name this expression with a column alias
-- 서브쿼리의 SELECT 절 부분에 산술연산 또는 함수식이 기술된 경우 별칭 부여를 해야함

CREATE TABLE EMPLOYEE_COPY4
AS   (SELECT EMP_ID , EMP_NAME, SALARY, SALARY *12 "연봉"
        FROM EMPLOYEE );

SELECT * FROM EMPLOYEE_COPY4;

-- [ 참고 ] 기존 테이블에 제약조건을 추가하는 방법
/*
       * 테이블이 이미 다 생성된 후 뒤늦게 제약조건을 추가 ( ALTER TABLE 테이블명 XXXX)
       
       - PRIMARY KEY : ADD PRIMARY KEY (컬럼명);
       - FOREIGN KEY : ADD FOREIGN KEY (컬럼명) REFERENCES 참조할테이블명 (참조할컬럼명);
                             -> 참조할컬럼명은 생략가능, 이 경우 참조할테이블명의 PRIMARY KEY로 잡힌다.
       - UNIQUE : ADD UNIQUE (컬럼명);
       - CHECK: ADD CHECK(컬럼에대한조건식);
       - NOT NULL : MODIFY 컬럼명 NOT NULL;
       
*/

--EMPLOYEE_COPY 테이블에 없는 PRIMARY KEY 제약조건을 추가 (EMP_ID)
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY (EMP_ID);

-- EMPLOYEE_COPY 테이블에 DEPT_CODE 컬럼에 외래키 제약조건을 추가 (DEPARTMENT 의 DEPT_ID컬럼을 참조)->얘가 부모
ALTER TABLE  EMPLOYEE_COPY ADD FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT (DEPT_ID);

-- EMPLOYEE_COPY 테이블에 JOB_CODE컬럼에 외래키 제약조건을 추가 ( JOB의 JOB_CODE컬럼을 참조)->얘가 부모
ALTER TABLE EMPLOYEE_COPY ADD FOREIGN KEY (JOB_CODE) REFERENCES JOB (JOB_CODE);









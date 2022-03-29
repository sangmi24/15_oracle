/*
    < DDL : DATA DEFINITION LANGUAGE>
    데이터 정의 언어 
    
      객체들을 새로이 생성 (CREATE) , 수정 (ALTER), 삭제 (DROP) 하는 구문
      
      1.  ALTER
      객체 구조를 수정하는 구문
      
      < 테이블 수정 > 
      ALTER TABLE 테이블명 수정할내용;

      - 수정할내용
      1)  컬럼 추가 / 수정 / 삭제
      2)  제약 조건 추가 / 삭제 => 수정은 불가 ( 수정하고자 한다면 삭제 후 새로이 추가 )
      3)  테이블명 / 컬럼명 / 제약조건명 변경     
*/

-- 1) 컬럼 추가 / 수정 / 삭제
-- 1_1) 컬럼 추가 ( ADD ) : ADD 추가할컬럼명 데이터타입 DEFAULT 기본값   => 수정할내용에 들어감 
--                                  (DEFAULT 기본값 부분은 생략 가능)
SELECT * FROM DEPT_COPY;

-- CNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20) ;
--새로운 컬럼이 추가되고 기본적으로 NULL 값들이 채워짐

-- LNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '한국';
--새로운 컬럼이 만들어지고 NULL 이 아닌 DEFAULT 값으로 채워짐

-- [ 맛보기 ] 컬럼명 변경
ALTER TABLE DEPT_COPY RENAME COLUMN LNAME TO LANAME;

--1_2) 컬럼 수정 (MODIFY)
--       데이터 타입 수정 : MODIFY 수정할컬럼명 바꾸고자하는데이터타입
--       DEFAULT 값 수정 : MODIFY 수정할컬럼명  DEFAULT 바꾸고자하는기본값

--DEPT_ID 컬럼의 데이터타입을 CHAR(2) 에서 CHAR(3) 로 변경
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

-- 현재 변경하고자 하는 컬럼에 이미 담겨있는값과 완전히 다른 타입으로는 변경이 불가하다.
--예)  문자 -> 숫자 (X)  / 문자열 사이즈 축소 (X) / 문자열 사이즈 확대 (ㅇ)

--ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
--column to be modified must be empty to change datatype
-- 완전히 다른 데이터타입으로 변경하고자 할 경우에는 값이 비어있어야 함

--ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(8);
-- cannot decrease column length because some value is too big
-- 실제 들어있는 값의 사이즈가 더 큰 경우 (즉, 축소 불가)

--DEPT_TITLE 컬럼의 데이터타입을 VARCHAR2(40)로
--LOCATION _ID 컬럼의 데이터타입을 VARCHAR2(2) 로 
-- LNAME 컬럼의 기본값을 '미국'으로 
--ALTER TABLE 테이블명 
--바꿀내용들;
--ALTER TABLE DEPT_COPY
--MODIFY 컬럼명 바꿀데이터타입
--MODIFY 컬럼명 DEFAULT 바꿀기본값;
ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY LNAME DEFAULT '미국';

-- 컬럼 삭제를 위한 복사본 테이블 만들기
--DEPT_COPY를 복사본
CREATE TABLE DEPT_COPY2 
AS ( SELECT *
       FROM DEPT_COPY );

SELECT * FROM DEPT_COPY2;

--1_3) 컬럼 삭제 (DROP COLUMN) : DROP COLUMN 삭제하고자하는컬럼명

-- DEPT_COPY2로 부터 DEPT_ID 컬럼 지우기
ALTER TABLE DEPT_COPY2 DROP COLUMN  DEPT_ID;

ROLLBACK;
-- DDL 구문은 ROLLBACK으로 복구 불가능 

-- 모든 컬럼을 없애보자
ALTER TABLE DEPT_COPY2 
DROP COLUMN DEPT_TITLE
DROP COLUMN LOCATION_ID
DROP COLUMN CNAME
DROP COLUMN LNAME;  --여러 개 한꺼번에 삭제 불가

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
-- cannot drop all columns in a table 
-- 테이블의 모든 컬럼들을 전부 삭제할 수 없음
-- 마지막 컬럼 삭제만 오류 : 테이블에 최소 한개의 컬럼은 남겨야 함

--컬럼 추가/ 수정/ 삭제 시 주의사항
--1. 컬럼명 중복 불가
--2. 수정 시 데이터타입 잘 신경 써서 변경
--3. ROLLBACK  불가
--4. 테이블당 적어도 한개의 컬럼은 있어야함

--2) 제약 조건 추가 / 삭제

/*
     2_1) 제약조건 추가 (ADD/ MODIFY)
     => 어느 컬럼에 어느 제약조건을 추가할건지 명시 
     
        -PRIMARY KEY: ADD PRIMARY KEY (컬럼명)
        -FOREIGN KEY: ADD FOREIGN KEY (컬럼명) REFERECES 참조할테이블명 (참조할컬럼명)
                             => 참조할컬럼명은 생략가능 (생략시, 자동으로 PRIMARY KEY가 참조할컬럼며으로 잡힘)                       
        -UNIQUE: ADD UNIQUE (컬럼명)
        -CHECK: ADD CHECK (컬럼에대한조건)
        -NOT NULL: MODIFY 컬럼명 NOT NULL

       나만의 제약조건명을 부여하고자 한다면 : CONSTRAINT 제약조건명을 제약조건종류 앞에 쓰면 된다.
       제약조건명 부여 부분인 CONSTRAINT 제약조건명은 생략 가능하다. (SYS_C~)
       제약조건명을 부여할 때 주의사항 : 현재 계정 내에 고유한 값으로 부여해야함
                                                        ( 아무리 다른 테이블이여도 제약조건명은 중복이 불가 )
*/

--DEPT_COPY 테이블에
--DEPT_ID컬럼에 PRIMARY KEY 제약조건 추가
--DEPT_TITLE 컬럼에 UNIQUE 제약조건 추가
--LNAME 컬럼에 NOT NULL 제약조건 추가

SELECT * FROM DEPT_COPY; -- 복사했을때는 제약조건NOTNULL만 따라옴 

ALTER TABLE DEPT_COPY 
ADD  CONSTRAINT DCOPY_PK PRIMARY KEY (DEPT_ID);

ALTER TABLE DEPT_COPY 
ADD CONSTRAINT DCOPY_UQ UNIQUE (DEPT_TITLE);
--cannot validate (KH.DCOPY_UQ) - duplicate keys found
-- 이미 들어있는 값들이 부여하고자 하는 제약조건에 위배가 된 상태이기 때문에 오류 발생 

ALTER TABLE DEPT_COPY 
MODIFY LNAME  CONSTRAINT DCOPY_NN NOT NULL;

SELECT *
FROM USER_CONSTRAINTS; --제약조건들을 담고있는 데이터 딕셔너리 

-- EMP_DEPT 테이블로 다시한번 연습
-- EMP_ ID 컬럼에 PRIMARY KEY 부여
-- EMP_NAME 컬럼에 UNIQUE 제약조건 부여
-- EMP_NAME 컬럼에 NOT NULL 제약조건 부여

ALTER TABLE EMP_DEPT
ADD CONSTRAINT EDPT_PK  PRIMARY KEY (EMP_ID)
ADD CONSTRAINT EDPT_UQ UNIQUE (EMP_NAME)
MODIFY EMP_NAME CONSTRAINT EDPT_NN NOT NULL;

-- 컬럼 추가 시 주의사항
--1. 제약조건명 중복 불가
--2. 이미 담긴 값들이 해당 제약조건을 만족하고 있는지 확인 하고 붙이기
--3. ALTER 문 하나 가지고 묶어서 한번에 변경 가능

/*
    2_2 ) 제약조건 삭제 (DROP CONSTRAINT / MODIFY)
    
    -PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK : DROP CONSTRAINT 제약조건명
    -NOT NULL : MODFY 컬럼명 NULL;
*/
--ALTER TABLE 테이블 바꿀내용;
-- EDPT_PK 제약조건 지우기
ALTER TABLE  EMP_DEPT DROP CONSTRAINT EDPT_PK;
-- EDPT_UQ 제약조건 지우기
-- EDPT_NN 제약조건 지우기 같이 지우기  
ALTER TABLE  EMP_DEPT
DROP CONSTRAINT EDPT_UQ;
MODIFY EMP_NAME NULL;

--------------------------------------------------------------------------------------------

-- 3)  컬럼명 / 제약조건명 / 테이블명 변경 (RENAME)

--ALTER TABLE 테이블명 바꿀내용;
--3_1 ) 컬럼명 변경 : RENAME COLUMN 기존컬럼명 TO 바꿀컬럼명
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO  DEPT_NAME;

SELECT * FROM DEPT_COPY;

--3_2 ) 제약조건명 변경 : RENAME CONSTRAINT 기존제약조건명 TO 바꿀제약조건명
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007182 TO DEPT_ID_NN;
ALTER TABLE DEPT_COPY RENAME  CONSTRAINT SYS_C007183 TO LOCATION_ID_NN;

--3_3) 테이블명 변경  : RENAME  TO 바꿀테이블명
--                            (기존테이블명도 생략가능, 이미 ALTER TABLE 테이블명에서 기술하기 때문에 생략 가능)
ALTER TABLE DEPT_COPY RENAME  TO DEPT_TEST;
ALTER TABLE EMP_SALARY RENAME TO SALARY_EMP;

--RENAME 기존테이블명 TO 바꿀테이블명 ; 으로도 가능하다.
ALTER TABLE SALARY_EMP RENAME TO EMP_SALARY;
-----------------------------------------------------------------------------------------------------------------
/*
    2. DROP
    객체를 삭제하는 구문
    
    < 테이블 삭제 >
    [ 표현법 ]
    DROP TABLE 테이블명;
    
    < 사용자 삭제 >
    DROP USER 유저명;   -- 해당 유저가 지금 접속중이면 삭제 안됨  
*/

DROP TABLE DEPT_TEST;
-- DELETE 또는 TRUNCATE 구문으로 모든 행을 삭제하는거랑은 다르다. (내용물을 지우는것)
-- DROP 은 테이블 자체를 지우는것

DROP TABLE DEPARTMENT;
-- unique/primary keys in table referenced by foreign keys
-- 어딘가에서 참조되고 있는 부모테이블들은 삭제되지 않는다.
-- 만약에 부모테이블을 삭제하고싶다면?
-- 1. 자식테이블 먼저 지우고 그 다음에 부모테이블을 지우는 방법
DROP TABLE EMPLOYEE_COPY ;--자식테이블명
DROP TABLE DEPARTMENT; --부모테이블명;

--2. 부모테이블만 삭제하는데, 맞물려있는 제약조건을 함께 지우는 방법
DROP TABLE 부모테이블명 CASCADE CONSTRAINT;














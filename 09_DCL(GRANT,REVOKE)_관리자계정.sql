/*
    < DCL : DATA CONTROL LANGUAGE >
    데이터 제어 언어
    
    계정에게 시스템권한 또는 객체접근권한을 부여 (GRNAT) 하거나 (REVOKE) 하는 언어 
    
    [ 표현법 ]
    * 권한 부여 ( GRANT )
    GRANT 권한, 권한 ,..  TO 계정명;
    
    * 권한 회수 ( REVOKE )
     REVOKE 권한, 권한, ... FROM 계정명;

*/

/*
   - 시스템 권한
    특정 DB 에 접근하는 권한, 객체들을 생성할 수 있는 권한 
    
    - 시스템권한의 종류 
    CREATE SESSION : 계정에 접속할 수 있는 권한 
    CREATE TABLE : 테이블을 생성할 수 있는 권한 
    CREATE VIEW : 뷰를 생성할 수 있는 권한 -(임시테이블)
    CREATE SEQUENCE : 시퀀스를 생성할 수 있는 권한
    CREATE USER : 계정을 생성할 수 있는 권한
    ...
*/
--1. SAMPLE 계정 생성
--CREATE USER 계정명 IDENTIFIED BY 비밀번호;  
CREATE USER SAMPLE IDENTIFIED BY SAMPLE; --> 오류남 권한이 없다고

--2. SAMPLE 계정에 접속하기 위한 CREATE SESSION 권한을 부여
GRANT CREATE SESSION TO SAMPLE;   --> 하고나서 접속추가!! 초록색 +

--3_1. SAMPLE 계정에 테이블을 생성할 수 있는 CREATE TABLE 권한을 부여
GRANT CREATE TABLE TO SAMPLE;

--3_2. SAMPLE 계정에 테이블스테이스를 할당해주기 ( SAMPLE 계정 구조 변경) 
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
--QUOTA : 몫, 할당하다.
--2M : 2 MEGA BYTE

--4. SAMPLE 계정에 뷰를 생성할 수 있는 CREATE VIEW 권한 부여
GRANT CREATE VIEW TO SAMPLE;

-------------------------------------------------------------------------------
/*
     - 객체접근권한  (객체권한)
     특정 객체들을 조작 (DML- SELECT, INSERT, UPDATE, DELETE ) 할 수 있는 권한
   
     [ 표현법 ]
     GRNAT 권한종류 ON 특정객체 TO 계정명;
     
      권한종류        |   특정객체
     ======================================
     SELECT           |  TABLE, VIEW, SEQUENCE  
     INSERT           |  TABLE, VIEW
     UPDATE          |   TABLE, VIEW
     DELETE           |   TABLE, VIEW
*/

--5. SAMPLE 계정에 KH.EMPLOYEE 테이블을 조회할 수 있는 권한 부여 
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

--6. SAMPLE 계정에 KH.DEPARTMENT 테이블에 행을 삽입할 수 있는 권한 부여
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

---------------------------------------------------------------------------------------------

-- 최소한의 권한을 부여하고자 할 때, CONNECT, RESOURCE 만 부여
-- GRANT CONNECT, RESOURCE TO 계정명;
/*
    < 롤 ROLE > 
    특정 권한들을 하나의 집합으로 모아 놓은 것
    
    CONNECT :  접속할 수 있는 권한들을 묶어놓은 ROLE ( CREATE SESSION) 
    RESOURCE : 특정 객체들을 생성 및 관리할 수 있는 권한들을 묶어놓은 ROLE ( CREATE TABLE, CREATE SEQUENCE,...)
    
*/

-- 롤을 확인할 수 있는 데이터 딕셔너리 조회 
SELECT *
FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT', 'RESOURCE');

-----------------------------------------------------------------------------------------------------------------------

/*
    *권한 회수 (REVOKE)
    권한을 회수할 때 사용하는 명령어
    
    [ 표현법 ]
    REVOKE 권한, 권한,  ... FROM 계정명;
    (ROLL도 권한에 들어가서 회수가 가능하다.) => GRANT 도 가능
*/

-- 7. SAMPLE 계정에서 테이블을 생성할 수 없도록 권한을 회수
REVOKE CREATE TABLE FROM SAMPLE;

-- 실습문제 --

-- 사용자에게 부여할 권한 : CONNECT, RESOURCE
-- 권한을 부여받을 사용자의 이름 : MYTEST
CREATE USER MYTEST IDENTIFIED BY MYTEST;  --1단계 : 계정 생성
GRANT CONNECT, RESOURCE TO MYTEST; --2단계 : 최소한의 권한을 부여 

--MYTEST 계정으로 접속해서 작업

--데이터 관리 권한만 회수하고싶다면? (롤 단위로 회수도 가능하다)
REVOKE RESOURCE FROM MYTEST;


--MYTEST 계정이 더이상 쓸모가 없다면 ?-- 지금 접속이 아니여야 제거가 가능하다.
DROP USER MYTEST;









































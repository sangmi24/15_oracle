-- CREATE TABLE 권한 부여받기 전
CREATE TABLE TEST(
    TEST_ID NUMBER

);
-- 3_1 .  SAMPLE 계정에 테이블을 생성할 수 있는 권한이 없기 때문에 오류 발생
-- insufficient privileges 
-- 권한이 충분히 부여되지 않음을 나타내는 오류

--CREATE TABLE 권한 부여받은 후
CREATE TABLE TEST(
  TEST_ID NUMBER
);
-- 3_2. TABLE SPACE ( 테이블들이 모여있는 공간 )가 할당 되지 않아서 오류 발생
-- no privileges on tablespace 'SYSTEM' 

--TABLE SPACE 를 할당 받은 후
CREATE TABLE TEST(
   TEST_ID NUMBER
);
-- 테이블 생성 완료 

-- 위의 테이블 생성 권한 (CREATE TABLE) 을 부여받게 되면
-- 해당 계정이 가지고 있는 테이블들을 조작( DML)하는 것도 가능해짐
SELECT * FROM TEST;
INSERT INTO TEST VALUES (1);

-- 뷰 만들어보기
--CREATE VIEW 뷰이름
--AS (서브쿼리);
CREATE VIEW V_TEST
AS (SELECT * FROM TEST);
--4. 뷰 객체를 생성할 수 있는 CREATE VIEW 권한이 없기 때문에 오류 발생
-- insufficient privileges

--CREATE VIEW 권한 부여받은 후
CREATE VIEW V_TEST
AS (SELECT * FROM TEST);
-- 뷰 생성 완료 

-- SAMLE 계정에서 KH 계정의 테이블에 접근해서 조회해보기
SELECT *
FROM KH.EMPLOYEE;
-- 5. KH 계정의 테이블에 접근해서 조회할 수 있는 권한이 없기 때문에 오류 발생
-- table or view does not exist
-- SAMPLE 계정 입장에서는 "KH.EMPLOYEE"라는 이름의 테이블이 존재하지 않기 때문에 위의 오류 발생

--SELECT ON 권한 부여 후
SELECT *
FROM KH.EMPLOYEE;
--EMPLOYEE 테이블 조회 성공

SELECT * 
FROM KH.DEPARTMENT;
--KH 계정의 DEPARTMENT 테이블에 접근할 수 있는 권한이 없기 때문에 오류 

-- SAMPLE 계정에서 KH계정의 테이블에 접근해서 행 삽입해보기
INSERT INTO KH.DEPARTMENT VALUES('D0','회계부','L2'  );
--6. KH 계정의 테이블에 접근해서 삽입할 수 있는 권한이 없기 때문에 오류 발생 
--table or view does not exist

-- INSERT ON 권한 부여후
INSERT INTO KH.DEPARTMENT VALUES ('D0','회계부','L2'  );
--KH.DEPARTMENT 테이블에 행 INSERT 성공

--확정까지 지어야 INSERT 가 완전히 완료됨
COMMIT;

-- 테이블 만들어보기
CREATE TABLE TEST2 (
      TEST_ID NUMBER
);
--7. SAMPLE 계정에서 테이블을 생성할 수 있는 권한을 회수 했기 때문에 오류 발생
--insufficient privileges






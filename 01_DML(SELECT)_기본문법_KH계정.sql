/*
      <  SELECT >
      데이터를 조회하거나 검색할 때 사용하는 명령어
      
      -  ResultSet : SELECT 구문을 통해 조회된 데이터들의 결과물을 의미
                           즉, 조회된 행들의 집합
                           
          [ 표현법 ]
          SELECT 조회하고자하는컬럼명, 컬럼명2, 컬럼명3, .... 
          FROM 테이블명;
*/
    
 -- EMPLOYEE 테이블의 전체 사원들의 사번, 이름, 급여 컬럼만을 조회
 SELECT EMP_ID, EMP_NAME, SALARY
 FROM  EMPLOYEE;
 
 --  명령어, 키워드 , 테이블명, 컬럼명 등은 대소문자를 가리지 않음
 --  소문자로 써도 무방, 단, 대분자로 써버릇 하자! 
 
 --EMPLOYEE 테이블의 전체 사원들의 모든 컬럼을 조회
 SELECT EMP_ID, EMP_NAME, EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,SAL_LEVEL,
              SALARY,BONUS,MANAGER_ID,HIRE_DATE,ENT_DATE,ENT_YN
 FROM  EMPLOYEE;
 
 --모든 컬럼을 조회할 경우에는 SELECT  *로 적어준다. 
 SELECT *
FROM EMPLOYEE;

-- JOB 테이블의 모든 컬럼들 조회
SELECT *
FROM JOB;

-- JOB 테이블의 직급명 컬럼만 조회
SELECT JOB_NAME
FROM JOB;

------- 실습문제 -----------
--1. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT;

--2. EMPLOYEE 테이블의 직원명,이메일,전화번호,입사일 컬럼만 조회
SELECT EMP_NAME,  EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

--3. EMPLOYEE 테이블의 입사일, 직원명, 급여 컬럼만 조회
 SELECT HIRE_DATE, EMP_NAME, SALARY
 FROM EMPLOYEE;
 
 -------------------------------------------------------------
 
 /*
      < 컬럼값을 통한 산술연산 >
      조회하고자 하는 컬럼들을 나열하는 SELECT절에 산술연산( + - / *)을 기술해서 결과를 조회할 수 있다. 
 */
  
-- EMPLOYEE 테이블로부터 직원명, 월급 , 연봉 (==월급 * 12 )
SELECT EMP_NAME,  SALARY , SALARY*12
FROM EMPLOYEE;
 
-- EMPLOYEE 테이블로부터 직원명, 월급, 보너스,  보너스가 포함된 연봉( == ( 월급 +( 월급*보너스) ) *12   )
SELECT EMP_NAME,  SALARY,  BONUS,  (SALARY+(SALARY*BONUS))*12
FROM EMPLOYEE;
 
 --> 산술 연산 과정에 NULL 값이 존재한다면 산술 연산 결과마저도  NULL 이 나옴!
 
 -- EMPLOYEE 테이블로부터 직원명, 입사일, 근무일수(오늘날짜 - 입사일) 조회
 -- DATE 타입끼리도 연산 가능 (DATE => 년, 월, 일, 시 , 분, 초 )
 -- 오늘 날짜 : SYSDATE
 
 SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE   
 FROM EMPLOYEE;
 -- 결과값은 일수 단위로 나옴
 -- 값이 지저분한 이유는  DATE 타입에 포함되어 있는 시/분/초 에 대한 연산까지 수행하기 때문
 
 --------------------------------------------------------------------------------
 
 /*
     < 컬럼명에 별칭 부여하기 >
     [ 표현법 ]
     컬럼명 AS 별칭, 컬럼명 AS "별칭",  컬럼명 별칭,  컬럼명 "별칭"
     
     AS 를 붙이든 안붙이든 간에 
     별칭에 특수문자나 띄어쓰기가 포함될 경우 반드시 ""를  묶어서 표기해야 함
 */
 
 -- EMPLOYEE  테이블로부터 이름, 월 급여, 보너스, 보너스가 포함된 총 소득을 조회
SELECT EMP_NAME AS 이름,  SALARY AS "급여(월)" , BONUS 보너스 , ( SALARY+(SALARY*BONUS) )*12 "총 소득"
FROM EMPLOYEE;
 
 --------------------------------------------------------------------------------
 
 /*
            < 리터럴 > ==값
            임의로 지정한 문자열 (' ') , 숫자, 날짜 를 SELECT 절에 기술하면
            실제 그 테이블에 존재하는 데이터처럼 ResultSet으로 조회가 가능하다.
 */
 
 -- EMPLOYEE 테이블로부터 사번, 사원명, 급여, 단위 조회하기
 SELECT EMP_ID AS 사원,  EMP_NAME "사원명", SALARY AS "급여", '원'  "단위"
 FROM EMPLOYEE;
 --> SELECT 절에 제시한 리터럴 값은 조회결과인 ResultSet 의 모든 행에 반복적으로 출력됨
 
 ---------------------------------------------------------------------------------
 
 /*
          <  DISTINCT >
          조회하고자 하는 컬럼에 중복된 값을 딱 한번씩만 조회하고 싶을 때 사용
          해당 컬럼명 앞에 기술
          
          [ 표현법 ]
          DISTINCT 컬럼명
          
          단, SELECT 절에 DISTINCT  구문은 단 한개만 작성 가능하다.
 */
 
 -- EMPLOYEE 테이블로부터 부서코드들을 조회
 SELECT DISTINCT DEPT_CODE
 FROM EMPLOYEE;
 
 -- EMPLOYEE 테이블로부터 직급코드들을 조회
 SELECT DISTINCT JOB_CODE
 FROM EMPLOYEE;
 
 -- DEPT_CODE, JOB_CODE 컬럼의 값을 세트로 묶어서 중복 판별
 SELECT DISTINCT DEPT_CODE, JOB_CODE
 FROM EMPLOYEE;
 
 ---------------------------------------------------------------------
 
 /*
     <  WHERE 절 >  => 행을 조절하는 것(가로줄)
     조회하고자 하는 테이블에 특정 조건을 제시해서 
     그 조건에 만족하는 데이터만을 조회하고자 할 때 기술하는 구문
       
     
     [ 표현법 ]
     SELECT 컬럼명1, 컬럼명2,  ...
     FROM  테이블명
     WHERE 조건식;
     
     실행순서 : FROM절 -> WHERE절 ->SELECT 절
     
     - 조건식에 다양한 연산자들 사용 가능
     
     < 비교 연산자 >
     > , < , >= , <=   (대소 비교)
     =    (일치하는가? : 동등비교, 자바에서 동등비교는 == 이였음)
     != , ^= , <>  (일치하지 않는가?)                                        
 */
 
 -- EMPLOYEE  테이블로부터 / 급여가  400만원 이상인 사원들의/ 모든 컬럼만 조회 
 SELECT *
 FROM EMPLOYEE
 WHERE  SALARY >= 4000000;
 
 -- EMPLOYEE 테이블로부터 /부서코드가 D9인 사원들의 /사원명, 부서코드, 급여 조회
 SELECT  EMP_NAME, DEPT_CODE, SALARY
 FROM EMPLOYEE
 WHERE  DEPT_CODE  = 'D9' ;  -- 23명 중 3명 조회 /WHERE  부서코드 컬럼에 들은 값이  D9 와 일치하는 경우;
 
 --EMPLOYEE  테이블로부터/ 부서코드가 D9가 아닌 사원들의 /사원명, 부서코드, 급여 조회
 SELECT EMP_NAME, DEPT_CODE , SALARY
 FROM EMPLOYEE
 WHERE DEPT_CODE != 'D9' ; --23명 중 20명 조회?  (NULL 은 제외하고 18명 조회)
 
 -----------     실습문제 --------------
 ---1. EMPLOYEE 테이블로부터 급여가 300만원 이상인 사원들의 이름, 급여, 입사일 조회
 SELECT EMP_NAME "이름", SALARY "급여", HIRE_DATE "입사일"
 FROM EMPLOYEE
 WHERE SALARY >= 3000000;
 
 ---2. EMPLOYEE 테이블로부터 직급코드가 J2인 사원들의 이름, 급여, 보너스 조회
 SELECT EMP_NAME "이름", SALARY "급여", BONUS "보너스"
 FROM EMPLOYEE 
 WHERE  JOB_CODE = 'J2';
 
 ---3.EMPLOYEE 테이블로부터 현재 재직중인 사원들(ENT_YN이 'N')의 사번,이름, 입사일 조회
 SELECT EMP_ID "사번" , EMP_NAME "이름", HIRE_DATE "입사일"
 FROM  EMPLOYEE 
 WHERE ENT_YN ='N';
 
 ---4. EMPLOYEE 테이블로부터 연봉(==급여 *12) 이 5000만원 이상인 사원들의 이름, 급여, 연봉, 입사일 조회 
 SELECT  EMP_NAME "이름", SALARY "급여", SALARY*12  "연봉", HIRE_DATE "입사일"
 FROM   EMPLOYEE 
 WHERE  ( SALARY*12 )  >=50000000;   
 --> SELECT  절에 부여한 별칭 "연봉" 을  WHERE 절에서 쓸 수 없음!! (왜? 실행 순서때문에 )
 
 ---------------------------------------------------------------------------------
 
 /*
       < 논리연산자  >
       여러 개의 조건을 엮을 때 사용
       
       ~이면서, 그리고 :  AND (자바에서는 && )
       ~이거나, 또는 :  OR (자바에서는  || )
 */
 
 --EMPLOYEE 테이블로부터 /부서코드가 'D9'이면서 급여가 500만원 이상인 /사원들의 이름, 부서코드, 급여 조회
 SELECT   EMP_NAME, DEPT_CODE, SALARY
 FROM EMPLOYEE
 WHERE DEPT_CODE='D9' AND SALARY >= 5000000;
 
 --EMPLOYEE 테이블로부터 부서코드가 'D6'이거나 급여가 300만원 이상인 사원들의 이름, 부서코드, 급여 조회
 SELECT EMP_NAME, DEPT_CODE, SALARY
 FROM EMPLOYEE
 WHERE DEPT_CODE='D6' OR SALARY >= 3000000;
 
 -- EMPLOYEE 테이블로부터 급여가 350만원 이상이고 600만원 이하인 사원들의 이름, 사번, 급여, 직급코드 조회
 SELECT EMP_NAME,EMP_ID,SALARY, JOB_CODE
 FROM EMPLOYEE
 WHERE SALARY >= 3500000 AND SALARY <=6000000;   
 -- WHERE  3500000 <= SALARY <=6000000;  안됨   
 --> 오라클도 마찬가지로 자바처럼 부등호를 연달아서 사용 불가!
 
 ---------------------------------------------------------------------------------------
 
 /*
      <  BETWEEN AND 연산자 >
      몇 이상 몇 이하인 범위에 대한 조건을 제시할 수 있는 연산자
      
      [ 표현법 ]
      비교대상컬럼명 BETWEEN  하한값(이상) AND 상한값(이하)
      
      (비교대상컬럼명에 들은 값이 하한값 이상 그리고 상한값 이하를 만족하는 경우)    
 */
  -- EMPLOYEE 테이블로부터 급여가 350만원 이상이고 600만원 이하인 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE 
WHERE SALARY BETWEEN 3500000 AND 6000000;
 
 
 
 
 
 
 
 
 
 
 
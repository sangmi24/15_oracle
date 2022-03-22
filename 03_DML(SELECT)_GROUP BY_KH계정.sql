/*
        < GROUP BY 절>
        그룹을 묶어줄 기준을 제시할 수 있는 구문
        => 해당 제시된 기준별로 그룹을 묶을 수 있음
        
        여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용
*/

-- 전체 사원의 총 급여합
SELECT SUM(SALARY)
FROM EMPLOYEE;
--> 현재 조회된 전체 사원들을 하나로 묶어서 총 합을 구한 결과

--각 부서별 총 급여합
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 전체사원수
SELECT COUNT(*)
FROM EMPLOYEE;

-- 각 부서별 사원수
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 총 급여 합을 부서별 오름차순 정렬해서 조회
SELECT DEPT_CODE, SUM(SALARY) --3.SELECT절
FROM EMPLOYEE    --1. FROM절
GROUP BY DEPT_CODE --2.GROUP BY절 (기준을 먼저 세우고 ->SELECT 절)
ORDER BY DEPT_CODE ASC  NULLS FIRST; --4. ORDER BY절
--ORDER BY DEPT_CODE ASC ; --NULL값이 가장 마지막

-- 각 직급별 직급코드, 총 급여의 합, 사원 수,  보너스를 받는 사원의 수, 사수가 있는 사원수를 조회
SELECT JOB_CODE, SUM(SALARY) "급여합" , COUNT(*) "사원수 "
         , COUNT(BONUS) "보너스 받는 사람", COUNT (MANAGER_ID) "사수있는 사람"
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 각 부서별 부서코드, 사원수, 총급여합, 평균급여, 최고급여, 최소급여 (단, 부서코드별로 오름차순)
SELECT DEPT_CODE "부서코드", COUNT(*) "사원수", SUM(SALARY) "총급여합"
           ,ROUND(AVG(SALARY)) "평균급여", MAX(SALARY) "최고급여", MIN(SALARY) "최소급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;
           
 --성별 별 사원수
 SELECT DECODE(SUBSTR(EMP_NO,8,1), '1', '남' ,'2','여')  "성별" ,COUNT(*) "사원수"
 FROM EMPLOYEE
 GROUP BY  SUBSTR(EMP_NO,8,1) ;  --함수식, 연산식 가능
 --GROUP BY "성별";  -- GROUP BY절 실행순서가 먼저이기 때문에 SELECT절에서 지정한 별칭 사용이 불가하다!
 
 -------------------------------------------------------------------------------------------

 /*
     < HAVING 절>
      "그룹함수에 대한" 조건을 제시하고자 할 때 사용되는 구문
       (주로 그룹함수를 가지고 조건을 제시해줌)
 */

-- 각 부서별 평균 급여가 300만원 이상인 부서들만 조회 
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
WHERE AVG(SALARY) >= 3000000
GROUP BY DEPT_CODE;  --오류 남

SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;
--> WHERE절과 HAVING 절의 차이점: 조건식에 그룹함수가 들어가냐 마냐의 차이!

--각 직급별 총 급여 합이 1000만원 이상인 직급 코드, 급여 합을 조회
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >=10000000;

--각 부서별로 보너스가 받는 사원이 없는 부서만을 조회 (BONUS 컬럼 기준으로 명수를 셌을때 0이 나와야 함)
SELECT DEPT_CODE , COUNT(BONUS) , COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;
 
 --------------------------------------------------------------------------------------------------
 /*
       < 실행 순서 >
       * 각 절의 작성 순서대로 필기
       
    5.   SELECT  * /조회하고자하는컬럼명 / 리터럴 / 산술연산식  / 함수식  AS  "별칭"
    1.   FROM 조회하고자하는테이블명  /  DUAL(가상테이블)
    2.   WHERE 조건식( 주의사항으로는 조건식에 그룹함수는 포함되면 안된다는 것)
    3.   GROUP BY 그룹기준에해당되는컬럼명  / 함수식
    4.   HAVING  그룹함수식을포함한조건식
    6.   ORDER BY [ 정렬기준에맞는컬럼명 / 별칭명/ 컬럼순번]   [ASC/DESC (생략가능)] [NULLS FIRST/ NULLS LAST  (생략가능)]   
 
 */
 
 ---------------------------------------------------------------------------------------------------------------------------------------
 
 /*
        < 집합 연산자 SET OPEARATOR>
        
        여러 개의 SELECT문을 가지고 하나의 쿼리문으로 만드는 연산자 
        
        - UNION : 합집합 (  두 쿼리문을 수행한 결과값을 모두 더한 후 중복되는 부분은 한번 뺀 개념) , OR 개념
        - INTERSECT : 교집합 (두 쿼리문을 수행한 결과값의 중복된 결과값 부분), AND  개념
        - UNION ALL : 합집합 결과에 교집합 더해진 개념
                            (두 쿼리문의 결과를 그냥 합치고 중복제거는 안함 => 중복된 결과가 두번씩 조회될 수 있음 )
        - MINUS : 차집합 ( 선행 쿼리문 결과값 빼기 후행 쿼리문 결과값의 결과)
           
         특이사항 : UNION 연산보다 UNION ALL 연산이 속도가 더 빠름 (중복을 빼는 행위가 일어나지 않기 때문에)
         
         주의사항 : 항상 SELECT 절이 동일해야 한다!
 */
 
 -- 1. UNION ( 합집합 - 두 쿼리문을 수행한 결과값을 더하지만 중복되는 결과는 한번만 조회 )
 -- 부서코드가 D5이거나 또는 급여가 300만원 초과인 사원들을 조회 ( 사번, 사원명, 부서코드, 급여)
 
 -- 부서코드가 D5인 사원들만 조회
 SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
 FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5'; --> 6명 조회( 박나라, 하이유,김해술,심봉선,윤은해,대북혼)
 
 -- 급여가 300만원 초과인 사원들을 조회
 SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
 FROM EMPLOYEE
 WHERE SALARY > 3000000; --> 8명 조회(선동일,송종기,노옹철,유재식,정중하,심봉선,대북혼,전지연)
 
  -- 부서코드가 D5이거나 또는 급여가 300만원 초과인 사원들을 조회 ( 사번, 사원명, 부서코드, 급여)
 -- UNION 연산자를 이용해서 위의 두쿼리를 합체
 SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
 FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5'
 UNION
 SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
 FROM EMPLOYEE
 WHERE SALARY > 3000000; -->12명 조회 (선동일,송종기,노옹철,유재식,정중하,박나라,하이유,김해술,심봉선,윤은해,대북혼,전지연)
--  12  :  6  +  8  -  2
-- 두 쿼리의 SELECT 절이 같아야 한다!!

-- 부서코드가 D5이거나 또는 급여가 300만원 초과인 사원들을 조회 ( 사번, 사원명, 부서코드, 급여)
-- 위의 UNION 구문 대신 하나의 SELECT 문으로 표현 ( OR 연산자 사용)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY >3000000;
--> OR 연산자로 두 개의 조건을 엮어서 조회하면 결과는 같음!

-- 2. UNION ALL ( 합집합에서 중복을 제거하지 않은 상태 == 교집합 부분이 두번 조회됨 )
-- 부서코드가 D5이거나 또는 급여가 300만원 초과인 사원들을 조회 ( 사번, 사원명, 부서코드, 급여) => 중복제거 X
 -- UNION ALL 연산자를 이용해서 위의 두쿼리를 합체
 SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
 FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5'
 UNION ALL
 SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
 FROM EMPLOYEE
 WHERE SALARY > 3000000; 
 -->14명 조회 ( 박나라, 하이유, 김해술, 심봉선, 윤은해,대북혼,선동일,송종기,노옹철,유재식,정중하,심봉선,대북혼,전지연)
--  14  :  6  +  8  
--중복제거를 하지 않기 때문에 OR연산자 사용 못함

-- 3. INTERSECT ( 교집합 - 여러 쿼리 결과의 중복된 결과만을 조회)
-- 부서 코드가 D5 이면서 그리고 급여 또한 300만원 초과인 사원들을 조회 (사번, 사원명, 부서코드, 급여)
-- INTERSECT 연산자를 이용하여 두개의 쿼리를 합친 버전
-- 부서 코드가 D5인 사원들
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5'
INTERSECT
-- 급여가 300만원 초과인 사원들
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;  --> 2명 조회 (심봉선, 대북혼)

-- 아래처럼도 가능
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5'  AND SALARY >3000000;

-- 4. MINUS ( 차집합 - 선행 쿼리 결과에서 후행 쿼리 결과를 뺀 나머지 , 순서 중요 )
-- 부서 코드가 D5인 사원들 중에서 급여가 300만원 초과인 사원들을 제외해서 조회 (사번, 사원명, 부서코드, 급여)
-- MINUS  연산자를 이용해서 두 쿼리를 합체
-- 부서 코드가 D5인 사원들 (선행 쿼리)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' --> 6명 조회( 박나라, 하이유,김해술,심봉선,윤은해,대북혼)
MINUS
-- 급여가 300만원 초과인 사원들 (후행 쿼리)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000 ; --> 8명 조회(선동일,송종기,노옹철,유재식,정중하,심봉선,대북혼,전지연)
--> 최종 4명 조회 ( 박나라, 하이유, 김해술, 윤은해)
-- 선행 쿼리의 결과 6명 중에서 겹치는 2명을 제외하고 4명이 조회되었다. 

-- 선행 후행 순서 바꿔서 테스트
-- 급여가 300만원 초과인 사원들 (후행 쿼리)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000  --> 8명 조회(선동일,송종기,노옹철,유재식,정중하,심봉선,대북혼,전지연)
MINUS
-- 부서 코드가 D5인 사원들 (선행 쿼리)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' ;--> 6명 조회( 박나라, 하이유,김해술,심봉선,윤은해,대북혼)
--> 최종 6명 조회 ( 선동일, 송종기, 노옹철,유재식,정중하,전지연)
--> 선행 쿼리의 결과 8명 중에서 겹치는 2명을 제외하고 6명이 조회되었다.

--아래처럼도 가능
-- 부서 코드가 D5 인 사원들 중에서 급여가 300만원 초과인 사원들을 제외해서 조회 (사번, 사원명, 부서코드, 급여)
-- 부서 코드가 D5 인 사원들 중에서 급여가 300만원 이하인 사원들만 조회 (사번, 사원명, 부서코드, 급여)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND SALARY <= 3000000;
--> 최종 4명 조회 ( 박나라, 하이유, 김해술, 윤은해)











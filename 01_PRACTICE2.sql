--문제1
--EMPLOYEE 테이블에서 12월 생일자에게 축하 메세지 보내기
--결과: OOO님 12월 OO일 생일을 축하합니다! 
SELECT EMP_NAME || '님 12월' || SUBSTR(EMP_NO,5,2) || '일 생일을 축하합니다'
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,3,2)='12';

--문제 2
--EMP 테이블의 부서코드(DEPT_CODE)와 DEPT(DEPT_ID) 테이블을 조인하여 각 부서별 근무지 위치를 조회
--사원명, 부서코드, 부서명, 근무지 위치 출력
--오라클
SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCATION_ID
FROM EMPLOYEE, DEPARTMENT,LOCATION
WHERE DEPT_CODE = DEPT_ID;
--ANSI
SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCATION_ID
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--문제3
--EMPLOYEE 테이블에서 월급 200만원 이상 300만원 이하인 사원의 
--사번, 사원명, 입사일, 부서코드, 연봉 조회 (단, 연봉은 BONUS 적용 및 \999,999,999로 조회)
SELECT EMP_ID 사번, EMP_NAME 사원명, HIRE_DATE 입사일 , DEPT_CODE 부서코드
           ,TO_CHAR( (SALARY+SALARY*NVL(BONUS,0))*12, 'L999,999,999') 연봉
           -- BONUS가 없는 경우에는 아예 출력이 되지 않았다. 
           --=> NVL(컬럼명, 해당컬럼값이NULL일 경우 반환값)으로 해결
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000 ;

--문제4
--EMPLOYEE 테이블을 통해 PHONE 번호가 011으로 시작하는 사원의
--이름, 사번, PHONE, 부서코드를 조회
SELECT EMP_NAME 이름, EMP_ID 사번,PHONE 폰번호, DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE SUBSTR(PHONE,1,3)='011';

--문제 5
--80년대생인 남자 직원들 중 성이 '김'씨인 사람의 주민번호, 직원명 조회
--단, 주민번호는 [888888-2******] 형태로 조회 및 직원명으로 오름차순 정렬
SELECT RPAD(SUBSTR(EMP_NO,1,8),14,'*') 주민번호, EMP_NAME 직원명
FROM EMPLOYEE
WHERE SUBSTR(EMP_NAME,1,1)='김'
ORDER BY 직원명 ASC;

--문제6
--EMPLOYEE 테이블에서 직급코드를 중복 없이, "직급 종류" 라는 별칭을 부여하고
--"직급 종류" 오름차순으로 정렬해서 조회
SELECT DISTINCT JOB_CODE "직급 종류"
FROM EMPLOYEE
ORDER BY "직급 종류" ASC;

--문제7  모르게씀!!
--부서별 급여 합계가 부서 급여 총합의 10%보다 많은 부서의 부서명과, 부서급여 합계 조회
--일반 단일행 서브쿼리 방식
--부서명=> DEPARTMENT(DEPT_TITLE) 부서코드 =>DEPT_ID
--부서코드=> EMPLOYEE( DEPT_CODE)
--부서급여 합계 => SUM(SALARY) 
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY)> SUM(SALARY)*1.1;











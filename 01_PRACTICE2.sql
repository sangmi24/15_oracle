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

--문제7  --해결
--부서별 급여 합계가 부서 급여 총합의 10%보다 많은 부서의 부서명과, 부서급여 합계 조회
--일반 단일행 서브쿼리 방식
--부서명=> DEPARTMENT(DEPT_TITLE) 부서코드 =>DEPT_ID
--부서코드=> EMPLOYEE( DEPT_CODE)
--부서급여 합계 => SUM(SALARY) 

--1.   부서 총 급여 합계 *10프로 (7009624)
SELECT SUM(SALARY)*0.1
FROM EMPLOYEE;

--2. 최종 코드
SELECT DEPT_TITLE "부서명",
           SUM(SALARY) "부서급여합계"
FROM  EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE= D.DEPT_ID
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > (SELECT SUM(SALARY)*0.1
                                     FROM EMPLOYEE) ;



-----------------------------------------------------------------------------------
--[문제 8]
--EMPLOYEE 테이블에서 부서 인원이 3명 이상인 부서의 
--부서 코드, 평균, 최고 급여, 최저 급여, 인원 수 조회 
--(단, 부서코드로 오름차순 조회 및 \999,999,999로 조회)
--다중행 단일열 문제 
--1) 부서 인원이 3명 이상인 부서를 구하기 --D1,D9,D5,D6,D2,D8
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*) >=3;

--2) 최종 코드
SELECT DEPT_CODE "부서코드",TO_CHAR(ROUND( AVG(SALARY)),'L99,999,999')  "평균"
         , TO_CHAR(MAX(SALARY),'L99,999,999') "최고급여", TO_CHAR(MIN(SALARY),'L99,999,999') "최저급여"
         , COUNT(DEPT_CODE) "인원수"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING DEPT_CODE IN (SELECT DEPT_CODE
                                   FROM EMPLOYEE
                                  GROUP BY DEPT_CODE
                                   HAVING COUNT(*) >=3)
ORDER BY DEPT_CODE  ASC;                                  

--와 해결함 ... 

-----------------------------------------------------------------------------------
--[문제 9]
--EMPLOYEE 테이블에서 
--직원 중 '이'씨 성을 가지면서, 
--급여가 200만원 이상 250만원 이하인 
--직원의 이름과 급여를 조회하시오

--이씨 성을 가진 직원을 찾기 --이중석,이태림
SELECT EMP_NAME "이름" ,SALARY "급여"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NAME,1,1)='이'  
AND SALARY  BETWEEN 2000000 AND 2500000; 

-----------------------------------------------------------------------------------
--[문제 10]
--자신의 매니저보다 급여(SALARY)를 많이 받는 직원들의
--이름(EMP_NAME),급여(SALARY),MANAGER_ID,매니저 이름(EMP_NAME)을
--급여의 내림차순으로 조회하시오.
--선배, 후배 개념은 자체JOIN
SELECT E.EMP_NAME 이름, E.SALARY 급여, M.MANAGER_ID, M.EMP_NAME "매니저 이름"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID (+) --연결고리에 대한 조건(매니저아이디!!기준이 E테이블이라서)
AND E.SALARY > M.SALARY  
ORDER BY E.SALARY DESC;

-----------------------------------------------------------------------------------
--[문제 11]
--EMPLOYEE 테이블에서 부서별 그룹을 편성하여
--부서별 급여 합계, 제일 낮게 받는 부서와, 제일 높게 받는부서, 인원수를 조회
--단, 조회결과는 인원수 오름차순하여 출력하여라.
--서브쿼리 이용  -- 코드 참고함! 처음에는 제일 낮게 받는 급여로 해석해서 풀다가 
--부서로 나와야 할것같아서 서브쿼리로 연결해서 코드 붙임 DECODE를 이용해서 나열함 
SELECT DEPT_CODE 부서 ,SUM(SALARY) "부서별급여합계"
          , DECODE(SUM(SALARY), (SELECT MAX(SUM(SALARY)) 
                                               FROM EMPLOYEE
                                               GROUP BY DEPT_CODE), '제일 높게 받는 부서'
                                              ,(SELECT MIN(SUM(SALARY))
                                                FROM EMPLOYEE
                                                GROUP BY DEPT_CODE), '가장 적게 받는 부서','기타') 부서급여
        ,COUNT(*) --COUNT(*)은 NULL값과 상관없이 모든 행 수를 카운트한다. 
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY COUNT(*) ASC;
                                                

-----------------------------------------------------------------------------------
--[문제12]
--EMPLOYEE 테이블에서 직급별
--그룹을 편성하여 직급코드, 급여평균, 급여합계, 인원 수를 조회
--단, 조회 결과는 급여평균 오름차순하여 출력, 인원수는 3명을 초과하는 직급만 조회
--1) 3명 초과하는 직급만 조회-J7,J6,J4
SELECT JOB_CODE
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING COUNT(*) >3; --COUNT는 그룹함수라서 GROUP BY를 써줘야 함 / *은  NULL과 관계없이 나올수 있기 때문에 씀 

--2) 최종
--다중행 단일열 서브쿼리 IN :여러개의 결과값 중에서 한개라도 일치하는 값이 있다면.. 나옴
SELECT JOB_CODE 직급코드, ROUND(AVG(SALARY)) 급여평균, SUM(SALARY) 급여합계, COUNT(*)  인원수
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING JOB_CODE IN ( SELECT JOB_CODE
                               FROM EMPLOYEE
                               GROUP BY JOB_CODE
                               HAVING COUNT(*) >3 );
-----------------------------------------------------------------------------------
--[문제13]
--2001년에 입사한 여자 직원이 있다.
--해당 직원과 같은 부서, 같은 직급에 해당하는 사원들을 조회하시오.
--사번, 사원명, 직급, 부서, 입사일
--1) 2001년에 입사한 여자 직원 구하기 --윤은해
SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(HIRE_DATE,1,2)=01
AND SUBSTR(EMP_NO,8,1) IN( 2, 4)  ;

--2) 윤은해 부서와 직급코드를 알아내야함 --D5, J7
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME=(  SELECT EMP_NAME
                                FROM EMPLOYEE
                                WHERE SUBSTR(HIRE_DATE,1,2)=01
                                AND SUBSTR(EMP_NO,8,1) IN( 2, 4) ) ;
                                
--3) 최종 합치기
SELECT EMP_ID 사번,EMP_NAME 사원명, JOB_CODE 직급, DEPT_CODE 부서, HIRE_DATE 입사일
FROM EMPLOYEE
WHERE (DEPT_CODE,JOB_CODE) 
  = ( SELECT DEPT_CODE, JOB_CODE
      FROM EMPLOYEE
      WHERE EMP_NAME=(  SELECT EMP_NAME
                                       FROM EMPLOYEE
                                      WHERE SUBSTR(HIRE_DATE,1,2)=01
                                       AND SUBSTR(EMP_NO,8,1) IN( 2, 4) )  );

-----------------------------------------------------------------------------------
--[문제14]
--EMPLOYEE 테이블에서 '하이유'와 같은 부서에서 일하는 사원들의 
--사원번호, 사원명, 부서코드, 직급코드, 급여 조회
--직급코드 내림차순 조회

--1) 하이유의 부서를 알아내기 --D5
 SELECT DEPT_CODE
 FROM EMPLOYEE
 WHERE EMP_NAME= '하이유';
 --2) 최종
SELECT EMP_ID 사원번호 ,EMP_NAME 사원명, DEPT_CODE 부서코드, JOB_CODE 직급코드, SALARY 급여
FROM EMPLOYEE
WHERE DEPT_CODE = ( SELECT DEPT_CODE
                                 FROM EMPLOYEE
                                 WHERE EMP_NAME= '하이유' );
-----------------------------------------------------------------------------------
--[문제15]
--EMPLOYEE 테이블에서 입사일이 2000년 1월 1일 이전인 사원에 대해 
--사원의 이름,  입사일,  부서코드, 급여를 입사일순으로 조회하시오
--(문제에 있는 이름대로 컬럼명을 따로 붙여주세요)
--2000년 1월 1일이전에 입사한 사람이 없다. 
SELECT EMP_NAME "사원의 이름", HIRE_DATE "입사일", DEPT_CODE "부서코드",SALARY "급여"
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE,'YYYYMMDD') < TO_DATE('20000101','YYYYMMDD') ;
-----------------------------------------------------------------------------------
--[문제16]
--EMPLOYEE 테이블에서 해외영업 부서(DEPT_TITLE) 소속인 사원들의
--이름(EMP_NAME), 직급(JOB_CODE), 부서명(DEPT_TITLE), 근무국가(NATIONAL_CODE)를 조회하시오
--단, 오라클 조인 구문으로 작성하고 별칭을 반드시 입력
--근무국가가 조회가 되어야 한다. => LOCATION 테이블에 있음
--연결고리 정리 
--1) E.DEPT_CODE= D.DEPT_ID  ( 예. D9)
--2) D.LOCATION_ID=N.LOCAL_CODE (예.L1)
--3)  L.NATIONAL_CODE =N.NATIONAL_CODE (예. KO  한국) X
SELECT E.EMP_NAME 이름, E.JOB_CODE 직급, D.DEPT_TITLE 부서명 
        , L.NATIONAL_CODE 근무국가
FROM EMPLOYEE E , DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE=D.DEPT_ID  (+)  --연결고리 지어줌 
AND D.LOCATION_ID=L.LOCAL_CODE
AND D.DEPT_TITLE LIKE '해외영업%'; --조건 지어줌 
-----------------------------------------------------------------------------------
--[문제17]
--EMPLOYEE 테이블에서
--'이태림'사원의 근속 년수를 조회하시오 (현재는 퇴사상태)
-- 오라클에서 제공하는  months_between 함수를 이용함 --나머지는 버리는 TRUNC숫자함수이용 
SELECT TRUNC(MONTHS_BETWEEN( ENT_DATE, HIRE_DATE )/12) "근속년"
FROM EMPLOYEE
WHERE EMP_NAME='이태림';
-----------------------------------------------------------------------------------
--[문제18]
--자신이 속한 직급의 평균 급여보다 많이 받는 사원의 JOB_CODE
--사원번호,직급명, 사원명,부서명, 급여정보 조회
--1) 같은직급끼리 평균 급여 구하기 
--대표: 8000000/대리: 2624373/차장: 2330000/과장:2820000/부사장:4850000/부장:3600000/사원:2017500
SELECT J.JOB_NAME ,J.JOB_CODE  CODE, ROUND(AVG(E.SALARY)) AVGS 
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE=J.JOB_CODE
GROUP BY J.JOB_NAME, J.JOB_CODE;
--최종
SELECT E.EMP_ID 사원번호, E.EMP_NAME 사원명, A.JOB_NAME 직급명
           , D. DEPT_TITLE 부서명,E.SALARY 급여, A.AVGS 부서평균급여
FROM EMPLOYEE E, DEPARTMENT D,
          (SELECT J.JOB_NAME ,J.JOB_CODE CODE, ROUND(AVG(E.SALARY)) AVGS 
            FROM EMPLOYEE E, JOB J
            WHERE E.JOB_CODE=J.JOB_CODE
            GROUP BY J.JOB_NAME, J.JOB_CODE ) A
WHERE E.DEPT_CODE=D.DEPT_ID  --연결고리 연결해줌 E테이블이랑 D테이블
   AND  E.JOB_CODE=A.CODE  --E테이블이랑 A안에 있는 JOB테이블 
   AND E.SALARY >A.AVGS;   -- 조건 :  E테이블에서 급여 > 1단계에서 구한 평균 급여 
                                         --자신이 속한 직급의 평균 급여보다 많이 받는 사원 
-----------------------------------------------------------------------------------
--[문제19]
--부서별로 근무하는 사원의 수가 3명 이하인 경우, 사원이 적은 부서별로 오름차순 정렬 조회
SELECT DEPT_CODE 부서, COUNT(*) 사원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*) <= 3 --NULL 인것은 *로 표현해서 한다. 
ORDER BY COUNT(*) ASC;

-----------------------------------------------------------------------------------
--[문제20]
--EMPLOYEE 테이블에서
--직급 별로 급여평균을 조회하고 급여평균 내림차순으로 정렬하시오
--(급여평균은 TRUNC 함수 사용하여 만원단위 이하는 버림 하시오)
SELECT  JOB_CODE,  TRUNC(AVG(SALARY),-4  )
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY AVG(SALARY) DESC;
-----------------------------------------------------------------------------------
--[문제21]
--해외영업2부(DEPT_CODE: D6)의 평균 급여보다 많이 받고, 해외영업2부에 속하지 않으며 
--관리자가 없는 사원의 사번(EMP_ID), 이름(EMP_NAME), 직급(JOB_NAME), 부서이름(DEPT_TITLE), 급여(SALARY)를 조회하시오.
--단,FROM 절에 서브쿼리 사용, JOIN은 오라클 구문 사용, 셀프 조인 사용
--1) 해외영업2부의 평균 급여--3366666
SELECT E.DEPT_CODE, TRUNC(AVG(E.SALARY))
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE=D.DEPT_ID
GROUP BY E.DEPT_CODE
HAVING E.DEPT_CODE='D6';
--2) 합치기 
SELECT E.EMP_ID 사번, E.EMP_NAME 이름, J.JOB_NAME 직급, A.DEPT_TITLE 부서이름, E.SALARY 급여
FROM EMPLOYEE E , JOB J,
          (SELECT E.DEPT_CODE, TRUNC(AVG(E.SALARY)) AVGS
          FROM EMPLOYEE E, DEPARTMENT D
          WHERE E.DEPT_CODE=D.DEPT_ID
          GROUP BY E.DEPT_CODE
         HAVING E.DEPT_CODE='D6')  A
WHERE E.JOB_CODE=J.JOB_CODE
AND E.DEPT_CODE=A.DEPT_ID       
AND E.SALARY > A.AVGS    ;  
--오류.. 잘모르게씀..
-----------------------------------------------------------------------------------
--[문제22] 
--EMP에서 직급이름으로 그룹을 만들고 월급이 500만원이상인 그룹 찾기
--JOB이름과, 급여 합계를 조회하시오
SELECT JOB_NAME 직급명, SUM(SALARY) 급여합계
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE=J.JOB_CODE
GROUP BY JOB_NAME
HAVING SUM(SALARY)>5000000;

-----------------------------------------------------------------------------------
--[문제23]
--EMPLOYEE 테이블에서
--입사일로부터 근무년수가 가장 긴 직원 상위 6명을
--RANK()함수를 이용하여 조회하시오
--사번, 사원명, 부서명, 직급명, 입사일을 조회하시오.
--1) 순위나타내기 
SELECT E.EMP_ID 사번, E.EMP_NAME 사원명, J.JOB_NAME 직급명
           ,RANK() OVER(ORDER BY SYSDATE-HIRE_DATE DESC) 순위
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE=J.JOB_CODE;
--2) 순번과 순위6명까지  잘라내기  
SELECT ROWNUM, E.*
FROM (SELECT E.EMP_ID 사번, E.EMP_NAME 사원명, J.JOB_NAME 직급명
           ,RANK() OVER(ORDER BY SYSDATE-HIRE_DATE DESC) 순위
            FROM EMPLOYEE E, JOB J
            WHERE E.JOB_CODE=J.JOB_CODE) E
WHERE 순위 <=6;            
-----------------------------------------------------------------------------------
--[문제24]
--EMPLOYEE 테이블에서 
--부서명 별로 급여가 가장 높은 직원들의
--부서명, 최대급여를 조회하시오
--단, 최대급여가 400만원 이하인 부서들만 조회하시오
--(부서명은 JOIN 활용)
-----------------------------------------------------------------------------------
--[문제25]
--EMPLOYEE 테이블에서 부서별 최고 급여를 확인 후, 사원 중 해당 부서와 최고 급여가 일치하는 사원의
--사번(EMP_ID), 이름(EMP_NAME), 부서이름(DEPT_TITLE), 직급(JOB_NAME), 부서코드(DEPT_CODE), 급여(SALARY)를 조회하시오.
--급여 내림차순으로 정렬, JOIN(ANSI 구문 사용), WHERE 절에서 서브쿼리로 부서별 최고 급여 확인.
-----------------------------------------------------------------------------------
--[문제26]
--'장쯔위'와 같은 연봉레벨, 같은 직급인 사원들의 
--사원번호, 이름, 부서코드, 직급코드, 연봉레벨(SAL_LEVEL) 조회 (다중열 처리)
-----------------------------------------------------------------------------------
--[문제27]
-- 사원들 중 월급이 5000000 이상이면 'HIGH', 3000000 이상이면 'MEDIUM', 2000000 이상이면 'LOW' 로 나머지는 'OTL'로 출력하고  
--사원명, 부서코드, 월급을 조회하시오.
--단, 월급이 많은 순으로 정렬하시오.
-----------------------------------------------------------------------------------
--[문제28]
--전형돈과 같은 직급, 같은 부서에 근무하는 
--직원들의 정보를 조회하시오 
-----------------------------------------------------------------------------------
--[문제 29]
--EMPLOYEE테이블에서
--각 부서 별 입사일이 가장 오래된 사원을 한 명씩 선별해
--사원번호, 사원명, 부서번호, 입사일을 조회하고 
--문제에 있는 명칭대로 컬럼명을 지정하시오
-----------------------------------------------------------------------------------
--[문제 30]
--EMPLOYEE테이블에서
--근무년수가 20년 이상 30년 미만인 사원의
--사원번호,사원명,입사일,연봉을 구하시오
--단,연봉은 보너스를 포함한 총합을 구한다.
-----------------------------------------------------------------------------------
--[문제 31]
--EMPLOYEE 테이블에서 근무국가(NATIONAL_CODE)가 'KO'인 사원들의
--이름(EMP_NAME), 연봉순위, 급여(SALARY), 근무국가(NATIONAL_CODE)를 조회하시오
--단, 연봉순위는 DENSE_RANK() 사용, ANSI(JOIN) 구문 사용, 내림차순 정렬(연봉순위) 
-----------------------------------------------------------------------------------
--[문제32]
 
--EMPLOYEE 테이블에서 'J1' 직급의 최고 월급과 'J7' 직급의 최저 월급 조회
--단, 나머지 JOB_CODE는 '비밀' 처리
-----------------------------------------------------------------------------------
--[문제 33]
--EMPLOYEE 테이블에서
--전 직원의 평균급여보다 급여가 적은 직원들의 사원명, 급여를 조회하고
--급여 내림차순으로 정렬하시오
--(단일행 서브쿼리 사용)
-----------------------------------------------------------------------------------
--[문제 34]
--급여 평균이 3위안에 드는 직급을 찾아 직급코드, 직급명, 급여평군을 조회한 후
--ROWNUM과 라인뷰를 반영하여 조회하시오
-----------------------------------------------------------------------------------
--[문제 35]
--EMPLOYEE 테이블에서
--급여가 1,380,000원인 직원과 같은 직급코드, 같은 급여등급(SAL_LEVEL)에 해당하는 
--사원의 사원명, 직급코드, 급여등급을 조회하시오
--단, 급여가 1,380,000원인 해당직원은 제외하여 조회하시오
--(다중열 서브쿼리 사용)
-----------------------------------------------------------------------------------
--[문제 36]
--4/4분기 실적에 따른 상여금을 지급하게 되어 기존 월급에 따라 상여금을 지급하려 한다.
--급여(SALARY)가 400만원 초과 시 급여의 30%, 200만원 이상 400만원 미만이면 급여의 50%, 
--100만원이상 200만원 미만이면 급여의 70%를 지급한다.
--단, CASE문 사용하고 급여 순으로 내림차순 정렬
-----------------------------------------------------------------------------------
--[문제 37]
--EMPLOYEE 테이블에서 사번이 200, 201, 202인 사원들을 찾아
--200번인 사원의 주민번호 앞자리를 '621212'로
--201번인 사원의 주민번호 앞자리를 '631111'로
--202번인 사원의 주민번호 앞자리를 '861010'으로 변경하는 UPDATE 구문을 구현하시오.
-----------------------------------------------------------------------------------
--[문제 38]
--EMPLOYE 테이블에서 ENT_YN이 Y면 '퇴사자', N이면 '근무자'로 표시하고
--관리자 사번이 있으면 '일반사원', 관리자 사번이 없으면 '관리자'로 표시하고
--직원의 사번, 사원명, 부서코드, 직급코드, 근무 현황, 관리자 여부를 조회하시오.
-----------------------------------------------------------------------------------
--[문제39]
--EMPLOYEE 테이블에서 부서코드 D5의 직급코드가 J5도 아니고 J7도 아닌 사원의 
--사원명, 부서코드, 직급코드, SAL_LEVEL, 근무여부 조회
-----------------------------------------------------------------------------------
--[문제40]
--EMPLOYEE테이블에서
--급여가 가장 높은 사원의
--사원번호,사원명,급여,부서번호를 구하시오
--급여 순으로 내림차순 하시오
-----------------------------------------------------------------------------------
--[문제41]
--일본에 근무하면서 해외영업1부인 사원을 조회하여
--사번,사원명,부서명,지역명(LOCAL_NAME),급여를 구하시오
--단, 사번 순으로 오름차순 하시오
-----------------------------------------------------------------------------------
--[문제42]
--부서별로 가장 월급을 적게 받는 사원명을 검색하시오
--모든 컬럼을 조회하나, 부서별 내림차순으로 정렬하시오
-----------------------------------------------------------------------------------
--[문제 43]
--EMPLOYEE 테이블에서
--최저급여를 받는 직원과 같은 부서의 직원들의 
--이름, 부서코드, 급여를 조회하시오 (최저급여 직원도 포함)
--(서브쿼리 이중으로 사용)
-----------------------------------------------------------------------------------
--[문제44]
--EMPLOYEE 테이블에서 사원번호가 208인 사원과 동일한 직급코드를 가진 사원의 
--사원번호, 사원명, 직급코드, 급여 조회 (사원번호로 오름차순)
-----------------------------------------------------------------------------------
--[문제 45]
--현재 시간과 현재 시간으로부터 한 시간 후의 시간을 출력하라.
--시간 포맷 예시)2020-12-29 21:15:23
-----------------------------------------------------------------------------------
--[문제 46]
--1995년 5월 1일 ~ 2000년 5월 1일 사이에 입사한 사원들의 
--모든 정보를 부서번호순(오름차순)으로 검색하시오.
-----------------------------------------------------------------------------------
--[문제 47]
--20년 이상 근무자에게 희망퇴직 신청을 받으려고한다.
--조건은 3년 연봉(보너스 포함) + 5000만원의 위로금
--20년이상 근무자의 사원번호, 사원명, 부서명, 직급명, 입사일, 근무년수, 퇴직금(위로금포함)을 조회하고
--입사일 기준으로 내림차순으로 정렬하여 제출하십시오 
-----------------------------------------------------------------------------------
--[문제 48]
--근무 년수에 따른 '수질 상태'를 분류하기 위해 CASE문을 이용하여 이름(EMP_NAME),
--직급(JOB_NAME), 입사날짜(HIRE_DATE), 수질상태(CASE문)을 조회하시오.
--근무 년수가 30년 이상이면 '석유', 20 ~ 29년 '해골물', 10 ~ 19년 '썩은물', 
--5 ~ 9년 '고인물', 나머지는 '아리수' 
--JOB 테이블 JOIN(ANSI)구문으로 작성, 입사날짜순으로 오름차순 정렬
-----------------------------------------------------------------------------------
--[문제 49] 
--숫자 하나를 입력받아서 짝수면 '~는 짝수입니다.' 홀수면 '~는 홀수입니다.'라는 형식으로 출력되도록 하시오
-- CASE WHEN THEN 구문을 이용하시오.
-----------------------------------------------------------------------------------
--[문제 50] 
--숫자 하나를 입력받아서 
--양수이면 "~는 양수입니다." 음수면 "~는 음수입니다." 0이면 '0 입니다'라고 표시되게
-- CASE WHEN THEN 구문을 이용하시오.
-----------------------------------------------------------------------------------




























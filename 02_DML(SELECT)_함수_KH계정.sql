/*
     < 함수 FUNCTION >
     자바의 메소드와 같은 존재 
     전달된 값들을 읽어서 계산한 결과를 반환
     
     - 단일행 함수 :  N개의 값을 읽어서 N개의 결과를 리턴  ( 매 행마다 반복적으로 함수를 실행후 결과 반환 )
     - 그룹 함수 :  N개의 값을 읽어서 1개의 결과를 리턴 ( 하나의 그룹별로 함수 실행 후 결과 반환 ) => 예)SUM
     
     주의사항  : 단일행 함수와 그룹 함수는 함께 사용될 수 없음 ( 애초에 결과 행의 갯수가 다르기 때문)     
*/

----------<단일행 함수 >--------------

/*
        <문자열과 관련된 함수>
        LENGTH /  LENGTHB
        
        -LENGTH (STR) :  해당 전달된 문자열의 글자 수 반환 
        -LENGTHB (STR) : 해당 전달된 문자열의 바이트 수 반환
        
        결과값은 NUMBER 타입으로 반환
        STR  :  '문자열 리터럴'  / 문자열에 해당되는 컬럼
        
        한글 :  'ㄱ' , 'ㅣ', 'ㅁ', '김' , .. => 한 글자 당 3BYTE 로 취급
        숫자, 영문, 특수문자 :  ' ! ', ' ~ ', 'A' , ' a ' , '1' => 한 글자 당 1BYTE 로 취급        
*/

SELECT LENGTH('오라클!'), LENGTHB('오라클!') 
FROM DUAL;  -- 가상테이블 (DUMMY TABLE) : 산술 연산이나 가상 컬럼 등의 값을 한번만 출력하고 싶을 때 사용하는 가상 테이블

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL), 
             EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;

-------------------------------------------------------------------------------------------------------------------

/*
       INSTR
       
       -INSTR (STR, '특정문자' , 찾을위치의시작값,  순번   ) :  문자열로부터 특정 문자의 위치값 반환
       
       결과값은 NUMBER 타입으로 반환
       찾을위치의시작값, 순번은 생략 가능 ( DEFAULT  값이 있다.)
       
       STR  :  '문자열 리터럴'  / 문자열에 해당되는 컬럼
       
       찾을위치의시작값
       1  :  '특정문자'를 앞에서부터 찾겠다 . (생략시 기본값)
       -1 :  '특정문자'를 뒤에서부터 찾겠다.     
       
       순번 생략 시 기본값은 1이 된다 !
*/

SELECT INSTR('AABAACAABBAA', 'B')
FROM DUAL;  -- 3 :  기본적으로 앞에서부터 해당 '특정문자'의 첫 번째 글자의 위치를 반환
 
SELECT INSTR('AABAACAABBAA', 'B' , 1)
FROM DUAL;  --  3   : 앞에서부터 첫번째에 위치하는 'B' 의 위치값을 알려준 것

SELECT INSTR('AABAACAABBAA' , 'B', -1)
FROM DUAL; --  10  : 뒤에서부터 첫번째에 위치하는 'B'의 위치값을 앞에서부터 세서 알려준 것

SELECT INSTR('AABAACAABBAA' , 'B', 1 , 2 )
FROM DUAL;  -- 9  : 앞에서부터 두번째에 위치하는 'B'의 위치값을 앞에서부터 세서 알려준 것

SELECT INSTR('AABAACAABBAA' , 'B', -1, 2 )
FROM DUAL; --   : 뒤에서부터 두번째에 위치하는 'B'의 위치값을 앞에서부터 세서 알려준 것 (1부터 셈)

--  EMAIL 컬럼에서 '@' 의 위치를 찾아보자
SELECT EMAIL, INSTR (EMAIL, '@') AS "@의 위치"
FROM EMPLOYEE;

-- 순번이 존재하지 않는 경우 0이 반환됨
-- 자바에서 INDEXOF 와 비슷하다 (얘는 0부터 셈) / INSTR은 1부터 셈
---------------------------------------------------------------------------------------

/*
     SUBSTR
     
     - SUBSTR ( STR, POSITION, LENGTH )   :  문자열로부터 특정 문자열을 추출해서 반환
                                                                      (자바로 치면 문자열.substring () 메소드와 유사)
      결과값은 CHARACTER 타입으로 반환 (문자열 형태)
      LENGTH  생략 가능 ( 생략 시 끝까지 잘라냄 )
      
      - STR : '문자열 리터럴'  / 문자열 타입의 컬럼명
      -POSITION : 문자열 추출을 시작할 위치값, POSITION 번째 문자부터 추출하겠다.
      -LENGTH : 추출할 문자 갯수 
  
*/

SELECT SUBSTR('SHOWMETHEMONEY',7)
FROM DUAL; -- 'THEMONEY'  :  7번째 문자부터 끝까지 추출하겠다.

SELECT SUBSTR('SHOWMETHEMONEY',5,2)
FROM DUAL; -- 'ME' : 5번째 문자부터 2개만 추출하겠다.

SELECT SUBSTR('SHOWMETHEMONEY', 1, 6)
FROM DUAL; --'SHOWME' :  글자 위치 지정 시 1부터 센다!

SELECT SUBSTR('SHOWMETHEMONEY', -8 , 3)
FROM DUAL; --'THE' : 뒤에서부터 8번째 문자에서 3개만 추출하겠다.

-- POSITION 이 음수일 경우 뒤에서부터 N번째 글자에서부터 문자를 추출한다 라는 뜻!

-- 주민등록번호에서 성별 부분을 추출해서 남자 (1,3) / 여자(2,4) 를 체크
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1) AS "성별" 
FROM EMPLOYEE;

--남자사원들만 조회 (사원명, 급여)
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8, 1) = '1'  OR SUBSTR(EMP_NO, 8, 1) = '3' ;
WHERE  SUBSTR(EMP_NO, 8, 1)  IN ('1','3') ;

--여자사원들만 조회 (사원명, 급여)
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ( '2' ,'4' );

-- 중첩해서 함수를 사용 가능
-- 이메일에서 ID  부분만 추출해서 조회
--SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 첫번째 글자, 골뱅이위치-1 ) AS "ID"
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL,'@' ) -1 ) AS "ID"
FROM EMPLOYEE;

----------------------------------------------------------------------------------------------------------

/*
      LPAD  / RPAD
      
      -LPAD/ RPAD ( STR, 최종적으로반환할문자열의길이(바이트), '덧붙이고자하는문자' )
      :  제시한 문자열에 임의의 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N 길이만큼의 문자열을 반환
      
      결과값은 CHARACTER  타입으로 반환 (문자열 형태)
      '덧붙이고자하는문자'는 생략 가능 ( DEFAULT 값이 있음)
      
      -STR : '문자열 리터럴' / 문자열 타입의 컬럼명
*/

--SELECT LPAD(EMAIL, 16) -- '덧붙이고자하는문자'를 생략할 경우 공백이 기본값으로 들어감
SELECT LPAD(EMAIL , 16, ' ')
FROM EMPLOYEE; -- 총 16(BYTE) 글자짜리 문자열을 반환하겠다. 단, 부족한 내용물은 왼쪽에 덧붙이겠다. 

SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE; --총 20(BYTE) 글자짜리 문자열을 반환하겠다. 단, 부족한 내용물은 오른쪽에 덧붙이겠다. 

--  850918-2****** => 마스킹처리된 상태로 주민등록번호(총 14글자) 보여주기 
--SELECT RPAD (문자열, 총몇글자, 덧붙일문자)
SELECT RPAD ('850918-2', 14, '*')
FROM EMPLOYEE;

--모든 직원의 주민등록번호 뒤 6자리를 마스킹처리해서 표현
--1단계.  SUBSTR 이용해서 주민등록번호 앞 8자리만 추출
SELECT EMP_NAME,  SUBSTR(EMP_NO,1,8)
FROM EMPLOYEE;
--2단계. RPAD 이용해서 * 덧붙이기
SELECT EMP_NAME,  RPAD(SUBSTR(EMP_NO,1,8), 14, '*' )
FROM EMPLOYEE;

-------------------------------------------------------------------------------------------------------------

/*
        LTRIM   /  RTRIM
        
        - LTRIM / RTRIM (STR,  '제거시키고자하는문자' )
        
        결과값은  CHARACTER 타입으로 반환 (문자열 형태)
        '제거시키고자하는문자' 는 생략 가능 (DEFAULT 값이 있음)
        
        -STR : '문자열 리터럴'  / 문자열 타입의 컬럼명
        
*/

SELECT LTRIM ('       K       H')
FROM DUAL; --  '제거시키고자하는문자' 생략 시 공백을 의미

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

-- 제거해주는 문자열을 통으로 지워주는게 아니라 문자 하나하나가 다 존재하면 다 지워주는 원리 

-----------------------------------------------------------------------------

/*
       TRIM
   
        -TRIM( BOTH /LEADING / TRALLING   '제거시키고자하는문자'   FROM STR)
       :  문자열의 양쪽/ 앞쪽/ 뒤쪽에 있는 특정 문자를 제거한 나머지 문자열을 반환  
        '제거시키고자하는문자' 생략 시 공백을 의미
       결과값은 CARACTER 타입으로 반환 ( 문자열 형태)
      BOTH:  양쪽에 있는 문자 다 제거하겠다. (생략시 기본값)
      LEADING(선두):  앞쪽에 있는 해당문자를 다 제거하겠다.  (LTRIM 과 동일한 역할)
      TRALLING (쫒다): 뒤쪽에 있는 해당문자를 다 제거하겠다. (RTRIM 과 동일한 역할) 
      
        -STR: '문자열 리터럴'  / 문자열 형식의 컬럼명
    
*/

--기본적으로 양쪽에 있는 공백 제거
SELECT TRIM('         K     H    ')
FROM DUAL;
  
-- BOTH / LEADING / TRALLING 생략 시 기본은 BOTH
SELECT TRIM( 'Z'    FROM  'ZZZKHZZZ')
FROM DUAL;
 
 SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ')
 FROM DUAL;  -- BOTH : 양쪽 (생략 시 기본값)
 
 SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ')
 FROM DUAL;   --LEADING :  앞쪽 (LTRIM 함수와 동일)
 
 SELECT TRIM (TRAILING 'Z'  FROM 'ZZZKHZZZ')
 FROM DUAL; -- TRAILING : 뒤쪽 (RTRIM  함수와 동일)
 
 -- 매개변수가 문장의 형식으로 한개로 지정되어서 들어감!
 
  ------------------------------------------------------------------------------------------------------------------------------------
  /*
          LOWER  /  UPPER  / INITCAP
          
          - LOWER ( STR )  : 다 소문자로 변경
          - UPPER ( STR )  : 다 대문자로 변경
          - INITCAP( STR ) :  각 단어 앞글자만 대문자로 변경 (띄어쓰기 기준,  사전 기준 x)
          
          결과값은 CHARACTER 타입으로 반환 (문자열 형태)
          
          - STR : '문자열 리터럴'  / 문자열 타입의 컬럼명       
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
          
          - CONCAT ( STR1, STR2 )  :  전달된 두개의 문자열을 하나로 합친 결과를 반환
          
          결과값은 CHARACTER 타입으로 반환 (문자열 형태)
          
          - STR1, STR2 : '문자열 리터럴'  / 문자열 타입의 컬럼명
          
  */
  
  SELECT CONCAT('가나다' , 'ABC')
  FROM DUAL;
  
  SELECT '가나다'  ||   'ABC'
  FROM DUAL;
  
  SELECT '가나다'  ||  'ABC' ||  'DEF'
  FROM DUAL;
  
  SELECT CONCAT( '가나다', 'ABC', 'DEF')
  FROM DUAL;  -- 오류 : 두 개의 문자열만 제시 가능
  
  -- 함수를 중첩해서 여러개 이러붙일수 있다.
  SELECT CONCAT('가나다',  CONCAT('ABC' ,  'DEF') )
  FROM DUAL;
  ------------------------------------------------------------------------------------------------
  
  /*
     REPLACE
      
      -REPLACE( STR,  '찾을문자' , '바꿀문자' )
      : STR 로부터 '찾을문자'를 찾아서 '바꿀문자' 로 바꾼 문자열을 반환
      
      결과값은 CHARACTER 타임으로 반환
      
      - STR : '문자열 리터럴'  / 문자열 타입의 컬럼명   
  */
  
  SELECT REPLACE ('서울시 강남구 역삼동' , '역삼동', '삼성동')
  FROM  DUAL;
  
  --이메일의 도메인을 kh.co.kr  에서 iei.com 으로 변경
  SELECT EMP_NAME,  EMAIL , REPLACE (EMAIL, 'kh.or.kr',  'iei.com')
  FROM EMPLOYEE;
  
  ---------------------------------------------------------------------------------------------------------------
  
  /*
          <    숫자와 관련된 함수    > => 자바에서MATH 클래스
         
         ABS
         
         -  ABS ( NUMBER )  :  절대값을 구해주는 함수  
  */
  
  SELECT ABS(-10)
  FROM DUAL;  -- 10
  
  SELECT ABS(-10.9)
  FROM DUAL; --  10.9
  
  ------------------------------------------------------------------------------------------------------------------------
  
  /*
      MOD
      
      - MOD( NUMBER1  , NUMBER2 ) : 두 수를 나눈 나머지값을 반환해주는 함수  
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
       
       - ROUND(NUMBER , 위치 ) : 반올림 처리를 해주는 함수
       
       위치 : 소숫점 아래  N 번째 수에서 반올림하겠다.
                  위치는 생략 가능, 생략 시 기본값은 0 
  */
  SELECT ROUND(123.456)
  FROM DUAL;   --123  : 위치 생략시 기본값은 0
  
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
  --  -1 , -2 음수이면 소숫점 위로 반올림화가 된다. 
  
 -------------------------------------------------------------------------------------------------------------------------------------
 
 /*
       CELL
       
       -CELL (NUMBER) :  소숫점 아래의 수를 무조건 올림처리 해주는 함수
 */
  
  SELECT CEIL(123.156)
  FROM DUAL;  --124 (버리지 않고 무조건 올림)
  
  SELECT CEIL(251.999)
  FROM DUAL;  --252
  
  ----------------------------------------------------------------------------------------------------------------------------------
  
  /*
         FLOOR
         
         - FLOOR(NUMBER)   : 소숫점 아래의 수를 무조건 버림처리 해주는 함수 ( 소숫점 절삭) 
  */
  
  SELECT FLOOR( 123.956 )
  FROM DUAL;  --123
  
  SELECT FLOOR(207.68)
  FROM DUAL;  --207
  
  ---각 직원별로 고용일로부터 오늘까지  근무일수 (오늘날짜-입사일 )를 조회
  -- 근무일수 뒤에 '일' 이라는 날짜의 단위 , 근무일수라는 컬럼명(별칭)도 추가
  
  --SELECT EMP_NAME, FLOOR(SYSDATE- HIRE_DATE ) || '일'   "근무일수"
 SELECT EMP_NAME, CONCAT(FLOOR(SYSDATE- HIRE_DATE),    '일')  "근무일수"
  FROM EMPLOYEE;
  
  -------------------------------------------------------------------------------------------------
  
  /*
     TRUNC
     
     -TRUNC ( NUMBER, 위치 ) : 위치 지정가능한 버림 처리를 해주는 함수 
     
     위치는  생략 가능, 생략 시  기본값은 0  (소숫점 밑을 다 잘라내겠다.) 
     소숫점 아래의 위치 까지만 남겨놓고 버림처리하겠다.
  */
  
  SELECT TRUNC(123.756)
  FROM DUAL;   -- 123 (FLOOR와 같음)
  
  SELECT TRUNC(123.756 , 1)
  FROM DUAL;  -- 123.7
  
  SELECT TRUNC(123.756 , -1)
  FROM DUAL;  -- 120
  
  -----------------------------------------------------------------------------------------------------------------------------
  /*
         <  날짜  관련 함수  >
     
      DATE 타입 :  년, 월, 일, 시, 분, 초 를 다 포함한 자료형     
  */
  
  -- SYSDATE  :  오늘날짜, 현재 내 컴퓨터의 시스템 날짜 
  SELECT SYSDATE
  FROM DUAL;
  
  -- MONTHS_BETWEEN (DATE1, DATE2)  : 두 날짜 사이의 개월수 반환  , NUMBER  타입 반환
 --                                                                            일, 시, 분, 초 가 소숫점으로 나옴!                                                                           
  --  각 직원별로 고용일로부터 오늘까지의 근무일수, 근무 개월수를 조회
  --SELECT EMP_NAME, 근무일수 , 근무개월수
  SELECT EMP_NAME, 
                   FLOOR(SYSDATE -  HIRE_DATE) ||  '일'  "근무일수",
                   FLOOR(MONTHS_BETWEEN(SYSDATE,  HIRE_DATE))  || '개월'  "근무개월수"
  FROM EMPLOYEE;
  -- DATE1 이 더 미래여야지 양수 결과가 나옴 
  -- DATE2 가  미래일경우 음수가 결과로 나옴  
  
  -- ADD_MONTHS( DATE, NUMBER ) : 특정 날짜에 해당 숫자만큼의 개월수를 더한 날짜를 반환 , DATE 타입 반환
  -- 오늘 날짜로부터 5개월 후
  SELECT ADD_MONTHS(SYSDATE, 5)
  FROM DUAL;   
  
  -- 전체 사원들의 직원명, 입사일, 입사 후 6개월이 흘렀을 때의 날짜  조회
  SELECT EMP_NAME,  HIRE_DATE,  ADD_MONTHS(HIRE_DATE,  6)
  FROM EMPLOYEE;
  
  -- 음수로 지정하면?
  SELECT ADD_MONTHS(SYSDATE, -5)
  FROM DUAL;
  
  --NEXT_DAY ( DATE, 요일( 문자/ 숫자 ) ) :  특정 날짜에서 가장 가까운 해당 요일을 찾아서 그 날짜를 반환
  SELECT NEXT_DAY(SYSDATE, '일요일')
  FROM DUAL;   --22/03/20
  
  SELECT NEXT_DAY(SYSDATE, '일')
  FROM DUAL;  --22/03/20
  
  -- 1 :  일요일 , 2 : 월요일 , 3 : 화요일 , .... 6: 금요일 , 7 : 토요일
  SELECT NEXT_DAY(SYSDATE, 7)
  FROM DUAL; --22/03/19
  
  -- 현재 언어가  KOREAN  이기 때문에 에러가 난다.
  SELECT NEXT_DAY(SYSDATE, 'SUNDAY')
  FROM DUAL;
  
  --언어 변경
  ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
  
  -- SUNDAY 로 다시 조회
  SELECT NEXT_DAY(SYSDATE, 'SUNDAY')
  FROM DUAL; --22/03/20
  
  --일요일로 다시 조회
 SELECT NEXT_DAY(SYSDATE, '일요일')
  FROM DUAL; 
  
  -- 항상 요일을 문자 형식으로 나타내고자 할 때에는 현재 언어 형식에 맞게 제시를 해야 함!
  
  --  한글로 변경
  ALTER SESSION SET NLS_LANGUAGE=KOREAN;
  
  -- LAST_DAY ( DATE ) : 특정 날짜가 속한 달의 마지막 날짜를 구해서 반환, DATE 타입 반환
  SELECT LAST_DAY(SYSDATE)
  FROM DUAL; --22/03/31
  
  --이름, 입사일, 입사한 달의 마지막 날짜 조회
  SELECT EMP_NAME, HIRE_DATE,  LAST_DAY(HIRE_DATE)
  FROM EMPLOYEE;
  
  /*
       EXTRACT :  년도 또는 월 또는 일 정보를 추출해서 반환  ( NUMBER 타입 반환)
       
       - EXTRACT( YEAR FROM DATE ) : 특정 날짜로부터 년도만 추출
       - EXTRACT (MONTH FROM DATE) : 특정 날짜로부터 월만 추출
       - EXTRACT (DAY FROM DATE )  : 특정 날짜로부터 일만 추출
  */
  
  -- 오늘 날짜 기준으로 EXTRACT 함수 적용
  SELECT EXTRACT (YEAR FROM SYSDATE),
                  EXTRACT ( MONTH FROM SYSDATE),
                 EXTRACT  ( DAY FROM SYSDATE)
  FROM DUAL;               
  
  -- 사원명, 입사년도, 입사월, 입사일 조회
  SELECT EMP_NAME, 
                  EXTRACT( YEAR FROM HIRE_DATE)  "입사년도",
                  EXTRACT( MONTH FROM HIRE_DATE)  "입사월",
                  EXTRACT( DAY FROM HIRE_DATE) "입사일"
  FROM EMPLOYEE      
  ORDER BY "입사년도" , "입사월" , "입사일";  --ASC가 생략된 꼴           
                
  ------------------------------------------------------------------------------------------------------------------------------------------
  
  /*
        <  형변환 함수 >
        
        NUMBER / DATE => CHARACTER
       
       - TO_CHAR ( NUMBER  / DATE ,  '포맷' ) --> 자바에서 simpledate 포멧  이랑 비슷하다
         : 숫자형 또는 날짜형 데이터를 문자형 타입으로 변환 (CHARACTER 타입 반환)     
  */
 
 SELECT 1234 ,TO_CHAR(1234 )
 FROM DUAL;  --  1234 => '1234'
 
 SELECT TO_CHAR (1234,  '00000')
 FROM DUAL; --  1234 => '01234'  :  빈칸을  0으로 채움.
 
 SELECT TO_CHAR(1234,  '99999')
 FROM DUAL;  -- 1234 => ' 1234' : 빈칸을 공백으로 채움  
  
 SELECT TO_CHAR(1234,  'L00000')
 FROM DUAL;  --1234 =>  '￦01234' : 현재 설정된 나라(LOCAL)의 화폐단위
 
SELECT TO_CHAR(1234, 'L99999')
FROM DUAL; --1234 =>  '￦1234' : 현재 설정된 나라(LOCAL)의 화폐단위 , 공백 생략됨. 

SELECT TO_CHAR(1234, '$99999')
FROM DUAL;  --1234 =>  '$1234'

SELECT TO_CHAR(1234,  'L99,999')
FROM DUAL; --1234 => ' ￦1,234' : 3자리마다  , 로 구분

-- 급여정보를 3자리마다  , 로 구분하여 출력 + 화폐단위
SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999') "급여정보"
FROM EMPLOYEE;

--여기까지 TO_CHAR 함수를 이용해서 숫자를 문자형식으로 바꾼 것

-- DATE( 년월일시분초 ) => CHARACTER
SELECT SYSDATE
FROM DUAL;    --날짜형식

SELECT TO_CHAR(SYSDATE)
FROM DUAL;    --문자형식   '22/03/14'

-- 포맷을 지정 안한 경우에는 YY/MM/DD 형식으로 나옴

-- 'YYYY-MM-DD'  형식으로   보여지고  싶다!
SELECT TO_CHAR(SYSDATE,   'YYYY-MM-DD')
FROM DUAL;   -- 문자형식  '2022-03-14'
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
-- 03_PLSQL-Function.sql

-- 함수
-- PL/SQL 코드 작성시에는 지금까지 사용하던 익명 블럭은 잘 사용하지 않음
-- 일반적으로 이름이 있는 서브 프로그램(함수) 또는 프로시저를 사용하는 것이 대부분임.
-- 익명 블럭은 한 번 사용하고 나면 없어져 버리는 휘발성 블럭이지만
-- 함수 또는 프로시져 컴파일을 거쳐 데이텁베이스에 저장되어 재사용이 가능한 구조임.

-- 함수의 정의 형태

-- CREATE OR REPLCE FUNCTION 함수이름 ( 매개변수1, 매개변수2..)
-- RETURN 리턴을 데이터타입;
-- IS(AS)
--     변수 , 상수 선언
-- BEGIN
--     실행부
--     RETURN 리턴값;
-- [ EXCEPTION
--     예외처리부 ]
--  END [함수이름];

-- 각 키워드별 상세내용
-- CREATE OR REPLACE FUNCTION : CREATE OR REPLACE FUCTION 라는 구문을 이용하여 함수를 생성함.
--      함수를 만들고 수정하더라도 이 구문을 계속 컴파일 할 수 있고, 마지막으로 컴파일 한 내용이
--      함수의 내용과 이름으로 사용됩니다
-- 매개변수 : 전달인수를 저장하는 변수로 " 변수이름 변수의 자료형 " 형태로 작성합니다
-- 첫 번째 RETURN 구분 다음에는 리턴될 자료의 자료형을 쓰고, 아래 쪽 두 번째 RETURN 구문 옆에는
--     그 자료형으로 실제 리턴될 값 또는 변수이름을 써줌.
-- [] 안에 있는 EXCEPTION 구문은 필요치 않을 시 생략이 가능함.


-- 두 개의 정수를 전달해서 첫 번째 값을 두 번째 값으로 나눈 나머지를 구해서 리턴해주는 함수

CREATE OR REPLACE FUNCTION myMod( num1 NUMBER, num2 NUMBER )
     RETURN NUMBER
IS
      v_remainder NUMBER := 0;   -- 나눈 나머지를 저장 할 변수
      v_mok      NUMBER := 0;    -- 나눈 몫을 저장 할 변수
BEGIN
      v_mok := FLOOR (num1 / num2);  -- 나눈 몫의 정수 부분만 저장.(소수점 절삭)
      v_remainder := num1 - (num2 * v_mok);   -- 몫 * 제수(나누는 수)를 피제수(나누어지는 수)에서 빼면 나머지가 계산됨
      RETURN v_remainder;
END;

SELECT myMod(14, 4) FROM DUAL;



-- 연습문제1----
-- 도서번호를 전달인수로 전달하여, booklist에서 해당 도서 제목을 리턴받는 함수를 제작하시오

-- 함수 호출 명령
SELECT subjectbynum(5)  ,subjectbynum(8) FROM dual;

-- 함수 제작
CREATE OR REPLACE FUNCTION subjectbynum (num NUMBER)
    RETURN VARCHAR2
IS 
     v_subject booklist.subject%TYPE;
BEGIN
     SELECT subject 
     INTO v_subject
     FROM BOOKLIST
     WHERE booknum = num;
     RETURN v_subject;
END;


-- 연습문제2
-- 위의 함수의 기능 중 전달된 도서번호로 검색된 도서가 없다면, '해당 도서 없음' 이라는 문구가 리턴되도록 수정해주세요
-- FUNCTION 내부에서 COUNT(*) 함수 활용. 조회한 도서번호의 레코드갯수가 0개이면 "해당 도서 없음" 리턴
-- 도서가 있으면 도서제목을 리턴합니다.
select subjectbynum2(8), subjectbynum2(20) from dual;

create or replace function subjectbynum2( num Number )
    return varchar2
is
    v_cnt number;
    v_subject booklist.subject%type;
begin
    -- 전달받은 도서번호의 해당하는 도서가 몇 권인지 조회
    select count(*) into v_cnt from booklist where booknum = num;
    if v_cnt = 0 then
       v_subject := '해당 도서 없음';
    else
        select subject into v_subject from booklist where booknum = num;
    end if;
    return v_subject;
    
end;

-- 매개변수가 없는 함수
create or replace function fn_get_user  -- 매개변수가 없는 함수는 괄호 없이 정의하기도 합니다.
    return varchar2
is
    vs_user_name varchar2(80);
begin
    select user into vs_user_name from dual;    -- 현재 오라클 로그인 유저 조회 > vs_user_name 변수에 저장
    return vs_user_name;    -- 사용자이름 리턴
end;
select fn_get_user(), fn_get_user from dual;    -- 매개변수가 없는 함수는 괄호 없이 호출하기도 합니다.





-- 연습문제 3
-- emp 테이블에서 각 부서번호를 전달받아서 급여의 평균값을 계산하여 리턴하는 함수를 제작하세요
-- 전달된 부서번호의 사원이 없으면 급여 평균은 0으로 리턴하세요.
-- 함수 호출은 아래와 같습니다.
select salAvgDept(10), salAvgDept(20), salAvgDept(30), salAvgDept(40) from dual;

create or replace function salAvgDept( p_deptNo Number )
    return number
is
    v_cnt number;
    v_avg number;
begin
    select count(*) into v_cnt from emp where deptno = p_deptNo;    -- 전달된 부서번호가 존재하는지 먼저 검사
    if v_cnt = 0 then
       v_avg := 0;
    else
        select avg(sal) into v_avg from emp where deptno = p_deptNo;
    end if;
    return v_avg;
end;
















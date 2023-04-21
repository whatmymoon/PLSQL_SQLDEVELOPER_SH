-- PL/SQL

-- 다수의 SQL 명령이 모여서 하나의 작업모듈 또는 트랙잭션을 이룰 때 이를 하나의 블럭으로 묶어서 한번에 실행하게 하는 단위실행명령입니다.

-- 예를 들어 일반적인 쇼핑몰 데이터베이스에서
-- 장바구니에 있는 목록을 꺼내서 주문 테이블에 넣어야 할 때
-- 1. 장바구니 테이블에서 현재 접속자가 넣어둔 목록 조회(select)
-- 2. 목록을 주분테이블에 추가(insert)


-- 위와 같이 두 개 이상의 sql이 한번에 실행되고자 한다면 select 의 결과를 변수에 넣고
-- 변수에 저장된 값을 다시 insert 할 수 있습니다.
-- 오라클이 제공하는 프로그래밍 요소와 함께 SQL 명령 그룹(블럭)을 만들어 한 번에 실행 할 수 있게 합니다.
-- 그렇게 만들어진 PL/SQL 블럭은 추후에 우리가 학습할 MyBatis 에서도 활용됩니다.


-- 블럭
-- PL/SQL 은 여러 블럭으로 구성되어 있는데, 쉽게 짐작할 수 있는 실행할 SQL 명령이 모여있는 블럭 등이 있으며, 이는 명령의 실행단위가 됩니다.
-- 이외 익명 블럭, 이름이 있는 블럭 등도 있고,
-- 내부는 기능별로 이름부, 선언부, 실행부, 예외처리부로도 나누기도 합니다.

-- PL/SQL 문(블럭)의 구성예
-- PL/SQL 로 하나의 단위명령을 실행할 때 아래와 같이 각 위치, 기능별 구성이 이루어집니다.
IS(AS)
-- 이름부
DECLARE
-- 선언부(변수 선언 등등)
BEGIN
-- 실행부(SQL 명령)
EXCEPTION
-- 예외처리부
END;
-- BEGIN, END 를 제외한 나머지는 필요에 의해 생략이 가능합니다.





-- 익명 블럭 (사용하지 않는 영역 키워드는 생략해도 무방합니다.)
DECLARE
    num NUMBER; -- 변수선언
BEGIN
    num := 100; -- num 변수에 100을 저장 -> 실행명령 1
    DBMS_OUTPUT.PUT_Line(num); -- 결과화면에 num 변수값을 출력하세요 -> 실행명령 2
END;



-- 화면 출력을 하기위해 기능을 ON 합니다
SET SERVEROUTPUT ON

-- 실행시간을 출력하기 위한 기능을 ON 합니다
SET TIMING ON
SET TIMING OFF



-- 우리의 현재 목표는 웹사이트에서 전달받은 전달인수로 연산(SQL)하고, 결과를 웹사이트로 다시 리턴해주는 것이지만
-- 현재는 그 상황까지 공부하지 못했으므로 내가 값을 넣어주고(num := 100;), 결과를 화면으로 출력합니다.
-- (DBMS_OUTPUT.PUT_LINE(num);)

-- 변수 : 첫번째 SQL 에서 Orders 테이블에 레코드를 삽입하고, 가장 큰 기본키값을 조회한 다음 그 값을
--      order_detail 의 입력값으로 사용하려면 변수를 선언하고 값을 저장해서 활용합니다.
-- 변수 선언방법
-- 변수명 변수자료타입
-- := 초기값; SQL 명령내의 = 과 구분하기위해 :=으로 사용합니다.

-- PL/SQL 의 자료형
-- 기존의 Oracle 자료형은 모두 포함하며, 자유롭게 사용할 수 있습니다.
-- BOOLEAN : TRUE, FALSE, NULL 을 갖을 수 있는 자료형
-- PLS_INTEGER : -2147483648 ~ 2147483647 값을 갖는 정수 NUMBER 형에 비해 저장공간을 덜 차지 합니다.
-- BINARY_INTEGER : PLS_INTEGER 와 같은 용량 같은 용도로 사용합니다.
-- NATRAL : PLS_INTEGER 중 양수(0 포함)
-- NATRALN : NATRAL 과 같지만, NULL 허용이 없고 선언과 동시에 초기화가 필요합니다.
-- POSITIVE : PLS_INTEGER 중 음수(0 미포함)
-- POSITIVEN : POSITIVE 와 같지만, NULL 허용이 없고 선언과 동시에 초기화가 필요합니다.
-- SIGNTYPE : -1, 0, 1
-- SIMPLE_INTEGER : PLS_INTEGER 중 NULL 이 아닌 모든 값, 선언과 동시에 초기화가 필요합니다.




-- 연산자
-- ** : 제곱 (자승) 연산 -> 3**4 3의 4승
-- +,- : 양수 음수 구분 연산
-- 사칙연산 +, -, *, /, ||(문자열연결)
-- 비교연산 =, >, <, >=, <=, <>, !=, IS NULL, LIKE, BETWEEN, IN
-- 논리연산 NOT AND OR




-- PL/SQL 블럭에 연산자를 사용한 예
DECLARE
    a INTEGER;
BEGIN
    a := 2**2*3**2;
    DBMS_OUTPUT.PUT_LINE('a = ' || TO_CHAR(a));
END;
-- BEGIN 등의 각 영역 내부에서는 한 문장의 SQL 문도 하나의 명령어로 인식하고,
-- 연산자를 포함한 일반 명령어도 하나의 명령어로 인식해서
-- 명령의 맨 뒤에 ';' 이 있는 곳까지 실행합니다.



-- SQL Developer 쿼리창에는 반드시 블럭만 사용할 수 있는 건 아닙니다. 아래와 같이 일반적은 SQL 문도 사용가능합니다.
select * from emp;








-- ★★★ SQL 문과 같이 사용되는 PL/SQL 블럭

-- ★★ emp 테이블에서 사원번호가 7900 인 사원의 이름을 출력하세요.
select ename from emp where empno = 7900; -- ->질의 결과 창에 table 형식으로 출력.

-- ★★ 위 문장을 PL/SQL의 블럭에 넣고 결과를 변수에 저장해서 DBMS_OUTPUT.PUT_LINE 으로 출력합니다.
DECLARE
    v_ename VARCHAR2(30);
BEGIN
    SELECT ename 
    INTO v_ename 
    from emp 
    WHERE empno = 7900;
    -- 블럭안에서 SQL 명령도 실행 가능합니다.
    -- 블럭안에 SQL문은 따로 별도 지정없이 그냥 다른 명령과 같이 기술하면 됩니다.
    -- SQL 문의 결과를 변수에 답아내는 방법 -> select 와 from 사이에 into 키워드를 넣고 저장될 변수를 저장합니다.
    -- SELECT 문과 FROM 사이에 지정한 핃드가 여러개면, 그 갯수 만큼 INTO 에 변수를 지정하여 모두 저장될 수 있게 합니다.
    DBMS_OUTPUT.PUT_LINE(v_ename);
END;





-- 사원번호가 7900인 사원의 이름과 급여를 출력하세요
DECLARE
    empname varchar2(30);
    empsal number;
BEGIN
    select ename, sal
    into empname, empsal
    from emp
    where empno=7900;
    DBMS_OUTPUT.PUT_LINE( '성명 : ' || empname || ', 급여 : ' || to_char(empsal) );
END;




-- 변수의 갯수가 많은 경우 자료형을 일일히 맞춰서 선언하기가 번거로우므로, 매칭할 필드의 이름과 %type 을 이용하여
-- 자동으로 자료형이 맞춰지도록 합니다
DECLARE
    empname emp.ename%TYPE;     -- emp테이블의 ename 필드의 자료형을 변수의 자료형을 맞춰주세요.
    empsal emp.sal%TYPE;
BEGIN
    select ename, sal
    into empname, empsal
    from emp
    where empno=7900;
    DBMS_OUTPUT.PUT_LINE( '성명 : ' || empname || ', 급여 : ' || to_char(empsal) );
END;




-- 연습문제1
-- DBMS_OUTPUT.PUT_LINE() 을 9번 사용하여 구구단 7단을 출력하는 익명 블럭을 제작하세요.
-- 이어붙이기 연산도 사용합니다.
-- 현재는 변수가 필요하지 않기 때문에 DECLARE 도 쓰지 않아도 됩니다.
-- 3x1=3 3x2=6 3x3=9 ... 에서 3 6 9 는 계산에 의해 출력되게 합니다.
BEGIN
    dbms_output.put_line('7 x 1 = ' || 7*1);
    dbms_output.put_line('7 x 2 = ' || 7*2);
    dbms_output.put_line('7 x 3 = ' || 7*3);
    dbms_output.put_line('7 x 4 = ' || 7*4);
    dbms_output.put_line('7 x 5 = ' || 7*5);
    dbms_output.put_line('7 x 6 = ' || 7*6);
    dbms_output.put_line('7 x 7 = ' || 7*7);
    dbms_output.put_line('7 x 8 = ' || 7*8);
    dbms_output.put_line('7 x 9 = ' || 7*9);
END;




-- 연습문제 2
-- 사원테이블(emp) 에서 사원번호(empno) 7788번 사원의 이름(ename)과 부서명(dname)을 출력하는 익명 블록을 만드세요.
-- join 명령 사용 '이름 - 부서명' 을 스크립트 출력창에 출력하세요.

DECLARE
    empname emp.ename%TYPE;
    deptname dept.dname%TYPE;
BEGIN
    select a.ename, b.dname
    into empname, deptname
    from emp a, dept b
    where a.deptno = b.deptno and empno = 7788;
    
    DBMS_OUTPUT.PUT_LINE( '성명 : ' || empname || ' 부서명 : ' || deptname );
END;

select * from dept




-- 연습문제 3
-- select 로 얻어내 값을 insert 명령에 사용합니다.
-- 사원테이블(emp) 테이블에서 가장 큰 사원번호(empno)로 조회하고,
-- 그 사원번호보다 1 만큼 큰 숫자를 새로운 입력 레코드의 사원번호로 하여 레코드를 추가하세요
-- 일련번호 필드에 시퀀스가 없는 경우 사용하는 방법입니다.

-- 사원명 : HARRISON
-- JOB : MANAGER
-- MGR : 7566
-- HIREDSTE : 2023/04/20(오늘날짜)
-- SAL : 3000
-- COMM : 700
-- DEPTNO : 40
declare
    max_empno emp.empno%type;
begin
    select MAX(empno)
    into max_empno
    from emp;
    
    -- max_empno := max_empno + 1;
    
    insert into emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
    values (max_empno + 1, 'HARRISON', 'MANAGER', 7566, sysdate, 3000, 700, 40); -- sysdate : 오늘날짜
    
    commit;
end;
select * from emp order by empno desc;











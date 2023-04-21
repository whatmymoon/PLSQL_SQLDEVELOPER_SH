-- 05_CURSOR.sql

-- CURSOR : 주로 프로시져 내부의 SQL 명령 중 SELECT 명령의 결과가 다수의 행으로 얻어졌을 때
-- 사용하는 결과를 저장하는 변수를 말합니다.
SET SERVEROUTPUT ON;


DECLARE
    v_job varchar2(30);
BEGIN
    select job into v_job from emp where deptno = 30;
    DBMS_OUTPUT.PUT_LINE(v_job);
END;
-- 위의 익명블럭은 SELECT 명령의 결과가 1행(ROW) 이므로 실행이 가능하지만,
-- 이는 SELECT 명령의 결과가 2행 이상이라면 에러가 발생합니다.
-- 2행 이상의 결과를 담을 수 있는 메모리 영역(또는 변수)으로 사용하는 것이 CURSER이며 자바의 리스트와 비슷한 구조를 갖고 있습니다.
-- 또는 반복실행문을 이용하여 그 값들을 참조하고 출력하고 리턴할 수 있습니다.



-- CURSOR 의 생성-실행단계

-- 1. CURSOR의 생성 (정의)
-------------------------------------------------------------------------------
-- CURSOR 사용할 커서의 이름[ (매개변수1, 매개변수2, ....) ]
-- IS
-- SELECT ....SQL 문장
-------------------------------------------------------------------------------
-- 매개변수의 역할 : SELECT 명령에서 사용할 값들을 저장( 주로 WHERE 절에서 사용할 값들)
-- SELECT ....SQL 문장 : 실행되어 CURSOR 에 결과를 안겨줄 SQL 명령



-- 2. CURSOR 의 OPEN (호출)
-------------------------------------------------------------------------------
-- OPEN 커서이름[ (전달인수1, 전달인수2, ....) ]
-------------------------------------------------------------------------------
-- 실제로 전달인수를 전달하여 커서안의 SQL문을 실행하고 결과를 커서에 저장합니다.


-- 3. 결과를 반복실행문과 함께 필요에 맞게 처리
-------------------------------------------------------------------------------
-- LOOP
--      FETCH 커서이름 INTO 변수(들);
--      EXIT WHEN 커서이름$NOTFOUND;    -- SELECT 에 의해 얻어진 레코드가 다 소진되어 없을때까지....반복계속
--      필요에 맞는 처리 실행
-- END LOOP;
-------------------------------------------------------------------------------
-- FETCH 커서이름 INTO 변수;  커서에 담긴 데이터들 중 한 줄씩 꺼내서 변수(들)에 넣는 동작입니다.
-- EXIT WHEN 커서이름%NOTFOUND;     꺼냈는데 데이터가 없으면 종료합니다.
-- LOOP 안에서 필요에 맞는 처리를 데이터가 없을때까지 반복합니다.


-- 4. CURSOR 닫기
-------------------------------------------------------------------------------
-- CLOSE 커서명
-------------------------------------------------------------------------------



-- CURSOR 의 사용
-- 전달인수로 부서번호를 전달한 후 그 부서의 사원이름과 직업들을 얻어오는 커서
DECLARE
    v_ename emp.ename%TYPE;
    v_job emp.job%TYPE;
    
    -- 1. 커서의 정의
    CURSOR cur_emp( p_deptno emp.deptno%TYPE )
IS
    SELECT ename, job FROM emp WHERE deptno = p_deptno;
    
BEGIN
    -- 2. 커서를 호출하고 실행
    OPEN cur_emp(30);
    
    -- 3. 반복실행문으로 얻어진 커서안의 내용을 하나씩 꺼내서 출력합니다.
    LOOP
        FETCH cur_emp INTO v_ename, v_job;
        EXIT WHEN cur_emp %NOTFOUND;
        DBMS_OUTPUT.PUT_LINE( v_ename || ' - ' || v_job );
    END LOOP;
    CLOSE cur_emp;
END;



-- 기존의 FOR문-----------------------------------------------------------------
-- FOR 인덱스변수 IN [REVERSE] 처음값....끝값
-- LOOP
--      실행문
-- END LOOP;
-- 처음값부터 끝값까지 하나씩 인덱스변수에 저장하면 반복실행
------------------------------------------------------------------------------

-- 커서와 함께 사용하는 FOR 문----------------------------------------------------
-- FOR 레코드변수 IN 커서이름(전달인수1, 전달인수2....)
-- LOOP
--      실행문
-- END LOOP
------------------------------------------------------------------------------
-- OPEN 과 LOOP 가 합쳐진 예입니다.

DECLARE
    -- emp_rec 라는 레코드변수안에 필드명이 다 살아 있어서, 각 행의 필드값을 저장할 별도의 변수는 필요하지 않습니다.
    CURSOR cur_emp( p_deptno emp.deptno%TYPE )
    IS
    SELECT ename, job FROM emp WHERE detpno = p_deptno;
BEGIN
    FOR emp_rec IN cur_emp(30)
    LOOP
        -- 필요한 필드는 emp_rec 뒤로 필드명을 지정하여 사용이 가능합니다.
        DBMS_OUTPUT.PUT_LINE( emp_rec.ename || ' - ' || emp_rec.job );
    END LOOP;
------------------------------------------------------------------------------
--    OPEN cur_emp(30);
--    
--    -- 3. 반복실행문으로 얻어진 커서안의 내용을 하나씩 꺼내서 출력합니다.
--    LOOP
--        FETCH cur_emp INTO v_ename, v_job;
--        EXIT WHEN cur_emp %NOTFOUND;
--        DBMS_OUTPUT.PUT_LINE( v_ename || ' - ' || v_job );
--    END LOOP;
--    CLOSE cur_emp;
------------------------------------------------------------------------------
END;



-- for문을 이용하여 커서변수의 사용이 조금 더 간단해집니다.

-- 조금 더 간결한 FOR 문과 커서의 사용
DECLARE
BEGIN
    FOR emp_rec IN ( SELECT * FROM emp WHERE deptno = 30 )
    LOOP
        DBMS_OUTPUT.PUT_LINE( emp_rec.ename || ' - ' || emp_rec.job );
    END LOOP;
END;



-- 연습문제
-- 부서번호가 30번인 사원의 이름, 부서명, 급여, 급여수준(높음, 보통, 낮음) 을 출력하세요.
-- 급여(sal)는 1000 미만 낮음, 1000~2500 보통 나머지 높음 으로 출력하세요
-- 이름 - 부서명 - 급여 - 높음 순으로 출력하세요.
select * from emp;
DECLARE
    level VARCHAR2(10);
BEGIN
    FOR emp_rec IN ( SELECT a.ename, b.dname, a.sal FROM emp a, dept b WHERE a.deptno = b.deptno AND a.deptno = 30 )
    LOOP
        IF emp_rec.sal < 1000 THEN
            level := '낮음';
            -- DBMS_OUTPUT.PUT_LINE( emp_rec.ename || ' - ' || emp_rec.job || ' - ' || emp_rec.sal || ' - ' || '낮음' );
        ELSIF emp_rec.sal BETWEEN 1000 AND 2500 THEN
            level := '보통';
            -- DBMS_OUTPUT.PUT_LINE( emp_rec.ename || ' - ' || emp_rec.job || ' - ' || emp_rec.sal || ' - ' || '보통' );
        ELSE
            level := '높음';
            -- DBMS_OUTPUT.PUT_LINE( emp_rec.ename || ' - ' || emp_rec.job || ' - ' || emp_rec.sal || ' - ' || '높음' );
        END IF;
            DBMS_OUTPUT.PUT_LINE( emp_rec.ename || ' - ' || emp_rec.dname || ' - ' || emp_rec.sal || ' - ' || level );
    END LOOP;
END;

-- 커서 변수
-- 앞에서 생성한 커서의 이름은 함수처럼 호출되는 이름이기도 하고, 커서를 대표하는 이름이었습니다.
-- 그러나 커서의 이름으로 다른 커서를 만들지는 못합니다.
-- 변수로 치면 앞에서 만든 커서의 이름은 상수 정도로 표현이 가능합니다.
-- 앞으로 나올 이름은 변수로서 사용되고, 다른 커서도 저장할 수 있게 사용하고자 합니다.
-- 커서변수를 사용해야 프로시져내에서 커서변수를 OUT 변수로 지정하고 리턴동작으로 활용할 수 있습니다.


-- 커서 변수의 선언
-- TYPE 사용할 커서의 타입이름 IS REF CURSOR [ RETURN 반환타입 ];
--      -> 생성된 커서타입의 이름으로 커서 변수를 선언할 예정입니다.
-- 커서변수이름 커서타입이름;
-- 커서 타입을 만들때 RETURN 값을 지정하면 강한커서타입이 생성되는 것이고, RETURN 이 없으면 약한 커서타입이라고 지칭합니다.
TYPE dep_curtype1 IS REF CURSOR RETURN emp%ROWTYPE;     -- 강한 커서 타입
TYPE dep_curtype2 IS REF CURSOR;
-- 위 두 줄의 명령은 커서의 이름을 생성한 것이 아니라, 커서를 선언할 수 있는 "커서자료형 (TYPE)" 을 생성한 겁니다.
-- 커서자료형 (TYPE)을 이용하여 이제 실제 커서변수를 선언할 수 있습니다.
cursor1 dep_curtype1;
cursor2 dep_curtype2;

-- cursor1과 cursor2 변수에는 select 명령을 담아서 커서를 완성할 수 있습니다.
-- 또한 커서내용(select 문)이 고정적이지 않고 바뀔 수 있습니다.
-- 다만 cursor1 은 강한 커서 타입이므로 정의되어 있는대로 (RETURN departments%ROWTYPE) 레코드 전체의 결과를 얻는 select만
-- 저장할 수 있습니다.
OPEN cursor1 FOR SELECT empno, ename FROM emp WHERE deptno = 30;    -- x 불가능
OPEN cursor1 FOR SELECT * FROM emp WHERE deptno = 30;   -- o : 가능

OPEN cursor2 FOR SELECT empno, ename FROM emp WHERE deptno = 30;    -- o : 쌉가능
OPEN cursor2 FOR SELECT * FROM emp WHERE deptno = 30;   -- o : 가능
-- 커서 변수를 만들어서 필요할 때마다 커서 내용을 저장하고 호출해서 그 결과를 사용하려고 변수를 만듭니다.

curtype3 SYS_REFCURSOR;     -- 시스템에서 제공해주는 커서 타입
-- SYS_REFCURSOR 를 사용하면
-- TYPE emp_dep_curtype IS REF CURSOR;  --> 커서타입 생성 생략가능
-- emp_curvar emp_dep_curtype;  --> 변수 선언을 이미 존재하는 커서타입인 SYS_REFCURSOR 형태로 선언

DECLARE
    v_deptno emp.deptno%TYPE;   -- 일반 변수 선언
    v_ename emp.dname%TYPE; -- 일반 변수 선언
    emp_curvar SYS_REFCURSOR;   -- SYS_REFCURSOR 타입의 커서변수 선언(커서 자료형 생성이 필요 없이 사용 가능합니다.)
BEGIN
    OPEN emp_curvar FOR SELECT ename, deptno FROM emp WHERE deptno = 20;    -- 커서변수에 select 문 설정
    LOOP
        FETCH emp_curvar INTO v_ename, v_deptno;        -- 쵯초 사용형태처럼 각 자료를 저장할 변수가 필요합니다.
        EXIT WHEN emp_curvar%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE( v_ename || ' - ' || v_deptno );
    END LOOP;
END;
-- 1. SYS_REFCURSOR 변수 생성
-- 2. 변수에 select 연결
-- 3. FETCH로 꺼내서 처리(반복실행)





-- 프로시져에서의 커서 사용 예
-- SELECT 의 결과를 커서변수에 담아서 프로시져를 호출한 OUT 변수에 리턴합니다.
-- 프로시져 내용 : 부서번호가 10번인 사원의 이름과 급여 리턴
CREATE OR REPLACE PROCEDURE testCursorArg(
    p_curvar OUT SYS_REFCURSOR
    -- 매개변수로 SELECT 명령의 결과를 담아서 다시 리턴해줄 OUT 변수(자료형 SYS_REFCURSOR)를 생성합니다.
)
IS
    temp_curvar SYS_REFCURSOR;  -- 프로시져 안에서 사용할 커서 변수
BEGIN
    -- 문제에서 요구한 부서번호가 10인 사원의 이름과 급여를 temp_curvar 변수에 저장
    OPEN temp_curvar FOR SELECT ename, sal FROM emp WHERE deptno = 10;
    -- 현재 위치에서 커서의 내용을 fetch 하지 않습니다. 반복실행도 fetch도 쓰지 않습니다.
    -- OUT 변수에 실행된 커서 변수의 내용을 담습니다.
    p_curvar := temp_curvar;
END;

DECLARE
    curvar SYS_REFCURSOR;
    v_ename emp.ename%TYPE;
    v_sal emp.sal%TYPE;
BEGIN
    testCursorArg( curvar );
    LOOP
        FETCH curvar INTO v_ename, v_sal;
        EXIT WHEN curvar%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE( v_ename || ' - ' || v_sal );
    END LOOP;
END;
-- select 내용은 temp_curvar에 temp_curvar의 내용은 p_curvar에 p_curvar의 내용은 curvar에 저장됩니다.

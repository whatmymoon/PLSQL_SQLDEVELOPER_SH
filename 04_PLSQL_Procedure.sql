-- 04_PLSQL_Procedure.sql

-- 프로시져
-- 함수와 비슷한 구조입니다.
-- 함수는 결과 리턴이 있지만 프로시져는 결과리턴이 없는 것이 특징입니다. (리턴을 위한 별도의 코드(변수)가 있습니다)
-- return 키워드 대신, 리턴역할을 하는 변수를 필요 갯수만큼 만들어서 사용합니다.



-- 프로시져의 생성

-- create or replace procedure 프로시져이름(
--      매개변수명1 [ IN | OUT | IN OUT ] 데이터타입[:=디폴트 값],
--      매개변수명2 [ IN | OUT | IN OUT ] 데이터타입[:=디폴트 값],
--      ....
-- )
-- IS[AS]
--      변수, 상수 선언
-- BEGIN
--      실행부
-- [ EXCEPTION
--      예외처리부 ]
-- END [프로시져이름];

-- create or replace procedure : 프로시져를 생성하는 구문입니다.
-- 매개변수명1 [IN | OUT | IN OUT ] : 매개변수를 만들되 전달되는 전달인수를 받는 IN 변수와
--      리턴역할을 할 수 있는 OUT 변수를 만들 때 사용합니다. 입력변수와 출력변수의 역할이
--      동시에 부여되려면 IN OUT 을 같이 기술합니다.
--      프로시져는 기본적으로 리턴값이 없지만(실제 RETURN명령을 사용하지 않음) 변수의 속성에 OUT 속성하나를
--      부여함으로써 리턴의 역할을 흉내낼 수 있게는 사용이 가능합니다.
--      변수 속성이 IN 인 경우 생략이 가능합니다.




-- RentList 테이블에 레코드를 추가하는 프로시져
create or replace procedure newRendList(
    p_bnum in rentlist.bnum%type,
    p_mnum in rentlist.mnum%type,
    p_discount in rentlist.discount%type)
is
begin
    insert into rentlist( rentdate, numseq, bnum, mnum, discount)
    values(sysdate, rent_seq.nextVal, p_bnum, P_mnum, p_discount);
    commit;
end;

exec newRendList( 6, 3, 300 );

select * from rentlist order by numseq desc;




-- IN, OUT, IN OUT 매개변수 사용 #1
-- newRentList 프로시져에서 입력된 오늘 날짜를 호출한 곳에서 되돌려 받아서 출력합니다.
create or replace procedure newRentList2(
    p_bnum in rentlist.bnum%type,
    p_mnum in rentlist.mnum%type,
    p_discount in rentlist.discount%type,
    p_outdate out rentlist.rentdate%type )
is
    v_sysdate rentlist.rentdate%type := sysdate;    -- 변수 선언과 동시에 오늘 날짜를 저장
begin
    insert into rentlist( rentdate, numseq, bnum, mnum, discount)
    values( v_sysdate, rent_seq.nextVal, p_bnum, p_mnum, p_discount );
    commit;
    p_outdate := v_sysdate;     -- out 변수에 오늘 날짜를 담고 있는 변수 값을 대입합니다.
    -- OUT변수에 값을 넣는 것은 호출할 때 OUT변수에 전달해준 변수로 그 값을 전달하는 것과 같습니다.
end;
declare
    v_date rentlist.rentdate%type;
begin
    newRentList2(4, 2, 200, v_date);
    -- 익명블록에서 프로시져를 호출할때는 exec 를 사용하지 않습니다
    -- 프로시져가 아니고 함수였다면 v_curdate = newRentList2(7, 2, 200); 와 같이 사용할 테지만,
    -- 프로시져이기 때문에 매개변수 중에도 OUT 변수에, 값 대신 변수를 전달해줍니다. (자바의 CALL BY REFERENCE와 같은 의미)
    -- 프로시져 내부에서 OUT 변수에 뭔가 값을 넣는 동작이 있으면, 호출한 곳에서 넣어준 변수에 그 값을 공유받아서
    -- 사용한 것과 같습니다.
    
    -- 프로시져에서 넣어준 값이 현재 변수를 통해 출력됩니다.
    DBMS_OUTPUT.PUT_LINE(v_date);
end;

set serverout on;

-- IN, OUT, IN OUT 의 사용 예 #2
-- IN 변수와 OUT 변수와 IN OUT 변수
create or replace procedure parameter_test(
    p_var1 in varchar2,
    p_var2 out varchar2,
    p_var3 in out varchar2)
is
begin
    -- IN 변수와 OUT 변수에 전달된 내용을 모두 출력해 봅니다.
    dbms_output.put_line('p_var1 value = ' || p_var1);
    -- OUT 변수는 전달인수를 값으로 전달받지 못하는 변수입니다. 값을 전달해줘도 적용되지 않습니다.
    -- IN 변수로서의 기능을 부여하려면 변수 선언당시 IN 과 OUT 을 같이 사용합니다.
    dbms_output.put_line('p_var2 value = ' || p_var2);
    dbms_output.put_line('p_var3 value = ' || p_var3);
    -- IN 변수와 OUT 변수에 모두 값을 대입해봅니다.
    -- p_var1 := 'A2';  -- IN 변수는 전달인수에 의해 값이 정해질 뿐 임의로 값을 변경하지 못합니다.
    p_var2 := 'B2';
    p_var3 := 'C2';
end;
declare
    v_var1 varchar2(10) := 'A';
    v_var2 varchar2(10) := 'B';
    v_var3 varchar2(10) := 'C';
begin
    parameter_test(v_var1, v_var2, v_var3);
    dbms_output.put_line('v_var1 value = ' || v_var1);
    dbms_output.put_line('v_var2 value = ' || v_var2);
    dbms_output.put_line('v_var3 value = ' || v_var3);
    -- 프로시져에 OUT변수로 전달된 변수는 프로시져 실행 후 프로시져 내에서 넣어준 값이 저장되어 있게 됩니다.
end;

-- IN OUT 변수의 사용규칙
-- 1. IN 변수는 전달인수로 전달되어 저장된 값을 참조만 할 수 있고, 값을 할당할 수 없습니다.
-- 2. OUT 변수에는 전달인수로 값을 전달할 수는 있지만, 참조할 수 없으므로 의미가 없는 전달입니다.
-- 3. OUT 변수와 IN OUT 변수는 디폴트값을 지정할 수 없습니다.
-- 4. IN 변수에는 변수, 상수, 각 데이터형에 따른 값을 전달인수로 전달할 수 있지만,
--      OUT 변수와 IN OUT 변수는 반드시 변수형태로 전달인수를 넣어줘야합니다.



-- 디폴트 밸류
create or replace procedure newRentList(
    p_bnum in rentlist.bnum%type,
    p_mnum in rentlist.mnum%type,
    p_discount in rentlist.discount%type := 100     -- 디폴트 밸류 : 매개변수에 값을 미리 저장합니다.
)
is
begin
    insert into rentlist( rentdate, numseq, bnum, mnum, discount)
    values( sysdate, rent_seq.nextVal, p_bnum, p_mnum, p_discount);
    commit;
end;
exec newRentList(5, 5);

-- 매개변수 인수 전달 시, 순서 변경
exec newRentList( p_mnum => 5, p_bnum => 6);

select * from rentlist order by numseq desc;



-- RETURN 문 : 프로시져에서 RETURN 은 값을 리턴하겠다는 명령이 아니고, 현 시점에서 프로시져를 끝내겠다는 뜻입니다.
-- rentlist 에 레코드를 추가하기 전에 전달된 도서번호와 회원번호가 없다면 해당 도서번호가 없습니다.
-- 또는 해당 회원번호가 없습니다 라고 출력하고 중간에 프로시져가 끝나도록 아래 프로시져를 수정하세요
create or replace procedure newRentList(
    p_bnum in rentlist.bnum%type, p_mnum in rentlist.mnum%type, p_discount in rentlist.discount%type :=  100)
is
    bcnt Number;    mcnt Number;
begin
    select count(*) into bcnt from booklist where booknum = p_bnum;
    if bcnt = 0 then
        dbms_output.put_line('해당 도서번호가 없습니다');
        return;     -- 프로시져를 종료합니다.
    end if;
    select count(*) into mcnt from memberlist where membernum = p_mnum;
    
    if mcnt = 0 then
        dbms_output.put_line('해당  회원번호가 없습니다');
        return;     -- 프로시져를 종료합니다.
    end if;
    insert into rentlist( rentdate, numseq, bnum, mnum, discount)
    values( sysdate, rent_seq.nextVal, p_bnum , p_mnum, p_discount);
    commit;
end;
exec newrentlist(20, 60, 100);











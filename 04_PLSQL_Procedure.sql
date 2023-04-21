-- 04_PLSQL_Procedure.sql

-- ���ν���
-- �Լ��� ����� �����Դϴ�.
-- �Լ��� ��� ������ ������ ���ν����� ��������� ���� ���� Ư¡�Դϴ�. (������ ���� ������ �ڵ�(����)�� �ֽ��ϴ�)
-- return Ű���� ���, ���Ͽ����� �ϴ� ������ �ʿ� ������ŭ ���� ����մϴ�.



-- ���ν����� ����

-- create or replace procedure ���ν����̸�(
--      �Ű�������1 [ IN | OUT | IN OUT ] ������Ÿ��[:=����Ʈ ��],
--      �Ű�������2 [ IN | OUT | IN OUT ] ������Ÿ��[:=����Ʈ ��],
--      ....
-- )
-- IS[AS]
--      ����, ��� ����
-- BEGIN
--      �����
-- [ EXCEPTION
--      ����ó���� ]
-- END [���ν����̸�];

-- create or replace procedure : ���ν����� �����ϴ� �����Դϴ�.
-- �Ű�������1 [IN | OUT | IN OUT ] : �Ű������� ����� ���޵Ǵ� �����μ��� �޴� IN ������
--      ���Ͽ����� �� �� �ִ� OUT ������ ���� �� ����մϴ�. �Էº����� ��º����� ������
--      ���ÿ� �ο��Ƿ��� IN OUT �� ���� ����մϴ�.
--      ���ν����� �⺻������ ���ϰ��� ������(���� RETURN����� ������� ����) ������ �Ӽ��� OUT �Ӽ��ϳ���
--      �ο������ν� ������ ������ �䳻�� �� �ְԴ� ����� �����մϴ�.
--      ���� �Ӽ��� IN �� ��� ������ �����մϴ�.




-- RentList ���̺� ���ڵ带 �߰��ϴ� ���ν���
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




-- IN, OUT, IN OUT �Ű����� ��� #1
-- newRentList ���ν������� �Էµ� ���� ��¥�� ȣ���� ������ �ǵ��� �޾Ƽ� ����մϴ�.
create or replace procedure newRentList2(
    p_bnum in rentlist.bnum%type,
    p_mnum in rentlist.mnum%type,
    p_discount in rentlist.discount%type,
    p_outdate out rentlist.rentdate%type )
is
    v_sysdate rentlist.rentdate%type := sysdate;    -- ���� ����� ���ÿ� ���� ��¥�� ����
begin
    insert into rentlist( rentdate, numseq, bnum, mnum, discount)
    values( v_sysdate, rent_seq.nextVal, p_bnum, p_mnum, p_discount );
    commit;
    p_outdate := v_sysdate;     -- out ������ ���� ��¥�� ��� �ִ� ���� ���� �����մϴ�.
    -- OUT������ ���� �ִ� ���� ȣ���� �� OUT������ �������� ������ �� ���� �����ϴ� �Ͱ� �����ϴ�.
end;
declare
    v_date rentlist.rentdate%type;
begin
    newRentList2(4, 2, 200, v_date);
    -- �͸��Ͽ��� ���ν����� ȣ���Ҷ��� exec �� ������� �ʽ��ϴ�
    -- ���ν����� �ƴϰ� �Լ����ٸ� v_curdate = newRentList2(7, 2, 200); �� ���� ����� ������,
    -- ���ν����̱� ������ �Ű����� �߿��� OUT ������, �� ��� ������ �������ݴϴ�. (�ڹ��� CALL BY REFERENCE�� ���� �ǹ�)
    -- ���ν��� ���ο��� OUT ������ ���� ���� �ִ� ������ ������, ȣ���� ������ �־��� ������ �� ���� �����޾Ƽ�
    -- ����� �Ͱ� �����ϴ�.
    
    -- ���ν������� �־��� ���� ���� ������ ���� ��µ˴ϴ�.
    DBMS_OUTPUT.PUT_LINE(v_date);
end;

set serverout on;

-- IN, OUT, IN OUT �� ��� �� #2
-- IN ������ OUT ������ IN OUT ����
create or replace procedure parameter_test(
    p_var1 in varchar2,
    p_var2 out varchar2,
    p_var3 in out varchar2)
is
begin
    -- IN ������ OUT ������ ���޵� ������ ��� ����� ���ϴ�.
    dbms_output.put_line('p_var1 value = ' || p_var1);
    -- OUT ������ �����μ��� ������ ���޹��� ���ϴ� �����Դϴ�. ���� �������൵ ������� �ʽ��ϴ�.
    -- IN �����μ��� ����� �ο��Ϸ��� ���� ������ IN �� OUT �� ���� ����մϴ�.
    dbms_output.put_line('p_var2 value = ' || p_var2);
    dbms_output.put_line('p_var3 value = ' || p_var3);
    -- IN ������ OUT ������ ��� ���� �����غ��ϴ�.
    -- p_var1 := 'A2';  -- IN ������ �����μ��� ���� ���� ������ �� ���Ƿ� ���� �������� ���մϴ�.
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
    -- ���ν����� OUT������ ���޵� ������ ���ν��� ���� �� ���ν��� ������ �־��� ���� ����Ǿ� �ְ� �˴ϴ�.
end;

-- IN OUT ������ ����Ģ
-- 1. IN ������ �����μ��� ���޵Ǿ� ����� ���� ������ �� �� �ְ�, ���� �Ҵ��� �� �����ϴ�.
-- 2. OUT �������� �����μ��� ���� ������ ���� ������, ������ �� �����Ƿ� �ǹ̰� ���� �����Դϴ�.
-- 3. OUT ������ IN OUT ������ ����Ʈ���� ������ �� �����ϴ�.
-- 4. IN �������� ����, ���, �� ���������� ���� ���� �����μ��� ������ �� ������,
--      OUT ������ IN OUT ������ �ݵ�� �������·� �����μ��� �־�����մϴ�.



-- ����Ʈ ���
create or replace procedure newRentList(
    p_bnum in rentlist.bnum%type,
    p_mnum in rentlist.mnum%type,
    p_discount in rentlist.discount%type := 100     -- ����Ʈ ��� : �Ű������� ���� �̸� �����մϴ�.
)
is
begin
    insert into rentlist( rentdate, numseq, bnum, mnum, discount)
    values( sysdate, rent_seq.nextVal, p_bnum, p_mnum, p_discount);
    commit;
end;
exec newRentList(5, 5);

-- �Ű����� �μ� ���� ��, ���� ����
exec newRentList( p_mnum => 5, p_bnum => 6);

select * from rentlist order by numseq desc;



-- RETURN �� : ���ν������� RETURN �� ���� �����ϰڴٴ� ����� �ƴϰ�, �� �������� ���ν����� �����ڴٴ� ���Դϴ�.
-- rentlist �� ���ڵ带 �߰��ϱ� ���� ���޵� ������ȣ�� ȸ����ȣ�� ���ٸ� �ش� ������ȣ�� �����ϴ�.
-- �Ǵ� �ش� ȸ����ȣ�� �����ϴ� ��� ����ϰ� �߰��� ���ν����� �������� �Ʒ� ���ν����� �����ϼ���
create or replace procedure newRentList(
    p_bnum in rentlist.bnum%type, p_mnum in rentlist.mnum%type, p_discount in rentlist.discount%type :=  100)
is
    bcnt Number;    mcnt Number;
begin
    select count(*) into bcnt from booklist where booknum = p_bnum;
    if bcnt = 0 then
        dbms_output.put_line('�ش� ������ȣ�� �����ϴ�');
        return;     -- ���ν����� �����մϴ�.
    end if;
    select count(*) into mcnt from memberlist where membernum = p_mnum;
    
    if mcnt = 0 then
        dbms_output.put_line('�ش�  ȸ����ȣ�� �����ϴ�');
        return;     -- ���ν����� �����մϴ�.
    end if;
    insert into rentlist( rentdate, numseq, bnum, mnum, discount)
    values( sysdate, rent_seq.nextVal, p_bnum , p_mnum, p_discount);
    commit;
end;
exec newrentlist(20, 60, 100);











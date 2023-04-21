-- 02_PLSQL_ControllOp.sql

-- IF ��
-- ����� ���� �� �� �ϳ��̰�, �ܵ� if�� ����� ��
-- if ���� then
--      ���๮1
-- end if



-- ����� ���� �� �� �ϳ��̰�, else �� �Բ� ����� ��
-- if ���� then
--      ���๮1
-- else
--      ���๮2
-- end if



-- ����� ���� �� �̻��� ��
-- if ����1 then
--      ���๮1
-- elsif ����2 then       -- ��Ÿ �ƴ� ���� elsif
--      ���๮2
-- else
--      ���๮3
-- ...
-- end if

declare
    vn_num1 number := 35;
    vn_num2 number := 16;
begin
    if vn_num1 >= vn_num2 then
        dbms_output.put_line(vn_num1 || '��(��) ū ��');
    else
        dbms_output.put_line(vn_num2 || '��(��) ū ��');
    end if;
end;



-- emp ���̺��� ��� �Ѹ��� �����Ͽ�, �� ����(salary)�� �ݾ׿� ���� ����, �߰�, ���� �̶�� �ܾ ����ϴ�
-- �͸� ���� �����մϴ�. (1~1000 ���� 1001~2500 ���� 2501 ~ ����)
-- ����� �����ϴ� ����� dbms_random.value �Լ��� �̿��մϴ�.
-- ������ �μ���ȣ�� ��ȸ�ϵ� �� �μ��� ����� �����̸� ù��°������� ����
set serverout on;
declare
    v_sal number := 0;
    v_deptno number := 0;
begin
    -- ��� �Ѹ� ���� : �����ϰ� �μ���ȣ�� �����ؼ� �� �μ��� ù��° ���
    
    -- �����ϰ� �μ���ȣ�� �߻�
    -- dbms_random.value(���ۼ���, ������) : ���� ���ں��� ������ ������ ���� ���ڸ� �߻��մϴ�.
    -- round(����, �ݿø��ڸ���) : ���ڸ� ������ �ݿø��ڸ����� �ݿø��մϴ�.
    -- �ݿø��ڸ��� 1 �̸� �Ҽ�����°�ڸ����� �ݿø��ؼ� ù°�ڸ����� ����
    -- �ݿø��ڸ��� -1 �̸� 1�� �ڸ����� �ݿø�.
    v_deptno := round (dbms_random.value(15, 44), -1);
    -- dbms_output.put_line(v_deptno);
    select sal into v_sal from emp where deptno = v_deptno and rownum=1;
    
    dbms_output.put_line(v_deptno);
    dbms_output.put_line(v_sal);
    
    if v_sal between 1 and 1000 then
        dbms_output.put_line('����');
    elsif v_sal >= 1001 and v_sal <= 2500 then
        dbms_output.put_line('����');
    elsif v_sal > 2500 then
        dbms_output.put_line('����');
    end if;
end;




-- case �� : ������ �� �� when �� ���� ���� ���� end case�� �� �ݴϴ�.
declare
    v_sal number := 0;
    v_deptno number := 0;
begin
    v_deptno := round( dbms_random.value(15, 44), -1 );
    select sal into v_sal from emp where deptno = v_deptno and rownum = 1;
    dbms_output.put_line(v_deptno);
    dbms_output.put_line(v_sal);
    
    case when v_sal between 1 and 1000 then
        dbms_output.put_line('����');
    when v_sal >= 1001 and v_sal <= 2500 then
        dbms_output.put_line('����');
    else  -- when v_sal > 2500 then
        dbms_output.put_line('����');
    end case;
end;

-- case ���� 1
-- case when ���ǽ�1 then
--          ���๮1
--      when ���ǽ�2 then
--          ���๮2
--      else  -- when ���ǽ�3 then     �������̾ ���ǽ��� �ᵵ �˴ϴ�.
--          ���๮3
-- end case;
---------------------------------------------------------------------
-- case ���� 2 - ǥ������ ����� �Ǵ� ������ ������ ����� ���� �а��մϴ�.
-- case ǥ���� �Ǵ� ����
--      when ��1 then
--          ���๮1
--      when ��2 then
--          ���๮2
--      else
--          ���๮3
-- end case;





-- loop ��

-- �ݺ����� ���� 1----------------------------------------------------
-- loop
--      ���๮;
--      exit(when ����);
-- end loop;

declare
    vn_base_num number := 7;    -- ��
    vn_cnt number := 1;         -- �ݺ� ���� ���� �� �¼�
begin
    loop
        dbms_output.put_line( vn_base_num || 'x' || vn_cnt || '=' || vn_base_num * vn_cnt );    -- ������ ���
        vn_cnt := vn_cnt + 1;       -- �ݺ����� ���� 1����
        exit when vn_cnt > 9;       -- �ݺ����� ������ 9�� �ʰ��ϸ� �ݺ����� ����
    end loop;
end;



-- �ݺ����� ���� 2------------------------------------------------------------------
-- while ����
-- loop
--      ���๮
-- end loop
declare
    vn_base_num number := 6;
    vn_cnt number := 1;
begin
    while vn_cnt <= 9       -- vn_cnt�� 9���� �۰ų� ���� ��쿡�� �ݺ� ����
    loop
        dbms_output.put_line( vn_base_num || 'x' || vn_cnt || '=' || vn_base_num * vn_cnt );
        vn_cnt := vn_cnt + 1;   -- vn_cnt ���� 1�� ����
    end loop;
end;




-- while �� exit when �� ȥ�ջ�� ---------------------------------------------------------------
declare
    vn_base_num number := 9;
    vn_cnt number := 1;
begin
    while vn_cnt <= 9   -- vn_cnt�� 9���� �۰ų� ���� ��쿡�� �ݺ�ó��
    loop
        dbms_output.put_line( vn_base_num || 'x' || vn_cnt || '=' || vn_base_num * vn_cnt );
        exit when vn_cnt = 5;
        vn_cnt := vn_cnt + 1;   -- vn_cnt ���� 1�� ����
    end loop;
end;




-- for ��
-- for ������ in (reverse)���۰�..����
-- loop
--      ���๮
-- end loop;
-- ���۰����� �������� �ݺ������մϴ�. reverse ������ ���, �ݴ������ ������������ �ݺ�����

declare
    vn_base_num number := 8;
begin
    for i in 1..9
    loop
        dbms_output.put_line( vn_base_num || 'x' || i || '=' || vn_base_num * i );
    end loop;
end;

-- reverse �� ����� ���--------------------------------------------------------------
declare
    vn_base_num number := 8;
begin
    for i in reverse 1..9
    loop
        dbms_output.put_line( vn_base_num || 'x' || i || '=' || vn_base_num * i);
    end loop;
end;













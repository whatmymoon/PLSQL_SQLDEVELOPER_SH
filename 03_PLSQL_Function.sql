-- 03_PLSQL-Function.sql

-- �Լ�
-- PL/SQL �ڵ� �ۼ��ÿ��� ���ݱ��� ����ϴ� �͸� ���� �� ������� ����
-- �Ϲ������� �̸��� �ִ� ���� ���α׷�(�Լ�) �Ǵ� ���ν����� ����ϴ� ���� ��κ���.
-- �͸� ���� �� �� ����ϰ� ���� ������ ������ �ֹ߼� ��������
-- �Լ� �Ǵ� ���ν��� �������� ���� �����Ӻ��̽��� ����Ǿ� ������ ������ ������.

-- �Լ��� ���� ����

-- CREATE OR REPLCE FUNCTION �Լ��̸� ( �Ű�����1, �Ű�����2..)
-- RETURN ������ ������Ÿ��;
-- IS(AS)
--     ���� , ��� ����
-- BEGIN
--     �����
--     RETURN ���ϰ�;
-- [ EXCEPTION
--     ����ó���� ]
--  END [�Լ��̸�];

-- �� Ű���庰 �󼼳���
-- CREATE OR REPLACE FUNCTION : CREATE OR REPLACE FUCTION ��� ������ �̿��Ͽ� �Լ��� ������.
--      �Լ��� ����� �����ϴ��� �� ������ ��� ������ �� �� �ְ�, ���������� ������ �� ������
--      �Լ��� ����� �̸����� ���˴ϴ�
-- �Ű����� : �����μ��� �����ϴ� ������ " �����̸� ������ �ڷ��� " ���·� �ۼ��մϴ�
-- ù ��° RETURN ���� �������� ���ϵ� �ڷ��� �ڷ����� ����, �Ʒ� �� �� ��° RETURN ���� ������
--     �� �ڷ������� ���� ���ϵ� �� �Ǵ� �����̸��� ����.
-- [] �ȿ� �ִ� EXCEPTION ������ �ʿ�ġ ���� �� ������ ������.


-- �� ���� ������ �����ؼ� ù ��° ���� �� ��° ������ ���� �������� ���ؼ� �������ִ� �Լ�

CREATE OR REPLACE FUNCTION myMod( num1 NUMBER, num2 NUMBER )
     RETURN NUMBER
IS
      v_remainder NUMBER := 0;   -- ���� �������� ���� �� ����
      v_mok      NUMBER := 0;    -- ���� ���� ���� �� ����
BEGIN
      v_mok := FLOOR (num1 / num2);  -- ���� ���� ���� �κи� ����.(�Ҽ��� ����)
      v_remainder := num1 - (num2 * v_mok);   -- �� * ����(������ ��)�� ������(���������� ��)���� ���� �������� ����
      RETURN v_remainder;
END;

SELECT myMod(14, 4) FROM DUAL;



-- ��������1----
-- ������ȣ�� �����μ��� �����Ͽ�, booklist���� �ش� ���� ������ ���Ϲ޴� �Լ��� �����Ͻÿ�

-- �Լ� ȣ�� ���
SELECT subjectbynum(5)  ,subjectbynum(8) FROM dual;

-- �Լ� ����
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


-- ��������2
-- ���� �Լ��� ��� �� ���޵� ������ȣ�� �˻��� ������ ���ٸ�, '�ش� ���� ����' �̶�� ������ ���ϵǵ��� �������ּ���
-- FUNCTION ���ο��� COUNT(*) �Լ� Ȱ��. ��ȸ�� ������ȣ�� ���ڵ尹���� 0���̸� "�ش� ���� ����" ����
-- ������ ������ ���������� �����մϴ�.
select subjectbynum2(8), subjectbynum2(20) from dual;

create or replace function subjectbynum2( num Number )
    return varchar2
is
    v_cnt number;
    v_subject booklist.subject%type;
begin
    -- ���޹��� ������ȣ�� �ش��ϴ� ������ �� ������ ��ȸ
    select count(*) into v_cnt from booklist where booknum = num;
    if v_cnt = 0 then
       v_subject := '�ش� ���� ����';
    else
        select subject into v_subject from booklist where booknum = num;
    end if;
    return v_subject;
    
end;

-- �Ű������� ���� �Լ�
create or replace function fn_get_user  -- �Ű������� ���� �Լ��� ��ȣ ���� �����ϱ⵵ �մϴ�.
    return varchar2
is
    vs_user_name varchar2(80);
begin
    select user into vs_user_name from dual;    -- ���� ����Ŭ �α��� ���� ��ȸ > vs_user_name ������ ����
    return vs_user_name;    -- ������̸� ����
end;
select fn_get_user(), fn_get_user from dual;    -- �Ű������� ���� �Լ��� ��ȣ ���� ȣ���ϱ⵵ �մϴ�.





-- �������� 3
-- emp ���̺��� �� �μ���ȣ�� ���޹޾Ƽ� �޿��� ��հ��� ����Ͽ� �����ϴ� �Լ��� �����ϼ���
-- ���޵� �μ���ȣ�� ����� ������ �޿� ����� 0���� �����ϼ���.
-- �Լ� ȣ���� �Ʒ��� �����ϴ�.
select salAvgDept(10), salAvgDept(20), salAvgDept(30), salAvgDept(40) from dual;

create or replace function salAvgDept( p_deptNo Number )
    return number
is
    v_cnt number;
    v_avg number;
begin
    select count(*) into v_cnt from emp where deptno = p_deptNo;    -- ���޵� �μ���ȣ�� �����ϴ��� ���� �˻�
    if v_cnt = 0 then
       v_avg := 0;
    else
        select avg(sal) into v_avg from emp where deptno = p_deptNo;
    end if;
    return v_avg;
end;
















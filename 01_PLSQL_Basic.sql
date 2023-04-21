-- PL/SQL

-- �ټ��� SQL ����� �𿩼� �ϳ��� �۾���� �Ǵ� Ʈ������� �̷� �� �̸� �ϳ��� ������ ��� �ѹ��� �����ϰ� �ϴ� �����������Դϴ�.

-- ���� ��� �Ϲ����� ���θ� �����ͺ��̽�����
-- ��ٱ��Ͽ� �ִ� ����� ������ �ֹ� ���̺� �־�� �� ��
-- 1. ��ٱ��� ���̺��� ���� �����ڰ� �־�� ��� ��ȸ(select)
-- 2. ����� �ֺ����̺� �߰�(insert)


-- ���� ���� �� �� �̻��� sql�� �ѹ��� ����ǰ��� �Ѵٸ� select �� ����� ������ �ְ�
-- ������ ����� ���� �ٽ� insert �� �� �ֽ��ϴ�.
-- ����Ŭ�� �����ϴ� ���α׷��� ��ҿ� �Բ� SQL ��� �׷�(��)�� ����� �� ���� ���� �� �� �ְ� �մϴ�.
-- �׷��� ������� PL/SQL ���� ���Ŀ� �츮�� �н��� MyBatis ������ Ȱ��˴ϴ�.


-- ��
-- PL/SQL �� ���� ������ �����Ǿ� �ִµ�, ���� ������ �� �ִ� ������ SQL ����� ���ִ� �� ���� ������, �̴� ����� ��������� �˴ϴ�.
-- �̿� �͸� ��, �̸��� �ִ� �� � �ְ�,
-- ���δ� ��ɺ��� �̸���, �����, �����, ����ó���ηε� �����⵵ �մϴ�.

-- PL/SQL ��(��)�� ������
-- PL/SQL �� �ϳ��� ��������� ������ �� �Ʒ��� ���� �� ��ġ, ��ɺ� ������ �̷�����ϴ�.
IS(AS)
-- �̸���
DECLARE
-- �����(���� ���� ���)
BEGIN
-- �����(SQL ���)
EXCEPTION
-- ����ó����
END;
-- BEGIN, END �� ������ �������� �ʿ信 ���� ������ �����մϴ�.





-- �͸� �� (������� �ʴ� ���� Ű����� �����ص� �����մϴ�.)
DECLARE
    num NUMBER; -- ��������
BEGIN
    num := 100; -- num ������ 100�� ���� -> ������ 1
    DBMS_OUTPUT.PUT_Line(num); -- ���ȭ�鿡 num �������� ����ϼ��� -> ������ 2
END;



-- ȭ�� ����� �ϱ����� ����� ON �մϴ�
SET SERVEROUTPUT ON

-- ����ð��� ����ϱ� ���� ����� ON �մϴ�
SET TIMING ON
SET TIMING OFF



-- �츮�� ���� ��ǥ�� ������Ʈ���� ���޹��� �����μ��� ����(SQL)�ϰ�, ����� ������Ʈ�� �ٽ� �������ִ� ��������
-- ����� �� ��Ȳ���� �������� �������Ƿ� ���� ���� �־��ְ�(num := 100;), ����� ȭ������ ����մϴ�.
-- (DBMS_OUTPUT.PUT_LINE(num);)

-- ���� : ù��° SQL ���� Orders ���̺� ���ڵ带 �����ϰ�, ���� ū �⺻Ű���� ��ȸ�� ���� �� ����
--      order_detail �� �Է°����� ����Ϸ��� ������ �����ϰ� ���� �����ؼ� Ȱ���մϴ�.
-- ���� ������
-- ������ �����ڷ�Ÿ��
-- := �ʱⰪ; SQL ��ɳ��� = �� �����ϱ����� :=���� ����մϴ�.

-- PL/SQL �� �ڷ���
-- ������ Oracle �ڷ����� ��� �����ϸ�, �����Ӱ� ����� �� �ֽ��ϴ�.
-- BOOLEAN : TRUE, FALSE, NULL �� ���� �� �ִ� �ڷ���
-- PLS_INTEGER : -2147483648 ~ 2147483647 ���� ���� ���� NUMBER ���� ���� ��������� �� ���� �մϴ�.
-- BINARY_INTEGER : PLS_INTEGER �� ���� �뷮 ���� �뵵�� ����մϴ�.
-- NATRAL : PLS_INTEGER �� ���(0 ����)
-- NATRALN : NATRAL �� ������, NULL ����� ���� ����� ���ÿ� �ʱ�ȭ�� �ʿ��մϴ�.
-- POSITIVE : PLS_INTEGER �� ����(0 ������)
-- POSITIVEN : POSITIVE �� ������, NULL ����� ���� ����� ���ÿ� �ʱ�ȭ�� �ʿ��մϴ�.
-- SIGNTYPE : -1, 0, 1
-- SIMPLE_INTEGER : PLS_INTEGER �� NULL �� �ƴ� ��� ��, ����� ���ÿ� �ʱ�ȭ�� �ʿ��մϴ�.




-- ������
-- ** : ���� (�ڽ�) ���� -> 3**4 3�� 4��
-- +,- : ��� ���� ���� ����
-- ��Ģ���� +, -, *, /, ||(���ڿ�����)
-- �񱳿��� =, >, <, >=, <=, <>, !=, IS NULL, LIKE, BETWEEN, IN
-- ������ NOT AND OR




-- PL/SQL ���� �����ڸ� ����� ��
DECLARE
    a INTEGER;
BEGIN
    a := 2**2*3**2;
    DBMS_OUTPUT.PUT_LINE('a = ' || TO_CHAR(a));
END;
-- BEGIN ���� �� ���� ���ο����� �� ������ SQL ���� �ϳ��� ��ɾ�� �ν��ϰ�,
-- �����ڸ� ������ �Ϲ� ��ɾ �ϳ��� ��ɾ�� �ν��ؼ�
-- ����� �� �ڿ� ';' �� �ִ� ������ �����մϴ�.



-- SQL Developer ����â���� �ݵ�� ���� ����� �� �ִ� �� �ƴմϴ�. �Ʒ��� ���� �Ϲ����� SQL ���� ��밡���մϴ�.
select * from emp;








-- �ڡڡ� SQL ���� ���� ���Ǵ� PL/SQL ��

-- �ڡ� emp ���̺��� �����ȣ�� 7900 �� ����� �̸��� ����ϼ���.
select ename from emp where empno = 7900; -- ->���� ��� â�� table �������� ���.

-- �ڡ� �� ������ PL/SQL�� ���� �ְ� ����� ������ �����ؼ� DBMS_OUTPUT.PUT_LINE ���� ����մϴ�.
DECLARE
    v_ename VARCHAR2(30);
BEGIN
    SELECT ename 
    INTO v_ename 
    from emp 
    WHERE empno = 7900;
    -- ���ȿ��� SQL ��ɵ� ���� �����մϴ�.
    -- ���ȿ� SQL���� ���� ���� �������� �׳� �ٸ� ��ɰ� ���� ����ϸ� �˴ϴ�.
    -- SQL ���� ����� ������ ��Ƴ��� ��� -> select �� from ���̿� into Ű���带 �ְ� ����� ������ �����մϴ�.
    -- SELECT ���� FROM ���̿� ������ ���尡 ��������, �� ���� ��ŭ INTO �� ������ �����Ͽ� ��� ����� �� �ְ� �մϴ�.
    DBMS_OUTPUT.PUT_LINE(v_ename);
END;





-- �����ȣ�� 7900�� ����� �̸��� �޿��� ����ϼ���
DECLARE
    empname varchar2(30);
    empsal number;
BEGIN
    select ename, sal
    into empname, empsal
    from emp
    where empno=7900;
    DBMS_OUTPUT.PUT_LINE( '���� : ' || empname || ', �޿� : ' || to_char(empsal) );
END;




-- ������ ������ ���� ��� �ڷ����� ������ ���缭 �����ϱⰡ ���ŷο�Ƿ�, ��Ī�� �ʵ��� �̸��� %type �� �̿��Ͽ�
-- �ڵ����� �ڷ����� ���������� �մϴ�
DECLARE
    empname emp.ename%TYPE;     -- emp���̺��� ename �ʵ��� �ڷ����� ������ �ڷ����� �����ּ���.
    empsal emp.sal%TYPE;
BEGIN
    select ename, sal
    into empname, empsal
    from emp
    where empno=7900;
    DBMS_OUTPUT.PUT_LINE( '���� : ' || empname || ', �޿� : ' || to_char(empsal) );
END;




-- ��������1
-- DBMS_OUTPUT.PUT_LINE() �� 9�� ����Ͽ� ������ 7���� ����ϴ� �͸� ���� �����ϼ���.
-- �̾���̱� ���굵 ����մϴ�.
-- ����� ������ �ʿ����� �ʱ� ������ DECLARE �� ���� �ʾƵ� �˴ϴ�.
-- 3x1=3 3x2=6 3x3=9 ... ���� 3 6 9 �� ��꿡 ���� ��µǰ� �մϴ�.
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




-- �������� 2
-- ������̺�(emp) ���� �����ȣ(empno) 7788�� ����� �̸�(ename)�� �μ���(dname)�� ����ϴ� �͸� ����� ���弼��.
-- join ��� ��� '�̸� - �μ���' �� ��ũ��Ʈ ���â�� ����ϼ���.

DECLARE
    empname emp.ename%TYPE;
    deptname dept.dname%TYPE;
BEGIN
    select a.ename, b.dname
    into empname, deptname
    from emp a, dept b
    where a.deptno = b.deptno and empno = 7788;
    
    DBMS_OUTPUT.PUT_LINE( '���� : ' || empname || ' �μ��� : ' || deptname );
END;

select * from dept




-- �������� 3
-- select �� �� ���� insert ��ɿ� ����մϴ�.
-- ������̺�(emp) ���̺��� ���� ū �����ȣ(empno)�� ��ȸ�ϰ�,
-- �� �����ȣ���� 1 ��ŭ ū ���ڸ� ���ο� �Է� ���ڵ��� �����ȣ�� �Ͽ� ���ڵ带 �߰��ϼ���
-- �Ϸù�ȣ �ʵ忡 �������� ���� ��� ����ϴ� ����Դϴ�.

-- ����� : HARRISON
-- JOB : MANAGER
-- MGR : 7566
-- HIREDSTE : 2023/04/20(���ó�¥)
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
    values (max_empno + 1, 'HARRISON', 'MANAGER', 7566, sysdate, 3000, 700, 40); -- sysdate : ���ó�¥
    
    commit;
end;
select * from emp order by empno desc;











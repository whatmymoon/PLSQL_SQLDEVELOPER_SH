-- 05_CURSOR.sql

-- CURSOR : �ַ� ���ν��� ������ SQL ��� �� SELECT ����� ����� �ټ��� ������ ������� ��
-- ����ϴ� ����� �����ϴ� ������ ���մϴ�.
SET SERVEROUTPUT ON;


DECLARE
    v_job varchar2(30);
BEGIN
    select job into v_job from emp where deptno = 30;
    DBMS_OUTPUT.PUT_LINE(v_job);
END;
-- ���� �͸���� SELECT ����� ����� 1��(ROW) �̹Ƿ� ������ ����������,
-- �̴� SELECT ����� ����� 2�� �̻��̶�� ������ �߻��մϴ�.
-- 2�� �̻��� ����� ���� �� �ִ� �޸� ����(�Ǵ� ����)���� ����ϴ� ���� CURSER�̸� �ڹ��� ����Ʈ�� ����� ������ ���� �ֽ��ϴ�.
-- �Ǵ� �ݺ����๮�� �̿��Ͽ� �� ������ �����ϰ� ����ϰ� ������ �� �ֽ��ϴ�.



-- CURSOR �� ����-����ܰ�

-- 1. CURSOR�� ���� (����)
-------------------------------------------------------------------------------
-- CURSOR ����� Ŀ���� �̸�[ (�Ű�����1, �Ű�����2, ....) ]
-- IS
-- SELECT ....SQL ����
-------------------------------------------------------------------------------
-- �Ű������� ���� : SELECT ��ɿ��� ����� ������ ����( �ַ� WHERE ������ ����� ����)
-- SELECT ....SQL ���� : ����Ǿ� CURSOR �� ����� �Ȱ��� SQL ���



-- 2. CURSOR �� OPEN (ȣ��)
-------------------------------------------------------------------------------
-- OPEN Ŀ���̸�[ (�����μ�1, �����μ�2, ....) ]
-------------------------------------------------------------------------------
-- ������ �����μ��� �����Ͽ� Ŀ������ SQL���� �����ϰ� ����� Ŀ���� �����մϴ�.


-- 3. ����� �ݺ����๮�� �Բ� �ʿ信 �°� ó��
-------------------------------------------------------------------------------
-- LOOP
--      FETCH Ŀ���̸� INTO ����(��);
--      EXIT WHEN Ŀ���̸�$NOTFOUND;    -- SELECT �� ���� ����� ���ڵ尡 �� �����Ǿ� ����������....�ݺ����
--      �ʿ信 �´� ó�� ����
-- END LOOP;
-------------------------------------------------------------------------------
-- FETCH Ŀ���̸� INTO ����;  Ŀ���� ��� �����͵� �� �� �پ� ������ ����(��)�� �ִ� �����Դϴ�.
-- EXIT WHEN Ŀ���̸�%NOTFOUND;     ���´µ� �����Ͱ� ������ �����մϴ�.
-- LOOP �ȿ��� �ʿ信 �´� ó���� �����Ͱ� ���������� �ݺ��մϴ�.


-- 4. CURSOR �ݱ�
-------------------------------------------------------------------------------
-- CLOSE Ŀ����
-------------------------------------------------------------------------------



-- CURSOR �� ���
-- �����μ��� �μ���ȣ�� ������ �� �� �μ��� ����̸��� �������� ������ Ŀ��
DECLARE
    v_ename emp.ename%TYPE;
    v_job emp.job%TYPE;
    
    -- 1. Ŀ���� ����
    CURSOR cur_emp( p_deptno emp.deptno%TYPE )
IS
    SELECT ename, job FROM emp WHERE deptno = p_deptno;
    
BEGIN
    -- 2. Ŀ���� ȣ���ϰ� ����
    OPEN cur_emp(30);
    
    -- 3. �ݺ����๮���� ����� Ŀ������ ������ �ϳ��� ������ ����մϴ�.
    LOOP
        FETCH cur_emp INTO v_ename, v_job;
        EXIT WHEN cur_emp %NOTFOUND;
        DBMS_OUTPUT.PUT_LINE( v_ename || ' - ' || v_job );
    END LOOP;
    CLOSE cur_emp;
END;



-- ������ FOR��-----------------------------------------------------------------
-- FOR �ε������� IN [REVERSE] ó����....����
-- LOOP
--      ���๮
-- END LOOP;
-- ó�������� �������� �ϳ��� �ε��������� �����ϸ� �ݺ�����
------------------------------------------------------------------------------

-- Ŀ���� �Բ� ����ϴ� FOR ��----------------------------------------------------
-- FOR ���ڵ庯�� IN Ŀ���̸�(�����μ�1, �����μ�2....)
-- LOOP
--      ���๮
-- END LOOP
------------------------------------------------------------------------------
-- OPEN �� LOOP �� ������ ���Դϴ�.

DECLARE
    -- emp_rec ��� ���ڵ庯���ȿ� �ʵ���� �� ��� �־, �� ���� �ʵ尪�� ������ ������ ������ �ʿ����� �ʽ��ϴ�.
    CURSOR cur_emp( p_deptno emp.deptno%TYPE )
    IS
    SELECT ename, job FROM emp WHERE detpno = p_deptno;
BEGIN
    FOR emp_rec IN cur_emp(30)
    LOOP
        -- �ʿ��� �ʵ�� emp_rec �ڷ� �ʵ���� �����Ͽ� ����� �����մϴ�.
        DBMS_OUTPUT.PUT_LINE( emp_rec.ename || ' - ' || emp_rec.job );
    END LOOP;
------------------------------------------------------------------------------
--    OPEN cur_emp(30);
--    
--    -- 3. �ݺ����๮���� ����� Ŀ������ ������ �ϳ��� ������ ����մϴ�.
--    LOOP
--        FETCH cur_emp INTO v_ename, v_job;
--        EXIT WHEN cur_emp %NOTFOUND;
--        DBMS_OUTPUT.PUT_LINE( v_ename || ' - ' || v_job );
--    END LOOP;
--    CLOSE cur_emp;
------------------------------------------------------------------------------
END;



-- for���� �̿��Ͽ� Ŀ�������� ����� ���� �� ���������ϴ�.

-- ���� �� ������ FOR ���� Ŀ���� ���
DECLARE
BEGIN
    FOR emp_rec IN ( SELECT * FROM emp WHERE deptno = 30 )
    LOOP
        DBMS_OUTPUT.PUT_LINE( emp_rec.ename || ' - ' || emp_rec.job );
    END LOOP;
END;



-- ��������
-- �μ���ȣ�� 30���� ����� �̸�, �μ���, �޿�, �޿�����(����, ����, ����) �� ����ϼ���.
-- �޿�(sal)�� 1000 �̸� ����, 1000~2500 ���� ������ ���� ���� ����ϼ���
-- �̸� - �μ��� - �޿� - ���� ������ ����ϼ���.
select * from emp;
DECLARE
    level VARCHAR2(10);
BEGIN
    FOR emp_rec IN ( SELECT a.ename, b.dname, a.sal FROM emp a, dept b WHERE a.deptno = b.deptno AND a.deptno = 30 )
    LOOP
        IF emp_rec.sal < 1000 THEN
            level := '����';
            -- DBMS_OUTPUT.PUT_LINE( emp_rec.ename || ' - ' || emp_rec.job || ' - ' || emp_rec.sal || ' - ' || '����' );
        ELSIF emp_rec.sal BETWEEN 1000 AND 2500 THEN
            level := '����';
            -- DBMS_OUTPUT.PUT_LINE( emp_rec.ename || ' - ' || emp_rec.job || ' - ' || emp_rec.sal || ' - ' || '����' );
        ELSE
            level := '����';
            -- DBMS_OUTPUT.PUT_LINE( emp_rec.ename || ' - ' || emp_rec.job || ' - ' || emp_rec.sal || ' - ' || '����' );
        END IF;
            DBMS_OUTPUT.PUT_LINE( emp_rec.ename || ' - ' || emp_rec.dname || ' - ' || emp_rec.sal || ' - ' || level );
    END LOOP;
END;

-- Ŀ�� ����
-- �տ��� ������ Ŀ���� �̸��� �Լ�ó�� ȣ��Ǵ� �̸��̱⵵ �ϰ�, Ŀ���� ��ǥ�ϴ� �̸��̾����ϴ�.
-- �׷��� Ŀ���� �̸����� �ٸ� Ŀ���� �������� ���մϴ�.
-- ������ ġ�� �տ��� ���� Ŀ���� �̸��� ��� ������ ǥ���� �����մϴ�.
-- ������ ���� �̸��� �����μ� ���ǰ�, �ٸ� Ŀ���� ������ �� �ְ� ����ϰ��� �մϴ�.
-- Ŀ�������� ����ؾ� ���ν��������� Ŀ�������� OUT ������ �����ϰ� ���ϵ������� Ȱ���� �� �ֽ��ϴ�.


-- Ŀ�� ������ ����
-- TYPE ����� Ŀ���� Ÿ���̸� IS REF CURSOR [ RETURN ��ȯŸ�� ];
--      -> ������ Ŀ��Ÿ���� �̸����� Ŀ�� ������ ������ �����Դϴ�.
-- Ŀ�������̸� Ŀ��Ÿ���̸�;
-- Ŀ�� Ÿ���� ���鶧 RETURN ���� �����ϸ� ����Ŀ��Ÿ���� �����Ǵ� ���̰�, RETURN �� ������ ���� Ŀ��Ÿ���̶�� ��Ī�մϴ�.
TYPE dep_curtype1 IS REF CURSOR RETURN emp%ROWTYPE;     -- ���� Ŀ�� Ÿ��
TYPE dep_curtype2 IS REF CURSOR;
-- �� �� ���� ����� Ŀ���� �̸��� ������ ���� �ƴ϶�, Ŀ���� ������ �� �ִ� "Ŀ���ڷ��� (TYPE)" �� ������ �̴ϴ�.
-- Ŀ���ڷ��� (TYPE)�� �̿��Ͽ� ���� ���� Ŀ�������� ������ �� �ֽ��ϴ�.
cursor1 dep_curtype1;
cursor2 dep_curtype2;

-- cursor1�� cursor2 �������� select ����� ��Ƽ� Ŀ���� �ϼ��� �� �ֽ��ϴ�.
-- ���� Ŀ������(select ��)�� ���������� �ʰ� �ٲ� �� �ֽ��ϴ�.
-- �ٸ� cursor1 �� ���� Ŀ�� Ÿ���̹Ƿ� ���ǵǾ� �ִ´�� (RETURN departments%ROWTYPE) ���ڵ� ��ü�� ����� ��� select��
-- ������ �� �ֽ��ϴ�.
OPEN cursor1 FOR SELECT empno, ename FROM emp WHERE deptno = 30;    -- x �Ұ���
OPEN cursor1 FOR SELECT * FROM emp WHERE deptno = 30;   -- o : ����

OPEN cursor2 FOR SELECT empno, ename FROM emp WHERE deptno = 30;    -- o : �԰���
OPEN cursor2 FOR SELECT * FROM emp WHERE deptno = 30;   -- o : ����
-- Ŀ�� ������ ���� �ʿ��� ������ Ŀ�� ������ �����ϰ� ȣ���ؼ� �� ����� ����Ϸ��� ������ ����ϴ�.

curtype3 SYS_REFCURSOR;     -- �ý��ۿ��� �������ִ� Ŀ�� Ÿ��
-- SYS_REFCURSOR �� ����ϸ�
-- TYPE emp_dep_curtype IS REF CURSOR;  --> Ŀ��Ÿ�� ���� ��������
-- emp_curvar emp_dep_curtype;  --> ���� ������ �̹� �����ϴ� Ŀ��Ÿ���� SYS_REFCURSOR ���·� ����

DECLARE
    v_deptno emp.deptno%TYPE;   -- �Ϲ� ���� ����
    v_ename emp.dname%TYPE; -- �Ϲ� ���� ����
    emp_curvar SYS_REFCURSOR;   -- SYS_REFCURSOR Ÿ���� Ŀ������ ����(Ŀ�� �ڷ��� ������ �ʿ� ���� ��� �����մϴ�.)
BEGIN
    OPEN emp_curvar FOR SELECT ename, deptno FROM emp WHERE deptno = 20;    -- Ŀ�������� select �� ����
    LOOP
        FETCH emp_curvar INTO v_ename, v_deptno;        -- ���� �������ó�� �� �ڷḦ ������ ������ �ʿ��մϴ�.
        EXIT WHEN emp_curvar%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE( v_ename || ' - ' || v_deptno );
    END LOOP;
END;
-- 1. SYS_REFCURSOR ���� ����
-- 2. ������ select ����
-- 3. FETCH�� ������ ó��(�ݺ�����)





-- ���ν��������� Ŀ�� ��� ��
-- SELECT �� ����� Ŀ�������� ��Ƽ� ���ν����� ȣ���� OUT ������ �����մϴ�.
-- ���ν��� ���� : �μ���ȣ�� 10���� ����� �̸��� �޿� ����
CREATE OR REPLACE PROCEDURE testCursorArg(
    p_curvar OUT SYS_REFCURSOR
    -- �Ű������� SELECT ����� ����� ��Ƽ� �ٽ� �������� OUT ����(�ڷ��� SYS_REFCURSOR)�� �����մϴ�.
)
IS
    temp_curvar SYS_REFCURSOR;  -- ���ν��� �ȿ��� ����� Ŀ�� ����
BEGIN
    -- �������� �䱸�� �μ���ȣ�� 10�� ����� �̸��� �޿��� temp_curvar ������ ����
    OPEN temp_curvar FOR SELECT ename, sal FROM emp WHERE deptno = 10;
    -- ���� ��ġ���� Ŀ���� ������ fetch ���� �ʽ��ϴ�. �ݺ����൵ fetch�� ���� �ʽ��ϴ�.
    -- OUT ������ ����� Ŀ�� ������ ������ ����ϴ�.
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
-- select ������ temp_curvar�� temp_curvar�� ������ p_curvar�� p_curvar�� ������ curvar�� ����˴ϴ�.

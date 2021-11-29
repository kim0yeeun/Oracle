--- 11/29
-- PL/SQL ���� 

declare
    v_fname varchar2(20);
    -- ������ ���� �������ֱ� ���� ������ �������. 
begin
    select first_name
    into v_fname
    from employees
    where employee_id = 100;
    dbms_output.put_line(v_fname);
    -- ������ ����ȳ����� ���
end;
/
-- 'prosedure�Դϴ�' �� �ǹ�


--    emp_hiredate date;
--    -- ���� ���� 
--    vn_num1 number := 1;
--    -- ���� ���� �� �ʱ�ȭ := �ʱⰪ �ο� 
--    emp_daptno number(2) not null := 10;
--    c_comm_constant number :=1400;
--    -- ��� ���� : ���� ������ ���� 
DECLARE
    vn_num1 number := 1;
    vn_num2 number := 2;
BEGIN
    if vn_num1 >= vn_num2 then 
        dbms_output.put_line (vn_num1 || '�� ū �� �Դϴ�.');
    else 
        dbms_output.put_line (vn_num2 || '�� ū �� �Դϴ�.');
    end if;
END;    
/

DECLARE
    employee_id number(6);      -- ���� �̸��� �ĺ��ڴ� ������� �ʴ� ���� ����.
BEGIN
    select employee_id          -- ���� ���̺��� �ƴ� �ٸ� ���̺��� ���
    into employee_id            -- ���������� ����ϴ� ���� ����. 
    from employees
    where last_name = 'Kochhar';
    dbms_output.put_line (employee_id);
END;
/


declare
    num1 number(10,3);
    bf_var BINARY_FLOAT; 
    bd_var BINARY_DOUBLE;
    --binary : �� ��Ȯ�� ���� �����ϱ� ���� �� 
    
begin
    num1 := 270/35;
    bf_var := 270/35f;
    bd_var := 140d/0.35;

    dbms_output.put_line ('number = ' || num1);
    dbms_output.put_line ('bf = ' || bf_var);
    dbms_output.put_line ('df = ' || bd_var);
end;
/ 
-- number ������ �������� ������ �� �ִ� �� ������ ��� ���� �����Ѵ�. 


--- %type �Ӽ�
-- �����ͺ��̽� ���� ���ǵǾ� �ִ� Ÿ���� ����ϰų�
-- ����� �ٸ� ������ Ÿ���� ����ϱ� ���� �� 
-- emp_lname employees.last_name%type; �̷��� ����
-- balance number (7,2); ���� ���ǵ� ������ Ÿ����
-- min.balance balance%type := 1000; �̷��� ��� 

DECLARE
    v_lastname employees.last_name%type;
    v_firstname employees.first_name%type;
BEGIN
    select last_name, first_name
    into v_lastname, v_firstname
    from employees
    where employee_id = 143;
    dbms_output.put_line (v_lastname);
    dbms_output.put_line (v_firstname);
END;
/


    
DECLARE
    flag boolean := false;
BEGIN
    flag := TRUE;
    dbms_output.put_line(flag);
    -- �ο�Ÿ���� dbout ���� ����� �� ����. 
END;
/


--- ���ε� ���� (= host ����)
-- variable Ű���带 ����ؼ� �����Ѵ�.
-- pl/sql ����� ����� �Ŀ��� ������ �����ϴ�.
--VARIABLE return_code number
--VARIABLE return_msg varchar2(30)
-- ���� �տ� �ݷ��� ����Ͽ� �����Ѵ�. 


VARIABLE emp_salary number
set autoprint on
begin
    select salary
    into :emp_salary -- variable����  
    -- ���ε� ������ ����� ������ : �� �տ� �ٿ����Ѵ�. 
    from employees
    where employee_id = 143;
    -- dbms_output.put_line(emp_salary);
    -- emp_salary �� declare�� ����Ǿ��־�� �Ѵ�. �� ������ ��� 
end;
--print emp_salary
--select first_name, employee_id from employees
--where salary = :emp_salary;
/


--- ġȯ���� 
-- ���� �Է��� ��� �� ���ȴ�.
-- �տ� ���ۻ���(&)�� �ٿ� PL/SQL ��� ������ ����
-- �����߿� ���� �� �ִ� ���� ���� �ڵ��ϴ� ���� ���� �� �ִ�.

VARIABLE emp_salary NUMBER
SET AUTOPRINT ON
DECLARE
    empno NUMBER(6):= &empno; -- ġȯ����
BEGIN
SELECT salary INTO :emp_salary 
FROM employees WHERE employee_id = empno; 
END;
/



set verify off
VARIABLE emp_salary number
accept empno prompt '�����ȣ�� �Է��ϼ���. '
set autoprint on
DECLARE
    empno number(6) := &empno; -- ġȯ����
BEGIN
    select salary into :emp_salary
    from employees where employee_id = empno;
END;
/
-- �����Ҷ����� ������ ���� �Է��ϰ� ������ ġȯ���� ��� 


-- declare �ȿ� declare ��� ���� ���� 
DECLARE 
    outer_variable varchar2(20) := 'Global Variable';
BEGIN
    DECLARE
        inner_variable varchar2(20) := 'Local Variable';
    BEGIN
        DBMS_OUTPUT.PUT_LINE(inner_variable);
        DBMS_OUTPUT.PUT_LINE(outer_variable);
    END;
    --DBMS_OUTPUT.PUT_LINE(inner_variable);
    --�ȿ��� ����� ������ �ۿ��� ����� �� ����. 
    DBMS_OUTPUT.PUT_LINE(outer_variable);
END;
/

-- ���� �̸��� ������ �ܺ�,���ο� �ϳ��� ����Ǿ��ִٸ�?
declare
    fname varchar2(20) := 'Patrick';
    hdate date := '2000-01-01';
begin
    declare 
        lname varchar2(20) := 'Mike';
        hdate date := '2001-12-25';
        -- ���� �̸��� ������ ���ο� �ϳ� �� ����
    begin
        DBMS_OUTPUT.PUT_LINE(lname);
        DBMS_OUTPUT.PUT_LINE(hdate); -- ��
        -- ���� �̸��� ������ ����Ǿ� ���� ��� �ȿ� �ִ� �� ���� ��� 
        DBMS_OUTPUT.PUT_LINE(fname);
    end;
    DBMS_OUTPUT.PUT_LINE(hdate);     -- ��
end;
/
    
--- begin<<outer>> end outer �������ִ� ����: �������� ���� �͵��� �����Ѵ�. 
-- �ĺ��ڸ� ��Ȯ�ϰ� �ϱ� ���ؼ� �����ش�. 
begin <<outer>>
declare
    fname varchar2(20) := 'Patrick';
    hdate date := '2000-01-01';
begin
    declare 
        lname varchar2(20) := 'Mike';
        hdate date := '2001-12-25';
    begin
        DBMS_OUTPUT.PUT_LINE(lname);
        DBMS_OUTPUT.PUT_LINE(hdate); 
        dbms_output.put_line(outer.hdate);
        DBMS_OUTPUT.PUT_LINE(fname);
    end;
    DBMS_OUTPUT.PUT_LINE(hdate);     
end;
end outer;
/



--- pl/sql �������� �׷��Լ��� ����� �� �ִ�. 
set serveroutput on
declare
    sum_sal number (10,2);
    deptno number not null:= 60;
begin
    select sum(salary)  -- group function
    into sum_sal from employees
    where department_id = deptno;
    dbms_output.put_line('60�μ��� �޿��� �հ谪�� ' || sum_sal);
end;
/


-- �̸��� �޸� �ϴ� ���� : ��ȣ�� ���� 
-- ����ڰ� ����ϰ��� �ϴ� ������ �÷��� �������� �𸥴�. 
-- �����ͺ��̽��� �� �̸��� �ĺ��ڷ� ������� �ʴ� ���� ����. 
-- ���� ������ ���� �Ķ������ �̸��� �����ͺ��̽� ���̺��� �̸����� �켱�մϴ�.
-- �����ͺ��̽� ���̺� ���� �̸��� ���� ������ �̸����� �켱�մϴ�.
-- å 113p

declare 
    hire_date employees.hire_date%type;
    sysdate hire_date%type;
    employee_id employees.employee_id%type := 176;
begin
    -- ORA-00904: "EMPLOYEEID": �������� �ĺ���
    -- �÷���� �������� ������ ������ �߻��Ѵ�. 
    select hire_date, sysdate
    into hire_date, sysdate
    from employees
    where employee_id = employeeid;
end;
/


create SEQUENCE employees_seq;
begin
    insert into emp
    (employee_id,first_name,last_name,email,hire_date,job_id,salary)
    values(employee_deq.nextval,'Ruth','Cores','RCORES',sysdate,'AD_ASST',4000);
end;
/

select * from emp;

accept fname prompt '��� �̸��� �Է��ϼ���. '
accept lname prompt '��� ���� �Է��ϼ���. '
accept mail prompt '��� �̸����� �Է��ϼ���. '
accept hdate prompt '��� �Ի����� yyyy-mm-dd �������� �Է��ϼ���. '
accept jid prompt '��� ������ �Է��ϼ���. '
accept sal prompt '��� �޿��� �Է��ϼ���. '

declare
    fname employee.first_name%TYPE := &fname; -- ġȯ����
    lname employee.last_name%TYPE := &lname;
    mail employee.email%TYPE := &mail;
    hdate employee.hire_date%TYPE := &hdate;
    jid employee.job_id%TYPE := &jid;
    sal employee.salary%TYPE := &sal;
begin
    insert into emp
    (employee_id,first_name,last_name,email,hire_date,job_id,salary)
    values(employee_deq.nextval,fname,lname,mail,hdate,jid,sal);
end;
/


-- update, delete 
declare 
    sal_increase employees.salary%type := 800;
begin 
    update employees
    set salary = salary + sal_increase
    where job_id = 'ST_CLERK';
    dbms_output.put_line('ST_CLERK �� �����Ͱ� ���ŵǾ����ϴ�.');
end;
/

declare
    empid employees.employee_id%type := 1;
begin
    delete from emp
    where employee_id = empid;
    dbms_output.put_line('1�� ����� �����Ͱ� �����Ǿ����ϴ�.');
end;
/

declare
    empid employees.employee_id%type := 3;
begin
    delete from emp
    where employee_id = empid;
    dbms_output.put_line(empid||'�� ����� �����Ͱ� �����Ǿ����ϴ�.');
end;
/

-- merge 

declare
    empno emp.employee_id%type := 200;
begin
merge into ex3_6 a
    using (select * from emp where employee_id = empno) b
    on (a.employee_id = b.employee_id)
when matched then
    update set salary = salary*1.1
when not matched then
    insert(a.employee_id, a.emp_name, a.salary, a.manager_id)
    values(b.employee_id, b.first_name, 15000,100);
end;
/
select * from ex3_6;


-- ���� if��
declare
    myage number := 31;
begin
    if myage < 11
    then 
        dbms_output.put_line ('���� 11�� �̸��Դϴ�.');
    else 
        dbms_output.put_line ('���� ���̴� ' || myage || '�� �Դϴ�');
    end if;
end;
/


-- �޿��� 1000 ���� ���� ���� 3 ���ϸ� ���, 5 ���ϴ� ����, 7���� �븮,
-- 9���� ����, 10���� ���� 13���� ���� 15���� ������ �� �ܿ� �̻�� ��� 130�� ����� ���� ��� 

declare 
    sal number;
    empid employees.employee_id%type := 130;
begin
    select trunc(salary/1000)
    into sal 
    from employees
    where employee_id = empid;
    if sal <= 3 then
        dbms_output.put_line ('���');
    elsif sal <= 5 then
        dbms_output.put_line ('����');
    elsif sal <= 7 then
        dbms_output.put_line ('�븮');
    elsif sal <= 9 then
        dbms_output.put_line ('����');
    elsif sal <= 10 then
        dbms_output.put_line ('����');
    elsif sal <= 13 then
        dbms_output.put_line ('����');
    elsif sal <= 15 then
        dbms_output.put_line ('������');
    else 
        dbms_output.put_line ('�̻�');
    end if;
end;
/


-- case������ �ۼ�
declare 
    empid employees.employee_id%type := 130;
    grade varchar2(20);
begin
    select 
    case when trunc(salary/1000) <= 3 then '���'
        when trunc(salary/1000) between 4 and 5 then '����'
        when trunc(salary/1000) <= 7 then '�븮'
        when trunc(salary/1000) <= 9 then '����'
        when trunc(salary/1000) <= 10 then '����'
        when trunc(salary/1000) <= 13 then '����'
        when trunc(salary/1000) <= 15 then '������'
        else '�̻�' end
    into grade from emp where employee_id = empid;
    dbms_output.put_line('������ ��å�� ' || grade);
end;
/

-- case������ �ۼ�
-- grade �� �����Է� 
declare
    grade char(1) := upper('&grade');
    result1 varchar2(30);
begin
    result1 :=
    case grade
        when 'A' then '90�� �̻��Դϴ�.'
        when 'B' then '80�� �̻��Դϴ�.'
        when 'C' then '70�� �̻��Դϴ�.'
        when 'D' then '60�� �̻��Դϴ�.'
        when 'F' then '60�� �̸��Դϴ�.'
    end;
    dbms_output.put_line ('grade : ' || grade || ' �� ��' || result1);
end;
/


declare 
    empid employees.employee_id%type := &empid;
    sal number;
    result1 varchar2(30);
begin
    select trunc(salary/1000)
    into sal
    from employees
    where employee_id = empid;
    /*case �� �����ϼ���*/
    result1 :=
    case when sal <= 3 then '���'
        when sal <= 5 then '����'
        when sal <= 7 then '�븮'
        when sal <= 9 then '����'
        when sal <= 10 then '����'
        when sal <= 13 then '����'
        when sal <= 15 then '������'
        else '�̻�' end;
    dbms_output.put_line('������ ��å�� ' || result1 || '�Դϴ�.');
end;
/


declare 
    grade char(1) := upper('&grade');
begin
    case
        when grade = 'A' then dbms_output.put_line ('Excellent');
        when grade in ('B','C') then dbms_output.put_line ('good');
        else dbms_output.put_line ('No such grade');
    end case;
end;
/
    
-- �μ��� ��ȣ�� �Է¹޾Ƽ� �μ����� �μ���ȣ�� �μ��̸��� ������� ����������.
-- 108 ��� �μ����� �μ��� 90���̰� �μ����� ������, ������� 20���̴�.
select * from departments where manager_id is not null; -- test ������ 11��
declare 
    deptid number;
    deptname VARCHAR2(20);
    mngid NUMBER:= 201; 
    emps number;
begin  
    case mngid
    when 200 then
        select department_id, department_name
        into deptid,deptname from departments
        where manager_id = mngid;
        SELECT count(*) INTO emps FROM employees 
        WHERE department_id=deptid;
    when 201 then
        select department_id, department_name
        into deptid,deptname from departments
        where manager_id = mngid;
        SELECT count(*) INTO emps FROM employees 
        WHERE department_id=deptid;
    when 114 then
        select department_id, department_name
        into deptid,deptname from departments
        where department_id = deptid;
        SELECT count(*) INTO emps FROM employees 
        WHERE department_id=deptid;
    end case;
    DBMS_OUTPUT.PUT_LINE (mngid ||'��� �μ����� �μ��� '|| deptid|| '���̰� �μ����� '
    || deptname ||' �̸� ������� ' ||emps|| ' �Դϴ�.');
end;
/   


-- �⺻ loof �ݺ���
select * from employees where department_id = 10;

declare 
    counter number(2) := 1;
    empid number(6) := &empid;
    eid number;
    fname varchar2(20);
    sal number;
    mngid number;
begin 
    loop
        select employee_id, first_name, salary, manager_id
        into eid, fname, sal, mngid
        from employees
        where employee_id = empid + counter;
        counter := counter + 1;
        insert into ex3_6
        values (eid, fname, sal, mngid);
        EXIT when counter > 3;
        -- Ż���ϱ� ���� ������ �� �־���Ѵ�. �ȱ׷��� ���ѷ����� ������. 
    END loop;
end;
/

select * from ex3_6;
delete from ex3_6;
commit;


-- while �ݺ��� (������ ���� �� ���)
-- EXIT �� ���� �ʿ����� �ʴ�. 
declare 
    counter number(2) := 1;
    empid number(6) := &empid;
    eid number;
    fname varchar2(20);
    sal number;
    mngid number;
begin
    while counter <= 3 loop
        select employee_id, first_name, salary, manager_id
        into eid, fname, sal, mngid
        from employees
        where employee_id = empid + counter;
        insert into ex3_6
        values(eid, fname, sal, mngid);
        counter := counter + 1;
    end loop;
end;
/


-- for �ݺ���
begin 
    for i in 1..9 loop
        dbms_output.put_line (i);
    end loop;
end;
/

declare
    counter number := 1;
    empid number := &empid;
    eid number;
    fname varchar2(20);
    sal number;
    mngid number;
begin
    for i in 1..3 loop
        select employee_id, first_name, salary, manager_id
        into eid, fname, sal, mngid
        from employees
        where employee_id = empid + i;
        insert into ex3_6
        values(eid, fname, sal, mngid);
    end loop;
end;
/
select * from ex3_6;

-- ������ �����

begin -- ��ø ����
    <<outer_loop>> --���̺� 
    for i in 1..9 loop
        <<inner_loop>> 
        for j in 1..9 loop
            dbms_output.put_line(i || '*' || j || '=' || j*j);
        end loop;
    end loop;
    end;
/




---  ���� 
-- 1.  d
-- 2. "Hello World"�� ����ϴ� ������ �͸� ����� �����Ͽ� ����
begin
    dbms_output.put_line('Hello World');
end;
/

-- 3. a
SET SERVEROUTPUT ON
DECLARE
fname VARCHAR2(20);
lname VARCHAR2(15) DEFAULT 'fernandez';
BEGIN
DBMS_OUTPUT.PUT_LINE( FNAME ||' ' ||lname);
END;
/

-- 4.
declare 
    today date := sysdate;
    tomorrow today%TYPE;
begin 
    tomorrow := today + 1;
    dbms_output.put_line('Hello World');
    dbms_output.put_line('TODAT IS ' || today);
    dbms_output.put_line('TOMORROW IS ' || tomorrow);
end;
/

-- 5. 

variable basic_percent number
variable pf_percent number
    :basic_percent := 45;
    :pf_percent := 12;
/
print basic_percent;
print pf_percent;


-- 6.
DECLARE
    weight NUMBER(3) := 600;
    message VARCHAR2(255) := 'Product 10012';
BEGIN
    DECLARE
        weight NUMBER(3) := 1;
        message VARCHAR2(255) := 'Product 11001';
        new_locn VARCHAR2(50) := 'Europe';
    BEGIN
        weight := weight + 1; --2
        new_locn := 'Western ' || new_locn; -- Western Europe
        DBMS_OUTPUT.PUT_LINE(weight);
        DBMS_OUTPUT.PUT_LINE(new_locn);
    END;
    weight := weight + 1; -- 601
    message := message || ' is in stock'; -- Product 10012 is in stock
    --new_locn := 'Western ' || new_locn; -- Western �� ���µ�? 
    DBMS_OUTPUT.PUT_LINE(weight);
    DBMS_OUTPUT.PUT_LINE(message);
    --DBMS_OUTPUT.PUT_LINE(new_locn); 
END;
/

-- 7. 

--variable basic_percent number
--variable pf_percent number
/*
    :basic_percent := 45;
    :pf_percent := 12;
*/

declare 
    fname varchar2(15);
    emp_sal number(10);
begin
    select first_name, salary
    into fname, emp_sal
    from employees
    where employee_id = 110;
    dbms_output.put_line('Hello ' || fname);
    dbms_output.put_line('Your salary is : ' || emp_sal);
    dbms_output.put_line('Your contribution towards PF : ' || emp_sal*:pf_percent/100);
end;
/


-- 8. 
create table employee_details  
as
select * from employees;
select * from employee_details;

select max(department_id) from departments;

-- 9,10. 
declare
    dept_name departments.department_name%TYPE := 'Education';
    dept_id number;
begin 
    select max(department_id)
    into dept_id from departments;
    dept_id := dept_id + 10;
    insert into departments (department_name, department_id, location_id)
    values (dept_name, dept_id, null);
    dbms_output.put_line(SQL%ROWCOUNT || ' ���� ���� ����Ǿ����ϴ�.');
    -- �� ���� �����Ͱ� ����ƴ��� �� ���� ����Ѵ�. 
end;
/
select * from departments;
-- 11. 



-- 12.
begin 
    for i in 1..10 loop
        if i not in (6,8) then
            dbms_output.put_line (i);
        end if;
    end loop;
    commit;
end;
/
            












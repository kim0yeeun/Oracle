--- 11/30

-- ���̺� �� ������ ����
create table emp3_7
as
select * from employees;
select * from emp3_7;
-- ���̺� ������ ����
create table emp3_8
as
select * from employees where 1=2;
select * from emp3_8;
-- �����͸� ������� ���̺� ����
insert into emp3_8
select * from employees;
select * from emp3_8;
-- ���ϴ� �����͸� ���� (�Ϻ� �÷��� ����)
insert into emp3_8 (employee_id,last_name,email,hire_date,job_id,salary)
select employee_id,last_name,email,hire_date,job_id,salary 
from employees;

-- ���� ����� �ʱ�ȭ
declare
    myname varchar2(20); -- ��������
begin
    dbms_output.put_line('MY NAME IS : ' || myname);
    myname := 'John'; -- �� �ʱ�ȭ
    dbms_output.put_line('MY NAME IS : ' || myname);
end;
/

declare
    myname varchar2(20) := 'Rhee'; -- ��������� ���ÿ� �ʱ�ȭ 
begin
    dbms_output.put_line('MY NAME IS : ' || myname);
    myname := 'John'; -- �� ���� 
    dbms_output.put_line('MY NAME IS : ' || myname);
end;
/

declare
    myname varchar2(20) := 'Rhee'; 
begin
    dbms_output.put_line('MY NAME IS : ' || myname);
    myname := q'\John's day \';
    -- q \ '  \ -> ' ��� �� 
    dbms_output.put_line('MY NAME IS : ' || myname);
end;
/ 

declare
    myname varchar2(20) := 'Rhee'; 
begin
    dbms_output.put_line('MY NAME IS : ' || myname);
    myname := q'\John's day \';
    dbms_output.put_line('MY NAME IS : ' || myname);
    myname := q'[John's day!]';
    dbms_output.put_line('MY NAME IS : ' || myname);
    myname := q'/John's day/';
    dbms_output.put_line('MY NAME IS : ' || myname);
end;
/
-- q '[]' �ϸ� '' ������ ' ���ڴ� ��� ��µȴ� 
-- q '\\'  q'//' ��������

declare
    first_name varchar2(20) := 'Soongmoo';
    last_name varchar2(20) default 'Rhee'; -- default �� �̿��ؼ� ������ �ʱ�ȭ �� �� �ִ�. 
begin
    dbms_output.put_line(first_name);
    dbms_output.put_line(last_name);
end;
/

-- ���ε� ����
variable emp_salary number
begin
    select salary into :emp_salary
    from employees where employee_id = 107;
end;
/
print emp_salary;
-- ���ε� ������ ����ϸ� ���ν����� ����� �Ŀ��� ����� �����ϴ�.
select * from employees
where salary = :emp_salary;
-- sql developeâ���� �ȵǸ� sql plus �Ѽ� ������� 
/

variable emp_salary number
SET AUTOPRINT ON
begin
    select salary into :emp_salary
    from employees where employee_id = 100;
end;
/

variable fname number
variable lname number
begin
    :fname := 45;
    :lname := 15;
end;
/
print fname;
print lname;




--- PL/SQL ���ڵ� ����
-- �ʵ� ������ ���� ������ ó���Ѵ�.
declare
    type emp_record_type is RECORD ( -- ����� �ڷ��� 
        employee_id number not null := 100,
        last_name employees.last_name%TYPE,
        job_id employees.job_id%TYPE
        );
        emp_record emp_record_type;
begin 
    emp_record.employee_id := 10;
    emp_record.last_name := 'Rhee';
    emp_record.job_id := 'AP';
    dbms_output.put_line(emp_record.employee_id);
    dbms_output.put_line(emp_record.last_name);
    dbms_output.put_line(emp_record.job_id);
end;
/


declare
    type emp_record_type is RECORD ( -- ����� �ڷ��� 
        employee_id number not null := 100,
        last_name employees.last_name%TYPE,
        job_id employees.job_id%TYPE
        );
        emp_record emp_record_type;
begin
    select employee_id,last_name,job_id
    into emp_record.employee_id,emp_record.last_name,emp_record.job_id
    from employees where employee_id = 100;
    dbms_output.put_line(emp_record.employee_id);
    dbms_output.put_line(emp_record.last_name);
    dbms_output.put_line(emp_record.job_id);
end;
/

--- %rowtype
-- �⺻ �����ͺ��̽� ���� ������ ����
-- select * ���� ����Ͽ� ���� �˻��� �� �����ϴ�.
-- ������ ������ ������� �ʾƵ� ������ �� �ִ�. 

declare
    emp_rec employees%ROWTYPE;
begin
    select * into emp_rec
    from employees where employee_id = &employee_id;
    insert into emp3_7(
    employee_id,last_name,email,hire_date,salary,job_id)
    values (emp_rec.employee_id,emp_rec.last_name,emp_rec.email,emp_rec.hire_date,emp_rec.salary,emp_rec.job_id);
end;
/
select * from emp3_7;


declare
    emp_rec emp3_7%rowtype;
begin
    select * into emp_rec from employees
    where employee_id = &empid;
    insert into emp3_7 values emp_rec;
end;
/
select * from emp3_7 where employee_id = 178;

-- ���ڵ带 ����Ͽ� ���̺��� �� ���� 
declare 
    emp_rec emp3_7%rowtype;
begin
    emp_rec.hire_date := sysdate;
    update emp3_7
    set hire_date = emp_rec.hire_date
    where employee_id = &empid;
end;
/
select * from emp3_7 where employee_id = 100;


-- index by table : �ప�� �������� ���� ���̺� 
-- ���ν����� �ϳ��� �ุ ������ �� �ִ�.
-- ���� �Ǵ� ���ڿ� ������ ������ primary key �� ����Ѵ�.
-- binary_integer �� pls_integer : ũ�Ⱑ �۾ƾ��ϱ� ������ integer ���

declare
    type dept_table_type is table of
        departments%rowtype
        -- department�� �ִ� �÷��� ��� ������ڴ�. 
        index by PLS_INTEGER;
    dept_table dept_table_type;
    max_count number(3) := 20;
begin
    for i in 1..max_count loop
        select * into dept_table(i) from departments
        where department_id = i * 10;
    end loop;
    for i in dept_table.first..dept_table.last loop
       -- in 1..max_count 
        insert into dept3_1 values dept_table(i);
    end loop;
end;
/
select * from departments;
select count(*) from departments; -- 28��
create table dept3_1
as
select * from departments where 1=2;
select * from dept3_1;


--- Ŀ�� open close
-- BOF : begin of file
-- EOF : end of file
-- cousor �� select �� ����� �� ��� 

declare
    cursor emp_cursor is
        select employee_id, last_name from employees
        where department_id = 30;
    empno employees.employee_id%TYPE;
    lname employees.last_name%TYPE;
begin
    open emp_cursor;
    fetch emp_cursor into empno,lname;
    dbms_output.put_line(empno || ' ' || lname);
end;
/
-- ��°� :  114 Raphaely 
-- ���� Ŀ���� �ִ� ���� ��� (ó����)


declare
    cursor emp_cursor is 
        select * from employees where department_id = &deptid;
    emp employees%rowtype;
begin  
    if not emp_cursor%isopen then -- Ŀ�� �����ִ��� �׽�Ʈ 
        open emp_cursor;
    end if;
    loop
        fetch emp_cursor into emp;
        exit when emp_cursor%notfound or emp_cursor%rowcount > 10;
        -- %rowcount : Ŀ���� ������ ������ 1�� �����ϴ� ���� ���´�.
        dbms_output.put_line(emp.first_name|| ' ' ||emp.last_name || ' ' || emp.department_id);
    end loop;
    close emp_cursor;
    -- Ŀ���� ���������� ������ �߻��Ѵ�. 
end;
/

-- subquery �� ����ϴ� cursor for loop 
-- Ŀ���� ������ �ʿ䰡 ����. 
begin
    for emp_record in (select employee_id, last_name from employees where department_id = 30)
        loop
            dbms_output.put_line(emp_record.employee_id || ' ' || emp_record.last_name);               
        end loop;
end;
/


--- �Ķ���Ͱ� ���Ե� Ŀ��
declare 
    cursor emp_cursor(deptno number) is 
        select * from employees
        where department_id = deptno;
    emp employees%rowtype;
begin
    open emp_cursor (20); 
    -- �Ķ���Ͱ� �ִ� ��� ���� �������ش�. 
    -- �׷��� �Ź� �ٸ��� ���� �ֱ� ������ �����Ŀ���� ������ �����ش�.
    loop
        fetch emp_cursor into emp;
        exit when emp_cursor%notfound;
        dbms_output.put_line(emp.employee_id || ' ' || emp.first_name || ' ' || emp.department_id);   
    end loop;
end;
/

-- ���� ���ν����� Ŀ���� open ���־���
-- �Ʒ��� ���ν����� for������ �ڵ� �����ϰ� �������. 
declare
    cursor emp_cursor(deptno number) is
        select * from employees
        where department_id = deptno;
begin
    for emp in emp_cursor(20) loop
        dbms_output.put_line(emp.employee_id || ' ' || emp.first_name || ' ' || emp.department_id);
    end loop;
end;
/

--- ����
-- �Ķ���Ͱ� �ִ� Ŀ���� ���� �� �μ� ��ȣ�� ������ �޵��� �ϰ�, �̸�, ����, �μ���ȣ�� ����ϼ���.
-- 1.openĿ�� 2.for�����ο��� 
declare
    cursor para(deptno number, jobno varchar2) is
        select * from employees
        where department_id = deptno and job_id = jobno;
        emp employees%rowtype;
begin
    open para (&deptno,&jobno); 
    loop
        fetch para into emp;
        exit when para%notfound;
        dbms_output.put_line(emp.first_name || ' ' || emp.job_id || ' ' || emp.department_id);
    end loop;
end;
/

declare
    cursor para(deptno number, jobno varchar2) is
        select * from employees
        where department_id = deptno and job_id = jobno;
begin
    for emp in para(&deptno,&jobno) loop
        dbms_output.put_line(emp.first_name || ' ' || emp.job_id || ' ' || emp.department_id);
    end loop;
end;
/
select * from employees where department_id = 20;

select * from emp3_7;
    
-- ��� : �ٸ� ����ڰ� �� ���̺��� ����� �� ���� �Ѵ�.     
select * from emp3_7
for update nowait;

declare
    cursor emp_cursor is
        select * from emp3_7 
        where department_id = 80 for update of salary;
    emp emp3_7%rowtype;
begin
    open emp_cursor;
    loop
        fetch emp_cursor into emp;
        EXIT when emp_cursor%notfound;
            dbms_output.put_line(emp.last_name || ' ' || emp.salary);
    end loop;
end;
/


declare
    cursor emp_cursor(deptno number) is
        select * from emp3_7 where department_id = deptno
        for update;
    emp emp3_7%rowtype;
begin
    open emp_cursor(10);
    loop
        fetch emp_cursor into emp;
        exit when emp_cursor%notfound;
        update emp3_7
        set salary = salary *1.1
        where current of emp_cursor;
        -- ���� Ŀ���� �ش��ϴ� ���� ������Ʈ�϶�� �� 
    end loop;
end;
/
select * from emp3_7 where department_id = 10;
    
-- ���ν����� �� �ุ �������Ƿ� �������� ������ �� ����. -> ������ �߸鼭 �����
-- ���Ḧ �������� exception
declare
    lname varchar2(15);
begin
    select last_name into lname from employees 
    where first_name = 'John';
    dbms_output.put_line(lname);
    exception
    when TOO_MANY_ROWS then
    dbms_output.put_line('���� ���� �ʹ� �����ϴ�.');
    when NO_DATA_FOUND then
    dbms_output.put_line('�����Ͱ� �����ϴ�.');
    when INVALID_CURSOR or DUP_VAL_ON_INDEX or ZERO_DIVIDE then
    dbms_output.put_line('Ŀ���� ��Ȯ�����ʴ�. �ε����� �ߺ��ƴ�. 0���� ������ ���Ѵ�.');
    when OTHERS then
    dbms_output.put_line('������ ����ó��');
end;
/

create sequence dept_num
increment by 1
start with 400;


--- ���ν��� �� �Լ� 
-- �Լ��� return ���� �ִ�.

create or replace procedure add_dept
is
    dept_id dept.department_id%TYPE;
    dept_name dept.department_name%TYPE;
begin
    dept_id := 320;
    dept_name := '���ߺ�';
    insert into dept(department_id,department_name)
    values(dept_num.nextval,dept_name);
    dbms_output.put_line(' Inserted ' || sql%rowcount || ' row ');
end;
/
exec add_dept;
select * from dept where department_id = 320;

create or replace procedure update_sal
(v_empno    in      number)
is
begin
    update emp3_7
    set salary = salary * 1.1
    where employee_id = v_empno;
end update_sal;
/

exec update_sal(100);
select * from emp3_7 where employee_id = 100;



create or replace procedure prc_tree
(
    v_emp_code in varchar2,
    p_code out varchar2,
    t_code out varchar2
    -- in procedure ������ ���� �ްڴ�. out procedure ������ ���� �������ڴ�.
)
is
begin
    select employee_id, job_id into p_code, t_code
    from employees
    where employee_id = v_emp_code;
end prc_tree;
/

declare 
    p_code varchar2(20);
    t_code varchar2(20);
begin
    prc_tree('120',p_code,t_code);
    dbms_output.put_line(p_code || ' ' || t_code);
end;
/

create or replace procedure sal_mng
(
    empid in number,
    sal out number,
    mng out number
)
is
begin
    select salary,manager_id into sal,mng from employees
    where employee_id = empid;
end sal_mng;
/

declare 
    sal number;
    mng number;
begin
    sal_mng(120,sal,mng);
    dbms_output.put_line('SALARY : ' || sal || ' MANAGER_ID : ' || mng);
end;
/

select * from emp3_7 ;
create or replace procedure emp_del_proc
(
    empid in number
)
is
begin
    delete from emp3_7
    where employee_id = empid;
    commit;
end emp_del_proc;
/
exec emp_del_proc(300);


select * from emp3_7 where job_id  = 'AD_PRES';
--- ���� 
-- 1.���ν����� �̿��ؼ� emp3_7 �� ���� ������ �Է��ϼ���.
-- 2.jobs_exam �� ���� 'AD_PRES' �� ���ν����� ���ڰ����� �����ϰ� 
-- ������ jobs���� insert, ������ min_salary �� 2000, max_salary �� 6000 ���� update �ϼ���. 
-- exec my_new_job_proc ('AD_PRES',2000,6000);

create table jobs_exam
as 
select job_id as jid, max(salary)as maxsal, min(salary) as minsal from emp3_7 
group by job_id;
drop table jobs_exam;

create or replace procedure my_new_job_proc
(
    jid in varchar2,
    min_sal in number,
    max_sal in number
)
is
begin
    if 
        ?????? = (select jod_id from emp3_7 where jod_id = jid) then 
        update jobs_exam
        set maxsal = max_sal, minsal = min_sal;
    else
        insert into jobs_exam (jid, min_sal, max_sal)
        values (jod_id,maxsal, minsal);
    end if;
end my_new_job_proc;
/

declare
    jid varchar2(20);
    min_sal number;
    max_sal number;
begin
    my_new_job_proc('AD_PRES',2000,6000);
    dbms_output.put_line('MIN : ' || min_sal || '   MAX : ' || max_sal);
end;
/


merge into jobs_exam a
        using (select * from emp3_7 where job_id = jid) b
        on (a.jid = b.job_id)
    when matched then
        update set maxsal = max_sal , minsal = min_sal
    when not matched then
        insert (a.jid,a.maxsal,a.minsal)
        values (b.job_id,b.max_sal,b.min_sal);

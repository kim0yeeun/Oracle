--- 12/1
-- �Լ� 

create or replace function check_sal
return number 
-- booleanŸ���� ���� �޾ƿ� �� ����. 
is
    dept_id employees.department_id%TYPE;
    empno employees.employee_id%TYPE;
    sal employees.salary%TYPE;
    avg_sal employees.salary%TYPE;
begin
    empno :=205;
    select salary,department_id into sal,dept_id
    from employees
    where employee_id = empno;
    --- 205�� ����� �μ��� ��� �޿�
    select avg(salary) into avg_sal from employees
    where department_id = dept_id;
    if sal > avg_sal then
        return 1;
    else
        return 0;
    end if;
end;
/
var t_f number;
exec :t_f := check_sal();
print t_f;



create or replace function check_sal
return boolean 
-- boolean Ÿ���� ��ȯ������ �� ��쿡�� if�� ���
is
    dept_id employees.department_id%TYPE;
    empno employees.employee_id%TYPE;
    sal employees.salary%TYPE;
    avg_sal employees.salary%TYPE;
begin
    empno :=205;
    select salary,department_id into sal,dept_id
    from employees
    where employee_id = empno;
    --- 205�� ����� �μ��� ��� �޿�
    select avg(salary) into avg_sal from employees
    where department_id = dept_id;
    if sal > avg_sal then
        return true;
    else
        return false;
    end if;
end;
/

-- ��ȯ���� boolean�� ��� if�� ���
begin
    if (check_sal is null) then
        dbms_output.put_line('check_sal�� null�Դϴ�.');
    elsif (check_sal) then
        dbms_output.put_line('Salary > Average');
    else
        dbms_output.put_line('Salary < Average');
    end if;
end;
/

create or replace function FC_update_sal(
    v_empno in number
    )
return number
is
    sal employees.salary%TYPE;
begin
    update emp3_7
    set salary = salary * 1.1
    where employee_id = v_empno;
    select salary into sal from employees
    where employee_id = v_empno;
    return sal; -- ���Ϲ��� �� �����ؾ��Ѵ�.
end;
/

var sal1 number;
exec :sal1 := FC_update_sal(110);
print sal1;

-- ����
-- emp3_7 ���̺��� �̸����� �μ� ��ȣ�� �˻��ϴ� �Լ��� �ۼ��ض�
create or replace function FC_search_dept(
    v_name in employees.first_name%TYPE
)
return number
is
    dept_id employees.department_id%type;
begin
    select department_id into dept_id from employees
    where first_name = v_name;
    return dept_id;
    exception 
        when no_data_found then 
            dbms_output.put_line('�����Ͱ� �����ϴ�');
        when too_many_rows then 
            dbms_output.put_line('�̸��� 2�� �̻��Դϴ�.');
        when others then
            dbms_output.put_line('��Ÿ �����Դϴ�.');
            
end FC_search_dept;
/
var deptid number;
exec :deptid := FC_search_dept('Shelley');
print deptid;

select * from employees where first_name = 'Steven';
-- 2�� �̻��Դϴ� dbms ��� ȭ�� Ȯ�� 

--- ����
-- emp���̺��� �̸��� �Է¹޾� �μ���ȣ, �μ���, �޿��� �˻��ϴ� function�� �ۼ��ض�
-- �� �μ���ȣ�� return �� ����Ͽ��� 

create or replace function FC_search(
    v_name in employees.first_name%TYPE,
    v_deptno out employees.department_id%TYPE,
    v_dname out departments.department_name%TYPE,
    v_sal out employees.salary%TYPE
)
return number
is 
    deptno employees.department_id%TYPE;
    deptname departments.department_name%TYPE;
    sal employees.salary%TYPE;
begin
    select d.department_id, department_name, salary into deptno, deptname, sal
    from employees e,departments d
    where first_name = v_name and d.department_id = e.department_id;
    v_dname := deptname; -- ouput ������ ���� 
    v_sal := sal;
    dbms_output.put_line('�̸� : ' || v_name);
    dbms_output.put_line('�μ���ȣ : ' || to_char(v_deptno));
    dbms_output.put_line('�μ��� : ' || deptname);
    dbms_output.put_line('�޿� : ' || to_char(sal,'$999,999'));
    return deptno;
    exception 
        when no_data_found then 
            dbms_output.put_line('�����Ͱ� �����ϴ�');
        when too_many_rows then 
            dbms_output.put_line('�̸��� 2�� �̻��Դϴ�.');
        when others then
            dbms_output.put_line('��Ÿ �����Դϴ�.');    
end FC_search;
/
var g_deptno number;
var g_dname varchar2(20);
var g_sal number;
exec :g_deptno := FC_search('Shelley',:g_dname,:g_sal); -- Neena
print g_deptno;
print g_sal;
print g_dname;

-- �Ի����� ���ϴ� �Լ��� ������
create or replace function FC_hiredate (
    v_empid in employees.employee_id%TYPE
)
return date
is
    hdate date;
begin
    select hire_date into hdate from employees
    where employee_id = v_empid;
    return to_char(hdate);
end FC_hiredate;
/
var g_hdate VARCHAR2(25);
exec :g_hdate := FC_hiredate(100); 
print g_hdate;

-- ����� ��
create or replace function FC_hiredate1 (
    v_empid in employees.employee_id%TYPE, v_fmt in varchar2
    -- �����ȣ�� ��¥ ����
)
return varchar2
is
    hdate varchar2(20);
begin
    select to_char(hire_date,v_fmt) into hdate from employees
    where employee_id = v_empid;
    return hdate;
end FC_hiredate1;
/
var g_hdate1 VARCHAR2(20);
exec :g_hdate1 := FC_hiredate1(100,'dd-mm-yyyy'); 
print g_hdate1;


-- ������ ����ϴ� �Լ��� ������ 
create or replace function FC_yearsal(
    v_empid employees.employee_id%TYPE
)
return number
is
    year_sal number;
begin
    select salary * (1+nvl(commission_pct,0)) * 12 into year_sal from employees
    where employee_id = v_empid;
    return year_sal;
end FC_yearsal;
/
var g_year_sal number;
exec :g_year_sal := FC_yearsal(100);
print g_year_sal;

-- �����޿���� 
create or replace function FC_retire_money(
    v_empid number
)
return number
is
    v_sal number;
begin
    select round(salary * (1+nvl(commission_pct,0))
        * round(months_between(sysdate,hire_date),0)/12,0)
    into v_sal from employees where employee_id = v_empid;
    return v_sal;
end FC_retire_money;
/
var retire_money number;
exec :retire_money := FC_retire_money(100);
print retire_money;


-- trigger
-- old ���̺� : ���� �� ������ �Ǵ� ������ ������ 
-- new ���̺� : ���� �� ������ �Ǵ� ���� �Էµ� ������

create or replace trigger emp_tri_row
after update of salary on emp3_7
-- emp3_7 �� salary ���� ������Ʈ�� �߻��ߴٸ�
for each row -- �� �࿡ ���ؼ� �����ϰڴ�.
begin
    if :old.salary < :new.salary then
        update emp3_8
        set salary = :old.salary * 1.1
        where employee_id = :new.employee_id;
    end if;
end;
/
select * from emp3_7 where employee_id = 120;
select * from emp3_8 where employee_id = 120;
update emp3_7
set salary = 13000
where employee_id = 120;


-- emp3_8 �� ������Ʈ���� �ʾƵ� emp3_7 �� ������Ʈ�� �� ������ ������ trigger�� �߻��ؼ� emp3_8 �� ������Ʈ�ȴ�.
-- emp3_7 �� 170�� ����� �����͸� employees ���̺��� �ҷ��� �����Ѵٸ�,
-- emp3_8 �� 170 �� ����� �����Ͱ� ����ǰ� �ϼ���.

select * from emp3_7 where employee_id = 170;
select * from emp3_8 where employee_id = 170;
create or replace trigger emp_test_ins
after insert on emp3_7
for each row
begin
    insert into emp3_8 (employee_id,last_name,email,hire_date,job_id)
    values (:new.employee_id,:new.last_name,:new.email,:new.hire_date,:new.job_id);
end;
/

insert into emp3_7
select * from employees where employee_id = 170;
select * from emp3_7 where employee_id = 170;
select * from emp3_8 where employee_id = 170;


-- emp3_7�� employees���� 145 �� ����� �����͸� �����ϰ� emp3_7 �� �ִ� 145�� ����� Ŀ�̼��� 0.5�� ������ ��,
-- ���� �� ���� ���� �� ������ ���� ��� emp3_9�� 145 ����� �޿��� 15% �λ��Ͽ� �����ϼ���.
create or replace trigger emp_aft_udt_row
after update of commission_pct on emp3_7
for each row
begin
    if :old.commission_pct < :new.commission_pct then
        update emp3_8
        set salary = salary * 1.15
        where employee_id = :new.employee_id;
    end if;
end;
/
select * from emp3_8 where employee_id = 150;
update emp3_7
set commission_pct = 0.5
where employee_id = 150;

-- emp3_7 �� 151�� ����� ������ 'ST_CLERK' �� ����Ǿ��ٸ� emp3_8 �� Ŀ�̼��� 0.6 ���� �����ض�
create or replace trigger test_up_tri
after update of job_id on emp3_7
for each row
begin
    if :new.job_id = 'ST_CLERK' then
        update emp3_8
        set commission_pct = 0.6
        where employee_id = :new.employee_id;
    end if;
end;
/
select * from emp3_7 where employee_id = 151;
select * from emp3_8 where employee_id = 151;
update emp3_7
set job_id = 'ST_CLERK'
where employee_id = 151;



create table emp_empty
as
select * from employees where 1=2;

create or replace trigger emp_test_del
after delete on emp3_7
for each row
begin
    insert into emp_empty(employee_id,last_name,email,hire_date,job_id)
    values (:old.employee_id,:old.last_name,:old.email,:old.hire_date,:old.job_id);
end;
/
select * from emp_empty;
delete from emp3_7 where employee_id = 200;
select * from emp3_7 where employee_id = 200;
rollback;


create table old_new
(
	old_first_name varchar2(20),
	new_first_name varchar2(20)
);

create or replace trigger emp_test_upd
after update on emp3_7
for each row
begin
    insert into old_new
    values(:old.first_name,:new.first_name);
end;
/
update emp3_7
set first_name = 'Rhee'
where employee_id = 100;

select * from old_new;




create or replace trigger emp_test_ins
after insert on emp3_7
for each row
begin
    insert into emp_empty(employee_id,last_name,email,hire_date,job_id)
    values (:new.employee_id,:new.last_name,:new.email,:new.hire_date,:new.job_id);
end;
/

insert into emp3_7
select * from employees where employee_id = 200;

select * from emp_empty where employee_id = 200;







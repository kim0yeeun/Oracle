--- 12/1
-- 함수 

create or replace function check_sal
return number 
-- boolean타입은 값을 받아올 수 없다. 
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
    --- 205번 사원의 부서의 평균 급여
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
-- boolean 타입을 반환값으로 한 경우에는 if문 사용
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
    --- 205번 사원의 부서의 평균 급여
    select avg(salary) into avg_sal from employees
    where department_id = dept_id;
    if sal > avg_sal then
        return true;
    else
        return false;
    end if;
end;
/

-- 반환값이 boolean인 경우 if문 사용
begin
    if (check_sal is null) then
        dbms_output.put_line('check_sal가 null입니다.');
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
    return sal; -- 리턴문이 꼭 존재해야한다.
end;
/

var sal1 number;
exec :sal1 := FC_update_sal(110);
print sal1;

-- 문제
-- emp3_7 테이블에서 이름으로 부서 번호를 검색하는 함수를 작성해라
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
            dbms_output.put_line('데이터가 없습니다');
        when too_many_rows then 
            dbms_output.put_line('이름이 2개 이상입니다.');
        when others then
            dbms_output.put_line('기타 에러입니다.');
            
end FC_search_dept;
/
var deptid number;
exec :deptid := FC_search_dept('Shelley');
print deptid;

select * from employees where first_name = 'Steven';
-- 2개 이상입니다 dbms 출력 화면 확인 

--- 문제
-- emp테이블에서 이름을 입력받아 부서번호, 부서명, 급여를 검색하는 function을 작성해라
-- 단 부서번호를 return 에 사용하여라 

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
    v_dname := deptname; -- ouput 변수에 저장 
    v_sal := sal;
    dbms_output.put_line('이름 : ' || v_name);
    dbms_output.put_line('부서번호 : ' || to_char(v_deptno));
    dbms_output.put_line('부서명 : ' || deptname);
    dbms_output.put_line('급여 : ' || to_char(sal,'$999,999'));
    return deptno;
    exception 
        when no_data_found then 
            dbms_output.put_line('데이터가 없습니다');
        when too_many_rows then 
            dbms_output.put_line('이름이 2개 이상입니다.');
        when others then
            dbms_output.put_line('기타 에러입니다.');    
end FC_search;
/
var g_deptno number;
var g_dname varchar2(20);
var g_sal number;
exec :g_deptno := FC_search('Shelley',:g_dname,:g_sal); -- Neena
print g_deptno;
print g_sal;
print g_dname;

-- 입사일을 구하는 함수를 만들어라
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

-- 강사님 답
create or replace function FC_hiredate1 (
    v_empid in employees.employee_id%TYPE, v_fmt in varchar2
    -- 사원번호와 날짜 형식
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


-- 연봉을 계산하는 함수를 만들어라 
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

-- 퇴직급여계산 
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
-- old 테이블 : 변경 전 데이터 또는 삭제된 데이터 
-- new 테이블 : 변경 된 데이터 또는 새로 입력된 데이터

create or replace trigger emp_tri_row
after update of salary on emp3_7
-- emp3_7 에 salary 에서 업데이트가 발생했다면
for each row -- 각 행에 대해서 실행하겠다.
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


-- emp3_8 을 업데이트하지 않아도 emp3_7 을 업데이트할 때 조건이 맞으면 trigger가 발생해서 emp3_8 도 업데이트된다.
-- emp3_7 에 170번 사원의 데이터를 employees 테이블에서 불러와 저장한다면,
-- emp3_8 에 170 번 사원의 데이터가 저장되게 하세요.

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


-- emp3_7에 employees에서 145 번 사원의 데이터를 저장하고 emp3_7 에 있는 145번 사원의 커미션을 0.5로 변경할 때,
-- 변경 전 값이 변경 후 값보다 작은 경우 emp3_9의 145 사원의 급여를 15% 인상하여 저장하세요.
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

-- emp3_7 에 151번 사원의 직무를 'ST_CLERK' 로 변경되었다면 emp3_8 의 커미션을 0.6 으로 변경해라
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







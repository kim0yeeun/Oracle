--- 11/30

-- 테이블 및 데이터 복사
create table emp3_7
as
select * from employees;
select * from emp3_7;
-- 테이블 구조만 복사
create table emp3_8
as
select * from employees where 1=2;
select * from emp3_8;
-- 데이터를 만들어진 테이블에 복사
insert into emp3_8
select * from employees;
select * from emp3_8;
-- 원하는 데이터만 복사 (일부 컬럼만 복사)
insert into emp3_8 (employee_id,last_name,email,hire_date,job_id,salary)
select employee_id,last_name,email,hire_date,job_id,salary 
from employees;

-- 변수 선언과 초기화
declare
    myname varchar2(20); -- 변수선언
begin
    dbms_output.put_line('MY NAME IS : ' || myname);
    myname := 'John'; -- 값 초기화
    dbms_output.put_line('MY NAME IS : ' || myname);
end;
/

declare
    myname varchar2(20) := 'Rhee'; -- 변수선언과 동시에 초기화 
begin
    dbms_output.put_line('MY NAME IS : ' || myname);
    myname := 'John'; -- 값 변경 
    dbms_output.put_line('MY NAME IS : ' || myname);
end;
/

declare
    myname varchar2(20) := 'Rhee'; 
begin
    dbms_output.put_line('MY NAME IS : ' || myname);
    myname := q'\John's day \';
    -- q \ '  \ -> ' 출력 됨 
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
-- q '[]' 하면 '' 사이의 ' 문자는 모두 출력된다 
-- q '\\'  q'//' 마찬가지

declare
    first_name varchar2(20) := 'Soongmoo';
    last_name varchar2(20) default 'Rhee'; -- default 를 이용해서 변수를 초기화 할 수 있다. 
begin
    dbms_output.put_line(first_name);
    dbms_output.put_line(last_name);
end;
/

-- 바인드 변수
variable emp_salary number
begin
    select salary into :emp_salary
    from employees where employee_id = 107;
end;
/
print emp_salary;
-- 바인드 변수를 사용하면 프로시저가 종료된 후에도 사용이 가능하다.
select * from employees
where salary = :emp_salary;
-- sql develope창에서 안되면 sql plus 켜서 사용하자 
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




--- PL/SQL 레코드 생성
-- 필드 모음을 논리적 단위로 처리한다.
declare
    type emp_record_type is RECORD ( -- 사용자 자료형 
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
    type emp_record_type is RECORD ( -- 사용자 자료형 
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
-- 기본 데이터베이스 열과 데이터 유형
-- select * 문을 사용하여 행을 검색할 때 유용하다.
-- 변수를 일일히 사용하지 않아도 가져올 수 있다. 

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

-- 레코드를 사용하여 테이블의 행 갱신 
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


-- index by table : 행값을 가져오기 위한 테이블 
-- 프로시저는 하나의 행만 가져올 수 있다.
-- 정수 또는 문자열 데이터 유형의 primary key 를 사용한다.
-- binary_integer 및 pls_integer : 크기가 작아야하기 때문에 integer 사용

declare
    type dept_table_type is table of
        departments%rowtype
        -- department에 있는 컬럼을 모두 갖고오겠다. 
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
select count(*) from departments; -- 28개
create table dept3_1
as
select * from departments where 1=2;
select * from dept3_1;


--- 커서 open close
-- BOF : begin of file
-- EOF : end of file
-- cousor 는 select 문 출력할 때 사용 

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
-- 출력값 :  114 Raphaely 
-- 현재 커서가 있는 값만 출력 (처음값)


declare
    cursor emp_cursor is 
        select * from employees where department_id = &deptid;
    emp employees%rowtype;
begin  
    if not emp_cursor%isopen then -- 커서 열려있는지 테스트 
        open emp_cursor;
    end if;
    loop
        fetch emp_cursor into emp;
        exit when emp_cursor%notfound or emp_cursor%rowcount > 10;
        -- %rowcount : 커서가 움직일 때마다 1씩 증가하는 값을 갖는다.
        dbms_output.put_line(emp.first_name|| ' ' ||emp.last_name || ' ' || emp.department_id);
    end loop;
    close emp_cursor;
    -- 커서를 닫지않으면 오류가 발생한다. 
end;
/

-- subquery 를 사용하는 cursor for loop 
-- 커서를 선언할 필요가 없다. 
begin
    for emp_record in (select employee_id, last_name from employees where department_id = 30)
        loop
            dbms_output.put_line(emp_record.employee_id || ' ' || emp_record.last_name);               
        end loop;
end;
/


--- 파라미터가 포함된 커서
declare 
    cursor emp_cursor(deptno number) is 
        select * from employees
        where department_id = deptno;
    emp employees%rowtype;
begin
    open emp_cursor (20); 
    -- 파라미터가 있는 경우 값을 전달해준다. 
    -- 그래서 매번 다르게 값을 주기 때문에 명시적커서를 여러번 열어준다.
    loop
        fetch emp_cursor into emp;
        exit when emp_cursor%notfound;
        dbms_output.put_line(emp.employee_id || ' ' || emp.first_name || ' ' || emp.department_id);   
    end loop;
end;
/

-- 위의 프로시저는 커서를 open 해주었고
-- 아래의 프로시저는 for문에서 자동 오픈하게 만들었따. 
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

--- 문제
-- 파라미터가 있는 커서를 만들 때 부서 번호와 직무를 받도록 하고, 이름, 직무, 부서번호를 출력하세요.
-- 1.open커서 2.for문으로오픈 
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
    
-- 잠금 : 다른 사용자가 이 테이블을 사용할 수 없게 한다.     
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
        -- 현재 커서에 해당하는 행을 업데이트하라는 뜻 
    end loop;
end;
/
select * from emp3_7 where department_id = 10;
    
-- 프로시저는 한 행만 가져오므로 여러개를 가져올 수 없다. -> 오류가 뜨면서 종료됨
-- 종료를 막으려면 exception
declare
    lname varchar2(15);
begin
    select last_name into lname from employees 
    where first_name = 'John';
    dbms_output.put_line(lname);
    exception
    when TOO_MANY_ROWS then
    dbms_output.put_line('행으 수가 너무 많습니다.');
    when NO_DATA_FOUND then
    dbms_output.put_line('데이터가 없습니다.');
    when INVALID_CURSOR or DUP_VAL_ON_INDEX or ZERO_DIVIDE then
    dbms_output.put_line('커서가 정확하지않다. 인덱스가 중복됐다. 0으로 나누지 못한다.');
    when OTHERS then
    dbms_output.put_line('나머지 예외처리');
end;
/

create sequence dept_num
increment by 1
start with 400;


--- 프로시저 및 함수 
-- 함수는 return 값이 있다.

create or replace procedure add_dept
is
    dept_id dept.department_id%TYPE;
    dept_name dept.department_name%TYPE;
begin
    dept_id := 320;
    dept_name := '개발부';
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
    -- in procedure 안으로 값을 받겠다. out procedure 밖으로 값을 내보내겠다.
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
--- 문제 
-- 1.프로시저를 이용해서 emp3_7 에 직원 정보를 입력하세요.
-- 2.jobs_exam 을 만들어서 'AD_PRES' 를 프로시저에 인자값으로 전달하고 
-- 없으면 jobs에서 insert, 있으면 min_salary 는 2000, max_salary 는 6000 으로 update 하세요. 
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

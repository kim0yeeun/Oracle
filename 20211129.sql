--- 11/29
-- PL/SQL 시작 

declare
    v_fname varchar2(20);
    -- 가져온 값을 전달해주기 위해 변수를 만들었다. 
begin
    select first_name
    into v_fname
    from employees
    where employee_id = 100;
    dbms_output.put_line(v_fname);
    -- 변수에 저장된내용을 출력
end;
/
-- 'prosedure입니다' 의 의미


--    emp_hiredate date;
--    -- 변수 선언 
--    vn_num1 number := 1;
--    -- 변수 선언 및 초기화 := 초기값 부여 
--    emp_daptno number(2) not null := 10;
--    c_comm_constant number :=1400;
--    -- 상수 정의 : 값이 변하지 않음 
DECLARE
    vn_num1 number := 1;
    vn_num2 number := 2;
BEGIN
    if vn_num1 >= vn_num2 then 
        dbms_output.put_line (vn_num1 || '이 큰 수 입니다.');
    else 
        dbms_output.put_line (vn_num2 || '이 큰 수 입니다.');
    end if;
END;    
/

DECLARE
    employee_id number(6);      -- 같은 이름의 식별자는 사용하지 않는 것이 좋다.
BEGIN
    select employee_id          -- 같은 테이블이 아닌 다른 테이블인 경우
    into employee_id            -- 제한적으로 사용하는 것이 좋다. 
    from employees
    where last_name = 'Kochhar';
    dbms_output.put_line (employee_id);
END;
/


declare
    num1 number(10,3);
    bf_var BINARY_FLOAT; 
    bd_var BINARY_DOUBLE;
    --binary : 더 정확한 값을 저장하기 위한 것 
    
begin
    num1 := 270/35;
    bf_var := 270/35f;
    bd_var := 140d/0.35;

    dbms_output.put_line ('number = ' || num1);
    dbms_output.put_line ('bf = ' || bf_var);
    dbms_output.put_line ('df = ' || bd_var);
end;
/ 
-- number 데이터 유형에서 저장할 수 있는 값 범위를 벗어난 값을 저장한다. 


--- %type 속성
-- 데이터베이스 열에 정의되어 있는 타입을 사용하거나
-- 선언된 다른 변수의 타입을 사용하기 위한 것 
-- emp_lname employees.last_name%type; 이렇게 정의
-- balance number (7,2); 먼저 정의된 변수의 타입을
-- min.balance balance%type := 1000; 이렇게 사용 

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
    -- 부울타입은 dbout 으로 출력할 수 없다. 
END;
/


--- 바인드 변수 (= host 변수)
-- variable 키워드를 사용해서 생성한다.
-- pl/sql 블록이 실행된 후에도 엑세스 가능하다.
--VARIABLE return_code number
--VARIABLE return_msg varchar2(30)
-- 사용시 앞에 콜론을 사용하여 참조한다. 


VARIABLE emp_salary number
set autoprint on
begin
    select salary
    into :emp_salary -- variable변수  
    -- 바인드 변수를 사용할 때에는 : 을 앞에 붙여야한다. 
    from employees
    where employee_id = 143;
    -- dbms_output.put_line(emp_salary);
    -- emp_salary 가 declare로 선언되어있어야 한다. 는 오류가 뜬다 
end;
--print emp_salary
--select first_name, employee_id from employees
--where salary = :emp_salary;
/


--- 치환변수 
-- 유저 입력을 얻는 데 사용된다.
-- 앞에 앰퍼샌드(&)를 붙여 PL/SQL 블록 내에서 참조
-- 실행중에 얻을 수 있는 값을 직접 코딩하는 것을 피할 수 있다.

VARIABLE emp_salary NUMBER
SET AUTOPRINT ON
DECLARE
    empno NUMBER(6):= &empno; -- 치환변수
BEGIN
SELECT salary INTO :emp_salary 
FROM employees WHERE employee_id = empno; 
END;
/



set verify off
VARIABLE emp_salary number
accept empno prompt '사원번호를 입력하세요. '
set autoprint on
DECLARE
    empno number(6) := &empno; -- 치환변수
BEGIN
    select salary into :emp_salary
    from employees where employee_id = empno;
END;
/
-- 실행할때마다 임의의 값을 입력하고 싶으면 치환변수 사용 


-- declare 안에 declare 사용 가능 예시 
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
    --안에서 선언된 변수는 밖에서 사용할 수 없다. 
    DBMS_OUTPUT.PUT_LINE(outer_variable);
END;
/

-- 같은 이름의 변수가 외부,내부에 하나씩 선언되어있다면?
declare
    fname varchar2(20) := 'Patrick';
    hdate date := '2000-01-01';
begin
    declare 
        lname varchar2(20) := 'Mike';
        hdate date := '2001-12-25';
        -- 같은 이름의 변수를 내부에 하나 더 선언
    begin
        DBMS_OUTPUT.PUT_LINE(lname);
        DBMS_OUTPUT.PUT_LINE(hdate); -- 안
        -- 같은 이름의 변수가 선언되어 있을 경우 안에 있는 게 먼저 출력 
        DBMS_OUTPUT.PUT_LINE(fname);
    end;
    DBMS_OUTPUT.PUT_LINE(hdate);     -- 밖
end;
/
    
--- begin<<outer>> end outer 를적어주는 이유: 변수명이 같은 것들이 존재한다. 
-- 식별자를 명확하게 하기 위해서 적어준다. 
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



--- pl/sql 내에서도 그룹함수를 사용할 수 있다. 
set serveroutput on
declare
    sum_sal number (10,2);
    deptno number not null:= 60;
begin
    select sum(salary)  -- group function
    into sum_sal from employees
    where department_id = deptno;
    dbms_output.put_line('60부서의 급여의 합계값은 ' || sum_sal);
end;
/


-- 이름을 달리 하는 이유 : 모호성 방지 
-- 사용자가 사용하고자 하는 변수나 컬럼이 무엇인지 모른다. 
-- 데이터베이스의 열 이름을 식별자로 사용하지 않는 것이 좋다. 
-- 로컬 변수와 형식 파라미터의 이름은 데이터베이스 테이블의 이름보다 우선합니다.
-- 데이터베이스 테이블 열의 이름은 로컬 변수의 이름보다 우선합니다.
-- 책 113p

declare 
    hire_date employees.hire_date%type;
    sysdate hire_date%type;
    employee_id employees.employee_id%type := 176;
begin
    -- ORA-00904: "EMPLOYEEID": 부적합한 식별자
    -- 컬럼명과 변수명이 같으면 오류가 발생한다. 
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

accept fname prompt '사원 이름을 입력하세요. '
accept lname prompt '사원 성을 입력하세요. '
accept mail prompt '사원 이메일을 입력하세요. '
accept hdate prompt '사원 입사일을 yyyy-mm-dd 형식으로 입력하세요. '
accept jid prompt '사원 업무를 입력하세요. '
accept sal prompt '사원 급여를 입력하세요. '

declare
    fname employee.first_name%TYPE := &fname; -- 치환변수
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
    dbms_output.put_line('ST_CLERK 의 데이터가 갱신되었습니다.');
end;
/

declare
    empid employees.employee_id%type := 1;
begin
    delete from emp
    where employee_id = empid;
    dbms_output.put_line('1번 사원의 데이터가 삭제되었습니다.');
end;
/

declare
    empid employees.employee_id%type := 3;
begin
    delete from emp
    where employee_id = empid;
    dbms_output.put_line(empid||'번 사원의 데이터가 삭제되었습니다.');
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


-- 조건 if문
declare
    myage number := 31;
begin
    if myage < 11
    then 
        dbms_output.put_line ('저는 11살 미만입니다.');
    else 
        dbms_output.put_line ('저의 나이는 ' || myage || '살 입니다');
    end if;
end;
/


-- 급여를 1000 으로 나눈 몫이 3 이하면 사원, 5 이하는 주임, 7이하 대리,
-- 9이하 과장, 10이하 차장 13이하 부장 15이하 본부장 그 외엔 이사로 출력 130번 사원에 대해 출력 

declare 
    sal number;
    empid employees.employee_id%type := 130;
begin
    select trunc(salary/1000)
    into sal 
    from employees
    where employee_id = empid;
    if sal <= 3 then
        dbms_output.put_line ('사원');
    elsif sal <= 5 then
        dbms_output.put_line ('주임');
    elsif sal <= 7 then
        dbms_output.put_line ('대리');
    elsif sal <= 9 then
        dbms_output.put_line ('과장');
    elsif sal <= 10 then
        dbms_output.put_line ('차장');
    elsif sal <= 13 then
        dbms_output.put_line ('부장');
    elsif sal <= 15 then
        dbms_output.put_line ('본부장');
    else 
        dbms_output.put_line ('이사');
    end if;
end;
/


-- case식으로 작성
declare 
    empid employees.employee_id%type := 130;
    grade varchar2(20);
begin
    select 
    case when trunc(salary/1000) <= 3 then '사원'
        when trunc(salary/1000) between 4 and 5 then '주임'
        when trunc(salary/1000) <= 7 then '대리'
        when trunc(salary/1000) <= 9 then '과장'
        when trunc(salary/1000) <= 10 then '차장'
        when trunc(salary/1000) <= 13 then '부장'
        when trunc(salary/1000) <= 15 then '본부장'
        else '이사' end
    into grade from emp where employee_id = empid;
    dbms_output.put_line('직원의 직책은 ' || grade);
end;
/

-- case문으로 작성
-- grade 에 문자입력 
declare
    grade char(1) := upper('&grade');
    result1 varchar2(30);
begin
    result1 :=
    case grade
        when 'A' then '90점 이상입니다.'
        when 'B' then '80점 이상입니다.'
        when 'C' then '70점 이상입니다.'
        when 'D' then '60점 이상입니다.'
        when 'F' then '60점 미만입니다.'
    end;
    dbms_output.put_line ('grade : ' || grade || ' 일 때' || result1);
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
    /*case 로 변경하세요*/
    result1 :=
    case when sal <= 3 then '사원'
        when sal <= 5 then '주임'
        when sal <= 7 then '대리'
        when sal <= 9 then '과장'
        when sal <= 10 then '차장'
        when sal <= 13 then '부장'
        when sal <= 15 then '본부장'
        else '이사' end;
    dbms_output.put_line('직원의 직책은 ' || result1 || '입니다.');
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
    
-- 부서장 번호를 입력받아서 부서장의 부서번호와 부서이름과 사원수를 가져오세요.
-- 108 사원 부서장의 부서는 90번이고 부서명은 영업부, 사원수는 20명이다.
select * from departments where manager_id is not null; -- test 제외한 11명
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
    DBMS_OUTPUT.PUT_LINE (mngid ||'사원 부서장의 부서는 '|| deptid|| '번이고 부서명은 '
    || deptname ||' 이며 사원수는 ' ||emps|| ' 입니다.');
end;
/   


-- 기본 loof 반복문
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
        -- 탈출하기 위한 조건을 꼭 주어야한다. 안그러면 무한루프에 빠진다. 
    END loop;
end;
/

select * from ex3_6;
delete from ex3_6;
commit;


-- while 반복문 (조건이 있을 때 사용)
-- EXIT 가 따로 필요하지 않다. 
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


-- for 반복문
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

-- 구구단 만들기

begin -- 중첩 루프
    <<outer_loop>> --레이블 
    for i in 1..9 loop
        <<inner_loop>> 
        for j in 1..9 loop
            dbms_output.put_line(i || '*' || j || '=' || j*j);
        end loop;
    end loop;
    end;
/




---  숙제 
-- 1.  d
-- 2. "Hello World"를 출력하는 간단한 익명 블록을 생성하여 실행
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
    --new_locn := 'Western ' || new_locn; -- Western 잉 없는뎅? 
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
    dbms_output.put_line(SQL%ROWCOUNT || ' 개의 행이 변경되었습니다.');
    -- 몇 개의 데이터가 적용됐는지 행 수를 출력한다. 
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
            












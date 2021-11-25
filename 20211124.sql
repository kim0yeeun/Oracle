--- 11/24 
-- 1. 성이 Abel인 사원의 직무를 출력하세요.
select job_id from employees where last_name='Abel';

-- 2. 성이 Abel인 사원과 같은 직무를 하는 사원들을 출력하시오.
select * from employees
where job_id = 'SA_REP';
--- 서브 쿼리가 메인 쿼리보다 먼저 실행이 된다.
--- 서브쿼리는 소괄호 안에 있어야 한다.
select * from employees
where job_id = (select job_id from employees where last_name='Abel');

-- 3. 106번인 사원의 급여를 구하세요.
select salary from employees where employee_id = 106;

-- 4. 106번인 사원과 같은 급여를 받는 사원들은?
select * from employees where salary = 4800;

select * from employees where salary = 
        (select salary from employees where employee_id = 106);
        
-- 5. 성이 Austin이라는 사원과 같이 일하는 사원들을 구하시오.
select * from employees 
where department_id =
	(select department_id from employees where last_name = 'Austin') ;
    
--- 6. 141번의 직무를 출력하시오.
select job_id from employees where employee_id = 141;--ST_CLERK
--     143번의 급여를 출력하시오.
select salary from employees where employee_id = 143;--2600 

-- 7. 141번의 직무와 같고 143번의 급여와 같은 사원들은?
--즉, 직무가 ST_CLERK이고 급여가 2600 인사원을 구하시오.
select * from employees
where job_id = 'ST_CLERK'
and salary = 2600;

select * from employees
where job_id = 
    (select job_id from employees where employee_id = 141)
and salary = 
    (select salary from employees where employee_id = 143);

-- 8. 최저 급여를 받는 사원을 구하시오.
select min(salary) from employees;
select * from employees
where salary = (select min(salary) from employees); 

-- 9. 90인부서의 평균 급여보다 많은 급여를 받는 사원을 구하시오.
select avg(salary) from employees where department_id = 90;

select * from employees
where salary > 
    (select avg(salary) from employees where department_id = 90);

-- 10. 입사일이 178번보다 늦게 입사한 사원을 구하시오.
select hire_date from employees where employee_id = 178;

select * from employees
where hire_date > 
    (select hire_date from employees where employee_id = 178);

-- 11.50인 부서의 평균 급여
select avg(salary) from employees
where department_id = 50;

-- 12. 각 부서의 평균 급여가 3475보다 큰 부서는?
select department_id, avg(salary)
from employees
group by department_id
having avg(salary) > 3475;

-- 13. 50인 부서의 평균 급여보다 평균급여가 많은 부서를 구하시오.
select department_id, avg(salary)
from employees
group by department_id
having avg(salary) > 
    (select avg(salary) from employees
     where department_id = 50);

-- 14.  60인 부서의 최저 급여보다 더 적은 급여를 받는 사원은
select min(salary) from employees where department_id = 60;
select * from employees 
where salary < 
    (select min(salary) from employees where department_id = 60);

-- 15. 50, 60, 70 인 부서의 최저 금액과 같은 급여 받는 사원들은?
select * from employees
where salary in (select min(salary) from employees
                 where department_id in (50,60,70)
                 group by department_id);


-- 16. 각 부서의 최저 금액을 구하고 그 최저 금액에 해당 되는 모든 사원들을 출력하시오.
select * from employees
where salary in (
    select min(salary) from employees
    group by department_id);
    
-- 17. 평균 급여가 가장 적은 업무를 찾으세요.
select job_id, avg(salary)
from employees
group by job_id
having avg(salary) = (select min(avg(salary)) from employees
                      group by job_id);

-- 18. 50인 부서의 급여를 출력하세요.
select salary from employees where department_id = 50
order by salary;
               |---------------------------------------->
      ---------|------------------------|------
             2100                     8200
-- 19. 50인 부서의 사원들의 급여 중 최저 금액보다 더 많이 받는 사원들을 찾으세요.
;--   작은 것 보다 크다.
select * from employees where salary > 2100;
select * from employees 
where salary >  (select min(salary) from employees
                    where department_id = 50);
select * from employees 
where salary > any (select salary from employees
                    where department_id = 50);
-- 20. 50인 부서의 사원들이 받는 급여 중 제일 많이 받는 급여보다 적은 급여를 받는 
--     사원들을 찾으세요.
select * from employees 
where salary < ( select max(salary) from employees
                  where department_id = 50);
select * from employees --- 큰것보다 작다.
where salary < any( select salary from employees
                  where department_id = 50);

-- 21. 90인부서의 급여중 제일 작은 급여보다 적은 급여를 받는 사원들을 구하시오.
select * from employees
where salary < (select min(salary) from employees
                where department_id = 90);
select * from employees
where salary < all(select salary from employees
                where department_id = 90);
-- 22. 50인부서의 급여중 제일 많은 급여보다 더 많은 급여를 받는 사원들을 구하시오.
select * from employees
where salary > (select max(salary) from employees
                where department_id = 50);

select * from employees
where salary > all(select salary from employees
                where department_id = 50);

--- 23. 30인 부서의 사원들이 받는 급여와 같은 급여를 받는 사원들을 찾으세요.
select salary from employees where department_id = 30;
select * from employees 
where salary in (select salary from employees where department_id = 30);

select * from employees 
where salary = any (select salary from employees where department_id = 30);


select * from testa;
select max(a1) + 1 from testa;
insert into testa values((select max(a1) + 1 from testa), 3);

-- 집합연산자 (set : union, intersect, minus)
--                 합집합  교집합
--select user_id 
--from employees
--where user_id = 'highland0'
--union
--select user_id
--from member
--where user_id = 'highland0'

-- 24. 사원 테이블에서 108번인 상사 출력
select manager_id from employees where employee_id = 108;
--    부서 테이블에서 80인 부서의 부서장을 출력
select manager_id from departments where department_id = 80;
-- 108번의 상사와 80 부서의 부서장을 출력하라.
select manager_id from employees where employee_id = 108
union 
select manager_id from departments where department_id = 80;

-- 25. 사원테이블에 사원번호와 직무를 출력
select employee_id, job_id from employees; --- 107
    -- 직무연역 테이블에서 사원번호와 직무를 출력
select employee_id, job_id from job_history; -- 10
--   사원테이블에 사원번호, 직무 그리고 직무연역 테이블에서 사원번호와 직무를 출력
select employee_id, job_id from employees
union
select employee_id, job_id from job_history; -- 115

select employee_id, job_id from employees
union all
select employee_id, job_id from job_history;  -- 117


-- 26. 사원 테이블에 있는 직속 상사와 직무 그리고 직무영역 테이블의 직원번호와 직무를 출력하세요.
select manager_id, job_id from employees
union
select employee_id, job_id from job_history;
-- 컬럼의 이름은 같지 않아도 된다. 

-- 27. 사원테이블에서는 이름, 급여를 출력하고 부서 테이블에서는 부서명과 부서장을 출력
-- 각 열의 데이터타입이 일치하면 된다.
-- heading name은 첫 번째 테이블의 열이름이다.
--      문자                  숫자
select first_name,          salary           from employees
union
select department_name,     manager_id       from departments;
-- 28. 첫번째 테이블의 열이름에 별칭추가
-- 별칭이 heading name에 적용된다. 
select first_name,          salary mng       from employees
union
select department_name,     manager_id       from departments;

-- 29. 사원테이블에서는 급여와 부서번호를 출력하고 부서테이블에서는 부서장과 부서이름을 출력하세요.
-- ORA-01790:대응하는 식과 같은 데이터 유형이어야 합니다. 열의 데이터 타입이 일치해야한다. 
--      숫자          숫자
select salary,     department_id from employees
union 
--      숫자          문자
select manager_id, department_name from departments;
---------------------------------------------
-- 열의 타입을 맞춰서 사용
select    salary,        department_id,     to_char(null) from employees
union 
select manager_id,       to_number(null), department_name from departments;

-- 31. 사원테이블에서 부서번호, 입사일, 그리고 부서테이블에서 부서번호, 지역번호 출력
select department_id, hire_date h_date,     to_number(null) l_id from employees
union
select department_id, to_date(null),        location_id     from departments;

-- 32. 부서테이블에는 존재하지 않는 직원테이블에만 존재하는 상사, 부서장이 아닌 관리자를 출력하세요.
select manager_id from employees
where manager_id not in (select manager_id) ;

select manager_id from employees
minus -- 차집합
select manager_id from departments;

-- 부서장인 상사를 출력하세요.
select manager_id from employees
intersect -- 교집합
select manager_id from departments;


--------------- 여기까지가 기본 select 문 ---------------
----- DML (date manipulation language) : insert, delete, update
----- 확장 DML : select, insert, delete, update
create table aa1 (
    a1 number primary key,
    a2 number
);
insert into aa1 values(1,1);

create table bb1 (
    a1 number references aa1(a1),
    b1 number 
);

insert into bb1 values (1,11);
select * from bb1;
--drop table bb1;
--drop table aa1;
delete from aa1 where a1 = 1; -- ORA-00001: 무결성 제약 조건(KOSA.SYS_C008484)에 위배됩니다

delete from bb1 where a1 = 1; -- 참조한 테이블의 a1을 먼저 삭제하고
delete from aa1 where a1 = 1; -- 삭제해야한다. 

-- 부모삭제시  1. 자식 데이터 남기기
--            2. 자식 데이터 삭제
create table aa2(
    a1 number primary key,
    a2 number    
);
insert into aa2 values (1,1);
select * from aa2;
create table bb2( -- 부모가 삭제되어도 자식은 null값으로 남도록 만듬
    a1 number references aa2(a1) on delete set null,
    b1 number 
);
insert into bb2 values (1,11);
select * from bb2;
create table cc2( -- 부모가 삭제되면 자식도 같이 삭제되도록 만듬
    a1 number references aa2(a1) on delete cascade,
    c1 number
);
insert into cc2 values (1,22);
select * from cc2;

insert into aa2 values (2,2);
insert into bb2 values (2,111);
insert into cc2 values (2,222);
select * from aa2;
select * from bb2;
select * from cc2;
delete from aa2;

create table aa3 (
    a1 number,
    a2 number
);
alter table aa3
add constraint aa3_a1_PK primary key (a1);
create table bb3 (
    a1 number,
    b1 number
);
alter table bb3
add constraint bb3_a1_FK foreign key (a1)
    references aa3(a1) on delete set null;
create table cc3 (
    a1 number,
    c1 number
);
alter table cc3
add constraint cc3_a1_FK foreign key (a1)
    references aa3(a1) on delete cascade;

create table dd3 ( -- 자식이 있으면 부모를 삭제할 수 없다. 
    a1 number,
    d1 number
);
alter table dd3
add constraint dd3_a1_FK foreign key (a1)
    references aa3(a1);



--- table copy
-- 테이블 카피시, () 쓰면 안된다.
-- 테이블 카피시 null을 제외한 제약조건은 포함되지 않는다. (기본키, 외래키 등)
create table emp
as 
select * from employees;
select * from emp;
select * from user_constraints where table_name = 'EMP';
select * from user_constraints where table_name = 'EMPLOYEES';

-- 33. 100번 사원을 삭제하세요.
delete from emp
where employee_id = 100;
select * from emp where employee_id = 100;

-- 34. 업무가 IT_PROG 인 사원들을 삭제하세요.
select * from emp where job_id = 'IT_PROG';
delete from emp where job_id = 'IT_PROG';

-- 35. Neena 와 같은 급여를 받는 사원을 삭제하세요.
select * from emp where salary = (select salary from emp where first_name = 'Neena');
delete from emp where salary = (select salary from emp where first_name = 'Neena');

-- 잘못 삭제했을 경우 rollback; 
-- rollback : 지금까지 한 DML작업이 모두 취소된다.
-- commit : 지금까지 한 DML작업을 마무리하게 된다. 

rollback;
commit;
-- 자동 commit이 되는 경우 DDL (create, alter, drop) 문을 사용한 경우
-- 작업 창을 닫는 경우 

create table dept
as
select * from departments;
select * from dept;

select * from user_constraints where table_name = 'DEPT';
select * from user_constraints where table_name = 'DEPARTMENTS';

-- 36. 부서명에 public 이 포함된 부서의 사원들을 모두 삭제하세요.
select * from dept where department_name like '%Public%';
delete from emp where department_id in(
                select department_id from dept where department_name like '%Public%'
                );
select * from emp where department_id in(
                  select department_id from dept where department_name like '%Public%'
                  );

--- truncate 자르기 
truncate table emp;
select * from emp;
rollback;


-- 37. 데이터 복사
insert into emp
select * from employees;

select * from emp;
commit;
-- rollback 해도 날라가지 않는다.



--- update
-- 38. emp 에서 60번 부서의 사원들을 출력하고 그 부서를 120번 부서로 변경하세요.
select * from emp where department_id = 60;
update emp
set department_id = 120
where department_id = 60;
select * from emp where department_id = 120;
-- 120 부서를 60 부서로 다시 변경
update emp
set department_id = 60
where department_id = 120;

-- 39. 사원 번호가 113인 사원의 부서를 70 부서로 변경하세요.
select * from emp where employee_id = 113;
update emp
set department_id = 70
where employee_id = 113;

-- where조건절이 없으면 전체가 다 바뀌어버린다. 
update emp 
set department_id = 130;
select * from emp;
rollback;

-- 40. 205번 사원의 직무를 출력 / 205번 사원의 급여를 출력
select job_id from emp where employee_id = 205;
select salary from emp where employee_id = 205;
-- 이 때 114번의 직무와 급여를 205번의 직무와 급여로 변경하세요 PU_MAN , 11000 -> AC_MGR , 12008
select job_id from emp where employee_id = 114;
select salary from emp where employee_id = 114;

update emp
set job_id =  -- 서브 쿼리를 쓸 떄에는 꼭 중괄호를 넣는다 
        (select job_id from emp where employee_id = 205),
    salary = 
        (select salary from emp where employee_id = 205)
where employee_id = 114;

-- 41.  200번 사원의 직무와 140번 사원의 직속상사를 130번 사원에 적용시키세요
select job_id from emp where employee_id = 200;             -- AD_ASST
select manager_id from emp where employee_id = 140;         -- 123
select job_id from emp where employee_id = 130;             -- ST_CLERK
select manager_id from emp where employee_id = 130;         -- 121
update emp
set job_id = (select job_id from emp where employee_id = 200),
    manager_id = (select manager_id from emp where employee_id = 140)
where employee_id = 130;

rollback;

-- 42. employees 테이블에 있는 100번 사원의 급여와 114번 사원의 직무를 emp 테이블에 있는 130번 사원에 적용시키세요.
select salary from employees where employee_id = 100; -- 24000
select job_id from employees where employee_id = 114; -- PU_MAN
select salary, job_id from emp where employee_id = 130; -- 2800, ST_CLERK
update emp
set salary = (select salary from employees where employee_id = 100),
    job_id = (select job_id from employees where employee_id = 114)
where employee_id = 130;

-- 43. 200번 사원이 가진 직무와 같은 사원들의 부서를 사원번호가 114인 부서로 변경하세요.
select* from emp;
update emp
set department_id = (select department_id from emp where employee_id =114)
where job_id = (select job_id from emp where employee_id = 200);

-- 44. 114 번의 직무와 급여를 205번 사원과 같게 변경하세요.
select job_id, salary from employees where employee_id = 114; -- PU_MAN , 11000
select job_id, salary from employees where employee_id = 205; -- AC_MGR , 12008
update emp
set job_id = (select job_id from emp where employee_id = 205),
    salary = (select salary from emp where employee_id = 205)
where employee_id = 114;

-- 45. 부서명에 대소문자 구분 없이 pu 가 포함되어 있는 부서의 직원들을 120번 사원의 급여로 변경하세요.
select salary from employees where employee_id = 120; -- 8000
select * from dept where lower(department_name )like '%pu%'; -- 
--몇개여ㅑ,,,, 7개래,,,
--select employee_id from emp
--where department_id in (select * from dept where lower(department_name )like '%pu%');

update emp
set salary = (select salary from emp where employee_id = 120)
where department_id in ( 
                    select department_id from dept
                    where lower(department_name) like '%pu%'
                    );

rollback;

---- insert, select, update, delete
---- C       S       U       D :  CRUD : DML 

insert into (select employee_id, first_name, last_name, hire_date, salary, department_id,
                    email, job_id
             from emp
             where department_id = 50) -- 50인 부서만 insert : where 조건문 
values (300,'SoongMoo','Rhee',sysdate,15000,10,'highland0','AP');

select *from emp;

-- 50인 부서만 insert 하려면 조건문을 where절로 달아준다. 여기서 check 옵션을 확인하면 위배됨을 알수 있따. 
--where department_id = 50 with check option
--ORA-01402: 뷰의 WITH CHECK OPTION의 조건에 위배 됩니다

----- DML 문 끝 -----
-- DML : insert, select, update, delete
-- DDL : create, alter, drop
-- Data Definition Language
-- TCL : rollback, commit, savepoint
-- DCL : grant, revoke, 
-- grant resource, connect, dba to KOSA;
-- revoke resource, connect, dba from KOSA;

rollback;

select * from emp;                  -- 107개존재
delete from emp 
where job_id like '%REP%';          -- 33개 삭제
select * from emp;                  -- 74개 존재
savepoint a; -------------------------------------------------------

delete from emp 
where department_id = 90;           -- 3개 삭제
select * from emp;                  -- 71개 존재
savepoint b; -------------------------------------------------------

delete from emp;                    -- 71개 삭제
select * from emp;                  -- 0개 존재
rollback to b;
select * from emp;

--------- TCL 끝 -----------
--- view object
-- 복잡한 쿼리문일 경우에 뷰를 통해서 단순하게 사용할 수 있다.
-- 실제 테이블이 아니라, 테이블의 일부를 보여준다. 실제 데이터가 아니라 테이블의 데이터를 보여준다.


-- 46. 사원번호, 이름, 이메일, 입사일, 급여, 커미션, 커미션을 포함한 연봉을 출력하는데 null은 0으로 적용
-- 대소문자 구분 없이 부서이름이 'pu' 가 포함된 부서의 사원
select employee_id, first_name, email, hire_date, salary, commission_pct,
       salary*(1+nvl(commission_pct,0))*12 yearsal
from emp
where department_id in (
                    select department_id from dept where lower(department_name) like '%pu%'
                    );
-- 46번을 view로 작성 
create view vw_pu
as
select employee_id, first_name, email, hire_date, salary, commission_pct,
       salary*(1+nvl(commission_pct,0))*12 yearsal
from emp
where department_id in (
                    select department_id from dept where lower(department_name) like '%pu%'
                    );

select * from vw_pu;

-- 48. 90번 부서를 출력하세요. 이름, 전화번호, 부서번호, 사원번호 
select first_name, phone_number, department_id, employee_id from employees where department_id = 90;

create view vw_90
as
select first_name, phone_number, department_id, employee_id
from employees
where department_id = 90;

select * from vw_90;




--- 숙제 
-- 1. ANSI-JOIN을 사용해서 사원번호, 이름, 부서번호, 위치를 출력하는데 상사가 149인 사원들만 출력하시오.
select employee_id, first_name, e.department_id, location_id
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 149;

-- 2. 직무에 4번째에서 6번째까지 PRO가 있다면 it_program으로 출력
-- ACC 가 있다면 finance_account 나머지는 business 로 출력하시오.
select replace (job_id,job_id,'IT_PROGRAM') from employees
where substr(job_id,4,3) = 'PRO';

select employee_id,first_name,
case when job_id like '%PRO%' then 'it_program'
     when job_id like '%ACC%' then 'finance_account'
     else 'business' end job_
from employees;

select case substr(job_id , 4,3) when 'PRO' then 'it_program'
                                 when 'ACC' then 'finance_account'
                                 else 'business' end job
from employees; -- 답

-- 3. 직무에 REP가 포함되어 있는 사원들의 평균 급여와 최소급여 최대급여 급여의 합계를 구하시오.
select avg(salary), sum(salary), min(salary), max(salary) 
from employees
where job_id like '%REP%';

-- 5.  부서별 최대 급여가 10000이상인 부서만 출력하시오.
select department_id, max(salary)
from employees
group by department_id
having max(salary) >=10000;

-- 6. 직무에 'SA'포함하고 있지 않은 사원들중 직무별 급여의 합계가 10000을 초과하는 직무와 급여의 합계를 출력하시오.
-- 또한 급여의 합계를 내림차순으로 정렬하여 출력
select job_id, sum(salary)
from employees
where job_id not like '%SA%'
group by job_id 
having sum(salary) > 10000
order by sum(salary) desc ;

-- 7. 부서가 20이거나 50인 부서의 사원번호와 부서번호 및 부서명 그리고 위치정보를 출력하시오.
select employee_id, d.department_id, department_name, location_id
from employees e, departments d
where e.department_id = d.department_id and d.department_id in (20,50);

-- 8. Matos라는 성을 가지고 있는 사원이 있다. 이 사원의 부서정보와 사원번호 그리고 성을 출력하시오.
select e.department_id, department_name, e.manager_id, location_id, employee_id, last_name
from employees e, departments d
where e.department_id = d.department_id and last_name = 'Matos';

-- 9. Matos라는 성을 가지고 있는 사원과 King라는 성을 가진 사원의 부서정보와 사원번호 그리고 성을 출력하시오.
select e.department_id, department_name, e.manager_id, location_id, employee_id, last_name
from employees e join departments d
on e.department_id = d.department_id
where last_name = 'Matos' or last_name = 'King';

-- 10. King라는 성을 가지고 있는 사원의 부서정보와 사원번호 그리고 성을 출력하시오. ANSI-JOIN을 사용할 것
select e.department_id, department_name, e.manager_id, location_id, employee_id, last_name
from employees e join departments d
on e.department_id = d.department_id
where last_name = 'King';

-- 12. 부서테이블에서 부서번호와 부서명 그리고 지역코드와 지역명을 출력하는데 지역코드가 1400인 지역만 출력 T-SQL, ANSI JOIN
--없음
select department_id , department_name, d.location_id, STREET_ADDRESS
from hr.departments d , hr.locations l
where d.location_id = l.location_id and d.location_id = 1400;

select department_id , department_name, d.location_id, STREET_ADDRESS
from hr.departments d join hr.locations l
on d.location_id = l.location_id and d.location_id = 1400; -- 답 

-- 14. 직원의 정보를 출력할 때 부서정보와 그 부서의 주소를 출력하시오.
-- 주소가 어딨떠
select employee_id, first_name , 
       d.department_id, department_name,
       l.location_id, STREET_ADDRESS
from hr.employees e, hr.departments d, HR.locations l
where e.department_id = d.department_id 
and d.location_id = l.location_id; -- 답 

-- 15. 직원정보를 출력할 때 그 직원의 부서정보와 직무내용을 출력하시오. 부서번호, 부서명, 직무번호, 직무내용
select * from jobs;
select department_id, department_name, job_id, job_title
from jobs j, departments d;
      
-- 16. 사원정보와 부서정보를 출력할 때 사원이 없는 부서도 출력하되 200번 부서부터 260부서를 제외하고 출력하시오.
???
select employee_id, first_name, d.department_id , department_name
from employees e left outer join departments d
on e.department_id = d.department_id; -- 답 

-- 17. 사원정보와 부서정보를 출력할 때 사원이 없는 부서도 출력하새요.
select employee_id, first_name, e.department_id, department_name
from employees e join departments d
on d.department_id = e.department_id;

-- 18. 직원의 직원정보와 직무내역을 출력하는 직무내역이 없는 직원도 출력하시오. job_history도 이용
select h.employee_id,e.first_name,h.job_id,j.job_title
from employees e join jobs j
on e.job_id = j.job_id right outer join job_history h 
on j.job_id = h.job_id;
-- 모루갣떠ㅓ어떠떠떠

-- 19. 직무에 4번째에서 6번째까지 PRO가 있다면 it_program으로 출력
--                             ACC가 있다면 finance_account
--                             나머지는 business로 출력하시오.
select employee_id,first_name,
case when job_id like '%PRO%' then 'it_program'
     when job_id like '%ACC%' then 'finance_account'
     else 'business' end job_
from employees;


-- 20. 급여가 15000 이상이면 임원으로 출력
--           10000 이상이면 부장
--           7000  이상이면 과장
--           5000이상이면 대리, 나머지는 사원으로 출력하시오.
select employee_id, first_name,
case when salary >= 15000 then '임원'
     when salary >= 10000 then '부장'
     when salary >= 7000 then '과장'
     when salary >= 5000 then '대리'
     else '사원' end rank
from employees;
     

-- 21. 부서별 급여의 평균이 5000이상인 부서만 출력하시오.
select department_id
from employees
group by department_id
having avg(salary) >= 5000;

-- 22. 급여가 10000이상인 사원들중 부서별 급여 평균이 16000이상인 부서만 출력하시오
select department_id
from employees
where salary >= 10000
group by department_id
having avg(salary) >= 16000;

-- 23. 입사일이 2005년도 이전에 입사한 사람들 중 부서별 최대급여가 8000이상인 부서와 최대 급여를 출력하시오.
select department_id, max(salary)
from employees
--where hire_date < '050101'
where to_char(hire_date, 'yyyy') < '2005' -- 답 
group by department_id
having max(salary) >= 8000;

-- 24. 부서별 최대 급여가 10000이상인 부서만 출력하시오.
select department_id, max(salary)
from employees
group by department_id
having max(salary) >= 10000;

-- 25. 직무에 'REP'포함하고 있지 않은 사원들중 직무별 급여의 합계가 3000을 초과하는 직무와 급여의 합계를 출력하시오.
-- 또한 급여의 합계를 내림차순으로 정렬하여 출력
select job_id , sum(salary) from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) > 3000
order by sum(salary) desc ;

-- 26.  직원의 25-10-2020까지의 근무일수를 계산하시오. 직원번호, 부서번호, 입사일, 근무일수
select employee_id, department_id, hire_date, '25-10-2020'-hire_date
from employees;

-- 27. '01-01-2005'에 입사한 사원을 출력하시오. 직원번호, 부서번호, 입사일, 근무일수
select employee_id, department_id, hire_date, sysdate-hire_date
from employees
where hire_date = '050101';

-- 28. 연봉(급여*12) : 급여는 커미션까지 포함된다. 직원의 년봉을 구하시오. 직원번호, 부서번호, 급여, 년봉
select employee_id, department_id, salary, salary * (1+nvl(commission_pct,0)) * 12 yearsal
from employees;

-- 29.  'IT_PROG' 이면 급여를  1.10*salary
--      'ST_CLERK' 이면 급여를  1.15*salary
--      'SA_REP' 이면  급여를 1.20*salary
--      나머지 직무는 salary 로 급여를 지불하고 heading name을      "REVISED_SALARY"가 되게 하시오.
--      case와 decode를 모두 사용하시오.
select employee_id,
case salary when job_id = 'IT_PROG' then 1.10*salary
            when job_id = 'ST_CLERK' then 1.15*salary
            when job_id = 'SA_REP' then 1.20*salary
            else salary end REVISED_SALARY
from employees;

select decode ( job_id , 'IT_PROG' , 1.10*salary
                       , 'ST_CLERK', 1.15*salary
                       ,  'SA_REP' , 1.20*salary
                       , salary) "REVISED_SALARY"
from employees;


-- 30 커미션을 포함한 급여의 평균을 구하시오. 커미션을 받지 않은 직원도 포함
select avg(salary * (1+nvl(commission_pct,0)))
from employees;

-- 31. 각부서별 커미션을 포함한 급여의 합계를 구하시오.
select department_id, sum(salary * (1+nvl(commission_pct,0)))
from employees
group by department_id;

-- 32. 각 부서의 직원수가 5명 이상인 부서만 출력하시오. (join아님)
select department_id, count(*)
from employees
group by department_id
having count(*) >= 5;

-- 33. 각 부서에 있는 사원의 직무별 급여의 평균을 구하시오.
select avg(salary)
from employees
group by job_id;

-- 34. 사원번호, 이름 , 급여, 입사일 , 부서번호, 부서명, 직무번호, 직무명을 출력할 때 담당하지 않는 직무도 출력하고 사원이 없는 직무도 출력하시오.
select employee_id, first_name, salary, hire_date, d.department_id, department_name, j.job_id,job_title
from departments d join employees e
on d.department_id = e.department_id  right outer join jobs j
on j.job_id = e.job_id;

-- 35. 사원테이블에서 직무에 MAN를 포함하고 급여가 10000이상인 사원을 사원번호와 성과 직무 그리고 급여를 출력하시오.
select employee_id,last_name, job_id, salary 
from employees
where job_id like '%MAN%' and salary>= 10000;

-- 36. 직무가 SA_RE 와 AD_PRES 이면서 급여가 15000을 초과하는 사원을 출력하시오. 단, 성, 직무, 급여만 출력 or와 and만 사용
select employee_id,last_name, job_id, salary 
from employees
where (job_id = 'SA_RE' or job_id = 'AD_PRES') and salary > 15000;

-- 37. 위 예제에 in연산자를 사용하시오.
select last_name, job_id, salary 
from employees
where job_id in ('SA_RE','AD_PRES') and salary > 15000;

-- 38. 부서는 내림차순으로 정렬하고 입사일도 내림차순으로 정렬 부서번호 , 급여, 입사일, 성
select department_id, salary, hire_date, last_name
from employees
order by department_id desc, hire_date desc; 

-- 39. 부서는 내림차순으로 정렬하고 입사일은 오름차순으로 정렬하여 출력 부서번호 , 급여, 입사일, 성
select department_id, salary, hire_date, last_name
from employees
order by department_id desc, hire_date asc; 

-- 40. 부서는 내림차순으로 정렬하고 입사일은 오름차순으로 정렬하여 급여를 내림차순으로 정렬하여 출력. 부서번호 ,  입사일, 급여, 성
select department_id, salary, hire_date, last_name
from employees
order by department_id desc, hire_date asc, salary desc; 


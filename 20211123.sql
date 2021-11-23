
--- 11/23
-- 1. concat
-- 2. nvl_1
select last_name, first_name, job_id, salary,(salary+salary*nvl(commission_pct,0))*12 year_sal
from employees;

-- 3. nvl_2
select last_name, first_name, job_id, salary,
       nvl2 (commission_pct, (salary+salary*commission_pct)*12, salary*12)
       --    com_pct가 null이면     두 번째값 출력            null이면 세번째 값 출력
from employees;

-- 4. nullif
select first_name, length(first_name), last_name, length(last_name),
--           exp1               exp2       
       nullif(length(first_name),length(last_name)) result
--     exp1과 exp2가 같으면 null 출력
--     exp1과 exp2가 다르면 exp1 출력
from employees;

-- 5. coalesce 함수
--                         exp1            exp2    exp3
select last_name, coalesce(commission_pct, salary, 10) comm
--                         exp1이 null이 아니면 exp1 출력
--                         exp1이 null이면 exp2 출력
--                         exp1과 exp2가 모두 null이면 exp3 출력
from employees;

--- 다중행 함수
-- 6. 급여를 제일 많이 받는 사람과 적게 받는 사람과 급여 평균을 출력하세요. 
select min(salary), max(salary), avg(salary) from employees;

-- 7. 급여를 받는 사람의 수와 부서를 가지고 있는 사람의 수를 출력하세요.
select count(salary), count(department_id) from employees;

--- 다중행 함수는 null값은 제외하고 계산해서 출력한다.
--- 다중행 함수는 null값은 포함하지 않으므로 전체의 값을 구할 때 값이 다를 수 있다.
--8. 커미션을 받는 사원의 커미션의 평균과 전체 커미션의 평균을 구하세요.
select avg(commission_pct), sum(commission_pct) / count(*)
from employees;

-- 9. 전체의 사원의 수를 구하세요. (행 전체의 개수)
select count(*) from employees;

-- 10. 제일 늦게 입사한 사원과 제일 처음에 입사한 사원을 출력하세요.
select min(hire_date),max(hire_date) from employees;

-- 11. 직무에 'REP' 를 가지고 있는 사원들중 급여를 제일 많이 받는 급여와 적게 받느 급여와 평균급여를 출력하세요.
select min(salary),max(salary),avg(salary), count(employee_id)
from employees 
where job_id like '%REP%';

--- 다중햄 함수를 사용하는 경우 다중행 함수만 사용해야 한다. 컬럼을 추가할 수 없다.
-- 예) select first_name, sum(salary) 
--     from employees;                         사용할 수 없다.
-- 12. 80번 부서에서 커미션을 받는 사원의 수와 최대 커미션 값과 최소 커미션 값을 출력
select count(commission_pct), max(commission_pct), min(commission_pct)
from employees
where department_id = 80;

-- 13. 사원이 속해있는 부서의 종류눈? 
select distinct(department_id) 
from employees;

-- 14. 부서의 개수는?
select count(distinct(department_id))
from employees; -- null 은 부서가 아니므로 제외

-- 15. 커미션을 받는 사원의 커미션 평균과 커미션을 받지 않은 사원의 커미션의 평균을 구하세요. 
select trunc(avg(commission_pct),4),
       trunc(avg(nvl(commission_pct,0)),4),
       trunc(sum(commission_pct)/count(*),4)
       from employees;
       
       
--- group by 
-- 16. 90인 부서의 급여의 평균, 합계, 최대, 최소, 사원의 수를 출력하세요.
select trunc(avg(salary),2), sum(salary), max(salary), min(salary), count(*)
from employees where department_id = 90;
-- 80인 부서의 급여의 평균, 합계, 최대, 최소, 사원의 수를 출력하세요.
select trunc(avg(salary),2), sum(salary), max(salary), min(salary), count(*)
from employees where department_id = 80;       
-- 70인 부서의 급여의 평균, 합계, 최대, 최소, 사원의 수를 출력하세요.
select trunc(avg(salary),2), sum(salary), max(salary), min(salary), count(*)
from employees where department_id = 70;
-- 17. 각 부서별 부서의 급여의 평균, 합계, 최대, 최소, 사원의 수를 출력하세요.
select department_id, -- group by 절에 있는 컬럼은 select 절에 다중행 함수와 함께 사용이 가능한다. 
       trunc(avg(salary),2), sum(salary), max(salary), min(salary), count(*)
from employees 
group by department_id;

-- 18. 같은 직무를 하는 사원들 중 제일 먼저 들어온 사원과 제일 늦게 들어온 사원의 입사일을 각각 출력하세요.
select job_id, min(hire_date), max(hire_date)
from employees
group by job_id
order by job_id;

-- 19. 사원번호, 이름, 입사일, 직무, 부서 출력시 부서는 오름차순, 각 부서의 직무 오름차순으로 정렬
select employee_id, first_name,hire_date, job_id, department_id
from employees
order by department_id, job_id;

-- 20. 각 부서의 직무별 급여 평균, 합계, 담당하는 사원의 수를 출력 
select department_id, job_id, trunc(avg(salary)), sum(salary), count(*)
from employees
group by department_id, job_id;

-- 21. 90 부서에서 직무별 급여 합계와 평균을 구하세요.
select job_id, trunc(avg(salary)), sum(salary)
from employees                                  -- 1
where department_id = 90                        -- 2 원하는 걸 먼저 갖고오고
group by job_id;                                -- 3 그룹으로 묶자 


--- having
-- 22. 각 부서에서 직무가 같은 사원들 중 입사일이 같은 사원의 수를 구하세요.
select department_id, job_id, hire_date, count(*)
from employees
group by department_id, job_id, hire_date
having count(*) >= 2; --gruop 함수의 조건이 있는 경우 where이 아니라 having을 사용한다.

-- 23. 평균 급여가 7000 이상인 부서만 출력하세요. 평균 급여 높은 것부터 출력하세요.
select department_id, trunc(avg(salary)) sal
from employees
group by department_id
having trunc(avg(salary)) >= 7000
order by sal desc;
-- order by trunc(avg(salary)) desc;
-- order by 2 desc;

-- 24. 부서의 직원 수가 10명 미만인 부서를 출력하세요.
select department_id, count(*)
from employees
group by department_id
having count(*) < 10;


-- 25. 직무에 'REP' 가 포함되어 있지 않은 직무별 급여의 평균, 합계, 최소, 최대값을 출력할 때 급여의 합계가 13000이상인 직무만 출력하세요.
select trunc(avg(salary)) sal, sum(salary), min(salary), max(salary)
from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) >= 13000;


--- 다중행 함수 group by, having,
--- sum, avg, max, min, count
select max(employee_id)+1 from employees;
-- select max(board_num) + 1 from board 보드테이블의 마지막 글번호 + 1 = 현재 글번호 



--- join : 두 개 이상의 테이블에서 정보를 가져올 때 
select employee_id, first_name, department_id 
from employees
where employee_id = 100;

select department_id, department_name
from departments
where department_id = 90;

-- 26. 
--        employees 테이블                                  departments 테이블 
select employee_id, first_name, employees.department_id, departments.department_id, department_name
--                                        90            =             90
from employees, departments
where employee_id = 100 and employees.department_id = departments.department_id ;

--- T sql - join
-- 27. 모든 사원의 성, 이름, 급여, 직무, 부서번호, 지역번호, 부서명을 출력하세요
select last_name, first_name, salary, job_id, e.department_id, location_id, department_name
from employees e , departments d
where e.department_id = d.department_id;

--- cartisian join 카디시안 조인
select last_name, first_name, salary, job_id, employees.department_id, location_id, department_name
from employees, departments;
-- 두 개의 테이블 정보를 모두 출력

-- 28. 모든 사원의 성, 급여, 입사일, 직무, 직무명을 출력하세요.
select last_name, salary, jobs.job_id, job_title 
from employees, jobs
where employees.job_id = jobs.job_id;


--- Ansi join 
-- 29. 직원번호, 성, 이름, 급여, 직무, 부서번호, 지역번호, 부서명을 Ansi-join 으로 출력하세요.
select last_name, first_name, salary, job_id, e.department_id, location_id, department_name
from employees e join departments d
on e.department_id = d.department_id; -- join 조건 

-- 30.  직원번호, 성, 이름, 급여, 직무, 부서번호, 지역번호, 부서명을 Ansi-join 으로 출력하세요.
-- 부서명이 100인 사람만 출력하세요.
select last_name, first_name, salary, job_id, e.department_id, location_id, department_name
from employees e join departments d
on  e.department_id = d.department_id
where employee_id = 100 ;


--- natual join 

-- 31. 직원번호, 성, 이름, 직무, 직무명을 출력하세요.
-- T sql join
select employee_id, last_name, first_name, e.job_id, job_title
from employees e, jobs j
where e.job_id = j.job_id;
-- Ansi join 
select employee_id, last_name, first_name, e.job_id, job_title
from employees e join jobs j
on e.job_id = j.job_id;

-- natual join 
-- 테이블에 같은 이름의 컬럼을 비교하는 것이므로 join 조건이 필요 없다.
-- 단 employees 와 departments 처럼 같은 이름의 컬럼이 2개 이상 있는 경우에는
-- 하나만 비교하는 것이 불가능하기 때문에 natural join 을 할 수 없다. 
select employee_id, last_name, first_name, job_id, job_title
from employees natural join jobs; --- 별칭을 가질 수 없다.

-- 32. 부서장이 상사인 직원을 구하세요.
-- 직원번호, 성, 급여, 입사일, 부서번호, 부서장 번호를 출력하세요.
-- T sql - join
select employee_id, last_name, salary, hire_date, e.department_id, e.manager_id
from employees e, departments d
where e.department_id = d.department_id and e.manager_id = d.manager_id;
-- ansi - join
select employee_id, last_name, salary, hire_date, e.department_id, e.manager_id
from employees e join departments d
on e.department_id = d.department_id and e.manager_id = d.manager_id;
-- natural - join
select employee_id, last_name, salary, hire_date, department_id, manager_id
from employees natural join departments ;

-- 33. 성, 이름 , 번호, 급여, 부서번호, 부서명을 anti join 으로 출력
select last_name, first_name, phone_number, salary, e.department_id, department_name
from employees e join departments d
on e.department_id = d.department_id;
--- using절 사용 
select last_name, first_name, phone_number, salary, department_id, department_name
from employees join departments using (department_id);

select employee_id, last_name, salary, hire_date, department_id, manager_id
from employees join departments using (department_id, manager_id);

-- 일반적으로 join조건은 primary key = foreign key 를 비교한다. 

-- 34. 각 부서의 부서 정보와 부서장의 이름을 출력하세요.
select e.department_id, department_name, location_id, employee_id, first_name, d.manager_id
from departments d, employees e
where d.manager_id = e.employee_id;

-- 35. 직원번호, 직무번호, 직무내용 
select employee_id, e.job_id, job_title
from employees e, jobs j
where e.job_id = j.job_id;
select employee_id, e.department_id, department_name
from employees e, departments d
where e.department_id = d.department_id;

--- 35. 각 직원의 직원번호,직무번호,직무내용,부서번호,부서명
-- t-sql join
select employee_id, e.job_id, job_title, e.department_id, department_name
from employees e, jobs j,departments d
where e.job_id = j.job_id and e.department_id = d.department_id;
-- ansi join
select employee_id, e.job_id, job_title, e.department_id, department_name
from employees e join jobs j 
on e.job_id = j.job_id join departments d
on e.department_id = d.department_id;
-- natural join
select employee_id, job_id, job_title, department_id, department_name
from employees natural join jobs join departments using(department_id);

-- table이 3개면 join 조건은 최소 2개,
-- table이 n개면 join 조건은 최소 n-1개

-- 36. 부서장의 직무 내용을 출력하세요. 부서장 번호, 직무내용
select e.manager_id, job_title
from employees e, jobs j, departments d
where e.job_id = j.job_id and e.employee_id = d.manager_id and e.department_id = d.department_id;

-- null 을 가진 사원은 안나온다.
select first_name, last_name, salary, e.department_id, d.department_id, department_name
from employees e, departments d
where e.department_id = d.department_id;
--- 37. 부서가 없는 직원도 같이 출력 
select first_name, last_name, salary, e.department_id, d.department_id, department_name
from employees e left outer join departments d -- 왼쪽에서 빠진걸 출력하겠따
on e.department_id = d.department_id;
select first_name, last_name, salary, e.department_id, d.department_id, department_name
from departments d right outer join employees e -- 오른쪽에서 빠진걸 출력하겠다
on e.department_id = d.department_id;

-- 38. 직원이 없는 부서를 출력
select first_name, last_name, salary, e.department_id, d.department_id, department_name
from departments d left outer join employees e 
on e.department_id = d.department_id;
select first_name, last_name, salary, e.department_id, d.department_id, department_name
from employees e right outer join departments d
on e.department_id = d.department_id;

-- 39. 직원이 없는 부서와 부서가 없는 직원 모두 출력 

select first_name, last_name, salary, e.department_id, d.department_id, department_name
from departments d full outer join employees e 
on e.department_id = d.department_id;


--- t sql 
-- 더 출력하고자하는 부분말고다른 부분에 (+) 해주면 된다. 
select first_name, last_name, salary, e.department_id, d.department_id, department_name
from employees e , departments d
where e.department_id = d.department_id(+);
select first_name, last_name, salary, e.department_id, d.department_id, department_name
from employees e , departments d
where e.department_id(+) = d.department_id;

select first_name, last_name, salary, e.department_id, d.department_id, department_name
from employees e , departments d
where e.department_id(+) = d.department_id;
select first_name, last_name, salary, e.department_id, d.department_id, department_name
from employees e , departments d
where e.department_id = d.department_id(+);

-- full outer join 은 ansi join 만 되고 t-sql join은 안 된다. 양쪽 (+) 불가능 
select first_name, last_name, salary, e.department_id, d.department_id, department_name
from employees e , departments d
where e.department_id(+) = d.department_id(+);



--- 숙제
--- 직무에 'REP'포함된 직원의 급여의 합계 , 평균, 최대, 최소, 사원 수를 구하시오.
select job_id, sum(salary), avg(salary), max(salary), min(salary), count(*)
from employees
where job_id like '%REP%'
group by job_id;

--- 80인 부서에서 커미션을 받는 사원의 수를 구하세요.
select count(*) from employees
where department_id = 80 and commission_pct is not null;

--- 부서별 급여의 평균을 구하고 급여의 평균을 내림차순으로 출력하시오.
select trunc(avg(salary)) sal
from employees
group by department_id
order by sal desc;

--- 그룹함수를 사용한 경우 select 절에 올 수 있는 컬럼은 group by절에 있는 컬럼만 올수 있다.
--- 직원의 급여가 6000이상인 사원들의 부서별 평균을 구하고 부서별 평균이 7000이상인 부서만 출력하시오. 부서를 내림차순
select department_id, trunc(avg(salary)) sal
from employees
where salary >= 6000
group by department_id
having trunc(avg(salary)) >= 7000
order by department_id desc;

--- 직무가 'REP'를 포함하고 있지 않은 직원들의 직무별 급여의 합계가 13000이상인 직무만 출력하시오.급여의 합계를 오름차순으로 정렬
select job_id , sum(salary) from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) >=13000
order by sum(salary) ;

-- 직무에 IT_PROG, ST_CLERK, SA_REP가 포함되어 있지 않은 사원
select * from employees
where job_id not in ('IT_PROG','ST_CLERK','SA_REP');

-- 급여가 3000에서 5000사이에 있지 않은 사원
select * from employees where salary not between 3000 and 5000;

-- 1.사원 테이블에서 부서번호, 사원번호, 이름 , 입사일을 출력하는 데 부서번호가 70인 부서를 출력하시오.
select department_id, employee_id, first_name, hire_date
from employees
where department_id = 70;

-- 2.사원테이블에서 사원번호, 부서번호, 이름 급여를 출력하는데 입사일이 02/06/07인 사원들만 출력하시오.
select department_id, employee_id, first_name, salary
from employees
where hire_date = '02/06/07';

-- 3. 사원 테이블에서 부서번호, 사원 번호,이름, 직무번호를 출력하는데 이름이 William 인 사원을 출력하시오.
select department_id, employee_id, first_name, job_id
from employees
where first_name = 'William';

-- 4. 사원 테이블에서 부서번호 사원번호 이름 직무번호 급여를 출력하는데 직무 번호가 FI_ACCOUNT인 사원 들을 출력하시오.
select department_id, employee_id, first_name, job_id, salary
from employees
where job_id = 'FI_ACCOUNT';

-- 5. 사원테이블을 출력하는 이름 name으로 부서번호는 did 사원번호는 eid 직무번호를 출력할 때 부서번호 50이상인 부서의 사원
select first_name name, employee_id eid, job_id
from employees
where department_id >= 50;

-- 6. 사원 테이블을 출력하는 데 급여가 4000에서 10000사이만 출력하시오.
select * from employees
where salary between 4000 and 10000;

-- 7. 사원 테이블에서 직무가 FI_ACCOUNT가 아닌 사원들을 출력하시오.
select * from employees where job_id not in ('FI_ACCOUNT');
select * from employees where job_id != 'FI_ACCOUNT'; -- 답 

-- 8. 사원테이블을 출력하는데 부서번호가 50이거나, 70인 사원 출력하시오
select * from employees
where department_id in (50,70);

-- 9. 사원테이블에서 사원이름이 Daniel보다 큰 사원을 출력하시오.
select * from employees
where first_name > 'Daniel';

-- 10. 사원 테이블에서 사원이름이 Daniel보다 크고 Julia보다 작은 사원들을 출력.
select * from employees
where first_name between 'Daniel' and 'Julia';

-- 11. 사원테이블을 출력할 때  입사일이 01/01/13부터 06/01/03까지  입사한 사원들만 출력하시오.
select * from employees
where hire_date between '01/01/13' and '06/01/03';

-- 12. 사원테이블에서 급여가 10000에서  15000사이의 사원들만 출력하시오.
select * from employees
where salary between 10000 and 15000;

-- 13. 사원 테이블에서 부서번호가   50이거나 70이거나 90인   사원을 출력하시오.
select * from employees
where department_id in (50,70,90);

-- 14. 사원 테이블에서 직무번호가  FI_MGR 이거나 SA_MAN 이거나  MK_MAN 인 사원을 출력하시오.
select * from employees
where job_id in ('FI_MGR','SA_MAN','MK_MAN');

-- 15. 사원테이블에서 사원번호, 성, 급여,  상사번호를 출력하는데 상사가 100,101,201인 사원들을  출력하시오.
select employee_id, last_name, salary, manager_id 
from employees
where manager_id in (100,101,201);

-- 16. 사원 테이블에서 사원번호, 상사번호, 부서번호를 출력하는데 성이 Hartstein 과 Vargas 사이의 사원들만 출력하시오.
select employee_id, manager_id, department_id
from employees
where last_name between 'Hartstein' and 'Vargas';

-- 17. 사원 테이블에서 사원번호, 상사번호, 부서번호를 출력하는데 성이 Hartstein 와 Vargas 인 사원만 출력하시오.
select employee_id, manager_id, department_id
from employees
where last_name in ('Hartstein','Vargas');

-- 18. 사원 테이블에서 커미션이 null인 사원들만 출력하세요.
select * from employees
where commission_pct is null;

-- 19. 사원 테이블에서 성, 직무번호, 상사를 출력하는게 상사가 없는 사원을 출력하시오.
select last_name, job_id, manager_id
from employees
where manager_id is null;

-- 20. 사원 테이블에서 부서가 없는 사원을 출력 하시오.
select * from employees
where department_id is null;

-- 21. 사원테이블에서 이름의 첫글자가 'S'로 시작되는 사원을 출력하시오.
select * from employees where substr(first_name,1,1) = 'S';
select * from employees where first_name like 'S%'; -- 답 

-- 22. 사원테이블에서 입사일 중 day가 6일인 사원들을 출력하시오.
select * from employees where substr(hire_date,7,2) = 06;
select * from employees where hire_date like '%06'; -- 답

-- 23 사원테이블에서 02년도에 입사한 사원들을 출력하시오.
select * from employees where substr(hire_date,1,2) = 02;
select * from employees where hire_date like '02%'; -- 답
select * from employees where to_char(hire_date,'yy') = '02'; -- 답 

-- 24. 사원테이블에서 직무번호에 MA를 포함하고 사원출력하시오.
select * from employees
where job_id like '%MA%';

-- 25. 사원 테이블에서 이름이 두번째 글자가 's'인 사원들을 출력하시오.
select * from employees
where substr(first_name,2,1) = 's';
select * from employees where first_name like '_s%'; -- 답 

-- 26. 사원 테이블에서 이름의 세번째 글자에 's'를 포함하는 사원은
select * from employees
where substr(first_name,3,1) = 's';
select * from employees where first_name like '__s%'; -- 답 

-- 27. 사원테이블에서 이름에 's'가 뒤에서 두번째에 포함되어 있는 사원은?
select * from employees
where substr(first_name,-2,2) = 's'; -- 틀렸땅 
select * from employees where first_name like '%s_'; -- 답

-- 28. 사원 테이블에서 직무에 'A_'를 포함하고 있는 사원은?
select * from employees where job_id like '%A_%'; -- 틀렸따!!!
select * from employees where job_id like '%A\_%' ESCAPE '\';  -- 답 

-- 29.사원테이블에서 급여가 10000 미만이고 15000을 초과하는 사원
select * from employees
where salary not between 10000 and 15000;

-- 30. 사원 테이블에서 사원 성이 Doran 부터 Fox 사이에 있는 사원을 제외한 나머지 사원을 출력
select * from employees
where last_name not between 'Doran' and 'Fox';

-- 31. 사원 테이블에서 부서번호가 50, 70, 90부서가 아닌 사원은?
select * from employees
where department_id not in (50,70,90);

-- 32. 사원테이블에서 성과 직무를 출력하는데 직무가 IT_PROG ,ST_CLERK , SA_REP 가 아닌 사원
select last_name, job_id from employees
where job_id not in ('IT_PROG','ST_CLERK','SA_REP');

-- 33. 사원테이블에 있는 commission_pct가 null이 아닌 사원들을 출력하시오.
select * from employees
where commission_pct is not null;

-- 34. 사원테이블에서 상사가 있는 사원들만 출력하시오.
select * from employees
where manager_id is not null;

-- 35. 부서를 가지고 있는 사원은?
select * from employees
where department_id is not null;

-- 36. 직무에 'SA'를 포함하는 사원은?
select * from employees
where job_id like '%SA%';

-- 37. 직무에 'SA'를 포함하고 있지 않은 사원은?
select * from employees
where job_id not like '%SA%';

-- 38. 사원테이블에서 부서가 50, 70, 90이면서 급여가 10000이상인 사원들을 구하시오.
select * from employees
where department_id in (50,70,90) and salary >= 10000;

-- 39. 사원테이블에서 부서가 50,70이고 또 부서가 90이면서 급여가  10000 이상인 사원?
select * from employees
where department_id in (50,70) or (department_id = 90 and salary >= 10000);

-- 40.아래쿼리문에 IN 연산자를 사용 
select * from hr.employees
where ( department_id = 50
OR department_id = 70
OR department_id = 90 )
AND salary >= 10000;

-- 41.IN연산자 사용
select * from hr.employees
where department_id = 50
OR department_id = 70
OR department_id = 90
AND salary >= 10000;

-- 42. 사원테이블에서 이름을 사전순서로 출력하시오.(오른차순)
select first_name from employees
order by first_name asc;

-- 43. 사원테이블에서 부서번호 이름 급여 입사일을 출력하는데 부서번호를 오름차순으로 정렬하시오.
select department_id, first_name, salary, hire_date from employees
order by department_id asc;

-- 44. 사원테이블에서 부서번호가 90인 부서의 사원을 출력하는데 사원 이름의 오름차순으로 정렬
select * from employees
where department_id = 90
order by first_name asc;

-- 45. 사원테이블에서 부서번호, 사원번호, 이름, 급여, 입사일을 출력할 때 부서가 50, 70인 부서의 사원을 입사일 순으로 정렬하시오.
select department_id, employee_id, first_name, salary, hire_date from employees
where department_id in (50,70)
order by hire_date asc;

-- 46. 사원을 입사일 제일 늦은 사원 부터 출력하시오.
select * from employees
order by hire_date desc; 

-- 47. 입사일이 02/08/16년부터 08/01/29년사이의 입사한 사람을 부서와 사번 그리고 이름을 출력하는데 입사일이 늦은 사원 부터 출력하시오.
select department_id, employee_id, first_name from employees
where hire_date between '02/08/16' and '08/01/29'
order by hire_date desc; 

-- 48. 'SA'로 시작는 직무를 제외한 나머지 사원들 중에 부서번호, 사번, 이름, 입사일을 출력하는데 부서를 내림차순으로 정렬하시오.
select department_id, employee_id, first_name, hire_date from employees
where job_id not like '%SA%'
order by department_id desc;

-- 49. 사원을 부서번호, 사번, 이름, 입사일, 직무를 출력할 때 부서번호가 90과 110을 출력할 때 부서를 오름차순으로 하고 부서의 사원도 입사일 기준으로 오름차순으로 정렬하시오.
select department_id, employee_id, first_name, hire_date, job_id from employees
where department_id in (90,110)
order by department_id asc, hire_date asc, employee_id asc;
  
-- 50. 사원테이블에서 부서번호,입사일 ,사번, 이름, 직무, 급여, 급여에 커미션을 더한값을 출력하는데 이름을 comm으로 변경하고
--부서는 50, 70, 120만 출력하는데 부서는 오름차순, 입사일은 내림차순으로 정렬하시오.
select department_id, hire_date,employee_id,first_name ,job_id,salary, salary+(salary*nvl(commission_pct,0)) comm from employees
where department_id in (50,70, 120)
order by department_id asc, hire_date desc;

-- 51. 사원테이블에서 사원번호, 성, 급여에 12를 곱한 값을 sal로 출력하고 급여에 12를 곱한 값을 오름차순으로 정렬하시오.
select employee_id, last_name, salary*12 sal from employees
order by sal;

-- 52. 성과 부서 그리고 급여를 출력하는데 급여가 4000부터 10000사이에 있는 사원만 부서를 내림차순으로 정렬하고 급여는 오름차순으로 정렬 
select last_name, department_id, salary from employees
where salary between 4000 and 10000
order by department_id desc, salary asc;

-- 53. 성과 급여를 출력할 때 직무가 'MA'포함하고 있는 사원을 제외한 나머지 사원들을 부서는 오름차순, 급여는 내림차순으로 정렬하시오.
select last_name, salary from employees
where job_id not like '%MA%'
order by department_id asc, salary desc;




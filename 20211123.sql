
--- 11/23
-- 1. concat
-- 2. nvl_1
select last_name, first_name, job_id, salary,(salary+salary*nvl(commission_pct,0))*12 year_sal
from employees;

-- 3. nvl_2
select last_name, first_name, job_id, salary,
       nvl2 (commission_pct, (salary+salary*commission_pct)*12, salary*12)
       --    com_pct�� null�̸�     �� ��°�� ���            null�̸� ����° �� ���
from employees;

-- 4. nullif
select first_name, length(first_name), last_name, length(last_name),
--           exp1               exp2       
       nullif(length(first_name),length(last_name)) result
--     exp1�� exp2�� ������ null ���
--     exp1�� exp2�� �ٸ��� exp1 ���
from employees;

-- 5. coalesce �Լ�
--                         exp1            exp2    exp3
select last_name, coalesce(commission_pct, salary, 10) comm
--                         exp1�� null�� �ƴϸ� exp1 ���
--                         exp1�� null�̸� exp2 ���
--                         exp1�� exp2�� ��� null�̸� exp3 ���
from employees;

--- ������ �Լ�
-- 6. �޿��� ���� ���� �޴� ����� ���� �޴� ����� �޿� ����� ����ϼ���. 
select min(salary), max(salary), avg(salary) from employees;

-- 7. �޿��� �޴� ����� ���� �μ��� ������ �ִ� ����� ���� ����ϼ���.
select count(salary), count(department_id) from employees;

--- ������ �Լ��� null���� �����ϰ� ����ؼ� ����Ѵ�.
--- ������ �Լ��� null���� �������� �����Ƿ� ��ü�� ���� ���� �� ���� �ٸ� �� �ִ�.
--8. Ŀ�̼��� �޴� ����� Ŀ�̼��� ��հ� ��ü Ŀ�̼��� ����� ���ϼ���.
select avg(commission_pct), sum(commission_pct) / count(*)
from employees;

-- 9. ��ü�� ����� ���� ���ϼ���. (�� ��ü�� ����)
select count(*) from employees;

-- 10. ���� �ʰ� �Ի��� ����� ���� ó���� �Ի��� ����� ����ϼ���.
select min(hire_date),max(hire_date) from employees;

-- 11. ������ 'REP' �� ������ �ִ� ������� �޿��� ���� ���� �޴� �޿��� ���� �޴� �޿��� ��ձ޿��� ����ϼ���.
select min(salary),max(salary),avg(salary), count(employee_id)
from employees 
where job_id like '%REP%';

--- ������ �Լ��� ����ϴ� ��� ������ �Լ��� ����ؾ� �Ѵ�. �÷��� �߰��� �� ����.
-- ��) select first_name, sum(salary) 
--     from employees;                         ����� �� ����.
-- 12. 80�� �μ����� Ŀ�̼��� �޴� ����� ���� �ִ� Ŀ�̼� ���� �ּ� Ŀ�̼� ���� ���
select count(commission_pct), max(commission_pct), min(commission_pct)
from employees
where department_id = 80;

-- 13. ����� �����ִ� �μ��� ������? 
select distinct(department_id) 
from employees;

-- 14. �μ��� ������?
select count(distinct(department_id))
from employees; -- null �� �μ��� �ƴϹǷ� ����

-- 15. Ŀ�̼��� �޴� ����� Ŀ�̼� ��հ� Ŀ�̼��� ���� ���� ����� Ŀ�̼��� ����� ���ϼ���. 
select trunc(avg(commission_pct),4),
       trunc(avg(nvl(commission_pct,0)),4),
       trunc(sum(commission_pct)/count(*),4)
       from employees;
       
       
--- group by 
-- 16. 90�� �μ��� �޿��� ���, �հ�, �ִ�, �ּ�, ����� ���� ����ϼ���.
select trunc(avg(salary),2), sum(salary), max(salary), min(salary), count(*)
from employees where department_id = 90;
-- 80�� �μ��� �޿��� ���, �հ�, �ִ�, �ּ�, ����� ���� ����ϼ���.
select trunc(avg(salary),2), sum(salary), max(salary), min(salary), count(*)
from employees where department_id = 80;       
-- 70�� �μ��� �޿��� ���, �հ�, �ִ�, �ּ�, ����� ���� ����ϼ���.
select trunc(avg(salary),2), sum(salary), max(salary), min(salary), count(*)
from employees where department_id = 70;
-- 17. �� �μ��� �μ��� �޿��� ���, �հ�, �ִ�, �ּ�, ����� ���� ����ϼ���.
select department_id, -- group by ���� �ִ� �÷��� select ���� ������ �Լ��� �Բ� ����� �����Ѵ�. 
       trunc(avg(salary),2), sum(salary), max(salary), min(salary), count(*)
from employees 
group by department_id;

-- 18. ���� ������ �ϴ� ����� �� ���� ���� ���� ����� ���� �ʰ� ���� ����� �Ի����� ���� ����ϼ���.
select job_id, min(hire_date), max(hire_date)
from employees
group by job_id
order by job_id;

-- 19. �����ȣ, �̸�, �Ի���, ����, �μ� ��½� �μ��� ��������, �� �μ��� ���� ������������ ����
select employee_id, first_name,hire_date, job_id, department_id
from employees
order by department_id, job_id;

-- 20. �� �μ��� ������ �޿� ���, �հ�, ����ϴ� ����� ���� ��� 
select department_id, job_id, trunc(avg(salary)), sum(salary), count(*)
from employees
group by department_id, job_id;

-- 21. 90 �μ����� ������ �޿� �հ�� ����� ���ϼ���.
select job_id, trunc(avg(salary)), sum(salary)
from employees                                  -- 1
where department_id = 90                        -- 2 ���ϴ� �� ���� �������
group by job_id;                                -- 3 �׷����� ���� 


--- having
-- 22. �� �μ����� ������ ���� ����� �� �Ի����� ���� ����� ���� ���ϼ���.
select department_id, job_id, hire_date, count(*)
from employees
group by department_id, job_id, hire_date
having count(*) >= 2; --gruop �Լ��� ������ �ִ� ��� where�� �ƴ϶� having�� ����Ѵ�.

-- 23. ��� �޿��� 7000 �̻��� �μ��� ����ϼ���. ��� �޿� ���� �ͺ��� ����ϼ���.
select department_id, trunc(avg(salary)) sal
from employees
group by department_id
having trunc(avg(salary)) >= 7000
order by sal desc;
-- order by trunc(avg(salary)) desc;
-- order by 2 desc;

-- 24. �μ��� ���� ���� 10�� �̸��� �μ��� ����ϼ���.
select department_id, count(*)
from employees
group by department_id
having count(*) < 10;


-- 25. ������ 'REP' �� ���ԵǾ� ���� ���� ������ �޿��� ���, �հ�, �ּ�, �ִ밪�� ����� �� �޿��� �հ谡 13000�̻��� ������ ����ϼ���.
select trunc(avg(salary)) sal, sum(salary), min(salary), max(salary)
from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) >= 13000;


--- ������ �Լ� group by, having,
--- sum, avg, max, min, count
select max(employee_id)+1 from employees;
-- select max(board_num) + 1 from board �������̺��� ������ �۹�ȣ + 1 = ���� �۹�ȣ 



--- join : �� �� �̻��� ���̺��� ������ ������ �� 
select employee_id, first_name, department_id 
from employees
where employee_id = 100;

select department_id, department_name
from departments
where department_id = 90;

-- 26. 
--        employees ���̺�                                  departments ���̺� 
select employee_id, first_name, employees.department_id, departments.department_id, department_name
--                                        90            =             90
from employees, departments
where employee_id = 100 and employees.department_id = departments.department_id ;

--- T sql - join
-- 27. ��� ����� ��, �̸�, �޿�, ����, �μ���ȣ, ������ȣ, �μ����� ����ϼ���
select last_name, first_name, salary, job_id, e.department_id, location_id, department_name
from employees e , departments d
where e.department_id = d.department_id;

--- cartisian join ī��þ� ����
select last_name, first_name, salary, job_id, employees.department_id, location_id, department_name
from employees, departments;
-- �� ���� ���̺� ������ ��� ���

-- 28. ��� ����� ��, �޿�, �Ի���, ����, �������� ����ϼ���.
select last_name, salary, jobs.job_id, job_title 
from employees, jobs
where employees.job_id = jobs.job_id;


--- Ansi join 
-- 29. ������ȣ, ��, �̸�, �޿�, ����, �μ���ȣ, ������ȣ, �μ����� Ansi-join ���� ����ϼ���.
select last_name, first_name, salary, job_id, e.department_id, location_id, department_name
from employees e join departments d
on e.department_id = d.department_id; -- join ���� 

-- 30.  ������ȣ, ��, �̸�, �޿�, ����, �μ���ȣ, ������ȣ, �μ����� Ansi-join ���� ����ϼ���.
-- �μ����� 100�� ����� ����ϼ���.
select last_name, first_name, salary, job_id, e.department_id, location_id, department_name
from employees e join departments d
on  e.department_id = d.department_id
where employee_id = 100 ;


--- natual join 

-- 31. ������ȣ, ��, �̸�, ����, �������� ����ϼ���.
-- T sql join
select employee_id, last_name, first_name, e.job_id, job_title
from employees e, jobs j
where e.job_id = j.job_id;
-- Ansi join 
select employee_id, last_name, first_name, e.job_id, job_title
from employees e join jobs j
on e.job_id = j.job_id;

-- natual join 
-- ���̺� ���� �̸��� �÷��� ���ϴ� ���̹Ƿ� join ������ �ʿ� ����.
-- �� employees �� departments ó�� ���� �̸��� �÷��� 2�� �̻� �ִ� ��쿡��
-- �ϳ��� ���ϴ� ���� �Ұ����ϱ� ������ natural join �� �� �� ����. 
select employee_id, last_name, first_name, job_id, job_title
from employees natural join jobs; --- ��Ī�� ���� �� ����.

-- 32. �μ����� ����� ������ ���ϼ���.
-- ������ȣ, ��, �޿�, �Ի���, �μ���ȣ, �μ��� ��ȣ�� ����ϼ���.
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

-- 33. ��, �̸� , ��ȣ, �޿�, �μ���ȣ, �μ����� anti join ���� ���
select last_name, first_name, phone_number, salary, e.department_id, department_name
from employees e join departments d
on e.department_id = d.department_id;
--- using�� ��� 
select last_name, first_name, phone_number, salary, department_id, department_name
from employees join departments using (department_id);

select employee_id, last_name, salary, hire_date, department_id, manager_id
from employees join departments using (department_id, manager_id);

-- �Ϲ������� join������ primary key = foreign key �� ���Ѵ�. 

-- 34. �� �μ��� �μ� ������ �μ����� �̸��� ����ϼ���.
select e.department_id, department_name, location_id, employee_id, first_name, d.manager_id
from departments d, employees e
where d.manager_id = e.employee_id;

-- 35. ������ȣ, ������ȣ, �������� 
select employee_id, e.job_id, job_title
from employees e, jobs j
where e.job_id = j.job_id;
select employee_id, e.department_id, department_name
from employees e, departments d
where e.department_id = d.department_id;

--- 35. �� ������ ������ȣ,������ȣ,��������,�μ���ȣ,�μ���
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

-- table�� 3���� join ������ �ּ� 2��,
-- table�� n���� join ������ �ּ� n-1��

-- 36. �μ����� ���� ������ ����ϼ���. �μ��� ��ȣ, ��������
select e.manager_id, job_title
from employees e, jobs j, departments d
where e.job_id = j.job_id and e.employee_id = d.manager_id and e.department_id = d.department_id;

-- null �� ���� ����� �ȳ��´�.
select first_name, last_name, salary, e.department_id, d.department_id, department_name
from employees e, departments d
where e.department_id = d.department_id;
--- 37. �μ��� ���� ������ ���� ��� 
select first_name, last_name, salary, e.department_id, d.department_id, department_name
from employees e left outer join departments d -- ���ʿ��� ������ ����ϰڵ�
on e.department_id = d.department_id;
select first_name, last_name, salary, e.department_id, d.department_id, department_name
from departments d right outer join employees e -- �����ʿ��� ������ ����ϰڴ�
on e.department_id = d.department_id;

-- 38. ������ ���� �μ��� ���
select first_name, last_name, salary, e.department_id, d.department_id, department_name
from departments d left outer join employees e 
on e.department_id = d.department_id;
select first_name, last_name, salary, e.department_id, d.department_id, department_name
from employees e right outer join departments d
on e.department_id = d.department_id;

-- 39. ������ ���� �μ��� �μ��� ���� ���� ��� ��� 

select first_name, last_name, salary, e.department_id, d.department_id, department_name
from departments d full outer join employees e 
on e.department_id = d.department_id;


--- t sql 
-- �� ����ϰ����ϴ� �κи���ٸ� �κп� (+) ���ָ� �ȴ�. 
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

-- full outer join �� ansi join �� �ǰ� t-sql join�� �� �ȴ�. ���� (+) �Ұ��� 
select first_name, last_name, salary, e.department_id, d.department_id, department_name
from employees e , departments d
where e.department_id(+) = d.department_id(+);



--- ����
--- ������ 'REP'���Ե� ������ �޿��� �հ� , ���, �ִ�, �ּ�, ��� ���� ���Ͻÿ�.
select job_id, sum(salary), avg(salary), max(salary), min(salary), count(*)
from employees
where job_id like '%REP%'
group by job_id;

--- 80�� �μ����� Ŀ�̼��� �޴� ����� ���� ���ϼ���.
select count(*) from employees
where department_id = 80 and commission_pct is not null;

--- �μ��� �޿��� ����� ���ϰ� �޿��� ����� ������������ ����Ͻÿ�.
select trunc(avg(salary)) sal
from employees
group by department_id
order by sal desc;

--- �׷��Լ��� ����� ��� select ���� �� �� �ִ� �÷��� group by���� �ִ� �÷��� �ü� �ִ�.
--- ������ �޿��� 6000�̻��� ������� �μ��� ����� ���ϰ� �μ��� ����� 7000�̻��� �μ��� ����Ͻÿ�. �μ��� ��������
select department_id, trunc(avg(salary)) sal
from employees
where salary >= 6000
group by department_id
having trunc(avg(salary)) >= 7000
order by department_id desc;

--- ������ 'REP'�� �����ϰ� ���� ���� �������� ������ �޿��� �հ谡 13000�̻��� ������ ����Ͻÿ�.�޿��� �հ踦 ������������ ����
select job_id , sum(salary) from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) >=13000
order by sum(salary) ;

-- ������ IT_PROG, ST_CLERK, SA_REP�� ���ԵǾ� ���� ���� ���
select * from employees
where job_id not in ('IT_PROG','ST_CLERK','SA_REP');

-- �޿��� 3000���� 5000���̿� ���� ���� ���
select * from employees where salary not between 3000 and 5000;

-- 1.��� ���̺��� �μ���ȣ, �����ȣ, �̸� , �Ի����� ����ϴ� �� �μ���ȣ�� 70�� �μ��� ����Ͻÿ�.
select department_id, employee_id, first_name, hire_date
from employees
where department_id = 70;

-- 2.������̺��� �����ȣ, �μ���ȣ, �̸� �޿��� ����ϴµ� �Ի����� 02/06/07�� ����鸸 ����Ͻÿ�.
select department_id, employee_id, first_name, salary
from employees
where hire_date = '02/06/07';

-- 3. ��� ���̺��� �μ���ȣ, ��� ��ȣ,�̸�, ������ȣ�� ����ϴµ� �̸��� William �� ����� ����Ͻÿ�.
select department_id, employee_id, first_name, job_id
from employees
where first_name = 'William';

-- 4. ��� ���̺��� �μ���ȣ �����ȣ �̸� ������ȣ �޿��� ����ϴµ� ���� ��ȣ�� FI_ACCOUNT�� ��� ���� ����Ͻÿ�.
select department_id, employee_id, first_name, job_id, salary
from employees
where job_id = 'FI_ACCOUNT';

-- 5. ������̺��� ����ϴ� �̸� name���� �μ���ȣ�� did �����ȣ�� eid ������ȣ�� ����� �� �μ���ȣ 50�̻��� �μ��� ���
select first_name name, employee_id eid, job_id
from employees
where department_id >= 50;

-- 6. ��� ���̺��� ����ϴ� �� �޿��� 4000���� 10000���̸� ����Ͻÿ�.
select * from employees
where salary between 4000 and 10000;

-- 7. ��� ���̺��� ������ FI_ACCOUNT�� �ƴ� ������� ����Ͻÿ�.
select * from employees where job_id not in ('FI_ACCOUNT');
select * from employees where job_id != 'FI_ACCOUNT'; -- �� 

-- 8. ������̺��� ����ϴµ� �μ���ȣ�� 50�̰ų�, 70�� ��� ����Ͻÿ�
select * from employees
where department_id in (50,70);

-- 9. ������̺��� ����̸��� Daniel���� ū ����� ����Ͻÿ�.
select * from employees
where first_name > 'Daniel';

-- 10. ��� ���̺��� ����̸��� Daniel���� ũ�� Julia���� ���� ������� ���.
select * from employees
where first_name between 'Daniel' and 'Julia';

-- 11. ������̺��� ����� ��  �Ի����� 01/01/13���� 06/01/03����  �Ի��� ����鸸 ����Ͻÿ�.
select * from employees
where hire_date between '01/01/13' and '06/01/03';

-- 12. ������̺��� �޿��� 10000����  15000������ ����鸸 ����Ͻÿ�.
select * from employees
where salary between 10000 and 15000;

-- 13. ��� ���̺��� �μ���ȣ��   50�̰ų� 70�̰ų� 90��   ����� ����Ͻÿ�.
select * from employees
where department_id in (50,70,90);

-- 14. ��� ���̺��� ������ȣ��  FI_MGR �̰ų� SA_MAN �̰ų�  MK_MAN �� ����� ����Ͻÿ�.
select * from employees
where job_id in ('FI_MGR','SA_MAN','MK_MAN');

-- 15. ������̺��� �����ȣ, ��, �޿�,  ����ȣ�� ����ϴµ� ��簡 100,101,201�� �������  ����Ͻÿ�.
select employee_id, last_name, salary, manager_id 
from employees
where manager_id in (100,101,201);

-- 16. ��� ���̺��� �����ȣ, ����ȣ, �μ���ȣ�� ����ϴµ� ���� Hartstein �� Vargas ������ ����鸸 ����Ͻÿ�.
select employee_id, manager_id, department_id
from employees
where last_name between 'Hartstein' and 'Vargas';

-- 17. ��� ���̺��� �����ȣ, ����ȣ, �μ���ȣ�� ����ϴµ� ���� Hartstein �� Vargas �� ����� ����Ͻÿ�.
select employee_id, manager_id, department_id
from employees
where last_name in ('Hartstein','Vargas');

-- 18. ��� ���̺��� Ŀ�̼��� null�� ����鸸 ����ϼ���.
select * from employees
where commission_pct is null;

-- 19. ��� ���̺��� ��, ������ȣ, ��縦 ����ϴ°� ��簡 ���� ����� ����Ͻÿ�.
select last_name, job_id, manager_id
from employees
where manager_id is null;

-- 20. ��� ���̺��� �μ��� ���� ����� ��� �Ͻÿ�.
select * from employees
where department_id is null;

-- 21. ������̺��� �̸��� ù���ڰ� 'S'�� ���۵Ǵ� ����� ����Ͻÿ�.
select * from employees where substr(first_name,1,1) = 'S';
select * from employees where first_name like 'S%'; -- �� 

-- 22. ������̺��� �Ի��� �� day�� 6���� ������� ����Ͻÿ�.
select * from employees where substr(hire_date,7,2) = 06;
select * from employees where hire_date like '%06'; -- ��

-- 23 ������̺��� 02�⵵�� �Ի��� ������� ����Ͻÿ�.
select * from employees where substr(hire_date,1,2) = 02;
select * from employees where hire_date like '02%'; -- ��
select * from employees where to_char(hire_date,'yy') = '02'; -- �� 

-- 24. ������̺��� ������ȣ�� MA�� �����ϰ� �������Ͻÿ�.
select * from employees
where job_id like '%MA%';

-- 25. ��� ���̺��� �̸��� �ι�° ���ڰ� 's'�� ������� ����Ͻÿ�.
select * from employees
where substr(first_name,2,1) = 's';
select * from employees where first_name like '_s%'; -- �� 

-- 26. ��� ���̺��� �̸��� ����° ���ڿ� 's'�� �����ϴ� �����
select * from employees
where substr(first_name,3,1) = 's';
select * from employees where first_name like '__s%'; -- �� 

-- 27. ������̺��� �̸��� 's'�� �ڿ��� �ι�°�� ���ԵǾ� �ִ� �����?
select * from employees
where substr(first_name,-2,2) = 's'; -- Ʋ�ȶ� 
select * from employees where first_name like '%s_'; -- ��

-- 28. ��� ���̺��� ������ 'A_'�� �����ϰ� �ִ� �����?
select * from employees where job_id like '%A_%'; -- Ʋ�ȵ�!!!
select * from employees where job_id like '%A\_%' ESCAPE '\';  -- �� 

-- 29.������̺��� �޿��� 10000 �̸��̰� 15000�� �ʰ��ϴ� ���
select * from employees
where salary not between 10000 and 15000;

-- 30. ��� ���̺��� ��� ���� Doran ���� Fox ���̿� �ִ� ����� ������ ������ ����� ���
select * from employees
where last_name not between 'Doran' and 'Fox';

-- 31. ��� ���̺��� �μ���ȣ�� 50, 70, 90�μ��� �ƴ� �����?
select * from employees
where department_id not in (50,70,90);

-- 32. ������̺��� ���� ������ ����ϴµ� ������ IT_PROG ,ST_CLERK , SA_REP �� �ƴ� ���
select last_name, job_id from employees
where job_id not in ('IT_PROG','ST_CLERK','SA_REP');

-- 33. ������̺� �ִ� commission_pct�� null�� �ƴ� ������� ����Ͻÿ�.
select * from employees
where commission_pct is not null;

-- 34. ������̺��� ��簡 �ִ� ����鸸 ����Ͻÿ�.
select * from employees
where manager_id is not null;

-- 35. �μ��� ������ �ִ� �����?
select * from employees
where department_id is not null;

-- 36. ������ 'SA'�� �����ϴ� �����?
select * from employees
where job_id like '%SA%';

-- 37. ������ 'SA'�� �����ϰ� ���� ���� �����?
select * from employees
where job_id not like '%SA%';

-- 38. ������̺��� �μ��� 50, 70, 90�̸鼭 �޿��� 10000�̻��� ������� ���Ͻÿ�.
select * from employees
where department_id in (50,70,90) and salary >= 10000;

-- 39. ������̺��� �μ��� 50,70�̰� �� �μ��� 90�̸鼭 �޿���  10000 �̻��� ���?
select * from employees
where department_id in (50,70) or (department_id = 90 and salary >= 10000);

-- 40.�Ʒ��������� IN �����ڸ� ��� 
select * from hr.employees
where ( department_id = 50
OR department_id = 70
OR department_id = 90 )
AND salary >= 10000;

-- 41.IN������ ���
select * from hr.employees
where department_id = 50
OR department_id = 70
OR department_id = 90
AND salary >= 10000;

-- 42. ������̺��� �̸��� ���������� ����Ͻÿ�.(��������)
select first_name from employees
order by first_name asc;

-- 43. ������̺��� �μ���ȣ �̸� �޿� �Ի����� ����ϴµ� �μ���ȣ�� ������������ �����Ͻÿ�.
select department_id, first_name, salary, hire_date from employees
order by department_id asc;

-- 44. ������̺��� �μ���ȣ�� 90�� �μ��� ����� ����ϴµ� ��� �̸��� ������������ ����
select * from employees
where department_id = 90
order by first_name asc;

-- 45. ������̺��� �μ���ȣ, �����ȣ, �̸�, �޿�, �Ի����� ����� �� �μ��� 50, 70�� �μ��� ����� �Ի��� ������ �����Ͻÿ�.
select department_id, employee_id, first_name, salary, hire_date from employees
where department_id in (50,70)
order by hire_date asc;

-- 46. ����� �Ի��� ���� ���� ��� ���� ����Ͻÿ�.
select * from employees
order by hire_date desc; 

-- 47. �Ի����� 02/08/16����� 08/01/29������� �Ի��� ����� �μ��� ��� �׸��� �̸��� ����ϴµ� �Ի����� ���� ��� ���� ����Ͻÿ�.
select department_id, employee_id, first_name from employees
where hire_date between '02/08/16' and '08/01/29'
order by hire_date desc; 

-- 48. 'SA'�� ���۴� ������ ������ ������ ����� �߿� �μ���ȣ, ���, �̸�, �Ի����� ����ϴµ� �μ��� ������������ �����Ͻÿ�.
select department_id, employee_id, first_name, hire_date from employees
where job_id not like '%SA%'
order by department_id desc;

-- 49. ����� �μ���ȣ, ���, �̸�, �Ի���, ������ ����� �� �μ���ȣ�� 90�� 110�� ����� �� �μ��� ������������ �ϰ� �μ��� ����� �Ի��� �������� ������������ �����Ͻÿ�.
select department_id, employee_id, first_name, hire_date, job_id from employees
where department_id in (90,110)
order by department_id asc, hire_date asc, employee_id asc;
  
-- 50. ������̺��� �μ���ȣ,�Ի��� ,���, �̸�, ����, �޿�, �޿��� Ŀ�̼��� ���Ѱ��� ����ϴµ� �̸��� comm���� �����ϰ�
--�μ��� 50, 70, 120�� ����ϴµ� �μ��� ��������, �Ի����� ������������ �����Ͻÿ�.
select department_id, hire_date,employee_id,first_name ,job_id,salary, salary+(salary*nvl(commission_pct,0)) comm from employees
where department_id in (50,70, 120)
order by department_id asc, hire_date desc;

-- 51. ������̺��� �����ȣ, ��, �޿��� 12�� ���� ���� sal�� ����ϰ� �޿��� 12�� ���� ���� ������������ �����Ͻÿ�.
select employee_id, last_name, salary*12 sal from employees
order by sal;

-- 52. ���� �μ� �׸��� �޿��� ����ϴµ� �޿��� 4000���� 10000���̿� �ִ� ����� �μ��� ������������ �����ϰ� �޿��� ������������ ���� 
select last_name, department_id, salary from employees
where salary between 4000 and 10000
order by department_id desc, salary asc;

-- 53. ���� �޿��� ����� �� ������ 'MA'�����ϰ� �ִ� ����� ������ ������ ������� �μ��� ��������, �޿��� ������������ �����Ͻÿ�.
select last_name, salary from employees
where job_id not like '%MA%'
order by department_id asc, salary desc;




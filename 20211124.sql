--- 11/24 
-- 1. ���� Abel�� ����� ������ ����ϼ���.
select job_id from employees where last_name='Abel';

-- 2. ���� Abel�� ����� ���� ������ �ϴ� ������� ����Ͻÿ�.
select * from employees
where job_id = 'SA_REP';
--- ���� ������ ���� �������� ���� ������ �ȴ�.
--- ���������� �Ұ�ȣ �ȿ� �־�� �Ѵ�.
select * from employees
where job_id = (select job_id from employees where last_name='Abel');

-- 3. 106���� ����� �޿��� ���ϼ���.
select salary from employees where employee_id = 106;

-- 4. 106���� ����� ���� �޿��� �޴� �������?
select * from employees where salary = 4800;

select * from employees where salary = 
        (select salary from employees where employee_id = 106);
        
-- 5. ���� Austin�̶�� ����� ���� ���ϴ� ������� ���Ͻÿ�.
select * from employees 
where department_id =
	(select department_id from employees where last_name = 'Austin') ;
    
--- 6. 141���� ������ ����Ͻÿ�.
select job_id from employees where employee_id = 141;--ST_CLERK
--     143���� �޿��� ����Ͻÿ�.
select salary from employees where employee_id = 143;--2600 

-- 7. 141���� ������ ���� 143���� �޿��� ���� �������?
--��, ������ ST_CLERK�̰� �޿��� 2600 �λ���� ���Ͻÿ�.
select * from employees
where job_id = 'ST_CLERK'
and salary = 2600;

select * from employees
where job_id = 
    (select job_id from employees where employee_id = 141)
and salary = 
    (select salary from employees where employee_id = 143);

-- 8. ���� �޿��� �޴� ����� ���Ͻÿ�.
select min(salary) from employees;
select * from employees
where salary = (select min(salary) from employees); 

-- 9. 90�κμ��� ��� �޿����� ���� �޿��� �޴� ����� ���Ͻÿ�.
select avg(salary) from employees where department_id = 90;

select * from employees
where salary > 
    (select avg(salary) from employees where department_id = 90);

-- 10. �Ի����� 178������ �ʰ� �Ի��� ����� ���Ͻÿ�.
select hire_date from employees where employee_id = 178;

select * from employees
where hire_date > 
    (select hire_date from employees where employee_id = 178);

-- 11.50�� �μ��� ��� �޿�
select avg(salary) from employees
where department_id = 50;

-- 12. �� �μ��� ��� �޿��� 3475���� ū �μ���?
select department_id, avg(salary)
from employees
group by department_id
having avg(salary) > 3475;

-- 13. 50�� �μ��� ��� �޿����� ��ձ޿��� ���� �μ��� ���Ͻÿ�.
select department_id, avg(salary)
from employees
group by department_id
having avg(salary) > 
    (select avg(salary) from employees
     where department_id = 50);

-- 14.  60�� �μ��� ���� �޿����� �� ���� �޿��� �޴� �����
select min(salary) from employees where department_id = 60;
select * from employees 
where salary < 
    (select min(salary) from employees where department_id = 60);

-- 15. 50, 60, 70 �� �μ��� ���� �ݾװ� ���� �޿� �޴� �������?
select * from employees
where salary in (select min(salary) from employees
                 where department_id in (50,60,70)
                 group by department_id);


-- 16. �� �μ��� ���� �ݾ��� ���ϰ� �� ���� �ݾ׿� �ش� �Ǵ� ��� ������� ����Ͻÿ�.
select * from employees
where salary in (
    select min(salary) from employees
    group by department_id);
    
-- 17. ��� �޿��� ���� ���� ������ ã������.
select job_id, avg(salary)
from employees
group by job_id
having avg(salary) = (select min(avg(salary)) from employees
                      group by job_id);

-- 18. 50�� �μ��� �޿��� ����ϼ���.
select salary from employees where department_id = 50
order by salary;
               |---------------------------------------->
      ---------|------------------------|------
             2100                     8200
-- 19. 50�� �μ��� ������� �޿� �� ���� �ݾ׺��� �� ���� �޴� ������� ã������.
;--   ���� �� ���� ũ��.
select * from employees where salary > 2100;
select * from employees 
where salary >  (select min(salary) from employees
                    where department_id = 50);
select * from employees 
where salary > any (select salary from employees
                    where department_id = 50);
-- 20. 50�� �μ��� ������� �޴� �޿� �� ���� ���� �޴� �޿����� ���� �޿��� �޴� 
--     ������� ã������.
select * from employees 
where salary < ( select max(salary) from employees
                  where department_id = 50);
select * from employees --- ū�ͺ��� �۴�.
where salary < any( select salary from employees
                  where department_id = 50);

-- 21. 90�κμ��� �޿��� ���� ���� �޿����� ���� �޿��� �޴� ������� ���Ͻÿ�.
select * from employees
where salary < (select min(salary) from employees
                where department_id = 90);
select * from employees
where salary < all(select salary from employees
                where department_id = 90);
-- 22. 50�κμ��� �޿��� ���� ���� �޿����� �� ���� �޿��� �޴� ������� ���Ͻÿ�.
select * from employees
where salary > (select max(salary) from employees
                where department_id = 50);

select * from employees
where salary > all(select salary from employees
                where department_id = 50);

--- 23. 30�� �μ��� ������� �޴� �޿��� ���� �޿��� �޴� ������� ã������.
select salary from employees where department_id = 30;
select * from employees 
where salary in (select salary from employees where department_id = 30);

select * from employees 
where salary = any (select salary from employees where department_id = 30);


select * from testa;
select max(a1) + 1 from testa;
insert into testa values((select max(a1) + 1 from testa), 3);

-- ���տ����� (set : union, intersect, minus)
--                 ������  ������
--select user_id 
--from employees
--where user_id = 'highland0'
--union
--select user_id
--from member
--where user_id = 'highland0'

-- 24. ��� ���̺��� 108���� ��� ���
select manager_id from employees where employee_id = 108;
--    �μ� ���̺��� 80�� �μ��� �μ����� ���
select manager_id from departments where department_id = 80;
-- 108���� ���� 80 �μ��� �μ����� ����϶�.
select manager_id from employees where employee_id = 108
union 
select manager_id from departments where department_id = 80;

-- 25. ������̺� �����ȣ�� ������ ���
select employee_id, job_id from employees; --- 107
    -- �������� ���̺��� �����ȣ�� ������ ���
select employee_id, job_id from job_history; -- 10
--   ������̺� �����ȣ, ���� �׸��� �������� ���̺��� �����ȣ�� ������ ���
select employee_id, job_id from employees
union
select employee_id, job_id from job_history; -- 115

select employee_id, job_id from employees
union all
select employee_id, job_id from job_history;  -- 117


-- 26. ��� ���̺� �ִ� ���� ���� ���� �׸��� �������� ���̺��� ������ȣ�� ������ ����ϼ���.
select manager_id, job_id from employees
union
select employee_id, job_id from job_history;
-- �÷��� �̸��� ���� �ʾƵ� �ȴ�. 

-- 27. ������̺����� �̸�, �޿��� ����ϰ� �μ� ���̺����� �μ���� �μ����� ���
-- �� ���� ������Ÿ���� ��ġ�ϸ� �ȴ�.
-- heading name�� ù ��° ���̺��� ���̸��̴�.
--      ����                  ����
select first_name,          salary           from employees
union
select department_name,     manager_id       from departments;
-- 28. ù��° ���̺��� ���̸��� ��Ī�߰�
-- ��Ī�� heading name�� ����ȴ�. 
select first_name,          salary mng       from employees
union
select department_name,     manager_id       from departments;

-- 29. ������̺����� �޿��� �μ���ȣ�� ����ϰ� �μ����̺����� �μ���� �μ��̸��� ����ϼ���.
-- ORA-01790:�����ϴ� �İ� ���� ������ �����̾�� �մϴ�. ���� ������ Ÿ���� ��ġ�ؾ��Ѵ�. 
--      ����          ����
select salary,     department_id from employees
union 
--      ����          ����
select manager_id, department_name from departments;
---------------------------------------------
-- ���� Ÿ���� ���缭 ���
select    salary,        department_id,     to_char(null) from employees
union 
select manager_id,       to_number(null), department_name from departments;

-- 31. ������̺��� �μ���ȣ, �Ի���, �׸��� �μ����̺��� �μ���ȣ, ������ȣ ���
select department_id, hire_date h_date,     to_number(null) l_id from employees
union
select department_id, to_date(null),        location_id     from departments;

-- 32. �μ����̺��� �������� �ʴ� �������̺��� �����ϴ� ���, �μ����� �ƴ� �����ڸ� ����ϼ���.
select manager_id from employees
where manager_id not in (select manager_id) ;

select manager_id from employees
minus -- ������
select manager_id from departments;

-- �μ����� ��縦 ����ϼ���.
select manager_id from employees
intersect -- ������
select manager_id from departments;


--------------- ��������� �⺻ select �� ---------------
----- DML (date manipulation language) : insert, delete, update
----- Ȯ�� DML : select, insert, delete, update
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
delete from aa1 where a1 = 1; -- ORA-00001: ���Ἲ ���� ����(KOSA.SYS_C008484)�� ����˴ϴ�

delete from bb1 where a1 = 1; -- ������ ���̺��� a1�� ���� �����ϰ�
delete from aa1 where a1 = 1; -- �����ؾ��Ѵ�. 

-- �θ������  1. �ڽ� ������ �����
--            2. �ڽ� ������ ����
create table aa2(
    a1 number primary key,
    a2 number    
);
insert into aa2 values (1,1);
select * from aa2;
create table bb2( -- �θ� �����Ǿ �ڽ��� null������ ������ ����
    a1 number references aa2(a1) on delete set null,
    b1 number 
);
insert into bb2 values (1,11);
select * from bb2;
create table cc2( -- �θ� �����Ǹ� �ڽĵ� ���� �����ǵ��� ����
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

create table dd3 ( -- �ڽ��� ������ �θ� ������ �� ����. 
    a1 number,
    d1 number
);
alter table dd3
add constraint dd3_a1_FK foreign key (a1)
    references aa3(a1);



--- table copy
-- ���̺� ī�ǽ�, () ���� �ȵȴ�.
-- ���̺� ī�ǽ� null�� ������ ���������� ���Ե��� �ʴ´�. (�⺻Ű, �ܷ�Ű ��)
create table emp
as 
select * from employees;
select * from emp;
select * from user_constraints where table_name = 'EMP';
select * from user_constraints where table_name = 'EMPLOYEES';

-- 33. 100�� ����� �����ϼ���.
delete from emp
where employee_id = 100;
select * from emp where employee_id = 100;

-- 34. ������ IT_PROG �� ������� �����ϼ���.
select * from emp where job_id = 'IT_PROG';
delete from emp where job_id = 'IT_PROG';

-- 35. Neena �� ���� �޿��� �޴� ����� �����ϼ���.
select * from emp where salary = (select salary from emp where first_name = 'Neena');
delete from emp where salary = (select salary from emp where first_name = 'Neena');

-- �߸� �������� ��� rollback; 
-- rollback : ���ݱ��� �� DML�۾��� ��� ��ҵȴ�.
-- commit : ���ݱ��� �� DML�۾��� �������ϰ� �ȴ�. 

rollback;
commit;
-- �ڵ� commit�� �Ǵ� ��� DDL (create, alter, drop) ���� ����� ���
-- �۾� â�� �ݴ� ��� 

create table dept
as
select * from departments;
select * from dept;

select * from user_constraints where table_name = 'DEPT';
select * from user_constraints where table_name = 'DEPARTMENTS';

-- 36. �μ��� public �� ���Ե� �μ��� ������� ��� �����ϼ���.
select * from dept where department_name like '%Public%';
delete from emp where department_id in(
                select department_id from dept where department_name like '%Public%'
                );
select * from emp where department_id in(
                  select department_id from dept where department_name like '%Public%'
                  );

--- truncate �ڸ��� 
truncate table emp;
select * from emp;
rollback;


-- 37. ������ ����
insert into emp
select * from employees;

select * from emp;
commit;
-- rollback �ص� ������ �ʴ´�.



--- update
-- 38. emp ���� 60�� �μ��� ������� ����ϰ� �� �μ��� 120�� �μ��� �����ϼ���.
select * from emp where department_id = 60;
update emp
set department_id = 120
where department_id = 60;
select * from emp where department_id = 120;
-- 120 �μ��� 60 �μ��� �ٽ� ����
update emp
set department_id = 60
where department_id = 120;

-- 39. ��� ��ȣ�� 113�� ����� �μ��� 70 �μ��� �����ϼ���.
select * from emp where employee_id = 113;
update emp
set department_id = 70
where employee_id = 113;

-- where�������� ������ ��ü�� �� �ٲ�������. 
update emp 
set department_id = 130;
select * from emp;
rollback;

-- 40. 205�� ����� ������ ��� / 205�� ����� �޿��� ���
select job_id from emp where employee_id = 205;
select salary from emp where employee_id = 205;
-- �� �� 114���� ������ �޿��� 205���� ������ �޿��� �����ϼ��� PU_MAN , 11000 -> AC_MGR , 12008
select job_id from emp where employee_id = 114;
select salary from emp where employee_id = 114;

update emp
set job_id =  -- ���� ������ �� ������ �� �߰�ȣ�� �ִ´� 
        (select job_id from emp where employee_id = 205),
    salary = 
        (select salary from emp where employee_id = 205)
where employee_id = 114;

-- 41.  200�� ����� ������ 140�� ����� ���ӻ�縦 130�� ����� �����Ű����
select job_id from emp where employee_id = 200;             -- AD_ASST
select manager_id from emp where employee_id = 140;         -- 123
select job_id from emp where employee_id = 130;             -- ST_CLERK
select manager_id from emp where employee_id = 130;         -- 121
update emp
set job_id = (select job_id from emp where employee_id = 200),
    manager_id = (select manager_id from emp where employee_id = 140)
where employee_id = 130;

rollback;

-- 42. employees ���̺� �ִ� 100�� ����� �޿��� 114�� ����� ������ emp ���̺� �ִ� 130�� ����� �����Ű����.
select salary from employees where employee_id = 100; -- 24000
select job_id from employees where employee_id = 114; -- PU_MAN
select salary, job_id from emp where employee_id = 130; -- 2800, ST_CLERK
update emp
set salary = (select salary from employees where employee_id = 100),
    job_id = (select job_id from employees where employee_id = 114)
where employee_id = 130;

-- 43. 200�� ����� ���� ������ ���� ������� �μ��� �����ȣ�� 114�� �μ��� �����ϼ���.
select* from emp;
update emp
set department_id = (select department_id from emp where employee_id =114)
where job_id = (select job_id from emp where employee_id = 200);

-- 44. 114 ���� ������ �޿��� 205�� ����� ���� �����ϼ���.
select job_id, salary from employees where employee_id = 114; -- PU_MAN , 11000
select job_id, salary from employees where employee_id = 205; -- AC_MGR , 12008
update emp
set job_id = (select job_id from emp where employee_id = 205),
    salary = (select salary from emp where employee_id = 205)
where employee_id = 114;

-- 45. �μ��� ��ҹ��� ���� ���� pu �� ���ԵǾ� �ִ� �μ��� �������� 120�� ����� �޿��� �����ϼ���.
select salary from employees where employee_id = 120; -- 8000
select * from dept where lower(department_name )like '%pu%'; -- 
--�����,,,, 7����,,,
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
             where department_id = 50) -- 50�� �μ��� insert : where ���ǹ� 
values (300,'SoongMoo','Rhee',sysdate,15000,10,'highland0','AP');

select *from emp;

-- 50�� �μ��� insert �Ϸ��� ���ǹ��� where���� �޾��ش�. ���⼭ check �ɼ��� Ȯ���ϸ� ������� �˼� �ֵ�. 
--where department_id = 50 with check option
--ORA-01402: ���� WITH CHECK OPTION�� ���ǿ� ���� �˴ϴ�

----- DML �� �� -----
-- DML : insert, select, update, delete
-- DDL : create, alter, drop
-- Data Definition Language
-- TCL : rollback, commit, savepoint
-- DCL : grant, revoke, 
-- grant resource, connect, dba to KOSA;
-- revoke resource, connect, dba from KOSA;

rollback;

select * from emp;                  -- 107������
delete from emp 
where job_id like '%REP%';          -- 33�� ����
select * from emp;                  -- 74�� ����
savepoint a; -------------------------------------------------------

delete from emp 
where department_id = 90;           -- 3�� ����
select * from emp;                  -- 71�� ����
savepoint b; -------------------------------------------------------

delete from emp;                    -- 71�� ����
select * from emp;                  -- 0�� ����
rollback to b;
select * from emp;

--------- TCL �� -----------
--- view object
-- ������ �������� ��쿡 �並 ���ؼ� �ܼ��ϰ� ����� �� �ִ�.
-- ���� ���̺��� �ƴ϶�, ���̺��� �Ϻθ� �����ش�. ���� �����Ͱ� �ƴ϶� ���̺��� �����͸� �����ش�.


-- 46. �����ȣ, �̸�, �̸���, �Ի���, �޿�, Ŀ�̼�, Ŀ�̼��� ������ ������ ����ϴµ� null�� 0���� ����
-- ��ҹ��� ���� ���� �μ��̸��� 'pu' �� ���Ե� �μ��� ���
select employee_id, first_name, email, hire_date, salary, commission_pct,
       salary*(1+nvl(commission_pct,0))*12 yearsal
from emp
where department_id in (
                    select department_id from dept where lower(department_name) like '%pu%'
                    );
-- 46���� view�� �ۼ� 
create view vw_pu
as
select employee_id, first_name, email, hire_date, salary, commission_pct,
       salary*(1+nvl(commission_pct,0))*12 yearsal
from emp
where department_id in (
                    select department_id from dept where lower(department_name) like '%pu%'
                    );

select * from vw_pu;

-- 48. 90�� �μ��� ����ϼ���. �̸�, ��ȭ��ȣ, �μ���ȣ, �����ȣ 
select first_name, phone_number, department_id, employee_id from employees where department_id = 90;

create view vw_90
as
select first_name, phone_number, department_id, employee_id
from employees
where department_id = 90;

select * from vw_90;




--- ���� 
-- 1. ANSI-JOIN�� ����ؼ� �����ȣ, �̸�, �μ���ȣ, ��ġ�� ����ϴµ� ��簡 149�� ����鸸 ����Ͻÿ�.
select employee_id, first_name, e.department_id, location_id
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 149;

-- 2. ������ 4��°���� 6��°���� PRO�� �ִٸ� it_program���� ���
-- ACC �� �ִٸ� finance_account �������� business �� ����Ͻÿ�.
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
from employees; -- ��

-- 3. ������ REP�� ���ԵǾ� �ִ� ������� ��� �޿��� �ּұ޿� �ִ�޿� �޿��� �հ踦 ���Ͻÿ�.
select avg(salary), sum(salary), min(salary), max(salary) 
from employees
where job_id like '%REP%';

-- 5.  �μ��� �ִ� �޿��� 10000�̻��� �μ��� ����Ͻÿ�.
select department_id, max(salary)
from employees
group by department_id
having max(salary) >=10000;

-- 6. ������ 'SA'�����ϰ� ���� ���� ������� ������ �޿��� �հ谡 10000�� �ʰ��ϴ� ������ �޿��� �հ踦 ����Ͻÿ�.
-- ���� �޿��� �հ踦 ������������ �����Ͽ� ���
select job_id, sum(salary)
from employees
where job_id not like '%SA%'
group by job_id 
having sum(salary) > 10000
order by sum(salary) desc ;

-- 7. �μ��� 20�̰ų� 50�� �μ��� �����ȣ�� �μ���ȣ �� �μ��� �׸��� ��ġ������ ����Ͻÿ�.
select employee_id, d.department_id, department_name, location_id
from employees e, departments d
where e.department_id = d.department_id and d.department_id in (20,50);

-- 8. Matos��� ���� ������ �ִ� ����� �ִ�. �� ����� �μ������� �����ȣ �׸��� ���� ����Ͻÿ�.
select e.department_id, department_name, e.manager_id, location_id, employee_id, last_name
from employees e, departments d
where e.department_id = d.department_id and last_name = 'Matos';

-- 9. Matos��� ���� ������ �ִ� ����� King��� ���� ���� ����� �μ������� �����ȣ �׸��� ���� ����Ͻÿ�.
select e.department_id, department_name, e.manager_id, location_id, employee_id, last_name
from employees e join departments d
on e.department_id = d.department_id
where last_name = 'Matos' or last_name = 'King';

-- 10. King��� ���� ������ �ִ� ����� �μ������� �����ȣ �׸��� ���� ����Ͻÿ�. ANSI-JOIN�� ����� ��
select e.department_id, department_name, e.manager_id, location_id, employee_id, last_name
from employees e join departments d
on e.department_id = d.department_id
where last_name = 'King';

-- 12. �μ����̺��� �μ���ȣ�� �μ��� �׸��� �����ڵ�� �������� ����ϴµ� �����ڵ尡 1400�� ������ ��� T-SQL, ANSI JOIN
--����
select department_id , department_name, d.location_id, STREET_ADDRESS
from hr.departments d , hr.locations l
where d.location_id = l.location_id and d.location_id = 1400;

select department_id , department_name, d.location_id, STREET_ADDRESS
from hr.departments d join hr.locations l
on d.location_id = l.location_id and d.location_id = 1400; -- �� 

-- 14. ������ ������ ����� �� �μ������� �� �μ��� �ּҸ� ����Ͻÿ�.
-- �ּҰ� �����
select employee_id, first_name , 
       d.department_id, department_name,
       l.location_id, STREET_ADDRESS
from hr.employees e, hr.departments d, HR.locations l
where e.department_id = d.department_id 
and d.location_id = l.location_id; -- �� 

-- 15. ���������� ����� �� �� ������ �μ������� ���������� ����Ͻÿ�. �μ���ȣ, �μ���, ������ȣ, ��������
select * from jobs;
select department_id, department_name, job_id, job_title
from jobs j, departments d;
      
-- 16. ��������� �μ������� ����� �� ����� ���� �μ��� ����ϵ� 200�� �μ����� 260�μ��� �����ϰ� ����Ͻÿ�.
???
select employee_id, first_name, d.department_id , department_name
from hr.employees e left outer join hr.departments d
on e.department_id = d.department_id; -- �� 

-- 17. ��������� �μ������� ����� �� ����� ���� �μ��� ����ϵ� �����ȣ�� Ȧ���� �� �� ����Ͻÿ�.
???

-- 18. ������ ���������� ���������� ����ϴ� ���������� ���� ������ ����Ͻÿ�. job_history�� �̿�
??? 

-- 19. ������ 4��°���� 6��°���� PRO�� �ִٸ� it_program���� ���
--                             ACC�� �ִٸ� finance_account
--                             �������� business�� ����Ͻÿ�.
select employee_id,first_name,
case when job_id like '%PRO%' then 'it_program'
     when job_id like '%ACC%' then 'finance_account'
     else 'business' end job_
from employees;


-- 20. �޿��� 15000 �̻��̸� �ӿ����� ���
--           10000 �̻��̸� ����
--           7000  �̻��̸� ����
--           5000�̻��̸� �븮, �������� ������� ����Ͻÿ�.
select employee_id, first_name,
case when salary >= 15000 then '�ӿ�'
     when salary >= 10000 then '����'
     when salary >= 7000 then '����'
     when salary >= 5000 then '�븮'
     else '���' end rank
from employees;
     

-- 21. �μ��� �޿��� ����� 5000�̻��� �μ��� ����Ͻÿ�.
select department_id
from employees
group by department_id
having avg(salary) >= 5000;

-- 22. �޿��� 10000�̻��� ������� �μ��� �޿� ����� 16000�̻��� �μ��� ����Ͻÿ�
select department_id
from employees
where salary >= 10000
group by department_id
having avg(salary) >= 16000;

-- 23. �Ի����� 2005�⵵ ������ �Ի��� ����� �� �μ��� �ִ�޿��� 8000�̻��� �μ��� �ִ� �޿��� ����Ͻÿ�.
select department_id, max(salary)
from employees
--where hire_date < '050101'
where to_char(hire_date, 'yyyy') < '2005' -- �� 
group by department_id
having max(salary) >= 8000;

-- 24. �μ��� �ִ� �޿��� 10000�̻��� �μ��� ����Ͻÿ�.
select department_id, max(salary)
from employees
group by department_id
having max(salary) >= 10000;

-- 25. ������ 'REP'�����ϰ� ���� ���� ������� ������ �޿��� �հ谡 3000�� �ʰ��ϴ� ������ �޿��� �հ踦 ����Ͻÿ�.
-- ���� �޿��� �հ踦 ������������ �����Ͽ� ���
select job_id , sum(salary) from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) > 3000
order by sum(salary) desc ;

-- 26.  ������ 25-10-2020������ �ٹ��ϼ��� ����Ͻÿ�. ������ȣ, �μ���ȣ, �Ի���, �ٹ��ϼ�
select employee_id, department_id, hire_date, '25-10-2020'-hire_date
from employees;

-- 27. '01-01-2005'�� �Ի��� ����� ����Ͻÿ�. ������ȣ, �μ���ȣ, �Ի���, �ٹ��ϼ�
select employee_id, department_id, hire_date, sysdate-hire_date
from employees
where hire_date = '050101';

-- 28. ����(�޿�*12) : �޿��� Ŀ�̼Ǳ��� ���Եȴ�. ������ ����� ���Ͻÿ�. ������ȣ, �μ���ȣ, �޿�, ���
select employee_id, department_id, salary, salary * (1+nvl(commission_pct,0)) * 12 yearsal
from employees;

-- 29.  'IT_PROG' �̸� �޿���  1.10*salary
--      'ST_CLERK' �̸� �޿���  1.15*salary
--      'SA_REP' �̸�  �޿��� 1.20*salary
--      ������ ������ salary �� �޿��� �����ϰ� heading name��      "REVISED_SALARY"�� �ǰ� �Ͻÿ�.
--      case�� decode�� ��� ����Ͻÿ�.
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


-- 30 Ŀ�̼��� ������ �޿��� ����� ���Ͻÿ�. Ŀ�̼��� ���� ���� ������ ����
select avg(salary * (1+nvl(commission_pct,0)))
from employees;

-- 31. ���μ��� Ŀ�̼��� ������ �޿��� �հ踦 ���Ͻÿ�.
select department_id, sum(salary * (1+nvl(commission_pct,0)))
from employees
group by department_id;

-- 32. �� �μ��� �������� 5�� �̻��� �μ��� ����Ͻÿ�. (join�ƴ�)


-- 33. �� �μ��� �ִ� ����� ������ �޿��� ����� ���Ͻÿ�.


-- 34. �����ȣ, �̸� , �޿�, �Ի��� , �μ���ȣ, �μ���, ������ȣ, �������� ����� �� ������� �ʴ� ������ ����ϰ� ����� ���� ������ ����Ͻÿ�.


-- 35. ������̺��� ������ MAN�� �����ϰ� �޿��� 10000�̻��� ����� �����ȣ�� ���� ���� �׸��� �޿��� ����Ͻÿ�.


-- 36. ������ SA_REP�� AD_PRES �̸鼭 �޿��� 15000�� �ʰ��ϴ� ����� ����Ͻÿ�. ��, ��, ����, �޿��� ��� or�� and�� ���


-- 37. �� ������ in�����ڸ� ����Ͻÿ�.


-- 38. �μ��� ������������ �����ϰ� �Ի��ϵ� ������������ ���� �μ���ȣ , �޿�, �Ի���, ��


-- 39. �μ��� ������������ �����ϰ� �Ի����� ������������ �����Ͽ� ��� �μ���ȣ , �޿�, �Ի���, ��


-- 40. �μ��� ������������ �����ϰ� �Ի����� ������������ �����Ͽ� �޿��� ������������ �����Ͽ� ���. �μ���ȣ ,  �Ի���, �޿�, ��



















--- 11/25 ��

select employee_id, last_name, salary
from employees
where department_id = 80;

create view vw_80
as
select employee_id, last_name, salary
from employees
where department_id = 80;

select * from vw_80;
desc vw_80;

create view vw_50
as
select employee_id eid, last_name lname, salary sal
from employees
where department_id = 50;

select * from vw_50;

create view vw_70
(eid,lname,sal)
as
select employee_id, last_name, salary 
from employees
where department_id = 70;

select * from vw_70;
-- view �� ���� �����Ͱ� �ƴϱ� ������ ������ �� ��� �����ߴٰ� �ٽ� �����ؾ��Ѵ�. 
-- �װ� �ʹ� �������� or replace �� �����ش�.
-- �並 �����ߴٰ� �ٽ� ����� �Ͱ� ���� �����̴�. 

create or REPLACE view vw_70
(eid,lname,sal)
as
select employee_id, last_name, salary *12
from employees
where department_id = 70;

-- �׷��� ó�� ���� ������ or replace �� ������ش�. 
-- ��� ������ѵ� ������ �߻����� �ʴ´�.

create or REPLACE view vw_year_sal
(eid, faname, hire_date, year_sal)
as
select employee_id, first_name, hire_date, salary * (1+nvl(commission_pct,0)) * 12
from employees
where job_id like '%MAN%';


--- ���� view
-- �� �μ��� ���� �ӱݰ� �ִ� �ӱ�, �׸��� ��� �ӱ��� ����ϼ���.
create or replace view dept_sal_view
(dept_id,min,max,avg)
as
select department_name, min(salary), max(salary), trunc(avg(salary))
from employees e,departments d
group by department_name;

select * from dept_sal_view;

-- ������ȣ,�̸�,�Ի���,�޿�,�μ���ȣ,�μ����� ����ϴ� �並 ������
create or replace view emp_dept_view
as
select employee_id,first_name,hire_date,salary,department_id,department_name
from employees e, departments d
where e.department_id = d.department_id;

select * from emp_dept_view;

create or replace view vw_30
as
select employee_id, last_name, email,hire_date, job_id,department_id
from emp
where department_id = 30;

desc emp;
select * from vw_30;

-- �並 ���� ���� ���̺� �����Ͱ� �� �� �ִ�. 
insert into vw_30
values (310,'kim','@naver',sysdate,'AP',210);
select * from emp;

-- SQL ����: ORA-00904: "MANAGER_ID": �������� �ĺ���
-- �並 ���� �������� �ʴ� �÷����� �����͸� ������ �� ����. 
insert into vw_30(employee_id, last_name,email,
                  hire_date, job_id,department_id,manager_id)
values (320,'park','@daum',sysdate,'AP',210,110);

-- �並 ���ؼ� �������� �����ʹ� ������ �����ϴ�. 
update vw_30
set hire_date = sysdate
where employee_id = 115;
select*from vw_30;

-- SQL ����: ORA-00904: "MANAGER_ID": �������� �ĺ���
-- �並 ���ؼ� �������� �ʴ� �÷��� ������ �� ����. 
update vw_30
set manager_id = 100
where employee_id = 115;

-- delete : �� �� ��ü�� �����ϴ� ��
delete from vw_30
where employee_id = 115;
select * from vw_30;

-- �並 ���� �������� ������ ������ ���� �ʴ´�. 
-- 0�� �� ��(��) �����Ǿ����ϴ�.
select * from emp where employee_id = 310;
delete from vw_30
where employee_id = 310;

-- �並 ���ؼ� DML���� ����� �� �ִ�.
-- �� insert �� �信�� ������ �ʾƵ� ������ �ȴ�. 

create table viewup1(
    c1 number primary key,
    c2 number
);
create table viewup2 (
    c1 number primary key,
    c3 number
);
insert into viewup1 values(1,1);
insert into viewup2 values(1,1);

-- ���� �� ����
create view v_viewup
as
select t1.c1, t1.c2, t2.c3
from viewup1 t1, viewup2 t2
where t1.c1 = t2.c1;

select * from v_viewup;

-- ��1 �ٲٱ�
update v_viewup
set c2 = 10
where c1 = 1;

select * from v_viewup;
select * from viewup1;

-- ��2 �ٲٱ�
update v_viewup
set c3 = 10
where c1 = 1;

select * from v_viewup;
select * from viewup2;

-- �׷��ٸ� �ΰ��� ���̺��� ���ÿ� �����غ��� 
-- SQL ����: ORA-01776: ���� �信 ���Ͽ� �ϳ� �̻��� �⺻ ���̺��� ������ �� �����ϴ�.
-- ���� ���� ��쿡�� �ΰ��� ���̺��� ���ÿ� ������ �� ����. 
update v_viewup
set c3 = 20, c2 = 20
where c1 = 1;

-- ���ÿ� insert�� �غ���
-- SQL ����: ORA-01776: ���� �信 ���Ͽ� �ϳ� �̻��� �⺻ ���̺��� ������ �� �����ϴ�.
insert into v_viewup values(2,2,2);

-- insert ���� 
insert into v_viewup(c1,c2) values (2,2);
select * from v_viewup;
select * from viewup1;
-- c1 �� viewup1 �� �ִ� ���� ����ϱ� ������ viewup2 ������ c1�� ����� �� ����.  
insert into v_viewup(c1,c3) values (2,2);
select * from v_viewup;
select * from viewup2;

delete from v_viewup
where c1 = 1; -- viewup1�� �ִ� c1
select * from v_viewup;
select * from viewup1;
select * from viewup2; -- viewup2�� �ִ� �� �������� �ʴ´�. 
-- ���պ�� DML���� ���������� ���ȴ�. 

create or replace view empvw20
as
select * from emp where department_id = 20
with check option constraint empvw20_ck; -- constraint empvw20_ck : �̸� �ֱ� 
-- with check option�� �信�� ���̰� �Ǵ� �����ͷθ� ����, ����, ������ �����ϴ�. 

select * from empvw20;
-- with check option ���� �� :  ����
insert into empvw20 (employee_id, last_name, email, hire_date,
                     job_id, department_id)
values (320,'park','@daum',sysdate,'AP',120);
select * from emp where employee_id = 320;

-- with check option ���� �� : �Ұ���
insert into empvw20 (employee_id, last_name, email, hire_date,
                     job_id, department_id)
values (340,'park','@daum',sysdate,'AP',120);
select * from emp where employee_id = 340;

-- �������� �� �信�� �������� �ʴ� �����ʹ� ����üũ�ɼ� �� ������ �� ����. 
-- ORA-01402: ���� WITH CHECK OPTION�� ���ǿ� ���� �˴ϴ�
update empvw20
set department_id = 50
where employee_id = 201;

create view empvw80
as
select * from emp
where department_id = 80
with read ONLY;

select * from empvw80;
-- SQL ����: ORA-42399: �б� ���� �信���� DML �۾��� ������ �� �����ϴ�.
-- read ONLY �̹Ƿ� �б⸸ ���� (select ���� ��� ����)
delete from empvw80
where employee_id = 147;

-- �� ����
drop view empvw80;
select * from empvw80; -- ���� 
-- select : ���̺��̳� �信 �ִ� �����͸� �˻��ϱ� ���� ����Ѵ�. 


--- �ζ��� �� inline view 
-- ��,�޿�,�μ���ȣ,�μ��� �ּұ޿�
select last_name,salary, e.department_id, minsal
from employees e, (select department_id,min(salary) minsal 
                   from employees
                   group by department_id) d
where e.department_id = d.department_id;
-- from ���� ���������� ����� �� �ִ� : �ζ��� �� inline view ! 

-- ������ȣ,�̸�,����,�Ի���,�޿� �׸��� �� �μ��� ����� �� ��� �޿��� ���
select employee_id,first_name,job_id,hire_date,salary,e.department_id,cnt,avgsal
from employees e, (select department_id, count(*) cnt,avg(salary) avgsal
                   from employees
                   group by department_id) d -- �ζ��� ��
where e.department_id = d.department_id;

-- �����ȣ,�̸�,�޿�,�μ�,������ �޿��� ���� ���� �޴� ������� ����ϼ���.
select employee_id,first_name,salary,department_id,job_id
from employees
order by salary desc; 


-- top-n
-- rownum : �÷��� ���� 
-- �޿��� ���� ���� �޴� ��� 5���� ���������� 
select rownum, employee_id,first_name,salary,department_id,job_id
from (select employee_id, first_name,salary,department_id,job_id
      from employees
      order by salary desc)
where rownum <= 5;

-- ���� ���̺��� �ֱ� �Խñ��� ���� 5�� ��������
--select rownum, subject
--from (select subject,reg_date
--      from board
--      order by reg_date desc)
--where rownum <= 5;

-- �޿��� ���� ���� �޴� ��� 10������ 15������ ����ϼ���
-- �����ȣ, �̸�, �޿�, �μ�, ����
-- rownum �� ���� ���� �������� �� �� �� ��������(�ζ��κ��)�� ���������Ѵ�. 
select rownum, rn, employee_id, first_name,salary,department_id,job_id
from (select rownum rn, employee_id, first_name,salary,department_id,job_id
      from (select employee_id, first_name,salary,department_id,job_id
      from employees
      order by salary desc)
     )
where rn >= 10 and rn <= 15; 
--where rn between 10 and 15;
--- rownum�� paging�� �� ����Ѵ�. 

-- �����ȣ, �̸�, �޿�, �μ�, ���� ��½� Ŀ�̼��� ���� ���� �޴� ��� 5���� ����ϼ���.
select rownum, employee_id,first_name,salary,department_id,job_id,commission_pct
from (select employee_id, first_name,salary,department_id,job_id,commission_pct
      from employees
      order by nvl(commission_pct,0) desc)
where rownum <= 5;

select rownum, employee_id,first_name,salary,department_id,job_id,commission_pct
from (select employee_id, first_name,salary,department_id,job_id,commission_pct
      from employees
      where commission_pct is not null
      order by commission_pct desc)
where rownum <= 5;

-- ����ȣ, �̸�, �޿�, �μ�, ���� ��½� Ŀ�̼��� ������ ������ ���� ���� �޴� ��� 6������ 10�������� ����ϼ���. 

select *
from (select rownum rn, employee_id, first_name,salary,department_id,job_id
      from(select rownum rn, employee_id, first_name,salary,department_id,job_id,
           salary*(1+nvl(commission_pct,0))*12 year_sal
           from employees 
           order by year_sal desc)
      )
where rn between 6 and 10;
--- DML�� 

---group by ���� ���� ���
-- �μ��� ������ ���� �޿��� �հ�� �μ���ȣ, ������ ����ϼ���.
select sum(salary), department_id, job_id
from employees 
group by department_id, job_id;

-- �μ��� �޿��� ����� 9500 �̻��� �μ��� ����ϼ���.
select department_id, avg(salary)
from employees
group by department_id
having avg(salary) >= 9500;

-- �μ��� ������ �޿��� ��հ� �μ��� �޿��� ��� �׸��� ��ü ����� ���ϼ���.
select avg(salary),department_id, job_id
from employees
group by department_id, job_id;

select department_id
from employees
group by department_id;

select avg(salary)
from employees;

-- ���� ������ ���� ����Ϸ��� union ���
select department_id, job_id,         avg(salary)
from employees
group by department_id, job_id
union
select department_id, to_char(null),  avg(salary)
from employees
group by department_id
union
select to_number(null), to_char(null), avg(salary)
from employees;
-- ��� ����� ���� 1.�μ��� ������ ���� ��� �޿� 2.�μ��� ��� �޿� 3.��� �޿� ������ ����ϰ� �ȴ�.
----------------------------------------------
--- ROLLUP ���� �̰� ���
select department_id, job_id, avg(salary)
from employees
group by ROLLUP (department_id, job_id);
--- (department_id, job_id,)
--- (department_id)
--- ()
-- �ڿ������� �ϳ��� ������ 

-- �� �μ����� ���� ������ �ϸ鼭 �Ի����� ���� ����� �޿� ��ո� ���ϼ���.
-- �� �μ��� ������ �޿� ���
-- �� �μ��� �޿� ���
-- ��ü �޿� ���
select department_id, job_id, hire_date, count (*), avg(salary)
from employees
group by ROLLUP (department_id, job_id, hire_date);
--(department_id, job_id, hire_date)
--(department_id, job_id)
--(department_id)
--()

select department_id, job_id, hire_date, count (*), avg(salary)
from employees
group by department_id, job_id, hire_date
UNION
select department_id, job_id, null, count (*), avg(salary)
from employees
group by department_id, job_id
UNION
select department_id, null, null, count (*), avg(salary)
from employees
group by department_id
UNION
select null, null, null, count (*), avg(salary)
from employees;

-- �μ��� ������ �޿��� �հ�
-- �μ��� �޿��� �հ�
-- ������ �޿��� �հ�
-- ��ü �޿��� �հ�

select department_id,            job_id,            sum(salary)
from employees
group by department_id, job_id
UNION
select department_id,               null,           sum(salary)
from employees
group by department_id
UNION
select null,                      job_id,           sum(salary)
from employees
group by job_id
UNION
select null,                        null,           sum(salary)
from employees;
-- ��� ������ ���� ������ ���´� : ����ü ������
-- CUBE
select department_id, job_id, sum(salary)
from employees
group by CUBE (department_id, job_id);
-- (department_id, job_id)
-- (department_id)
-- (job_id)
-- ()

-- �� �μ����� ���� ������ �ϸ鼭 �Ի����� ���� ����� �޿� ��ո� ���ϼ���.
-- �� �μ��� ������ ����� ��, �޿� ���
-- �� �μ����� �Ի����� ���� ����� ���� �޿� ���
-- �� ������ �Ի����� ���� ����� ���� �޿� ���
-- �� �μ��� ����� ���� �޿� ���
-- �� ������ ����� ���� �޿� ���
-- �Ի����� ���� ����� �޿� ��� 
-- ��ü ����� ���� �޿� ���

select department_id, job_id, hire_date, count(*), avg(salary)
from employees
group by CUBE (department_id, job_id, hire_date);
-- (department_id, job_id, hire_date)
-- (department_id, job_id)
-- (job_id, hire_date)
-- (department_id,hire_date)
-- (department_id)
-- (job_id)
-- (hire_date)
-- ()

--- grouping �Լ� : ����� �÷��� Ȯ�� 
-- grouping sets ((),(),());
select department_id, job_id, sum(salary)
       , grouping(department_id)
       , grouping(job_id)
from employees
group by ROLLUP(department_id, job_id);

-- �� �μ��� ������ ��縦 ������ �ִ� ����� �޿� ���
-- �� �μ��� ���� ��縦 ���� ������� �޿��� ��� 
-- ������ ���� ��縦 ���� ������� �޿��� ����� ���ϼ���.
-- ���ϴ� ���踸 ����� �� �ִ�. 
select department_id, job_id, manager_id, avg(salary)
from employees
group by grouping sets ((department_id, job_id, manager_id),
                        (department_id, manager_id),
                        (job_id, manager_id));

-- ���� �� ������ ���踦 ����
-- a, (b,c) ,d
-- a,(b,c),d
-- a,(b,c) ���� 
-- (b,c)�� ���� ���� �� ����
-- a
select department_id, job_id, manager_id, sum(salary)
from employees
group by ROLLUP (department_id,(job_id,manager_id));
-- (department_id,(job_id,manager_id))
-- (job_id,manager_id)
-- (department_id)
-- ()

select department_id, job_id, manager_id, sum(salary)
from employees
group by department_id, rollup(job_id), cube(maanger_id);

-- �ΰ� �ǹ� ���� 
-- group by department_id, rollup(job_id), rollup(maanger_id)
-- group by rollup(department_id, job_id, maanger_id)

-- department_id, job_id, maanger_id
-- department_id, job_id
-- department_id, 
-- department_id, manager_id
-- rollup�� ���� �� ������� cube�� ����ȴ�.

-- 104�� ����� �μ��� ��簡 ���� ����� ����ϼ���.
select * from employees
where department_id = (select department_id from employees
                       where employee_id = 104)
and manager_id = (select manager_id from employees
                  where employee_id = 104);

-- 50�� �μ����� �ϴ� ������ ���� ������ �ϴ� ���
select * from employees
where job_id in (select job_id from employees
                 where department_id = 50);

select job_id from employees where department_id = 50;

-- ������ȣ�� 178�Ǵ� 174 �� ����� ������ �� �μ��� ���� ������ �� �μ��� ���� ����� ������ ����ϼ���
select * from employees
where manager_id = (select manager_id from employees where employee_id = 174)
UNION
select * from employees
where manager_id = (select manager_id from employees where employee_id = 178)
and department_id = (select department_id from employees where employee_id = 178);
-- �̷��� �ΰ� �̻��� �÷��� ���ؼ� �������°� �ֺ񱳶���Ѵ�.
--- �ֺ�
select * from employees
where (manager_id, department_id) in (select manager_id, department_id
                                      from employees
                                      where employee_id in(174,178)
)and employee_id not in (174,178);



--- window �Լ�
-- 1. Rank() -- ������ ���� ��� ������ ����, ���� ����� 1,2,3,4
-- �޿��� ���� �������� ������ ����ϼ���.
select first_name, salary, job_id,
       rank() over (order by salary desc) all_rank
from employees;
-- rownum �� window�Լ��� ����ϴ� 
select rownum, first_name, salary, job_id
from (select first_name, salary, job_id
      from employees
      order by salary desc);
      
-- ������ �޿��� ������ ������������ ����ϼ���.
--select first_name, salary, job_id
--from employees
--group by job_id
--order by salary desc;

-- partition by = group by 
-- rank() over���� group by �� ����� �� ����. 
select first_name, salary, job_id
       ,rank() over (partition by job_id order by salary desc) JOB_RANK
from employees;

-- ���μ����� �Ի����� ���� ������� �̸�, ����, �Ի����� ��ŷ ������ ����ϼ���.
select first_name, job_id, hire_date, department_id
       ,rank() over (partition by department_id order by hire_date asc) HIRE_RANK
from employees;

-- �޿��� ���� ���� �޴� ������� ������, ������ �޿��� ������ ����ϼ���.
select first_name,salary,job_id,
       rank() over (order by salary desc) ALL_RANK,
       rank() over (partition by job_id order by salary desc) JOB_RANK 
from employees;
-- ��Ƽ�� ���ذ��� �ذͺ��� ������ ���Ƽ� ���� ���ĵȴ�. 

--- 2. dense_rank ()
-- rank : ������ ������ �ǳ� �ٰ� ���� ��ŷ�� ������
-- dende_rank : ������ �־ �ǳʶ��� �ʰ� ��ȣ�� ���ӵȴ�. 
select first_name,salary,job_id,
       rank() over (order by salary desc) ALL_RANK,
       dense_rank() over (order by salary desc) DENSE_RANK
from employees;

-- 3. row_number() ������ ��� �����ϴ� ���� ���´�.
select first_name,salary,job_id,
       rank() over (order by salary desc) ALL_RANK,
       row_number() over (order by salary desc) ROW_NUMBER
from employees;

-- ���,�̸�,�̸���,����,�μ����� ��� �޿��� ����ϼ���.
select employee_id, first_name, email ,job_id, salary, e.department_id, avgsal
from employees e, (select department_id, avg(salary) avgsal
                 from employees
                 group by department_id ) d
where e.department_id = d.department_id
-- where �� ������ department_id �� null�̸� ������. 
order by employee_id;
-- �̷��� ����ؿԴµ� window�Լ��� �̿��ϸ� �ξ� �����ϰ� ����� �� �ִ�.
-- window�Լ� ���
select employee_id, first_name, email, job_id, salary, department_id,
       avg(salary) over (partition by department_id) avgsal
from employees
order by employee_id;


--- ����
--���� 1) ȸ�� ���̺��� ����ÿ�. �� �÷��� ���� ������ �ο� �Ͻÿ�.
--Table MEMBER
--================================
--USER_ID     	NOT NULL 	VARCHAR2(20)  
--USER_PW     	NOT NULL 	VARCHAR2(200) 
--USER_NAME   	NOT NULL 	VARCHAR2(40)  
--USER_BIRTH  	NOT NULL 	TIMESTAMP 
--USER_GENDER 	NOT NULL 	VARCHAR2(1)   
--USER_ADDR   	NOT NULL 	VARCHAR2(200) 
--USER_PH1    	NOT NULL 	VARCHAR2(13)  
--USER_PH2             			VARCHAR2(13)  
--USER_REGIST          		TIMESTAMP  
--USER_EMAIL           		VARCHAR2(200) 
--JOIN_OK              			VARCHAR2(500)
--
--USER_ID     : primary key (MEMBER_USER_ID_PK)
--USER_EMAIL : unique (member_USER_EMAIL_UU)
--USER_REGIST  : ����Ʈ ���� sysdate
create table member (
    user_id         varchar2(20)        not null,               -- PK
    user_pw         varchar2(200)       not null,
    user_name       varchar2(40)        not null,
    user_birth      timestamp           not null,
    user_gender     varchar2(1)         not null,
    user_addr       varchar2(200)       not null,
    user_ph1        varchar2(13)        not null,
    user_ph2        varchar2(13),
    user_regist     timestamp           default sysdate,
    user_email      varchar2(200),                              -- UU
    join_ok         varchar2(500),
    constraint MEMBER_USER_ID_PK primary key (user_id),
    constraint MEMBER_USER_EMAIL_UU unique (user_email)
);
drop table member;


--����2) �Խ��� ���̺��� ����� �� �÷��� ���������� �ο� �Ͻÿ�.
--Table BOARD
--====================================
--BOARD_NUM     	NOT NULL 	NUMBER         
--USER_ID       	NOT NULL 	VARCHAR2(20)   
--BOARD_NAME    	NOT NULL 	VARCHAR2(20)    --- �� ���� 
--BOARD_PASS    	NOT NULL 	VARCHAR2(200)  
--BOARD_SUBJECT 	NOT NULL 	VARCHAR2(100)  -- ����
--BOARD_CONTENT          		VARCHAR2(2000) -- ����
--BOARD_DATE             		TIMESTAMP   
--IP_ADDR                		VARCHAR2(15)   
--READ_COUNT             		NUMBER      
--
--BOARD_NUM : primary key (BOARD_BOARD_NUM_PK)
--USER_ID : foreign key (BOARD_USER_ID_FK)
--READ_COUNT ; ����Ʈ ���� 0
create table board (
    board_num         number            not null,               -- PK
    user_id           varchar2(20)      not null,               -- FK
    board_name        varchar2(20)      not null,               -- �۾���
    board_pass        varchar2(20)      not null,
    board_subject     varchar2(100)     not null,               -- ����
    board_content     varchar2(2000)    not null,               -- ����
    board_date        timestamp,
    ip_addr           varchar2(15),
    read_count        number            default 0,
    constraint BOARD_BOARD_NUM_PK primary key (board_num),
    constraint BOARD_USER_ID_FK foreign key (user_id) references member(user_id)
);
drop table board;

--���� 3) ȸ�����̺� �Ʒ� ������ �����Ͽ� 5���� �����͸� �����ÿ�.
--insert into member (user_id,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
--values('highland0','111111','�̼���','1999-12-12','1','����','010-1234-1234',null,default,null);

insert into member (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland0','111111','�̼���','1999-12-12','1','����','010-1234-1234',null,default,null);
insert into member (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('oracle222','222222','�迹��','1995-09-25','2','����','010-1111-1111',null,default,'ab3s');
insert into member (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('oracle333','333333','�̿���','2000-12-26','2','���','010-2222-2222',null,default,null);
insert into member (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('oracle444','444444','�ڿ���','1985-04-30','1','����','010-3333-3333',null,default,'naver');
insert into member (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('oracle555','555555','�Ͽ���','1993-03-07','2','����','010-4444-4444','010-5555-5555',default,'daum');
select * from member;

--����4)�Խ��� ���̺� �����͸� �Ʒ� ���� ���� 6�� �̻��� �ִµ� �� ȸ������ �ּ� �Ѱ� �̻� �Խñ��� ��ϵǰ� �Ͻÿ�.
--insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR)
--values(1, 'highland0', '����� �ƺ�', '1111','����', '����', '192.168.3.117');
insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR)
values(1, 'highland0', '����� �ƺ�', '1111','����', '����', '192.168.3.117');
insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR)
values(2, 'oracle222', '�迹�� ����', '2222','����1', '�迹���� ���� ����', '196.169.5.235');
insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR)
values(3, 'oracle222', '�迹�� ����', '2222','����2', '�迹���� ���� ����', '196.169.5.235');
insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR)
values(4, 'oracle333', '�̿��� �����', '3333','����3', '�̿����� ����� ����', '162.765.4.126');
insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR)
values(5, 'oracle444', '�ڿ��� ������', '4444','����4', '�ڿ����� ������ ����', '147.547.6.762');
insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR)
values(6, 'oracle555', '�Ͽ��� ����', '5555','����5', '�Ͽ����� ������ ����', '251.923.1.672');
select * from board;

--����5) highland0 ȸ���� ȸ�����̵�, ȸ����, �̸���, �Խñ� ��ȣ, �Խñ� ����, READ_COUNT�� ����Ͻÿ�.
desc member;
desc board;
select m.user_id, user_name, user_email, board_name, board_subject, read_count  
from member m, board b
where m.user_id = b.user_id and m.user_id = 'highland0';

--����6) �Խñ��� ������ READ_COUNT�� 1�� ���� �� ���̴�. 
--         update���� ���� �� ������ READ_COUNT 1���� �Ҽ� �ְ� update���� �ۼ��Ͻÿ�.
--         1�� �Խñ��� ���� ��Ű�ÿ�.
update board
set read_count = read_count +1
where board_num =1;
select board_num, read_count from board;

--���� 7) �Խñ� 2���� �ش��ϴ� ȸ���� ����Ͻÿ�.
select * from member
where user_id = (select user_id from board where board_num =2);

--���� 8) ��ϵ� �Խñ��� ������ ����Ͻÿ�.
select count(*)
from board
where borad_num;

--���� 9) �� ȸ���� �Խñ��� ������ ����Ͻÿ�. (���� �ƴ�)


--���� 10) ȸ���� ���� ����Ͻÿ�.


--���� 11) ���̵� 'highland0'�� ȸ���� ��ȭ��ȣ�� '02-9876-1234', �̸����� 'highland0@nate.com', ��й�ȣ�� '22222'�� �����Ͻÿ�.
dd

--���� 12) �Խñ� 1���� ������ '���� ������ �����ҷ�', ������ '������ �����ؼ� \n ���� ����� �� �� �ְ� ����ؾ���'��  �����Ͻÿ�.


--���� 13) 1�� �Խñ��� ����� �� ������ \n�� <br /> �� ��µǰ� �Ͻÿ�.


--���� 14)  �Խñ� ������ �ʹ� �� ȭ�鿡 �� ��µǱ� ��ƴ� . ������ ù��° ���� ���� 5���ڸ� ����ϰ� �ڿ��� *�� 5���� ��µǰ� �Ͻÿ�.


--���� 15) '�̼���'ȸ���� ���̵� �ؾ���ȴٰ� �Ѵ�. �̸��ϰ� ��ȭ��ȣ�� �̿��ؼ� ���̵� ����ϴ� �� ���̵�� ��� ����ؼ��� �ȵǰ� ù���ں��� ������ �������� '*'�� ��µǰ� �Ͻÿ�.


--���� 16) �Խ��� ���̺��� �Խñ��� ���� �� �Խñ��� user_id�� �Խñ� ������ ���� ����Ͻÿ�.


--���� 17) ���ݱ����� �۾��� ��� ���� ���� ��Ű�ÿ�.


--���� 18) '�̼���'ȸ���� Ż���Ϸ��� �Ѵ�. �̼��� ȸ���� Ż�� �Ҽ� �ְ� �����Ͻÿ�.
dd

--���� 19) '�̼���' ȸ���� Ż���ϴ� ���� �ƴϾ��� �� �� �� ������ �Ͽ��� . ���������� '�̼���'ȸ���� ���� ��� ������(�Խ��� ����) ���� �� �� �ְ� �Ͻÿ�.


--���� 20) ��highland0���� ȸ���� �α����� �Ͽ� �ڽ��� �� ���� 1�� �Խñ��� �����Ϸ��� �Ѵ�.
--�ش� �Խù��� ���� �ǰ� �Ͻÿ�.


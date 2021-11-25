--- 11/25 뷰

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
-- view 는 실제 데이터가 아니기 때문에 수정할 수 없어서 삭제했다가 다시 생성해야한다. 
-- 그게 너무 귀찮으니 or replace 를 적어준다.
-- 뷰를 삭제했다가 다시 만드는 것과 같은 과정이다. 

create or REPLACE view vw_70
(eid,lname,sal)
as
select employee_id, last_name, salary *12
from employees
where department_id = 70;

-- 그래서 처음 만들 때부터 or replace 를 사용해준다. 
-- 계속 실행시켜도 에러가 발생하지 않는다.

create or REPLACE view vw_year_sal
(eid, faname, hire_date, year_sal)
as
select employee_id, first_name, hire_date, salary * (1+nvl(commission_pct,0)) * 12
from employees
where job_id like '%MAN%';


--- 복합 view
-- 각 부서명에 최저 임금과 최대 임금, 그리고 평균 임금을 출력하세요.
create or replace view dept_sal_view
(dept_id,min,max,avg)
as
select department_name, min(salary), max(salary), trunc(avg(salary))
from employees e,departments d
group by department_name;

select * from dept_sal_view;

-- 직원번호,이름,입사일,급여,부서번호,부서명을 출력하는 뷰를 만들자
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

-- 뷰를 통해 실제 테이블에 데이터가 들어갈 수 있다. 
insert into vw_30
values (310,'kim','@naver',sysdate,'AP',210);
select * from emp;

-- SQL 오류: ORA-00904: "MANAGER_ID": 부적합한 식별자
-- 뷰를 통해 보여지지 않는 컬럼에는 데이터를 저장할 수 없다. 
insert into vw_30(employee_id, last_name,email,
                  hire_date, job_id,department_id,manager_id)
values (320,'park','@daum',sysdate,'AP',210,110);

-- 뷰를 통해서 보여지는 데이터는 수정이 가능하다. 
update vw_30
set hire_date = sysdate
where employee_id = 115;
select*from vw_30;

-- SQL 오류: ORA-00904: "MANAGER_ID": 부적합한 식별자
-- 뷰를 통해서 보여지지 않는 컬럼은 수정할 수 없다. 
update vw_30
set manager_id = 100
where employee_id = 115;

-- delete : 한 행 자체를 삭제하는 것
delete from vw_30
where employee_id = 115;
select * from vw_30;

-- 뷰를 통해 보여지지 않으면 삭제가 되지 않는다. 
-- 0개 행 이(가) 삭제되었습니다.
select * from emp where employee_id = 310;
delete from vw_30
where employee_id = 310;

-- 뷰를 통해서 DML문을 사용할 수 있다.
-- 단 insert 만 뷰에서 보이지 않아도 저장이 된다. 

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

-- 복합 뷰 생성
create view v_viewup
as
select t1.c1, t1.c2, t2.c3
from viewup1 t1, viewup2 t2
where t1.c1 = t2.c1;

select * from v_viewup;

-- 뷰1 바꾸기
update v_viewup
set c2 = 10
where c1 = 1;

select * from v_viewup;
select * from viewup1;

-- 뷰2 바꾸기
update v_viewup
set c3 = 10
where c1 = 1;

select * from v_viewup;
select * from viewup2;

-- 그렇다면 두개의 테이블을 동시에 수정해보자 
-- SQL 오류: ORA-01776: 조인 뷰에 의하여 하나 이상의 기본 테이블을 수정할 수 없습니다.
-- 복합 뷰일 경우에는 두개의 테이블을 동시에 수정할 수 없다. 
update v_viewup
set c3 = 20, c2 = 20
where c1 = 1;

-- 동시에 insert를 해보자
-- SQL 오류: ORA-01776: 조인 뷰에 의하여 하나 이상의 기본 테이블을 수정할 수 없습니다.
insert into v_viewup values(2,2,2);

-- insert 성공 
insert into v_viewup(c1,c2) values (2,2);
select * from v_viewup;
select * from viewup1;
-- c1 은 viewup1 에 있는 것을 사용하기 때문에 viewup2 에서는 c1을 사용할 수 없다.  
insert into v_viewup(c1,c3) values (2,2);
select * from v_viewup;
select * from viewup2;

delete from v_viewup
where c1 = 1; -- viewup1에 있는 c1
select * from v_viewup;
select * from viewup1;
select * from viewup2; -- viewup2에 있는 건 삭제되지 않는다. 
-- 복합뷰는 DML문이 제한적으로 사용된다. 

create or replace view empvw20
as
select * from emp where department_id = 20
with check option constraint empvw20_ck; -- constraint empvw20_ck : 이름 주기 
-- with check option은 뷰에서 보이게 되는 데이터로만 수정, 삭제, 삽입이 가능하다. 

select * from empvw20;
-- with check option 설정 전 :  가능
insert into empvw20 (employee_id, last_name, email, hire_date,
                     job_id, department_id)
values (320,'park','@daum',sysdate,'AP',120);
select * from emp where employee_id = 320;

-- with check option 설정 후 : 불가능
insert into empvw20 (employee_id, last_name, email, hire_date,
                     job_id, department_id)
values (340,'park','@daum',sysdate,'AP',120);
select * from emp where employee_id = 340;

-- 수정됐을 때 뷰에서 보여지지 않는 데이터는 위드체크옵션 후 수정할 수 없다. 
-- ORA-01402: 뷰의 WITH CHECK OPTION의 조건에 위배 됩니다
update empvw20
set department_id = 50
where employee_id = 201;

create view empvw80
as
select * from emp
where department_id = 80
with read ONLY;

select * from empvw80;
-- SQL 오류: ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.
-- read ONLY 이므로 읽기만 가능 (select 절만 사용 가능)
delete from empvw80
where employee_id = 147;

-- 뷰 삭제
drop view empvw80;
select * from empvw80; -- 없당 
-- select : 테이블이나 뷰에 있는 데이터를 검색하기 위해 사용한다. 


--- 인라인 뷰 inline view 
-- 성,급여,부서번호,부서의 최소급여
select last_name,salary, e.department_id, minsal
from employees e, (select department_id,min(salary) minsal 
                   from employees
                   group by department_id) d
where e.department_id = d.department_id;
-- from 절에 서브쿼리를 사용할 수 있다 : 인라인 뷰 inline view ! 

-- 직원번호,이름,직무,입사일,급여 그리고 각 부서의 사원수 및 평균 급여를 출력
select employee_id,first_name,job_id,hire_date,salary,e.department_id,cnt,avgsal
from employees e, (select department_id, count(*) cnt,avg(salary) avgsal
                   from employees
                   group by department_id) d -- 인라인 뷰
where e.department_id = d.department_id;

-- 사원번호,이름,급여,부서,직무를 급여가 제일 많이 받는 사람부터 출력하세요.
select employee_id,first_name,salary,department_id,job_id
from employees
order by salary desc; 


-- top-n
-- rownum : 컬럼의 순서 
-- 급여를 제일 많이 받는 사람 5명을 가져오세요 
select rownum, employee_id,first_name,salary,department_id,job_id
from (select employee_id, first_name,salary,department_id,job_id
      from employees
      order by salary desc)
where rownum <= 5;

-- 보드 테이블에서 최근 게시글의 제목만 5개 가져오기
--select rownum, subject
--from (select subject,reg_date
--      from board
--      order by reg_date desc)
--where rownum <= 5;

-- 급여를 제일 많이 받는 사원 10위부터 15위까지 출력하세요
-- 사원번호, 이름, 급여, 부서, 직무
-- rownum 이 범위 값을 가지려면 한 번 더 서브쿼리(인라인뷰로)를 만들어줘야한다. 
select rownum, rn, employee_id, first_name,salary,department_id,job_id
from (select rownum rn, employee_id, first_name,salary,department_id,job_id
      from (select employee_id, first_name,salary,department_id,job_id
      from employees
      order by salary desc)
     )
where rn >= 10 and rn <= 15; 
--where rn between 10 and 15;
--- rownum은 paging할 때 사용한다. 

-- 사원버호, 이름, 급여, 부서, 직무 출력시 커미션을 제일 많이 받는 사원 5명을 출력하세요.
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

-- 원버호, 이름, 급여, 부서, 직무 출력시 커미션을 포함한 연봉을 제일 많이 받는 사람 6위에서 10위까지만 출력하세요. 

select *
from (select rownum rn, employee_id, first_name,salary,department_id,job_id
      from(select rownum rn, employee_id, first_name,salary,department_id,job_id,
           salary*(1+nvl(commission_pct,0))*12 year_sal
           from employees 
           order by year_sal desc)
      )
where rn between 6 and 10;
--- DML문 

---group by 절의 향상된 기능
-- 부서별 직무에 대한 급여의 합계와 부서번호, 직무를 출력하세요.
select sum(salary), department_id, job_id
from employees 
group by department_id, job_id;

-- 부서별 급여의 평균이 9500 이상인 부서만 출력하세요.
select department_id, avg(salary)
from employees
group by department_id
having avg(salary) >= 9500;

-- 부서별 직무의 급여의 평균과 부서별 급여의 평균 그리고 전체 평균을 구하세요.
select avg(salary),department_id, job_id
from employees
group by department_id, job_id;

select department_id
from employees
group by department_id;

select avg(salary)
from employees;

-- 위의 세개를 같이 출력하려면 union 사용
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
-- 출력 결과를 보면 1.부서별 직무에 대한 평균 급여 2.부서별 평균 급여 3.평균 급여 순으로 출력하게 된다.
----------------------------------------------
--- ROLLUP 안이 이게 몬대
select department_id, job_id, avg(salary)
from employees
group by ROLLUP (department_id, job_id);
--- (department_id, job_id,)
--- (department_id)
--- ()
-- 뒤에꺼부터 하나씩 없어짐 

-- 각 부서에서 같은 직무를 하면서 입사일이 같은 사원의 급여 평균를 구하세요.
-- 각 부서의 직무별 급여 평균
-- 각 부서의 급여 평균
-- 전체 급여 평균
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

-- 부서별 직무의 급여의 합계
-- 부서별 급여의 합계
-- 직무별 급여의 합계
-- 전체 급여의 합계

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
-- 모든 가능한 수의 조합을 묶는다 : 육면체 ㅇㅅㅇ
-- CUBE
select department_id, job_id, sum(salary)
from employees
group by CUBE (department_id, job_id);
-- (department_id, job_id)
-- (department_id)
-- (job_id)
-- ()

-- 각 부서에서 같은 직무를 하면서 입사일이 같은 사원의 급여 평균를 구하세요.
-- 각 부서의 직무별 사원의 수, 급여 평균
-- 각 부서에서 입사일이 같은 사원의 수와 급여 평균
-- 각 직무별 입사일이 같은 사원의 수와 급여 평균
-- 각 부서의 사원의 수와 급여 평균
-- 각 직무의 사원의 수와 급여 평균
-- 입사일이 같은 사원의 급여 평균 
-- 전체 사원의 수와 급여 평균

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

--- grouping 함수 : 집계된 컬럼을 확인 
-- grouping sets ((),(),());
select department_id, job_id, sum(salary)
       , grouping(department_id)
       , grouping(job_id)
from employees
group by ROLLUP(department_id, job_id);

-- 각 부서의 직무별 상사를 가지고 있는 사원의 급여 평균
-- 각 부서별 같은 상사를 가진 사원들의 급여의 평균 
-- 직무별 같은 상사를 가진 사원들의 급여의 평균을 구하세요.
-- 원하는 집계만 사용할 수 있다. 
select department_id, job_id, manager_id, avg(salary)
from employees
group by grouping sets ((department_id, job_id, manager_id),
                        (department_id, manager_id),
                        (job_id, manager_id));

-- 묶인 건 무조건 집계를 하자
-- a, (b,c) ,d
-- a,(b,c),d
-- a,(b,c) 집계 
-- (b,c)에 대해 집계 후 지움
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

-- 두개 의미 같음 
-- group by department_id, rollup(job_id), rollup(maanger_id)
-- group by rollup(department_id, job_id, maanger_id)

-- department_id, job_id, maanger_id
-- department_id, job_id
-- department_id, 
-- department_id, manager_id
-- rollup은 집계 후 사라지고 cube는 집계된다.

-- 104번 사원의 부서와 상사가 같은 사원을 출력하세요.
select * from employees
where department_id = (select department_id from employees
                       where employee_id = 104)
and manager_id = (select manager_id from employees
                  where employee_id = 104);

-- 50인 부서에서 하는 업무와 같은 업무를 하는 사원
select * from employees
where job_id in (select job_id from employees
                 where department_id = 50);

select job_id from employees where department_id = 50;

-- 직원번호가 178또는 174 인 사원의 관리자 및 부서와 같은 관리자 및 부서를 갖는 사원의 정보를 출력하세요
select * from employees
where manager_id = (select manager_id from employees where employee_id = 174)
UNION
select * from employees
where manager_id = (select manager_id from employees where employee_id = 178)
and department_id = (select department_id from employees where employee_id = 178);
-- 이렇게 두개 이상의 컬럼을 비교해서 가져오는걸 쌍비교라고한다.
--- 쌍비교
select * from employees
where (manager_id, department_id) in (select manager_id, department_id
                                      from employees
                                      where employee_id in(174,178)
)and employee_id not in (174,178);



--- window 함수
-- 1. Rank() -- 동일한 값인 경우 동일한 순위, 다음 등수는 1,2,3,4
-- 급여가 많은 사람들부터 순위를 출력하세요.
select first_name, salary, job_id,
       rank() over (order by salary desc) all_rank
from employees;
-- rownum 과 window함수는 비슷하다 
select rownum, first_name, salary, job_id
from (select first_name, salary, job_id
      from employees
      order by salary desc);
      
-- 직무별 급여의 순위를 내림차순으로 출력하세요.
--select first_name, salary, job_id
--from employees
--group by job_id
--order by salary desc;

-- partition by = group by 
-- rank() over에는 group by 를 사용할 수 없다. 
select first_name, salary, job_id
       ,rank() over (partition by job_id order by salary desc) JOB_RANK
from employees;

-- 각부서에서 입사일이 빠른 사원부터 이름, 직무, 입사일을 랭킹 순으로 출력하세요.
select first_name, job_id, hire_date, department_id
       ,rank() over (partition by department_id order by hire_date asc) HIRE_RANK
from employees;

-- 급여를 제일 많이 받는 사람부터 순위와, 직무별 급여의 순위를 출력하세요.
select first_name,salary,job_id,
       rank() over (order by salary desc) ALL_RANK,
       rank() over (partition by job_id order by salary desc) JOB_RANK 
from employees;
-- 파티션 안준것이 준것보다 순위가 높아서 먼저 정렬된다. 

--- 2. dense_rank ()
-- rank : 동률이 있으면 건너 뛰고 다음 랭킹을 주지만
-- dende_rank : 동률이 있어도 건너뛰지 않고 번호가 연속된다. 
select first_name,salary,job_id,
       rank() over (order by salary desc) ALL_RANK,
       dense_rank() over (order by salary desc) DENSE_RANK
from employees;

-- 3. row_number() 동률도 계속 증가하는 값을 갖는다.
select first_name,salary,job_id,
       rank() over (order by salary desc) ALL_RANK,
       row_number() over (order by salary desc) ROW_NUMBER
from employees;

-- 사번,이름,이메일,직무,부서별의 평균 급여를 출력하세요.
select employee_id, first_name, email ,job_id, salary, e.department_id, avgsal
from employees e, (select department_id, avg(salary) avgsal
                 from employees
                 group by department_id ) d
where e.department_id = d.department_id
-- where 절 때문에 department_id 가 null이면 빠진다. 
order by employee_id;
-- 이렇게 출력해왔는데 window함수를 이용하면 훨씬 간편하게 출력할 수 있다.
-- window함수 사용
select employee_id, first_name, email, job_id, salary, department_id,
       avg(salary) over (partition by department_id) avgsal
from employees
order by employee_id;


--- 숙제
--문제 1) 회원 테이블을 만드시오. 각 컬럼에 제약 조건을 부여 하시오.
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
--USER_REGIST  : 디펄트 값은 sysdate
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


--문제2) 게시판 테이블을 만들고 각 컬럼에 제약조건을 부여 하시오.
--Table BOARD
--====================================
--BOARD_NUM     	NOT NULL 	NUMBER         
--USER_ID       	NOT NULL 	VARCHAR2(20)   
--BOARD_NAME    	NOT NULL 	VARCHAR2(20)    --- 글 쓴이 
--BOARD_PASS    	NOT NULL 	VARCHAR2(200)  
--BOARD_SUBJECT 	NOT NULL 	VARCHAR2(100)  -- 제목
--BOARD_CONTENT          		VARCHAR2(2000) -- 내용
--BOARD_DATE             		TIMESTAMP   
--IP_ADDR                		VARCHAR2(15)   
--READ_COUNT             		NUMBER      
--
--BOARD_NUM : primary key (BOARD_BOARD_NUM_PK)
--USER_ID : foreign key (BOARD_USER_ID_FK)
--READ_COUNT ; 디펄트 값은 0
create table board (
    board_num         number            not null,               -- PK
    user_id           varchar2(20)      not null,               -- FK
    board_name        varchar2(20)      not null,               -- 글쓴이
    board_pass        varchar2(20)      not null,
    board_subject     varchar2(100)     not null,               -- 제목
    board_content     varchar2(2000)    not null,               -- 내용
    board_date        timestamp,
    ip_addr           varchar2(15),
    read_count        number            default 0,
    constraint BOARD_BOARD_NUM_PK primary key (board_num),
    constraint BOARD_USER_ID_FK foreign key (user_id) references member(user_id)
);
drop table board;

--문제 3) 회원테이블에 아래 내용을 포함하여 5개의 데이터를 넣으시오.
--insert into member (user_id,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
--values('highland0','111111','이숭무','1999-12-12','1','서울','010-1234-1234',null,default,null);

insert into member (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland0','111111','이숭무','1999-12-12','1','서울','010-1234-1234',null,default,null);
insert into member (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('oracle222','222222','김예은','1995-09-25','2','서울','010-1111-1111',null,default,'ab3s');
insert into member (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('oracle333','333333','이예은','2000-12-26','2','경기','010-2222-2222',null,default,null);
insert into member (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('oracle444','444444','박예람','1985-04-30','1','강원','010-3333-3333',null,default,'naver');
insert into member (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('oracle555','555555','하예은','1993-03-07','2','서울','010-4444-4444','010-5555-5555',default,'daum');
select * from member;

--문제4)게시판 테이블에 데이터를 아래 내용 포함 6개 이상을 넣는데 위 회원들은 최소 한개 이상 게시글이 등록되게 하시오.
--insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR)
--values(1, 'highland0', '상장범 아빠', '1111','제목', '내용', '192.168.3.117');
insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR)
values(1, 'highland0', '상장범 아빠', '1111','제목', '내용', '192.168.3.117');
insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR)
values(2, 'oracle222', '김예은 졸림', '2222','제목1', '김예은이 졸린 내용', '196.169.5.235');
insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR)
values(3, 'oracle222', '김예은 힘듬', '2222','제목2', '김예은이 힘든 내용', '196.169.5.235');
insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR)
values(4, 'oracle333', '이예은 배고픔', '3333','제목3', '이예은이 배고픈 내용', '162.765.4.126');
insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR)
values(5, 'oracle444', '박예람 집갈래', '4444','제목4', '박예람이 집가는 내용', '147.547.6.762');
insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR)
values(6, 'oracle555', '하예은 놀고싶', '5555','제목5', '하예은이 놀고싶은 내용', '251.923.1.672');
select * from board;

--문제5) highland0 회원의 회원아이디, 회원명, 이메일, 게시글 번호, 게시글 제목, READ_COUNT를 출력하시오.
desc member;
desc board;
select m.user_id, user_name, user_email, board_name, board_subject, read_count  
from member m, board b
where m.user_id = b.user_id and m.user_id = 'highland0';

--문제6) 게시글을 읽으면 READ_COUNT가 1씩 증가 할 것이다. 
--         update문을 실행 할 때마다 READ_COUNT 1증가 할수 있게 update문을 작성하시오.
--         1번 게시글을 증가 시키시오.
update board
set read_count = read_count +1
where board_num =1;
select board_num, read_count from board;

--문제 7) 게시글 2번에 해당하는 회원을 출력하시오.
select * from member
where user_id = (select user_id from board where board_num =2);

--문제 8) 등록된 게시글의 개수를 출력하시오.
select count(*)
from board
where borad_num;

--문제 9) 각 회원의 게시글의 갯수를 출력하시오. (조인 아님)


--문제 10) 회원의 수를 출력하시오.


--문제 11) 아이디가 'highland0'인 회원의 전화번호를 '02-9876-1234', 이메일을 'highland0@nate.com', 비밀번호를 '22222'로 변경하시오.
dd

--문제 12) 게시글 1번의 제목을 '나는 열심히 공부할래', 내용을 '열심히 공부해서 \n 빨리 취업이 될 수 있게 노력해야지'로  수정하시오.


--문제 13) 1번 게시글을 출력할 때 내용의 \n을 <br /> 로 출력되게 하시오.


--문제 14)  게시글 제목이 너무 길어서 화면에 다 출력되기 어렵다 . 제목을 첫번째 글자 부터 5글자를 출력하고 뒤에는 *를 5개가 출력되게 하시오.


--문제 15) '이숭무'회원이 아이디를 잊어버렸다고 한다. 이메일과 전화번호를 이용해서 아이디를 출력하는 데 아이디는 모두 출력해서는 안되고 첫글자부터 세글자 나머지는 '*'로 출력되게 하시오.


--문제 16) 게시판 테이블에서 게시글을 많이 쓴 게시글의 user_id를 게시글 갯수와 같이 출력하시오.


--문제 17) 지금까지의 작업을 모두 정상 종료 시키시오.


--문제 18) '이숭무'회원이 탈퇴하려고 한다. 이숭무 회원이 탈퇴 할수 있게 삭제하시오.
dd

--문제 19) '이숭무' 회원이 탈퇴하는 것이 아니었는 데 잘 못 삭제를 하였다 . 정상적으로 '이숭무'회원에 대한 모든 내용이(게시판 포함) 존재 할 수 있게 하시오.


--문제 20) ‘highland0’인 회원이 로그인을 하여 자신이 쓴 글인 1번 게시글을 삭제하려고 한다.
--해당 게시물이 삭제 되게 하시오.


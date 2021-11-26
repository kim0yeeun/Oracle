--- 11/26

-- 문제1) 테이블만들기
create table member1 (
    user_id         varchar2(20)        constraint user_id_NN not null,      -- PK
    user_pw         varchar2(200)       constraint user_pw_NN not null,
    user_name       varchar2(40)        constraint user_name_NN not null,
    user_birth      timestamp           constraint user_birth_NN not null,     -- date라고 해도 상관없다. 
    user_gender     varchar2(1)         constraint user_gender_NN not null,
    user_addr       varchar2(200)       constraint user_addr_NN not null,
    user_ph1        varchar2(13)        constraint user_ph1_NN not null,
    user_ph2        varchar2(13),
    user_regist     timestamp,                                                 -- 가입일
    user_email      varchar2(200),                                             -- UU
    join_ok         varchar2(500)                                              -- 이메일로 가입확인 
                                                                               -- 확인되면 Y, 안되면 null (N)
--    constraint MEMBER1_USER_ID_PK primary key (user_id),
--    constraint MEMBER1_USER_EMAIL_UU unique (user_email)
--    제약 조건을 테이블안에 만들지 않는다. not null은 제외 (열레벨로 줘야함)
--    테이블 생성 후 alter 로 제약 조건을 준다. 나중에 부모<->자식관계가 애매해짐
);
drop table member1;

-- 테이블 레벨 수정
alter table member1
add (constraint mem1_user_id_pk primary key (user_id),
     constraint mem1_user_email_uu unique (user_email));
-- 열레벨 수정
alter table member1
modify (user_id constraint mem1_user_id_pk primary key,
        user_email constraint mem1_user_email_uu unique);
        
alter table member1
modify (user_regist default sysdate);

select * from member1;
select * from user_constraints where table_name = 'MEMBER1';
select * from user_cons_columns where table_name = 'MEMBER1';


-- 문제2) 테이블만들기
create table board1 (
    board_num         number            constraint board_num_NN not null,             -- PK
    user_id           varchar2(20) not null,     -- constraint user_id_NN not null,               -- FK
    board_name        varchar2(20)      constraint board_name_NN not null,            -- 글쓴이
    board_pass        varchar2(200)     constraint board_pass_NN not null,
    board_subject     varchar2(100)     constraint board_subject_NN not null,         -- 제목
    board_content     varchar2(2000)    constraint board_content_NN not null,         -- 내용
    board_date        timestamp,
    ip_addr           varchar2(15),
    read_count        number
);

alter table board1
add constraint board1_board_num_pk primary key (board_num);

alter table board1 
modify board_num constraint board1_board_num_pk primary key;

alter table board1
modify user_id constraint board1_board_num_fk references member1(user_id) ;
               
alter table board1
modify read_count default 0;


select * from board1;
select * from user_constraints where table_name = 'BOARD1';
select * from user_cons_columns where table_name = 'BOARD1';



-- 문제3) 삽입하기
desc member1;

insert into member1 (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL,JOIN_OK)
values('highland0','111111','이숭무','1999-12-12','1','서울','010-1234-1234',null,default,'@naver.com',null);
insert into member1 (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL,JOIN_OK)
values('oracle222','222222','김예은','1995-09-25','2','서울','010-1111-1111',null,default,'ab3s',null);
insert into member1 (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL,JOIN_OK)
values('oracle333','333333','이예은','2000-12-26','2','경기','010-2222-2222',null,default,null,null);
insert into member1 (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL,JOIN_OK)
values('oracle444','444444','박예람','1985-04-30','1','강원','010-3333-3333',null,default,'naver',null);
insert into member1 (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL,JOIN_OK)
values('oracle555','555555','하예은','1993-03-07','2','서울','010-4444-4444','010-5555-5555',default,'daum',null);
select * from member1;

-- 문제4) 삽입하기
desc board1;

insert into board1(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR,READ_COUNT)
values((select nvl(max(BOARD_NUM),0)+1 from board1),
       'highland0', '상장범 아빠', '1111','제목', '내용', '192.168.3.117',0);
insert into board1(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR,READ_COUNT)
values((select nvl(max(BOARD_NUM),0)+1 from board1),
       'oracle222', '김예은 졸림', '2222','제목1', '김예은이 졸린 내용', '196.169.5.235',0);
insert into board1(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR,READ_COUNT)
values((select nvl(max(BOARD_NUM),0)+1 from board1),
       'oracle222', '김예은 힘듬', '2222','제목2', '김예은이 힘든 내용', '196.169.5.235',0);
insert into board1(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR,READ_COUNT)
values((select nvl(max(BOARD_NUM),0)+1 from board1), 
       'oracle333', '이예은 배고픔', '3333','제목3', '이예은이 배고픈 내용', '162.765.4.126',0);
insert into board1(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR,READ_COUNT)
values((select nvl(max(BOARD_NUM),0)+1 from board1), 
       'oracle444', '박예람 집갈래', '4444','제목4', '박예람이 집가는 내용', '147.547.6.762',0);
insert into board1(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR,READ_COUNT)
values((select nvl(max(BOARD_NUM),0)+1 from board1), 
       'oracle555', '하예은 놀고싶', '5555','제목5', '하예은이 놀고싶은 내용', '251.923.1.672',0);
select * from board1;

-- 문제5) highland0 회원의 회원아이디, 회원명, 이메일, 게시글 번호, 게시글 제목, READ_COUNT를 출력하시오.
select m.user_id, user_name, user_email, board_name, board_subject, read_count  
from member1 m, board1 b
where m.user_id = b.user_id and m.user_id = 'highland0';


-- 문제6) 게시글을 읽으면 READ_COUNT가 1씩 증가 할 것이다. 
--         update문을 실행 할 때마다 READ_COUNT 1증가 할수 있게 update문을 작성하시오.
--         1번 게시글을 증가 시키시오.
update board1 -- 게시글 상세페이지에 들어갈 내용 or 제품 상세 페이지 
set read_count = read_count +1
where board_num = 1;
select board_num, read_count from board1;

-- 문제 7) 게시글 2번에 해당하는 회원을 출력하시오.
select * from member1
where user_id = (select user_id from board1 where board_num =2);

-- 문제 8) 등록된 게시글의 개수를 출력하시오.
select count(*) from board1;

-- 문제 9) 각 회원의 게시글의 갯수를 출력하시오. (조인 아님)
select user_id, count(*)
from board1
group by user_id;

-- 문제 10) 회원의 수를 출력하시오.
select count(*) from member1;

-- 문제 11) 아이디가 'highland0'인 회원의 전화번호를 '02-9876-1234', 이메일을 'highland0@nate.com', 비밀번호를 '22222'로 변경하시오.
update member1
set user_ph1 = '02-9876-1234',
    user_email = 'highland0@nate.com',
    user_pw = '2222'
where user_id = 'highland0';
-- 회원 상세 페이지
select * from member1 where user_id = 'highland0';

-- 문제 12) 게시글 1번의 제목을 '나는 열심히 공부할래', 내용을 '열심히 공부해서 \n 빨리 취업이 될 수 있게 노력해야지'로  수정하시오.
desc board1;
-- 게시글 상세페이시 1번 글 (board_num = 페이지수 를 적어주면 원하는 페이지로 넘어감 )
select * from board1 where board_num = 1;
update board1
set board_subject = '나는 열심히 공부할래',
    board_content = '열심히 공부해서 \n 빨리 취업이 될 수 있게 노력해야지'
where board_num = 1;

-- 문제 13) 1번 게시글을 출력할 때 내용의 \n을 <br /> 로 출력되게 하시오.
select board_subject, replace (board_content,'\n','<br>') content
from board1
where board_num = 1;

-- 문제 14)  게시글 제목이 너무 길어서 화면에 다 출력되기 어렵다 . 제목을 첫번째 글자 부터 5글자를 출력하고 뒤에는 *를 5개가 출력되게 하시오.
select rpad(substr(board_subject,1,5),10,'*')
from board1; -- 틀려따!!!! 
select substr(board_subject,1,5)|| '*****'
from board1;

-- 문제 15) '이숭무'회원이 아이디를 잊어버렸다고 한다.
-- 이메일과 전화번호를 이용해서 아이디를 출력하는 데 아이디는 모두 출력해서는 안되고 첫글자부터 세글자 나머지는 '*'로 출력되게 하시오.
select rpad(substr(user_id,1,3),length(user_id),'*')
from member1
where user_email = 'highland0@nate.com' and user_ph1 = '02-9876-1234';

-- 문제 16) 게시판 테이블에서 게시글을 많이 쓴 게시글의 user_id를 게시글 갯수와 같이 출력하시오.
select user_id, count(*)
from (select user_id, count(*) from board1 group by user_id order by cnt desc)
where rownum =1 ;

select user_id, cnt
from (select user_id, count(*) cnt from board1 group by user_id order by cnt desc)
where rownum =1 ;

-- 문제 17) 지금까지의 작업을 모두 정상 종료 시키시오.
commit;

-- 문제 18) '이숭무'회원이 탈퇴하려고 한다. 이숭무 회원이 탈퇴 할수 있게 삭제하시오.
delete member1
where user_name = '이숭무'; 
-- ORA-02292: 무결성 제약조건(KOSA.BOARD1_BOARD_NUM_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
select * from member1 where user_name = '이숭무';
select * from board1 where user_id = 'highland0'; -- 자식 데이터를 먼저 삭제해야 한다.
-- 이름이 이숭무인 아이디를 찾아서 해당 아이디의 게시글을 삭제한 후 
delete from board1
where user_id = (select user_id 
                 from member1
                 where user_name = '이숭무');
-- 멤버에서 이숭무를 삭제해준다
delete member1
where user_name = '이숭무'; 

-- 문제 19) '이숭무' 회원이 탈퇴하는 것이 아니었는 데 잘 못 삭제를 하였다.
-- 정상적으로 '이숭무'회원에 대한 모든 내용이(게시판 포함) 존재 할 수 있게 하시오.
rollback;
select * from member1 where user_name = '이숭무';
select * from board1 where user_id = 'highland0';
-- 존재함을 알 수 있다. 

-- 문제 20) ‘highland0’인 회원이 로그인을 하여 자신이 쓴 글인 1번 게시글을 삭제하려고 한다. 해당 게시물이 삭제 되게 하시오.
delete from board1
where user_id = 'highland0' and board_num = 1;
select * from board1
where user_id = 'highland0' and board_num = 1;






----- ERP : enterprise relationship model
--부모 삭제 시 자식 존재 - 비식별관계(점선)
--on delete set null
--부모 삭제 시 자식 삭제 - 식별관계(실선)
--on delete cascade

-- 강사 
create table teacher(
    teach_no        number          not null,       -- 강사 번호     -- PK
    teach_name      varchar2(10)    not null,       -- 강사명
    teach_tel       varchar2(11)    not null,       
    teach_email     varchar2(30)    not null,       
    teach_addr      varchar2(255)   not null,
    teach_carr      varchar2(1000),                 -- 강사 경력
    teach_viol      varchar2(1000),                 -- 결항 사항
    teach_certi     varchar2(1000)                  -- 강사 자격증
);
desc teacher;
drop table teacher;

create table subject(
    subj_no         number          not null,       -- 과목 번호     -- PK
    subj_name       varchar2(100)   not null,       -- 과목명
    subj_cnt        varchar2(1000)  not null,       -- 과목 설명
    subj_group      number          not null,       -- 강의 분류
    subj_day        number          not null,       -- 강의 일정
    subj_time       number          not null        -- 강의 시간 
);
desc subject;

create table employment( -- 직원고용계약
    employee_no     number          not null,       -- 직원계약번호    -- PK
    emp_no          number          not null,       -- 사원번호       -- PK, FK
    employee_sign   varchar2(1000)  not null,       -- 고용계약서 서명
    employee_sal    number          not null,       -- 직원 급여
    employee_posi   varchar2(10)    not null,       -- 직원 직급
    employee_date   timestamp       not null        -- 날짜 
);
desc employment;
drop table employment;

create table leceval( -- 강의평가 
    leceval_no      number          not null,       -- 평가번호       -- PK
    emp_no          number          not null,       -- 사원번호       -- PK, FK
    lec_no          number          not null,       -- 계약강사번호    -- PK, FK
    leceval_substfy number          not null,       -- 과목만족도
    leceval_relate  number          not null,       -- 실무연관도
    leceval_lecstfy number          not null,       -- 강의만족도
    leceval_etc     varchar2(1000)                  -- 기타건의사항
);
desc leceval;
             
create table leccontract ( -- 강사채용계약
    lec_no          number          not null,       -- 계약강사번호    -- PK,
    teach_no        number,                         -- 강사번호       -- FK
    subj_no         number,                         -- 과목번호       -- FK
    lec_data        timestamp       not null,       -- 강사채용 계약일
    lec_pay         number          not null,       -- 강사 급여
    lec_sign        varchar2(1000)  not null,       -- 강사채용계약서 서명
    lec_unit        number                          -- 이수단위
);
desc leccontract;

create table jobintv( -- 직원 채용 면접 
    jobintv_no      number           not null,      -- 면접번호       -- PK
    emp_no          number           not null,      -- 사원번호       -- PK, FK
    jobintv_lang    number           not null,      -- 언어능력
    jobintv_serv    number           not null,      -- 고객응대능력
    jobintv_task    number           not null,      -- 업무이해도
    jobintv_social  number           not null,      -- 동료친화도
    jobintv_solve   number           not null       -- 문제해결력
);
desc jobintv;

create table employee( -- 사원
    emp_no          number          not null,       -- 사원번호       -- PK
    dept_no         number,                         -- 부서번호       -- FK
    emp_name        varchar2(10)    not null,       -- 사원명
    emp_tel         varchar2(11)    not null,       -- 사원 연락처
    emp_email       varchar2(30)    not null,       -- 사원 이메일
    emp_addr        varchar2(255)   not null,       -- 사원 자택주소
    emp_date        timestamp,                      -- 입사일
    emp_carr        varchar2(1000),                 -- 경력
    emp_certi       varchar2(1000)                  -- 자격증
);
desc employee;

create table attend ( -- 출석부 
    attend_no       number          not null,       -- 출석번호       -- PK 
    emp_no          number          not null,       -- 사원번호       -- PK, FK 
    lec_no          number          not null,       -- 계약강사번호    -- PK, FK 
    attend_date     timestamp       not null,       -- 출석일자
    attend_time     number          not null,       -- 출석시간
    compl_date      timestamp       not null        -- 수료일
);
desc attend;

create table department ( -- 부서
    dept_no         number          not null,       -- 부서번호       -- PK
    dept_name       varchar2(100)   not null,       -- 부서명
    dept_tel        varchar2(11)    not null,       -- 부서 연락처
    dept_addr       varchar2(255)   not null        -- 부서 주소
);
desc department;




-- primary key

alter table teacher
add constraint teacher_teach_no_PK primary key (teach_no);

alter table subject
add constraint subject_subj_no_PK primary key (subj_no);

alter table employment
add constraint empm_mnt_no_emp_no_PK primary key (employee_no, emp_no);

alter table leceval
add constraint leceval_lece_no_emp_no_lec_no_PK primary key (leceval_no,emp_no,lec_no);

alter table leccontract
add constraint leccontract_lec_no_PK primary key(lec_no);

alter table jobintv
add constraint jobintv_jobintv_no_emp_no_PK primary key (jobintv_no ,emp_no);

alter table employee
add constraint employee_emp_no_PK primary key(emp_no);

alter table attend
add constraint attend_at_no_emp_no_lec_no_PK primary key(attend_no,emp_no,lec_no);

alter table department
add constraint department_dept_no_PK primary key(dept_no); 

-- 외래키

alter table orders
add


-- foreign key

alter table employment 
add constraint employment_emp_no_FK foreign key (emp_no)
    references employee (emp_no) on delete cascade;
    
alter table leceval
add (constraint leceval_emp_no_FK foreign key (emp_no)
     references employee (emp_no) on delete cascade,
     constraint leceval_lec_no_FK foreign key (lec_no)
     references leccontract (lec_no) on delete cascade
    );
    
alter table leccontract
add (constraint leccontract_teach_no_FK foreign key (teach_no)
     references teacher (teach_no) on delete set null,
     constraint leccontract_subj_no_FK foreign key (subj_no)
     REFERENCES subject (subj_no) on delete set null);
     
alter table jobintv
add (constraint jobintv_emp_no_FK foreign key (emp_no)
     references employee (emp_no) on delete cascade);

alter table employee
add (constraint employee_dept_no_FK foreign key (dept_no)
     references department (dept_no) on delete set null);
     
alter table attend
add (constraint attend_emp_no_FK foreign key (emp_no)
     references employee (emp_no) on delete cascade,
     constraint attend_lec_no_FK foreign key (lec_no)
     references leccontract (lec_no) on delete cascade );
     
-- 외래키로 넘어올때 기본키 개수만큼 넘어온다. 

-- ex3_6란 테이블을 만들고 , 사원테이블 (employees)에서 관리자사번이 124번, 급여가 2000~3000 사이에 있는
-- 사원의 사번, 사우너명, 급여, 관리자 사번을 입력하는 insert문을 작성하세요.
create table ex3_6(
    employee_id number(6),
    emp_name varchar2(80),
    salary number(8,2),
    manager_id number(6)
);
insert into ex3_6 
select employee_id, first_name, salary, manager_id from employees 
where manager_id = 124 and (salary between 2000 and 3000);
select * from ex3_6;

-- 사원테이블 (employees)에서 커미션 (commission_pct) 값이 없는 사원의 사번과 사우너명을 추출하는 쿼리를 작성해보자.
select employee_id, first_name
from employees
where commission_pct is null;

--select employee_id, first_name
--from employees
--where salary between 2000 and 2500
--order by employee_id;
-- 를 논리연산자로 변경하세요
select employee_id, first_name
from employees
where salary >= 2000 and salary <= 2500;


--select employee_id, first_name
--from employees
--where salary between 2000 and 2500
--order by employee_id;
-- 를 any로 변경하세요
select employee_id, first_name
from employees
where salary > any (2000,3000,4000)
order by employee_id;

--select employee_id, first_name
--from employees
--where salary not in (2000,3000,4000)
--order by employee_id;
--를 all로 변경하세요
select employee_id, first_name
from employees
where salary <> all (2000,3000,4000)
order by employee_id;
-- <> all : 모든 값들과 다르면 결과를 리턴 

-- 사원테이블에는 phone_number 라는 컬럼에 사원의 전화번호가
-- ###-###-#### 형태로 저장되어있다. 여기서 처음 3자리 숫자 대신 서울 지역번호인 02 를 붙여서 출력하세요 lpad
select lpad(substr(phone_number,5),length(phone_number),'(02)')
from employees;

-- 2. 현재일자 기준으로 사원테이블의 입사일자를 참조해서 근속년수가 10년 이상인 사원을 다음과 같은 형태의 결과로 출력하세요.
-- 근속년수가 많은 사원순서대로 사원번호   사원명    입사일자    근속년수
select employee_id "사원번호 ", first_name "사원명", hire_date "입사일자",round((sysdate - hire_date)/365) "근속년수"
from employees
where trunc((sysdate - hire_date)/365) >=10
order by "근속년수" desc;

-- 사원번호, 사원명, 급여, 전화번호 츌력시 급여를 통화단위로, 전화번호를 . 대신 - 로 출력되게 쿼리문을 작성하세요.
select employee_id, first_name, to_char(salary,'$999,999,999') sal, replace(phone_number,'.','-') phone
from employees;

-- 근속년수가 16년차면 주임... 나머지 사원으로 출력
select employee_id, first_name,
case when (trunc((sysdate-hire_date)/365)) >= 19 then '이사'
     when (trunc((sysdate-hire_date)/365)) >= 18 then '본부장'
     when (trunc((sysdate-hire_date)/365)) >= 17 then '부장'
     when (trunc((sysdate-hire_date)/365)) >= 16 then '차장'
     when (trunc((sysdate-hire_date)/365)) >= 15 then '과장'
     when (trunc((sysdate-hire_date)/365)) >= 14 then '대리'
     else '사원' end emp
from employees;

-- 급여를 1000 으로 나눈 몫이 3 이하면 사원, 5 이하면 주임, 7이하면 대리
-- 9 이하면 과장 10 이하면 차장 13 이하면 부장 15 이하면 본부장 그외는 이사로 출력

select employee_id, first_name, salary,
case when trunc(salary/1000) <= 3 then '사원'
     when trunc(salary/1000) <= 5 then '주임'
     when trunc(salary/1000) <= 7 then '대리'
     when trunc(salary/1000) <= 9 then '과장'
     when trunc(salary/1000) <= 10 then '차장'
     when trunc(salary/1000) <= 13 then '부장'
     when trunc(salary/1000) <= 15 then '본부장'
     else '이사' end emp
from employees
order by salary desc;

-- 사원테이블에서 입사 년도별 사원수를 구하는 쿼리를 작성하세요.
select substr(hire_date,1,2) y , count(*)
from employees
group by substr(hire_date,1,2) 
order by y;

select to_char(hire_date,'yyyy') y , count(*)
from employees
group by to_char(hire_date,'yyyy') 
order by y; -- 답 
-- 날짜일 경우에는 substr 보다는 to char가 좋다.  


-- 아래의 쿼리는 분할 rollup을 적용한 쿼리이다.
select department_id, job_id, sum(salary) totl_jan
from employees
where hire_date like '03%'
group by department_id, rollup(job_id);
-- 이 쿼리를 rollup을 사용하지 않고
-- 집합연산자를 사용해서 동일한 결과가 나오도록 작성하자. 

select department_id, job_id, sum(salary) totl_jan
from employees
where hire_date like '03%'
group by rollup (department_id, job_id);
-- 뒤에 롤업을 주면 모두다가 안나온다. 

select department_id, job_id, sum(salary) totl_jan
from employees
where hire_date like '03%'
group by department_id, job_id
UNION
select department_id, null, sum(salary) totl_jan
from employees
where hire_date like '03%'
group by department_id;


-- 사번   사원명     job명칭   job시작일자     job종료일자     job수행부서명
-- e,h   e          j         h               h             d
-- 101번 사원만 출력하세요
select*from job_history;
select * from jobs;
select * from employees;
select * from departments;
--  말고 desc 해서 복붙해서 사용! 
--desc employees;             desc jobs;          desc job_history;          desc departments;
--EMPLOYEE_ID                 JOB_ID              EMPLOYEE_ID                DEPARTMENT_ID
--                            JOB_TITLE           START_DATE
--                                                END_DATE
--                                                JOB_ID
--                                                DEPARTMENT_ID
-- 겹치는게 기본키로 이어진다 

select e.employee_id, e.first_name, j.job_title, h.start_date, h.end_date, d.department_name
from employees e, job_history h ,jobs j ,departments d
where e.employee_id = h.employee_id
and   h.department_id = d.department_id
and   h.job_id = j.job_id
and   e.employee_id = 101;


-- 다음의 쿼리를 ansi join으로 변경하세요.
-- t-sql join
select d.department_id, d.department_name
from departments d, employees e
where d.department_id = e.department_id
and e.salary > 3000
order by d.department_name;
-- ansi join 
select d.department_id, d.department_name
from departments d join employees e
on d.department_id = e.department_id
where e.salary > 3000
order by d.department_name;

-- 각부서의 급여를 제일 적게 받는 사원들을 구하세요.
select employee_id, first_name,department_id, min_sal
from employees ,(select min(salary) min_sal from employees group by department_id) s
where employees.salary = s.min_sal
order by employee_id; -- 틀림

select * 
from employees
where (department_id, salary) 
      in (select department_id, min(salary) from employees 
          group by department_id); -- 답



--- merge : insert? update?
-- 원하는 table에 date가 없으면 insert, 있으면 update 
select * from ex3_6;
merge into ex3_6 a
      using (select * from employees where employee_id = 101) b
      on (a.employee_id = b.employee_id)
when matched then 
      update set salary = salary * 1.1
when not matched then
      insert (a.employee_id, a.emp_name, a.salary, a.manager_id)
      values (b.employee_id, b.first_name, 15000, 100);
      
select * from ex3_6;
-- 위에 한번 더 실행시키면 급여가 1.1 퍼 올라간다.

merge into ex3_6 a
      using (select * from employees where employee_id = 103) b
      on (a.employee_id = b.employee_id)
when matched then 
      update set salary = salary * 1.1
when not matched then
      insert (a.employee_id, a.emp_name, a.salary, a.manager_id)
      values (b.employee_id, b.first_name, 15000, 100);
select * from ex3_6;

-- 머지 하기 위해서는 비교대상이 필요하다 using(~~~) ~~~  가있냐? on 비교해서 있으면
-- when matched then 있다면update 없ㅇ면 insert 




--- 숙제 
-- ERD 모델 보고 table 만들기
create table members( -- 회원 
    member_no            varchar2(15)       not null,            -- PK
    member_name          varchar2(20)       not null,
    member_id            varchar2(12)       not null,
    member_phone         varchar2(30)       not null,
    member_email         varchar2(40),
    member_mobile        varchar2(30),
    pay_method           varchar2(16)
);

create table publisher ( -- 출판사 
    pub_co_num           varchar2(15)       not null,           -- pk
    pub_name             varchar2(20)       not null,
    pub_addr             varchar2(50)       not null,
    pub_phone            varchar2(30)       not null,
    bank_no              varchar2(7)        not null,
    account_num          varchar2(16)       not null
);

create table orders ( -- 주문
    order_no            number              not null,           -- PK
    del_addr            varchar2(50)        not null,
    del_phone           varchar2(30)        not null,
    order_date          date                not null,
    del_code            number(6,3)         not null,
    tot_payment         integer,
    member_no           varchar2(15),                           --FK
    qty                 integer          
);


create table order_list ( -- 주문 목록
    order_no            number              not null,           -- PK, FK
    book_no             number              not null,           -- PK, FK
    order_qty           number
);
drop table order_list;

create table book ( -- 도서
    book_no             number              not null,            -- pk
    book_name           varchar2(20),
    book_ck             number(6,3),
    book_qty            number
);
drop table book;

create table chk_book ( -- 체크도서 
    chk_no              number              not null,            -- pk
    member_no           varchar2(15)        not null,            -- pk/fk 
    book_no             number(6,3)         not null,            -- pk/fk
    reg_date            date                not null
);
drop table chk_book;

create table supply_book ( -- 공급도서
    book_no             number              not null,            -- pk/fk
  
    cont_number         number              not null,            -- pk/fk
    book_reg            date                not null
);

create table contract_company ( -- 계약업체
    cont_number         number              not null,            -- pk
    cont_status         number              not null,  
    min_pct             number(6,3)         not null,
    cont_date           date                not null,
    pub_co_num          varchar2(15)                             -- fk
);

-- 기본키 
alter table members
add constraint members_member_no_PK primary key (member_no);

alter table orders
add constraint orders_order_no_PK primary key (order_no);

alter table order_list
add constraint order_list_order_no_book_no_PK primary key (order_no,book_no);

alter table book
add constraint book_book_no_PK primary key (book_no);

alter table supply_book
add constraint supply_book_bk_no_cont_num_PK primary key (book_no,cont_number);

alter table chk_book
add constraint chk_book_chkno_memno_bkno_PK primary key (chk_no,member_no,book_no);

alter table publisher
add constraint publisher_pub_co_num_PK primary key (pub_co_num);

alter table contract_company
add constraint contract_company_cont_number_PK primary key (cont_number);


-- 외래키 
    
alter table orders
add constraint orders_member_no_FK foreign key (member_no)
    references members (member_no) on delete set null;
    
alter table order_list
add (constraint order_list_order_no_FK foreign key (order_no)
    references orders (order_no) on delete cascade,
    constraint order_list_book_no_FK foreign key (book_no)
    references book (book_no) on delete cascade );
    
alter table chk_book
add (constraint chk_book_member_no_FK foreign key (member_no)
     references members (member_no) on delete cascade,
     constraint chk_book_book_no_FK foreign key (book_no)
     references book (book_no) on delete cascade );
    
alter table supply_book   
add (constraint supply_book_book_no_FK foreign key (book_no)
     references book (book_no) on delete cascade,
     constraint supply_book_cont_number_FK foreign key (cont_number)
     references contract_company(cont_number) on delete cascade);
     
alter table contract_company
add (constraint contract_company_pub_co_num_FK foreign key (pub_co_num)
     references publisher(pub_co_num) on delete set null);


commit;





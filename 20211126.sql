--- 11/26

-- ����1) ���̺����
create table member1 (
    user_id         varchar2(20)        constraint user_id_NN not null,      -- PK
    user_pw         varchar2(200)       constraint user_pw_NN not null,
    user_name       varchar2(40)        constraint user_name_NN not null,
    user_birth      timestamp           constraint user_birth_NN not null,     -- date��� �ص� �������. 
    user_gender     varchar2(1)         constraint user_gender_NN not null,
    user_addr       varchar2(200)       constraint user_addr_NN not null,
    user_ph1        varchar2(13)        constraint user_ph1_NN not null,
    user_ph2        varchar2(13),
    user_regist     timestamp,                                                 -- ������
    user_email      varchar2(200),                                             -- UU
    join_ok         varchar2(500)                                              -- �̸��Ϸ� ����Ȯ�� 
                                                                               -- Ȯ�εǸ� Y, �ȵǸ� null (N)
--    constraint MEMBER1_USER_ID_PK primary key (user_id),
--    constraint MEMBER1_USER_EMAIL_UU unique (user_email)
--    ���� ������ ���̺�ȿ� ������ �ʴ´�. not null�� ���� (�������� �����)
--    ���̺� ���� �� alter �� ���� ������ �ش�. ���߿� �θ�<->�ڽİ��谡 �ָ�����
);
drop table member1;

-- ���̺� ���� ����
alter table member1
add (constraint mem1_user_id_pk primary key (user_id),
     constraint mem1_user_email_uu unique (user_email));
-- ������ ����
alter table member1
modify (user_id constraint mem1_user_id_pk primary key,
        user_email constraint mem1_user_email_uu unique);
        
alter table member1
modify (user_regist default sysdate);

select * from member1;
select * from user_constraints where table_name = 'MEMBER1';
select * from user_cons_columns where table_name = 'MEMBER1';


-- ����2) ���̺����
create table board1 (
    board_num         number            constraint board_num_NN not null,             -- PK
    user_id           varchar2(20) not null,     -- constraint user_id_NN not null,               -- FK
    board_name        varchar2(20)      constraint board_name_NN not null,            -- �۾���
    board_pass        varchar2(200)     constraint board_pass_NN not null,
    board_subject     varchar2(100)     constraint board_subject_NN not null,         -- ����
    board_content     varchar2(2000)    constraint board_content_NN not null,         -- ����
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



-- ����3) �����ϱ�
desc member1;

insert into member1 (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL,JOIN_OK)
values('highland0','111111','�̼���','1999-12-12','1','����','010-1234-1234',null,default,'@naver.com',null);
insert into member1 (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL,JOIN_OK)
values('oracle222','222222','�迹��','1995-09-25','2','����','010-1111-1111',null,default,'ab3s',null);
insert into member1 (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL,JOIN_OK)
values('oracle333','333333','�̿���','2000-12-26','2','���','010-2222-2222',null,default,null,null);
insert into member1 (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL,JOIN_OK)
values('oracle444','444444','�ڿ���','1985-04-30','1','����','010-3333-3333',null,default,'naver',null);
insert into member1 (USER_ID,USER_PW,USER_NAME,USER_BIRTH,USER_GENDER,USER_ADDR ,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL,JOIN_OK)
values('oracle555','555555','�Ͽ���','1993-03-07','2','����','010-4444-4444','010-5555-5555',default,'daum',null);
select * from member1;

-- ����4) �����ϱ�
desc board1;

insert into board1(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR,READ_COUNT)
values((select nvl(max(BOARD_NUM),0)+1 from board1),
       'highland0', '����� �ƺ�', '1111','����', '����', '192.168.3.117',0);
insert into board1(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR,READ_COUNT)
values((select nvl(max(BOARD_NUM),0)+1 from board1),
       'oracle222', '�迹�� ����', '2222','����1', '�迹���� ���� ����', '196.169.5.235',0);
insert into board1(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR,READ_COUNT)
values((select nvl(max(BOARD_NUM),0)+1 from board1),
       'oracle222', '�迹�� ����', '2222','����2', '�迹���� ���� ����', '196.169.5.235',0);
insert into board1(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR,READ_COUNT)
values((select nvl(max(BOARD_NUM),0)+1 from board1), 
       'oracle333', '�̿��� �����', '3333','����3', '�̿����� ����� ����', '162.765.4.126',0);
insert into board1(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR,READ_COUNT)
values((select nvl(max(BOARD_NUM),0)+1 from board1), 
       'oracle444', '�ڿ��� ������', '4444','����4', '�ڿ����� ������ ����', '147.547.6.762',0);
insert into board1(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,BOARD_CONTENT,IP_ADDR,READ_COUNT)
values((select nvl(max(BOARD_NUM),0)+1 from board1), 
       'oracle555', '�Ͽ��� ����', '5555','����5', '�Ͽ����� ������ ����', '251.923.1.672',0);
select * from board1;

-- ����5) highland0 ȸ���� ȸ�����̵�, ȸ����, �̸���, �Խñ� ��ȣ, �Խñ� ����, READ_COUNT�� ����Ͻÿ�.
select m.user_id, user_name, user_email, board_name, board_subject, read_count  
from member1 m, board1 b
where m.user_id = b.user_id and m.user_id = 'highland0';


-- ����6) �Խñ��� ������ READ_COUNT�� 1�� ���� �� ���̴�. 
--         update���� ���� �� ������ READ_COUNT 1���� �Ҽ� �ְ� update���� �ۼ��Ͻÿ�.
--         1�� �Խñ��� ���� ��Ű�ÿ�.
update board1 -- �Խñ� ���������� �� ���� or ��ǰ �� ������ 
set read_count = read_count +1
where board_num = 1;
select board_num, read_count from board1;

-- ���� 7) �Խñ� 2���� �ش��ϴ� ȸ���� ����Ͻÿ�.
select * from member1
where user_id = (select user_id from board1 where board_num =2);

-- ���� 8) ��ϵ� �Խñ��� ������ ����Ͻÿ�.
select count(*) from board1;

-- ���� 9) �� ȸ���� �Խñ��� ������ ����Ͻÿ�. (���� �ƴ�)
select user_id, count(*)
from board1
group by user_id;

-- ���� 10) ȸ���� ���� ����Ͻÿ�.
select count(*) from member1;

-- ���� 11) ���̵� 'highland0'�� ȸ���� ��ȭ��ȣ�� '02-9876-1234', �̸����� 'highland0@nate.com', ��й�ȣ�� '22222'�� �����Ͻÿ�.
update member1
set user_ph1 = '02-9876-1234',
    user_email = 'highland0@nate.com',
    user_pw = '2222'
where user_id = 'highland0';
-- ȸ�� �� ������
select * from member1 where user_id = 'highland0';

-- ���� 12) �Խñ� 1���� ������ '���� ������ �����ҷ�', ������ '������ �����ؼ� \n ���� ����� �� �� �ְ� ����ؾ���'��  �����Ͻÿ�.
desc board1;
-- �Խñ� �����̽� 1�� �� (board_num = �������� �� �����ָ� ���ϴ� �������� �Ѿ )
select * from board1 where board_num = 1;
update board1
set board_subject = '���� ������ �����ҷ�',
    board_content = '������ �����ؼ� \n ���� ����� �� �� �ְ� ����ؾ���'
where board_num = 1;

-- ���� 13) 1�� �Խñ��� ����� �� ������ \n�� <br /> �� ��µǰ� �Ͻÿ�.
select board_subject, replace (board_content,'\n','<br>') content
from board1
where board_num = 1;

-- ���� 14)  �Խñ� ������ �ʹ� �� ȭ�鿡 �� ��µǱ� ��ƴ� . ������ ù��° ���� ���� 5���ڸ� ����ϰ� �ڿ��� *�� 5���� ��µǰ� �Ͻÿ�.
select rpad(substr(board_subject,1,5),10,'*')
from board1; -- Ʋ����!!!! 
select substr(board_subject,1,5)|| '*****'
from board1;

-- ���� 15) '�̼���'ȸ���� ���̵� �ؾ���ȴٰ� �Ѵ�.
-- �̸��ϰ� ��ȭ��ȣ�� �̿��ؼ� ���̵� ����ϴ� �� ���̵�� ��� ����ؼ��� �ȵǰ� ù���ں��� ������ �������� '*'�� ��µǰ� �Ͻÿ�.
select rpad(substr(user_id,1,3),length(user_id),'*')
from member1
where user_email = 'highland0@nate.com' and user_ph1 = '02-9876-1234';

-- ���� 16) �Խ��� ���̺��� �Խñ��� ���� �� �Խñ��� user_id�� �Խñ� ������ ���� ����Ͻÿ�.
select user_id, count(*)
from (select user_id, count(*) from board1 group by user_id order by cnt desc)
where rownum =1 ;

select user_id, cnt
from (select user_id, count(*) cnt from board1 group by user_id order by cnt desc)
where rownum =1 ;

-- ���� 17) ���ݱ����� �۾��� ��� ���� ���� ��Ű�ÿ�.
commit;

-- ���� 18) '�̼���'ȸ���� Ż���Ϸ��� �Ѵ�. �̼��� ȸ���� Ż�� �Ҽ� �ְ� �����Ͻÿ�.
delete member1
where user_name = '�̼���'; 
-- ORA-02292: ���Ἲ ��������(KOSA.BOARD1_BOARD_NUM_FK)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�
select * from member1 where user_name = '�̼���';
select * from board1 where user_id = 'highland0'; -- �ڽ� �����͸� ���� �����ؾ� �Ѵ�.
-- �̸��� �̼����� ���̵� ã�Ƽ� �ش� ���̵��� �Խñ��� ������ �� 
delete from board1
where user_id = (select user_id 
                 from member1
                 where user_name = '�̼���');
-- ������� �̼����� �������ش�
delete member1
where user_name = '�̼���'; 

-- ���� 19) '�̼���' ȸ���� Ż���ϴ� ���� �ƴϾ��� �� �� �� ������ �Ͽ���.
-- ���������� '�̼���'ȸ���� ���� ��� ������(�Խ��� ����) ���� �� �� �ְ� �Ͻÿ�.
rollback;
select * from member1 where user_name = '�̼���';
select * from board1 where user_id = 'highland0';
-- �������� �� �� �ִ�. 

-- ���� 20) ��highland0���� ȸ���� �α����� �Ͽ� �ڽ��� �� ���� 1�� �Խñ��� �����Ϸ��� �Ѵ�. �ش� �Խù��� ���� �ǰ� �Ͻÿ�.
delete from board1
where user_id = 'highland0' and board_num = 1;
select * from board1
where user_id = 'highland0' and board_num = 1;






----- ERP : enterprise relationship model
--�θ� ���� �� �ڽ� ���� - ��ĺ�����(����)
--on delete set null
--�θ� ���� �� �ڽ� ���� - �ĺ�����(�Ǽ�)
--on delete cascade

-- ���� 
create table teacher(
    teach_no        number          not null,       -- ���� ��ȣ     -- PK
    teach_name      varchar2(10)    not null,       -- �����
    teach_tel       varchar2(11)    not null,       
    teach_email     varchar2(30)    not null,       
    teach_addr      varchar2(255)   not null,
    teach_carr      varchar2(1000),                 -- ���� ���
    teach_viol      varchar2(1000),                 -- ���� ����
    teach_certi     varchar2(1000)                  -- ���� �ڰ���
);
desc teacher;
drop table teacher;

create table subject(
    subj_no         number          not null,       -- ���� ��ȣ     -- PK
    subj_name       varchar2(100)   not null,       -- �����
    subj_cnt        varchar2(1000)  not null,       -- ���� ����
    subj_group      number          not null,       -- ���� �з�
    subj_day        number          not null,       -- ���� ����
    subj_time       number          not null        -- ���� �ð� 
);
desc subject;

create table employment( -- ���������
    employee_no     number          not null,       -- ��������ȣ    -- PK
    emp_no          number          not null,       -- �����ȣ       -- PK, FK
    employee_sign   varchar2(1000)  not null,       -- ����༭ ����
    employee_sal    number          not null,       -- ���� �޿�
    employee_posi   varchar2(10)    not null,       -- ���� ����
    employee_date   timestamp       not null        -- ��¥ 
);
desc employment;
drop table employment;

create table leceval( -- ������ 
    leceval_no      number          not null,       -- �򰡹�ȣ       -- PK
    emp_no          number          not null,       -- �����ȣ       -- PK, FK
    lec_no          number          not null,       -- ��భ���ȣ    -- PK, FK
    leceval_substfy number          not null,       -- ��������
    leceval_relate  number          not null,       -- �ǹ�������
    leceval_lecstfy number          not null,       -- ���Ǹ�����
    leceval_etc     varchar2(1000)                  -- ��Ÿ���ǻ���
);
desc leceval;
             
create table leccontract ( -- ����ä����
    lec_no          number          not null,       -- ��భ���ȣ    -- PK,
    teach_no        number,                         -- �����ȣ       -- FK
    subj_no         number,                         -- �����ȣ       -- FK
    lec_data        timestamp       not null,       -- ����ä�� �����
    lec_pay         number          not null,       -- ���� �޿�
    lec_sign        varchar2(1000)  not null,       -- ����ä���༭ ����
    lec_unit        number                          -- �̼�����
);
desc leccontract;

create table jobintv( -- ���� ä�� ���� 
    jobintv_no      number           not null,      -- ������ȣ       -- PK
    emp_no          number           not null,      -- �����ȣ       -- PK, FK
    jobintv_lang    number           not null,      -- ���ɷ�
    jobintv_serv    number           not null,      -- ������ɷ�
    jobintv_task    number           not null,      -- �������ص�
    jobintv_social  number           not null,      -- ����ģȭ��
    jobintv_solve   number           not null       -- �����ذ��
);
desc jobintv;

create table employee( -- ���
    emp_no          number          not null,       -- �����ȣ       -- PK
    dept_no         number,                         -- �μ���ȣ       -- FK
    emp_name        varchar2(10)    not null,       -- �����
    emp_tel         varchar2(11)    not null,       -- ��� ����ó
    emp_email       varchar2(30)    not null,       -- ��� �̸���
    emp_addr        varchar2(255)   not null,       -- ��� �����ּ�
    emp_date        timestamp,                      -- �Ի���
    emp_carr        varchar2(1000),                 -- ���
    emp_certi       varchar2(1000)                  -- �ڰ���
);
desc employee;

create table attend ( -- �⼮�� 
    attend_no       number          not null,       -- �⼮��ȣ       -- PK 
    emp_no          number          not null,       -- �����ȣ       -- PK, FK 
    lec_no          number          not null,       -- ��భ���ȣ    -- PK, FK 
    attend_date     timestamp       not null,       -- �⼮����
    attend_time     number          not null,       -- �⼮�ð�
    compl_date      timestamp       not null        -- ������
);
desc attend;

create table department ( -- �μ�
    dept_no         number          not null,       -- �μ���ȣ       -- PK
    dept_name       varchar2(100)   not null,       -- �μ���
    dept_tel        varchar2(11)    not null,       -- �μ� ����ó
    dept_addr       varchar2(255)   not null        -- �μ� �ּ�
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

-- �ܷ�Ű

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
     
-- �ܷ�Ű�� �Ѿ�ö� �⺻Ű ������ŭ �Ѿ�´�. 

-- ex3_6�� ���̺��� ����� , ������̺� (employees)���� �����ڻ���� 124��, �޿��� 2000~3000 ���̿� �ִ�
-- ����� ���, ���ʸ�, �޿�, ������ ����� �Է��ϴ� insert���� �ۼ��ϼ���.
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

-- ������̺� (employees)���� Ŀ�̼� (commission_pct) ���� ���� ����� ����� ���ʸ��� �����ϴ� ������ �ۼ��غ���.
select employee_id, first_name
from employees
where commission_pct is null;

--select employee_id, first_name
--from employees
--where salary between 2000 and 2500
--order by employee_id;
-- �� �������ڷ� �����ϼ���
select employee_id, first_name
from employees
where salary >= 2000 and salary <= 2500;


--select employee_id, first_name
--from employees
--where salary between 2000 and 2500
--order by employee_id;
-- �� any�� �����ϼ���
select employee_id, first_name
from employees
where salary > any (2000,3000,4000)
order by employee_id;

--select employee_id, first_name
--from employees
--where salary not in (2000,3000,4000)
--order by employee_id;
--�� all�� �����ϼ���
select employee_id, first_name
from employees
where salary <> all (2000,3000,4000)
order by employee_id;
-- <> all : ��� ����� �ٸ��� ����� ���� 

-- ������̺��� phone_number ��� �÷��� ����� ��ȭ��ȣ��
-- ###-###-#### ���·� ����Ǿ��ִ�. ���⼭ ó�� 3�ڸ� ���� ��� ���� ������ȣ�� 02 �� �ٿ��� ����ϼ��� lpad
select lpad(substr(phone_number,5),length(phone_number),'(02)')
from employees;

-- 2. �������� �������� ������̺��� �Ի����ڸ� �����ؼ� �ټӳ���� 10�� �̻��� ����� ������ ���� ������ ����� ����ϼ���.
-- �ټӳ���� ���� ���������� �����ȣ   �����    �Ի�����    �ټӳ��
select employee_id "�����ȣ ", first_name "�����", hire_date "�Ի�����",round((sysdate - hire_date)/365) "�ټӳ��"
from employees
where trunc((sysdate - hire_date)/365) >=10
order by "�ټӳ��" desc;

-- �����ȣ, �����, �޿�, ��ȭ��ȣ ���½� �޿��� ��ȭ������, ��ȭ��ȣ�� . ��� - �� ��µǰ� �������� �ۼ��ϼ���.
select employee_id, first_name, to_char(salary,'$999,999,999') sal, replace(phone_number,'.','-') phone
from employees;

-- �ټӳ���� 16������ ����... ������ ������� ���
select employee_id, first_name,
case when (trunc((sysdate-hire_date)/365)) >= 19 then '�̻�'
     when (trunc((sysdate-hire_date)/365)) >= 18 then '������'
     when (trunc((sysdate-hire_date)/365)) >= 17 then '����'
     when (trunc((sysdate-hire_date)/365)) >= 16 then '����'
     when (trunc((sysdate-hire_date)/365)) >= 15 then '����'
     when (trunc((sysdate-hire_date)/365)) >= 14 then '�븮'
     else '���' end emp
from employees;

-- �޿��� 1000 ���� ���� ���� 3 ���ϸ� ���, 5 ���ϸ� ����, 7���ϸ� �븮
-- 9 ���ϸ� ���� 10 ���ϸ� ���� 13 ���ϸ� ���� 15 ���ϸ� ������ �׿ܴ� �̻�� ���

select employee_id, first_name, salary,
case when trunc(salary/1000) <= 3 then '���'
     when trunc(salary/1000) <= 5 then '����'
     when trunc(salary/1000) <= 7 then '�븮'
     when trunc(salary/1000) <= 9 then '����'
     when trunc(salary/1000) <= 10 then '����'
     when trunc(salary/1000) <= 13 then '����'
     when trunc(salary/1000) <= 15 then '������'
     else '�̻�' end emp
from employees
order by salary desc;

-- ������̺��� �Ի� �⵵�� ������� ���ϴ� ������ �ۼ��ϼ���.
select substr(hire_date,1,2) y , count(*)
from employees
group by substr(hire_date,1,2) 
order by y;

select to_char(hire_date,'yyyy') y , count(*)
from employees
group by to_char(hire_date,'yyyy') 
order by y; -- �� 
-- ��¥�� ��쿡�� substr ���ٴ� to char�� ����.  


-- �Ʒ��� ������ ���� rollup�� ������ �����̴�.
select department_id, job_id, sum(salary) totl_jan
from employees
where hire_date like '03%'
group by department_id, rollup(job_id);
-- �� ������ rollup�� ������� �ʰ�
-- ���տ����ڸ� ����ؼ� ������ ����� �������� �ۼ�����. 

select department_id, job_id, sum(salary) totl_jan
from employees
where hire_date like '03%'
group by rollup (department_id, job_id);
-- �ڿ� �Ѿ��� �ָ� ��δٰ� �ȳ��´�. 

select department_id, job_id, sum(salary) totl_jan
from employees
where hire_date like '03%'
group by department_id, job_id
UNION
select department_id, null, sum(salary) totl_jan
from employees
where hire_date like '03%'
group by department_id;


-- ���   �����     job��Ī   job��������     job��������     job����μ���
-- e,h   e          j         h               h             d
-- 101�� ����� ����ϼ���
select*from job_history;
select * from jobs;
select * from employees;
select * from departments;
--  ���� desc �ؼ� �����ؼ� ���! 
--desc employees;             desc jobs;          desc job_history;          desc departments;
--EMPLOYEE_ID                 JOB_ID              EMPLOYEE_ID                DEPARTMENT_ID
--                            JOB_TITLE           START_DATE
--                                                END_DATE
--                                                JOB_ID
--                                                DEPARTMENT_ID
-- ��ġ�°� �⺻Ű�� �̾����� 

select e.employee_id, e.first_name, j.job_title, h.start_date, h.end_date, d.department_name
from employees e, job_history h ,jobs j ,departments d
where e.employee_id = h.employee_id
and   h.department_id = d.department_id
and   h.job_id = j.job_id
and   e.employee_id = 101;


-- ������ ������ ansi join���� �����ϼ���.
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

-- ���μ��� �޿��� ���� ���� �޴� ������� ���ϼ���.
select employee_id, first_name,department_id, min_sal
from employees ,(select min(salary) min_sal from employees group by department_id) s
where employees.salary = s.min_sal
order by employee_id; -- Ʋ��

select * 
from employees
where (department_id, salary) 
      in (select department_id, min(salary) from employees 
          group by department_id); -- ��



--- merge : insert? update?
-- ���ϴ� table�� date�� ������ insert, ������ update 
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
-- ���� �ѹ� �� �����Ű�� �޿��� 1.1 �� �ö󰣴�.

merge into ex3_6 a
      using (select * from employees where employee_id = 103) b
      on (a.employee_id = b.employee_id)
when matched then 
      update set salary = salary * 1.1
when not matched then
      insert (a.employee_id, a.emp_name, a.salary, a.manager_id)
      values (b.employee_id, b.first_name, 15000, 100);
select * from ex3_6;

-- ���� �ϱ� ���ؼ��� �񱳴���� �ʿ��ϴ� using(~~~) ~~~  ���ֳ�? on ���ؼ� ������
-- when matched then �ִٸ�update ������ insert 




--- ���� 
-- ERD �� ���� table �����
create table members( -- ȸ�� 
    member_no            varchar2(15)       not null,            -- PK
    member_name          varchar2(20)       not null,
    member_id            varchar2(12)       not null,
    member_phone         varchar2(30)       not null,
    member_email         varchar2(40),
    member_mobile        varchar2(30),
    pay_method           varchar2(16)
);

create table publisher ( -- ���ǻ� 
    pub_co_num           varchar2(15)       not null,           -- pk
    pub_name             varchar2(20)       not null,
    pub_addr             varchar2(50)       not null,
    pub_phone            varchar2(30)       not null,
    bank_no              varchar2(7)        not null,
    account_num          varchar2(16)       not null
);

create table orders ( -- �ֹ�
    order_no            number              not null,           -- PK
    del_addr            varchar2(50)        not null,
    del_phone           varchar2(30)        not null,
    order_date          date                not null,
    del_code            number(6,3)         not null,
    tot_payment         integer,
    member_no           varchar2(15),                           --FK
    qty                 integer          
);


create table order_list ( -- �ֹ� ���
    order_no            number              not null,           -- PK, FK
    book_no             number              not null,           -- PK, FK
    order_qty           number
);
drop table order_list;

create table book ( -- ����
    book_no             number              not null,            -- pk
    book_name           varchar2(20),
    book_ck             number(6,3),
    book_qty            number
);
drop table book;

create table chk_book ( -- üũ���� 
    chk_no              number              not null,            -- pk
    member_no           varchar2(15)        not null,            -- pk/fk 
    book_no             number(6,3)         not null,            -- pk/fk
    reg_date            date                not null
);
drop table chk_book;

create table supply_book ( -- ���޵���
    book_no             number              not null,            -- pk/fk
  
    cont_number         number              not null,            -- pk/fk
    book_reg            date                not null
);

create table contract_company ( -- ����ü
    cont_number         number              not null,            -- pk
    cont_status         number              not null,  
    min_pct             number(6,3)         not null,
    cont_date           date                not null,
    pub_co_num          varchar2(15)                             -- fk
);

-- �⺻Ű 
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


-- �ܷ�Ű 
    
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





-- 11/22  4�� �Լ�

-- ������ �Լ� : �� �ϳ��� ����Ǵ� �Լ���� ��

select * from employees;
--- �빮�ڸ� �ҹ��ڷ� , �ҹ��ڸ� �빮�ڷ�
select email, lower(email),initcap(email), first_name, upper(first_name), lower(first_name),
       length(first_name), lengthb(first_name), length('�̼���'), lengthb('�̼���')
from employees;

-- 1. �̸��� 'steven' �� ����� ����ϼ���.
select * from employees where first_name = 'Steven';
select * from employees where lower(first_name) = 'steven';

-- 2. ���� KING�� ������ ����ϼ���.
select * from employees where upper(last_name) ='KING';

-- 3. �̸��� ������ ������ 5�� ����� ����ϼ���.
select * from employees where length(first_name) = 5;

-- 4. �޿��� 5�� �̻��� ����� ���ϼ���.
select * from employees where salary >= 10000;
select * from employees where length(salary) >= 5;

-- indexOf() : ���ڿ����� ���ϴ� ���ڰ� �ִ� ��ġ ��ȣ str.indexOf('a');
-- DB������  instr() : DB�� �ε����� 1���� �����Ѵ�. 

-- 5. �̸��� 's' �ڸ� ���� ����� �� �̸��� ���°�� �ִ����� ����ϼ���.
select first_name, instr(first_name,'s')
from employees;
-- 1 steven �� 1 �̾���ϴµ� 0 ? -> ��ҹ��� �����ϱ� ���� 

-- 6. �̸��� 's' �ڰ� �� ��°�� �ִ� ����� ����ϼ���.
select * from employees where instr(first_name,'s') = 3;

-- java : 
-- String str = "I love the java";
--               01234567
-- System.out.println(str.substring(7));
-- DB������ substr
-- 7. �̸��� ���� �޿��� ������ ����� �� �̸����� 3��° ���ں��� ����ϼ���.
select first_name, last_name, salary, job_id, email, substr(email,3)
from employees;

-- 8. �̸��Ͽ� 's'���� ����ϰ�, �޿�, �Ի���, �̸� , ���� ����ϼ���.
-- ���� ��쿡�� instr() = 0 �̰� �ǹǷ� ó������ ��µȴ�. 
select email, substr(email,instr(email,'S')), salary, hire_date, first_name, last_name
from employees;

-- String str = "I love the java";
--               0123456789
-- System.out.println(str.substring(7,7+3);
-- 9. �̸�, �޿�, ����, �μ��� ����� �� �̸����� 3��°���� 3���ڸ� ����ϼ���.
-- substr(�÷�,a,b) : a ��° ���ں��� b�� ���ڸ� �����Ͷ�
select first_name, salary, job_id, department_id, email, substr(email,3,4)
from employees;

-- 10. �̸��Ͽ� 3��° ���ں��� 4���ڿ� 'ARTS'�� �ִ� ����� ����ϼ���.
select * from employees where substr(email,3,4) = 'ARTS';

-- 11. �̸��Ͽ� 's' �� 5��°�� �ִ� ����� ����ϼ���.
select * from employees where substr(email,5,1) = 'S';
select * from employees where instr(lower(email), 's') = 5;
-- ????????????????? 2�� ������� 


--- lower, upper, length, lengthb, initcap, substr, instr 

-- print("���� ���̴� %10d�̴�", % 30);
-- ���� ���̴�           30�̴�

select salary, rpad(salary, 10, '*'), lpad(salary, 10, '*') from employees;
-- ���̵� ã�� highland0 : high*****
-- 12. �̸��Ͽ��� �տ��� 2���ڸ� ����ϰ� �������� �����ʿ� * �� ä���� ����ϼ���.
select email, rpad(substr(email,1,2), length(email), '*') from employees;

-- 13. �Ի����� 03/06/17, ��ȭ��ȣ�� 515.123.4567�� ����� �̸����� �տ��� 3���ڸ� ����ϰ� �������� * �� ����ϼ���.
select rpad(substr(email,1,3),length(email),'*') 
from employees
where hire_date = '030617' and phone_number = '515.123.4567';

-- str. replace ("","")
-- 14. ������ _AS�� �ִٸ� abc�� �����ϼ���.
select replace(job_id, '_AS', 'abc'), job_id
from employees
where job_id like ('%_AS%');

-- str.trim()
select '   �̼���   ' , trim('      �̼���    '), rtrim('    �̼��� '), ltrim('  �̼���')
from dual;
-- ���鹮�ڰ� �ƴ� ��쿡�� trim('����' from �÷�) ���� �������.
-- 15. �̸��Ͽ��� 'A'�� ó���̳� ���� �ִٸ� �����Ͽ� �������.
select email,trim('A' from email), trim(email)
from employees;

-- str = 'abcdefg'
--        0123456
--        7654321
-- print (str[4:7])
-- print (str[-3:])

-- 16. �̸��Ͽ��� �ڿ��� �� ���ڸ� ���������, �� �̸��Ͽ��� �ڿ������� 2���ڸ� ���������, �̸��Ͽ��� �ڿ��� 3�������� 2���ڸ� ����ϼ���.
select email, substr(email,-1,1), substr(email,-2,2), substr(email,-3,2)
from employees;

-- 17. 010-7146-1970, 010-****-1970, 02-314-1970, 02-***-1970

select rpad(substr('010-7146-1970',1,instr('010-7146-1970','-')),
       length(substr('010-7146-1970',1,instr('010-7146-1970','-',-1)-1)),'*')
       ||substr('010-7146-1970',-5,5)
from dual;

-- 18. �̸�, �Ի���, �μ���ȣ, �޿�, ������ ����ϼ���.
select first_name, hire_date, department_id, salary, salary*12 
from employees;

-- 19. �̸�, �Ի���, �μ���ȣ, �޿�, ������ ����� �� �������� Ŀ�̼��� ���ԵǾ���Ѵ�. 
select first_name, hire_date, department_id, salary, (salary + salary * commission_pct) * 12
from employees;

--- nvl(�÷�,��) : �÷����� null�̸� ���� �ش�. 
select commission_pct, nvl(commission_pct,0)
from employees;
-- 20. Ŀ�̼��� null�̶�� Ŀ�̼� ���� 0���� �����Ͽ� �̸�, �μ�, �Ի���, ����, �޿�, Ŀ�̼�, �׸��� ������ ����ϼ���.
select first_name, department_id, hire_date, job_id, salary, commission_pct, 
       (salary + salary * nvl(commission_pct,0)) * 12
from employees;

select nvl(commission_pct, 100) from employees;


--- �����Լ� 
-- round() : �ݿø�
-- trunc() : ���� 
-- mod()   : ������

-- 21. �ݿø��ϼ��� : 5���� �ݿø��ȴ�. 
select round(15.19345,3), round(15.19355,3), round(145.5545,2), round(142.5554,1),
       round(145.5554,0), round(145.4554,0), round(145.5554,-1), round(145.5554,-2)
from dual;

-- 22. �����ϼ��� : ���� 
select trunc(15.19345,3), trunc(15.19355,3), trunc(145.5545,2), trunc(142.5554,1),
       trunc(145.5554,0), trunc(145.4554,0), trunc(145.5554,-1), trunc(145.5554,-2)
from dual;

-- 23. �Ի��Ϸκ��� ���ó�¥���� ��ĥ�� �������� �Ϸ� ����ϼ���.
-- �Ի���, �̸�, ��, ������ �Բ����.

select sysdate from dual;
select hire_date, first_name, last_name, job_id, trunc(sysdate - hire_date,0)
from employees;

-- 24. �Ի���, �̸�, ��, ������ ����� �� �Ի��Ϸκ��� �� �ְ� �������� ����ϼ���.
select sysdate from dual;
select hire_date, first_name, last_name, job_id, round((sysdate - hire_date)/7) as week
from employees;

-- 25. �Ի���, �̸�, ��, ������ ����� �� �Ի��Ϸκ��� �� �������� ����ϼ���.
select sysdate from dual;
select hire_date, first_name, last_name, job_id, round((sysdate - hire_date)/365) year 
from employees;

-- 26. ������ 17�� �̻��� ����� ����ϼ���.
select * from employees where (sysdate-hire_date)/365 >= 17;

-- 10/3 : 10%3 : mod(10,3)
select mod(10,3) from dual;

-- 27. �̸�, ��, �Ի���, �޿��� ����� �� �޿��� 400���� ���� �������� ����ϼ���.
select first_name, last_name, hire_date, salary, mod(salary,400) from employees;

-- 28. �޿��� 500���� ���� �������� 400�̻��� ������� ����ϼ���.
select * from employees where mod(salary,500) >= 400;

-- 10�� 3���� ���� �� int i = 10, int j = 3, result = i / j
--                  double d = 10, double d1 = 3, result = (int)(d/d1) ��������ȯ
select 10/3 from dual;
select trunc(10/3) from dual;


--- ��¥ �Լ� 
-- 29. ���� ��¥���� ���� �ݿ����� ��ĥ�Դϱ�?
select next_day(sysdate, '��'), next_day(sysdate, '�ݿ���')
from dual;

-- 30. �̸�, ��, ����, �Ի����� ����� �� �Ի��Ϸκ��� ���� ������� ���������� ����ϼ���.
select first_name, last_name, job_id, hire_date, next_day(hire_date,'��')
from employees;

-- add_months(a,b) : a��¥�� b������ ���Ѵ� 
-- ���ú��� 3���� �Ĵ� ��ĥ�Դϱ�? 
select add_months(sysdate,3)
from dual;

-- 31. Neena �� �Ի��ϰ� 3���� �İ� �������� �Ǵ� ���̴�.
-- �������� �Ǵ� ���� ��������, �̸�, ��, �Ի���, ����, �����ȣ�� �Բ� ����ϼ���.
select first_name, last_name, hire_date, job_id, department_id, add_months(hire_date,3)
from employees
where first_name = 'Neena';

-- 32. �Ի��� ���� ���� ������� '01/01/18' �� ����� ���ϼ���.
select * from employees where next_day(hire_date,'��') = '010118';

-- last_day() : ������ ���� ���
select last_day(sysdate) 
from dual;

-- 33. ���޿� �Ի��� ����� ����ϼ���.
select * from employees where last_day(hire_date) like '%/02/29%' ;

--- months_between(a,b) : a-b ������ 
-- 34. �Ի��Ϸκ��� ������� �� ���� �������� �̸�, ��, ����, �Ի��ϰ� �Բ� ����ϼ���.
select first_name, last_name, job_id, hire_date, trunc(months_between(sysdate,hire_date))
from employees;

-- 35. �� ����� ������ ����� ���� �� ������ ����ϼ���.
select employee_id, job_id, start_date, end_date, round(months_between(end_date,start_date))
from job_history;

-- 36. �Ի����� 200������ ���� ������� ����ϼ���.
select * from employees where months_between(sysdate,hire_date) >= 200;


--- ��ȯ�Լ� 

--- ��¥ ��ȯ 2021-05-14 11:10:35 (date)
-- 20   21   05   14   11   10   35
-- ����  ��   ��   ��   ��    ��   ��
-- 21/05/14 : 2021/05/14 : 49�⵵������ ���� ���⸦ ����´�.
-- 50/05/14 : 2050/05/14�� �ƴ϶� 1950/05/14 �� �����´�.
-- 2050/05/14 ��� ������� 2050���� �����´�. 
-- �� 50����� 99������� �������⸦ �����´�. 

-- to_date('a','b') : a�� date �������� �ٲپ��ش�. b�� a�� ����� ���� �˷��ش�. 
-- b �� a ���ڿ��� ������ �����־���Ѵ�. 
select trunc(sysdate - to_date('21-01-15'))
from dual;
select trunc(sysdate - to_date('21-01-15','yy-mm-dd'))
from dual;

-- '01-05-2021' : ���ϳ��� ���
select sysdate - to_date ('01/05/2021','mm/dd/yyyy')
from dual;

-- 03/06/17 ���Ŀ� �Ի��� ����� ����ϼ���.
select * from employees where hire_date > '03/06/17';
select * from employees where hire_date > to_date('03/06/17','yy-mm-dd');

-- 38. 17/06/03 (�Ͽ���) ���Ŀ� �Ի��� �����?
select * from employees where hire_date > to_date('17/06/03','dd-mm-yy');

--- ���� ��ȯ : ���� ��¥�� ���ڷ� ��ȯ
--             yy-mm-dd
-- to_char('a','b') : a�� b�� ������ ���ڷ� �ٲپ��ش�. b���� ���ϴ� ������ �����ָ� �ȴ�.
select sysdate, to_char(sysdate, 'yy-mm-dd'), to_char(sysdate,'dd-mm-yy'), to_char(sysdate,'yyyy-mm-dd') from dual;
select sysdate, to_char(sysdate, 'yyyy-mm-dd hh:mi:ss AM'), to_char(sysdate, 'yyyy-mm-dd hh:mi:ss.ssss AM'),
                to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss AM'), to_char(sysdate, 'yyyy-mon-dd hh:mi:ss AM')
from dual;

--- ���ڿ��� ��¥ ��
-- ���ڴ� ���� �����̱� ������ ��¥�� ���ڷ� ���� ��� ����� �ٸ��� ���� �� �ֱ� ������
-- ��¥�� ���ڷ� �ٲٴ� �� �ƴ϶� "���ڿ��� ��¥ �ٲ㼭 ��"�ϵ��� ����. 
-- 40. 25-04-2003 ���� �ʰ� �Ի��� ����� ����ϼ���.
select * from employees where hire_date > to_date('25-04-2003','dd-mm-yyyy');
select * from employees where to_char(hire_date,'dd-mm-yyyy') > '25-04-2003'; -- �߸��� �񱳹�� 

-- ���ڸ� ���ڿ���
-- 1,234,567 => w1,234,567, $1,234,567, $1,234,567-
select to_char(1234567.890, '9,999,999'),
       to_char(1234567.890, '9,999,999.00'),
       to_char(1234567.890, '$9,999,999.00'),
       to_char(1234567.890, 'L9,999,999.00'),
       to_char(-1234567.890, 'L9,999,999.00mi')
from dual;

-- 41. �̸�, ��, �����μ� �׸��� �޿��� ���ڸ��� , �� ��� $ �� ��µǰ� �Ͻÿ�
select first_name, last_name, job_id, department_id,
       to_char(salary,'$99,9999,999mi'),
       to_char(-salary,'$99,9999,999mi') -- ȸ����Ʈ���� ���� ���ȴ� minus �ڿ� ���̱� 
from employees;

-- 42. janette �Ǵ� JANETTE �Ǵ� jaNette�� ���� ���޹޾Ҵ�.
-- �̸��� 'Janette' �� ����� ����ϼ���.
select * from employees where first_name = initcap('janette') or first_name = initcap('JANETTE') or first_name = initcap('jaNette');        --1
select * from employees where lower(first_name) = 'janette' or upper(first_name) = 'JANETTE' or lower(first_name) = lower('jaNette');       --2
-- 2���� ���� �ֳ��ϸ� �÷��� ���� ���� ���� ���� ����� ���� ���ϱ⶧���̴�. 

--- java ǥ���� : switch(����) ~ case ���� : ����� break ; default : ����� 
--          case ���� when ���� then ����� else ����� end

-- 43. job_id�� 'IT_PROG' �̸� �޿��� 10% ���, 'ST_CLERK' 15% ���
--'SA_REP' 20% ��½��� ����ϰ� �ܴ̿� �޿��� �״�� ����ض�
select first_name, last_name, salary, job_id,
case job_id when 'IT_PROG' then salary + salary * 0.1
            when 'ST_CLERK' then salary + salary * 0.15
            when 'SA_REP' then salary + salary * 0.2
            else salary end sal
from employees;

select first_name, last_name, salary, job_id,
case when job_id = 'IT_PROG' then salary + salary * 0.1
     when job_id = 'ST_CLERK' then salary + salary * 0.15
     when job_id = 'SA_REP' then salary + salary * 0.2
     else salary end sal
from employees;

-- 44. ��, �̸�, ����, �޿�, �޿��� ���� ��å�� ���� ����ϼ���.
--�޿��� 3000 ���ϸ� ���
--      5000 ���� ����
--      7000 ���� �븮
--      9000 ���� ����
--      11000 ���� ����
--      13000 ���� ����
--      �� �̻��� �ӿ�

select last_name, first_name, job_id, salary,
case when salary <= 3000 then '���'
     when salary <= 5000 then '����'
     when salary <= 7000 then '�븮'
     when salary <= 9000 then '����'
     when salary <= 11000 then '����'
     when salary <= 13000 then '����'
     else '�ӿ�' end grade
from employees;

-- 45. �޿��� ���� ������ ����ϰ��� �Ѵ�. �̸�, ��, �޿�, ����, ������ ����ϼ���.
--�޿��� 2000���� ���� ���� 0�̸� �޿��� 0%
--                        1�̸� �޿��� 9%
--                        2�̸� �޿��� 20%
--                        3�̸� �޿��� 30%
--                        4�̸� �޿��� 40%
--                        5�̸� �޿��� 42%
--                        6�̸� �޿��� 44%
--                        �̿� �޿��� 45% �� �����̴�
select first_name, last_name, salary, job_id,
case when trunc(salary/2000) = 0 then salary*0.00
     when trunc(salary/2000) = 1 then salary*0.09
     when trunc(salary/2000) = 2 then salary*0.2
     when trunc(salary/2000) = 3 then salary*0.3
     when trunc(salary/2000) = 4 then salary*0.4
     when trunc(salary/2000) = 5 then salary*0.42
     when trunc(salary/2000) = 6 then salary*0.44
     else trunc(salary*0.45) end tex
from employees;

select first_name, last_name, salary, job_id,
case trunc(salary/2000) when 0 then salary*0.00
                        when 1 then salary*0.09
                        when 2 then salary*0.2
                        when 3 then salary*0.3
                        when 4 then salary*0.4
                        when 5 then salary*0.42
                        when 6 then salary*0.44
                        else trunc(salary*0.45) end tex
from employees;

select first_name, last_name, salary, job_id,
decode (job_id, 'IT_PROG' , salary + salary * 0.1
              , 'ST_CLERK' , salary + salary * 0.15
              , 'SA_REP' , salary + salary * 0.2
              , salary )sal
from employees;  

select first_name, last_name, salary, job_id,
decode( trunc(salary/2000) , 0 , salary*0.00
                           , 1 , salary*0.09
                           , 2 , salary*0.2
                           , 3 , salary*0.3
                           , 4 , salary*0.4
                           , 5 , salary*0.42
                           , 6 , salary*0.44
                           , trunc(salary*0.45) ) tex
from employees;



--- ���� 
-- �����Լ�
-- Lower, Upper, initcap, concat, substr

-- 1. ���� ��� �ҹ����� grant�� ��� �빮���� 'GRANT'�� �������̺��� �ش� ����� ã���� �Ѵ�.  (Grant) 
select * from employees where lower(last_name) = 'grant' or upper(last_name) = 'GRANT';

-- 2. 'GranT'�� �Է������� ������̺��� ���� 'Grant'�� ����� ã���ÿ�.
select * from employees where last_name = initcap('GranT');

-- 3. ���� ��� �빮�ڷ� ��ȯ�ϰ� �̸� ��� �ҹ��ڷ� ��ȯ�Ͽ�
-- ���� �̸��� �ٿ� ����� �� ' ���� GRANT douglas �Դϴ�'�� ��µǰ� �Ͻÿ�.
select '���� '||upper(last_name)||' '||lower(first_name)||' �Դϴ�.' from employees;

-- concat
-- 4. ���� �̸��� �ٿ� ���
select concat(last_name,first_name) from employees;

-- 5.  ���� ��� �빮�ڷ� ��ȯ�ϰ� �̸� ��� �ҹ��ڷ� ��ȯ�Ͽ� ���� �̸��� �ٿ� ����� �� ' ���� GRANT douglas �Դϴ�'�� ��µǰ� �Ͻÿ�. concat�� �̿�
select '���� '||concat(upper(last_name),lower(first_name))||' �Դϴ�.' from employees;

/* ���� ����
����Ŭ�� ��
String str = "abcdefghi";
String result = str.subString(2, 6); //cdef
String result = str.subString(2); //cdefghi
���� �� */ 

-- 6. ���� Davies���� av�� ����Ͻÿ�.
select substr(last_name,2,2) from employees where last_name = 'Davies';

-- 7. ���� �ι�° ���ں��� ��� ����Ͻÿ�.
select last_name,substr(last_name,2) from employees;

-- 8. ���� ������ ���ڿ��� �α��ڸ� �������ÿ�.
select last_name,substr(last_name,-2) from employees;

-- 9. ���� �ڿ� on���� ������ ����� ã���ÿ�.
select * from employees where substr(last_name,-2) = 'on';

-- 10. ���� �ڿ� ����° ���ڰ� so�� ����� ����Ͻÿ�.
select * from employees where substr(last_name,-3) like 'so%';

-- 11. ���� ������ ����ϴµ� �̸����� ���ʿ��� 3���ڸ� ����Ͻÿ�. ������ȣ, ��, �޿�, ����, �̸���
select employee_id, last_name, salary, job_id, email, substr(email,1,3)
from employees;

-- 12. ���� ������ ����ϴµ� �̸����� �����ʿ��� 3���ڸ� ����Ͻÿ�. ������ȣ, ��, �޿�, ����, �̸���
select employee_id, last_name, salary, job_id, email, substr(email,-3)
from employees;

-- 13. ���� ������ ����ϴµ� �̸����� �����ʿ��� 3���ڸ� ����ϰ� �������� ��-���� ��� ������ȣ, ��, �޿�, ����, �̸���
select employee_id, last_name, salary, job_id, email, lpad(substr(email,1,3),length(email),'-')
from employees;

/* ���� ����
String str ="abcdefg";
int i = str.indexOf("f");  //5
���� �� */

-- 14. o�� �ִ� ���� o�� ���°�� �ִ� ��ġ���� ����Ͻÿ�. --- �Ʒ� �����ϱ� ������ȣ ��, ���� ��ġ, ����
select employee_id, last_name, instr(last_name,'o'),job_id
from employees;

-- 15. oc�� �ִ� ���� oc�� ���°�� �ִ� ��ġ���� ����Ͻÿ�. -- �Ʒ� �����ϱ�  ������ȣ ��, ���� ��ġ, ����
select employee_id, last_name, instr(last_name,'oc'),job_id
from employees;

/* ���� ����
instr(last_name,'oc') : ���ϴ� ���ڰ� ������ 0�� ��ȯ
instr('abcde' , 'a') : 1
�ڹٿ��� "abcdef".indexOf("a") : 0
���� �� */

-- 16. ������ RE�� �ִ� ��� RE���� 3���ڸ� ����Ͻÿ�. ������ȣ ��,  ����, ������ ����
select employee_id, last_name, job_id,
case when job_id like '%RE%' then substr(job_id,instr(job_id,'RE'))
     else job_id end JOB_ID
from employees;

-- 17. ������ȣ, ��, �Ի��� , �޿��� 10ĭ�� ����ϰ� ������ ���� �տ� * ǥ�ð� �ǰ� ����.
select lpad(employee_id, 10, '*'),
       lpad(last_name, 10, '*'),
       lpad(hire_date, 10, '*'),
       lpad(salary, 10, '*')
from employees;

-- 18. ������ȣ, ��, �Ի��� , �޿��� 10ĭ�� ����ϰ� ������ ���� �ڿ� * ǥ�ð� �ǰ� ����.
select rpad(employee_id, 10, '*'),
       rpad(last_name, 10, '*'),
       rpad(hire_date, 10, '*'),
       rpad(salary, 10, '*')
from employees;

-- 19.  ������ȣ, ��, �Ի���, ������ ����ϴµ� ������ RE�� �ִٸ� RE�� AB�� �����Ͽ� ���
select employee_id, last_name, hire_date,
case when job_id like '%RE%' then replace(job_id,'RE','AB')
     else job_id end JOB_ID
from employees;

/* ���� ����
select trim(' ab cd ef ') 
from dual;

select trim(' ' from ' ab cd ef ') 
from dual;

select trim('a' from 'abada')
from dual;

select round(45.923, 2), round(45.924, 2), round(45.925, 2),
       round(45.926, 2)
from dual;


select trunc(45.923, 2), trunc(45.924, 2), trunc(45.925, 2),
       trunc(45.926, 2)
from dual;

select  round(45.925, 2),round(45.925, 1), round(45.925),
	round(45.925, -1), round(45.925, -2)
from dual;


select  trunc(45.925, 2), trunc(45.925, 1), trunc(45.925),
	trunc(45.925, -1), trunc(45.925, -2)
from dual;


select mod(10,3)
from dual;
���� �� */

-- 20. ������ȣ, ����ó, Ŀ�̼�, �μ���ȣ,�޿�,�޿��� 3000���� �������� ���� �������� ����Ͻÿ�.
select employee_id, phone_number, commission_pct, salary, mod(salary,3000)
from employees;

-- 21. 2002�⵵���� �Ի��� �������� ����Ͻÿ�.
select * from employees where hire_date > '020101';

-- 22. ���ش� ���ñ��� ���ְ� �������� Ȯ���Ͻÿ�.
select trunc((sysdate - to_date('2020-01-01'))/7) 
from dual; 

-- 23. �������� ��� �ٹ������� ����Ͻÿ�. ������ȣ, ��, ����ó,�μ�, �ٹ����
select employee_id, last_name, phone_number, job_id, trunc((sysdate-hire_date)/365)
from employees;

-- 24. �ټӳ�� 8�� �̻��� ����鸸 ����Ͻÿ�.
select * from job_history;
select * from job_history where trunc((end_date-start_date)/365) >= 8;

-- 25. ���� : �Խ��Ǹ���Ʈ���� ������ 5����****�� �� ó�� ������ ���� 3���ڸ� ��� �ڿ� *�� ������ ����Ͻÿ�. ������ȣ, �Ի���, ��
select employee_id, hire_date, rpad(substr(last_name,1,3),6,'*') from employees;

-- 26. ȫ�浿�� ������Դϱ�? -- ���� ��abc���� ��
select lengthb('ȫ�浿') from dual;
select lengthb('abc') from dual;

-- 27. "ȫ�浿 \n"���� �Ǿ� �ִ� ���� html���� �� �ٲ��̵ǵ��� "ȫ�浿 <br>"�����Ͻÿ�.
select replace('ȫ�浿\n','ȫ�浿\n','ȫ�浿<br>') from dual;

-- 28. �Ի����� 'YYYY-MM-DD'�� ��¥�� 31-05-2019 16:24:30 ������ ���·� �������.
select to_char(hire_date,'dd-mm-yyyy hh:mi:ss am') from employees;

-- 29. ����(3333333)�� 3�ڸ����� ��ǥ�� �� ���
select to_char(3333333, '9,999,999') from dual;

-- 30. �������̺��� �޿��� W33,333,333������ ����Ͻÿ�.
select to_char(salary,'L9,999,999') from employees;

-- 31. ������ 2018-10-25������ �ٹ��ϼ��� ����Ͻÿ�. ������ȣ, �μ���ȣ, �Ի���, �ٹ��ϼ�
select employee_id, department_id, hire_date, to_date('2018-10-25','yyyy-mm-dd')-hire_date 
from employees;
-- 32. ������ 25-10-2018������ �ٹ��ϼ��� ����Ͻÿ�. ������ȣ, �μ���ȣ, �Ի���, �ٹ��ϼ�
select employee_id, department_id, hire_date, to_date('25-10-2018','dd-mm-yyyy')- hire_date
from employees;

-- 33. ������ 10-25-2018������ �ٹ��ϼ��� ����Ͻÿ�. ������ȣ, �μ���ȣ, �Ի���, �ٹ��ϼ�
select employee_id, department_id, hire_date, to_date('10-25-2018','mm-dd-yyyy')- hire_date
from employees;

-- 34. '10-25-2002'�� �Ի��� ����� ����Ͻÿ�. ������ȣ, �μ���ȣ, �Ի���, �ٹ��ϼ�
select employee_id, department_id, hire_date, trunc(sysdate-hire_date)
from employees 
where hire_date = to_date('08-17-2002','mm-dd-yyyy');

-- 35. ���������� �Ϸ��� �մϴ�. ����(�޿�*12) : �޿��� Ŀ�̼Ǳ��� ���Եȴ�.
-- ������ ������ ���Ͻÿ�.  ������ȣ, �μ���ȣ, �޿�, ����
select employee_id, department_id, salary,(salary+(nvl(salary*commission_pct,0)))*12
from employees;

-- 36. �μ��� 90�̰ų� 30�� �μ��� ������ ������ ���Ͻÿ�. ������ȣ, �μ���ȣ, �޿�, ����
select employee_id, department_id, salary,(salary+(nvl(salary*commission_pct,0)))*12
from employees
where department_id = 90 or department_id = 30;

-- 37. ���� ��ȣ�� ���� �޿� �׸��� ������ ����Ͻÿ�.
select employee_id, last_name, salary,(salary+(nvl(salary*commission_pct,0)))*12
from employees;




-- ǥ����
-- 38. �޿��� 10000�̻��̸� "�̻���Դϴ�"
--            7000�̻��̸� "������Դϴ�"
--            5000�̻��̸� "������Դϴ�"
--            �������� ������� ����Ͻÿ�.
--            ���� �޿��� ���� ����Ѵ�.
-- case

-- 39. �޿��� 2000���� ���� ���� ���� 
--       0�̸� 0.00
--       1�̸� 0.09
--       2�̸� 0.20
--       3�̸� 0.30
--       4�̸� 0.40
--       5�̸� 0.42
--       6�̸� 0.44
--             0.45 ��ŭ ������ �ο��ȴ�.
--�ο��Ǵ� ������ ����Ͻÿ�.
--���� �޿��� ���� ����Ͻÿ�.(��, �μ��� 80�� �����)


-- 40. ���� ��ü���� �Ի����� ���Ϻ��� ����� �ֱٿ� �Ի��� ����� ����Ͻÿ�.

-- 41. �޿��� 1000������ �ݿø��Ͽ� ����Ͻÿ�.

-- 42. �����ȣ�� ¦���� ����� ����Ͻÿ�

-- 43. �����ȣ�� Ȧ���� ����� ����Ͻÿ�.

-- 44. ����� �޿��� 3000���� 6000 ������ ����� ����Ͻÿ�,

-- 45. ����� �޿��� 3000���� 6000 ������ �޿��� ���� ���ϴ� ����� ����Ͻÿ�,

-- 46. ������� �Ի����� �� �ְ� �Ǿ��� ����Ͻÿ�.

-- 47. ����� �� 1000�ְ� ���� ����鸸 ����Ͻÿ�.

-- 48. ������� �Ի����� ����� �Ǿ����� ����Ͻÿ�.

-- 49. email���� ù������ 2����, 2��°���� 2��¥ , 3��° ���� 2���ڸ� ����Ͻÿ�.

-- 50. 10-25-2003���� ���߿� ���� ����� ����Ͻÿ�.

-- 51. ������� Ŀ�̼��� �����ϴ� ������ ���Ͻÿ�.

-- 52. 50, 60, 90�� �μ��� �ƴ� ������� ���Ͻÿ�

-- 53. ��¥�� 10-20-2003���� ���� �Ի��� ����� ��� ����Ͻÿ�. �̶� Steven�� �Ի����� 10-20-2003�Դϴ�

-- 54. ����̸�, �޿�, ���� �� ���Ͻÿ�. Ŀ�̼��� ���� ��� Ŀ�̼��� 0���� �Ѵ�. ������ ���� ��� ���� ����Ͻÿ�.

-- 55. �� �������� �μ��� 60�̰ų� 90�� ����� ����Ͻÿ�




create table hc_testc
(
y number,
v varchar2(10),
sal number
)
drop table hc_testc
  insert into hc_testc values(201401,'aa',10);
  insert into hc_testc values(201401,'bb',20);
  insert into hc_testc values(201401,'aa',30);
  insert into hc_testc values(201402,'bb',10);
  insert into hc_testc values(201402,'aa',10);
  insert into hc_testc values(201403,'bb',20);
  insert into hc_testc values(201403,'cc',20);
  insert into hc_testc values(201404,'bb',30);
  insert into hc_testc values(201404,'ss',20);
  
  select * from hc_testc
--row_number() over()
select y,v,sal, row_number() over(partition by y order by v) from hc_testc
--sum() over()
select y,v,sal,sum(sal) over(partition by y order by v ) from hc_testc

--Lag��Lead��������������ͬһ�β�ѯ��ȡ��ͬһ�ֶε�ǰN�е�����(Lag)�ͺ�N�е�����(Lead)��Ϊ�������С�
--lag��������(�ֶ���,ƫ������Ĭ��ֵ) ���over()�õ���partiton by���ӣ���ôǰ��ƫ�ƵĶ���ֻ�����ڷ����ڵ�
select id,name,lag(id,1,'û��') over(order by id) lag,lead(id,1,'û��') over(order by id) lead  from test2
--first_value��last_value ����ָ���е�����ֵ��ĩ��ֵ������з��飬���Ƿ�����
select y,v,sal,first_value(sal) over(partition by y order by v) fValue,
last_value(sal) over(partition by y order by v) lValue
 from hc_testc

--rownumber,rank,dense_rank
select y,v,row_number() over(order by y) rownumber,
rank() over(order by y) rank,
dense_rank() over(order by y) dense
 from hc_testc
 
 --cume_dist��percent_rank
 select y,v,sal,rank() over(order by sal) rank,
 cume_dist() over(order by sal) cume,
 percent_rank() over(order by sal) perc--���λ��-1/������-1
  from hc_testc


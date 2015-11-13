
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

--Lag和Lead分析函数可以在同一次查询中取出同一字段的前N行的数据(Lag)和后N行的数据(Lead)作为独立的列。
--lag三个参数(字段名,偏移量，默认值) 如果over()用到了partiton by分钟，那么前后偏移的都是只能是在分组内的
select id,name,lag(id,1,'没有') over(order by id) lag,lead(id,1,'没有') over(order by id) lead  from test2
--first_value、last_value 返回指定列的首行值和末行值，如果有分组，则是分组内
select y,v,sal,first_value(sal) over(partition by y order by v) fValue,
last_value(sal) over(partition by y order by v) lValue
 from hc_testc

--rownumber,rank,dense_rank
select y,v,row_number() over(order by y) rownumber,
rank() over(order by y) rank,
dense_rank() over(order by y) dense
 from hc_testc
 
 --cume_dist、percent_rank
 select y,v,sal,rank() over(order by sal) rank,
 cume_dist() over(order by sal) cume,
 percent_rank() over(order by sal) perc--相对位置-1/总行数-1
  from hc_testc


--EP136����
--��ѯ
select * from Data0001

--��ϸ
exec sp_executesql N'select * from data0003 where curr_ptr=@P1
order by fyear,fmonth
',N'@P1 int',

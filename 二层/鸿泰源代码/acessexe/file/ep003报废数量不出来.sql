--ep003报废数量不出来
--trigger_ep003_ep001_for_data0058
IF EXISTS (SELECT name 
	   FROM   sysobjects 
	   WHERE  name = 'ep082_data0006_3' 
	   AND 	  type = 'TR')
    DROP TRIGGER ep082_data0006_3
GO
IF EXISTS (SELECT name 
	   FROM   sysobjects 
	   WHERE  name = 'ep082_data0006_4' 
	   AND 	  type = 'TR')
    DROP TRIGGER ep082_data0006_4
GO

-- 初始化数据表
IF EXISTS (SELECT name 
	   FROM   sysobjects 
	   WHERE  name = 'UPDATE058_1' 
	   AND 	  type = 'TR')
    DROP TRIGGER UPDATE058_1
GO

IF EXISTS (SELECT name 
	   FROM   sysobjects 
	   WHERE  name = 'UPDATE058_2' 
	   AND 	  type = 'TR')
    DROP TRIGGER UPDATE058_2
GO


IF EXISTS (SELECT name 
	   FROM   sysobjects 
	   WHERE  name = 'UPDATE058_3' 
	   AND 	  type = 'TR')
    DROP TRIGGER UPDATE058_3
GO


update data0060 set quan_reject=0
go

SELECT so_ptr,SUM(qty_reject) as qty_reject into #test00 
         FROM data0058,data0006,data0025
	where data0058.wo_ptr=data0006.rkey and data0025.rkey=data0006.bom_ptr and data0025.parent_ptr=0
         GROUP BY data0006.so_ptr
go

UPDATE data0060 SET quan_reject =a.qty_reject
from data0060,#test00 a
where data0060.rkey=a.so_ptr
go

drop table #test00
go

CREATE TRIGGER UPDATE058_1
ON DATA0058 
WITH ENCRYPTION 
FOR  UPDATE 
AS 
BEGIN
declare @vptr int
select @vptr=isnull(data0006.so_ptr,0) from inserted ,data0006,data0025
where inserted.wo_ptr=data0006.rkey and data0006.bom_ptr=data0025.rkey
and data0025.parent_ptr=0

if @vptr>0
 if update(qty_reject) 
 begin
    update data0060 set data0060.quan_reject=data0060.quan_reject+inserted.qty_reject-deleted.qty_reject
     from data0060,data0006,inserted,deleted
       where inserted.wo_ptr=data0006.rkey
         and data0006.so_ptr=data0060.rkey
 end
END
GO
CREATE TRIGGER UPDATE058_2
ON DATA0058
WITH ENCRYPTION 
FOR insert 
AS 
BEGIN
declare @vptr int

select @vptr=isnull(data0006.so_ptr,0) from inserted ,data0006,data0025
where inserted.wo_ptr=data0006.rkey and data0006.bom_ptr=data0025.rkey
and data0025.parent_ptr=0

if @vptr>0
update data0060 set data0060.quan_reject=data0060.quan_reject+inserted.qty_reject
  from data0060,data0006,inserted
    where inserted.wo_ptr=data0006.rkey
         and data0006.so_ptr=data0060.rkey

END
GO
CREATE TRIGGER UPDATE058_3
ON DATA0058 
WITH ENCRYPTION 
FOR delete
AS 
BEGIN
declare @vptr int

select @vptr=isnull(data0006.so_ptr,0) from deleted ,data0006,data0025
where deleted.wo_ptr=data0006.rkey and data0006.bom_ptr=data0025.rkey
and data0025.parent_ptr=0

if @vptr>0
 update data0060 set data0060.quan_reject=data0060.quan_reject-deleted.qty_reject
  from data0060,data0006,deleted
   where deleted.wo_ptr=data0006.rkey
         and data0006.so_ptr=data0060.rkey
END
GO


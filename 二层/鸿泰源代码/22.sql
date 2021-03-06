USE [demo2]
GO
/****** Object:  Trigger [dbo].[T22]    Script Date: 06/21/2017 14:34:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
ALTER  trigger [dbo].[T22] on [dbo].[Data0022] 
 for  delete 
  as 
  begin 
  declare  
  @rkey17 int  ,
  @rkey22  int,
  @Qty22 float,
  @AQty22 float,
  @AQty17 float
  
  set @qty22=0
 
	 if exists (select * from tempdb.dbo.sysobjects                         
	where id = object_id(N'tempdb..#temp')                         
	and type='U')                        
	drop table #temp
 
  select @rkey17=inventory_ptr,@rkey22=rkey,@Qty22=QUAN_ON_HAND  from deleted 
  select  INVENTORY_PTR, sum(QUAN_ON_HAND)QUAN_ON_HAND  into #temp from data0022  where INVENTORY_PTR=@rkey17  group by INVENTORY_PTR 
  select @AQty22=QUAN_ON_HAND from #temp
  select  @AQty17=quan_on_hand from data0017  where rkey= @rkey17
  
 
  if (@AQty22<>@AQty17)
  begin 
  RAISERROR('更新库存不同步！',16,1)  WITH NOWAIT
  insert into T22_17(atype,rkey17,rkey22,qty)values ('删除',@rkey17, @rkey22,@Qty22)  
  end

	if exists (select * from tempdb.dbo.sysobjects                         
	where id = object_id(N'tempdb..#temp')                         
	and type='U')                        
	drop table #temp

  end
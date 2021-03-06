USE [demo2]
GO
/****** Object:  Trigger [dbo].[T17]    Script Date: 06/21/2017 14:19:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER  trigger [dbo].[T17] on [dbo].[Data0017] 
 for   update 
  as 
  begin 
  declare  
  @rkey17 int  ,
 -- @atype varchar(10),  --更新类型
  @Qty17  float,  --更新前数量
  @Qty17_2  float, --更新后数量
  @AQty22 float,
  @AQty17 float
  
   
	if exists (select * from tempdb.dbo.sysobjects                         
	where id = object_id(N'tempdb..#temp')                         
	and type='U')                        
	drop table #temp
  
  set @qty17=0
  if (exists(select rkey from deleted))   
  select @qty17=QUAN_ON_HAND from deleted   --更新前的数量


 
  select @rkey17=rkey,@Qty17_2=QUAN_ON_HAND  from inserted 
  select  INVENTORY_PTR,  sum(QUAN_ON_HAND)QUAN_ON_HAND into #temp    from data0022  where INVENTORY_PTR=@rkey17  group by INVENTORY_PTR 
   select @AQty22=QUAN_ON_HAND from #temp
  select  @AQty17=quan_on_hand from data0017  where rkey= @rkey17
  
 
  if (@AQty22<>@AQty17)
  begin 
  RAISERROR('更新库存不同步！',16,1)  WITH NOWAIT
  insert into T22_17(atype,rkey17,qty)values ('更新',@rkey17,@Qty17_2-@Qty17)  
  end

	if exists (select * from tempdb.dbo.sysobjects                         
	where id = object_id(N'tempdb..#temp')                         
	and type='U')                        
	drop table #temp

  end
  
  
--��ѯ
select top 1 Data0862.*,data0073.user_full_name from Data0862 inner join data0073 on data0862.key73=data0073.rkey order by data0862.rkey DESC
--����
SELECT * FROM data0862
select barcode_id,quan_in_insp,quan_to_be_shipped,quan_to_be_scr,quan_useasis,quan_to_be_stocked
from data0022
where (isnull(quan_in_insp,0)>0 or isnull(quan_to_be_shipped,0)>0 or isnull(quan_to_be_shipped,0)>0
 or isnull(quan_to_be_scr,0)>0 or isnull(quan_useasis,0)>0 or isnull(quan_to_be_stocked,0)>0)
and tdate>'2013-05-03 12:43:00'
and tdate<=getdate()--��ûδ���ʣ����ϡ��˻ع�Ӧ�̵�

/*declare @p3 int
set @p3=5
declare @p4 smallint
set @p4=1
declare @p5 varchar(100)
set @p5='���ʳɹ�!'
exec EP766;3 1,1,@p3 output,@p4 output,@p5 output
select @p3, @p4, @p5
*/
declare  --������
@type int, --����;0����;1����
@Key73 int,--������
@rkey int ,--����rkey
@error_id smallint , --�����
@error_mess varchar(100) --��������
SELECT @type=1,@Key73=1,@rkey=5,@error_id=1,@error_mess='���ʳɹ�'
begin 
  if @type=1 
  begin
   
    insert into data0862(closedatetime,ifclose,key73)
    values(convert(nvarchar(20),getdate(),120),1,@key73) 
    select @rkey=max(rkey) from data0862 
    set @error_id=1
    set @error_mess='���ʳɹ�!'
  end
  else
  begin  --select * from data0862
    update data0862 set ifclose=0,opendatetime=convert(nvarchar(20),getdate(),120)
    where rkey in (select max(rkey) from data0862)
    set @error_id=2
    set @error_mess='���ʳɹ�!'
  end
  
   
end 
GO
--�̵���
select top 1 rkey from data0092 where status=0

SELECT * FROM data0860

/*
declare @p6 smallint
set @p6=0
declare @p7 varchar(100)
set @p7='201306�½�ɹ�!'
exec EP766;1 2013,6,1,N'2013-05-03 11:55:00',N'2013-05-03 13:37:33',@p6 output,@p7 output
select @p6, @p7
*/
--�����½ᵥ
DECLARE 
@Year int, --Ҫ�½����
@month int,--Ҫ�½����
@Key73 int,--�½���
@begdatetime nvarchar(20), --�½Ὺʼ����
@enddatetime nvarchar(20), --�½��������
@error_id SMALLINT,  --�����
@error_mess varchar(100)  --��������
SELECT @Year=2013,@month=6,@Key73=1,@begdatetime='2013-05-03 11:55:00',@enddatetime='2013-05-03 13:37:33'
declare 
@ifEnd int,  --�½�״̬
@rkey int,--
@last0860rkey int,
@curyearmonth nvarchar(7)--�����½�����
begin
  set @rkey=0
  set @ifEnd=99
  
  --Ҫ�½�Ľ������ڲ��ܴ��ڵ�ǰϵͳ����
  if @enddatetime>convert(nvarchar(20),getdate(),120)
  begin
    set @error_id=13
    set @error_mess='Ҫ�½�Ľ������ڲ��ܴ��ڵ�ǰϵͳ����!'
    return
  end
  select @rkey=rkey,@ifEnd=isnull(ifEnd,0)
    from Data0860 where MNYear=@Year and MNmonth=@month

 -- print @ifEnd
BEGIN TRAN
  if @ifEnd=99 --û��δ�½��¼�������¼
  begin
    
    insert into Data0860(mnYear,mnMonth,LastDatetime,enddatetime,ifend,key73,createDatetime)
    values(@Year,@month,@begdatetime,@enddatetime,0,@Key73,getdate())
    select @rkey=max(rkey) from Data0860

  end
  set @curyearmonth=rtrim(convert(varchar(4),@Year))
        +replicate('0',2-len(rtrim(convert(varchar(2),@month))))+rtrim(convert(varchar(2),@month))
  delete from Data0861 where rkey860=@rkey
  IF @@error>0
  begin
  	set @error_id=3
  	set @error_mess='�½�״̬�ж�ʧ��!'
    ROLLBACK TRAN
    return   
  END 
  --ȡ��ǰ���
  insert into data0861(rkey860,rkey17,location_ptr,rkey23,stock,amount)
  select @rkey,a.inventory_ptr,isnull(a.location_ptr,0),a.supplier_ptr,
  sum(a.quan_on_hand),round(sum(a.quan_on_hand * a.price * (1+a.tax_2/100.00)/a.exchange_rate),6)
  from data0022 a
    inner join data0017 b on a.inventory_ptr=b.rkey  and a.quantity>=0
  group by a.inventory_ptr,isnull(a.location_ptr,0),a.supplier_ptr,isnull(b.STD_COST,0)
  IF @@error>0
  begin
  	set @error_id=4
  	set @error_mess='��ת��ǰ������!'
    ROLLBACK TRAN
    return   
  END 
 -- print @oldlastenddatetime
  --ȡ�ڳ���
  set @last0860rkey=0
  select @last0860rkey=rkey from Data0860 where enddatetime=@begdatetime
  
 
  if @last0860rkey>0 
  begin
     update data0861 set begstock=b.stock,begstock_money=b.amount,std_begstock_money=b.std_calcamount
     from data0861 a
     inner join (select rkey17,location_ptr,rkey23,isnull(calcstock,0) as stock,isnull(calcamount,0) as amount,
     isnull(std_calcamount,0) as std_calcamount
     from data0861 where rkey860=@last0860rkey
     ) b on a.rkey17=b.rkey17 and a.location_ptr=b.location_ptr and a.rkey23=b.rkey23
    where a.rkey860=@rkey

    IF @@error>0
    begin
      set @error_id=5
  	  set @error_mess='��ת�ڳ�������!'
      ROLLBACK TRAN
      return   
    END 
  end
    ----��ǰʱ�̵�IQC���������������
  update data0861 set iqc_qty=b.IQC,iqc_money=b.amount
  from data0861 a
    inner join ( SELECT INVENTORY_PTR,SUPPLIER_PTR,isnull(Data0022.location_ptr,0) as location_ptr,
	    SUM(data0022.quan_in_insp+data0022.quan_in_insp1+data0022.quan_to_be_stocked+data0022.quan_to_be_stocked1+data0022.quan_useasis) AS IQC, 
	    ROUND(SUM((data0022.quan_in_insp+data0022.quan_in_insp1+data0022.quan_to_be_stocked+data0022.quan_to_be_stocked1+data0022.quan_useasis) 
	    * Data0022.PRICE*(1+data0022.tax_2/100.00)/ Data0022.EXCHANGE_RATE), 6) AS amount
       FROM Data0022
       WHERE (data0022.quan_in_insp>0 OR data0022.quan_in_insp1>0 
		OR data0022.quan_to_be_stocked>0 or data0022.quan_to_be_stocked1>0 or data0022.quan_useasis>0)
        and data0022.tdate>@begdatetime and data0022.tdate<=@enddatetime
       GROUP BY INVENTORY_PTR, SUPPLIER_PTR,isnull(Data0022.location_ptr,0)
    ) b on a.rkey17=b.inventory_ptr and a.location_ptr=b.location_ptr and a.rkey23=b.SUPPLIER_PTR
  where a.rkey860=@rkey
  IF @@error>0
  begin
  	set @error_id=6
  	set @error_mess='��ת��ǰIQC��������������ݴ���!'
    ROLLBACK TRAN
    return   
  END   
   --ȡ�����ջ����ų����²���ת�Ƶ��ջ�isnull(data0022.quan_send,0)<=0
  update data0861 set received=b.received,received_money=b.received_money
    from data0861 a
  inner join (
      SELECT data0022.inventory_ptr,Data0022.SUPPLIER_PTR,isnull(Data0022.location_ptr,0) as location_ptr,
		SUM(Data0022.QUANTITY-isnull(data0022.quan_send,0)) AS received, 
		ROUND(SUM((Data0022.QUANTITY-isnull(data0022.quan_send,0)) * Data0022.PRICE*(1+data0022.tax_2/100.00)/ Data0022.EXCHANGE_RATE), 6) AS received_money
  	  FROM Data0022 
  	  WHERE data0022.tdate>@begdatetime and data0022.tdate<=@enddatetime
        and isnull(Data0022.QUANTITY,0)>=0 and isnull(data0022.quan_send,0)<=0
	  GROUP BY data0022.inventory_ptr,data0022.supplier_ptr,isnull(Data0022.location_ptr,0)--,Data0022.CURRENCY_PTR
    ) b on a.rkey17=b.inventory_ptr and a.location_ptr=b.location_ptr and a.rkey23=b.SUPPLIER_PTR
  where a.rkey860=@rkey
  IF @@error>0
  begin
  	set @error_id=7
  	set @error_mess='��ת��ǰ�ջ����ݴ���!'
    ROLLBACK TRAN
    return   
  END  
  
   --ȡת��
  update data0861 set TranIn_qty=b.TranIn_qty,TranIn_money=b.TranIn_money
    from data0861 a
  inner join (
      SELECT data0022.inventory_ptr,Data0022.SUPPLIER_PTR,isnull(Data0022.location_ptr,0) as location_ptr,
		SUM(Data0022.QUANTITY) AS TranIn_qty, 
		ROUND(SUM((Data0022.QUANTITY) * Data0022.PRICE*(1+data0022.tax_2/100.00)/ Data0022.EXCHANGE_RATE), 6) AS TranIn_money
  	  FROM data0027 
    INNER JOIN  Data0022 ON data0027.TO_D0022_PTR = Data0022.RKEY 
    where isnull(data0022.quan_send,0)>0
      and data0027.TDATE >@begdatetime
	  AND data0027.TDATE <=@enddatetime
    GROUP BY data0022.inventory_ptr,data0022.supplier_ptr,isnull(Data0022.location_ptr,0)--,Data0022.CURRENCY_PTR
    ) b on a.rkey17=b.inventory_ptr and a.location_ptr=b.location_ptr and a.rkey23=b.SUPPLIER_PTR
  where a.rkey860=@rkey
  IF @@error>0
  begin
  	set @error_id=7
  	set @error_mess='��ת��ǰת�����ݴ���!'
    ROLLBACK TRAN
    return   
  END  
   --ȡ����
  update data0861 set extend=b.out_qty,extend_money=b.out_money
  from data0861 a
    inner join (
    SELECT data0022.inventory_ptr,data0022.supplier_ptr,isnull(Data0022.location_ptr,0) as location_ptr,
		SUM(Data0207.QUANTITY) AS out_qty, 
		ROUND(SUM(Data0207.QUANTITY *Data0022.PRICE*(1+data0022.tax_2/100.00)/ Data0022.EXCHANGE_RATE), 6) AS out_money
  	FROM Data0207 
    INNER JOIN  Data0022 ON Data0207.D0022_PTR = Data0022.RKEY 
  	WHERE Data0207.TDATE >@begdatetime
		AND Data0207.TDATE <=@enddatetime
  	GROUP BY ALL data0022.inventory_ptr,data0022.supplier_ptr,isnull(Data0022.location_ptr,0)
     ) b on a.rkey17=b.inventory_ptr and a.location_ptr=b.location_ptr and a.rkey23=b.SUPPLIER_PTR
  where a.rkey860=@rkey
  IF @@error>0
  begin
  	set @error_id=8
  	set @error_mess='��ת��ǰ�������ݴ���!'
    ROLLBACK TRAN
    return   
  END 
 --ȡת��
  update data0861 set TranOut_qty=b.TranOut_qty,TranOut_money=b.TranOut_money
  from data0861 a
    inner join (
    SELECT data0022.inventory_ptr,data0022.supplier_ptr,isnull(Data0022.location_ptr,0) as location_ptr,
	SUM(0-Data0027.QUANTITY) AS TranOut_qty,
	ROUND(SUM((Data0027.QUANTITY) * Data0022.PRICE*(1+data0022.tax_2/100.00) 
      / Data0022.EXCHANGE_RATE),4) AS TranOut_money
FROM Data0027 
INNER JOIN Data0022 ON Data0027.D0022_PTR = Data0022.RKEY 
  	WHERE isnull(Data0022.quan_send,0)<0
        and Data0027.TDATE >@begdatetime
		AND Data0027.TDATE <=@enddatetime 
  	GROUP BY ALL data0022.inventory_ptr,data0022.supplier_ptr,isnull(Data0022.location_ptr,0)
     ) b on a.rkey17=b.inventory_ptr and a.location_ptr=b.location_ptr and a.rkey23=b.SUPPLIER_PTR
  where a.rkey860=@rkey
  IF @@error>0
  begin
  	set @error_id=8
  	set @error_mess='��ת��ǰ�������ݴ���!'
    ROLLBACK TRAN
    return   
  END 
   --�˻�����Ӧ��
  update data0861 set quan_return=b.quan_return,amount_return=b.amount_return
  from data0861 a
    inner join (
       SELECT Data0096.INVT_PTR as inventory_ptr,Data0022.SUPPLIER_PTR,isnull(Data0022.location_ptr,0) as location_ptr,
           SUM(Data0096.QUAN_REJD) AS quan_return, 
           ROUND(SUM(Data0096.QUAN_REJD * Data0022.PRICE*(1+data0022.tax_2/100.00)/ Data0022.EXCHANGE_RATE), 6) AS amount_return
  	  FROM Data0096 
      INNER JOIN Data0022 ON Data0096.INV_TRAN_PTR = Data0022.RKEY
  	  WHERE Data0096.TDATE >@begdatetime
		AND Data0096.TDATE <=@enddatetime
		and (data0096.flag='2' or data0096.flag='9')
        and (((data0096.TRAN_TP=8 or data0096.TRAN_TP=38 or isnull(data0096.TRAN_TP,0)=0) and data0096.tstatus<>2) or data0096.tstatus=1 or data0096.tstatus=3)
  	 GROUP BY Data0096.INVT_PTR,SUPPLIER_PTR,isnull(Data0022.location_ptr,0)--,Data0022.CURRENCY_PTR
    ) b on a.rkey17=b.inventory_ptr and a.location_ptr=b.location_ptr and a.rkey23=b.SUPPLIER_PTR
  where a.rkey860=@rkey  
  IF @@error>0
  begin
  	set @error_id=8
  	set @error_mess='��ת��ǰ�˻���Ӧ�����ݴ���!'
    ROLLBACK TRAN
    return   
  END  
    --����
  update data0861 set quan_scrap=b.quan_scrap,amount_scrap=b.amount_scrap
    from data0861 a
    inner join ( 
      SELECT Data0096.INVT_PTR as inventory_ptr, Data0022.SUPPLIER_PTR,isnull(Data0022.location_ptr,0) as location_ptr,
		SUM(Data0096.QUAN_REJD) AS quan_scrap, 
		ROUND(SUM(Data0096.QUAN_REJD *Data0022.PRICE*(1+data0022.tax_2/100.00)/ Data0022.EXCHANGE_RATE), 6) AS amount_scrap
  	  FROM Data0096 
      INNER JOIN Data0022 ON Data0096.INV_TRAN_PTR = Data0022.RKEY
     WHERE Data0096.TDATE >@begdatetime
		AND Data0096.TDATE <=@enddatetime
		and data0096.flag='1'
        and data0096.tstatus<>2
     GROUP BY Data0096.INVT_PTR,SUPPLIER_PTR,isnull(Data0022.location_ptr,0)--,Data0022.CURRENCY_PTR 
   ) b on a.rkey17=b.inventory_ptr and a.location_ptr=b.location_ptr and a.rkey23=b.SUPPLIER_PTR
  where a.rkey860=@rkey
  IF @@error>0
  begin
  	set @error_id=9
  	set @error_mess='��ת��ǰ�������ݴ���!'
    ROLLBACK TRAN
    return   
  END 
  update data0860 set ifend=1 where rkey=@rkey
  IF @@error>0
  begin
  	set @error_id=10
  	set @error_mess='��дdata0860�����½�״̬ʧ��!'
    ROLLBACK TRAN
    return   
  END 
--������ĩ��������ĩ���
  update data0861 set calcstock=isnull(begstock,0)+isnull(received,0)+isnull(tranin_qty,0)
     -isnull(extend,0)-isnull(quan_return,0)-isnull(tranout_qty,0)-isnull(quan_scrap,0),--+isnull(iqc_qty,0),
    calcamount=isnull(begstock_money,0)+isnull(received_money,0)+isnull(tranin_money,0)-isnull(extend_money,0)
    -isnull(amount_return,0)-isnull(tranout_money,0)-isnull(amount_scrap,0), --+isnull(iqc_money,0)
   std_price=(isnull(std_begstock_money,0)+isnull(received_money,0)+isnull(tranin_money,0)
-isnull(amount_return,0)-isnull(tranout_money,0))/case when(isnull(begstock,0)+isnull(received,0)+isnull(tranin_qty,0)
-isnull(quan_return,0)-isnull(tranout_qty,0))=0 then 1 else
isnull(begstock,0)+isnull(received,0)+isnull(tranin_qty,0)-isnull(tranout_qty,0)-isnull(quan_return,0) end

  where rkey860=@rkey
  
  IF @@error>0
  begin
  	set @error_id=11
  	set @error_mess='����data0861����ĩ���ʧ��!'
    ROLLBACK TRAN
    return   
  END
  delete from data0861 
  where rkey860=@rkey
  and (isnull(begstock,0)=0 and isnull(received,0)=0 and isnull(extend,0)=0
  and isnull(quan_return,0)=0 and isnull(quan_scrap,0)=0 and isnull(iqc_qty,0)=0 
  and isnull(calcstock,0)=0)

  --������ĩ�ɱ����ɱ����Ͻ��
  update data0861 set std_extend_money=isnull(std_price,0)*isnull(extend,0),
  std_amount_scrap=isnull(std_price,0)*isnull(quan_scrap,0),
  std_calcamount=isnull(std_begstock_money,0)+isnull(received_money,0)-isnull(std_price,0)*isnull(extend,0)
    -isnull(amount_return,0)-isnull(std_price,0)*isnull(quan_scrap,0)
  where rkey860=@rkey
  
  IF @@error>0
  begin
  	set @error_id=12
  	set @error_mess='����data0861���Ȩƽ����ʧ��!'
    ROLLBACK TRAN
    return   
  END
  update data0207 set rkey860=@rkey
  where tdate>=@begdatetime and tdate<=@enddatetime
  
  set @error_mess=@curyearmonth+'�½�ɹ�!'
  commit;

  
end

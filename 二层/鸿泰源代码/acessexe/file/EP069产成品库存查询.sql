--exec EP069A;10 7,'and Data0016.code LIKE ''PW03%''',0,30

--CREATE PROCEDURE ep069A;10  --��Ʒ�����ϸ��ԭֱ��ȡData0060.exch_rate,����dbo.SF_GET_EXCHRATE(data0060.rkey,DATA0060.currency_ptr,DATA0053.MFG_DATE)�˺��������п��ؿ���  LLL 20120803
  declare
  @pararkey int=7,--4
  @sqlwhere varchar(3000)='Data0016.code LIKE ''PW03%''',
  @isKC int=0,--�Ƿ���ʾ���Ϊ0��0Ϊ����ʾ��1Ϊ��ʾ
  @Tday int=30   

--AS

  declare
   @sql varchar(8000),
   @sql2 varchar(8000),
   @sql3 varchar(8000),
   @day int 

 set @day=@Tday 
  set @sql =' 
  SELECT  data0053.rkey as d0053rkey,Data0006.WORK_ORDER_NUMBER,data0053.QTY_ALLOC,data0053.to_be_audit,
      Data0050.CATALOG_NUMBER, Data0050.CUSTOMER_PART_NUMBER,data0053.KC_remark,data0053.remark,
       Data0050.CP_REV,data0059.CUSTOMER_PART_DESC,case data0050.tax_flag when ''Y'' then ''��'' else ''��'' end as protariff,
      data0059.customer_matl_desc,Data0050.layers,
      Data0008.PROD_CODE, data0008.product_name,data0007.pr_grp_code, data0007.product_group_name,
      data0010.CUST_CODE,Data0010.ABBR_NAME as abbr_name10,
      Data0015.WAREHOUSE_CODE, Data0016.LOCATION,data0456.grn_number,Data0047.PARAMETER_VALUE,
      set_qty_total=convert(int,data0053.to_be_audit+data0053.QTY_ON_HAND+data0053.WaitShip)/isnull(data0050.set_x_qty*data0050.set_y_qty,1),
      qty_total=convert(int,data0053.to_be_audit+data0053.QTY_ON_HAND+data0053.WaitShip),
      qty_on_hand_set=data0053.QTY_ON_HAND/isnull(data0050.set_x_qty*data0050.set_y_qty,1),
      data0053.QTY_ON_HAND,data0053.WaitShip,
      ROUND(data0053.QTY_ON_HAND * Data0050.REPORT_UNIT_VALUE1 / 1000,4) AS weight, Data0050.REPORT_UNIT_VALUE1 as unit_Weight,--�����أ���������ؿ� 20120806
      case  when isnull(d01.curr_code,'''')=''''  then  isnull(data0001.curr_code,''RMB'') else d01.curr_code end as  curr_code,--�ұ� 20130123LLL 
      isnull(dbo.SF_GET_EXCHRATE(data0060.rkey,DATA0060.currency_ptr,DATA0053.MFG_DATE),1) as exch_rate,--����
      case when  isnull(data0060.rkey,0)>0 then
        (case when Data0060.PART_PRICE>0 then
               ( case Data0060.tax_in_price
                        when ''Y'' then ROUND(Data0060.PART_PRICE/(1+Data0189.STATE_TAX/100) ,4)
                        when ''N'' then ROUND(Data0060.PART_PRICE , 4)
                end)
            end)
          
          else  ROUND(Data0050.LATEST_PRICE/(1+IsNull(Data0050.last_state_tax,0)/100),4) --50�����һ�ε����Ǻ�˰�ۣ����ɲ���˰��0130306 LLL
         end as  OriCur_PRICE,   --��ֲ���˰�۸�(ԭ��)


     case when  isnull(data0060.rkey,0)>0 then
          (case when Data0060.PART_PRICE>0 then
             (CASE Data0060.tax_in_price WHEN ''Y'' THEN ROUND(Data0060.PART_PRICE  ,4)
                                         WHEN ''N'' THEN ROUND(Data0060.PART_PRICE *(1+Data0189.STATE_TAX/100),4)
              END)
           end)
        else  ROUND(Data0050.LATEST_PRICE,4)  -- 50�����һ�ε��ۣ������Ƿ�˰���� 20130306 LLL
        
       end as TaxOriCur_PRICE,     --��ֺ�˰�۸�(ԭ��)


    case when  isnull(data0060.rkey,0)>0 then
        (case when Data0060.PART_PRICE>0 then
               ( case Data0060.tax_in_price
                        when ''Y'' then ROUND(Data0060.PART_PRICE/(1+Data0189.STATE_TAX/100)  / dbo.SF_GET_EXCHRATE(data0060.rkey,DATA0060.currency_ptr,DATA0053.MFG_DATE) ,4)
                        when ''N'' then ROUND(Data0060.PART_PRICE / dbo.SF_GET_EXCHRATE(data0060.rkey,DATA0060.currency_ptr,DATA0053.MFG_DATE) , 4)
                end)
            end)
          -- else  Data0050.LATEST_PRICE/(1+IsNull(Data0189.STATE_TAX,0)/100) 
          else  ROUND(Data0050.LATEST_PRICE/(1+IsNull(Data0050.last_state_tax,0)/100),4) --50�����һ�ε����Ǻ�˰�ۣ����ɲ���˰��0130306 LLL
         end as  rmb_PRICE,   --��ֲ���˰�۸�(��λ��)
    case when  isnull(data0060.rkey,0)>0 then
          (case when Data0060.PART_PRICE>0 then
             (CASE Data0060.tax_in_price WHEN ''Y'' THEN ROUND(Data0060.PART_PRICE / dbo.SF_GET_EXCHRATE(data0060.rkey,DATA0060.currency_ptr,DATA0053.MFG_DATE) ,4)
                                         WHEN ''N'' THEN ROUND(Data0060.PART_PRICE / dbo.SF_GET_EXCHRATE(data0060.rkey,DATA0060.currency_ptr,DATA0053.MFG_DATE)*(1+Data0189.STATE_TAX/100),4)
              END)
           end)
       else  ROUND(Data0050.LATEST_PRICE,4)  --50�����һ�ε����Ǻ�˰��20130306 LLL
       
       end as TAX_rmb_PRICE,  --��ֺ�˰�۸�(��λ��)
     case when  isnull(data0060.rkey,0)>0 then
         (case when Data0060.PART_PRICE>0 then
             (CASE Data0060.tax_in_price WHEN ''Y'' THEN ROUND( Data0053.QTY_ON_HAND*Data0060.PART_PRICE ,4)
                                         WHEN ''N'' THEN ROUND(Data0053.QTY_ON_HAND*Data0060.PART_PRICE *(1+Data0189.STATE_TAX/100),4)
              END) 
         end)
         else  round(Data0053.QTY_ON_HAND*Data0050.LATEST_PRICE ,4) --50�����һ�ε����Ǻ�˰��20130306 LLL
         
          end  as taxamount_base_OriCur,     --���(��˰,ԭ��)

     case when  isnull(data0060.rkey,0)>0 then
          (case when Data0060.PART_PRICE>0 then
                 (case Data0060.tax_in_price
                        when ''Y'' then ROUND(Data0053.QTY_ON_HAND *Data0060.PART_PRICE/(1+Data0189.STATE_TAX/100) ,4)
                        when ''N'' then ROUND(Data0053.QTY_ON_HAND *Data0060.PART_PRICE , 4)
                 end )
              end)
       else  round( Data0050.LATEST_PRICE * Data0053.QTY_ON_HAND/(1+IsNull(Data0050.last_state_tax,0)/100) ,4) -- 50�����һ�ε��ۣ������Ƿ�˰���� 20130306 LLL
         end AS amount_base_OriCur, '   --���(����˰,ԭ��)


  set @sql2 ='  case when  isnull(data0060.rkey,0)>0 then
         (case when Data0060.PART_PRICE>0 then
             (CASE Data0060.tax_in_price WHEN ''Y'' THEN ROUND( Data0053.QTY_ON_HAND*Data0060.PART_PRICE / dbo.SF_GET_EXCHRATE(data0060.rkey,DATA0060.currency_ptr,DATA0053.MFG_DATE) ,4)
                                         WHEN ''N'' THEN ROUND(Data0053.QTY_ON_HAND*Data0060.PART_PRICE / dbo.SF_GET_EXCHRATE(data0060.rkey,DATA0060.currency_ptr,DATA0053.MFG_DATE)*(1+Data0189.STATE_TAX/100),4)
              END) 
         end)
           else  round(Data0053.QTY_ON_HAND*Data0050.LATEST_PRICE,4)
          end  as taxamount_base,      --���(��˰,��λ��)

    case when  isnull(data0060.rkey,0)>0 then
          (case when Data0060.PART_PRICE>0 then
                 (case Data0060.tax_in_price
                        when ''Y'' then ROUND(Data0053.QTY_ON_HAND *Data0060.PART_PRICE/(1+Data0189.STATE_TAX/100)  / dbo.SF_GET_EXCHRATE(data0060.rkey,DATA0060.currency_ptr,DATA0053.MFG_DATE) ,4)
                        when ''N'' then ROUND(Data0053.QTY_ON_HAND *Data0060.PART_PRICE / dbo.SF_GET_EXCHRATE(data0060.rkey,DATA0060.currency_ptr,DATA0053.MFG_DATE) , 4)
                 end )
              end)
          else  round( Data0050.LATEST_PRICE * Data0053.QTY_ON_HAND/(1+IsNull(Data0050.last_state_tax,0)/100) ,4) -- 50�����һ�ε����Ǻ�˰�� 20130306 LLL
         end AS amount_base,      --���(����˰,��λ��) 
ROUND(data0053.QTY_ON_HAND * Data0047.PARAMETER_VALUE, 4) AS house_mianji,ROUND(data0053.WaitShip * Data0047.PARAMETER_VALUE, 4) AS houseWaitShip,
ROUND(data0053.QTY_ON_HAND * Data0050.unit_sq, 4) AS so_mianji,ROUND(data0053.WaitShip * Data0050.unit_sq, 4) AS soWaitShip,
      data0053.MFG_DATE, data0053.REFERENCE_NUMBER,data0053.WO_DateCode,
        eng_tp,data0050.analysis_code_2,data0050.analysis_code_1+''(/''+ltrim(rtrim(str(set_x_qty*set_y_qty)))+'')'' as shipsize,data0416.reference,
  case data0492.ttype when 0 then ''����Ͷ��'' when 1 then ''���˻�����''
	when 2 then ''�˻�����'' when 3 then ''��������'' when 4 then ''�˻�����'' end cuttypedesc,
   a.parameter_value as pnl_value,data0416.post_date,

   Data0025.REVIEW_DAYS,Data0050.LATEST_PRICE,DATEDIFF(day,data0053.mfg_date,getdate()) as day, --LLL 20120607����Ч״̬
   case when DATEDIFF(day,data0053.mfg_date,getdate())>=isnull(Data0025.REVIEW_DAYS,0)  then ''�ѹ���''
        when DATEDIFF(day,data0053.mfg_date,getdate())<isnull(Data0025.REVIEW_DAYS,0) and  DATEDIFF(day,data0053.mfg_date,getdate())>isnull(Data0025.REVIEW_DAYS,0)-'+cast(@Tday as varchar(5))+' then ''Ԥ����''
           else ''����'' end as Vstatus,Data0060.SALES_ORDER, --20120911����Ҫ�����Ӷ����źͶ������� 20120911 LLL 
    case data0060.so_style when 0 then ''��ʽ����'' when 1 then ''��Ѷ���''  when 2 then ''�˻�����''  when 3 then ''���϶���'' 
    when 4 then ''�������'' when 5 then ''Ԥ���Ѷ���'' when 6 then ''�ڲ�����'' when 7 then ''��ʱ����''  end as so_style ,
    case when data0060.rkey>0 then data0060.sch_date else c.sch_date end as sch_date, --�ظ�����,���µ����ڣ��г�����20121011 LLL 
    case when data0060.rkey>0 then data0060.ent_date else c.ent_date end as ent_date,
    case when data0060.rkey>0 then data0060.ORIG_SCHED_SHIP_DATE else c.ORIG_SCHED_SHIP_DATE end as ORIG_SCHED_SHIP_DATE  '


--2012-04-16 ��SQL�ĳ������������ⳬ��8000���ַ���ִ�б���
set @sql3='
FROM (select * from data0053 WHERE (data0053.QTY_ON_HAND>0 or data0053.WaitShip>0 or 
        data0053.to_be_audit>0 or data0053.QTY_ALLOC>0)) AS data0053   
  INNER JOIN Data0050 ON data0053.CUST_PART_PTR = Data0050.RKEY  
  INNER JOIN Data0015 ON data0053.WHSE_PTR = Data0015.RKEY
  INNER JOIN Data0016 ON data0053.LOC_PTR = Data0016.RKEY
  INNER JOIN Data0025 ON Data0050.RKEY = Data0025.ANCESTOR_PTR
  INNER JOIN Data0008 ON Data0025.PROD_CODE_PTR = Data0008.RKEY
  inner join data0007 on data0008.pr_grp_pointer=data0007.rkey
  LEFT JOIN Data0010 ON Data0053.customer_ptr = Data0010.RKEY
  LEFT JOIN data0059 ON Data0053.CUST_PART_PTR=data0059.cust_part_ptr
       AND Data0053.customer_ptr=Data0059.customer_ptr             
  LEFT OUTER JOIN Data0047 ON (Data0025.RKEY = Data0047.SOURCE_POINTER AND Data0047.PARAMETER_PTR ='+cast(@pararkey as varchar(5))+')
  left join data0047 a on data0025.rkey=a.source_pointer and a.parameter_ptr=2
  LEFT OUTER JOIN Data0006 ON data0053.WORK_ORDER_PTR = Data0006.RKEY
  left join Data0060 on Data0006.SO_ptr=Data0060.rkey  
   left join data0001 on data0060.currency_ptr=data0001.rkey --20130123 LLL ����60��ȡ�ұ�����Ϊ�̵���û��SO��DATA0053һ�㲻����SOָ���
  LEFT JOIN Data0012 ON Data0060.CUST_SHIP_ADDR_PTR = Data0012.RKEY
  left join Data0189 ON Data0012.SHIP_CTAX_PTR = Data0189.RKEY

  left join data0060 c on data0053.so_ptr=c.rkey  --����Щί�ⵥû�й����� 20120921 LLL 
  left join data0001 d01 on c.currency_ptr=d01.rkey --ί����ȡ�ұ� 20130123 LLL
  left join data0416 on data0053.npad_ptr=data0416.rkey 
  left join data0492 on data0006.cut_no=data0492.cut_no  
  left join data0022 on data0053.srce_ptr=data0022.rkey 
  left join data0456 on data0022.grn_ptr=data0456.rkey
WHERE (Data0025.PARENT_PTR = 0)  ' 


 
if @isKC=0  
set @sql3 = @sql3+ ' and Data0053.QTY_ON_HAND>0  ' --����ʾ���Ϊ0������

set @sql3 =@sql3 + @sqlwhere

set @sql3 = @sql3 +'
ORDER BY  Data0050.CUSTOMER_PART_NUMBER,Data0010.CUST_CODE '

print (@sql+@sql2+@sql3) 
exec(@sql+@sql2+@sql3)


--print (@sqlview+@sql)
--print (@sql2)



go
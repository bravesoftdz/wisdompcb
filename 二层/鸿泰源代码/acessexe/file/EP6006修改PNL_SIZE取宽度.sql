
--ALTER PROCEDURE [dbo].[EP6006]
--(
declare
@vdate1 DATETIME='2013-6-1',
@vdate2 DATETIME='2013-9-1',
@vdept1 varchar(20)='',
@vdept2 varchar(20)='',
@vemp1  varchar(20)='',
@vemp2  varchar(20)=''
--)
--as 
BEGIN
select distinct t2.dept_name,data0005.employee_name,data0060.sales_order,data0006.work_order_number,
  data0050.customer_part_number,data0050.cp_rev,
  cast(set_x_qty as varchar(4))+'X'+cast(set_y_qty as varchar(3)) rult,

 -- case when CHARINDEX('m',PNL_SIZE)<=0 then Rtrim(substring(PNL_SIZE,1,CHARINDEX('x',PNL_SIZE)-1)) else
 -- Rtrim(substring(PNL_SIZE,1,CHARINDEX('m',PNL_SIZE)-1)) end PNL_LNGTH,
      case when len(rtrim(ltrim(pnl_size)))>0 then
            case when CHARINDEX('m',PNL_SIZE)<=0 then 
              case when CHARINDEX('*',PNL_SIZE)>0 then
                Rtrim(substring(PNL_SIZE,1,CHARINDEX('*',PNL_SIZE)-1)) 
              else 
                case when CHARINDEX('X',PNL_SIZE)>0 then
                   Rtrim(substring(PNL_SIZE,1,CHARINDEX('X',PNL_SIZE)-1)) 
                ELSE
                   Rtrim(substring(PNL_SIZE,1,CHARINDEX('x',PNL_SIZE)-1)) 
                END  
              end
            else
              CASE WHEN CHARINDEX('m',PNL_SIZE)>0 THEN
                CASE WHEN CHARINDEX('m',Rtrim(substring(PNL_SIZE,1,7)))>0 THEN
                   Rtrim(substring(PNL_SIZE,1,CHARINDEX('m',PNL_SIZE)-1))
                ELSE
                    Rtrim(substring(PNL_SIZE,1,CHARINDEX('x',PNL_SIZE)-1))
                END
              ELSE '0'  END
            end 
       else '0' end PNL_LNGTH, 
  CASE WHEN CHARINDEX('x',PNL_SIZE)=0 THEN
       case when CHARINDEX('m',PNL_SIZE)<=0 then substring(PNL_SIZE,CHARINDEX('*',PNL_SIZE)+1,30) else
       substring(substring(PNL_SIZE,CHARINDEX('*',PNL_SIZE)+1,30),1,
                CHARINDEX('m',substring(PNL_SIZE,CHARINDEX('*',PNL_SIZE)+1,30))-1) end ELSE
       case when CHARINDEX('m',PNL_SIZE)<=0 then substring(PNL_SIZE,CHARINDEX('x',PNL_SIZE)+1,30) 
       else
       -- LTRIM(substring(substring(PNL_SIZE,CHARINDEX('x',PNL_SIZE)+1,30),1,CHARINDEX('m',substring(PNL_SIZE,CHARINDEX('x',PNL_SIZE)+1,30))-1))
       --报SUBSTRING函数的长度参数无效
           case when CHARINDEX('m',substring(PNL_SIZE,CHARINDEX('x',PNL_SIZE)+1,30))>0 then
             LTRIM(substring(substring(PNL_SIZE,CHARINDEX('x',PNL_SIZE)+1,30),1,CHARINDEX('m',substring(PNL_SIZE,CHARINDEX('x',PNL_SIZE)+1,30))-1)) 
          else
             substring(pNL_SIZE,CHARINDEX('x',PNL_SIZE)+1,30)                                                                                                                                          
           end       
       end END PNL_WIDTH,

  data0502.unit_len set_lngth,data0502.unit_wth set_width,data0050.set_lngth DN_LEN,DATA0050.set_width DN_WTH,
  data0041.prod_pcs,data0006.parts_per_panel/t8.parameter_value*data0041.prod_pnls prod_set,--data0041.prod_sets prod_set,
  data0041.prod_pnls,t9.parameter_value*(data0041.prod_pnls*data0006.parts_per_panel) sq,
  case when t2.dept_name='V坑' then /*cast(t4.parameter_value as float)*data0041.prod_sets*/cast(t4.parameter_value as float)/1000 else 0 end WM2,
  case when t2.dept_name='V坑' then /*cast(t3.parameter_value as float)*data0041.prod_sets*/cast(t3.parameter_value as float)/1000 else 0 end LM2,
  t6.parameter_value WMD,t7.parameter_value LMD,
  data0041.tdatetime,data0010.cust_code,data0060.QTY_PLANNNED/t5.parameter_value PNLS,
  CAST(t4.parameter_value AS FLOAT) LP,CAST(t3.parameter_value AS FLOAT) WP,data0041.remark_info,DATA0041.RKEY,
  case when len(memo_info)>0 then '由'+t10.employee_name+'更改:'+data0041.memo_info else '' end memo_ifno,
  isnull(data0492.PANEL_1_QTY,0)+isnull(data0492.PANEL_2_QTY,0)+isnull(data0492.PANEL_3_QTY,0)+isnull(data0492.PANEL_4_QTY,0) pnl,
  t494_1.parameter_value DRL_KS,t494_2.parameter_value CCZCA
  into #temp
 from data0041
 left join data0006 on data0006.rkey=data0041.wo_ptr
 left join data0005 on data0005.rkey=data0041.empl_ptr
 left join data0005 t10 on t10.rkey=data0041.memo_ptr
 left join data0034 t1 on t1.rkey=data0041.fm_dept_ptr
 left join data0034 t2 on t2.rkey=t1.dept_ptr
 left join data0060 on data0060.rkey=data0006.so_ptr
 --left join data0010 on data0010.rkey=data0060.customer_ptr
 left join data0025 on data0025.rkey=data0006.bom_ptr
 left join data0050 on data0050.rkey=data0025.ancestor_ptr
 left join data0047 on data0025.rkey=data0047.source_pointer and data0047.parameter_ptr=4
 left join data0047 t5 on data0025.rkey=t5.source_pointer and t5.parameter_ptr=2
 left join data0047 t8 on data0025.rkey=t8.source_pointer and t8.parameter_ptr=3
 left join data0047 t9 on data0025.rkey=t9.source_pointer and t9.parameter_ptr=7
 left join data0279 t3 on data0025.rkey=t3.source_ptr and t3.parameter_ptr=186  --全局参数表V-CUT长度
 left join data0279 t4 on data0025.rkey=t4.source_ptr and t4.parameter_ptr=187  --全局参数表V-CUT宽度 
 left join data0279 t6 on data0025.rkey=t6.source_ptr and t6.parameter_ptr=196  --全局参数表V-CUT长刀
 left join data0279 t7 on data0025.rkey=t7.source_ptr and t7.parameter_ptr=197  --全局参数表V-CUT宽刀

 left join data0038 t38 on data0025.rkey=t38.SOURCE_PTR and t38.dept_ptr=274
 left join data0494 t494_1 on t494_1.ROUTE_STEP_PTR=t38.rkey and t494_1.PARAMETER_PTR=198
 --工序参数手工钻孔把位孔数
 left join data0038 t38_1 on data0025.rkey=t38_1.SOURCE_PTR and t38_1.dept_ptr=296
 left join data0494 t494_2 on t494_2.ROUTE_STEP_PTR=t38_1.rkey and t494_2.PARAMETER_PTR=151
 --工序参数是否过针床
 left join data0502 on data0025.rkey=data0502.source_ptr                        --拼版参数表
 left join data0010 on data0010.rkey=data0060.customer_ptr
 left join data0492 on data0492.cut_no=data0006.cut_no
where Data0041.tdatetime>=@vdate1 and data0041.tdatetime<=@vdate2
 -- and t2.dept_CODE>=@vdept1 and t2.dept_CODE<=@vdept2
 -- and data0005.empl_CODE>=@vemp1 and data0005.empl_CODE<=@vemp2
order by t2.dept_name,data0005.employee_name,data0060.sales_order

  SELECT dept_name,employee_name,sales_order,work_order_number,customer_part_number,
         cp_rev,rult,PNL_LNGTH,PNL_WIDTH,set_lngth,set_width,DN_LEN,DN_WTH,
         prod_pcs,prod_set,prod_pnls,sq,set_lngth*set_width/1000000 setsq,
         case dept_name 
           when '字符' then case when cust_code='060' or cust_code='124' then 
                                 case when cast(pnl_lngth as float)*cast(pnl_width as float)/1000000>0.1 then 0.031 else 0.028 end 
                            else case when cast(pnl_lngth as float)*cast(pnl_width as float)/1000000>0.1 then 0.027 else 0.024 end end
           when '冲床' then case when cast(pnl_lngth as float)>=450 or cast(pnl_width as float)>=450 then 0.025 
                            else case when DN_LEN*DN_WTH/1000000<0.02 then 0.016 
                                 else case when DN_LEN*DN_WTH/1000000<0.0399 then 0.019 else 0.021 end end end
           when '蚀刻' then case when cust_code='060' or cust_code='124' then  0.035 
                            else case when cast(pnl_lngth as float)*cast(pnl_width as float)/1000000>0.1 
                                 then 0.025 else 0.022 end end
           when 'V坑'  then CASE WHEN LP>0 THEN case WHEN LP<100.00 THEN 0.02 else case when LP<200.00 then 0.016 else 0.013 end end ELSE 0 END+
                            CASE WHEN WP>0 THEN case WHEN WP<100.00 THEN 0.02 else case when WP<200.00 then 0.016 else 0.013 end end ELSE 0 END    
           else 0 END DTEST,
         DN_LEN*DN_WTH/1000000 DN_SQ,
         cast(pnl_lngth as float)*cast(pnl_width as float)/1000000 pnl_sq,
         WM2,LM2,WMD,LMD,tdatetime,remark_info,cust_code,RKEY,memo_ifno,pnl,DRL_KS,CCZCA
    INTO #DISP
  FROM #TEMP

SELECT dept_name,employee_name,sales_order,work_order_number,customer_part_number,
         cp_rev,rult,PNL_LNGTH,PNL_WIDTH,set_lngth,set_width,DN_LEN,DN_WTH,
         prod_pcs,prod_set,prod_pnls,round(setsq,4) setsq,round(DN_SQ,4) DN_SQ,
         round(pnl_sq,4) pnl_sq,WM2,LM2,WMD,LMD,DTEST,
         case dept_name 
           when '字符' then DTEST*prod_pnls
           when '冲床' then DTEST*prod_set
           when '蚀刻' then DTEST*prod_pnls
           when 'V坑'  then 0
           else 0 END amount, 
         tdatetime ,remark_info,cust_code,round(sq,2) ttlsq,DRL_KS,case when dept_name='冲床' then CCZCA else '' end CCZC,
         CASE WHEN dept_name='V坑' THEN round((isnull(WM2,0)+isnull(LM2,0))*PROD_SET,2) ELSE 0 END V_LEN,RKEY,memo_ifno,pnl
   FROM #DISP
  ORDER BY DEPT_NAME,EMPLOYEE_NAME,tdatetime--SALES_ORDER

drop table #temp
drop table #disp
END

















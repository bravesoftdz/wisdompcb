select * from  data0264 --�����
select * from  data0265 --�����ϸ
 left join data0264 on data0265.AUTH_GROUP_PTR =data0264 .RKEY
 
--data0264.ttype 0�������������̣�1������������


exec sp_executesql N'select data0265.* from data0265,data0264
where Data0264.ttype=1 
--and data0264.rkey=1 --???
and data0264.rkey=data0265.auth_group_ptr and (data0265.mrb_flag=2 or data0265.mrb_flag=1)
and (UPPER_LIMIT <=@P1) AND (LOWER_LIMIT >= @P2) 
ORDER BY data0265.rkey
',N'@P1 float,@P2 float',0.25,0.25

   /*   WHEN Data0158.mrb_flag=0 THEN '��ֻ����'
      WHEN Data0158.mrb_flag=1 THEN 'SET����' 
    ,case 
      WHEN Data0158.STATUS=0 THEN 'δ�ύ'
      WHEN Data0158.STATUS=1 THEN '�����'
      WHEN Data0158.STATUS=2 THEN '�����'
      WHEN Data0158.STATUS=3 THEN '���˻�'
    end as v_STATUS     
      */
  select * from data0265    
      --user_ptr������DATA0073�д��ڣ���Ȼ�����NULL����
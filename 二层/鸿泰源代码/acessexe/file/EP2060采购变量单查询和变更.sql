--EP2060�ɹ���������ѯ�ͱ��
--�ɹ���������ѯ����
SELECT distinct PoBg_Status,rkey,v_status,PoBg_Number,PoBg_Type,v_Type,PoBg_Date,Bg_time,employee_name,po_number,v_typePO,PO_MAINMATTYPE,InPutTypeDescPO,code,supplier_name,sys_id,sys_rq,SUB_TOTAL,EXCHANGE_RATE,Back_Time,Back_Ptr,warehouse_pointer 
FROM vdata2060_1  
WHERE PoBg_TypePo='S' and PoBg_Date>='2014-02-23 00:00:00' and PoBg_Date<='2014-03-26 00:00:00' and PoBg_Status<>3  Order by PoBg_Number  Asc

���Ӳɹ���������������
exec sp_executesql N'SET NOCOUNT OFF; INSERT INTO "SJ_V20_live".."Data0921" 
("PoBg_Number","Po_Ptr","PoBg_Type","PoBg_TypePo","PoBg_Date","Bg_time","PoBg_Create","PoBg_Status","CSI_USER_POINTER","sys_id","sys_rq") 
VALUES (@P1,@P2,@P3,@P4,@P5,@P6,@P7,@P8,@P9,@P10,@P11); 
SELECT SCOPE_IDENTITY() AS SCOPE_ID_COLUMN',
N'@P1 varchar(11),@P2 int,@P3 int,@P4 varchar(1),@P5 datetime,@P6 datetime,@P7 int,@P8 int,@P9 int,@P10 varchar(5),@P11 datetime',
'POBG1301043',8273,3,'S','2014-03-25 13:47:56',NULL,1,1,1,'ADMIN','2014-03-25 13:47:56'

exec sp_executesql N'SET NOCOUNT OFF; INSERT INTO "SJ_V20_live".."Data0922" 
("Bg_PoBgRkey","Bg_reky71","Bg_BeforValue","Bg_EndrValue") 
VALUES (@P1,@P2,@P3,@P4); 
SELECT SCOPE_IDENTITY() AS SCOPE_ID_COLUMN',N'@P1 int,@P2 int,@P3 float,@P4 float',
1,28750,100,120

exec sp_executesql N'UPDATE "SJ_V20_live".."data0004" 
SET "SEED_VALUE"=@P1
 WHERE "CONTROL_NO_LENGTH"=@P2 AND "SEED_VALUE"=@P3 AND "SEED_FLAG"=@P4',
 N'@P1 varchar(11),@P2 smallint,@P3 varchar(11),@P4 tinyint',
 'POBG1301044',15,'POBG1301043',2
 
SELECT * FROM data0921
SELECT * FROM data0070 WHERE rkey=8273
SELECT * FROM DATA0073

--�����˰��
exec sp_executesql N'SET NOCOUNT OFF; INSERT INTO "SJ_V20_live".."Data0921" 
("PoBg_Number","Po_Ptr","PoBg_Type","PoBg_TypePo","PoBg_Date","Bg_time","PoBg_Create","PoBg_Status","CSI_USER_POINTER","sys_id","sys_rq") 
VALUES (@P1,@P2,@P3,@P4,@P5,@P6,@P7,@P8,@P9,@P10,@P11); 
SELECT SCOPE_IDENTITY() AS SCOPE_ID_COLUMN',
N'@P1 varchar(11),@P2 int,@P3 int,@P4 varchar(1),@P5 datetime,@P6 datetime,@P7 int,@P8 int,@P9 int,@P10 varchar(5),@P11 datetime',
'POBG1301044',8267,1,'S','2014-03-25 15:05:19',NULL,1,1,1,'ADMIN','2014-03-25 15:05:19'
exec sp_executesql N'SET NOCOUNT OFF; INSERT INTO "SJ_V20_live".."Data0922" 
("Bg_PoBgRkey","Bg_reky71","Bg_BeforValue","Bg_EndrValue") 
VALUES (@P1,@P2,@P3,@P4); SELECT SCOPE_IDENTITY() AS SCOPE_ID_COLUMN',
N'@P1 int,@P2 int,@P3 float,@P4 float',
2,28712,931.29999999999995,121
exec sp_executesql N'UPDATE "SJ_V20_live".."data0004" 
SET "SEED_VALUE"=@P1 WHERE "CONTROL_NO_LENGTH"=@P2 AND "SEED_VALUE"=@P3 AND "SEED_FLAG"=@P4',N'@P1 varchar(11),@P2 smallint,@P3 varchar(11),@P4 tinyint','POBG1301045',15,'POBG1301044',2


       ,case 
          when Data0921.PoBg_Type=1 then '��˰�۱��'  
          when Data0921.PoBg_Type=2 then '����˰�۱��' 
          when Data0921.PoBg_Type=3 then '�������' 
          when Data0921.PoBg_Type=4 then '�������ڱ��' 
          when Data0921.PoBg_Type=5 then '�ɹ����ڱ��' 
          when Data0921.PoBg_Type=6 then '�ɹ���Ӧ�̱��' 
          when Data0921.PoBg_Type=7 then '���ϱ��'
        end as v_Type
       ,case 
          when Data0921.PoBg_Status=1 then 'δ�ύ'  
          when Data0921.PoBg_Status=2 then '�����'  
          when Data0921.PoBg_Status=3 then '�����'  
          when Data0921.PoBg_Status=4 then '���˻�' 
          else 'δ�ύ' 
        end as v_status
       ,case
          when data0070.InPutType=1 then '�ֹ�����'
          when data0070.InPutType=2 then '�����ε���'
          when data0070.InPutType=3 then 'MRP����'
          when data0070.InPutType=4 then 'Ԥ�ɹ��ƻ�����' 
          when data0070.InPutType=5 then '���۲��ϵ���' 
          when data0070.InPutType=6 then 'PR������' 
          else '�ֹ�����'
       end as InPutTypeDescPO 
       ,case
          when data0070.PO_TYPE = 'S' then '��׼���϶���'
          when data0070.PO_TYPE = 'M' then '�Ǳ�׼���϶���'
          when data0070.PO_TYPE = 'T' then '��׼�ⷢ����'
          when data0070.PO_TYPE = 'N' then '�Ǳ�׼�ⷢ����'
          else ''
       end as v_typePO
      ,case
          when data0070.discount2_days =0 then '����'          
          else '����'
       end as in_outPO
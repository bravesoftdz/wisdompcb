--EP191�ύMI����
exec sp_executesql N'SET NOCOUNT OFF; INSERT INTO "SJ_V20_live".."data0150"
 ("TDATEtime","ttype","cust_part_ptr","PS_REJ","EMPL_PTR") VALUES (@P1,@P2,@P3,@P4,@P5); 
 SELECT SCOPE_IDENTITY() AS SCOPE_ID_COLUMN',
 N'@P1 datetime,@P2 int,@P3 int,@P4 tinyint,@P5 int',
 '2013-11-27 19:31:57',25,13352,0,1
 
 exec sp_executesql N'UPDATE "SJ_V20_live".."Data0050" 
 SET "baseinfo_status"=@P1 
  WHERE "baseinfo_status" IS NULL AND "RKEY"=@P2',
  N'@P1 tinyint,@P2 int',0,13352

----����״̬   NULL δ�ύ  0���ύ  1�˻�  2 ��ȷ��
---tstatus   null 0-δ�ύ,1-��1��,2-��2��,3-��3��,4-��4��,5-1����,6-2����,7-3����,,8-4����,9ͨ��,10CAM������
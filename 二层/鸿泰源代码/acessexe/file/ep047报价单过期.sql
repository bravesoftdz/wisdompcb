--ep047���۵�����
exec sp_executesql N'UPDATE "SJ_V20_Sample"."dbo"."Data0085" 
SET "expiration_date"=@P1,"old_expire_date"=@P2 --��Ч�ڣ�ԭ����Ч��
WHERE "RKEY"=@P3 AND "expiration_date"=@P4 AND "old_expire_date" IS NULL',
N'@P1 datetime,@P2 datetime,@P3 int,@P4 datetime',
'2013-07-27 22:29:57','2014-04-27 00:00:00',13747,'2014-04-27 00:00:00'

--�ָ���Ч��
exec sp_executesql N'UPDATE "SJ_V20_Sample"."dbo"."Data0085" 
SET "expiration_date"=@P1 
WHERE "RKEY"=@P2 AND "expiration_date"=@P3',
N'@P1 datetime,@P2 int,@P3 datetime',
'2014-08-27 00:00:00',13747,'2013-07-27 22:30:00'
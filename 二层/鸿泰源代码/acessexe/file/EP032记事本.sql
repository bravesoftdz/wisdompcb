--EP032���±�
exec sp_executesql N'UPDATE "SJ_V20_live".."data0011" SET "memo_text"=@P1 WHERE "RKEY"=@P2',N'@P1 text,@P2 int','�¿�����ģ��222',126805

exec sp_executesql N'SET NOCOUNT OFF; INSERT INTO "SJ_V20_live".."data0011" 
("FILE_POINTER","SOURCE_TYPE","memo_text") 
VALUES (@P1,@P2,@P3); SELECT SCOPE_IDENTITY() AS SCOPE_ID_COLUMN',N'@P1 int,@P2 smallint,@P3 text',
6677,60,'adfadsfasdfasd�¿���ͨģ�����ڣ������������+/-    PCS'
--"FILE_POINTER"��60��RKEY,�ڶ����ֶ�60
SELECT * FROM data0060 WHERE rkey=6677
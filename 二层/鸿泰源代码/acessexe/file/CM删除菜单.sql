--ɾ��������ײ�ģ��˵�
DECLARE @PROGRAM VARCHAR(30);--Ҫɾ����ִ�г�����
SET @PROGRAM='ep766.exe'

------------------------
DECLARE  @ncount INT,@rkey int
select @ncount=0,@rkey=0
select @ncount=count(*) from data0419 where programe=@program

IF @ncount>0 --�����Ƿ����
 BEGIN
  SELECT @rkey=rkey from data0419 where programe=@program
  DELETE  FROM data0074 WHERE FUNCTION_ID=@rkey
  DELETE  FROM data0073 WHERE rkey=@rkey
  SELECT @ncount,@rkey
end
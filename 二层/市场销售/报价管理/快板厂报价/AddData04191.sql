SELECT * FROM DATA0419 WHERE PROGRAME = 'qwzpr85Report.exe'
BEGIN TRANSACTION compile_all --��ʼ����
  declare @description1 varchar(50),
          @description2 varchar(50),
          @description varchar(50),
          @PROGRAME varchar(50),
          @PREV_TP char(5),
          @exe_flag smallint
  set @description1 = '���ܱ���ϵͳ' --һ���˵���
  set @description2 = '��������ά��' --����˵���
--'����DATA0511�е�ͼƬBMP��ʽתΪJPEG��ʽ'
  set @description ='���ٱ��ۡ��������(���)' --��ʶ 
--'WZPR511.exe'
  set @PROGRAME = 'qwzpr85Report.exe' --��������
  set @PREV_TP = 'W/R' --��дȨ��
  set @exe_flag = 1 --1:exe
  --select * from data0419 where description = @description1
  --����һ���˵���RKEYֵ
  declare @ancestor_ptr int
  set @ancestor_ptr =(select top 1 rkey from data0419 where description =@description1)
  print @ancestor_ptr
  --���Ҷ����˵���RKEYֵ
  --select * from data0419 where description = @description2
  declare @parent_ptr int
  set @parent_ptr = (select top 1 rkey from data0419 where description =@description2 and ancestor_ptr=@ancestor_ptr)
  print @parent_ptr
  --���ҳ�����SEQ_NOֵ������ֵ��1,Ϊ������¼�������ֵ
  --select * from data0419 where description = '���ٱ��� ϵͳ'
  declare @SEQ_NO int
  --SELECT MAX(SEQ_NO) AS maxSEQ_NO FROM dbo.Data0419 WHERE (ANCESTOR_PTR = @ancestor_ptr) AND (PARENT_PTR = @parent_ptr)
  set @SEQ_NO=(SELECT MAX(SEQ_NO)+1 AS maxSEQ_NO
                    FROM dbo.Data0419
                WHERE (ANCESTOR_PTR = @ancestor_ptr) AND (PARENT_PTR = @parent_ptr))

  print @ancestor_ptr
  print @parent_ptr
  print '@SEQ_NO='
  print @SEQ_NO
  
  --�����419���ֶ�������RKEY�⣩�������ڱ�������һ���ɵļ�¼ֵ��Ȼ�������ļ�¼��һЩ�ֶ�ֵ��ʹ֮����
  declare @exesql varchar(1000),
          @exesql2 varchar(255)
  set @exesql = '' 
  declare @i int,@maxi int
  set @i=1
  set @maxi=(SELECT TOP 100 PERCENT MAX(syscolumns.colid) AS Expr1
                    FROM syscolumns INNER JOIN
                        sysobjects ON syscolumns.id = sysobjects.id
                    WHERE (sysobjects.name = N'data0419'))
  while (@maxi>@i)
    begin
      set @i = @i + 1
      set @exesql2 = (SELECT TOP 100 PERCENT syscolumns.name 
                       FROM syscolumns INNER JOIN
                              sysobjects ON syscolumns.id = sysobjects.id
                       WHERE (sysobjects.name = N'data0419')
                             and syscolumns.colid = @i)
      if (@maxi <> @i) 
         set @exesql =ltrim(rtrim(@exesql)) + ltrim(rtrim(@exesql2))+','
      else if (@maxi = @i) 
         set @exesql =ltrim(rtrim(@exesql)) + ltrim(rtrim(@exesql2))   
      --print @exesql2
    end

  set @exesql ='INSERT INTO data0419('+ltrim(rtrim(@exesql)) +') select top 1  '+ ltrim(rtrim(@exesql)) +
                ' from data0419 where (ANCESTOR_PTR =' +CONVERT(varchar(10),@ancestor_ptr)+') AND (PARENT_PTR ='+ CONVERT(varchar(10),@parent_ptr)+')'
  --print @exesql
  exec(@exesql)

  declare @rkey int
  set @rkey = (select top 1 rkey from data0419 order by rkey DESC)
  --print @rkey
  
  update data0419
     set seq_no = @seq_no,
         exe_flag = @exe_flag,
         [description] =@description,
         PROGRAME = @PROGRAME,
         PREV_TP = @PREV_TP
     where rkey = @rkey
  --���DATA0419�����Ƿ����ֶ�PROGRAM������о͸ı�������¼�Ķ�Ӧ��PROGRAM��ֵ
  IF EXISTS(SELECT TOP 100 PERCENT syscolumns.colid
        FROM syscolumns INNER JOIN
                     sysobjects ON syscolumns.id = sysobjects.id
            WHERE (sysobjects.name = N'data0419') AND
                 (syscolumns.name = N'PROGRAM'))
    BEGIN
      SET @exesql = 'update data0419 set PROGRAM ='''+ LTRIM(RTRIM(@PROGRAME))
             +''' where rkey ='+CONVERT(varchar(10),@rkey)
      EXEC(@exesql)
    END
  select * from data0419 --��ʾ��data0419���еļ�¼ֵ��
if @@error = 0 --�Ƿ����
  commit tran compile_all --�ύ����
else
  rollback tran compile_all --�ع�����

  -- delete data0419 where rkey = 453  --ɾ����¼

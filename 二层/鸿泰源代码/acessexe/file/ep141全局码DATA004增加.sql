ep141ȫ����DATA004����
declare @vptr int
select @vptr=count(*) from data0004 where rkey=70
if @vptr=0
INSERT INTO Data0004
           ([CONTROL_NO_LENGTH]
           ,[SEED_MEAN]
           ,[BIG5_SEED_MEAN]
           ,[SEED_VALUE]
           ,[SEED_FLAG]
           ,[table_name])
     VALUES
           (10
           ,'���۳��ֵ���'
           ,'���۳��ֵ���'
           ,'X10000001'
           ,4
           ,'DATA0457')


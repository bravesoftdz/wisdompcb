�߹�  14:55:04
create TRIGGER [data0056_lisenter] ON [dbo].[data0056] 
FOR update
AS
  --���ڼ�ظ���ֵ������
  if update(to_be_stocked)
  begin
    declare @beforettype float
    declare @afterttype float
  
    select @beforettype=to_be_stocked from inserted --����֮ǰ��ֵ
    select @afterttype=to_be_stocked from deleted   --����֮���ֵ
   
    if @afterttype<0
    begin
       select * from data0056���to_be_stocked������
    end 
  end
go

�߹�  14:55:04
create TRIGGER [data0056_lisenter] ON [dbo].[data0056] 
FOR update
AS
  --���ڼ�ظ���ֵ������
  if update(to_be_stocked)
  begin
    declare @beforettype float
    declare @afterttype float
  
    select @beforettype=to_be_stocked from inserted --����֮ǰ��ֵ
    select @afterttype=to_be_stocked from deleted   --����֮���ֵ
   
    if @afterttype<0
    begin
       select * from data0056���to_be_stocked������
    end 
  end
go

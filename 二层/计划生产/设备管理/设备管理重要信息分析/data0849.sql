if not exists(select * from data0419 where description='�豸ά�����ݷ���')
insert into data0419(SEQ_NO,DESCRIPTION,PREV_TP,PROGRAME,VerNo,manu_ptr)
select SEQ_NO+1,'�豸ά�����ݷ���',PREV_TP,'WZPR846.exe','1.1.1.1',manu_ptr from data0419 where description='���������'
 
 if not Exists   (select * from sysobjects where name= 'data0849' and type= 'U') --drop table data0849
  begin --select *from data0849  delete data0849  where rkey in(540,541)
    CREATE TABLE [dbo].[data0849](	
		[Rkey]			int identity not   null, --�Զ���ţ�������
		[D419_ptr]      int          not   null, --����ָ�루�����
		[D073_ptr]	    int          not   null, --�û�ָ�루�����
		[FormName]	    [varchar](50)not   null, --������ 
		[GridName]	    [varchar](50)not   null, --����� 
		[FieldName]	    [varchar](50)not   null, --�ֶ��� 
		[FieldCaption]	[varchar](100)not  null, --�ֶ��� 		
		[FieldOrder]    int                null, --�ֶ�˳��
		[FieldWidth]    int                null, --�ֶο��
		[IsDisplay]     bit                null, --�Ƿ���ʾ
       CONSTRAINT [PK_data0849] PRIMARY KEY CLUSTERED ([Rkey])ON [PRIMARY],
       CONSTRAINT [FK_data0849_Data0419_rkey]FOREIGN KEY ([D419_ptr]) REFERENCES [data0419]([rkey]),
       CONSTRAINT [FK_data0849_Data0073_rkey]FOREIGN KEY ([D073_ptr]) REFERENCES [data0073]([rkey]),             
)
end
--�ֶ����˵�� 
EXEC sp_addextendedproperty 'MS_Description', '����ָ��', 'user', dbo, 'table', data0849, 'column', [D419_ptr]
EXEC sp_addextendedproperty 'MS_Description', '�û�ָ��', 'user', dbo, 'table', data0849, 'column', [D073_ptr]
EXEC sp_addextendedproperty 'MS_Description', '������'  , 'user', dbo, 'table', data0849, 'column', [FormName]
EXEC sp_addextendedproperty 'MS_Description', '�����'  , 'user', dbo, 'table', data0849, 'column', [GridName]
EXEC sp_addextendedproperty 'MS_Description', '�ֶ���'  , 'user', dbo, 'table', data0849, 'column', [FieldName]
EXEC sp_addextendedproperty 'MS_Description', '�ֶ���'  , 'user', dbo, 'table', data0849, 'column', [FieldCaption]
EXEC sp_addextendedproperty 'MS_Description', '�ֶ�˳��', 'user', dbo, 'table', data0849, 'column', [FieldOrder]
EXEC sp_addextendedproperty 'MS_Description', '�ֶο��', 'user', dbo, 'table', data0849, 'column', [FieldWidth]
EXEC sp_addextendedproperty 'MS_Description', '�Ƿ���ʾ', 'user', dbo, 'table', data0849, 'column', [IsDisplay]
--��ӱ�����   
EXEC sp_addextendedproperty  'MS_Description', '�û��ֶ��Զ����','user',dbo,'table', [data0849]


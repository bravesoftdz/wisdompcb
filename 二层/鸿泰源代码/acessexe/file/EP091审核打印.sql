--EP091��˴�ӡ
IF not EXISTS (
SELECT name
FROM syscolumns
WHERE (name = 'mo_prt_sample_flag') AND (id IN
          (SELECT id
         FROM sysobjects
         WHERE name = 'data0195'))) 
begin
alter table data0195 add mo_prt_sample_flag bit default(0) not null
---�Ƿ��������������ϵ����ǰ��ӡ���ϵ���0������1����
end
GO

IF not EXISTS (
SELECT name
FROM syscolumns
WHERE (name = 'mo_prt_bf_audit_flag') AND (id IN
          (SELECT id
         FROM sysobjects
         WHERE name = 'data0195'))) 
begin
alter table data0195 add mo_prt_bf_audit_flag bit default(0) not null
---�Ƿ����������������ϵ����ǰ��ӡ���ϵ���0������1����
end
GO

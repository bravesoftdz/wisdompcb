/*
   2015年8月26日星期三13:58:59
   用户: sa
   服务器: 172.16.68.8
   数据库: sj_v20_live
   应用程序: 
*/

/* 为了防止任何可能出现的数据丢失问题，您应该先仔细检查此脚本，然后再在数据库设计器的上下文之外运行此脚本。*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Resttypemsg ADD
	userdefine binary(50) NOT NULL CONSTRAINT DF_Resttypemsg_userdefine DEFAULT 1
GO
DECLARE @v sql_variant 
SET @v = N'前三为0,系统自带不可更改删除.用户定义为1,允许更改删除'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'SCHEMA', N'dbo', N'TABLE', N'Resttypemsg', N'COLUMN', N'userdefine'
GO

ALTER TABLE dbo.FactoryCalendar ADD
	slr_ptr int NOT NULL CONSTRAINT DF_FactoryCalendar_slr_ptr1 DEFAULT 0
GO
COMMIT

update Resttypemsg
set userdefine = 0 
where rkey<4

update FactoryCalendar
set slr_ptr = CalendarID + 9 













不同服务器数据库之间的数据操作
--创建链接服务器 
exec sp_addlinkedserver   'ITSV ', ' ', 'SQLOLEDB ', '远程服务器名或ip地址 ' 
exec sp_addlinkedsrvlogin  'ITSV ', 'false ',null, '用户名 ', '密码 ' 
--查询示例 select * from ITSV.数据库名.dbo.表名 
--导入示例 select * into 表 from ITSV.数据库名.dbo.表名 
--以后不再使用时删除链接服务器 exec sp_dropserver  'ITSV ', 'droplogins '

/*测试
 * 要分开执行就可以
 
exec sp_addlinkedserver   'ITSV', ' ', 'SQLOLEDB ', '192.168.8.148' 
exec sp_addlinkedsrvlogin  'ITSV', 'false ',null, 'sa ', 'koimy1234' 
select * from ITSV.sj_v20_live.dbo.data0015
exec sp_dropserver  'ITSV ', 'droplogins ' 
 
 
 */

 
 
 
--连接远程/局域网数据(openrowset/openquery/opendatasource) 
--1、openrowset 
--查询示例 select * from openrowset( 'SQLOLEDB ', 'sql服务器名 '; '用户名 '; '密码 ',数据库名.dbo.表名) 
--生成本地表 select * into 表 from openrowset( 'SQLOLEDB ', 'sql服务器名 '; '用户名 '; '密码 ',数据库名.dbo.表名) 
--把本地表导入远程表 insert openrowset( 'SQLOLEDB ', 'sql服务器名 '; '用户名 '; '密码 ',数据库名.dbo.表名) 
select *from 本地表 
--更新本地表 update b set b.列A=a.列A  from openrowset( 'SQLOLEDB ', 'sql服务器名 '; '用户名 '; '密码 ',数据库名.dbo.表名)as a 
inner join 本地表 b on a.column1=b.column1 

/* 测试
 
 --启用Ad Hoc Distributed Queries： 
exec sp_configure 'show advanced options',1 
reconfigure 
exec sp_configure 'Ad Hoc Distributed Queries',1 
reconfigure 
select * from openrowset( 'SQLOLEDB ', '192.168.8.148'; 'sa'; 'koimy1234',sj_v20_live.dbo.data0015)

--关闭Ad Hoc Distributed Queries： 
exec sp_configure 'Ad Hoc Distributed Queries',0 
reconfigure 
exec sp_configure 'show advanced options',0 
reconfigure
 */




--openquery用法需要创建一个连接 
--首先创建一个连接创建链接服务器 
exec sp_addlinkedserver   'ITSV ', ' ', 'SQLOLEDB ', '远程服务器名或ip地址 '
 --查询 
 select * FROM openquery(ITSV,  'SELECT *  FROM 数据库.dbo.表名 ') 
 --把本地表导入远程表 
 insert openquery(ITSV,  'SELECT *  FROM 数据库.dbo.表名 ')
 select * from 本地表 --更新本地表 
                      --
 update b set b.列B=a.列B 
 FROM openquery(ITSV,  'SELECT * FROM 数据库.dbo.表名 ') as a 
  inner join 本地表 b on a.列A=b.列A 
 
 
 
  
  --3、opendatasource/openrowset 
  SELECT   * FROM   opendatasource( 'SQLOLEDB ',  'Data Source=ip/ServerName;User ID=登陆名;Password=密码 ' ).test.dbo.roy_ta 
  --把本地表导入远程表 
  --insert opendatasource( 'SQLOLEDB ',  'Data Source=ip/ServerName;User ID=登陆名;Password=密码 ').数据库.dbo.表名 
  select * from﻿
EP242����������
����492��
exec sp_executesql N'SET NOCOUNT OFF; INSERT INTO "SJ_V20_live".."data0492" 
("TTYPE","CUT_NO","SO_NO","BOM_PTR","PLANNED_QTY","ISSUED_QTY","SCH_COMPL_DATE","ISSUE_DATE","CREATED_BY_PTR","FM_WO_NUMBER","TO_WO_NUMBER","UPANEL1","PANEL_1_QTY","CUSTOMER_PTR") 
VALUES (@P1,@P2,@P3,@P4,@P5,@P6,@P7,@P8,@P9,@P10,@P11,@P12,@P13,@P14); 
SELECT SCOPE_IDENTITY() AS SCOPE_ID_COLUMN',
N'@P1 tinyint,@P2 varchar(20),@P3 varchar(12),@P4 int,@P5 int,@P6 int,@P7 datetime,@P8 datetime,@P9 int,@P10 varchar(12),@P11 varchar(12),@P12 int,@P13 int,@P14 int',
1,'W1-130920002        ','RT130917-001',11584,0,0,'2013-09-20 00:00:00','2013-09-20 17:15:36',1,'W1-130920002','W1-130920002',7,152,309
����6��
exec sp_executesql N'SET NOCOUNT OFF; INSERT INTO "SJ_V20_live".."data0006" 
("WORK_ORDER_NUMBER","CUT_NO","BEGIN_STEP_NO","WHOUSE_PTR","BOM_PTR","PRIORITY_CODE","PROD_STATUS","QUAN_SCH","QUAN_REJ","QUAN_PROD","PANELS","ENT_DATETIME","SCH_COMPL_DATE","PARTS_PER_PANEL","RELEASE_DATE","FLOW_NO","WIPMAT_STATUS","wtype","SO_PTR","SETS_QTY","parts_per_set") 
VALUES (@P1,@P2,@P3,@P4,@P5,@P6,@P7,@P8,@P9,@P10,@P11,@P12,@P13,@P14,@P15,@P16,@P17,@P18,@P19,@P20,@P21); 
SELECT SCOPE_IDENTITY() AS SCOPE_ID_COLUMN',N'@P1 varchar(12),@P2 varchar(20),@P3 smallint,@P4 int,@P5 int,@P6 tinyint,@P7 smallint,@P8 float,@P9 float,@P10 float,@P11 int,@P12 datetime,@P13 datetime,@P14 float,@P15 datetime,@P16 smallint,@P17 smallint,@P18 tinyint,@P19 int,@P20 int,@P21 int',
'W1-130920002','W1-130920002        ',2,2,11584,0,3,152,0,0,7,'2013-09-20 17:15:36','2013-09-20 00:00:00',22,'2013-09-20 17:15:35',0,1,1,8834,152,1
��������
exec sp_executesql N'SET NOCOUNT OFF; INSERT INTO "SJ_V20_live".."data0056" 
("WO_PTR","DEPT_PTR","EMPLOYEE_PTR","FLOW_NO","STEP","QTY_BACKLOG","PANELS","INTIME","WTYPE","SETS_QTY")
 VALUES (@P1,@P2,@P3,@P4,@P5,@P6,@P7,@P8,@P9,@P10); 
 SELECT SCOPE_IDENTITY() AS SCOPE_ID_COLUMN',N'@P1 int,@P2 int,@P3 int,@P4 smallint,@P5 smallint,@P6 float,@P7 int,@P8 datetime,@P9 tinyint,@P10 int',
 22770,348,0,0,2,152,7,'2013-09-20 17:15:36',1,152
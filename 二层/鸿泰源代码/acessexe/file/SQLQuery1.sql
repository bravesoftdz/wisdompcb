--EP702ѡ����˻ص����뵥��
--Vdata0703_4
SELECT     dbo.data0700.RKEY, dbo.data0700.DEPT_CODE, dbo.Data0034.DEPT_NAME, dbo.data0700.TDATE, dbo.Data0005.EMPLOYEE_NAME AS USER_FULL_NAME
FROM         dbo.data0700 LEFT OUTER JOIN
                      dbo.Data0034 ON dbo.data0700.DEPT_CODE = dbo.Data0034.RKEY LEFT OUTER JOIN
                      dbo.Data0005 RIGHT OUTER JOIN
                      dbo.Data0073 ON dbo.Data0005.RKEY = dbo.Data0073.EMPLOYEE_PTR ON dbo.data0700.USER_PTR = dbo.Data0073.RKEY
WHERE     (dbo.data0700.STATUS = 3)

SELECT RKEY As ���쵥��,DEPT_NAME As ���첿��,TDATE As ��������,USER_FULL_NAME As ������Ա FROM Vdata0703_4  Where 1=1 and 1=1 and dept_code='329' Order by RKEY


if exists (select * from sysobjects where id = object_id(N'autocal85') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
    drop PROCEDURE autocal85
GO
/*
(����ֵ)            ����ΪX����  y1(col)  y2    y3    y4     y5
����ΪY����            0        ֵ1      ֵ2   ֵ3    ֵ4    ֵ5
   1(row_index)       x11      ֵ6      ֵ7   ֵ8    ֵ9    ֵ10    
   2                  x12      ֵ11     ֵ12  ֵ13   ֵ14   ֵ15
   3                  x13      ֵ16     ֵ17  ֵ18   ֵ19   ֵ20

��Ҫ��ֵ7��Ҫ����Ĳ���Ϊ   @vtp,@vptr,y2,x11,0,0
*/
CREATE PROCEDURE autocal85;1  --�������е�ֵ�ҳ���Ӧ�ı��е�ֵ
  @vptr int, --��280��ָ��
  @vcol0 varchar(50), --����ֵֻ���ַ� ,��ӦYֵ
  @vrow0 varchar(50), --  ��ӦXֵ
  @vcol real, --����ֵֻ������ --��ӦYֵ
  @vrow real  --��ӦXֵ
--with encryption
AS
  begin
	declare @vmcol int  /*��������*/
	declare @vmrow int  /*��������*/
	--���ݲ�����������ȷ�����ص�ֵ,
	--���ַ���Ϊ:���ڵ��ڴ�ֵ�ĵ�һ���ڱ��е�ֵ
	--�ַ���ʵ���е�ֵ�����ض�Ӧ��ֵ
        DECLARE @vtpx int,@vtpy int
        set  @vtpx = (SELECT top 1 Data0278.DATA_TYPE 
                        FROM Data0280 LEFT OUTER JOIN
                          Data0278 ON Data0280.FX = Data0278.RKEY where  Data0280.rkey = @vptr)
        set  @vtpy = (SELECT top 1 Data0278.DATA_TYPE 
                       FROM Data0280 LEFT OUTER JOIN
                         Data0278 ON Data0280.FY = Data0278.RKEY where  Data0280.rkey = @vptr)
     
--print @vtpx
--print @vtpy

        if @vtpx = 1 --����Ϊ���� row_index
	  	set @vmcol=( select min(row_index) as vmcol from data0282
	 	 where eng_table_ptr=@vptr
	 		 and col=1
 	 		 and cast(tvalue as decimal(20,8))>= @vcol)
        else if @vtpx = 2 --����Ϊ�ַ�
 		 set @vmcol=( select min(row_index) as vmcol from data0282
		    where eng_table_ptr=@vptr
 		 	and col = 1  
  			and ''''+ltrim(rtrim(tvalue))+''''= @vcol0 )
        if @vtpy is null 
             set @vmrow=( select min(col) as vmrow from data0282
         		 where eng_table_ptr=@vptr
	         		and row_index = 1
	          		and cast(tvalue as decimal(20,8))>=1)
        else
            begin
                if @vtpy = 1 --����Ϊ����
	  	        set @vmrow=( select min(col) as vmrow from data0282
         		 where eng_table_ptr=@vptr
	         		and row_index=1 
	          		and cast(tvalue as decimal(20,8))>=@vrow)
                else if @vtpy = 2 --����Ϊ�ַ�
 	        	 set @vmrow=( select min(col) as vmrow from data0282
 		            where eng_table_ptr=@vptr
  	        		and row_index=1 
 		         	and ''''+ltrim(rtrim(tvalue))+''''=@vrow0)
            end

	
	--����ʵ�ʵ�ֵ
	select tvalue from data0282
	  where eng_table_ptr=@vptr
		and col=@vmrow
		and row_index=@vmcol
       --select @vptr,@vmcol,@vmrow

end
go



declare @data0085rkey int
set @data0085rkey = 12
--����ÿһ�����۵��Ĳ��������ֵ
SELECT Data0431.*, Data0278.PARAMETER_NAME, 
      Data0278.PARAMETER_DESC, Data0278.DATA_TYPE, 
      Data0002.UNIT_CODE, Data0002.UNIT_NAME
FROM Data0431 INNER JOIN
      Data0278 ON Data0431.UNIT_PTR = Data0278.RKEY INNER JOIN
      Data0002 ON Data0278.UNIT_PTR = Data0002.RKEY
WHERE (Data0431.QTE_PTR = @data0085rkey)
--ÿһ�����۵�Ҫ�õ������ر���
SELECT Data0348.*
FROM Data0348 INNER JOIN
      Data0432 ON Data0348.RKEY = Data0432.SOURCE_PTR
WHERE (Data0432.QTE_PTR = @data0085rkey)

--ÿһ���ر���Ҫ�õ��Ĳ���
SELECT Data0348.ADDER_NAME, Data0430.*, Data0002.UNIT_CODE, 
      Data0002.UNIT_NAME
FROM Data0348 INNER JOIN
      Data0430 ON Data0348.RKEY = Data0430.SOURCE_PTR INNER JOIN
      Data0278 ON Data0430.UNIT_PTR = Data0278.RKEY INNER JOIN
      Data0002 ON Data0278.UNIT_PTR = Data0002.RKEY


--ѡ���ر�����Ҫ�õ���ȫ������
SELECT DISTINCT Data0278.PARAMETER_NAME, Data0278.DATA_TYPE
FROM Data0430 INNER JOIN
      Data0278 ON Data0430.UNIT_PTR = Data0278.RKEY

--ÿһ�����۵���Ҫ�õ��Ĳ�����ֵ
	SELECT Data0278.PARAMETER_NAME, Data0278.DATA_TYPE, 
	      case Data0431.UNIT_VALUE when null then (case Data0278.DATA_TYPE when 1 then 0
                                                                               when 2 then ''' ''' end)
                               else  (case Data0278.DATA_TYPE when 1 then Data0431.UNIT_VALUE
                                                              when 2 then ''''+Data0431.UNIT_VALUE+'''' end) end
	               as UNITVALUE
	FROM Data0431 INNER JOIN
	      Data0278 ON Data0431.UNIT_PTR = Data0278.RKEY
	WHERE (Data0431.QTE_PTR = @data0085rkey)


--exec sp_addextendedproperty N'MS_Description', N'��λ��,��������,����', N'user', N'dbo', N'table', N'TProvince'
--exec sp_addextendedproperty N'MS_Description', N'��������', N'user', N'dbo', N'table', N'TProvince', N'column', N'ZipCode'
--
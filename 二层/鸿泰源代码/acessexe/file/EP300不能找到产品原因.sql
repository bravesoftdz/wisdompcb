--EP300�����ҵ���Ʒԭ��
SELECT distinct top 100 PERCENT Data0050.RKEY,  --��������ƶ����� 
      Data0050.CUSTOMER_PART_NUMBER, data0059.customer_part_desc,
      Data0050.CP_REV, data0059.customer_ptr,data0050.QTY_ON_HAND,
      Data0050.CATALOG_NUMBER, Data0010.CUST_CODE,
      Data0010.ABBR_NAME,data0279.parameter_value
FROM Data0010 RIGHT OUTER JOIN
      data0059 ON
      Data0010.RKEY = data0059.customer_ptr RIGHT OUTER JOIN
      Data0050 ON data0059.cust_part_ptr = Data0050.RKEY  inner join
     Data0053 on Data0050.rkey=data0053.cust_part_ptr  and ((data0010.rkey=data0053.customer_ptr)  or (isnull(data0053.customer_ptr,0)=0))   --�ӿͻ�ָ���Ϊ��
    left join data0025 on data0050.rkey=data0025.ancestor_ptr and data0025.parent_ptr=0 left join  
     data0279 on Data0025.rkey=Data0279.source_ptr and Data0279.parameter_ptr=441   
  WHERE (Data0050.TTYPE < 2) --0,��1,��2,���� ���۲�Ʒ�����������
  and data0053.QTY_ON_HAND>0

ORDER BY Data0050.CUSTOMER_PART_NUMBER
 
(--�����б��ѯ��ͼ
SELECT     dbo.Data0060.SALES_ORDER AS ���۶�����,dbo.Data0015.ABBR_NAME ����,

dbo.Data0025.MANU_PART_NUMBER AS �������, dbo.Data0025.MANU_PART_DESC AS �ͻ��ͺ�, dbo.Data0025.ANALYSIS_CODE_2 AS �ͻ����Ϻ�,
dbo.Data0025.ANALYSIS_CODE_1 AS �����ߴ�, dbo.Data0025.set_qty AS ������Ԫ��, dbo.Data0025.SAMPLE_NR AS ���Գ��ͱ�ע,

CASE data0025.ttype WHEN 0 THEN '����' WHEN 1 THEN '����' END AS ��Ʒ����, dbo.Data0025.LAYERS AS ����,dbo.Data0008.PRODUCT_NAME AS ��Ʒ����,

dbo.Data0010.CUST_CODE AS �ͻ�����, dbo.Data0010.ABBR_NAME AS �ͻ����, 
dbo.Data0097.PO_NUMBER AS �ͻ�������, dbo.Data0060.ORIG_CUSTOMER AS ����ԭ�ͻ�, 
                       
       dbo.Data0060.ENT_DATE AS �µ�����, 
      dbo.Data0060.ORIG_SCHED_SHIP_DATE AS �ƻ�����,
      dbo.Data0060.SCH_DATE AS �ظ�����, 
      dbo.Data0060.CONF_DATE AS ȷ������,

     case DATA0060.STATUS when 1 then '��Ч' when 2 then '�ݻ�' when 3 then '�ر�' 
     when 4 then '�����' when 6 then 'δ�ύ' end as ����״̬, 
     data0060.so_oldnew  as �����¾�,                  
     case data0060.QUOTE_PRICE when 0 then 'δ����' when 1 then '������'
     when 2 then '���˻�' when 3 then '������' end as ������,
     case data0060.so_tp when 0 then '����' when 1 then '�ⷢ' when 2 then '���Ƴ�' end as �ӹ���ʽ,
    case  data0060.PROD_REL when 1 then 'δȷ��' when 2 then '��ȷ��' when 3 then '��Ͷ��' end as �������,

     dbo.Data0005.EMPLOYEE_NAME as ������Ա, data0005_1.EMPLOYEE_NAME AS ҵ��Ա, data0005_2.EMPLOYEE_NAME AS ȷ����Ա,

   data0060.PARTS_ORDERED as ����,data0060.PARTS_ORDERED*data0025.unit_sq as ���,
  round(data0060.PARTS_ALLOC*(1+data0060.RUSH_CHARGE*0.01),4) as ��˰�۸�,data0060.RUSH_CHARGE as ˰��,
  round(data0060.PARTS_ORDERED*data0060.PARTS_ALLOC*(1+data0060.RUSH_CHARGE*0.01),2) as ��˰���,
    case when data0060.tax_in_price='Y' then Data0060.TOTAL_ADD_L_PRICE
   else Data0060.TOTAL_ADD_L_PRICE*(1+data0060.RUSH_CHARGE*0.01) end  as ���߷���,
  data0001.curr_name as ����,

   dbo.Data0060.REFERENCE_NUMBER AS �����ο�,

   data0060.ISSUED_QTY as Ͷ������,data0060.PARTS_SHIPPED as �ͻ�����,data0060.PARTS_RETURNED as �˻�����,data0060.RETURNED_SHIP as �˻��ٳ�������,
   data0060.PARTS_ORDERED-data0060.PARTS_SHIPPED+data0060.PARTS_RETURNED-data0060.RETURNED_SHIP as Ƿ������
   
FROM	dbo.Data0060 INNER JOIN
        dbo.Data0097 ON dbo.Data0060.PURCHASE_ORDER_PTR = dbo.Data0097.RKEY INNER JOIN
        dbo.Data0025 ON dbo.Data0060.CUST_PART_PTR = dbo.Data0025.RKEY INNER JOIN
        dbo.Data0010 ON dbo.Data0060.CUSTOMER_PTR = dbo.Data0010.RKEY INNER JOIN
        dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY INNER JOIN
        dbo.Data0015 ON dbo.Data0060.SHIP_REG_TAX_ID = dbo.Data0015.RKEY INNER JOIN
        dbo.Data0005 ON dbo.Data0060.ENTERED_BY_EMPL_PTR = dbo.Data0005.RKEY INNER JOIN
        dbo.Data0005 AS data0005_1 ON dbo.Data0060.COMM_ASSIGNED_BY_E_P = data0005_1.RKEY LEFT OUTER JOIN
        dbo.Data0005 AS data0005_2 ON dbo.Data0060.CONF_BY_EMPL_PTR = data0005_2.RKEY inner join data0001
        on data0060.CURRENCY_PTR=data0001.rkey
) a
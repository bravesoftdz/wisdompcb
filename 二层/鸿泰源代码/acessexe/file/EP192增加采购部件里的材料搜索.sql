--EP192���Ӳɹ�������Ĳ�������
SELECT
  Data0017.RKEY ,
  Data0017.group_ptr ,
  Data0017.INV_PART_NUMBER ,
  Data0017.INV_PART_DESCRIPTION ,
  Data0017.std_cost,
  Data0002.unit_code
FROM  Data0017,data0002
WHERE  Data0017.P_M = 'P' --�ǲɹ������Լ�����(P/M)(�ݲ�������)
and data0017.stock_unit_ptr=data0002.rkey
ORDER BY  INV_PART_NUMBER
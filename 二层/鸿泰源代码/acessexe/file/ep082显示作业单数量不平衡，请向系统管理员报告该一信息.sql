 --ep082��ʾ��ҵ��������ƽ�⣬����ϵͳ����Ա�����һ��Ϣ
 if Adoquery1.fieldbyname('prod_status').asinteger=3 then
  if ADOQuery2.FieldByName('quan_sch').AsCurrency-ADOQuery2.FieldByName('QUAN_REJ').AsCurrency-ADOQuery2.FieldByName('quan_prod').AsCurrency<>  ADOQuery2.FieldByName('wip_qty').AsCurrency then
  begin
    Messagedlg(adoquery1.fieldbyname('work_order_number').asstring+'��ҵ��������ƽ�⣬����ϵͳ����Ա�����һ��Ϣ��',mtinformation,[mbOk],0);
    exit;
  end;

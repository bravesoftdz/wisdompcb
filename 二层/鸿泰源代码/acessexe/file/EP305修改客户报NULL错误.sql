EP305�޸Ŀͻ���NULL����
�ǿ��в��ܸ���Ϊ Null��.

1��60�����EXCH_RATE,CURRENCY_PTR ���±���һ�»���
2\װ�˵�ַ


 with dm.ADOQryTmp do //ȡ���»��һ���  20121129 LLL ���Ŀͻ���ͬʱ���»���
      begin
        if active = True then
          active := False;
        sql.Clear;
        sql.text:='select isnull(data0003.exch_rate,0) as exch_rate,fyear,fmonth '
          +'from data0003 '
          +'where data0003.curr_ptr=' + trim(form10.Label9.Caption)
          +' and fyear= '+inttostr(yearof(dm.ADO60.FieldByName('ent_date').Value))   //         �µ����ڵ��»���
          +' and fmonth='+inttostr(monthof(dm.ADO60.FieldByName('ent_date').Value));  //         �µ����ڵ��»���
        active := True;
       end;
         dm.ADO60.FieldByName('exch_rate').Value:=dm.ADOQryTmp.FieldByName('exch_rate').Value;  //20121129 LLL ���Ŀͻ���ͬʱ���»���

2850615974(������) 2014-03-21 11:49:28
  dm.ADO60.FieldByName('customer_ptr').AsInteger := strtoint('0' +
          trim(form10.Edit6.Hint));�ͻ�
        dm.ADO60.FieldByName('cust_ship_addr_ptr').AsInteger := strtoint('0' +
          trim(form10.Edit7.Hint));װ�˵ص�
        dm.ADO60.FieldByName('CURRENCY_PTR').AsInteger :=strtoint('0' +
          trim(form10.Label9.Caption)); //�»���ָ��
          
          Form10.Label9.Caption :=DM.ADO60.fieldbyname('currency_ptr').AsString;
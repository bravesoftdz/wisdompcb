unit HeBingGongDan;

interface
uses
  DM;



function CombinLot(AChildRKey06: string): Boolean;
//function ExtractBurnNO(AWONumber: string; AWtype: Integer): string;

implementation
uses
  Classes, Dialogs, SysUtils, ADODB, WZ_gUnit, StrUtils;

function CombinLot(AChildRKey06: string): Boolean;
var
  LS: TStringList;
  LQry: TADOQuery;
  nEffect, Child56NowPcs, Child56NowPnl, ChildToStockPcs, ChildToStockPnl, Child06BFPcs, ChildJiHuaPNL: Integer;
  ChildJiHuaPCS: Double;
  //tmp,tmp2: Integer;
  Mother06Rkey, Child25RKey: string;
  lqry410Mother,Lqry410Child: TADOQuery;
  //LBurnNO: string;
  LSql: string;
  label lbl;
begin
//  Child56NowPcs := 0;
//  Child56NowPnl := 0;
//  ChildToStockPcs := 0;
//  ChildToStockPnl := 0;
//  ChildJiHuaPCS := 0;
  Result := False;
  //����ӹ������ڴ�������������ֹ�˻ء�
  LSql := 'select TO_BE_STOCKED,TO_BE_CANCD from data0056 where wo_ptr = ' + AChildRKey06;
  dm1.SqlOpen(LSql,DM1.qrytmp);
  if (DM1.qrytmp.FieldByName('TO_BE_STOCKED').AsInteger > 0) or (DM1.qrytmp.FieldByName('TO_BE_CANCD').AsInteger > 0) then
  begin
    ShowMessage('�ӹ������ڴ������������ֹ�˻ز���');
    Exit;
  end;


  

  LS := TStringList.Create;
  try
    //ĸ���Ƿ���ڣ�״̬�Ƿ�һ��
    LS.Clear;
    LS.Add(' SELECT D06Mother.*, D06Child.put_type AS ChildOldStatus, D06Child.Quan_SCH AS ChildJiHuaPCS, D06Child.QUAN_REJ AS ChildBFPcs,');
    LS.Add(' D06Child.BOM_PTR AS Child25RKey,');
    //����
    LS.Add(' D56Child.DEPT_PTR AS ChildNowDeptPtr, D56Mother.DEPT_PTR AS MotherNowDeptPtr,');
    //56��������
    LS.Add(' D56Child.QTY_BACKLOG AS ChildNowPcs, D56Child.PANELS AS ChildNowPnl, D56Mother.RKey AS MotherRkey56,');
    //56 child ���������
    LS.Add(' D56Child.TO_BE_STOCKED AS ChildToStockPcs, D56Child.TO_BE_CANCD AS ChildToStockPnl ');
    LS.Add(' FROM Data0006 D06Mother ');
    //����
    LS.Add(' INNER JOIN Data0006 D06Child ON D06Child.from_wo_ptr = D06Mother.RKey');
    LS.Add(' Left JOIN Data0056 D56Child ON D06Child.RKey = D56child.WO_PTR');
    LS.Add(' Left JOIN Data0056 D56Mother On D56Mother.WO_PTR = D06Mother.Rkey');
    //����
    LS.Add(' WHERE D06Child.Rkey = ' + AChildRKey06);
    if DM1.SqlOpen(LS,DM1.qrytmp) then
    begin
      if DM1.qrytmp.IsEmpty then //ĸ�������ڣ����Լ�����ĸ��
      begin
        lbl:
        if not DM1.con1.InTransaction then DM1.con1.BeginTrans;
        //�˻ص�ʱ���ӡ���ݲ��ı�
//        LQry := TADOQuery.Create(nil);
//        try
//          LS.Clear;
//          LS.Add('SELECT WORK_ORDER_NUMBER, put_type from Data0006 WHERE RKey =' + AChildRKey06);
//          if DM1.SqlOpen(LS,LQry) then
//          begin
//            LBurnNO := ExtractBurnNO(LQry.FieldByName('WORK_ORDER_NUMBER').AsString,LQry.FieldbyName('put_type').AsInteger);
//          end else
//          begin
//            ShowMessage('���»�ȡ��ӡ����ʧ��ʱ��ȡ�ù�����ʧ��');
//            Exit;
//          end;
//        finally
//          LQry.Free;
//        end;

        LS.Clear;
        LS.Add('UPDATE Data0006 SET WTYPE = ISNULL(1,0) WHERE RKey = ' + AChildRKey06);
        if DM1.SqlExec(LS,nEffect) then
        begin
          if nEffect > 0 then
          begin
            Result := True;
          end else
          begin
            ShowMessage('�����ӵ�06Ϊĸ��ʱ�򷵻�0�У��˻�ʧ��');
            Result := False
          end;
        end else
          Result := False;
          
        //д�ӹ�����־  
        if Result then
        begin
          LS.Clear;
          LS.Add('INSERT INTO Data0117 VALUES(');
          LS.Add(AChildRKey06 + ',2,0,' + gUser.User_Ptr + ',getdate(),15,');
          LS.Add(QuotedStr('LOT_MRB�����˻�,��ĸ����:' + DM1.qrytmp.FieldByName('WORK_ORDER_NUMBER').AsString + ' �޷��ϲ�.'));
          ls.Add(')');
          if DM1.SqlExec(LS,DM1.qrytmp,nEffect) then
          begin
            Result := nEffect >= 1;
            if not Result then
              ShowMessage('д�ӹ�������־ʧ��');
          end else
          begin
            Result := False;
            ShowMessage('д�ӹ�������־ʧ��');
          end;
        end;
        if Result then DM1.con1.CommitTrans else DM1.con1.RollbackTrans;
        Exit;
      end else
      begin
        //���ĸ����״̬
        if DM1.qrytmp.FieldByName('Prod_Status').AsInteger in [9,102,103] then
        begin
          //sShowMessage('ĸ����״̬�����˻�ʧ��');
          goto lbl;
          Exit;
        end;
        if DM1.qrytmp.FieldByName('Prod_Status').AsInteger = 202 then //ĸ�����Ѿ����ϲ�����ʱ����
        begin
          goto lbl;
          Exit;
        end;        

        if DM1.qrytmp.FieldByName('WType').AsInteger <> DM1.qrytmp.FieldByName('ChildOldStatus').AsInteger then
        begin
          //ShowMessage('ĸ�������ӹ���ԭʼ��WTYPE״̬��һ�£��˻�ʧ��');
          goto lbl;
          Exit;
        end;
        //��鹤��һ��
        if DM1.qrytmp.FieldByName('ChildNowDeptPtr').AsInteger <> DM1.qrytmp.FieldByName('MotherNowDeptPtr').AsInteger then
        begin
          //�������һ�������Լ�����һ�������ĵ���
          goto lbl;
          Exit;
        end;
        //����Ƿ��б��ϣ�����б����򲻿����˻�
        if DM1.qrytmp.FieldByName('ChildBFPcs').AsInteger > 0 then
        begin
          //ShowMessage('�ӵ��б��ϼ�¼���������˻أ��˻�ʧ��');
          goto lbl;
          Exit;
        end;
      end;
    end else Exit;

    Mother06Rkey := DM1.qrytmp.fieldbyname('RKey').AsString;
    Child56NowPcs := DM1.qrytmp.Fieldbyname('ChildNowPcs').AsInteger;
    Child56NowPnl := DM1.qrytmp.Fieldbyname('ChildNowPnl').AsInteger;
    ChildToStockPcs := DM1.qrytmp.Fieldbyname('ChildToStockPcs').AsInteger;
    ChildToStockPnl := DM1.qrytmp.Fieldbyname('ChildToStockPnl').AsInteger;
    ChildJiHuaPCS := DM1.qrytmp.FieldByName('ChildJiHuaPCS').AsFloat;
    Child06BFPcs := DM1.qrytmp.FieldByName('ChildBFPcs').AsInteger;
    Child25RKey :=  DM1.qrytmp.FieldByName('Child25RKey').AsString;
    ChildJiHuaPNL := DM1.qrytmp.FieldByName('PANELS').AsInteger;
    
    DM1.con1.BeginTrans;
    //����ĸ��������56��¼�е�����
    LS.Clear;
    LS.Add(' UPDATE Data0056 SET QTY_BACKLOG = QTY_BACKLOG + ' + IntToStr(Child56NowPcs) + ',');
    LS.Add(' PANELS = PANELS + ' + IntToStr(Child56NowPnl) + ',');
    LS.Add(' TO_BE_STOCKED = TO_BE_STOCKED + ' + IntToStr(ChildToStockPcs) + ',');
    LS.Add(' TO_BE_CANCD = TO_BE_CANCD + ' + IntToStr(ChildToStockPnl));
    LS.Add(' WHERE RKey = ' + DM1.qrytmp.fieldbyname('MotherRkey56').AsString);
    if DM1.SqlExec(LS,DM1.qrytmp,nEffect) then
    begin
      //
    end else
    begin
      ShowMessage('����ĸ�����߼�¼�����˻�ʧ��');
      Exit;
    end;
    //����ĸ��06������
    LS.Clear;
    LS.Add(' UPDATE Data0006 SET QUAN_SCH = QUAN_SCH + ' + IntToStr(Child56NowPcs) + ',');
    LS.Add(' PANELS = PANELS + ' + IntToStr(Child56NowPnl));
    //LS.Add(' REMARK_PNLS = REMARK_PNLS ' + IntToStr(Child56NowPnl) + ','); ��Ϊ���ʱ��û�м���������ʱ����
    LS.Add(' WHERE RKey = ' + Mother06Rkey);
    if DM1.SqlExec(LS,DM1.qrytmp, nEffect) then
    begin
      if nEffect <= 0 then
      begin
        ShowMessage('����ĸ��06����ʱ����0�У��˻�ʧ��');
        Exit;
      end;
    end else
    begin
      ShowMessage('����ĸ��06����ʱ������˻�ʧ��');
      Exit;
    end;

    //����ĸ��0489�İ��Ʒ�����¼
    //�Ȳ��child �İ��Ʒ��ת��¼
    LQry := TADOQuery.Create(nil);
    try
      LS.Clear;
      LS.Add(' SELECT RKey,Qty,SOURCE_PTR,BOM_PTR FROM Data0489 WHERE WO_PTR = ' + AChildRKey06);
      if DM1.SqlOpen(LS,LQry) then
      begin
        LQry.First;
        while not LQry.Eof do
        begin
          //������ϼ�¼Ϊ0��ȫ
          if Child06BFPcs <= 0 then
          begin
            LS.Clear;
            LS.Add('UPDATE Data0489 SET Qty = Qty + ' + LQry.Fieldbyname('Qty').AsString);
            LS.Add(' WHERE SOURCE_PTR = ' + LQry.FieldByName('SOURCE_PTR').AsString);
            LS.Add(' AND WO_PTR = ' + Mother06Rkey);
            LS.Add(' AND BOM_PTR = ' + LQry.fieldbyname('BOM_PTR').AsString);
            if not DM1.SqlExec(LS,DM1.qrytmp,nEffect) then
            begin
              ShowMessage('����ĸ�����Ʒ�������������˻�ʧ��');
              Exit;
            end;
            //ɾ��Child ��489�ļ�¼
            LS.Clear;
            LS.Add(' DELETE FROM Data0489 ');
            LS.Add(' WHERE RKey = ' + LQry.fieldbyname('RKey').AsString);
            if not DM1.SqlExec(LS,DM1.qrytmp,nEffect) then
            begin
              ShowMessage('ɾ���ӵ����Ʒ�����¼�����˻�ʧ��');
              Exit;
            end;            
          end else
          begin
            {
            LS.Clear;
            tmp := Round((Child56NowPcs/(Child56NowPcs + Child06BFPcs))* LQry.FieldByName('Qty').AsInteger);//ͨ���ٷֱ����������İ��Ʒ��
            LS.Add('UPDATE Data0489 SET Qty = Qty + ' + IntToStr(tmp) );
            LS.Add(' WHERE SOURCE_PTR = ' + LQry.FieldByName('SOURCE_PTR').AsString);
            LS.Add(' AND WO_PTR = ' + Mother06Rkey);
            if not DM1.SqlExec(LS,DM1.qrytmp,nEffect) then
            begin
              ShowMessage('����ĸ�����Ʒ�������������˻�ʧ��');
              Exit;
            end;
            //����Child ��489��qty����
            LS.Clear;
            LS.Add('UPDATE Data0489 SET Qty = Qty - ' + IntToStr(tmp) );
            LS.Add(' WHERE RKey = ' + LQry.fieldbyname('RKey').AsString);
            if not DM1.SqlExec(LS,DM1.qrytmp,nEffect) then
            begin
              ShowMessage('�����ӵ����Ʒ�������������˻�ʧ��');
              Exit;
            end;
            }
            ShowMessage('�б��ϼ�¼�����˻ء��˻�ʧ��');
          end;

          LQry.Next;
        end;
      end else
      begin
        ShowMessage('ȡ�÷�����ӹ���ʱ�����');
        Exit;
      end;
    finally
      LQry.Free;
    end;


    //����Mother�е�488����������Child��488������
    LQry := TADOQuery.Create(nil);
    try
      LS.Clear;
      LS.Add(' SELECT RKey,BOM_PTR,Quan_Req,Quan_ISSUED FROM Data0488 WHERE WO_PTR = ' + AChildRKey06);
      if DM1.SqlOpen(LS,LQry) then
      begin
        LQry.First;
        while not LQry.Eof do
        begin
          //���child�ı���Ϊ0��
          if Child06BFPcs <= 0 then
          begin
            LS.Clear;
            LS.Add('UPDATE Data0488 SET Quan_Req = Quan_Req + ' + LQry.fieldbyname('Quan_Req').AsString + ',');
            LS.Add(' Quan_ISSUED = Quan_ISSUED + ' + LQry.fieldbyname('Quan_ISSUED').AsString);
            LS.Add(' WHERE WO_PTR = ' + Mother06Rkey);
            LS.Add(' AND BOM_PTR = ' + LQry.FieldByName('BOM_PTr').AsString);
            if not DM1.SqlExec(LS,DM1.qrytmp,nEffect) then
            begin
              ShowMessage('����ĸ��488����ʱ������˻�ʧ��');
              Exit;
            end;
            //ɾ���ӵ���488��¼
            LS.Clear;
            LS.Add(' DELETE FROM Data0488 WHERE RKey = ' + LQry.FieldByName('RKey').AsString);
            if not DM1.SqlExec(LS,DM1.qrytmp,nEffect) then
            begin
              ShowMessage('ɾ���ӵ�488��¼ʱ������˻�ʧ��');
              Exit;
            end;
          end else
          begin
            ShowMessage('�б��ϼ�¼�����˻أ��˻�ʧ��');
            Exit;
          end;
          LQry.Next;
        end;
      end else
      begin
        ShowMessage('ȡ���ӹ���488��¼ʱ������˻�ʧ��');
        Exit;
      end;
    finally
      LQry.Free;
    end;

    //����ĸ����48����������¼
    LQry := TADOQuery.Create(nil);
    try
      LS.Clear;
      LS.Add('UPDATE Data0048 SET WO_PTR = ' + Mother06Rkey);
      //LS.Add(' PANELS = PANELS + ' + IntToStr(ChildJiHuaPNL));
      LS.Add(' WHERE WO_PTR = ' + AChildRKey06);
      //LS.Add(' AND TO_DEPT_PTR IS not NULL');
      if DM1.SqlExec(LS,LQry,nEffect) then
      begin
        
      end else
      begin
        ShowMessage('����ĸ��48������¼ʧ�ܣ��˻�ʧ��');
        Exit;
      end;
    finally
      LQry.Free;
    end;

    //�ϲ�410�ļ�¼��ɾ���ӵ���410
    lqry410Mother := TADOQuery.Create(nil);
    Lqry410Child := TADOQuery.Create(nil);
    try
      if not DM1.SqlOpen('select * from data0410 where WO_PTR = ' + Mother06Rkey,lqry410Mother) then
      begin
        ShowMessage('ȡ��ĸ��410����');
        Exit;
      end;
      if not DM1.SqlOpen('select * from data0410 where WO_PTR = ' + AChildRKey06,Lqry410Child) then
      begin
        ShowMessage('ȡ���ӵ�410����');
        Exit;
      end;
      try
      lqry410Mother.First;
      while not lqry410Mother.Eof do
      begin
        Lqry410Child.First;
        while not Lqry410Child.Eof do
        begin
          if (lqry410Mother.FieldByName('D0451_PTR').Value = Lqry410Child.FieldByName('D0451_PTR').Value) and
            (lqry410Mother.FieldByName('STEP').Value = Lqry410Child.FieldByName('STEP').Value) and
            (lqry410Mother.FieldByName('DEPT_PTR').Value = Lqry410Child.FieldByName('DEPT_PTR').Value)
          then
          begin
            lqry410Mother.Edit;
            lqry410Mother.FieldByName('QTY').AsInteger := lqry410Mother.FieldByName('QTY').AsInteger + Lqry410Child.FieldByName('QTY').AsInteger;
            lqry410Mother.FieldByName('MATL_AMOUNT').AsFloat := lqry410Mother.FieldByName('MATL_AMOUNT').AsFloat + Lqry410Child.FieldByName('MATL_AMOUNT').AsFloat;
            lqry410Mother.FieldByName('ovhd1_AMOUNT').AsFloat := lqry410Mother.FieldByName('ovhd1_AMOUNT').AsFloat + Lqry410Child.FieldByName('ovhd1_AMOUNT').AsFloat;
            lqry410Mother.FieldByName('ovhd2_AMOUNT').AsFloat := lqry410Mother.FieldByName('ovhd2_AMOUNT').AsFloat + Lqry410Child.FieldByName('ovhd2_AMOUNT').AsFloat;
            lqry410Mother.FieldByName('ovhd3_AMOUNT').AsFloat := lqry410Mother.FieldByName('ovhd3_AMOUNT').AsFloat + Lqry410Child.FieldByName('ovhd3_AMOUNT').AsFloat;
            lqry410Mother.Post;
            Lqry410Child.Delete;
          end;
          Lqry410Child.Next;
        end;
        lqry410Mother.Next;
      end;
      except
        ShowMessage('�ϲ�410��¼ʱ�����');
        Exit;
      end;

    finally
      lqry410Mother.Free;
      Lqry410Child.Free;
    end;

    //ɾ���ӵ���48��¼
//    LS.Clear;
//    LS.Add('DELETE FROM Data0048 WHERE WO_PTR = ' + AChildRKey06);
//    if not DM1.SqlExec(LS,DM1.qrytmp,nEffect) then
//    begin
//      ShowMessage('ɾ���ӵ�������¼ʧ�ܣ��˻�ʧ��');
//      Exit;
//    end;

    //�����ӹ�����06״̬������
    LS.Clear;
    LS.Add('UPDATE Data0006 SET QUAN_SCH = 0,PANELS = 0,PROD_STATUS = 202,WTYPE= ISNULL(put_type,1) ');
    LS.Add(' WHERE RKey = ' + AChildRKey06);
    if not DM1.SqlExec(LS,DM1.qrytmp,nEffect) then
    begin
      ShowMessage('�����ӵ�06��¼״̬ʧ�ܣ��˻�ʧ��');
      Exit;
    end;

    //ɾ���ӹ�����238��¼
    LS.Clear;
    LS.Add('DELETE FROM Data0238 WHERE WO_PTR = ' + AChildRKey06);
    if not DM1.SqlExec(LS,DM1.qrytmp,nEffect) then
    begin
      ShowMessage('ɾ���ӹ�������238����ʧ��');
      Exit;
    end;

    //ɾ��ɾ���ӵ�������56��¼
    LS.Clear;
    LS.Add('DELETE FROM Data0056 WHERE WO_PTR = ' + AChildRKey06);
    if not DM1.SqlExec(LS,DM1.qrytmp,nEffect) then
    begin
      ShowMessage('ɾ���ӵ����߼�¼ʧ�ܣ��˻�ʧ��');
      Exit;
    end;

    //д�ӹ�����־
    LS.Clear;
    LS.Add('INSERT INTO Data0117 VALUES(');
    LS.Add(AChildRKey06 + ',2,0,' + gUser.User_Ptr + ',getdate(),15,');
    LS.Add('NULL');
    ls.Add(')');
    if DM1.SqlExec(LS,DM1.qrytmp,nEffect) then
    begin
      Result := nEffect >= 1;
      if not Result then
        ShowMessage('д�ӹ�������־ʧ��');
    end else
    begin
      Result := False;
      ShowMessage('д�ӹ�������־ʧ��');
    end;

    //дĸ������־
    LS.Clear;
    LS.Add('INSERT INTO Data0117 VALUES(');
    LS.Add(Mother06Rkey + ',2,0,' + gUser.User_Ptr + ',getdate(),15,');
    LS.Add(QuotedStr('LOT_MRB�����˻�,�����ϲ��ӹ���:' + DM1.adsFrmMain.fieldbyname('WORK_ORDER_NUMBER').AsString));
    ls.Add(')');
    if DM1.SqlExec(LS,DM1.qrytmp,nEffect) then
    begin
      Result := nEffect >= 1;
      if not Result then
        ShowMessage('дĸ��������־ʧ��');
    end else
    begin
      Result := False;
      ShowMessage('дĸ��������־ʧ��');
    end;

    DM1.con1.CommitTrans;
    Result := True;
  finally
    LS.Free;
    if DM1.con1.InTransaction then DM1.con1.RollbackTrans;
  end;
end;



end.

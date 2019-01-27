unit PrintUnit;

interface
uses
  Windows, MainFrm, DM;



  //ͨ�ô�ӡ
  procedure Common_Print(ACustomType: TCustomType);
  //���˿�Ѷ
  procedure Print_2303(ACustomType: TCustomType;ACustCode: string);
  //��̩
  procedure Print_WT(ACustomType: TCustomType);
  //��ݸ��˶
  procedure Print_DGHS(ACustomType: TCustomType);
  //��ݸ����
  procedure Print_DGDell(ACustomType: TCustomType);
  //��Ϊ�ն�
  procedure Print_HWZD(ACustomType: TCustomType);



  function ExtractTimeWithZQ(AZQ: string;AYearWeek: Boolean = True): TDateTime;

var
  gPrintName: string;
implementation

uses
  SysUtils, Classes, ppCtrls, DateUtils, WZ_gUnit,
  StrUtils, Dialogs, ExtCtrls;


function StrInArr(Str: string; Arr: array of string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := Low(Arr) to High(Arr) do
    if Str = Arr[I] then Result := True;
end;

function ExtractTimeWithZQ(AZQ: string;AYearWeek: Boolean = True): TDateTime;
var
  tmpWeek: Integer;
  Y: string;

begin
  if AYearWeek then
  begin
    Y := '20'+ Copy(AZQ,1,2) + '-01-01';
    tmpWeek := StrToInt(Copy(AZQ,3,2));
    Result := StartOfAWeek(YearOf(gStrToDateTime(Y)),tmpWeek);
    Result := IncDay(Result,-1);//������Ϊ��ʼ
  end else
  begin
    Y := '20'+ Copy(AZQ,3,2) + '-01-01';
    tmpWeek := StrToInt(Copy(AZQ,1,2));
    Result := StartOfAWeek(YearOf(gStrToDateTime(Y)),tmpWeek);
    Result := IncDay(Result,-1);//������Ϊ��ʼ    
  end;
end;



procedure BeginPrint(AReportFile: string);
begin
  DM1.ppPrint.Reset;
  DM1.ppPrint.Template.FileName := AReportFile;
  DM1.ppPrint.Template.LoadFromFile;
  DM1.ppPrint.OnPrintingComplete := DM1.ppPrintPrintingComplete;
  DM1.pdbReportNext(DM1.pdbReport);

  DM1.ppPrint.ShowPrintDialog := False;
  DM1.ppPrint.DeviceType := 'Printer';
  DM1.ppPrint.PrinterSetup.PrinterName := gPrintName;
  DM1.ppPrint.Print;
end;

procedure FreeReportFile(RCName, DesFileName: string);
begin
  with TResourceStream.Create(HInstance,RCName ,RT_RCDATA) do
  begin
    try
      SaveToFile(DesFileName);
    finally
      Free;
    end;
  end;
end;

function GetReportFileName(ACustTtype: TCustomType): string;
var
  LReg: string;
  LIO: string;
  LRCName: string;
begin
  //ȡ������
  if dm1.GetServerRegion = '����' then LReg := 'SZ' else
  if dm1.GetServerRegion = '÷��' then LReg := 'MZ' else
  if dm1.GetServerRegion = '��ݸ' then LReg := 'DG';

  //������
  if DM1.adsFrmMain.FieldByName('type').AsString = '����' then LIO := 'I' else LIO := 'O';

  case ACustTtype of
    ctHW,ctCDHW,ctHWAJX: Result := '1806';
    ctHWZD: Result := '1915';
    ctMRMT: Result := '2104';
    //ctSAMSUNG: Result := '1850';
    //ctGreatWall: Result := '1202';
    ctCLS: Result := '1901';
    ctZXKX: Result := '2303';
    ctUnknow: Result := '';
    ctHS: Result := '2258';
    ctDH: Result := '2390';
    ctDYH: Result := 'DYH_';
    ctWT: Result := 'WT_';
    ctHQ: Result := 'HQ_';
    ctTCL: Result := 'TCL_';
    ctJCKJ: Result := 'JCKJ_';
    ctBCKJ: Result := 'S2763_';
    ctYYD: Result := 'YYD_';
    ctDGHS: Result := 'HS7325_';
    ctDGDELL: Result := 'Dell_';
    ctSSJ: Result := 'SSJ_'
  end;
  if Result = '' then Exit;
  LRCName := LReg + Result + LIO;
  Result := LReg + Result + LIO + '.rtm';
  Result := ExtractFilePath(ParamStr(0)) + 'Report\WZPR0698\' + Result;
  if not frmMain.cbx1.Checked then
  FreeReportFile(LRCName, Result);
end;


procedure Common_Print(ACustomType: TCustomType);
var
  LSql: string;
begin
  DM1.adsReport.Close;
  DM1.adsReport.Parameters[0].Value := DM1.adsFrmMain.FieldByName('RKey').Value;
  DM1.adsReport.Open;

  DM1.cdsReport.Data := DM1.dspReport.Data;


  LSql := 'select CUSTOMER_NAME from data0025 d25 inner join data0010 d10 on d10.abbr_name = d25.ORIG_CUSTOMER ' +
          ' where d25.manu_part_number = ' + QuotedStr(DM1.adsReport.fieldbyname('�������').AsString);
  DM1.SqlOpen(LSql);
  if not DM1.qrytmp.IsEmpty then
  begin
    DM1.cdsReport.First;
    while not DM1.cdsReport.Eof do
    begin
      DM1.cdsReport.Edit;
      DM1.cdsReport.FieldByName('�ͻ�����').Value := DM1.qrytmp.fieldbyname('CUSTOMER_NAME').Value;
      DM1.cdsReport.Post;
      DM1.cdsReport.Next;
    end;
  end;  

  DM1.ppPrint.DataPipeline := DM1.pdbReport;
  BeginPrint(GetReportFileName(ACustomType));
end;

procedure Print_2303(ACustomType: TCustomType; ACustCode: string);
var
  ZXlblNum,ZXBZtime,ZXSCTime,ZXHKTime: Tpplabel;
  //ZXNoROSH: TppLine;
  //ImgStream: TMemoryStream;
  ZXROHS,ZXNoPB,ZXHSF,Img2DBar: TppImage;
  I,J: Integer;
  LSql: string;
  LYearWeek: Boolean;
  ltmpstr: string;
  LText: string;
  LtmpIni: integer;
begin
  ZXlblNum := nil;
  DM1.adsReport.Close;
  DM1.adsReport.Parameters[0].Value := DM1.adsFrmMain.FieldByName('RKey').Value;
  DM1.adsReport.Open;

  LYearWeek := not DM1.adsReport.FieldByName('flag698').AsBoolean;

  DM1.cdsReport.Data := DM1.dspReport.Data;

  LSql := 'select CUSTOMER_NAME from data0025 d25 inner join data0010 d10 on d10.abbr_name = d25.ORIG_CUSTOMER ' +
          ' where d25.manu_part_number = ' + QuotedStr(DM1.adsReport.fieldbyname('�������').AsString);
  DM1.SqlOpen(LSql);
  if not DM1.qrytmp.IsEmpty then
  begin
    DM1.cdsReport.First;
    while not DM1.cdsReport.Eof do
    begin
      DM1.cdsReport.Edit;
      DM1.cdsReport.FieldByName('�ͻ�����').Value := DM1.qrytmp.fieldbyname('CUSTOMER_NAME').Value;
      DM1.cdsReport.Post;
      DM1.cdsReport.Next;
    end;
  end;
  DM1.cdsReport.First;
  //DM1.ppPrint.DataPipeline := DM1.pdbReport;


  DM1.ppPrint.Reset;
  DM1.ppPrint.Template.FileName := GetReportFileName(ACustomType);
  DM1.ppPrint.Template.LoadFromFile;
  DM1.ppPrint.OnPrintingComplete := DM1.ppPrintPrintingComplete;


  dm1.F2303SCRQ := FormatDateTime('YYYY-MM-DD',ExtractTimeWithZQ(DM1.adsReport.fieldbyname('����').AsString,LYearWeek));

    DM1.ppPrint.ObjectByName(I,J,'ppImage1');
    Img2DBar := DM1.ppPrint.Bands[I].Objects[J] as TppImage;

    LText := DM1.pdbReport.Fields[DM1.pdbReport.FindField('������')].AsString + '&&' +
            DM1.pdbReport.Fields[DM1.pdbReport.FindField('PCS����')].AsString + '&' +
            DM1.pdbReport.Fields[DM1.pdbReport.FindField('�ͻ����Ϻ�')].AsString + '&' +
            dm1.F2303SCRQ + '&' +
            DM1.pdbReport.Fields[DM1.pdbReport.FindField('����')].AsString + '&';
    DM1.Get2DCodeBmp(LText,Img2DBar.Picture);



  if DM1.adsFrmMain.FieldByName('type').AsString = '����' then
  begin

    DM1.ppPrint.ObjectByName(I,J,'lblHKRQ');
    ZXHKTime := DM1.ppPrint.Bands[I].Objects[J] as TppLabel;

    DM1.ppPrint.ObjectByName(I,J,'lblPCS');
    //ZXlblNum := DM1.ppPrint.Bands[I].Objects[J] as TppLabel;

    DM1.ppPrint.ObjectByName(I,J,'lblBZRQ');
    ZXBZtime := DM1.ppPrint.Bands[I].Objects[J] as TppLabel;

    DM1.ppPrint.ObjectByName(I,J,'lblSCRQ');
    ZXSCTime := DM1.ppPrint.Bands[I].Objects[J] as TppLabel;
    DM1.ppPrint.ObjectByName(I,J,'img1');
    ZXROHS := DM1.ppPrint.Bands[I].Objects[J] as TppImage;
    DM1.ppPrint.ObjectByName(I,J,'img2');
    ZXNoPB := DM1.ppPrint.Bands[I].Objects[J] as TppImage;
    DM1.ppPrint.ObjectByName(I,J,'imgHSF');
    ZXHSF := DM1.ppPrint.Bands[I].Objects[J] as TppImage;

    if Pos('�����', DM1.adsReport.FieldByName('��ע698').AsString) > 0 then
    begin
      //ZXlblNum.Caption := DM1.adsReport.fieldbyname('PCS����').AsString + ' ����';
      if ZXlblNum <> nil then
      ZXlblNum.Caption := IntToStr(DM1.adsReport.fieldbyname('PCSÿSETS').Asinteger - 1)
        + 'X' + IntToStr(DM1.adsReport.fieldbyname('PCS����').AsInteger div (DM1.adsReport.fieldbyname('PCSÿSETS').AsInteger-1))
        + '=' + DM1.adsReport.fieldbyname('PCS����').AsString;
    end else
    if Pos('˫���', DM1.adsReport.FieldByName('��ע698').AsString) > 0 then
    begin
      //ZXlblNum.Caption := DM1.adsReport.fieldbyname('PCS����').AsString + ' ˫��';
      if ZXlblNum <> nil then
      ZXlblNum.Caption := IntToStr(DM1.adsReport.fieldbyname('PCSÿSETS').Asinteger - 2)
        + 'X' + IntToStr(DM1.adsReport.fieldbyname('PCS����').AsInteger div (DM1.adsReport.fieldbyname('PCSÿSETS').AsInteger-2))
        + '=' + DM1.adsReport.fieldbyname('PCS����').AsString;
    end else
      //ZXlblNum.Caption := DM1.adsReport.fieldbyname('PCS����').AsString + '';
      if ZXlblNum <> nil then
      ZXlblNum.Caption := DM1.adsReport.fieldbyname('PCSÿSETS').AsString
        + 'X' + IntToStr(DM1.adsReport.fieldbyname('PCS����').AsInteger div DM1.adsReport.fieldbyname('PCSÿSETS').AsInteger)
        + '=' + DM1.adsReport.fieldbyname('PCS����').AsString;
    if (DM1.adsReport.fieldbyname('���洦��').AsString = '����')
      or (DM1.adsReport.fieldbyname('���洦��').AsString = '����') or (DM1.adsReport.fieldbyname('���洦��').AsString = '��Ǧ����')
    then
      ZXBZtime.Caption := FormatDateTime('YYYY-MM-DD',IncMonth(ExtractTimeWithZQ(DM1.adsReport.fieldbyname('����').AsString,LYearWeek),6))
    else
    if (DM1.adsReport.fieldbyname('���洦��').AsString = '����') then
    begin
      ZXBZtime.Caption := FormatDateTime('YYYY-MM-DD',IncMonth(ExtractTimeWithZQ(DM1.adsReport.fieldbyname('����').AsString,LYearWeek),3))
    end else
    if (DM1.adsReport.fieldbyname('���洦��').AsString = 'OSP')
      or (DM1.adsReport.fieldbyname('���洦��').AsString = 'OSP+����')
    then
    begin
      ZXBZtime.Caption := FormatDateTime('YYYY-MM-DD',IncMonth(ExtractTimeWithZQ(DM1.adsReport.fieldbyname('����').AsString,LYearWeek),6));

      //�����������4617������Ϊ6����
      //������
      if StrInArr(ACustCode,['Z0257','Z1001','Z0276','2031','7053','6791']) then
      begin
        //if (StrToInt(LeftStr(DM1.adsReport.fieldbyname('����').AsString,2)) >= 44) and (StrToInt(RightStr(DM1.adsReport.fieldbyname('����').AsString,2)) >= 17) then
        begin
          ZXBZtime.Caption := FormatDateTime('YYYY-MM-DD',IncMonth(ExtractTimeWithZQ(DM1.adsReport.fieldbyname('����').AsString,LYearWeek),6));
        end;
      end;
      //------2017-11-1
    end;



    ZXSCTime.Caption := FormatDateTime('YYYY-MM-DD',ExtractTimeWithZQ(DM1.adsReport.fieldbyname('����').AsString,LYearWeek));
    DM1.F2303SCRQ := ZXSCTime.Caption;
    if DM1.adsReport.fieldbyname('���洦��').AsString = '����' then
    begin
      ZXROHS.Visible := True;
      ZXNoPB.Visible := False;
      ZXHSF.Visible := False;
    end
    else
    begin
      ZXROHS.Visible := False;
      ZXNoPB.Visible := True;
      ZXHSF.Visible := False;
    end;
    if Trim(DM1.adsFrmMain.FieldByName('CURRENT_REV').AsString) = 'Y' then
    begin
      ZXHSF.Visible := True;
      ZXROHS.Visible := False;
      ZXNoPB.Visible := False;
    end else
    begin

    end;
    if Pos('@', DM1.adsReport.FieldByName('��ע698').AsString) > 0 then
    begin
      ZXHKTime.Caption := Copy(DM1.adsReport.FieldByName('��ע698').AsString,Pos('@', DM1.adsReport.FieldByName('��ע698').AsString)+1,10);
      if StrInArr(ACustCode,['2303']) then
        LtmpIni := 6
      else
        LtmpIni := 3;

      if (DM1.adsReport.fieldbyname('���洦��').AsString = '����') or (DM1.adsReport.fieldbyname('���洦��').AsString = '��Ǧ����')
        or (DM1.adsReport.fieldbyname('���洦��').AsString = '����')
      then
         ZXBZtime.Caption := FormatDateTime('YYYY-MM-DD',IncMonth(gStrToDate(ZXHKTime.Caption),LtmpIni))
      else
      if (DM1.adsReport.fieldbyname('���洦��').AsString = 'OSP')
        or (DM1.adsReport.fieldbyname('���洦��').AsString = '����')
        or (DM1.adsReport.fieldbyname('���洦��').AsString = 'OSP+����')
      then
      begin
        ZXBZtime.Caption := FormatDateTime('YYYY-MM-DD',IncMonth(gStrToDate(ZXHKTime.Caption),LtmpIni));
        //�����������4617������Ϊ6����
        //������
        if StrInArr(ACustCode,['Z0257','Z1001','Z0276','2031','7053','6791']) then
        begin
          //if (StrToInt(LeftStr(DM1.adsReport.fieldbyname('����').AsString,2)) >= 44) and (StrToInt(RightStr(DM1.adsReport.fieldbyname('����').AsString,2)) >= 17) then
          begin
            ZXBZtime.Caption := FormatDateTime('YYYY-MM-DD',IncMonth(gStrToDate(ZXHKTime.Caption),LtmpIni));
          end;
        end;
        //------2017-11-1
      end;
    end;
  end else
  if DM1.adsFrmMain.FieldByName('type').AsString = '����' then
  begin
    DM1.ppPrint.ObjectByName(I,J,'lblSCRQ');
    ZXSCTime := DM1.ppPrint.Bands[I].Objects[J] as TppLabel;
    DM1.ppPrint.ObjectByName(I,J,'lblHKRQ');
    ZXHKTime := DM1.ppPrint.Bands[I].Objects[J] as TppLabel;
      
    DM1.ppPrint.ObjectByName(I,J,'lblBZRQ');
    ZXBZtime := DM1.ppPrint.Bands[I].Objects[J] as TppLabel;
    DM1.ppPrint.ObjectByName(I,J,'img1');
    ZXROHS := DM1.ppPrint.Bands[I].Objects[J] as TppImage;
    DM1.ppPrint.ObjectByName(I,J,'img2');
    ZXNoPB := DM1.ppPrint.Bands[I].Objects[J] as TppImage;
    DM1.ppPrint.ObjectByName(I,J,'imgHSF');
    ZXHSF := DM1.ppPrint.Bands[I].Objects[J] as TppImage;
    if (DM1.adsReport.fieldbyname('���洦��').AsString = '����') or (DM1.adsReport.fieldbyname('���洦��').AsString = '��Ǧ����')
      or (DM1.adsReport.fieldbyname('���洦��').AsString = '����')
    then
       ZXBZtime.Caption := FormatDateTime('YYYY-MM-DD',IncMonth(ExtractTimeWithZQ(DM1.adsReport.fieldbyname('����').AsString,LYearWeek),6))
    else
    if (DM1.adsReport.fieldbyname('���洦��').AsString = '����') then
    begin
      ZXBZtime.Caption := FormatDateTime('YYYY-MM-DD',IncMonth(ExtractTimeWithZQ(DM1.adsReport.fieldbyname('����').AsString,LYearWeek),3))
    end else
    if (DM1.adsReport.fieldbyname('���洦��').AsString = 'OSP')
      or (DM1.adsReport.fieldbyname('���洦��').AsString = 'OSP+����')
    then
    begin
      ZXBZtime.Caption := FormatDateTime('YYYY-MM-DD',IncMonth(ExtractTimeWithZQ(DM1.adsReport.fieldbyname('����').AsString,LYearWeek),6));

        //�����������4617������Ϊ6����
        //������
        if StrInArr(ACustCode,['Z0257','Z1001','Z0276','2031','7053','6791']) then
        begin
        //if (StrToInt(LeftStr(DM1.adsReport.fieldbyname('����').AsString,2)) >= 44) and (StrToInt(RightStr(DM1.adsReport.fieldbyname('����').AsString,2)) >= 17) then
        begin
          ZXBZtime.Caption := FormatDateTime('YYYY-MM-DD',IncMonth(ExtractTimeWithZQ(DM1.adsReport.fieldbyname('����').AsString,LYearWeek),6));
        end;
        end;
        //------2017-11-1
    end;
    ZXSCTime.Caption := FormatDateTime('YYYY-MM-DD',ExtractTimeWithZQ(DM1.adsReport.fieldbyname('����').AsString,LYearWeek));
    DM1.F2303SCRQ := ZXSCTime.Caption;
    if DM1.adsReport.fieldbyname('���洦��').AsString = '����' then
    begin
      ZXROHS.Visible := True;
      ZXNoPB.Visible := False;
      ZXHSF.Visible := False;
    end
    else
    begin
      ZXROHS.Visible := False;
      ZXNoPB.Visible := True;
      ZXHSF.Visible := False;
    end;


    if Trim(DM1.adsFrmMain.FieldByName('CURRENT_REV').AsString) = 'Y' then
    begin
      ZXHSF.Visible := True;
      ZXROHS.Visible := False;
      ZXNoPB.Visible := False;
    end else
    begin

    end;
    if Pos('@', DM1.adsReport.FieldByName('��ע698').AsString) > 0 then
    begin
      ZXHKTime.Caption := Copy(DM1.adsReport.FieldByName('��ע698').AsString,Pos('@', DM1.adsReport.FieldByName('��ע698').AsString)+1,10);
      if StrInArr(ACustCode,['2303']) then
        LtmpIni := 6
      else
        LtmpIni := 3;
      if (DM1.adsReport.fieldbyname('���洦��').AsString = '����')  or (DM1.adsReport.fieldbyname('���洦��').AsString = '��Ǧ����')
        or (DM1.adsReport.fieldbyname('���洦��').AsString = '����')
      then
         ZXBZtime.Caption := FormatDateTime('YYYY-MM-DD',IncMonth(gStrToDate(ZXHKTime.Caption),LtmpIni))
      else
      if (DM1.adsReport.fieldbyname('���洦��').AsString = 'OSP')
        or (DM1.adsReport.fieldbyname('���洦��').AsString = 'OSP+����')
        or (DM1.adsReport.fieldbyname('���洦��').AsString = '����')
      then
      begin
        ZXBZtime.Caption := FormatDateTime('YYYY-MM-DD',IncMonth(gStrToDate(ZXHKTime.Caption),LtmpIni));
        ShowMessage(ZXHKTime.Caption);

        //�����������4617������Ϊ6����Z0257/Z1001/Z0276
        //������
        if StrInArr(ACustCode,['Z0257','Z1001','Z0276','2031','7053','6791']) then
        begin
          //if (StrToInt(LeftStr(DM1.adsReport.fieldbyname('����').AsString,2)) >= 44) and (StrToInt(RightStr(DM1.adsReport.fieldbyname('����').AsString,2)) >= 17) then
          begin
            ZXBZtime.Caption := FormatDateTime('YYYY-MM-DD',IncMonth(gStrToDate(ZXHKTime.Caption),LtmpIni));
          end;
        end;
        //------2017-11-1
      end;

    end;
  end;
  DM1.ppPrint.ShowPrintDialog := False;

  DM1.ppPrint.DeviceType := 'Printer';
  DM1.ppPrint.PrinterSetup.PrinterName := gPrintName;
  DM1.ppPrint.Print;

end;


procedure Print_DGHS(ACustomType: TCustomType);
var
  Img2DBar: TppImage;
  I,J: Integer;
  LSql: string;
  LText: string;

begin
  DM1.adsReport.Close;
  DM1.adsReport.Parameters[0].Value := DM1.adsFrmMain.FieldByName('RKey').Value;
  DM1.adsReport.Open;
  //DM1.ppPrint.DataPipeline := DM1.pdbReport;

  DM1.cdsReport.Data := DM1.dspReport.Data;

  DM1.SqlOpen('select getdate() as nowtime');
  

  LSql := 'select CUSTOMER_NAME from data0025 d25 inner join data0010 d10 on d10.abbr_name = d25.ORIG_CUSTOMER ' +
          ' where d25.manu_part_number = ' + QuotedStr(DM1.adsReport.fieldbyname('�������').AsString);
  DM1.SqlOpen(LSql);
  if not DM1.qrytmp.IsEmpty then
  begin
    DM1.cdsReport.First;
    while not DM1.cdsReport.Eof do
    begin
      DM1.cdsReport.Edit;
      DM1.cdsReport.FieldByName('�ͻ�����').Value := DM1.qrytmp.fieldbyname('CUSTOMER_NAME').Value;
      DM1.cdsReport.FieldByName('���Ӳ���1').Value :=  'R' + DM1.adsReport.fieldbyname('�͹�����').AsString +
        DM1.cdsReport.fieldbyname('���Ӳ���1').AsString ;
      DM1.cdsReport.Post;
      DM1.cdsReport.Next;
    end;
  end;

  DM1.ppPrint.Reset;
  DM1.ppPrint.Template.FileName := GetReportFileName(ACustomType);
  DM1.ppPrint.Template.LoadFromFile;
  DM1.ppPrint.OnPrintingComplete := DM1.ppPrintPrintingComplete;

  if DM1.adsFrmMain.FieldByName('type').AsString = '����' then
  begin
    DM1.ppPrint.ObjectByName(I,J,'ppImage1');
    Img2DBar := DM1.ppPrint.Bands[I].Objects[J] as TppImage;
    LText :=  Copy(DM1.adsReport.fieldbyname('ANALYSIS_CODE_2').AsString,1,Pos('+',DM1.adsReport.fieldbyname('ANALYSIS_CODE_2').AsString)-1) + ';';
    LText := LText + 'MWUZHU;';
    LText := LText + 'V' + DM1.adsReport.fieldbyname('�͹�����').AsString + ';';
    LText := LText + 'D' + DM1.adsReport.fieldbyname('����').AsString + ';';
    LText := LText + 'L' + DM1.adsReport.fieldbyname('CUT_NO_HEAD').AsString + ';';
    LText := LText + 'R' + DM1.adsReport.fieldbyname('���Ӳ���1').AsString ;
    DM1.Get2DCodeBmp(LText,Img2DBar.Picture);
  end;
  DM1.ppPrint.ShowPrintDialog := False;
  DM1.ppPrint.DeviceType := 'Printer';
  DM1.ppPrint.PrinterSetup.PrinterName := gPrintName;
  DM1.ppPrint.Print;
end;

procedure Print_WT(ACustomType: TCustomType);
var
  Img2DBar: TppImage;
  I,J: Integer;
  LSql: string;
  LText: string;
begin
  DM1.adsReport.Close;
  DM1.adsReport.Parameters[0].Value := DM1.adsFrmMain.FieldByName('RKey').Value;
  DM1.adsReport.Open;

  DM1.cdsReport.Data := DM1.dspReport.Data;

  LSql := 'select CUSTOMER_NAME from data0025 d25 inner join data0010 d10 on d10.abbr_name = d25.ORIG_CUSTOMER ' +
          ' where d25.manu_part_number = ' + QuotedStr(DM1.adsReport.fieldbyname('�������').AsString);
  DM1.SqlOpen(LSql);
  if not DM1.qrytmp.IsEmpty then
  begin
    DM1.cdsReport.First;
    while not DM1.cdsReport.Eof do
    begin
      DM1.cdsReport.Edit;
      DM1.cdsReport.FieldByName('�ͻ�����').Value := DM1.qrytmp.fieldbyname('CUSTOMER_NAME').Value;
      DM1.cdsReport.Post;
      DM1.cdsReport.Next;
    end;
  end;  

  DM1.ppPrint.Reset;
  DM1.ppPrint.Template.FileName := GetReportFileName(ACustomType);
  DM1.ppPrint.Template.LoadFromFile;
  DM1.ppPrint.OnPrintingComplete := DM1.ppPrintPrintingComplete;


  DM1.ppPrint.ObjectByName(I,J,'ppImage1');
  Img2DBar := DM1.ppPrint.Bands[I].Objects[J] as TppImage;

  LText := DM1.adsReport.fieldbyname('�ͻ����Ϻ�').AsString + '|' +
                  DM1.adsReport.fieldbyname('PCS����').AsString + '|' +
                  DM1.adsReport.fieldbyname('�ͻ��ͺ�').AsString + '|' +
                  DM1.adsReport.fieldbyname('����').AsString + '|' +
                  DM1.adsReport.fieldbyname('���洦��').AsString + '|' +
                  Trim(DM1.adsReport.fieldbyname('�ͻ�������').AsString) + '|' +
                  'Wuzhu';

  DM1.Get2DCodeBmp(LText,Img2DBar.Picture);
  DM1.ppPrint.ShowPrintDialog := False;
  DM1.ppPrint.DeviceType := 'Printer';
  DM1.ppPrint.PrinterSetup.PrinterName := gPrintName;
  DM1.ppPrint.Print;
end;

procedure Print_HWZD(ACustomType: TCustomType);
var
  Img2DBar,Img2DBar_2: TppImage;
  I,J: Integer;
  LSql: string;
  LText: string;
begin
  DM1.adsReport.Close;
  DM1.adsReport.Parameters[0].Value := DM1.adsFrmMain.FieldByName('RKey').Value;
  DM1.adsReport.Open;

  DM1.cdsReport.Data := DM1.dspReport.Data;

  LSql := 'select CUSTOMER_NAME from data0025 d25 inner join data0010 d10 on d10.abbr_name = d25.ORIG_CUSTOMER ' +
          ' where d25.manu_part_number = ' + QuotedStr(DM1.adsReport.fieldbyname('�������').AsString);
  DM1.SqlOpen(LSql);
  if not DM1.qrytmp.IsEmpty then
  begin
    DM1.cdsReport.First;
    while not DM1.cdsReport.Eof do
    begin
      DM1.cdsReport.Edit;
      DM1.cdsReport.FieldByName('�ͻ�����').Value := DM1.qrytmp.fieldbyname('CUSTOMER_NAME').Value;
      DM1.cdsReport.Post;
      DM1.cdsReport.Next;
    end;
  end;  

  DM1.ppPrint.Reset;
  DM1.ppPrint.Template.FileName := GetReportFileName(ACustomType);
  DM1.ppPrint.Template.LoadFromFile;
  DM1.ppPrint.OnPrintingComplete := DM1.ppPrintPrintingComplete;
  DM1.adsReport.First;

  DM1.ppPrint.ObjectByName(I,J,'ppImage1');
  Img2DBar := DM1.ppPrint.Bands[I].Objects[J] as TppImage;

//  LText := 'P' + DM1.adsReport.fieldbyname('�ͻ��ͺ�').AsString + ' ' +
//           '1P' + DM1.adsReport.fieldbyname('�������').AsString + ' ' +
//           'Q' + DM1.adsReport.fieldbyname('PCS����').AsString + ' ' +
//           'V' + DM1.adsReport.fieldbyname('�͹�����').AsString + ' ' +
//           '1T' + DM1.adsReport.fieldbyname('���').AsString + ' ' +
//           '9D' + DM1.adsReport.fieldbyname('����').AsString + ' ' +
//           'MWuZhu' + ' ' +
//           '4LChina' + ' ' +
//           //'1D' + DM1.adsReport.fieldbyname('����').AsString + ' ' +
//           //'1Q' + DM1.adsReport.fieldbyname('PCS����').AsString + ' ' +
//           'K' + DM1.adsReport.fieldbyname('�ͻ�������').AsString;

  LText := '[)>' + Char(30) + '06' + //' ' +
            'P' + DM1.adsReport.fieldbyname('�ͻ��ͺ�').AsString + //' ' +
           '1P' + DM1.adsReport.fieldbyname('�������').AsString + //' ' +
           'Q' + DM1.adsReport.fieldbyname('PCS����').AsString + //' ' +
           'V' + DM1.adsReport.fieldbyname('�͹�����').AsString + //' ' +
           '1T' + DM1.adsReport.fieldbyname('���').AsString + //' ' +
           '9D' + DM1.adsReport.fieldbyname('����').AsString + //' ' +
           '25B'+DM1.adsReport.fieldbyname('xBrode').AsString + //' ' +
           'PSN'+ DM1.adsReport.fieldbyname('Psn').AsString + //' ' +
           'MWuZhu' + //' ' +
           '4LChina'; //+ ' ';
           //'1D' + DM1.adsReport.fieldbyname('����').AsString + ' ' +
           //'1Q' + DM1.adsReport.fieldbyname('PCS����').AsString + ' ' +
//           'K' + DM1.adsReport.fieldbyname('�ͻ�������').AsString;



  DM1.Get2DCodeBmp(LText,Img2DBar.Picture);

  if (DM1.adsFrmMain.FieldByName('type').AsString = '����') then
  begin
    DM1.ppPrint.ObjectByName(I,J,'ppImage2');
    Img2DBar_2 := DM1.ppPrint.Bands[I].Objects[J] as TppImage;
    LText :=  '1D' + DM1.adsReport.fieldbyname('����').AsString + ' ' +
              '1Q' + DM1.adsReport.fieldbyname('PCS����').AsString;
    DM1.Get2DCodeBmp(LText,Img2DBar_2.Picture,2);
  end;

  DM1.ppPrint.ShowPrintDialog := False;
  DM1.ppPrint.DeviceType := 'Printer';
  DM1.ppPrint.PrinterSetup.PrinterName := gPrintName;
  DM1.ppPrint.Print;


end;

procedure Print_DGDell(ACustomType: TCustomType);
var
  Img2DBar: TppImage;
  I,J: Integer;
  LSql: string;
  LText: string;
begin
  DM1.adsReport.Close;
  DM1.adsReport.Parameters[0].Value := DM1.adsFrmMain.FieldByName('RKey').Value;
  DM1.adsReport.Open;

  DM1.cdsReport.Data := DM1.dspReport.Data;

  LSql := 'select CUSTOMER_NAME from data0025 d25 inner join data0010 d10 on d10.abbr_name = d25.ORIG_CUSTOMER ' +
          ' where d25.manu_part_number = ' + QuotedStr(DM1.adsReport.fieldbyname('�������').AsString);
  DM1.SqlOpen(LSql);
  if not DM1.qrytmp.IsEmpty then
  begin
    DM1.cdsReport.First;
    while not DM1.cdsReport.Eof do
    begin
      DM1.cdsReport.Edit;
      DM1.cdsReport.FieldByName('�ͻ�����').Value := DM1.qrytmp.fieldbyname('CUSTOMER_NAME').Value;
      DM1.cdsReport.Post;
      DM1.cdsReport.Next;
    end;
  end;  

  DM1.ppPrint.Reset;
  DM1.ppPrint.Template.FileName := GetReportFileName(ACustomType);
  DM1.ppPrint.Template.LoadFromFile;
  DM1.ppPrint.OnPrintingComplete := DM1.ppPrintPrintingComplete;
  DM1.adsReport.First;

  DM1.ppPrint.ObjectByName(I,J,'ppImage1');
  Img2DBar := DM1.ppPrint.Bands[I].Objects[J] as TppImage;

  LText := 'P' + DM1.adsReport.fieldbyname('�ͻ����Ϻ�').AsString + ',' +
           'Q' + DM1.adsReport.fieldbyname('PCS����').AsString + ',' +
           'M' + DM1.adsReport.fieldbyname('M�������_2').AsString + ',' +
           'D' + DM1.adsReport.fieldbyname('����').AsString + ',' +
           'L' + DM1.adsReport.fieldbyname('���洦��').AsString + ',' +
           'S' + dm1.pdbReport.Fields[DM1.pdbReport.FindField('������')].AsString;
  DM1.Get2DCodeBmp(LText,Img2DBar.Picture);
  DM1.ppPrint.ShowPrintDialog := False;
  DM1.ppPrint.DeviceType := 'Printer';
  DM1.ppPrint.PrinterSetup.PrinterName := gPrintName;  
  DM1.ppPrint.Print;
end;

end.

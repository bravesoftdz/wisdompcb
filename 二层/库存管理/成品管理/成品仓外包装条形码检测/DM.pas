unit DM;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TBarInfo = record
    GongYingShangCode: string;//��Ӧ�̴���
    HWCode: string;//��Ϊ���
    Ver: string;//�汾
    Qty: Integer;//����
    LotNum: string;//��������
    VPO: string;//������
    BarCode: string;//������
    MANU_PART_NUMBER: string;//�������
    Param1: string;//����1
    addinfo: string;
  end;

  TBarType = (btHW,btHWZD,btUnKnow);


  Tdm1 = class(TDataModule)
    con1: TADOConnection;
    qry1: TADOQuery;
  private
    { Private declarations }
    function FillBarInfo: TBarInfo;
    function FillBarUnFind(ABar: string): TBarInfo;    
  public
    { Public declarations }
    function GetBarInfo(ABar: String): TBarInfo;
    function GetBarType(ABar: string): TBarType;
    function OpenQry(AStr: string): Boolean;
    function SqlOpen(ALQry: TADOQuery; ASql: string): Boolean;overload;
    function SqlOpen(ACon: TADOConnection;AQry: TADOQuery; ASql: string): Boolean;overload;
    //function Open699: Boolean;
  end;

var
  dm1: Tdm1;

implementation

uses
  Dialogs,Variants;

{$R *.dfm}

{ Tdm1 }

function Tdm1.GetBarInfo(ABar: String): TBarInfo;
var
  s1,s2: string;
  k1,k2: Integer;
  s,tmpS: string;
begin
  case GetBarType(ABar) of
    btHW:
    begin
      s1 := Copy(ABar,1,Pos('-',ABar)-1);
      s2 := Copy(ABar,Pos('-',ABar)+1,Length(ABar)-Pos('-',ABar)+1);
      k1 := StrToIntDef(s1,0);
      k2 := StrToIntDef(s2,0);
      if OpenQry('SELECT * FROM Data0699 WHERE pack_ptr=' + IntToStr(k1) + ' AND order_no=' + IntToStr(k2)) then
        Result := FillBarInfo
      else
      begin
        ShowMessage('û�в��ҵ�������ݣ�' + ABar);
        Result := FillBarUnFind(ABar);
      end;
    end;
    btHWZD:
    begin
      if OpenQry('SELECT * FROM Data0699 WHERE barcode_id=' + QuotedStr(ABar) + ' ORDER BY PO_NUMBER ') then
      begin
        qry1.First;
        while not qry1.Eof do
        begin
          if tmpS <> qry1.Fieldbyname('PO_NUMBER').AsString then
          begin
            s := s + qry1.Fieldbyname('PO_NUMBER').AsString + ';';
            tmpS := qry1.Fieldbyname('PO_NUMBER').AsString;
          end;
          qry1.Next;
        end;
        Result := FillBarInfo;
        if s <> '' then Result.VPO := s;
      end else
      begin
        ShowMessage('û�в��ҵ�������ݣ�' + ABar);
        Result := FillBarUnFind(ABar);
      end;
    end;
    btUnKnow:
    begin
      ShowMessage('ֻ֧�ֻ�Ϊ�ͻ�Ϊ�ն˵�����  ' + ABar);
      Result := FillBarUnFind(ABar);
    end;
  end;
end;


function Tdm1.GetBarType(ABar: string): TBarType;
var
  n: Integer;
  i: Integer;
begin
  Result := btUnKnow;
  n := 0;
  for I := 1 to Length(ABar) do if ABar[I] = '-' then Inc(n);
  case n of
    1:
    begin
      if (Pos('-',ABar) <> 1) and (Pos('-',ABar) <> Length(ABar)) then
        Result := btHW;
    end;
    5:
    begin
      Result := btHWZD;
    end;
  else
    Result := btUnKnow;
  end;
end;

function Tdm1.FillBarInfo: TBarInfo;
begin
  with Result do
  begin
    MANU_PART_NUMBER := qry1.FieldByName('MANU_PART_NUMBER').AsString;
    GongYingShangCode := qry1.FieldByName('code').AsString;
    HWCode := qry1.FieldByName('MANU_PART_DESC').AsString;
    Ver := qry1.FieldByName('ANALYSIS_CODE_2').AsString[Length(qry1.FieldByName('ANALYSIS_CODE_2').AsString)];
    Qty := qry1.FieldByName('qty').AsInteger;
    LotNum := qry1.FieldByName('lotno').AsString;
    VPO := qry1.FieldByName('PO_NUMBER').AsString;
    BarCode := qry1.FieldByName('barcode_id').AsString;
    Param1 := qry1.FieldByName('Param1').AsString;
  end;


end;


function Tdm1.FillBarUnFind(ABar: string): TBarInfo;
begin
  with Result do
  begin
    MANU_PART_NUMBER := 'δ֪';
    GongYingShangCode := ABar;
    HWCode := 'δ֪';
    Ver := 'δ֪';
    Qty := 0;
    LotNum := 'δ֪';
    VPO := 'δ֪';
    BarCode := 'δ֪';
  end;
end;

function Tdm1.OpenQry(AStr: string): Boolean;
begin
  Result := False;
  try
    qry1.Close;
    qry1.SQL.Clear;
    qry1.SQL.Add(AStr);
    qry1.Open;
  except
    on e: Exception do
    begin
      ShowMessage(e.Message);
      Exit;
    end;
  end;
  Result := True;
end;

function Tdm1.SqlOpen(ALQry: TADOQuery; ASql: string): Boolean;
begin
  ALQry.Close;
  ALQry.Connection := con1;
  ALQry.SQL.Clear;
  ALQry.SQL.Add(ASql);
  try
    ALQry.Open;
    Result := True;
  except
    Result := False;
    ShowMessage(ASql);
  end;
end;

function Tdm1.SqlOpen(ACon: TADOConnection; AQry: TADOQuery;
  ASql: string): Boolean;
begin
  if not ACon.Connected then ACon.Open;

  AQry.Close;
  AQry.Connection := ACOn;
  AQry.SQL.Clear;
  AQry.SQL.Add(ASql);
  try
    AQry.Open;
    Result := True;
  except
    Result := False;
    ShowMessage(ASql);
  end;

end;

end.



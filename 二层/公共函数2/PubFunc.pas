unit PubFunc;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  VCLCom, StdVcl,DB,Provider,variants,winsock,Midas,ComConst,
  StdCtrls,ComObj,ConstDeclare,DBClient,ZLib,Math;


  procedure ShowMsg(Info,title:string;Btn_type:byte);overload;//������Ϣ��,btn_type:����,1��������Ŧ��2��2����Ŧ
  procedure ShowMsg(Info:string;Btn_type:byte);overload;//������Ϣ��,btn_type:����,1��������Ŧ��2��2����Ŧ
  function Msg_Dlg_Ask(Info,title:string;btn_type:byte):boolean;//������Ϣ��.�ṩyes,noѡ��
  function Pick_Date(inDate:TDAtetime): TDatetime;//ѡ������
  function DeQuotedStr(S:string):string;//��QuotedStr����
  function Get_Month_First_Day(fdate:tDate):TDate;//���ص���1��
  function Get_Month_Last_Day(fdate:tDate):TDate;//���ص������һ��
  function Get_Year_First_Day(fdate:tDate):TDate;//�������1��
  function Get_Year_Last_Day(fdate:tDate):TDate;//����������һ��

  procedure PackStream(var CompressedStream: TMemoryStream);
  procedure UnPackStream(var CompressedStream: TMemoryStream);
  function OleVariant_To_MemoryStream(OV: OleVariant): TMemoryStream;
  function Stream_To_OleVariant(Stream: TMemoryStream): OleVariant;
  function Compress_Data(var vData:oleVariant):boolean;//ѹ������
  function DeCompress_Data(var vData:oleVariant):boolean;//��ѹ������
  function IsDatetime(str:string):boolean;
  function Get_Filter_Of_Fixed_Int(D:Double):integer;
{  function Pick_Cust_ID(Value:variant;AdoConn:TAdoconnection;PickType:byte):variant;//ѡ��ͻ�
  function Pick_Prod_Type(Value:variant;AdoConn:TAdoconnection;PickType:byte):variant;//ѡ���Ʒ����
  function Pick_Sales_Man(Value:variant;AdoConn:TAdoconnection;PickType:byte):variant;//ѡ��ҵ��Ա
  function Pick_Sales_Director(Value:variant;AdoConn:TAdoconnection;PickType:byte):variant;//ѡ��ҵ������

  function Pick_Date(inDate:TDAtetime): TDatetime;//ѡ������

  function Get_Pick_Value(PickItemId:integer;Value:variant;AdoConn:TAdoconnection;PickType:byte):String;//������ѡ��ĿID�����жԻ�����ѡ
}


implementation
uses Pick_Item,DatePick;


procedure ShowMsg(Info,title:string;Btn_type:byte);overload;
begin
  case Btn_Type of
    1:  Application.MessageBox(Pchar(Info),Pchar(title),mb_ok);
    2:  Application.MessageBox(Pchar(Info),Pchar(title),MB_OKCANCEL);
  end;
end;

procedure ShowMsg(Info:string;Btn_type:byte);overload;//������Ϣ��,btn_type:����,1��������Ŧ��2��2����Ŧ
begin
  case Btn_Type of
    1:  Application.MessageBox(Pchar(Info),'��ʾ',mb_ok);
    2:  Application.MessageBox(Pchar(Info),'��ʾ',MB_OKCANCEL);
  end;
end;

function Msg_Dlg_Ask(Info,title:string;btn_type:byte):boolean;//������Ϣ��.�ṩyes,noѡ��
begin
  case Btn_Type of
    1:  result := Application.MessageBox(Pchar(Info),Pchar(title),mb_okCancel)=IdOK;
    2:  result := Application.MessageBox(Pchar(Info),Pchar(title),MB_YESNOCANCEL)=IDYes;
    else result := false;
  end;
end;

function Pick_Date(inDate:TDAtetime): TDatetime;//ѡ������
begin
  with TfrmDatePick.Create(Application) do
  try
    InitForm(inDate);
    if Showmodal = mrok then
      result := GetDate
    else
      result := 0;
  finally
    free;
  end;
end;

function DeQuotedStr(S:string):string;//��QuotedStr����
var
  I :integer;
begin
  for I := 1 to Length(S) do
  begin
    if S[i]='''' then
    begin
      Delete(s,i,1);
      break;
    end;
  end;
  for I := Length(S) downto 1 do
  begin
    if S[i]='''' then
    begin
      Delete(s,i,1);
      break;
    end;
  end;

  Result := S;
end;

function Get_Month_First_Day(fdate:tDate):TDate;//���ص���1��
var
  Y,M,D:Word;
begin
  DecodeDate(fdate,y,m,d);
  result := EnCodeDate(y,m,1);
end;

function Get_Month_Last_Day(fdate:tDate):TDate;//���ص������һ��
var
  Y,M,D:Word;
begin
  DecodeDate(fdate,y,m,d);
  if m=12 then
    result := EnCodedate(y+1,1,1)-1
  else
    result := EnCodeDate(y,m+1,1)-1;
end;

function Get_Year_First_Day(fdate:tDate):TDate;//�������1��
var
  Y,M,D:Word;
begin
  DecodeDate(fdate,y,m,d);
  result := EnCodedate(y,1,1);
end;

function Get_Year_Last_Day(fdate:tDate):TDate;//����������һ��
var
  Y,M,D:Word;
begin
  DecodeDate(fdate,y,m,d);
  result := EnCodedate(y+1,1,1)-1
end;


procedure PackStream(var CompressedStream: TMemoryStream);
var
  SourceStream: TCompressionStream;
  DestStream: TMemoryStream;
  Count: Integer;
Begin
  Count := CompressedStream.Size;
  DestStream := TMemoryStream.Create;
  SourceStream:=TCompressionStream.Create(clDefault, DestStream);
  Try
    CompressedStream.SaveToStream(SourceStream);
    SourceStream.Free;
    CompressedStream.Clear;
    CompressedStream.WriteBuffer(#6#3#1, 3);    //631 ��ѹ�����
    CompressedStream.WriteBuffer(Count, SizeOf(Count));
    CompressedStream.CopyFrom(DestStream, 0);
  finally
    DestStream.Free;
  end;
end;

procedure UnPackStream(var CompressedStream: TMemoryStream);
var
  SourceStream: TDecompressionStream;
  DestStream: TMemoryStream;
  Buffer: PChar;
  Count: integer;
  tmpstr:string;
Begin
  CompressedStream.Position:=0;
  tmpstr:='DDD';
  CompressedStream.ReadBuffer(tmpstr[1], 3);
  if tmpstr<>#6#3#1 then exit; //�ж��Ƿ�ѹ������
  CompressedStream.ReadBuffer(Count, SizeOf(Count));
  GetMem(Buffer, Count);
  DestStream := TMemoryStream.Create;
  SourceStream := TDecompressionStream.Create(CompressedStream);
  Try
    SourceStream.ReadBuffer(Buffer^, Count);
    DestStream.WriteBuffer(Buffer^, Count);
    SourceStream.Free;
    DestStream.Position := 0;//��λ��ָ��
    CompressedStream.LoadFromStream(DestStream);
  finally
    FreeMem(Buffer);
    DestStream.Free;
  end;
end;

function OleVariant_To_MemoryStream(OV: OleVariant): TMemoryStream;
var
  Data: PByteArray;
  Size: integer;
begin
  Result := TMemoryStream.Create;
  try
      Size := VarArrayHighBound (OV, 1) - VarArrayLowBound(OV, 1) + 1;
      Data := VarArrayLock(OV);
      try
       Result.Position := 0;
       Result.WriteBuffer(Data^, Size);
      finally
       VarArrayUnlock(OV);
      end;
  except
      Result.Free;
      Result := nil;
  end;
end;

function Stream_To_OleVariant(Stream: TMemoryStream): OleVariant;
var
  Data: PByteArray;
begin
  Result := VarArrayCreate([0, Stream.Size - 1], varByte);
  Data := VarArrayLock(Result);
  try
    Stream.Position := 0;
    Stream.ReadBuffer(Data^, Stream.Size);
  finally
    VarArrayUnlock(Result);
  end;
end;

function Compress_Data(var vData:oleVariant):boolean;//ѹ������
var
  InStream:TMemoryStream;
begin
  InStream:=TMemoryStream.Create;
  try
    InStream:= OleVariant_To_MemoryStream(vData);
    try
      PackStream(InStream);
      vData:= Stream_To_OleVariant(InStream);
      result := true;
    except
      result := false;
    end;
  finally
    InStream.free;
  end;
end;

function DeCompress_Data(var vData:oleVariant):boolean;//��ѹ������
var
  InStream:TMemoryStream;
begin
  InStream:=TMemoryStream.Create;
  try
    InStream:= OleVariant_To_MemoryStream(vData);
    try
      UnPackStream(InStream);
      vData:= Stream_To_OleVariant(InStream);
      result := true;
    except
      result := false;
    end;
  finally
    InStream.free;
  end;
end;

function IsDatetime(str:string):boolean;
begin
  result := true;
  try
    StrTodatetime(str);
  except
    result := false;
  end;
end;

function Get_Filter_Of_Fixed_Int(D:Double):integer;
var
  Int_Part:string;
  i,iLen:integer;
begin
  Int_Part:= IntToStr(trunc(Abs(d)));
{  i:=Pos('0',Int_Part);
  if i>0 then
  begin
    iLen:=Length(Int_Part)-i+1;
    result := trunc(int(d/Power(10,iLen))*Power(10,iLen)) + trunc(Power(10,iLen));
  end
  else
  begin
    iLen:=Length(Int_Part);
    result:= trunc(int(d/Power(10,iLen-1))*Power(10,iLen-1))+10;
  end;}
  iLen:=Length(Int_Part);
  result := trunc(int(d/Power(10,iLen-1))*Power(10,iLen-1))+trunc(Power(10,iLen-1));

end;

end.


unit PasPublic;

interface
     uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls,ExtCtrls,ActnList,DBGridEh,IniFiles,
  ComObj,Registry;
Type
  Time_Story  =   (ts_12,       {12 Сʱ��}
                   ts_24        {24 Сʱ��}
                  );
function GetTimeStory: Time_Story;
procedure SetTimeStory(const Story: Time_Story);
//ȡ��RKeyֵ
function GetDataRkey2(Const Tablename:String;AdoConn:TADOConnection;whereT:String=''):Integer;
function GetDataRkey(Const Tablename,FieldName,strValues:String;AdoConn:TADOConnection;whereT:String=''):Integer;
//���룬�ֶ������ֶ�ֵ��AdoConn��������Ϊ�գ����ؼ�¼����
function ResultRecordCount(Const Tablename:String;AdoConn:TADOConnection;whereT:String=''):Integer;
var
   ListDEPT,ListDEPT2: TStringList; //���б�
   dListDEPT:TList;
implementation
{ ------------------------------------------------------------------------
//
//   ���ص�ǰϵͳʱ�����ʾ��ʽ
//
//   ����ֵ :
//          Ĭ�ϵķ���Ϊ 24 Сʱ��
//
  -----------------------------------------------------------------------}
function GetTimeStory: Time_Story;
var
  Reg: TRegistry;
begin
  Result := ts_24;
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  Reg.OpenKey('\Control Panel\International', False);
  Try
    if Reg.ReadString('sTimeFormat') = 'tt h:mm:ss' then
       Result := ts_12
    else
       Result := ts_24;
  Finally;
    Reg.CloseKey;
    Reg.Free;
  end;
end;


{ ---------------------------------------------------------------------------
//
//   ��ϵͳʱ�����ʾ��ʽ����Ϊָ������
//
//   ����   :
//          Story       :       ָ������
//
  --------------------------------------------------------------------------}

procedure SetTimeStory(const Story: Time_Story);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  {���ø�����Ϊ  HKEY_CURRENT_USER}
  Reg.RootKey := HKEY_CURRENT_USER;
  {������   '\Control Panel\International'}
  Reg.OpenKey('\Control Panel\International', False);
  Try   {д������}
    Case Story of
      ts_12:    {12 Сʱ��}
        begin
          Reg.WriteString('iTime', '0');
          Reg.WriteString('iTimePrefix', '1');
          Reg.WriteString('sTimeFormat', 'tt h:mm:ss');
        end;
      ts_24:    {24 Сʱ��}
        begin
          Reg.WriteString('iTime', '1');
          Reg.WriteString('iTimePrefix', '0');
          Reg.WriteString('sTimeFormat', 'H:mm:ss');
        end;
    end;
  Finally;
    Reg.CloseKey;       {�ر�����}
    Reg.Free;
  end;
end;

//ȡ��RKeyֵ
function GetDataRkey2(Const Tablename:String;AdoConn:TADOConnection;whereT:String=''):Integer;
var tmpAdo:TADOQuery;
begin
  try
    try
      tmpAdo:=TADOQuery.Create(Application);
      tmpAdo.Connection:=AdoConn;
      tmpAdo.Close;
      tmpAdo.SQL.Clear;
      if (whereT<>'') then
        tmpAdo.SQL.Text:='select * from '+Tablename+' '+whereT+''
      else
        tmpAdo.SQL.Text:='select * from '+Tablename+'';
      tmpAdo.Open;
      if not tmpAdo.IsEmpty then
      begin
        Result:=tmpAdo.FieldBYName('Rkey').AsInteger;
      end else
        Result:=0;
    except
      Result:=0;
    end;
  finally
    tmpAdo.Close;
    tmpAdo.Connection:=nil;
    tmpAdo.Free;
    tmpAdo:=nil;
  end;
end;

//ȡ��RKeyֵ
function GetDataRkey(Const Tablename,FieldName,strValues:String;AdoConn:TADOConnection;whereT:String=''):Integer;
var tmpAdo:TADOQuery;
begin
  try
    try
      tmpAdo:=TADOQuery.Create(Application);
      tmpAdo.Connection:=AdoConn;
      tmpAdo.Close;
      tmpAdo.SQL.Clear;
      if (whereT<>'') then
        tmpAdo.SQL.Text:='select * from '+Tablename+' where '+FieldName+'='''+strValues+''' and '+whereT+''
      else
        tmpAdo.SQL.Text:='select * from '+Tablename+' where '+FieldName+'='''+strValues+'''';
      tmpAdo.Open;
      if not tmpAdo.IsEmpty then
      begin
        Result:=tmpAdo.FieldBYName('Rkey').AsInteger;
      end else
        Result:=0;
    except
      Result:=0;
    end;
  finally
    tmpAdo.Close;
    tmpAdo.Connection:=nil;
    tmpAdo.Free;
    tmpAdo:=nil;
  end;
end;

//���룬�ֶ������ֶ�ֵ��AdoConn��������Ϊ�գ����ؼ�¼����
function ResultRecordCount(Const Tablename:String;AdoConn:TADOConnection;whereT:String=''):Integer;
var tmpAdo:TADOQuery;
begin
  try
    try
      tmpAdo:=TADOQuery.Create(Application);
      tmpAdo.Connection:=AdoConn;
      tmpAdo.Close;
      tmpAdo.SQL.Clear;
      if (whereT<>'') then
      begin
         tmpAdo.SQL.Text:='select * from '+Tablename+' '+whereT+'';
      end else
      begin
          tmpAdo.SQL.Text:='select * from '+Tablename+'';
      end;
      tmpAdo.Open;
      if not tmpAdo.IsEmpty then
      begin
        Result:=tmpAdo.RecordCount;
      end else
        Result:=0;
    except
      Result:=0;
    end;
  finally
    tmpAdo.Close;
    tmpAdo.Connection:=nil;
    tmpAdo.Free;
  end;
end;

end.
 
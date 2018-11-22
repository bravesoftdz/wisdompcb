{       EastRiver Smart Function Example               }
{                                                      }
{            Author: shuguang LING                     }
{                                                      }
{               April.14.2004                          }


unit Functions;

interface

uses
  Windows, SysUtils, Forms, Controls, EastRiver,{EastriverT,} Classes,  Dialogs;

var
  StrPwd :String;
  RealFlag: Boolean=False;

  function CheckHandle(hPort: THandle): Boolean;
  function OpenPort(pclk: PClockInfo; Style: Integer): Boolean;
  function ClosePort(pclk: PClockInfo; Style: Integer): Boolean;
  function Is880(Model: Integer): Boolean;
  function Is780(Model: Integer): Boolean;
  function MsgBox(const Text: string; Flags: Longint=MB_ICONINFORMATION): Integer;
  function MyStrToTime(StrTime: string): TDateTime;
  function TimeToMyStr(Time: TDateTime): string;
  function StrsToPeriods(const Strs: TStrings; var Periods: string): Boolean;
  function PeriodsToStrs(var Strs: TStrings; const PeriodBytes: string): Boolean;
  function SplitString(const S: string;var args: array of string;const Seperators: TSysCharSet=[#9]): Integer;
  function AryStrToString(const args: array of string; Seperator: Char=#9; MaxCol: Integer=0): string;



resourcestring
  msg_Infor = '��ʾ';
  msg_error = '����';
  msg_confirm = 'ȷ��';
  msg_Warning = '����';
  msg_connect_clock_fail = '�޷����� COM%d-%.2x';
  msg_connect_clock_fail_tcp = '�޷����� IP��ַ��%s�����ţ�%.2x ';
  msg_write_iccard_error = 'д������';
  msg_read_iccard_error = '��������'; 
  SCeEaEeA = '�����뿨��. ';
  SCeEaEeAAAUAe = '�����뿪������. ';
  msg_add_list_card_error = '��ӿ��Ŵ���';
  msg_delete_list_card_error = 'ɾ�����Ŵ���';
  msg_clear_list_card_error = '������Ŵ���';
  msg_write_iccard_pwd_error = 'дIC���������';
  msg_readalldata_time = '���ڶ�ȡ��һ������,��Լ�� %d ��.';
  msg_readall_savedata = '���ڱ���� %d/%d ����¼...';
  msg_record_xor_err = '��¼У�����, �Ƿ񱣴�? ';
  msg_readall_continue = '�Ƿ��������? ';
  msg_readall_nodata = '����û�����ݣ�';
  msg_readall_cleardata = '�����ܹ���%d����ȡ����%d�����Ƿ�Ҫ������ݣ�';
  msg_readall_comm_err = '������ͨ�Ŵ��󣬴�����룺%d';
  msg_readall_cmderr_xorerr = '�����������У����󣬴�����룺%d';
  msg_readall_cancel = '���û���ֹ�����δ��ɣ�������룺%d';
  msg_reqadall_resource_err = '����Դ������󣬴�����룺%d';
  msg_realread_caption = 'ʵʱ��';
  msg_realread_stop = 'ֹͣ';
  msg_realmonitor_caption = 'ʵʱ���';
  msg_stoprealmonitor_caption = 'ֹͣ���';
  msg_realread_nofind = 'ʵʱ��ѯû���ҵ���';
  msg_realread_readerr = 'ʵʱ��ȡ���Ŵ���';
  msg_realread_connect = 'Ҫ��������';
  msg_readall_consume = '����';
  msg_readall_charge = '����';
  msg_dataok = '���ݲɼ���ϣ������ѱ����ڵ�ǰ�ļ����¡�����ʱ %.1f ��';
  msg_datafinnook = '���ݲɼ���ϣ���¼����Ϊ %d����ֻ�ɼ� %d �������ԭ�򡣹���ʱ %.1f ��';
  msg_pwd_modiOk = '�����޸ĳɹ�';
  msg_pwd_modifail = '�����޸�ʧ��';
  msg_pwd_readclientcode_ok = '�ͻ������ȡ�ɹ�';
  msg_pwd_readclientcode_fail = '�ͻ������ȡʧ��';
  msg_pwd_setclientcode_ok = '�ͻ��������óɹ�';
  msg_pwd_setclientcode_fail = '�ͻ���������ʧ��';
  msg_inputnewid_error = '�»������벻��ȷ��';
  msg_clockid_modi_ok = '�����޸ĳɹ�';
  msg_clockid_modi_fail = '�����޸�ʧ��';
  msg_findprob_code = '���ִ��󣬴�����룺%d';
  msg_checkcard_exists = '�Ѵ��ڣ�';
  msg_checkcard_notexists = '�����ڣ�';
  
implementation

uses  MainU;

function CheckHandle(hPort: THandle): Boolean;
begin
  Result:=(hPort<>0) and (hPort<>INVALID_HANDLE_VALUE);
end;



function OpenPort(pclk: PClockInfo; Style: Integer): Boolean;
var
  SaveCursor: TCursor;
  //tddevinfo:DEVINFO;
  StrIP: AnsiString;
  PMode: array[0..34] of Char;
  function BaudToByte(Baud: Integer): Byte;
  begin
    case Baud of
       9600:Result := 5;
      19200:Result := 6;
      38400:Result := 7;
      57600:Result := 8;
     115200:Result := 9;
     else   Result := 5;
    end;
  end;
begin
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    Result:=False;
    if CheckHandle(pclk.hPort) then
    begin
      GetClockModel(pclk.hPort, pclk.Model, pclk.fireware, pclk.cls);
      Result:=True;
    end else //�����������״̬������
    begin
      case Style of
        0:pclk.hPort:=OpenCommPort(pclk.Port, pclk.BaudRate);
        1:begin
            case pclk.Vendor of
              1:begin
                  StrIP := pclk.IPAddr;
                  {
                  if ZNET_GetDeviceInformation(PChar(StrIP),@tddevinfo)=1 then
                  begin
                    tddevinfo.workmode := 1;
                    tddevinfo.workport := pclk.IPPort;
                    tddevinfo.zne100info.baud:=BaudToByte(pclk.baudrate);
                    tddevinfo.zne100info.databits:=8;
                    tddevinfo.zne100info.stopbits:=1;
                    tddevinfo.zne100info.checkbits:=3;
                    if ZNET_ModifyDevice(PChar(pclk.IPAddr),PChar(pclk.IPPwd),@tddevinfo)=1 then
                    begin
                      pclk.hPort := OpenClientSocket(PCHar(pclk.IPAddr), pclk.IPPort);
                    end;
                  end;
                  }
                   pclk.hPort := OpenClientSocket(PCHar(pclk.IPAddr), pclk.IPPort);
                end;
             else
                pclk.hPort := OpenClientSocket(PCHar(pclk.IPAddr), pclk.IPPort);
            end;
          end;
      end;
      if CheckHandle(pclk.hPort) then
      begin
        //SetCmdVerify(pclk.CmdVerify);
        SetCmdVerify(true);
        SelectCommStyle(pclk.CommStyle);
        if RealFlag then Result := True
        else begin
          Result:=CallClock(pclk.hPort, pclk.clock_id);
          if Result then
          begin
            if not GetClockModel(pclk.hPort, pclk.Model, pclk.fireware, pclk.cls) then
            begin
              SetPortParity(pclk.hPort, 4);
              GetClockModel(pclk.hPort, pclk.Model, pclk.fireware, pclk.cls);
            end;
            ReadClockMode(pclk.hPort, pclk.Mode, pclk.ExtraMode, pclk.SystemMode);
            pclk.VerOrd:=GetClockVersionOrd(pclk.hPort);
            FillChar(PMode, 35, #0);
            //ReadClockModeStr(pclk.hPort, PMode);
            //SetClockModeStr(pclk.hPort, PMode);
            //ShowMessage(PMode);
            //if (pclk.model=880) and (pclk.Fireware<=1.32) then
            if (pclk.model=690) and (pclk.Fireware=1.5) then
              pclk.Decimal:=100
            else
              pclk.Decimal:=10;
          end else
          begin
            ClosePortHandle(pclk.hPort);
            pclk.hPort := 0;
          end;
        end;
      end;
    end;
    pclk.Connected := Result;
    if not Result then
      if pclk.CommStyle=0 then
        MsgBox(format(msg_connect_clock_fail, [pclk.Port, pclk.clock_id]), MB_ICONERROR)
      else
        MsgBox(format(msg_connect_clock_fail_tcp, [pclk.IPAddr, pclk.clock_id]), MB_ICONERROR)
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

function ClosePort(pclk: PClockInfo; Style: Integer): Boolean;
begin
  Result:=False;
  if Assigned(pclk) then
  begin
    if CheckHandle(pclk.hPort) then
    begin
      UnCallClock(pclk.hPort);
      case Style of
        0:ClosePortHandle(pclk.hPort); //CloseHandle(pclk.hPort);
        1:CloseClientSocket(pclk.hPort);
      end;
      Result:=True;
    end;
    pclk.hPort:=0;
  end;
end;

function Is880(Model: Integer): Boolean;
begin
  Result:=ClockVerOrd(Model)>1;
end;

function Is780(Model: Integer): Boolean;
begin
  Result:=ClockVerOrd(Model)>2;
end;

function MsgBox(const Text: string; Flags: Longint): Integer;
var
  Caption: string;
begin
  if (Flags and MB_ICONWARNING)<>0 then
    Caption:=msg_warning
  else if (Flags and MB_ICONERROR)<>0 then
    Caption:=msg_error
  else if (Flags and MB_ICONQUESTION)<>0 then
    Caption:=msg_confirm
  else Caption:=msg_infor;
  if Assigned(Screen.ActiveForm) then
    Result:=MessageBox(Screen.ActiveForm.Handle, PChar(Text), PChar(Caption), Flags)
  else
    Result:=Application.MessageBox(PChar(Text), PChar(Caption), Flags);
end;

function MyStrToTime(StrTime: string): TDateTime;
//ʱ���ַ�����ʽ:32:45
var
  tmpStr: string;
  tmpVar: Integer;
  tmpTime: TDateTime;
  Day, Hour, Min: WORD;
begin
  Result := 0;
  try
    StrTime := Trim(StrTime);
    if Length(StrTime)=5 then
    begin
      if StrTime[3]=TimeSeparator then
      begin
        tmpStr := Copy(StrTime, 1, 2);
        tmpVar := StrToIntDef(tmpStr, 0);
        Day := tmpVar div 24;
        Hour := tmpVar mod 24;
        tmpStr := Copy(StrTime, 4, 2);
        tmpVar := StrToIntDef(tmpStr, 0);
        Min := tmpVar;
        tmpTime := EncodeTime(Hour, Min, 0, 0);
        ReplaceDate(tmpTime, Day);
        Result := tmpTime;
      end;
    end
    else if Length(StrTime)=4 then //�м���ʱ��ָ���
    begin
      tmpStr := Copy(StrTime, 1, 2);
      tmpVar := StrToIntDef(tmpStr, 0);
      Day := tmpVar div 24;
      Hour := tmpVar mod 24;
      tmpStr := Copy(StrTime, 3, 2);
      tmpVar := StrToIntDef(tmpStr, 0);
      Min := tmpVar;
      tmpTime := EncodeTime(Hour, Min, 0, 0);
      ReplaceDate(tmpTime, Day);
      Result := tmpTime;
    end;
  except
    Result := -1;
  end;
end;

function TimeToMyStr(Time: TDateTime): string;
var
  Day, Hour, Min, Sec, Msec: WORD;
  tmpStr: string;
begin
  if Time>=100/24 then
    Exit;
  if Time<0 then
    Exit;
  try
    Day := WORD(Trunc(Time));
    DecodeTime(Time, Hour, Min, Sec, MSec);
    Hour := Day*24+Hour;
    tmpStr := format('%.2u', [Hour]);
    Result := tmpStr+TimeSeparator;
    tmpStr := format('%.2u', [Min]);
    Result := Result+tmpStr;
  except
    Result := '';
  end;
end;

function StrsToPeriods(const Strs: TStrings; var Periods: string): Boolean;
var
  i, y: Integer;
  Buf: array[0..5] of Byte;
  TimeBegin, TimeEnd: TDateTime;
begin
  Result := False;
  if Assigned(Strs) then
  begin
    SetLength(Periods, 12);
    FillChar(Buf, Length(Buf), 0);
    for i := 0 to Strs.Count-1 do
    begin
      TimeBegin := MyStrToTime(Copy(Strs[i], 1, 5));
      TimeEnd := MyStrToTime(Copy(Strs[i], 6, 5));
      if (TimeEnd>0)and(TimeEnd>TimeBegin) then
        for y := Round(TimeBegin*48)to Round(TimeEnd*48)-1 do
        begin
          Buf[y div 8] := ((Buf[y div 8])or(1 shl(y mod 8)));
        end;
    end;
    for i := 0 to 5 do
    begin
      StrMove(@Periods[i*2+1], PChar(IntToHex(Buf[i], 2)), 2);
    end;
    Result := True;
  end;
end;

function PeriodsToStrs(var Strs: TStrings; const PeriodBytes: string): Boolean;
var
  i, head, tail: Integer;
  TimeBegin, TimeEnd: TDateTime;
  Buf: array[0..6] of Byte;
begin
  Result := False;
  tail := -1;
  if Assigned(Strs) then
  begin
    Strs.Clear;
    HexToBin(PChar(PeriodBytes), @Buf, Length(PeriodBytes));
    Buf[6] := 0;
    for i := 0 to 48 do
    begin
      if ((Buf[i div 8])and(1 shl(i mod 8)))=0 then
      begin
        head := tail+1;
        tail := i;
        if (tail>head) then
        begin
          TimeBegin := head/48;
          TimeEnd := (tail)/48;
          if TimeEnd>=TimeBegin then
          begin
            Strs.Add(TimeToMyStr(TimeBegin)+TimeToMyStr(TimeEnd));
          end;
        end;
      end;
    end;
    Result := True;
  end;
end;

function SplitString(const S: string;var args: array of string;const Seperators: TSysCharSet=[#9]): Integer;
var
  i, ct, head, tail: Integer;
begin
  ct := 0;
  tail := 0;
  Result:=0;
  FillChar(Args, SizeOf(Args), 0);
  if Length(args)=0 then Exit;
  for i := 1 to Length(S) do
  begin
    if S[i] in Seperators then
    begin
      head := tail;
      tail := i;
      Args[Low(Args)+ct] := Copy(S, head+1, tail-head-1);
      inc(ct);
    end
    else if (i=Length(S)) then
    begin
      Args[Low(Args)+ct]:=Copy(S, tail+1, i-tail);
      Inc(ct);
      Break;
    end;
    if ct>High(Args) then Break;
  end;
  Result:=ct;
end;

function AryStrToString(const args: array of string; Seperator: Char; MaxCol: Integer): string;
var
  i: Integer;
begin
  if MaxCol=0 then MaxCol:=High(args) else
    if MaxCol>High(args) then MaxCol:=High(args);
  Result:=args[Low(args)];
  for i:=Low(args)+1 to MaxCol do
    Result:=Result+Seperator+args[i];
end;



end.


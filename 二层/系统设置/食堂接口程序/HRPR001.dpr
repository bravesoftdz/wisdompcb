program HRPR001;

uses
  Forms,SysUtils,Windows,
  MainU in 'MainU.pas' {Main_Form},
  UDM in 'UDM.pas' {DM: TDataModule},
  modify_card in 'modify_card.pas' {Form_modify_card},
  dataimport_show in 'dataimport_show.pas';
 var
  hMutex: Cardinal;
  Ret: Integer;
  sExeNm:string;

{$R *.res}

begin
sExeNm:='';
  sExeNm := ExtractFileName(Application.ExeName);
  if Pos('.', sExeNm) > 0 then
    sExeNm := Copy(sExeNm, 1, Pos('.', sExeNm) - 1);
  sExeNm:=sExeNm+'_TBYF';
 
  hMutex := CreateMutex(nil, False, PChar(sExeNm));
  Ret := GetLastError;
  if Ret <> ERROR_ALREADY_EXISTS then
   //һ�����
  begin
  Application.Initialize;
  Application.CreateForm(TMain_Form, Main_Form);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm_modify_card, Form_modify_card);
  Application.Run;
  // һ���������
  end 
  else
  begin
    ReleaseMutex(hMutex);
    Application.MessageBox('�ó����Ѿ����У������ѱ�����С����', '�ظ�����', MB_OK + MB_ICONEXCLAMATION);
    Halt;
  end;
end.

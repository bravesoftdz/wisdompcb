unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, ADODB, ActnList, ImgList;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    N01: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N03: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N04: TMenuItem;
    N6: TMenuItem;
    N05: TMenuItem;
    N7: TMenuItem;
    N06: TMenuItem;
    N8: TMenuItem;
    N07: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N99: TMenuItem;
    adoConn: TADOConnection;
    N08: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N_Separate1: TMenuItem;
    N13: TMenuItem;
    N_Separate0: TMenuItem;
    procedure N1Click(Sender: TObject);
    procedure N99Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    iTag: Integer;    
  end;

var
  frmMain: TfrmMain;

implementation

uses BaseForm,
     Report1,      {������ϸ��ѯ}
     Report2,      {������ܲ�ѯ}
     Report3,      {�����ϸ��ѯ}
     Report4,      {�����ϸ��ѯ}
     Report5,      {�����ܲ�ѯ}
     Report6,      {��;��ϸ��ѯ}
     Report7,      {��Ӧ����Ϣ��ѯ}
     Report8,      {������Ϣ��ѯ}
     Report9,      {���������빺��ѯ}
     Report10,     {�����������빺��ѯ}
     Report11,     {�������ϲɹ���ѯ(׼ʱ������)}
     Report12,     {���������ϲɹ���ѯ(׼ʱ������)}
     Report13,     {Cost Down ��Ϣ��ѯ}
     common;

{$R *.dfm}

procedure TfrmMain.N1Click(Sender: TObject);
var
  vTitle,vSql,vFormName,vClassName: string;
begin
  Case (Sender as TMenuItem).Tag of
    1:
    begin
      vTitle:= '������ϸ��ѯ';
      //vSql:= 'Exec SP_GroupReports :Servers, :Condition, :OrderBy';
    end;
    2:
    begin
      vTitle:= '������ܲ�ѯ';
      //vSql:= 'Exec SP_GroupReports;2 :Servers, :Condition, :OrderBy';   //ʹ�ô��ֺŵĴ洢���̻ᵼ��Parameters���ͳ���,�������趨��Parameters����ʹ��
    end;
    3:
    begin
      vTitle:= '�����ϸ��ѯ';
      //vSql:= 'Exec SP_GroupReports;3 :Servers, :Condition, :OrderBy';
    end;
    4:
    begin
      vTitle:= '�����ϸ��ѯ';
      //vSql:= 'Exec SP_GroupReports;4 :Servers, :Condition, :OrderBy';
    end;
    5:
    begin
      vTitle:= '�����ܲ�ѯ';
      //vSql:= 'Exec SP_GroupReports;5 :Servers, :Condition, :OrderBy';
    end;
    6:
    begin
      vTitle:= '��;��ϸ��ѯ';
      //vSql:= 'Exec SP_GroupReports;6 :Servers, :Condition, :OrderBy';
    end;
    7:
    begin
      vTitle:= '��Ӧ����Ϣ��ѯ';
      //vSql:= 'Exec SP_GroupReports;7 :Servers, :Condition, :OrderBy';
    end;
    8:
    begin
      vTitle:= '������Ϣ��ѯ';
      //vSql:= 'Exec SP_GroupReports;8 :Servers, :Condition, :OrderBy';
    end;
    9:
    begin
      vTitle:= '���������빺��ѯ';
      //vSql:= 'Exec SP_GroupReports;9 :Servers, :Condition, :OrderBy';
    end;
    10:
    begin
      vTitle:= '�����������빺��ѯ';
      //vSql:= 'Exec SP_GroupReports;10 :Servers, :Condition, :OrderBy';
    end;
    11:
    begin
      vTitle:= '�������ϲɹ���ѯ(׼ʱ������)';
      //vSql:= 'Exec SP_GroupReports;11 :Servers, :Condition, :OrderBy';
    end;
    12:
    begin
      vTitle:= '���������ϲɹ���ѯ(׼ʱ������)';
      //vSql:= 'Exec SP_GroupReports;12 :Servers, :Condition, :OrderBy';
    end;
    13:
    begin
      vTitle:= 'Cost Down ��Ϣ��ѯ';
      //vSql:= 'Exec SP_GroupReports;13 :Servers, :Condition, :OrderBy';
    end;
  end;
  iTag:= (Sender as TMenuItem).Tag;
  vFormName:= 'frmReport'+IntToStr((Sender as TMenuItem).Tag);
  vClassName:= 'T'+vFormName;
  if Application.FindComponent(vFormName)=nil then
  begin
    if GetClass(vClassName) <> nil then
    with TfrmBaseForm(TComponentClass(FindClass(vClassName)).Create(Application)) do
    begin
      Name:= vFormName;
      InitForm(vTitle, vSql);
    end
    else
      ShowMessage(Format('��%sδע��',[vClassName]));
  end
  else
    TfrmBaseForm(Application.FindComponent(vFormName)).WindowState:= wsMaximized;
end;

procedure TfrmMain.N99Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
{$IFDEF Release}
  if not App_init_2(adoConn) then
  begin
    ShowMsg('��������ʧ�ܣ�����ϵ����Ա��',1);
    Application.Terminate;
  end;
{$ENDIF}
{$IFDEF Debug}
  adoConn.Connected:= False;
  adoConn.Connected:= True;
{$ENDIF}
  Self.Caption:= Application.Title;
end;

initialization

RegisterClasses([TfrmReport1,TfrmReport2,TfrmReport3,TfrmReport4,TfrmReport5,TfrmReport6,TfrmReport7,
                 TfrmReport8,TfrmReport9,TfrmReport10,TfrmReport11,TfrmReport12,TfrmReport13]);

finalization

UnRegisterClasses([TfrmReport1,TfrmReport2,TfrmReport3,TfrmReport4,TfrmReport5,TfrmReport6,TfrmReport7,
                   TfrmReport8,TfrmReport9,TfrmReport10,TfrmReport11,TfrmReport12,TfrmReport13]);

end.

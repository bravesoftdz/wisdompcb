unit ExcelImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, Comobj, TLHelp32, Grids,
  DBGrids, DB, ADODB;

type
  TfrmExcelImport = class(TForm)
    pgc1: TPageControl;
    ts1: TTabSheet;
    edtFile: TEdit;
    btn1: TSpeedButton;
    lbl1: TLabel;
    dlgOpen1: TOpenDialog;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ts2: TTabSheet;
    ts3: TTabSheet;
    ts4: TTabSheet;
    rg1: TRadioGroup;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    dbgrd1: TDBGrid;
    con1: TADOConnection;
    qry1: TADOQuery;
    ds1: TDataSource;
    lbl2: TLabel;
    pb1: TProgressBar;
    qryImport: TADOQuery;
    qryImportWAREHOUSE_CODE: TStringField;
    qryImportDEPT_CODE: TStringField;
    qryImportINV_PART_NUMBER: TStringField;
    qryImportQUAN: TFloatField;
    qryImportSTD_PRICE: TFloatField;
    lbl3: TLabel;
    cmd1: TADOCommand;
    cmdInsert: TADOCommand;
    cmdPrice: TADOCommand;
    procedure btn1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
  private
    { Private declarations }
    ExcelApp: Variant;
  public
    { Public declarations }
  end;

var
  frmExcelImport: TfrmExcelImport;

implementation

uses uDM;

{$R *.dfm}

procedure TfrmExcelImport.btn1Click(Sender: TObject);
begin
 if  dlgOpen1.Execute then
 begin
   edtFile.Text:= dlgOpen1.FileName;
 end;
end;

procedure TfrmExcelImport.BitBtn1Click(Sender: TObject);
var
 i:integer;
begin
  if edtFile.Text='' then
  begin
    Application.MessageBox('��ѡ���赼���Excel�ļ�!','��ʾ',mb_ok);
  end;
  try
    ExcelApp.WorkBooks.Open(trim(edtFile.Text));
    con1.Connected:=False ;
    qry1.Active :=False ;
    con1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=';
    con1.ConnectionString:=con1.ConnectionString+trim(edtFile.Text);
    con1.ConnectionString:=con1.ConnectionString+';Extended Properties=excel 8.0;Persist Security Info=false';
    con1.LoginPrompt:=False ;
    con1.Connected:=True;
    rg1.Items.Clear;
    for i:=1 to ExcelApp.ActiveWorkbook.WorkSheets.Count do
      rg1.Items.Add(ExcelApp.ActiveWorkbook.WorkSheets[i].Name);
    rg1.ItemIndex:=0;
    pgc1.ActivePageIndex:= 1;
  except
    ExcelApp.WorkBooks.Close;
  end;
end;

procedure TfrmExcelImport.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmExcelImport.FormShow(Sender: TObject);
begin
  ts1.TabVisible:= False;
  ts2.TabVisible:= False;
  ts3.TabVisible:= False;
  ts4.TabVisible:= False;
  pgc1.ActivePageIndex:= 0;
  ExcelApp:= CreateOleObject('Excel.Application');
end;

procedure TfrmExcelImport.FormClose(Sender: TObject;
  var Action: TCloseAction);
  procedure EndProcess(AFileName: string);
  const
    PROCESS_TERMINATE=$0001;
  var
    ExeFileName: String;
    ContinueLoop: BOOL;
    FSnapshotHandle: THandle;
    FProcessEntry32: TProcessEntry32;
  begin
    ExeFileName := AFileName;
    FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle,FProcessEntry32);
    while integer(ContinueLoop) <> 0 do
      begin
        if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))=UpperCase(ExeFileName))
         or (UpperCase(FProcessEntry32.szExeFile)=UpperCase(ExeFileName))) then
          TerminateProcess(OpenProcess(PROCESS_TERMINATE, BOOL(0),FProcessEntry32.th32ProcessID), 0);
        ContinueLoop := Process32Next(FSnapshotHandle,FProcessEntry32);
      end;
  end;
begin
  if ExcelApp.WorkBooks.Count<>0 then
  begin
   try
     ExcelApp.WorkBooks.Close;
   except
   end;
  end;
  EndProcess('Excel.exe');
  Action:= Cafree;
end;

procedure TfrmExcelImport.BitBtn3Click(Sender: TObject);
begin
  qry1.close;
  qry1.SQL.Clear;
  qry1.sql.Add('SELECT * FROM ['+rg1.Items[rg1.ItemIndex]+'$]');
  qry1.open;
  pgc1.ActivePageIndex:= 3;
end;

procedure TfrmExcelImport.BitBtn4Click(Sender: TObject);
begin
  if ExcelApp.activeWorkBook.WorkSheets.Count<>0 then
    ExcelApp.WorkBooks.Close;
  pgc1.ActivePageIndex:= 0;
end;

procedure TfrmExcelImport.BitBtn5Click(Sender: TObject);
begin
  pgc1.ActivePageIndex:=2;
  try
    BitBtn7.Visible:= False;
    lbl2.Caption:='���ݵ����У����Ժ򡣡���';
    with qry1 do
    begin
      close;
      SQL.Clear;
      SQL.Add('SELECT * FROM ['+rg1.Items[rg1.ItemIndex]+'$]');
      open;
      Application.ProcessMessages;
      pb1.StepBy(1);
      pb1.Max:= qry1.RecordCount+2;
      First;
      cmd1.Execute;
      if not qryImport.Active then qryImport.Open;
      while not qry1.Eof do
      begin
        qryImport.Append;
        qryImportWAREHOUSE_CODE.Value:=qry1.Fields[0].AsString;
        qryImportDEPT_CODE.Value:=qry1.Fields[1].AsString;
        qryImportINV_PART_NUMBER.Value:=qry1.Fields[2].AsString;
        qryImportQUAN.Value:=qry1.Fields[3].AsFloat;
//        qryImportSTD_PRICE.Value:=qry1.Fields[4].AsFloat;
        qryImport.Post;
        Application.ProcessMessages;
        pb1.StepBy(1);
        Next;
      end;
    end;
  except
    ShowMessage('�����������������Excel�ļ���ʽ�Ƿ���Ҫ���һ�£�');
    Abort;
  end;
  try  //�ȸ��µ��ۣ��ٰ����ݴ��м��ת����Data0462
//    cmdPrice.Parameters.ParamByName('RKEY444').Value:=DM.DS444RKEY.Value;
  //jacky zhong 2015-5-30 ͬ��������������ֻ��ֵ��һ��������sqlִ���쳣
    cmdPrice.Parameters[0].Value:=DM.DS444RKEY.Value;
    cmdPrice.Parameters[1].Value:=DM.DS444RKEY.Value;
    cmdPrice.Parameters[2].Value:=DM.DS444RKEY.Value;
    cmdPrice.Prepared;
    cmdPrice.Execute; 
    cmdInsert.Parameters.ParamByName('D0443_PTR').Value:=dm.DS444RKEY.Value;
    cmdInsert.Prepared;
    cmdInsert.Execute;   //�жϹ��������򡢲��ϱ����Ƿ���ȷ
    pb1.StepBy(1);
    lbl2.Caption:='���ݵ���ɹ�'+IntToStr(qry1.RecordCount)+'�У�';
    BitBtn7.Visible:= True;
  except
    on E:Exception do
    begin
      ShowMessage(E.Message);
      lbl2.Caption:= '���ݵ���ʧ�ܣ�'+E.Message;
      pb1.Position:=0;
      BitBtn7.Visible:= True;
      Abort;
    end;
  end;
end;

procedure TfrmExcelImport.BitBtn6Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmExcelImport.BitBtn7Click(Sender: TObject);
begin
  Close;
  DM.AD462.Close;
  DM.AD462.Open;
end;

procedure TfrmExcelImport.BitBtn8Click(Sender: TObject);
begin
//  Table1.Close;
//  Database1.Connected:=false;
  pgc1.ActivePageIndex:= 1;
end;

end.

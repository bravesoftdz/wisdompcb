unit ExcelFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, Grids, ExtCtrls, ComObj;

type
  TFrmExcel = class(TForm)
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    Button1: TButton;
    EdtFilename: TEdit;
    BitBtn3: TBitBtn;
    Button2: TButton;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    StringGrid2: TStringGrid;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmExcel: TFrmExcel;

implementation

uses common, Damo, DateUtils;

{$R *.dfm}

procedure TFrmExcel.BitBtn3Click(Sender: TObject);
begin
  OpenDialog1.Title := '��ѡ����ȷ��excel�ļ�';
   OpenDialog1.Filter := 'Excel(*.xls)|*.xls';
   if OpenDialog1.Execute then
     EdtFilename.Text := OpenDialog1.FileName;
end;

procedure TFrmExcel.FormCreate(Sender: TObject);
begin
  StringGrid1.Cells[0, 0] := '����';
  StringGrid1.Cells[1, 0] := '����';
  StringGrid1.Cells[2, 0] := '��Ч����';
  StringGrid1.Cells[3, 0] := '��Ч�÷�';
  StringGrid1.Cells[4, 0] := '��Чʱ��';
  StringGrid1.Cells[5, 0] := '��ע';
  StringGrid1.Cells[6, 0] := '��֤���';
  StringGrid1.Cells[7, 0] := 'employeeid';
  StringGrid1.Cells[8, 0] := 'item';
  StringGrid1.Cells[9, 0] := 'flag';

  StringGrid2.Cells[0, 0] := '����';
  StringGrid2.Cells[1, 0] := '����';
  StringGrid2.Cells[2, 0] := '��Ч����';
  StringGrid2.Cells[3, 0] := '��Ч�÷�';
  StringGrid2.Cells[4, 0] := '��Чʱ��';
  StringGrid2.Cells[5, 0] := '��ע';
end;

procedure TFrmExcel.Button1Click(Sender: TObject);
const
     BeginRow = 2; BeginCol = 1;
var
     Excel: OleVariant;
     iRow,iCol,i : integer;
     xlsFilename: string;
begin
  if (trim(EdtFilename.Text) = '') then
  begin
   MessageBox(GetActiveWindow(), '��ѡ����ȷ��excel·��', '��ʾ��Ϣ', MB_OK + MB_ICONWARNING);
   exit;
  end;
  xlsFilename := trim(EdtFilename.Text);
  try
    Excel := CreateOLEObject('Excel.Application');
  except
    Application.MessageBox('excelû�а�װ', '��ʾ��Ϣ', MB_OK+MB_ICONASTERISK+MB_DEFBUTTON1+MB_APPLMODAL);
    Exit;
  end;
  Excel.Visible := false;
  Excel.WorkBooks.Open(xlsFilename);
  try
    iRow := BeginRow;
    iCol := BeginCol;
    while trim(Excel.WorkSheets[1].Cells[iRow,iCol].value) <> '' do
    begin
      with StringGrid1 do
      begin
        Cells[0, iRow - 1] := trim(Excel.WorkSheets[1].Cells[iRow,iCol].value);   //����
        Cells[1, iRow - 1] := trim(Excel.WorkSheets[1].Cells[iRow,iCol+1].value); //����
        Cells[2, iRow - 1] := trim(Excel.WorkSheets[1].Cells[iRow,iCol+2].value); //��Ч����
        Cells[3, iRow - 1] := trim(Excel.WorkSheets[1].Cells[iRow,iCol+3].value); //��Ч�÷�
        Cells[4, iRow - 1] := trim(Excel.WorkSheets[1].Cells[iRow,iCol+4].value); //��Чʱ��
        Cells[5, iRow - 1] := trim(Excel.WorkSheets[1].Cells[iRow,iCol+5].value); //��ע
        iRow := iRow + 1;
        Label5.Caption := IntToStr(StringGrid1.RowCount - 1) + ' ��';
        RowCount := RowCount + 1;
      end;
    end;
    StringGrid1.RowCount := StringGrid1.RowCount - 1;
    Excel.Quit;
  except
    Application.MessageBox('�������ݳ���', '��ʾ��Ϣ', MB_OK+MB_ICONASTERISK+MB_DEFBUTTON1+MB_APPLMODAL);
    Excel.Quit;
  end;
  MessageBox(GetActiveWindow(), '���ݵ���ɹ�', '��ʾ��Ϣ', MB_OK + MB_ICONWARNING);
  Button1.Enabled := False;
end;

procedure TFrmExcel.Button2Click(Sender: TObject);
var
  i, j: Integer;
  vDateTime: TDateTime;
begin
  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    if StringGrid1.Cells[0,1] ='' then
    begin
      ShowMessage('��ǰ��¼Ϊ�գ��뵼�����ݺ��ٽ�����֤��');
      Exit;
    end;
    with DM.qrytemp do
    begin
      //��֤��Ա�����Ƿ���������Ϣ���е�����
      Close;
      SQL.Clear;
      SQL.Text := 'select rkey from employeemsg where employeecode =' + QuotedStr(StringGrid1.Cells[0, i])
        + ' and chinesename= ' + QuotedStr(StringGrid1.Cells[1, i]);
      Open;
      if IsEmpty then
      begin
        StringGrid1.Cells[6, i] := StringGrid1.Cells[6, i] + 'ʧ�ܣ�������Ϣ�޸�Ա����Ϣ�򹤺���������ƥ��;'
      end
      else
      begin
        StringGrid1.Cells[7, i] := IntToStr(FieldValues['rkey']);
        //��֤����ļ�Ч�÷�
        if Trim(StringGrid1.Cells[3, i]) = '' then
        begin
           StringGrid1.Cells[6, i] := 'ʧ�ܣ���Ч�÷ֲ���Ϊ��; ';
        end
        else
        begin
          Close;
          SQL.Clear;
          SQL.Text := 'select rkey, dictid from dbo.datadetail where item = ' + QuotedStr(StringGrid1.Cells[2, i]);
          Open;
          if IsEmpty then
          begin
            StringGrid1.Cells[6, i] := 'ʧ�ܣ���Ч��������;';
          end
          else
          begin
            if FieldByName('dictid').AsInteger = 12 then StringGrid1.Cells[9, i] := '0';
            if FieldByName('dictid').AsInteger = 15 then StringGrid1.Cells[9, i] := '1';
            StringGrid1.Cells[8, i] := IntToStr(FieldValues['rkey']);
            if not TryStrToDate(StringGrid1.Cells[4, i], vDateTime) then
            begin
              StringGrid1.Cells[6, i] := 'ʧ�ܣ�ʱ���ʽ����;';
            end
            else
            begin
              j := j + 1;
              StringGrid1.Cells[6, i] := '��֤ͨ��';
            end;
          end;
        end;
      end;
    end;
  end;
  Label6.Caption := IntToStr(j) +' ��';
  Label7.Caption := IntToStr(StringGrid1.RowCount - 1 - j) + ' ��';
end;

procedure TFrmExcel.Button3Click(Sender: TObject);
var
 i:byte;
begin
  for i := 1 to StringGrid1.RowCount - 1 do StringGrid1.Rows[i].Clear;
  StringGrid1.RowCount:=2;
  Button1.Enabled := True;
  Label5.Caption := '0 ��';
  Label6.Caption := '0 ��';
  Label7.Caption := '0 ��';
end;

procedure TFrmExcel.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  If (Length(StringGrid1.Cells[ACol, ARow]) > 8) and (ACol = 6) then
  Begin
      StringGrid1.Canvas.Brush.Color := clRed;
  End;
  StringGrid1.Canvas.FillRect(Rect);
  StringGrid1.Canvas.TextOut(Rect.Left+2,Rect.Top+2,StringGrid1.Cells[acol,ARow]);
end;

procedure TFrmExcel.SpeedButton1Click(Sender: TObject);
begin
  common.Export_Grid_to_Excel(StringGrid2, '����ģ��');
end;

procedure TFrmExcel.BitBtn2Click(Sender: TObject);
var
  i, j, uj: Integer;
begin
  if StringGrid1.Cells[6, 1] = '' then
  begin
    MessageBox(GetActiveWindow(), '���Ƚ�����֤����֤���ٱ�������', '��ʾ��Ϣ', MB_OK + MB_ICONWARNING);
    Exit;
  end;
  if MessageDlg('����ʱֻ�����Ч��¼����ȷ��Ҫ������?',mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    for i := 1 to stringgrid1.RowCount - 1 do
    begin
      try
        uj := uj +1;
        if Length(StringGrid1.Cells[6, i]) <= 8 then
        begin
          DM.ADOConnection1.BeginTrans;
          with DM.qrytemp do
          begin
            Close;
            SQL.Clear;
            SQL.Text := Format('insert into employee_rewards_punishment(employeeid, type, money, effectdate, remark, flag) '
              + 'values(%d, %d, %d, ''%s'', ''%s'', %d)',
              [StrToInt(stringGrid1.Cells[7, i]), StrToInt(StringGrid1.Cells[8,i]), StrToInt(StringGrid1.Cells[3,i]),
              stringgrid1.Cells[4,i], stringgrid1.Cells[5,i], StrToInt(stringgrid1.Cells[9,i])]);
            ExecSQL;
            j := j + 1;
          end;
          DM.ADOConnection1.CommitTrans;
        end;
      except
        on e: Exception do
        begin
          DM.ADOConnection1.RollbackTrans;
          ShowMessage('�����쳣...... (' + e.Message + ')');
        end;
      end;
    end;
  end;
  ShowMessage('����ɹ�!'  + #13
    +  '�˴α�����Ч���ݹ��ƣ�' + IntToStr(j) + ' ��' + #13
    +  '�˴α�����Ч���ݹ��ƣ�' + IntToStr(uj - j) + ' ��');
  ModalResult := mrOk;
end;

end.

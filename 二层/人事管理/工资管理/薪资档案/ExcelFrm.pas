unit ExcelFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Buttons, StdCtrls, ExtCtrls, common, damo, ComObj, DateUtils;

type
  TFrmExcel = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    Button1: TButton;
    EdtFilename: TEdit;
    BitBtn3: TBitBtn;
    Button2: TButton;
    Button3: TButton;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    FCount: Integer;
  public
    { Public declarations }
  end;

var
  FrmExcel: TFrmExcel;

implementation
 

{$R *.dfm}

procedure TFrmExcel.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  StringGrid1.Cells[0, 0] := '����';
  StringGrid1.Cells[1, 0] := '����';
  {select employeemsg.rkey, employeemsg.status, Employeebasicsalary.freshflag,  '
+ 'employeecode as Ա������,chinesename as Ա������,departmentname as ��������,'
+ ' ondutytime as ��ְʱ��,outdutytime as ��ְʱ��,datadetail.item as ְ��, '
+ ' (select max(effect_date) from basicsalary_alteration where itemname like '+#39+'%����%'+#39
+ 'and basicsalary_alteration.employeeid=employeemsg.rkey and effect_flag=1) as �ϴε�нʱ��,'}
  for i := 10 to DM.qry1.FieldCount-1 do
  begin
    StringGrid1.ColWidths[i -8] := 90;
    StringGrid1.Cells[i - 8, 0] := DM.qry1.Fields[i].FieldName;

  end;

  for i := 0 to  DM.c_len- 1 do
  begin
    StringGrid1.Cells[i+4, 1]:= DM.C[i];
  end;  


  for i := 4+DM.c_len to StringGrid1.ColCount - 3 do
  begin
    StringGrid1.ColWidths[i] := 0;
    FCount := FCount + 1;
  end;

  StringGrid1.Cells[StringGrid1.ColCount-2, 0] := 'Ա��rkey';
  StringGrid1.Cells[StringGrid1.ColCount-1, 0] := '��֤���';
  StringGrid1.ColWidths[StringGrid1.ColCount-1] := 250;
  
end;

procedure TFrmExcel.BitBtn3Click(Sender: TObject);
begin
    OpenDialog1.Title := '��ѡ����ȷ��excel�ļ�';
   OpenDialog1.Filter := 'Excel(*.xls)|*.xls';
   if OpenDialog1.Execute then
     EdtFilename.Text := OpenDialog1.FileName;
end;

procedure TFrmExcel.Button1Click(Sender: TObject);
const
     BeginRow = 2; BeginCol = 1;
var
     Excel: OleVariant;
     iRow,iCol,i,j : integer;
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
        Cells[0, iRow] := trim(Excel.WorkSheets[1].Cells[iRow,iCol].value);   //����
        Cells[1, iRow] := trim(Excel.WorkSheets[1].Cells[iRow,iCol+1].value); //����
        for j := 0 to StringGrid1.ColCount - 3 do
        begin
          Cells[j+2, iRow] := trim(Excel.WorkSheets[1].Cells[iRow, j+3].value);
        end;
        iRow := iRow + 1;
        Label5.Caption := IntToStr(StringGrid1.RowCount - 2) + ' ��';
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
  Button2Click(Sender);
  
end;

procedure TFrmExcel.Button2Click(Sender: TObject);
var
  i, j, k, outPut: Integer;
begin
  for i := 2 to StringGrid1.RowCount - 1 do
  begin
    if StringGrid1.Cells[0,2] ='' then
    begin
      ShowMessage('��ǰ��¼Ϊ�գ��뵼�����ݺ��ٽ�����֤��');
      Exit;
    end;
   StringGrid1.Cells[StringGrid1.ColCount-1, i] := '';
    with DM.qrytemp do
    begin
      for k := 2 to dm.c_len+1 do
      begin
         //ShowMessage(StringGrid1.Cells[k, i]);
        if not TryStrToInt(StringGrid1.Cells[k, i], outPut) then
        begin
          StringGrid1.Cells[StringGrid1.ColCount-1, i] := 'ʧ�ܣ���Ŀ�������'
        end;
      end;
      //��֤��Ա�����Ƿ���������Ϣ���е�����
      Close;
      SQL.Clear;
      SQL.Text := 'select employeecode, freshflag from employeemsg inner join '
        + ' Employeebasicsalary on employeemsg.rkey=Employeebasicsalary.employeeid '
        + ' where employeecode =' + QuotedStr(StringGrid1.Cells[0, i]);
      Open;
      if FieldByName('employeecode').IsNull then
      begin
        StringGrid1.Cells[StringGrid1.ColCount-1, i] := 'ʧ�ܣ��ù��Ų�����';
      end
      else if FieldByName('freshflag').AsInteger =1 then
      begin
        StringGrid1.Cells[StringGrid1.ColCount-1, i] := 'ʧ�ܣ�н�ʵ������б����¼';
      end;
    end;

    if StringGrid1.Cells[StringGrid1.ColCount-1, i] = ''
    then
    begin
      StringGrid1.Cells[StringGrid1.ColCount-1, i] := '��֤ͨ��';
      j := j + 1;
    end;
  end;
  Label6.Caption := IntToStr(j) +' ��';
  Label7.Caption := IntToStr(StringGrid1.RowCount - 2 - j) + ' ��';
end;


procedure TFrmExcel.Button3Click(Sender: TObject);
var
 i:byte;
begin
  for i := 2 to StringGrid1.RowCount - 1 do StringGrid1.Rows[i].Clear;
  StringGrid1.RowCount:=3;
  Button1.Enabled := True;
  Label5.Caption := '0 ��';
  Label6.Caption := '0 ��';
  Label7.Caption := '0 ��';
end;

procedure TFrmExcel.SpeedButton1Click(Sender: TObject);
var i:Integer;
begin
  StringGrid2.ColCount := 4+dm.c_len;
  StringGrid2.RowCount :=1;
  for i:=0 to  4+dm.c_len   do
  begin
    StringGrid2.Cells[i,0]:= StringGrid1.Cells[i,0]
  end;

  common.Export_Grid_to_Excel(StringGrid2, 'н����������');
end;

procedure TFrmExcel.BitBtn2Click(Sender: TObject);
var
  i,j: Integer;
  datafield: array of string;

begin
  if StringGrid1.Cells[StringGrid1.ColCount-1, 2] = '' then
  begin
    MessageBox(GetActiveWindow(), '���Ƚ�����֤����֤���ٱ�������', '��ʾ��Ϣ', MB_OK + MB_ICONWARNING);
    Exit;
  end;
  if MessageDlg('����ʱֻ�����Ч��¼, ��ȷ��Ҫ������?',mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    for i := 2 to stringgrid1.RowCount - 1 do
    begin
      try
        if StringGrid1.Cells[StringGrid1.ColCount-1, i] = '��֤ͨ��' then
        begin
          DM.ADOConnection1.BeginTrans;
          with DM.qrytemp do
          begin
            Close;
            SQL.Clear;
            SQL.Text := 'update  Employeebasicsalary  set ';
              for j:=0 to DM.c_len-1 do
               begin
                 if j=0 then SQL.Text := SQL.Text + dm.C[j]+'='+ StringGrid1.Cells[4+j, i]
                 else SQL.Text := SQL.Text +', '+ dm.C[j]+'='+ StringGrid1.Cells[4+j, i];
               end;
            SQL.Text :=SQL.Text + '  from  Employeebasicsalary where freshflag=0 and employeeid=('+
              'select top 1 rkey from employeemsg where employeecode =' + QuotedStr(StringGrid1.Cells[0, i])+')' ;
            //showmessage(SQL.Text);
            ExecSQL;
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
  ModalResult := mrOk;
end;

end.

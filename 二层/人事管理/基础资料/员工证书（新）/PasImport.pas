unit PasImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons, ExtCtrls,ADODB, Menus;

type
  TfrmImport = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    sgImport: TStringGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    OpenDialog1: TOpenDialog;
    Panel3: TPanel;
    Label1: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure sgImportMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sgImportDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
    procedure importSave(sg_row:Integer;adotmp:TADOQuery);
  public
    { Public declarations }
  end;

var
  frmImport: TfrmImport;

implementation

uses damo,common,ComObj;

{$R *.dfm}

procedure TfrmImport.FormShow(Sender: TObject);
begin
  sgImport.Cells[0,0]:='����';
  sgImport.Cells[1,0]:='֤����';
  sgImport.Cells[2,0]:='֤������';
  sgImport.Cells[3,0]:='֤������';
  sgImport.Cells[4,0]:='��Ч����';
  sgImport.Cells[5,0]:='ʧЧ����';
  sgImport.Cells[6,0]:='��ע';
  sgImport.Cells[7,0]:='��λ����';
  sgImport.Cells[8,0]:='��λ����';

  sgImport.ColWidths[9]:= 0;
  sgImport.ColWidths[10]:= 0;
  sgImport.ColWidths[12]:= 0;
end;

procedure TfrmImport.BitBtn1Click(Sender: TObject);
begin
  common.Export_Grid_to_Excel(sgImport,'Ա��֤�鵼��',True);
end;

procedure TfrmImport.BitBtn2Click(Sender: TObject);
var
  excel:Variant;
  i,iRow,iCol:Integer;
begin
  iRow:=2;
  iCol:=1;
  OpenDialog1.Title:='��ѡ��Ҫ������ļ�';
  OpenDialog1.Filter:='*.xls|*.xls|*.xlsx|*.xlsx';
  OpenDialog1.DefaultExt:='xls';

  if OpenDialog1.Execute then
  begin
    if sgImport.RowCount > 2 then btnClearClick(nil);
    sgImport.Cursor:=crHourGlass;
    excel:= CreateOleObject('Excel.Application');
    excel.Visible := false;
    excel.WorkBooks.Open(opendialog1.FileName);
    for i:=2 to excel.ActiveSheet.UsedRange.Rows.Count  do
    begin
      with sgImport do
      begin
        Cells[0,iRow-1]:= Trim(excel.activesheet.cells[iRow,iCol].value);
        Cells[1,iRow-1]:= Trim(excel.activesheet.cells[iRow,iCol+1].value);
        Cells[2,iRow-1]:= Trim(excel.activesheet.cells[iRow,iCol+2].value);
        Cells[3,iRow-1]:= Trim(excel.activesheet.cells[iRow,iCol+3].value);
        Cells[4,iRow-1]:= Trim(excel.activesheet.cells[iRow,iCol+4].value);
        Cells[5,iRow-1]:= Trim(excel.activesheet.cells[iRow,iCol+5].value);
        Cells[6,iRow-1]:= Trim(excel.activesheet.cells[iRow,iCol+6].value);
        Cells[7,iRow-1]:= Trim(excel.activesheet.cells[iRow,iCol+7].value);
        Cells[8,iRow-1]:= Trim(excel.activesheet.cells[iRow,iCol+8].value);
        iRow:=iRow+1;
        RowCount:=RowCount+1;
      end;
    end;
    sgImport.Cursor:=crDefault;
    excel.quit;
  end;
end;

procedure TfrmImport.btnSaveClick(Sender: TObject);
var
  i,j,k,z,coderkey:Integer;
  startdate,enddate:TDateTime;
  bool,err:Boolean;
  strNC:string;
  originalList,newList:TStringList;
begin
//  sgImport.Cursor:=crAppStart;
  btnSave.Cursor:=crHourGlass;
  err:=False;
  if sgImport.RowCount>2 then
  begin

    originalList:=TStringList.Create;
    originalList.Sorted:=True;
    originalList.Duplicates:=dupAccept;
    newList:=TStringList.Create;
    newList.Sorted:=True;
    newList.Duplicates:=dupIgnore;
    for i:=1 to sgImport.RowCount-2 do                        //�жϵ��������е��ظ�
    begin
//      for o:= sgImport.RowCount-1 downto i+1 do
//      begin
//        if (sgImport.Cells[0,i]+ sgImport.Cells[1,i]) = (sgImport.Cells[0,o]+ sgImport.Cells[1,o]) then
//        begin
//          sgImport.Cells[7,i]:=sgImport.Cells[7,i]+' ����������д����������ţ�'+ sgImport.Cells[0,i]+ ',֤���ţ�'+ sgImport.Cells[1,i]+' �ļ�¼';
//          sgImport.Cells[7,o]:=sgImport.Cells[7,o]+' ����������д����������ţ�'+ sgImport.Cells[0,i]+ ',֤���ţ�'+ sgImport.Cells[1,i]+' �ļ�¼';
//
//        end;
//      end;
      strNC:=sgImport.Cells[0,i]+ sgImport.Cells[1,i];
      originalList.Add(strNC);
      newList.Add(strNC);
      if originalList.Count <> newList.Count then
      begin
        sgImport.Cells[11,i]:= sgImport.Cells[11,i]+' ������������Ѿ����ڹ��ţ�'+ sgImport.Cells[0,i]+ ',֤���ţ�'+ sgImport.Cells[1,i]+' �ļ�¼';
        err:=True;
        newList.Add(IntToStr(i));
      end;

      with DM.adoTmp do                                            //�жϹ���
      begin
        Close;
        SQL.Clear;
        SQL.Add('select rkey,employeecode from employeemsg where status=1 and employeecode ='+ QuotedStr(trim(sgImport.Cells[0,i])));
        Open;
        coderkey:=FieldByName('rkey').AsInteger;

        if not IsEmpty then
        begin
          sgImport.Cells[9,i]:= IntToStr(FieldByName('rkey').AsInteger);
          Close;
          SQL.Clear;
          SQL.Add('select rkey from hrcertificate where employeeid = '+ IntToStr(coderkey)+ ' and code = '+ QuotedStr(Trim(sgImport.Cells[1,i])));
          Open;
          if not IsEmpty then
          begin
            sgImport.Cells[11,i]:='�Ѿ����ڹ���'+ sgImport.Cells[0,i]+',֤����'+ sgImport.Cells[1,i]+' �ļ�¼';      //�ж��Ƿ��ظ����֤��
            err:=True;
          end;
        end
        else
        begin
          sgImport.Cells[11,i]:='���Ų����ڻ�Ա���Ѿ���ְ';
          err:=True;
        end;
      end;

      if (Trim(sgImport.Cells[3,i])<>'����') and (Trim(sgImport.Cells[3,i])<>'��˾')
                    and  (Trim(sgImport.Cells[3,i])<>'��ͨ��λ') and (Trim(sgImport.Cells[3,i])<>'�ؼ���λ') then            //�ж�֤������
      begin
        sgImport.Cells[11,i]:=sgImport.Cells[11,i]+' ֤����������';
        err:=True;
      end;

      if TryStrToDate(sgImport.Cells[4,i],startdate) then                       //�ж�����
      begin
        if TryStrToDate(sgImport.Cells[5,i],enddate) then
        begin
          if startdate>=enddate then
          begin
            sgImport.Cells[11,i]:= sgImport.Cells[11,i]+' ��Ч���ڴ��ڻ����ʧЧ����';
            err:=True;
          end;
        end
        else
        begin
          sgImport.Cells[11,i]:=sgImport.Cells[11,i]+' ʧЧ���ڸ�ʽ����ȷ';
          err:=True;
        end;
      end
      else
      begin
        sgImport.Cells[11,i]:=sgImport.Cells[11,i]+' ��Ч���ڸ�ʽ����ȷ';
        err:=True;
      end;


      with DM.adoTmp do                                        //�ж�֤������
      begin
        Close;
        SQL.Clear;
        SQL.Add('select rkey from datadetail where dictid = 18 and item = '+ QuotedStr(Trim(sgImport.Cells[2,i])));
        Open;
        if IsEmpty then
        begin
          sgImport.Cells[11,i]:=sgImport.Cells[11,i]+ ' ֤�����Ʋ���ȷ';
          err:=true;
        end
        else  sgImport.Cells[10,i]:=IntToStr(FieldByName('rkey').AsInteger);
      end;

      with DM.adoTmp do                                        //�жϸ�λ
      begin
        Close;
        SQL.Clear;
        SQL.Add('select rkey from datadetail where dictid = 16 and item = '+ QuotedStr(trim(sgImport.Cells[7,i])));
        Open;
        if IsEmpty then
        begin
          sgImport.Cells[11,i]:=sgImport.Cells[11,i]+ ' ��λ����ȷ';
          err:=true;
        end
        else  sgImport.Cells[12,i]:=IntToStr(FieldByName('rkey').AsInteger);
      end;
    end;
    sgImport.Cells[10,0]:='����˵��' ;
  end
  else
  begin
    btnSave.Cursor:=crDefault;
    ShowMessage('���������Ϊ�գ�����ѡ���������');
    Exit;
  end;
//  sgImport.Cursor:=crDefault;
  btnSave.Cursor:=crDefault;
  if err then
  begin
    ShowMessage('���������������鿴����˵�����޸ĺ����µ���');
    Exit;
  end;

  try
    DM.ADOConnection1.BeginTrans;
    with DM.adoTmp do
    begin
      Close;
      SQL.Clear;
      sql.Add('select code, datadetail_ptr, employeeid, type, startdate, enddate, inputdate, opration_person, status,stationid, remark,PAbility from hrcertificate where rkey = 0');
      Open;
      for z:=1 to sgImport.RowCount-2 do
      begin
        Append;
        Self.importSave(z,DM.adoTmp);
        Post;
      end;
      UpdateBatch(arAll);
      DM.ADOConnection1.CommitTrans;
      ModalResult:=mrOk;
    end;
  except
    on E: Exception do
    begin
      DM.ADOConnection1.RollbackTrans;
      messagedlg(E.Message,mterror,[mbcancel],0);
    end;
  end;
end;

procedure TfrmImport.importSave(sg_row:Integer;adotmp:TADOQuery);
begin
  with adotmp do
  begin
    with sgImport do
    begin
      FieldByName('code').AsString:=Cells[1,sg_row];
      FieldByName('datadetail_ptr').AsInteger:=StrToInt(Cells[10,sg_row]);
      FieldByName('employeeid').AsInteger:= StrToInt(Cells[9,sg_row]);
      if Cells[3,sg_row]='����' then FieldByName('type').AsInteger:=0
      else if Cells[3,sg_row]='�ؼ���λ' then  FieldByName('type').AsInteger:=1
      else if Cells[3,sg_row]='��ͨ��λ' then  FieldByName('type').AsInteger:=2
      else if Cells[3,sg_row]='��˾' then  FieldByName('type').AsInteger:=3;
      FieldByName('startdate').AsDateTime:=StrToDate(Cells[4,sg_row]);
      FieldByName('enddate').AsDateTime:=StrToDate(Cells[5,sg_row]);
      FieldByName('inputdate').AsDateTime:= getsystem_date(DM.adoTime,1);
      FieldByName('opration_person').AsInteger:= StrToInt(user_ptr);
      FieldByName('status').AsInteger:= 1;
      FieldByName('remark').AsString:=Cells[6,sg_row];
      FieldByName('stationid').AsString:=Cells[12,sg_row];
      FieldByName('PAbility').AsString:=Cells[8,sg_row];
    end;
  end;
end;

procedure TfrmImport.btnClearClick(Sender: TObject);
var
  i:Integer;
begin
  if sgImport.RowCount>2 then
    for i:=1 to sgImport.RowCount-2 do
    begin
      sgImport.Rows[i].Text:='';
    end;
  sgImport.RowCount:=2;
end;

procedure TfrmImport.N2Click(Sender: TObject);
var
  i:Integer;
begin
  if sgImport.RowCount>2 then
    for i:=1 to sgImport.RowCount-2 do
    begin
      sgImport.Rows[i].Text:='';
    end;
  sgImport.RowCount:=2;
end;

procedure TfrmImport.N1Click(Sender: TObject);
var
  i:Integer;
begin
  if sgImport.Row<>sgImport.RowCount-1 then
  begin
    for i:=sgImport.Row to sgImport.RowCount-2 do
    begin
      sgImport.Rows[i]:=sgImport.Rows[i+1];
    end;
    sgImport.RowCount:=sgImport.RowCount-1;
  end;
end;

procedure TfrmImport.sgImportMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  irow,icol:Integer;
begin
  if Button= mbRight then
  begin
    sgImport.MouseToCell(x,y,icol,irow);
    sgImport.Row:=irow;
  end;
end;

procedure TfrmImport.sgImportDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if (Length(sgImport.Cells[acol,arow])>10) and (ACol=7) and (ARow >0) then
    sgImport.Canvas.Brush.Color := clRed;
  sgImport.Canvas.FillRect(Rect);
  sgImport.Canvas.TextOut(Rect.Left+2,Rect.Top+2,sgImport.Cells[acol,ARow]);
end;

end.

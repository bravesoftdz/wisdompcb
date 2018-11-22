unit PasBatchPause;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Buttons, ExtCtrls, Grids, ComCtrls,DateUtils;

type
  TFrmBatchPause = class(TForm)
    Panel5: TPanel;
    d56STEP: TLabel;
    BitBtn2: TBitBtn;
    BitBtn5: TBitBtn;
    Panel2: TPanel;
    Label3: TLabel;
    Label7: TLabel;
    edtHour: TEdit;
    Label1: TLabel;
    Edit1: TEdit;
    SpeedButton2: TSpeedButton;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    SGrid1: TStringGrid;
    SGrid2: TStringGrid;
    labD34Rkey: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure edtHourKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBatchPause: TFrmBatchPause;

implementation
uses common, Pick_Item_Single,ConstVar, PasDM;

{$R *.dfm}

procedure TFrmBatchPause.SpeedButton2Click(Sender: TObject);
var InputVar: PDlgInput ;
    iRow,i,j,iCount:Integer;
begin
  frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
  try
    try
      DM.Ado587.DisableControls;
      InputVar.Fields := 'DEPT_CODE/�������/200,DEPT_NAME/��������/250';
      InputVar.Sqlstr :='select Rkey,DEPT_CODE,DEPT_NAME from dbo.data0034 where TType=1 order by DEPT_CODE';
      inputvar.KeyField:='DEPT_CODE';
      InputVar.AdoConn:=DM.ADOConnection1 ;
      frmPick_Item_Single.InitForm_New(InputVar);
      if frmPick_Item_Single.ShowModal=mrok then
      begin
        labD34Rkey.Caption:=frmPick_Item_Single.adsPick.FieldValues['Rkey'];
        Edit1.Tag:=frmPick_Item_Single.adsPick.FieldValues['Rkey'];
        Edit1.Text:=trim(frmPick_Item_Single.adsPick.FieldValues['DEPT_CODE']);
      end;
  //--�ж��Ƿ��ǵ�ǰ�ɹ�����-����ʾ������ʾ-----------
      iCount:=0;
      if (DM.Ado587.IsEmpty) then Exit;
      for  j:=0 to ListDEPT.Count-1 do
      begin
        if (ListDEPT[j]=labD34Rkey.Caption) then
        begin
          iCount:=iCount+1;
        end;
      end;
      if (iCount=0) then
      begin
        ShowMsg('�ù���ǰ����û����ҵ����',1);
        Exit;
      end;
//--end �ж��Ƿ��ǵ�ǰ�ɹ�����------------------------
      if (not DM.Ado587.IsEmpty) then
      begin
        DM.Ado587.Filter:='DEPT_PTR='''+labD34Rkey.Caption+'''';
        DM.Ado587.First;
        iRow:=1;
        for i :=0  to DM.Ado587.RecordCount-1 do
        begin
          SGrid1.Cells[0,iRow]:=DM.Ado587.FieldByName('WORK_ORDER_NUMBER').AsString;
          SGrid1.Cells[1,iRow]:=DM.Ado587.FieldByName('MANU_PART_NUMBER').AsString;
          SGrid1.Cells[2,iRow]:=DM.Ado587.FieldByName('DEPT_PTR').AsString;
          SGrid1.Cells[3,iRow]:=DM.Ado587.FieldByName('STEP').AsString;
          SGrid1.Cells[4,iRow]:=IntToStr(iRow);
          SGrid1.Cells[5,iRow]:=DM.Ado587.FieldByName('FLOW_NO').AsString;
          SGrid1.Cells[6,iRow]:=DM.Ado587.FieldByName('Rkey06').AsString;
          iRow:=iRow+1;
          SGrid1.RowCount:=SGrid1.RowCount+1;
          SGrid1.RowHeights[iRow]:=20;
          DM.Ado587.Next;
        end;
      end;
      DM.Ado587.First;
    finally
      DM.Ado587.EnableControls;
    end;
  finally
    frmPick_Item_Single.Free ;
  end;
end;

procedure TFrmBatchPause.FormShow(Sender: TObject);
begin
  SGrid1.ColCount:=7;
  SGrid1.ColWidths[1]:=100;
  SGrid1.ColWidths[2]:=-1;
  SGrid1.ColWidths[3]:=-1;
  SGrid1.ColWidths[4]:=-1;
  SGrid1.ColWidths[5]:=-1;
  SGrid1.ColWidths[6]:=-1;
  SGrid2.ColCount:=7;
  SGrid2.ColWidths[1]:=100;
  SGrid2.ColWidths[2]:=-1;
  SGrid2.ColWidths[3]:=-1;
  SGrid2.ColWidths[4]:=-1;
  SGrid2.ColWidths[5]:=-1;
  SGrid2.ColWidths[6]:=-1;
  SGrid1.RowHeights[0]:=20;
  SGrid2.RowHeights[0]:=20;
  SGrid1.Cells[0,0]:='ѡ����Ҫ��ͣ����ҵ����';
  SGrid1.Cells[1,0]:='�������';
  SGrid2.Cells[0,0]:='������ͣ����ҵ����';
  SGrid2.Cells[1,0]:='�������';
end;

procedure TFrmBatchPause.BitBtn2Click(Sender: TObject);
var tmpAdo:TADOQuery;
    i,iSum:Integer;
    dDate:TDateTime;
    sName05:string;
begin
  if (Trim(edtHour.Text)='') then
  begin
    ShowMsg('��ͣСʱ������Ϊ�գ�',1);
    Exit;
  end;
  if (SGrid2.Cells[0,1]='') then
  begin
    ShowMsg('û����ͣ��ҵ����',1);
    Exit;
  end;
  if (Trim(Edit2.Text)='') then
  begin
    ShowMsg('��ͣԭ����Ϊ�գ�',1);
    Exit;
  end;
  dDate:=getsystem_date(DM.tmp,0);
  dm.ADOQuery1.Close;
  dm.ADOQuery1.SQL.Text:= ' select data0117.*,data0005.employee_name from data0005,data0117 '+
           ' where data0117.source_type=2 and data0117.source_ptr='+SGrid2.Cells[6,1]+' and Action=16 and data0117.empl_ptr=data0005.rkey';
  DM.ADOQuery1.Open;
  sName05:=DM.ADOQuery1.FieldByName('employee_name').AsString;
  
  tmpAdo:=TADOQuery.Create(Application);
  try
    try
      tmpAdo.Connection:=DM.ADOConnection1;
      if not DM.ADOConnection1.InTransaction then
        DM.ADOConnection1.BeginTrans;
      iSum:=0;
  //20150421��ӹ�����ͣʱ�Ƿ������ɹ� ,54���Ƿ��ɹ�����51�Ƿ�ʱ�����
      for i :=1  to SGrid2.RowCount-2 do
      begin
        tmpAdo.Close;
        tmpAdo.SQL.Clear;
        tmpAdo.SQL.Text:='update dbo.data0056 set FLOW_NO=:FLOW_NO where WO_PTR=:WO_PTR and DEPT_PTR=:DEPT_PTR and STEP=:STEP';
        tmpAdo.Parameters.ParamByName('FLOW_NO').Value:=StrToFloat(edtHour.Text)+StrToFloat(SGrid2.Cells[5,i]);
        tmpAdo.Parameters.ParamByName('WO_PTR').Value:=StrToInt(SGrid2.Cells[6,i]);
        tmpAdo.Parameters.ParamByName('DEPT_PTR').Value:=StrToInt(labD34Rkey.Caption);
        tmpAdo.Parameters.ParamByName('STEP').Value:=StrToInt(SGrid2.Cells[3,i]);
        tmpAdo.ExecSQL;
        dm.ADOQuery1.Close;
        dm.ADOQuery1.SQL.Text:=' insert into data0117(Source_ptr,Source_Type,NOTEPAD_PTR,Empl_ptr,Tdate,Action,Remark) '+
                ' values ('+SGrid2.Cells[6,i]+',2,0,'+User_ptr+',getdate(),16,''===�ֶ�����������ͣ��'
                +datetimetostr(Ddate)+' ��ͣ:'+edtHour.Text+'Сʱ '+' ����:'+sName05+'==='+#13+'��ͣԭ��'+Trim(Edit2.Text)+''')';
        dm.ADOQuery1.ExecSQL;
        iSum:=iSum+1;
      end;
      DM.ADOConnection1.CommitTrans;
    except
      DM.ADOConnection1.RollbackTrans;
      ShowMsg('��ҵ����ͣ����ʧ�ܣ�',1);
      Exit;
    end;
    if (iSum>0) then
    begin
      ShowMsg('����������ͣ�ɹ���',1);
    end;
//    FrmBatchPause.Hide;
    modalresult:=mrok;
  finally
    tmpAdo.Close;
    tmpAdo.Connection:=nil;
    tmpAdo.Free;
    tmpAdo:=nil;
  end;
end;

procedure TFrmBatchPause.Button2Click(Sender: TObject);
var i,iRow:Integer;
begin
  if SGrid1.RowCount>2 then
  begin
    SGrid2.RowCount:=2;
    SGrid2.Rows[1].Clear;
    try
      DM.Ado587.DisableControls;
      if (not DM.Ado587.IsEmpty) then
      begin
        DM.Ado587.Filter:='DEPT_PTR='''+labD34Rkey.Caption+'''';
        DM.Ado587.First;
        iRow:=1;
        for i :=0  to DM.Ado587.RecordCount-1 do
        begin
          SGrid2.Cells[0,iRow]:=DM.Ado587.FieldByName('WORK_ORDER_NUMBER').AsString;
          SGrid2.Cells[1,iRow]:=DM.Ado587.FieldByName('MANU_PART_NUMBER').AsString;
          SGrid2.Cells[2,iRow]:=DM.Ado587.FieldByName('DEPT_PTR').AsString;
          SGrid2.Cells[3,iRow]:=DM.Ado587.FieldByName('STEP').AsString;
          SGrid2.Cells[4,iRow]:=IntToStr(iRow);
          SGrid2.Cells[5,iRow]:=DM.Ado587.FieldByName('FLOW_NO').AsString;
          SGrid2.Cells[6,iRow]:=DM.Ado587.FieldByName('rkey06').AsString;
          iRow:=iRow+1;
          SGrid2.RowCount:=SGrid2.RowCount+1;
          SGrid2.RowHeights[iRow]:=20;
          DM.Ado587.Next;
        end;
      end;
      DM.Ado587.First;
    finally
      DM.Ado587.EnableControls;
    end;
    SGrid1.RowCount:=2;
    SGrid1.Rows[1].Clear;
  end;
end;

procedure TFrmBatchPause.Button4Click(Sender: TObject);
var i,iRow,j:Integer;
begin
  if SGrid2.RowCount>2 then
  begin
    SGrid1.RowCount:=2;
    SGrid1.Rows[1].Clear;
    try
      DM.Ado587.DisableControls;
      if (not DM.Ado587.IsEmpty) then
      begin
        DM.Ado587.Filter:='DEPT_PTR='''+labD34Rkey.Caption+'''';
        DM.Ado587.First;
        iRow:=1;
        for i :=0  to DM.Ado587.RecordCount-1 do
        begin
          SGrid1.Cells[0,iRow]:=DM.Ado587.FieldByName('WORK_ORDER_NUMBER').AsString;
          SGrid1.Cells[1,iRow]:=DM.Ado587.FieldByName('MANU_PART_NUMBER').AsString;
          SGrid1.Cells[2,iRow]:=DM.Ado587.FieldByName('DEPT_PTR').AsString;
          SGrid1.Cells[3,iRow]:=DM.Ado587.FieldByName('STEP').AsString;
          SGrid1.Cells[4,iRow]:=IntToStr(iRow);
          SGrid1.Cells[5,iRow]:=DM.Ado587.FieldByName('FLOW_NO').AsString;
          SGrid1.Cells[6,iRow]:=DM.Ado587.FieldByName('rkey06').AsString;
          iRow:=iRow+1;
          SGrid1.RowCount:=SGrid1.RowCount+1;
          SGrid1.RowHeights[iRow]:=20;
          DM.Ado587.Next;
        end;
      end;
      DM.Ado587.First;
    finally
      DM.Ado587.EnableControls;
    end;
    SGrid2.Enabled:=False;
    SGrid2.Enabled:=True;
    if (SGrid2.RowCount <= 2) and (SGrid2.Cells[1,1]<>'') then
    begin
      for i:=0 to SGrid2.RowCount-1 do
        for j:=1 to SGrid2.ColCount do
       SGrid2.Cells[j,i]:='';
    end;
    SGrid2.RowCount:=2;
    SGrid2.Rows[1].Clear;
  end;
end;

procedure TFrmBatchPause.Button1Click(Sender: TObject);
var i,j,ii,jj:integer;
begin
//  if (SGrid2.Cells[0,1]='') then
//  begin
//    SGrid2.RowCount:=2;
//    SGrid2.Rows[1].Clear;
//  end;
//  SGrid2.Cells[0,SGrid2.RowCount-1]:=SGrid1.Cells[0,SGrid1.Row];
//  SGrid2.Cells[1,SGrid2.RowCount-1]:=SGrid1.Cells[1,SGrid1.Row];
//  SGrid2.Cells[2,SGrid2.RowCount-1]:=SGrid1.Cells[2,SGrid1.Row];
//  SGrid2.RowCount:=SGrid2.RowCount+1;
//  SGrid2.Rows[SGrid2.RowCount-1].Clear;
//  if (sgrid1.RowCount <= 2) and (SGrid1.Cells[1,1]='') then exit;
//  if (sgrid1.RowCount <= 2) and (SGrid1.Cells[1,1]<>'') then
//   for i:=sgrid1.Row to sgrid1.RowCount-2 do sgrid1.Rows[i].Text:=sgrid1.Rows[i+1].Text
//  else
//  begin
//    for i:=sgrid1.Row to sgrid1.RowCount-2 do sgrid1.Rows[i].Text:=sgrid1.Rows[i+1].Text;
//    sgrid1.RowCount:=sgrid1.RowCount-1;
//  end;

  for i:=SGrid1.Selection.Top to SGrid1.Selection.Bottom do
   if i<>SGrid1.RowCount-1 then       //�����ǰ�в������һ��
    begin
     if SGrid2.RowCount=2 then        //���STG2��ǰ�ǿ���
     begin
      SGrid2.Rows[1].Text := SGrid1.Rows[i].Text
     end else
      for ii:=1 to SGrid2.RowCount-2 do  //����Ѱ�Ҳ����λ�� ���ڵ�ǰ��
       if strtoint(SGrid2.Cells[4,ii])>strtoint(SGrid1.Cells[4,i]) then
        begin
         for jj:=SGrid2.RowCount-1 downto ii do
          if jj<>ii then
           SGrid2.Rows[jj].Text := SGrid2.Rows[jj-1].Text
          else
           SGrid2.Rows[jj].Text := SGrid1.Rows[i].Text;
         break;   //�����������ѭ��
        end
       else
        if ii=SGrid2.RowCount-2 then                //С�ڵ�ǰ�в��������һ��
         SGrid2.Rows[ii+1].Text := SGrid1.Rows[i].Text;
     SGrid2.RowCount := SGrid2.RowCount+1;
    end;
    SGrid2.Rows[SGrid2.RowCount-1].Clear;
                                    //�ڶ���ʵ��stg1��ɾ��
   for i:=SGrid1.Selection.Top to SGrid1.Selection.Bottom do
    begin
     for j:=SGrid1.Selection.Top to SGrid1.RowCount-2 do
      SGrid1.Rows[j].Text:=SGrid1.Rows[j+1].Text;
     if SGrid1.Selection.Top<=SGrid1.RowCount-2 then
      SGrid1.RowCount:=SGrid1.RowCount-1;
    end;
end;

procedure TFrmBatchPause.Button3Click(Sender: TObject);
var i,ii,j,jj:integer;
begin
//  if (SGrid1.Cells[0,1]='') then
//  begin
//    SGrid1.RowCount:=2;
//    SGrid1.Rows[1].Clear;
//  end;
//  SGrid1.Cells[0,SGrid1.RowCount-1]:=SGrid2.Cells[0,SGrid2.Row];
//  SGrid1.Cells[1,SGrid1.RowCount-1]:=SGrid2.Cells[1,SGrid2.Row];
//  SGrid1.Cells[2,SGrid1.RowCount-1]:=SGrid2.Cells[2,SGrid2.Row];
//  SGrid1.RowCount:=SGrid1.RowCount+1;
//  SGrid1.Rows[SGrid1.RowCount-1].Clear;
//  if (sgrid2.RowCount <= 2) and (SGrid2.Cells[1,1]='') then exit;
//  if (sgrid2.RowCount <= 2) and (SGrid2.Cells[1,1]<>'') then
//    for i:=sgrid2.Row to sgrid2.RowCount-2 do sgrid2.Rows[i].Text:=sgrid2.Rows[i+1].Text
//  else
//  begin
//    for i:=sgrid2.Row to sgrid2.RowCount-2 do sgrid2.Rows[i].Text:=sgrid2.Rows[i+1].Text;
//    sgrid2.RowCount:=sgrid2.RowCount-1;
//  end;
  for i:=SGrid2.Selection.Top to SGrid2.Selection.Bottom do
   if i<>SGrid2.RowCount-1 then //�����ǰ�в������һ��
    begin
     if SGrid1.RowCount=2 then  //���STG1��ǰ�ǿ���
      SGrid1.Rows[1].Text := SGrid2.Rows[i].Text
     else
      for ii:=1 to SGrid1.RowCount-2 do //����Ѱ�Ҳ����λ��
       if strtoint(SGrid1.Cells[4,ii])>strtoint(SGrid2.Cells[4,i]) then
        begin
         for jj:=SGrid1.RowCount-1 downto ii do
          if jj<>ii then
           SGrid1.Rows[jj].Text := SGrid1.Rows[jj-1].Text
          else
           SGrid1.Rows[jj].Text := SGrid2.Rows[i].Text;
         break;   //�����������ѭ��
        end
       else                                                         //����
        if ii=SGrid1.RowCount-2 then//С�ڵ�ǰ�в��������һ��
         SGrid1.Rows[ii+1].Text := SGrid2.Rows[i].Text;
     SGrid1.RowCount := SGrid1.RowCount+1;
    end;
  //******************************************************************************
  for i:=SGrid2.Selection.Top to SGrid2.Selection.Bottom do//�ڶ���ʵ��stringgrid2��ɾ��
   begin
    for j:=SGrid2.Selection.Top to SGrid2.RowCount-2 do SGrid2.Rows[j].Text:=SGrid2.Rows[j+1].Text;
    if SGrid2.Selection.Top<=SGrid2.RowCount-2 then SGrid2.RowCount:=SGrid2.RowCount-1;
   end;
end;

procedure TFrmBatchPause.edtHourKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'.. '9',#8,#13,'-']) then Key:=#0;
end;

end.

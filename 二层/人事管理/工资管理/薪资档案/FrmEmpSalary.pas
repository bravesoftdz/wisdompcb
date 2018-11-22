unit FrmEmpSalary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrideh, common, DB, ADODB, ExtCtrls, DBGrids;

type
  TSalaryFrm = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    lbl1: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblCode: TLabel;
    lblName: TLabel;
    lblDept: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh;State: TGridDrawState);
  private
    { Private declarations }
    dbgridehs: array of TDBGridEh;  //����DBGridEh�ؼ�
    qrys: array of TADOQuery;       //����ADOQuery�ؼ�
    dss: array of TDataSource;      //����DataSource�ؼ�
  public
    { Public declarations }
  end;

var
  SalaryFrm: TSalaryFrm;

implementation

uses damo;

{$R *.dfm}
procedure TSalaryFrm.DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  with  (Sender as TDBGridEh)do
  begin
    Canvas.Brush.Color := clMoneyGreen;
    DefaultDrawColumnCell(Rect, DataCol, Column, [gdFixed, gdFocused, gdSelected]);
  end;
end;

procedure TSalaryFrm.FormCreate(Sender: TObject);
var
  A, B, C, D: Array of String;  //����A���� datafield��B���� itemname, C�����������������ƴ�ӵ�SQL, D����˴β�ѯ������id
  IndexAB, IndexC, IndexD, i, j, k: Integer; //����������±�
  StrsTemp: string; //��ʼƴ�ӵ�SQL
begin
  lblCode.Caption := DM.qry1.FieldValues['Ա������'];
  lblName.Caption := DM.qry1.FieldValues['Ա������'];
  lblDept.Caption := DM.qry1.FieldValues['��������'];
  Screen.Cursor := crHourGlass;
  with DM.qrytemp do
  begin
    //��ѯ��Ա������н���д��ڵ���������
    Close;
    SQL.Clear;
    SQL.Text := 'select distinct accountid from V_employeebasicsalary ' + ' where employeecode = ' + QuotedStr(DM.qry1.FieldValues['Ա������']);
    Open;
    if not IsEmpty then
    begin
      Setlength(C, RecordCount);
      Setlength(D, RecordCount);
      IndexD := 0;
      First;
      for i := 0 to RecordCount - 1 do
      begin
        D[IndexD] := FieldValues['accountid'];
        with DM.qrytemp1 do
        begin
          //�����������Ͳ�ѯ����Ӧ��������������Ŀ�������Ŀ����
          close;
          SQL.Clear;
          SQL.Text := 'select datafield, itemname, accountid, salaryaccount.accountName '
            + 'from DesignSalaryItem '
            + 'inner join salaryaccount on DesignSalaryItem.accountid=salaryaccount.rkey '
            + 'where datasourcetype=2 and accountid in (' + DM.qrytemp.FieldByName('accountid').AsString + ')';
          Open;
          Setlength(A, RecordCount);
          Setlength(B, RecordCount);
          IndexAB := 0;
          First;
          While (Not Eof) Do
          begin
            A[IndexAB] := FieldByName('datafield').asString;
            B[IndexAB] := FieldByName('itemname').asString;
            Inc(IndexAB);
            Next;
          end;
          //ѭ���ۼӽ��ֶ�datafieldת��Ϊ�ֶ�itemname, ������Employeebasicsalary���datafield��ʾitemname��
          StrsTemp := '';
          for j := 0 to RecordCount - 1 do
          begin
            StrsTemp := StrsTemp + A[j] + ' as ' + B[j] + ',' ;
          end;
          StrsTemp := copy(StrsTemp, 1, length(StrsTemp) - 1);
        end;
        C[i] := StrsTemp; //�������׶�Ӧ����Ŀ����������ƴ�ӵ�SQL
        Inc(IndexD);
        DM.qrytemp.Next;
      end;
    end;
  end;
  Screen.Cursor := crDefault;
  SetLength(dbgridehs, Length(c));
  SetLength(qrys, Length(c));
  SetLength(dss, Length(c));
  IndexC := 0;
  for i := 0 to Length(c) - 1 do
  begin
    qrys[i] := TADOQuery.Create(nil);                //����ADOQuery�ؼ�
    qrys[i].Connection := DM.ADOConnection1;         //���ӵ�ADOConnection
    dss[i] := TDataSource.Create(nil);               //���� DataSource
    dss[i].DataSet := qrys[i];                       //��DataSource�󶨵�ADOQuery
    with qrys[i] do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'select salaryaccount.accountName as ''��������'', yearmonth ''�·�'', '
        + C[IndexC] + ' from V_employeebasicsalary '
        + 'inner join salaryaccount on V_employeebasicsalary.accountid = salaryaccount.rkey '
        + 'where employeecode = ' + QuotedStr( DM.qry1.FieldValues['Ա������'])
        + ' and accountid= ' + D[IndexC];
      Open;
      dbgridehs[IndexC] := TDBGridEh.Create(nil);
      if i = 0 then
      begin
        dbgridehs[i].Top := Panel1.Height + 1;
        dbgridehs[i].Height := Self.Height - Panel1.Height - 100;
      end
      else
      begin
        dbgridehs[i].Top := dbgridehs[i-1].Top + dbgridehs[i-1].Height +  1;
        dbgridehs[i-1].Height := 110;
        dbgridehs[i].Height := Self.Height - Panel1.Height - dbgridehs[i-1].Top - dbgridehs[i-1].Height;
      end;
      dbgridehs[i].Left := 10;
      dbgridehs[i].Width := Self.Width - 20;
      dbgridehs[i].Align := alTop;
      dbgridehs[i].OnDrawColumnCell := self.DrawColumnCell;
      if i = 0 then
      begin
        dbgridehs[i].Anchors := dbgridehs[i].Anchors + [akleft];
        dbgridehs[i].Anchors := dbgridehs[i].Anchors + [aktop];
        dbgridehs[i].Anchors := dbgridehs[i].Anchors + [akRight];
        dbgridehs[i].Anchors := dbgridehs[i].Anchors + [akBottom];
      end
      else
      begin
        dbgridehs[i-1].Anchors := dbgridehs[i].Anchors + [akleft];
        dbgridehs[i-1].Anchors := dbgridehs[i].Anchors + [aktop];
        dbgridehs[i-1].Anchors := dbgridehs[i].Anchors + [akRight];
        dbgridehs[i].Anchors := dbgridehs[i].Anchors + [aktop];
        dbgridehs[i].Anchors := dbgridehs[i].Anchors + [akBottom];
      end;
      dbgridehs[i].ReadOnly := True;
      dbgridehs[i].Parent := Self;
      dbgridehs[i].DataSource := dss[i];
      for k := 0 to dbgridehs[i].Columns.Count - 1 do
      begin
        if k > 1 then dbgridehs[i].Columns[k].Width := 85
        else dbgridehs[i].Columns[k].Width := 65;
      end;
      Inc(IndexC);
    end;
  end;
  Self.Height := dbgridehs[Length(dbgridehs)- 1].Top + dbgridehs[Length(dbgridehs)- 1].Height + 20;
end;

procedure TSalaryFrm.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TSalaryFrm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
  for i := 0 to Length(dbgridehs) - 1  do
  begin
    dbgridehs[i].Free;
    qrys[i].Free;
    dss[i].Free;
  end;
end;

end.

unit PasImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, ComCtrls,ADODB;

type
  TfrmImport = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    btnImSave: TBitBtn;
    btnImExit: TBitBtn;
    btnExport: TBitBtn;
    btnImport: TBitBtn;
    sgImport: TStringGrid;
    OpenDialog1: TOpenDialog;
    sgExport: TStringGrid;
    cbbTime: TComboBox;
    lbTime: TLabel;
    function SbctoDbc(s:string):string;
    procedure FormShow(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure btnImSaveClick(Sender: TObject);
  private
    { Private declarations }
    err:Boolean;
  public
    { Public declarations }
  end;

var
  frmImport: TfrmImport;

implementation

uses DAMO,common,ComObj;

{$R *.dfm}

function TfrmImport.SbctoDbc(s:string):string;
var nlength,i:Integer;
    strTxt,ctmp,C1,C2:string;
begin
  nlength:=Length(s);
  if (nlength=0) then Exit;
  strTxt:='';
  setlength(ctmp,nlength+1);
  ctmp:=s;
  i:=1;
  while (i<=nlength) do
  begin
    C1:=ctmp[i];
    C2:=ctmp[i+1];
    if (C1=#163) then
    begin
      strTxt:=strTxt+chr(ord(C2[1])-128);
      inc(i,2);
      continue;
    end;
    if (C1>#163) then
    begin
      strTxt:=strTxt+C1;
      strTxt:=strTxt+C2;
      inc(i,2);
      continue;
    end;
    if (C1=#161) and (C2=#161) then
    begin
      strTxt:=strTxt+' ';
      inc(i,2);
      continue;
    end;
    strTxt:=strTxt+C1;
    inc(i);
  end;
  Result:=strTxt;
end;

procedure TfrmImport.FormShow(Sender: TObject);
begin
  sgExport.Visible:=False;
  err:=False;
  with sgImport do
  begin
    sgImport.RowCount:=3;
    Cells[0,0]:='Ա������';
    Cells[1,0]:='��ѵ���';
    Cells[2,0]:='��ѵ����';
    Cells[3,0]:='��ʼ����';
    Cells[4,0]:='��ʼʱ��';
    Cells[5,0]:='��������';
    Cells[6,0]:='����ʱ��';
    Cells[7,0]:='��ѵʱ��(����)';
    Cells[8,0]:='��ѵ��ʦ';
    Cells[9,0]:='��ѵ�ص�';
    Cells[10,0]:='��ѵ�ɼ�';
    Cells[11,0]:='��ѵ���';
    Cells[12,0]:='��ѵ����';
    Cells[13,0]:='����״��(δ���/���)';
    Cells[14,0]:='��ѵ����';
    Cells[15,0]:='��ѵ����';
    Cells[16,0]:='������Ч��';
    Cells[17,0]:='�ؼ���λ';

    Cells[18,0]:='�γ̱��';
    Cells[19,0]:='�γ�����';

    //20171211add
    Cells[20,0]:='��ѵ���';
    Cells[21,0]:='��ѵ��ʽ';
    Cells[22,0]:='���˷�ʽ';

    Cells[0,1]:='10010';
    Cells[1,1]:='2013060001';
    Cells[2,1]:='��ѵר������';
    Cells[3,1]:='2013-10-01';
    Cells[4,1]:='9:30';
    Cells[5,1]:='2013-10-02';
    Cells[6,1]:='10:30';
    Cells[7,1]:='60';
    Cells[8,1]:='����';
    Cells[9,1]:='��¥������';
    Cells[10,1]:='98';
    Cells[11,1]:='�ϸ�';
    Cells[12,1]:='��ѵ����';
    Cells[13,1]:='���';
    Cells[14,1]:='ר��';
    Cells[15,1]:='100';
    Cells[16,1]:='2014-10-01';
    Cells[17,1]:='����ƬԱ';

    Cells[18,1]:='��ݸ������';
    Cells[19,1]:='��ݸ������';

    Cells[20,1]:='��ݸ������';
    Cells[21,1]:='��ݸ������';
    Cells[22,1]:='��ݸ������';



//    Cells[17,0]:='����˵��';
//    Cells[0,2]:='������һ��Ϊʵ��������������Ҫ���������������ĺ��ֱ���м����ð�ǣ����ڸ�ʽͳһΪ��YYYY-MM-DD����2013-10-01��ʱ�䵥Ԫ��ʽ����ʱ�����ͻ����ı�����ʱ�����ͱ�ʾ��21:00:00���ı���ʾʱ������9:00';
//    Cells[0,3]:='�ɼ������á���ѵʱ��(����)ֻ���������֣�����״��ֻ������(δ��ɻ����)����ѵ����ֻ������(��ͨ��ר������ְ����н��ѡ��һ)����ѵ����Ϊ��ͨʱ����ѵ�����������Ч�����ղ���᰸��ʼĬ�϶�Ϊδ�ᡣ';
  end;

  with sgExport do
  begin
    Cells[0,0]:='Ա������';
    Cells[1,0]:='��ѵ���';
    Cells[2,0]:='��ѵ����';
    Cells[3,0]:='��ʼ����';
    Cells[4,0]:='��ʼʱ��';
    Cells[5,0]:='��������';
    Cells[6,0]:='����ʱ��';
    Cells[7,0]:='��ѵʱ��(����)';
    Cells[8,0]:='��ѵ��ʦ';
    Cells[9,0]:='��ѵ�ص�';
    Cells[10,0]:='��ѵ�ɼ�';
    Cells[11,0]:='��ѵ���';
    Cells[12,0]:='��ѵ����';
    Cells[13,0]:='����״��(δ���/���)';
    Cells[14,0]:='��ѵ����';
    Cells[15,0]:='��ѵ����';
    Cells[16,0]:='������Ч��';
    Cells[17,0]:='�ؼ���λ';
    Cells[18,0]:='�γ̱��';
    Cells[19,0]:='�γ�����';
    Cells[20,0]:='��ѵ���';
    Cells[21,0]:='��ѵ��ʽ';
    Cells[22,0]:='���˷�ʽ';

    Cells[23,0]:='����';
    Cells[24,0]:='����˵��';
    

  end;
end;

procedure TfrmImport.btnExportClick(Sender: TObject);
begin
  Export_Grid_to_Excel(sgImport,Self.Caption,True);
end;

procedure TfrmImport.btnImportClick(Sender: TObject);
var
  excel:Variant;
  i,iCol:Integer;
  checktime:TDateTime;
  checkint:Integer;
  checkfloat:Double;
begin
  iCol:=1;

  OpenDialog1.Title:='��ѡ��Ҫ������ļ�';
  OpenDialog1.Filter:='*.xls|*.xls|*.xlsx|*.xlsx';
  OpenDialog1.DefaultExt:='xls';

  if OpenDialog1.Execute then
  begin
    btnImport.Enabled:=False;
    if sgImport.RowCount>2 then
    begin
      for i:=1 to sgImport.RowCount-2 do
        sgImport.Rows[i].Clear;
      sgImport.RowCount:=2;
    end;
    sgImport.Cursor:=crHourGlass;
    try
      excel:=CreateOleObject('Excel.Application');
      excel.visible:=False;
      excel.WorkBooks.open(OpenDialog1.FileName);
      for i:=2 to excel.activesheet.UsedRange.Rows.Count do
      begin
        with sgImport do
        begin
          if Trim((Trim(excel.activesheet.cells[i,iCol].value)))='' then
          begin
            Break;
          end
          else Cells[0,i-1]:=Trim(excel.activesheet.cells[i,iCol].value);

          if Trim(excel.activesheet.cells[i,iCol+1].value)='' then
          begin
            Cells[1,i-1]:=Trim(excel.activesheet.cells[i,iCol+1].value);
            Cells[24,i-1]:=Cells[24,i-1] + ' ��¼�д��ڿ�ֵ';
          end
          else Cells[1,i-1]:=Trim(excel.activesheet.cells[i,iCol+1].value);

          if Trim(excel.activesheet.cells[i,iCol+2].value)='' then
          begin
            Cells[2,i-1]:=Trim(excel.activesheet.cells[i,iCol+2].value);
            Cells[24,i-1]:=Cells[24,i-1] + ' ��¼�д��ڿ�ֵ ' ;
          end
          else Cells[2,i-1]:=Trim(excel.activesheet.cells[i,iCol+2].value);

          if not TryStrToDate(Trim(excel.activesheet.cells[i,iCol+3].value),checktime) then
          Cells[24,i-1]:=Cells[24,i-1] + ' ��ʼ���ڸ�ʽ���� '
          else Cells[3,i-1]:=FormatDateTime('yyyy-MM-dd',checktime);

  //        if not TryFloatToDateTime((StrToFloat(Trim(excel.activesheet.cells[i,iCol+4].value))),checktime) then Cells[19,i-1]:=Cells[19,i-1] + ' ��ʼʱ���ʽ���� '
  //        else Cells[4,i-1]:=FormatDateTime('hh:mm:ss',FloatToDateTime(StrToFloat(Trim(excel.activesheet.cells[i,iCol+4].value))));

          if not (TryStrToDateTime((Trim(excel.activesheet.cells[i,iCol+4].value)),checktime) or
                  TryFloatToDateTime((StrToFloat(Trim(excel.activesheet.cells[i,iCol+4].value))),checktime))
          then Cells[24,i-1]:=Cells[24,i-1] + ' ��ʼʱ���ʽ���� '
          else Cells[4,i-1]:=FormatDateTime('hh:mm:ss',checktime);

          if not TryStrToDate(Trim(excel.activesheet.cells[i,iCol+5].value),checktime) then
          Cells[24,i-1]:=Cells[24,i-1] + ' �������ڸ�ʽ���� '
          else Cells[5,i-1]:=FormatDateTime('yyyy-MM-dd',checktime);

  //        if not TryFloatToDateTime((StrToFloat(Trim(excel.activesheet.cells[i,iCol+6].value))),checktime) then Cells[19,i-1]:=Cells[19,i-1] + ' ����ʱ���ʽ���� '
  //        else Cells[6,i-1]:=FormatDateTime('hh:mm:ss',FloatToDateTime(StrToFloat(Trim(excel.activesheet.cells[i,iCol+6].value))));

          if not (TryStrToDateTime((Trim(excel.activesheet.cells[i,iCol+6].value)),checktime) or
                    TryFloatToDateTime((StrToFloat(Trim(excel.activesheet.cells[i,iCol+6].value))),checktime))
          then Cells[24,i-1]:=Cells[24,i-1] + ' ����ʱ���ʽ���� '
          else Cells[6,i-1]:=FormatDateTime('hh:mm:ss',checktime);

          if Trim(excel.activesheet.cells[i,iCol+7].value)='' then
          begin
            Cells[7,i-1]:=Trim(excel.activesheet.cells[i,iCol+7].value);
            Cells[24,i-1]:=Cells[24,i-1] + ' ��¼�д��ڿ�ֵ ';
          end
          else Cells[7,i-1]:=Trim(excel.activesheet.cells[i,iCol+7].value);

          if Trim(excel.activesheet.cells[i,iCol+8].value)='' then
          begin
            Cells[8,i-1]:=Trim(excel.activesheet.cells[i,iCol+8].value);
            Cells[24,i-1]:=Cells[24,i-1] + ' ��¼�д��ڿ�ֵ ' ;
          end
          else Cells[8,i-1]:=Trim(excel.activesheet.cells[i,iCol+8].value);

          if Trim(excel.activesheet.cells[i,iCol+9].value)='' then
          begin
            Cells[9,i-1]:=Trim(excel.activesheet.cells[i,iCol+9].value);
            Cells[24,i-1]:=Cells[24,i-1] + ' ��¼�д��ڿ�ֵ '  ;
          end
          else Cells[9,i-1]:=Trim(excel.activesheet.cells[i,iCol+9].value);

  //        if not  TryStrToInt(Trim(excel.activesheet.cells[i,iCol+10].value),checkint) then             // ��ѵ�ɼ�
  //        begin
  //          Cells[10,i-1]:=Trim(excel.activesheet.cells[i,iCol+10].value);
  //          Cells[19,i-1]:=Cells[19,i-1] + ' ��ѵ�ɼ����� ' ;
  //        end
  //        else
  //        begin
  //          if (checkint<0) or (checkint > 100) then
  //          begin
  //            Cells[10,i-1]:=Trim(excel.activesheet.cells[i,iCol+10].value);
  //            Cells[19,i-1]:=Cells[19,i-1] + ' ��ѵ�ɼ�������0-100֮�� ' ;
  //          end
  //          else Cells[10,i-1]:=Trim(excel.activesheet.cells[i,iCol+10].value);
  //        end;
          if Trim(excel.activesheet.cells[i,iCol+10].value)='' then
          begin
            Cells[10,i-1]:=Trim(excel.activesheet.cells[i,iCol+10].value);
            Cells[24,i-1]:=Cells[24,i-1] + ' ��¼�д��ڿ�ֵ '  ;
          end
          else Cells[10,i-1]:=Trim(excel.activesheet.cells[i,iCol+10].value);

          if Trim(excel.activesheet.cells[i,iCol+11].value)='' then                         //��ѵ���
          begin
            Cells[11,i-1]:=Trim(excel.activesheet.cells[i,iCol+11].value);
            Cells[24,i-1]:=Cells[24,i-1] + ' ��¼�д��ڿ�ֵ ' ;
          end
          else Cells[11,i-1]:=Trim(excel.activesheet.cells[i,iCol+11].value);

          if Trim(excel.activesheet.cells[i,iCol+12].value)='' then
          begin
            Cells[12,i-1]:=Trim(excel.activesheet.cells[i,iCol+12].value);                    //��ѵ����
            Cells[24,i-1]:=Cells[24,i-1] + ' ��¼�д��ڿ�ֵ ' ;
          end
          else Cells[12,i-1]:=Trim(excel.activesheet.cells[i,iCol+12].value);

          if Trim(excel.activesheet.cells[i,iCol+13].value)='���' then
           Cells[26,i-1]:='1'              //��ѵ״��
          else
          begin
            if Trim(excel.activesheet.cells[i,iCol+13].value)='δ���' then
             Cells[26,i-1]:='0'
            else Trim(excel.activesheet.cells[i,iCol+13].value) ;
          end;
            Cells[13,i-1]:=Trim(excel.activesheet.cells[i,iCol+13].value);

          if Trim(excel.activesheet.cells[i,iCol+14].value)='' then                               //��ѵ����
          begin
            Cells[14,i-1]:=Trim(excel.activesheet.cells[i,iCol+14].value);
            Cells[24,i-1]:=Cells[24,i-1] + ' ��¼�д��ڿ�ֵ ';
          end
          else Cells[14,i-1]:=Trim(excel.activesheet.cells[i,iCol+14].value);

          if Trim(excel.activesheet.cells[i,iCol+15].value)='' then
            Cells[15,i-1]:='0'
          else if not TryStrToFloat(Trim(excel.activesheet.cells[i,iCol+15].value),checkfloat) then      //��ѵ����
          begin
            Cells[15,i-1]:=Trim(excel.activesheet.cells[i,iCol+15].value);
            Cells[24,i-1]:=Cells[24,i-1] + ' ��ѵ�������� ';
          end
          else
            Cells[15,i-1]:=Trim(excel.activesheet.cells[i,iCol+15].value);

  //        if not TryStrToDate(Trim(excel.activesheet.cells[i,iCol+16].value),checktime) then        //ʧЧ����
  //        begin
  //          Cells[16,i-1]:=Trim(excel.activesheet.cells[i,iCol+16].value);
  //          Cells[19,i-1]:=Cells[19,i-1] + ' ��¼�д��ڿ�ֵ ';
  //        end
  //        else Cells[16,i-1]:=Trim(excel.activesheet.cells[i,iCol+16].value);
          Cells[16,i-1]:=Trim(excel.activesheet.cells[i,iCol+16].value);
          Cells[17,i-1]:=Trim(excel.activesheet.cells[i,iCol+17].value);
          Cells[18,i-1]:=Trim(excel.activesheet.cells[i,iCol+18].value);
          Cells[19,i-1]:=Trim(excel.activesheet.cells[i,iCol+19].value);

          Cells[20,i-1]:=Trim(excel.activesheet.cells[i,iCol+20].value);
          Cells[21,i-1]:=Trim(excel.activesheet.cells[i,iCol+21].value);
          Cells[22,i-1]:=Trim(excel.activesheet.cells[i,iCol+22].value);

          
          if Cells[24,i-1]<>'' then err:=True;
          RowCount:=RowCount+1;
  //        if i=n*t then
  //        begin
  //          ProgressBar1.Position:=10*t;
  //          Application.ProcessMessages;
  //          t:=t+1;
  //        end;
        end;
      end;
    finally
      excel.Quit;
      excel:=Unassigned;
      sgImport.Cursor:=crDefault;
    end;
    ShowMessage('�������');
    btnImport.Enabled:=True;
  end;
end;

procedure TfrmImport.btnImSaveClick(Sender: TObject);
var
  i,j,imrow,errrow,uprcount:Integer;
  daystr,Key:string;
//  checkdate:TDateTime;
  datebegin,timebegin,timeend:string;
//  grade:Extended;
begin
//  if cbbTime.ItemIndex=-1 then
//  begin
//    ShowMessage('����ѡ����ѵʱ��Σ�');
//    cbbTime.SetFocus;
//    exit;
//  end;
  imrow:=1;
  uprcount:=0;
  err:=False;
  case cbbTime.ItemIndex of
    0:
    begin
      timebegin:='08:00:00';
      timeend:='12:00:00';
    end;
    1:
    begin
      timebegin:='12:00:00';
      timeend:='16:00:00';
    end;
    2:
    begin
      timebegin:='16:30:00';
      timeend:='22:00:00';
    end;
  end;

  with DM.adoTmp do                               //�жϹ�������ѵ�����Ƿ���ȷ
  begin
    Close;
    SQL.Clear;
    SQL.Add('if exists(select * from tempdb.dbo.sysobjects where id = object_id(N''tempdb..#trainimport'') and type=''U'') '+ #13+
            'drop table #trainimport '+#13+
            'create table #trainimport(employeeid int,employeecode nvarchar(20),train_no varchar(50),train_topics nvarchar(50), '+
            ' startdate datetime,starttime varchar(20),enddate datetime,endtime varchar(20),train_time float, '+
            ' teacher nvarchar(50),train_place nvarchar(30),train_grade nvarchar(20),train_result nvarchar(20), '+
            ' train_content nvarchar(200),train_status int,train_feels money,effective_date datetime,oprator_ptr int, '+
            ' oprate_time datetime,traintype nvarchar(20),typeid int,feels_payed bit,ptr_flag bit,dbflag bit,deptid int,keyid int,KeyPosition varchar(40), '+
            'ccode varchar(20),cname varchar(30),PostID int,tc_ptr int,Ctype varchar(10),Ttype varchar(10),Etype varchar(10), CtypeiD int, TTYpeID int,ETYpeid int )');
     // ShowMessage(SQL.Text);
    ExecSQL;


    Close;
    SQL.Clear;
    for i:=1 to sgImport.RowCount-2 do
    begin
      if Length(sgImport.Cells[24,i])< 2 then
      begin
        if Trim(sgImport.Cells[16,i])='' then daystr:='null'
        else daystr:= QuotedStr(sgImport.Cells[16,i]);
        if Trim(sgImport.Cells[17,i])='' then Key:='null'
        else Key:= QuotedStr(sgImport.Cells[17,i]) ;
        SQL.Text:=SQL.Text+ 'insert into #trainimport values(0,'+ QuotedStr(sgImport.Cells[0,i])+','+ QuotedStr(sgImport.Cells[1,i])+','+ QuotedStr(sgImport.Cells[2,i])+','+
                  QuotedStr(sgImport.Cells[3,i])+','+ QuotedStr(sgImport.Cells[4,i])+','+ QuotedStr(sgImport.Cells[5,i])+','+QuotedStr(sgImport.Cells[6,i])+','+ sgImport.Cells[7,i]+','+
                  QuotedStr(sgImport.Cells[8,i])+','+QuotedStr(sgImport.Cells[9,i])+','+QuotedStr(sgImport.Cells[10,i])+','+ QuotedStr(sgImport.Cells[11,i])+','+
                  QuotedStr(sgImport.Cells[12,i])+','+sgImport.Cells[26,i]+','+ sgImport.Cells[15,i]+','+ daystr +','+ user_ptr+','+
                  QuotedStr(FormatDateTime('yyyy-MM-dd',getsystem_date(DM.adoTime,1)))+','+QuotedStr(sgImport.Cells[14,i])+',0,0,0,0,0,null,' +
                 Key+','+QuotedStr(sgImport.Cells[18,i])+','+QuotedStr(sgImport.Cells[19,i])+ ',0,0,'+QuotedStr(sgImport.Cells[20,i])+ ','+QuotedStr(sgImport.Cells[21,i])+ ' '+
                 ','+QuotedStr(sgImport.Cells[22,i])+ ',-1,-1,-1)';
      end;
    end;
    // ShowMessage(SQL.Text);
    if SQL.Text='' then
    begin
      ShowMessage('û�п��Ա�������ݣ���鿴��¼�����Ĵ���˵���Ƿ���ڴ��󣬸��������µ���');
      exit;
    end;
    ExecSQL;

    Close;
    SQL.Clear;
    SQL.Text:='update #trainimport set employeeid = employeemsg.rkey,typeid = datadetail.rkey,deptid = employeemsg.departmentid,tc_ptr=trainclass.rkey,postID=employeemsg.Position ' + #13+
                ',CtypeID=(case when #trainimport.ctype=''��ְ��ѵ''  then 0  when #trainimport.ctype=''��ǰ��ѵ''  then 1 when #trainimport.ctype=''�ڸ���ѵ''  then 2 else -1 end )'+  #13+
                ',TtypeID=(case when #trainimport.ttype=''��������''  then 0  when #trainimport.Ttype=''ʵ����ѵ''  then 1 when #trainimport.Ttype=''������ѵ''  then 2 else -1 end )'+  #13+
                ',EtypeID=(case when #trainimport.Etype=''���Կ���''  then 0  when #trainimport.Etype=''���Կ���''  then 1 when #trainimport.Etype=''ʵ�ٿ���''  then 2 when #trainimport.Etype=''���߿���''  then 3 else -1 end )'+  #13+
                'from #trainimport inner join employeemsg on #trainimport.employeecode=employeemsg.employeecode '+  #13+
                'inner join datadetail on #trainimport.traintype=datadetail.item '+#13+
                'left join trainclass  on #trainimport.ccode=trainclass.ccode   '+#13+
               // 'inner join datadetail d1  on #trainimport.ccode=trainclass.ccode   '+#13+
                'select * from #trainimport'; //employeeid,employeecode,train_no,traintype,typeid,dbflag
   // ShowMessage('1:'+SQL.Text);
    ExecSQL;
    Open;
    if not IsEmpty then
    begin
      First;
      while not Eof do
      begin
        if (FieldByName('employeeid').AsInteger<>0) and (FieldByName('typeid').AsInteger<>0) then
        begin
          with dm.adoTime do
          begin
            Close;
            SQL.Clear;
            SQL.Text:='select rkey,employeeid,Train_no from employee_train where employeeid ='+
                DM.adoTmp.FieldByName('employeeid').AsString +' and Train_no = '+
                QuotedStr(DM.adoTmp.FieldByName('train_no').AsString);
            Open;
            if not IsEmpty then
            begin
              with DM.adoTmp2 do
              begin
                Close;
                SQL.Clear;
                SQL.Text:='update #trainimport set dbflag=1 where employeeid ='+ DM.adoTmp.FieldByName('employeeid').AsString +' and train_no = '+ QuotedStr(DM.adoTmp.FieldByName('train_no').AsString);
                ExecSQL;
              end;
              sgImport.Cells[24,imrow]:=sgImport.Cells[24,imrow]+' ��¼�Ѿ����� ';
              err:=True;
            end;
          end;
          sgImport.Cells[25,imrow]:= FieldByName('employeeid').AsString;
          sgImport.Cells[27,imrow]:= FieldByName('typeid').AsString;
        end
        else
        begin
            sgImport.Cells[24,imrow]:=sgImport.Cells[24,imrow]+' ���Ż��������� ';
            err:=True;
        end;
        imrow:=imrow+1;
        Next;
      end;
    end;

    Close;
    SQL.Clear;
    SQL.Text:='update #trainimport set keyid = hr_KeyPosition.rkey ' + #13+
                'from #trainimport inner join hr_KeyPosition on #trainimport.deptid = hr_KeyPosition.deptid and #trainimport.KeyPosition = hr_KeyPosition.positionname '+  #13+
                'select * from #trainimport';
    ExecSQL;
    open;
    if not IsEmpty then
    begin
      imrow:=1;
      first;
      while not eof do
      begin

        if (FieldByName('cname').asstring <> '') and (FieldByName('tc_ptr').AsInteger=0) then
        begin
          sgImport.Cells[24,imrow]:=sgImport.Cells[24,imrow]+' �γ̱�Ż��������� ';
          err:=True;
        end;

        if (FieldByName('KeyPosition').asstring <> '') and (FieldByName('keyid').AsInteger=0) then
        begin
          sgImport.Cells[24,imrow]:=sgImport.Cells[24,imrow]+' �ؼ���λ���� ';
          err:=True;
        end;

        if (Trim(FieldByName('traintype').asstring) = '�ؼ���λ') and (FieldByName('keyid').AsInteger=0) then
        begin
          sgImport.Cells[24,imrow]:=sgImport.Cells[24,imrow]+' �ؼ���λ���� ';
          err:=True;
        end;
        imrow:=imrow+1;
        Next;
      end;
    end;

    Close;
    SQL.Clear;
    SQL.Text:='update #trainimport set dbflag=1 where traintype = ''�ؼ���λ'' and keyid =0' +
              'update #trainimport set keyid = null where traintype <> ''�ؼ���λ'' and keyid <>0';
    ExecSQL;
  end;

  try
    with DM.adoTmp do
    begin
      Close;
      SQL.Clear;
      SQL.Text:='select top 1 startdate from #trainimport' ;
      Open;
      if not IsEmpty then
      begin
        datebegin:=FieldByName('startdate').AsString;
      end;
    end;

    with DM.adoTmp do                                                                        //ͬ��ʱ��
    begin
      Close;
      SQL.Clear;
      SQL.Text:=' update #trainimport '+#13+
                ' set starttime=isnull(b.card_time,#trainimport.starttime),endtime=isnull(c.card_time,#trainimport.endtime) '+#13+
                ' from #trainimport left join (select * from employee_train_eastid  where flag=0 and card_date= '+ QuotedStr(datebegin)+ #13+
                ' and card_time between '+ QuotedStr(timebegin)+' and '+ QuotedStr(timeend)+') b on #trainimport.employeeid=b.employeeid and #trainimport.startdate=b.card_date '+ #13+
                ' left join (select * from employee_train_eastid a where flag=0 and a.rkey >( '+  #13+
                ' select top 1 rkey from employee_train_eastid where flag=0 and card_date='+ QuotedStr(datebegin)+'and card_time between '+ QuotedStr(timebegin)+' and '+ QuotedStr(timeend)+') '+ #13+
                ' and card_date='+ QuotedStr(datebegin) + ' and card_time between '+ QuotedStr(timebegin)+' and ' + QuotedStr(timeend)+')  c on #trainimport.employeeid=c.employeeid and #trainimport.startdate=c.card_date '+#13+
                ' select @@rowcount as rcount ';
//      ShowMessage(SQL.Text);
      ExecSQL;
      if not IsEmpty then  uprcount:= fieldByName('rcount').Value;

    end;
    if uprcount<>0 then
    begin
      with DM.adoTmp do                                                                      //������ѵʱ��
      begin
        Close;
        SQL.Clear;
        SQL.Text:=' update #trainimport '+#13+
                  ' set train_time= datediff(n,starttime,endtime)';    //�˴�������BUG���Ӵ����������
        ExecSQL;
      end;
    end;

    DM.ADOConnection1.BeginTrans;
    with DM.adoTmp do                                                                      //�Ѽ�¼����employee_train
    begin
      Close;
      SQL.Clear;
      SQL.Text:='insert into employee_train(employeeid, Train_NO, Train_topics, startdate, starttime, enddate, endtime, Train_time, Teacher, ' +
                'Train_place, Train_grade, Train_result, Train_content, Train_status, ptr_flag, type_ptr, train_feels, effective_date, ' +
                'feels_payed, oprator_ptr, oprate_time, employeecode,KeyPositionId,tc_ptr,DeptID,PostID,Ctype,TType,ETYpe)'+#13+
                'select employeeid,train_no,train_topics,startdate,starttime,enddate,endtime,train_time,teacher,train_place,train_grade, '+
                'train_result,train_content,train_status,ptr_flag,typeid,train_feels,effective_date,feels_payed,oprator_ptr,oprate_time,employeecode,keyid,tc_ptr,DeptID,PostID '+ #13+
                ',CtypeID,TTypeID,ETYpeID'+ #13+
                'from #trainimport where (employeeid <>0 and typeid <>0 ) and dbflag=0';
      ExecSQL;
    end;
//
    with DM.adoTmp do                                                                    //�� employee_train_eastid ��ʹ�ù���ʱ��flag���ó�1
    begin
      Close;
      SQL.Clear;
      SQL.Text:='update employee_train_eastid '+#13+
                'set flag=1 '+#13+
                'where rkey in (select top 2 rkey from employee_train_eastid where flag=0 and card_date = '+ QuotedStr(datebegin) +
                ' and card_time between '+ QuotedStr(timebegin)+' and '+ QuotedStr(timeend)+')' ;
//      ShowMessage(SQL.Text);
      ExecSQL;
    end;
//
//
    DM.ADOConnection1.CommitTrans;
//
    if err=True then
    begin
      if MessageDlg('��ȷ���ݵ�����ɣ��Ƿ񵼳��������ݣ�',mtInformation,[mbYes,mbNo],0)=mryes then
      begin
        errrow:=1;
        for i:=1 to sgImport.RowCount-2 do
        begin
          if Length(sgImport.Cells[24,i])>2 then
          begin
            for j:=0 to sgImport.ColCount-3 do
            begin
              sgExport.Cells[j,errrow]:=sgImport.Cells[j,i];
            end;
            errrow:=errrow+1;
            sgExport.RowCount:=sgExport.RowCount+1;
          end;
        end;
        Export_Grid_to_Excel(sgExport,'1',True);
      end;
    end;

    ModalResult:=mrYes;
  except
    on E: Exception do
    begin
      DM.ADOConnection1.RollbackTrans;
      messagedlg(E.Message,mterror,[mbcancel],0);
    end;
  end;

end;

end.

unit uNewForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Mask, DBCtrls, Grids, DBGrids, Buttons;

type
  TForm2 = class(TForm)
    DataSource1: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    BitBtn4: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    Label18: TLabel;
    BitBtn2: TBitBtn;
    Label9: TLabel;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    DataSource2: TDataSource;
    Edcitem: TEdit;
    Edunit: TEdit;
    EdCode: TEdit;
    Edname: TEdit;
    Edprice: TEdit;
    Edmax: TEdit;
    Edmin: TEdit;
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EdmaxKeyPress(Sender: TObject; var Key: Char);
    procedure EdcitemKeyPress(Sender: TObject; var Key: Char);
    procedure EdunitKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    mflag:boolean;  //�������޸ı�־
    munitrkey:integer;
    mcitemrkey:integer;
        
    function calsum():single;
    procedure update();
    function getCode(const pCode:string):boolean;
    function setTable(const msum:single):string;

    function setSQl(const msum:single):string;
  public
    { Public declarations }
    property Flag:boolean write mflag;
    property UnitKey:integer write munitrkey;
    property citemkey:integer write mcitemrkey;
  end;

var
  Form2: TForm2;

implementation

uses uCPCItem, uWZCPMain,uDM,uPublic;

{$R *.dfm}
//��ֵ����ǰ�޸ĵļ�¼
function TForm2.setTable(const msum:single):string;
var
 msql:string;
 begin
    msql:='update data0008';
    msql :=msql+' set ';
    msql:=msql+'prod_code=';
    msql :=msql +''''+ edcode.Text+''',';
    msql:=msql+' product_name=';
    msql:=msql+ ''''+ edname.Text+''',' ;
    msql:=msql+ 'pr_grp_pointer=';
    msql:=msql+ inttostr(mcitemrkey)+',';
    
    msql:=msql+'unit_ptr=';
    msql:=msql+inttostr(munitrkey)+',';
    msql:=msql+'new_price=';
     msql:=msql+edprice.Text+',';
    msql:=msql+'qty_onhand=';
    msql:=msql+floattostr(msum)+',';
    msql:=msql+'min_qty=';
    msql:=msql+edmin.Text+',';
    msql:=msql+'max_qty=';
    msql:=msql+edmax.Text ;
    msql:=msql+' where rkey=';
    msql:=msql+DataModule1.ADODataSet1RKEY.asstring;
    result:=msql;
 end;

//����SQL���
function TForm2.setSQl(const msum:single):string;
var
 msql:string;
 begin
    msql:='insert into data0008';
    msql :=msql+'(';
    msql:=msql+'prod_code,product_name,pr_grp_pointer,';
    msql:=msql+'unit_ptr,new_price,qty_onhand,';
    msql:=msql+'min_qty,max_qty';
    msql:=msql+')';
    msql:=msql+' values';
    msql:=msql+'(';
    msql :=msql +''''+ edcode.Text+''',';
    msql:=msql+ ''''+ edname.Text+''',' ;
    msql:=msql+ inttostr(mcitemrkey)+',';
    msql:=msql+inttostr(munitrkey)+',';
    msql:=msql+edprice.Text+',';
    msql:=msql+floattostr(msum)+',';
    msql:=msql+edmin.Text+',';
    msql:=msql+edmax.Text ;
    msql:=msql+')';
    result:=msql;
 end;
function TForm2.getCode(const pCode:string):boolean;
var
  mds:TADOdataset;
  aa:string;
begin
   //
   mds :=TADOdataset.Create(Application);
   mds.CommandType :=cmdtext;
        mds.Connection := DataModule1.ADOConnection1 ;
        mds.Active :=false;
        mds.CommandText :='SELECT * ';
        mds.CommandText :=mds.CommandText+' FROM  data0008 ';
        mds.CommandText :=mds.CommandText+' WHERE (prod_code = '''+pCode+''')';
        mds.Active :=true;
        if mds.Recordset.RecordCount >0 then
           result:=true
        else
        result:=false;
  mds.Free ;

end;
//�޸Ĳ�Ʒ�����
 procedure TForm2.update();
 begin
   try
     DataModule1.ADOConnection1.BeginTrans ;
     DataModule1.ADOConnection1.Execute(setTable(calsum),cmdtext); ;

     DataModule1.ADODSCW.First ;
     //���۱������Ѿ�����
     if self.DBGrid1.Enabled =true then
     begin
      while not DataModule1.ADODSCW.Eof do
        begin
          //DataModule1.ADOTBKCMX.IndexFieldNames :=' proc_ptr;location_ptr';

          if DataModule1.ADODSCWMAX_UNIT_VALUE.value>0 then

            begin
              DataModule1.ADOTBKCMX.Filter :=
              'proc_ptr='+DataModule1.ADODataSet1RKEY.AsString +' and location_ptr='+DataModule1.ADODSCWRKEY.AsString ;
              DataModule1.ADOTBKCMX.Active :=false;
              DataModule1.ADOTBKCMX.Active :=true;
              if DataModule1.ADOTBKCMX.RecordCount >0 then  //�޸�
                begin
                  DataModule1.ADOTBKCMX.edit ;       //�ֿ���ϸ
                  DataModule1.ADOTBKCMX.FieldByName('qty_on_hand').Value  :=DataModule1.ADODSCWMAX_UNIT_VALUE.value ;
                end
              else
                begin
                   DataModule1.ADOTBKCMX.Append ;       //�ֿ���ϸ
                   DataModule1.ADOTBKCMX.FieldByName('proc_ptr').AsInteger :=DataModule1.ADODataSet1RKEY.value ;
                   DataModule1.ADOTBKCMX.FieldByName('location_ptr').AsInteger :=DataModule1.ADODSCWRKEY.Value ;
                   DataModule1.ADOTBKCMX.FieldByName('qty_on_hand').Value  :=DataModule1.ADODSCWMAX_UNIT_VALUE.value ;
                end;  
            end//eof   DataModule1.ADODSCWMAX_UNIT_VALUE.value>0
            else
              begin
                DataModule1.ADOTBKCMX.Filter :=
                'proc_ptr='+DataModule1.ADODataSet1RKEY.AsString +' and location_ptr='+DataModule1.ADODSCWRKEY.AsString ;
                DataModule1.ADOTBKCMX.Active :=false;
                DataModule1.ADOTBKCMX.Active :=true;
                if DataModule1.ADOTBKCMX.RecordCount >0 then  //ɾ�����Ϊ0
                   DataModule1.ADOTBKCMX.Delete ;

              end;

          DataModule1.ADODSCW.Next ;
       end;   //end do
       dataModule1.ADOTBKCMX.Post;
     end;     //end dbgrid
       //DataModule1.ADOTable1.Post;             //�޸Ĳ�Ʒ
       DataModule1.ADOConnection1.CommitTrans;
     except
      DataModule1.ADOConnection1.RollbackTrans;
     end;
 end;
//�ϼƵ�ǰ���
function TForm2.calsum():single;
var
  msum:single;
 begin
      msum:=0;
      DataModule1.ADODSCW.First ;
      while not DataModule1.ADODSCW.Eof do
        begin
          if DataModule1.ADODSCWMAX_UNIT_VALUE.value>0 then
            begin
              msum :=msum+ DataModule1.ADODSCWMAX_UNIT_VALUE.value;

            end;//eof
          DataModule1.ADODSCW.Next ;
        end;  
      result:=msum;
 end;
//���Ҳ�Ʒ����
procedure TForm2.BitBtn4Click(Sender: TObject);
var
  mColumn:TColumn;
  i:integer;
begin
 try
 //��������

   DataModule1.ADOTabl_search.Active :=false;
   DataModule1.ADOTabl_search.Fields.Clear ;   
   DataModule1.ADOTabl_search.TableName  :='data0007';


  DataModule1.ADOTabl_search.Active :=true;

  formCitem:=TformCitem.Create(application);


  formCitem.DataSource1.DataSet :=DataModule1.ADOTabl_search;
    //�����ֶ�
  for i :=0 to  DataModule1.ADOTabl_search.Fields.Count -1 do
   begin
     if (formCitem.DBGrid1.Columns[i].DisplayName <>'PR_GRP_CODE') and
        (formCitem.DBGrid1.Columns[i].DisplayName<>'PRODUCT_GROUP_NAME') then
            formCitem.DBGrid1.Columns[i].Visible :=false
     else
          formCitem.DBGrid1.Columns[i].Visible :=true;
     if  formCitem.DBGrid1.Columns[i].DisplayName='PR_GRP_CODE' then
        begin
          formCitem.DBGrid1.Columns[i].Title.Caption :='����';
          formCitem.DBGrid1.Columns[i].Width :=100;
        end;
     if  formCitem.DBGrid1.Columns[i].Title.Caption ='PRODUCT_GROUP_NAME' then
        begin
          formCitem.DBGrid1.Columns[i].Title.Caption :='����';
          formCitem.DBGrid1.Columns[i].Width :=250;
        end;  
   end;
  formCitem.Label1.Caption :='��Ʒ���ͱ���';
  formCitem.Edit1.Text := trim(Edcitem.Text);
  if DataModule1.ADOTable1.IsEmpty then
   begin
    messagedlg('û���ҵ����������ļ�¼!',mtwarning,[mbok],0);
    Edcitem.SetFocus;
   end
  else
  if formCitem.ShowModal=mrok then
   begin
    //DBEdit3.Text := DataModule1.ADOTabl_search.FieldValues['PR_GRP_CODE'];
    Edcitem.Text := DataModule1.ADOTabl_search.FieldValues['PR_GRP_CODE'];
    Edcitem.Font.Color := clwindowtext;
    label18.Caption := DataModule1.ADOTabl_search.FieldValues['PRODUCT_GROUP_NAME'];
    //DataModule1.ADOTable1PR_GRP_POINTER.Value := DataModule1.ADOTabl_search.FieldValues['rkey'];
    mcitemrkey :=DataModule1.ADOTabl_search.FieldValues['rkey'];
    Edunit.SetFocus;
   end
  else
   Edcitem.SetFocus;
   formCitem.Edit1.Text :=''
 finally
  //formCitem.free;
 end;
end;
//�����λ
procedure TForm2.BitBtn2Click(Sender: TObject);
var
 // mColumn:TColumn;
  i:integer;
begin
 try
 //��������
   DataModule1.ADOTabl_search.Active :=false;
   DataModule1.ADOTabl_search.Fields.Clear ;
   DataModule1.ADOTabl_search.TableName  :='data0002';


  DataModule1.ADOTabl_search.Active :=true;


  formCitem:=TformCitem.Create(application);

  formCitem.DataSource1.DataSet :=DataModule1.ADOTabl_search;
    //�����ֶ�
  for i :=0 to  DataModule1.ADOTabl_search.Fields.Count -1 do
   begin
     if (formCitem.DBGrid1.Columns[i].DisplayName <>'UNIT_CODE') and
        (formCitem.DBGrid1.Columns[i].DisplayName<>'UNIT_NAME') then
            formCitem.DBGrid1.Columns[i].Visible :=false
     else
          formCitem.DBGrid1.Columns[i].Visible :=true;
     if  formCitem.DBGrid1.Columns[i].DisplayName='UNIT_CODE' then
        begin
          formCitem.DBGrid1.Columns[i].Title.Caption :='����';
         formCitem.DBGrid1.Columns[i].width :=100;
        end;
     if  formCitem.DBGrid1.Columns[i].Title.Caption ='UNIT_NAME' then
        begin
          formCitem.DBGrid1.Columns[i].Title.Caption :='����';
          formCitem.DBGrid1.Columns[i].width :=250;
        end;
   end;

  formCitem.Label1.Caption :='��Ʒ��λ����';
  formCitem.Edit1.Text := trim(Edunit.Text);


  if formCitem.ShowModal=mrok then
   begin
       if DataModule1.ADOTabl_search.IsEmpty then
         begin
            messagedlg('û���ҵ����������ļ�¼!',mtwarning,[mbok],0);
            Edunit.SetFocus;
            exit;
         end;
       //DBEdit4.Text := DataModule1.ADOTabl_search.FieldValues['UNIT_CODE'];
       Edunit.Text := DataModule1.ADOTabl_search.FieldValues['UNIT_CODE'];
       Edunit.Font.Color := clwindowtext;
       label9.Caption := DataModule1.ADOTabl_search.FieldValues['UNIT_NAME'];
       //DataModule1.ADOTable1unit_ptr.Value :=  DataModule1.ADOTabl_search.FieldValues['RKEY'];
       munitrkey :=DataModule1.ADOTabl_search.FieldValues['RKEY'];
       edmax.SetFocus;
   end
   else
   Edunit.SetFocus;
   formCitem.Edit1.Text :=''
 finally
  formCitem.free;
end;
end;
//����
procedure TForm2.BitBtn1Click(Sender: TObject);
var
  mrkey:integer;
  mds:TADOdataset;
begin
    if  Edcode.Text='' then
      begin
        showmessage('��Ʒ���벻��Ϊ�գ�����');
        Exit;
      end;
    if mflag =true then  //�Ƿ��ظ�
      begin
       if getCode(Edcode.Text)=true then
          begin
            showmessage('��Ʒ�����Ѿ����ڣ�����');
            Exit;
          end;
      end;
    if Edname.Text ='' then
       begin
        showmessage('��Ʒ���Ʋ���Ϊ�գ�����');
        Exit;
       end;
    if edcitem.Text ='' then
       begin
        showmessage('��Ʒ���Ͳ���Ϊ�գ�����');
        exit;
       end;
    if edunit.Text ='' then
       begin
        showmessage('��Ʒ��λ����Ϊ�գ�����');
        exit;
       end;
  if mflag =true then  //����
    begin
    try

     DataModule1.ADOConnection1.BeginTrans ;
     //DataModule1.ADOTable1qty_onhand.Value := calsum ;
     //showmessage(inttostr(DataModule1.ADOTable1.RecordCount));
     //showmessage('rkey:'+inttostr(DataModule1.ADOTable1RKEY.value));
     //DataModule1.ADOTable1.Post;             //������Ʒ
    // showmessage(inttostr(DataModule1.ADOTable1.RecordCount));
    // showmessage('rkey:'+inttostr(DataModule1.ADOTable1RKEY.value));

     DataModule1.ADOConnection1.Execute(setSQl(calsum),cmdtext);
      //�������ȡrkey
     mds :=TADOdataset.Create(Application);
     mds.CommandType :=cmdtext;
     mds.Connection := DataModule1.ADOConnection1 ;
     mds.CommandText :='select max(rkey) as rkey from data0008 ';
     mds.Active :=true;


     DataModule1.ADODSCW.First ;
     DataModule1.ADOTBKCMX.open;
      while not DataModule1.ADODSCW.Eof do
        begin
          if DataModule1.ADODSCWMAX_UNIT_VALUE.value>0 then
            begin
              DataModule1.ADOTBKCMX.Append ;       //�ֿ���ϸ
              DataModule1.ADOTBKCMX.FieldByName('proc_ptr').AsInteger :=mds.FieldByName('rkey').AsInteger; ;
              DataModule1.ADOTBKCMX.FieldByName('location_ptr').AsInteger :=DataModule1.ADODSCWRKEY.Value ;
              DataModule1.ADOTBKCMX.FieldByName('qty_on_hand').Value  :=DataModule1.ADODSCWMAX_UNIT_VALUE.value ;
              DataModule1.ADOTBKCMX.Post;
           // DataModule1.ADOTable1qty_onhand.Value :=DataModule1.ADOTable1qty_onhand.Value+ DataModule1.ADODSCWMAX_UNIT_VALUE.value;

            end;//eof
          DataModule1.ADODSCW.Next;
        end;
      DataModule1.ADOConnection1.CommitTrans;

      mrkey:=mds.FieldByName('rkey').AsInteger ;
      DataModule1.ADODataSet1.Active :=false ;
      DataModule1.ADODataSet1.active :=true;
      DataModule1.ADODataSet1.IndexFieldNames := 'rkey';
      DataModule1.ADODataSet1.Locate(DataModule1.ADODataSet1.IndexFieldNames,mrkey,[lopartialkey]);
      //����ɾ�����޸�
      if DataModule1.ADODataSet1.RecordCount =0 then
        begin
          Form1.n2.Enabled :=false;
          Form1.n3.Enabled :=false;
          Form1.BitBtn3.Enabled :=false;
          Form1.BitBtn4.Enabled :=false;
        end
     else
        begin
           Form1.n2.Enabled :=true;
           Form1.n3.Enabled :=true;
          Form1.BitBtn3.Enabled :=true;
          Form1.BitBtn4.Enabled :=true;
        end;
     except

        on E: Exception do
        begin
         showmessage(E.Message);
         DataModule1.ADOConnection1.RollbackTrans;
        end;
     end;
    end   //end����

  else
    begin

    update();  //�޸�
    mrkey:=DataModule1.ADODataSet1RKEY.AsInteger ;
    DataModule1.ADODataSet1.Active :=false ;
    DataModule1.ADODataSet1.active :=true;
    DataModule1.ADODataSet1.IndexFieldNames := 'rkey' ;
    DataModule1.ADODataSet1.Locate(DataModule1.ADODataSet1.IndexFieldNames,mrkey,[lopartialkey]);

    end;
 
    self.Close ;
end;
//�˳�
procedure TForm2.BitBtn3Click(Sender: TObject);
begin
    DataModule1.ADOTable1.active :=false;

    self.Close ;
end;
procedure TForm2.FormActivate(Sender: TObject);
var
    mstr:widestring;
    mTB:TADOTABLE;
    mi53,mi63:integer;
begin
     {if mflag =false then
        begin
          //���������
          mTB :=TADOTABLE.Create(self);
          mstr :='select * from data0053 where cust_part_ptr='+DataModule1.ADOTable1RKEY.AsString ;
          DataModule1.ADOConnection1.Execute(mstr,mi53);
          mstr :='select * from data0063 where part_batch_ptr='+DataModule1.ADOTable1RKEY.AsString ;
          DataModule1.ADOConnection1.Execute(mstr,mi63);
          IF (mi63 =0) and (mi63=0) then           //������δ�õ�
            begin
              //showmessage('���֡�����δ�õ�');
              self.DBGrid1.Enabled :=true;
            end
          else
            self.DBGrid1.Enabled :=false;
        end
      else
        self.DBGrid1.Enabled :=true;}
end;

procedure TForm2.EdmaxKeyPress(Sender: TObject; var Key: Char);
begin
 if  checkchar(TEdit(Sender).Text, key)=false then
    begin
      showmessage('�������ݲ��ԣ�����');
      abort;
    end;
end;

procedure TForm2.EdcitemKeyPress(Sender: TObject; var Key: Char);
begin
abort;
end;

procedure TForm2.EdunitKeyPress(Sender: TObject; var Key: Char);
begin
abort;
end;

end.

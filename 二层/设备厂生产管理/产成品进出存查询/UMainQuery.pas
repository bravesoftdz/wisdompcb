unit UMainQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, ExtCtrls, StdCtrls, Buttons, ComCtrls,DB, ADODB;

type
  TMain_Form = class(TForm)
    Panel1: TPanel;
    db_ptr: TLabel;
    vprev: TLabel;
    GroupBKC: TGroupBox;
    LbKC3: TLabel;
    LbKC2: TLabel;
    LbKC1: TLabel;
    DTPKC1: TDateTimePicker;
    EdKC: TEdit;
    DTPKC2: TDateTimePicker;
    BtKC: TButton;
    BitBtnKC: TBitBtn;
    ListBKC: TListBox;
    StaticText3: TStaticText;
    GroupBIn: TGroupBox;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    DTpk1: TDateTimePicker;
    Edit1: TEdit;
    DTPk2: TDateTimePicker;
    Button3: TButton;
    BitBtn6: TBitBtn;
    ListBox1: TListBox;
    StaticText7: TStaticText;
    GroupBOut: TGroupBox;
    LbOut3: TLabel;
    LbOut2: TLabel;
    LbOut1: TLabel;
    dtpOut1: TDateTimePicker;
    EdOut: TEdit;
    dtpOut2: TDateTimePicker;
    btOut: TButton;
    BitBtnOut: TBitBtn;
    ListBOut: TListBox;
    StaticText1: TStaticText;
    RadioGroup1: TRadioGroup;
    StaticText2: TStaticText;
    SGrid1: TStringGrid;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Button4: TButton;
    Button1: TButton;
    Button2: TButton;
    OutCBox1: TComboBox;
    RadioGroup3: TRadioGroup;
    RadioGroup2: TRadioGroup;
    RadioGroup4: TRadioGroup;
    DTTm2: TDateTimePicker;
    dttm1: TDateTimePicker;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    GroupBChange: TGroupBox;
    Label10: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Edit4: TEdit;
    DTPk7: TDateTimePicker;
    Button5: TButton;
    BitBtn7: TBitBtn;
    StaticText5: TStaticText;
    ListBChange: TListBox;
    RadioGroup5: TRadioGroup;
    DTpk8: TDateTimePicker;
    RGp4: TRadioGroup;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    GroupBox4: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox3: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure btOutClick(Sender: TObject);
    procedure BitBtnOutClick(Sender: TObject);
    procedure ListBOutClick(Sender: TObject);
    procedure ListBKCClick(Sender: TObject);
    procedure BitBtnKCClick(Sender: TObject);
    procedure BtKCClick(Sender: TObject);
    procedure ListBChangeClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Edit4KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RGp4Click(Sender: TObject);
  private
   v_Field_List_CN,v_Field_List_EN:Variant;
  procedure update_sgrid(sgrid_row: byte);
  procedure Outupdate_sgrid(const plisB:Tlistbox;const pEdit:TEdit;
pdtp1:TDateTimePicker;pdtp2:TDateTimePicker;sgrid_row: byte);
  procedure KCupdate_sgrid(const plisB:Tlistbox;const pEdit:TEdit;
pdtp1:TDateTimePicker;pdtp2:TDateTimePicker;sgrid_row: byte);
    { Private declarations }
  public
  function sumQuantity(const pDS:TADOQuery; const pField:string):single;
    { Public declarations }
  end;

var
  Main_Form: TMain_Form;

implementation

uses common, UGroupBIn, udm, UProItem, UYG, UOut, UST, ConstVar, Pick_Item_Single,
  UChange, PasInCollectQuery, PasOutCollectQuery;

{$R *.dfm}


procedure TMain_Form.FormCreate(Sender: TObject);
begin { }
 if not App_Init(dm.ADOConnection1) then
  begin
    ShowMsg('������ʧ��,����ϵ����Ա!',1);
    application.Terminate;
    exit;
  end;
  Caption := application.Title;

//   dm.ADOConnection1.Open;

  DateSeparator := '-';
  ShortDateFormat := 'yyyy-mm-dd';

  GroupBOut.Left:=GroupBKC.Left;
  GroupBOut.Top:= GroupBKC.Top;
  GroupBIn.Left:=GroupBKC.Left;
  GroupBIn.Top:= GroupBKC.Top;
  GroupBChange.Left:=GroupBKC.Left;
  GroupBChange.Top:= GroupBKC.Top;
  Self.Width:=590;
  Self.Height:=380;
end;

procedure TMain_Form.FormActivate(Sender: TObject);
begin
  RadioGroup1Click(nil);
  listbox1.Selected[0]:=true;
  dtpk1.Date:=date()-60;
  dtpk2.date:=date();
  dtpOut1.Date:=date()-60;
  dtpOut2.date:=date();
  DTPk7.Date:=date()-60;
  DTPk8.date:=date();
  sgrid1.Cells[0,0]:='������';
  sgrid1.Cells[1,0]:='����ֵ';
end;

function TMain_Form.sumQuantity(const pDS:TADOQuery;const pField:string):single;
var
  mQT:Single;
begin
  mQT :=0;
  pDS.First ;
   while not pDS.Eof do
    begin
     mQT:=mQT+pDS.FieldByName(pField).Value;
     pDS.Next;
    end;
  result:=mQT;
end;

procedure TMain_Form.BitBtn1Click(Sender: TObject);
var
  i:integer;
begin
  case radiogroup1.ItemIndex of
    0://���
    begin
      if sgrid1.RowCount=2 then
      begin
        messagedlg('�����ȶ����ѯ����!',mtinformation,[mbok],0);
        screen.Cursor:=crdefault;
        exit;
      end
      else
      begin
        if (RGp4.Items[RGp4.ItemIndex] = '��ϸ') then
        begin
          GroupBIn_Form:=tGroupBIn_Form.Create(application);
          with GroupBIn_Form.adoqin do
          begin
            close;
           //ȡ������
            for i:=1 to sgrid1.RowCount-2 do
            begin
              SQL.Text := SQL.Text +' and'+ sgrid1.Cells[2,i];
            end;
           open;
          end; //with end
          if GroupBIn_Form.adoqin.IsEmpty then
          begin
            messagedlg('û���ҵ���������������!',mtinformation,[mbok],0);
            screen.Cursor:=crdefault;
            exit;
          end;
          GroupBIn_Form.Edit1.Text:=FormatFloat('0.00',sumQuantity(GroupBIn_Form.adoqin,'QUANTITY'));
          GroupBIn_Form.ShowModal;
          GroupBIn_Form.free;
        end;// if end
        if (RGp4.Items[RGp4.ItemIndex] = '����') then
        begin
          FrmInCollectQuery:=TFrmInCollectQuery.Create(application);
          with FrmInCollectQuery.ADOQuery1 do
          begin
            close;
           //ȡ������
            sql.Insert(sql.Count - 3,' and ');
            for i:=1 to sgrid1.RowCount-2 do
            begin
              sql.Insert(sql.Count-3, sgrid1.Cells[2,i]);
              if i<>sgrid1.RowCount-2 then
              sql.Insert(sql.Count - 3,' and ')
            end;
//            ShowMessage(FrmInCollectQuery.ADOQuery1.SQL.Text);
            open;
          end; //with end
          if FrmInCollectQuery.ADOQuery1.IsEmpty then
          begin
            messagedlg('û���ҵ���������������!',mtinformation,[mbok],0);
            screen.Cursor:=crdefault;
            exit;
          end;
          FrmInCollectQuery.Edit1.Text:=FormatFloat('0.00',sumQuantity(FrmInCollectQuery.ADOQuery1,'QUANTITY'));
          FrmInCollectQuery.ShowModal;
          FrmInCollectQuery.free;
        end;
      end; //end else
   //�ϼ�
    end;//0

    1://����
    begin
      if sgrid1.RowCount=2 then
      begin
        messagedlg('�����ȶ����ѯ����!',mtinformation,[mbok],0);
        screen.Cursor:=crdefault;
      end
      else
      begin
        if (RGp4.Items[RGp4.ItemIndex] = '��ϸ') then
        begin
          FormOut:=tFormOut.Create(application);
          with FormOut.ADOQout do      //ȡ������
          begin
            close;
            //ShowMessage(FormOut.ADOQout.SQL.Text);
            sql.Insert(sql.Count,' and ');
            for i:=1 to sgrid1.RowCount-2 do
            begin
              sql.Insert(sql.Count, sgrid1.Cells[2,i]);
              if i<>sgrid1.RowCount-2 then
              sql.Insert(sql.Count ,' and ')
            end;
//            ShowMessage(FormOut.ADOQout.SQL.Text);
           open;
          end; //with end
          if FormOut.ADOQout.IsEmpty then
          begin
            messagedlg('û���ҵ���������������!',mtinformation,[mbok],0);
            screen.Cursor:=crdefault;
            exit;
          end;
           FormOut.Edit1.Text:=FormatFloat('0.00',sumQuantity(FormOut.ADOQout,'quantity'));
           FormOut.Edit2.Text:=FormatFloat('0.00',sumQuantity(FormOut.ADOQout,'CPTatal'));
           //FormOut.Edit2.Text:=FormOut.DBGridEh1.GetFooterValue(0, FormOut.DBGridEh1.Columns[11]);
           FormOut.ShowModal;
           FormOut.free;
        end;// else end
        if (RGp4.Items[RGp4.ItemIndex] = '����') then
        begin
          FrmOutCollectQuery:=TFrmOutCollectQuery.Create(application);
          with FrmOutCollectQuery.ADOQuery1 do      //ȡ������
          begin
            close;
            sql.Insert(sql.Count - 3,' and ');
            for i:=1 to sgrid1.RowCount-2 do
            begin
              sql.Insert(sql.Count-3, sgrid1.Cells[2,i]);
              if i<>sgrid1.RowCount-2 then
              sql.Insert(sql.Count - 3,' and ')
            end;
//            ShowMessage(FrmOutCollectQuery.ADOQuery1.SQL.Text);
           open;
          end; //with end
          if FrmOutCollectQuery.ADOQuery1.IsEmpty then
          begin
            messagedlg('û���ҵ���������������!',mtinformation,[mbok],0);
            screen.Cursor:=crdefault;
            exit;
          end;
           FrmOutCollectQuery.Edit1.Text:=FormatFloat('0.00',sumQuantity(FrmOutCollectQuery.ADOQuery1,'quantity'));
//           FrmOutCollectQuery.Edit2.Text:=FormatFloat('0.00',sumQuantity(FrmOutCollectQuery.ADOQuery1,'CPTatal'));
           FrmOutCollectQuery.Edit2.Text:=FrmOutCollectQuery.DBGridEh1.GetFooterValue(0, FrmOutCollectQuery.DBGridEh1.Columns[5]);
           FrmOutCollectQuery.ShowModal;
           FrmOutCollectQuery.free;
        end;
      end;//1
    end;

    2://���
    begin
//      if sgrid1.RowCount=2 then
//      begin
//        messagedlg('�����ȶ����ѯ����!',mtinformation,[mbok],0);
//        screen.Cursor:=crdefault;
//      end
//      else
      begin
        St_Form:=tSt_Form.Create(application);
        with St_Form.ADOQSt do
        begin
          close;
          //ȡ������
          for i:=1 to sgrid1.RowCount-2 do
          begin
            sql.Insert(sql.Count,sgrid1.Cells[2,i]);
          end;
          sql.Insert(sql.Count,' and dbo.WZCP0001.qty_on_hand>0');
    //      ShowMessage(sql.Text)      ;
          open;
        end; //with end
 
        if St_Form.ADOQSt.IsEmpty then
        begin
          messagedlg('û���ҵ���������������!',mtinformation,[mbok],0);
          screen.Cursor:=crdefault;
          exit;
        end;
   //�ϼ�
        St_Form.Edit1.Text:=floattostr(sumQuantity(St_Form.ADOQSt,'qty_on_hand'));

        St_Form.ShowModal;
        St_Form.free;
      end;// else end
    end;//2

    3://ת��
    begin
      if sgrid1.RowCount=2 then
      begin
        messagedlg('�����ȶ����ѯ����!',mtinformation,[mbok],0);
        screen.Cursor:=crdefault;
      end
      else
      begin
        frmChange:=TfrmChange.Create(application);
        with frmChange.ADOQChange do      //ȡ������
        begin
          close;
          for i:=1 to sgrid1.RowCount-2 do
          begin
            sql.Insert(sql.Count-1,sgrid1.Cells[2,i]);
            if i<>sgrid1.RowCount-2 then
          end;
     //showmessage(sql.Text);

         open;
        end; //with end
        if frmChange.ADOQChange.IsEmpty then
        begin
          messagedlg('û���ҵ���������������!',mtinformation,[mbok],0);
          screen.Cursor:=crdefault;
          exit;
        end;
   //�ϼ�
       frmChange.Edit1.Text:=floattostr(sumQuantity(frmChange.ADOQChange,'quantity'));

       frmChange.ShowModal;
       frmChange.free;
      end;// else end
    end;
  end;//end case
end;

procedure TMain_Form.Button4Click(Sender: TObject);
var
 i:byte;
begin
  if (sgrid1.RowCount <= 2) or (sgrid1.Row=sgrid1.RowCount-1) then exit;
  for i:=sgrid1.Row to sgrid1.RowCount-2 do sgrid1.Rows[i].Text:=sgrid1.Rows[i+1].Text;
  sgrid1.RowCount:=sgrid1.RowCount-1;
end;

procedure TMain_Form.Button2Click(Sender: TObject);
var
 i:byte;
begin
  if (sgrid1.RowCount <= 2) or (sgrid1.Row=sgrid1.RowCount-1) then exit;
  for i:=sgrid1.Row to sgrid1.RowCount-2 do sgrid1.Rows[i].Text:=sgrid1.Rows[i+1].Text;
  sgrid1.RowCount:=sgrid1.RowCount-1;
end;

procedure TMain_Form.Button1Click(Sender: TObject);
var
 i:byte;
begin
  if (sgrid1.RowCount <= 2) or (sgrid1.Row=sgrid1.RowCount-1) then exit;
  for i:=sgrid1.Row to sgrid1.RowCount-2 do sgrid1.Rows[i].Text:=sgrid1.Rows[i+1].Text;
  sgrid1.RowCount:=sgrid1.RowCount-1;
end;


procedure TMain_Form.BitBtn3Click(Sender: TObject);
begin
 application.Terminate;
 close;
end;

procedure TMain_Form.BitBtn2Click(Sender: TObject);
var
 i:byte;
begin
 for i:=1 to sgrid1.RowCount-1 do
    sgrid1.Rows[i].Clear;
    sgrid1.RowCount:=2;
end;

procedure TMain_Form.PopupMenu1Popup(Sender: TObject);
begin
  if sgrid1.Row=sgrid1.RowCount-1  then
    n1.Enabled :=false
  else
    n1.Enabled :=true;
end;

procedure TMain_Form.ListBox1Click(Sender: TObject);
begin
  if (RGp4.Items[RGp4.ItemIndex] = '��ϸ') then
  begin
    label1.Caption:=listbox1.Items[listbox1.itemindex];
    label1.Top:=40;
    Label1.Left:=95;
    edit1.Left:=95;
    Edit1.Top:= Label1.Top + Label1.Height+5;
    BitBtn6.Top:= Edit1.Top;
    BitBtn6.Left:= Edit1.Left+Edit1.Width+2;
    edit1.Text:='';
    ComboBox1.Visible:=False;
    case listbox1.ItemIndex of
    0: //��Ʒ����
    begin
      label1.visible :=true;
      edit1.Visible:=true;
      bitbtn6.Visible:=true;
      dtpk1.Visible :=false;
      dtpk2.Visible :=false;
      Label2.Visible:=false;
      Label3.Visible:=false;
      dttm1.Visible:=false;
      dttm2.Visible:=false;
      RadioGroup3.Visible :=true;
      edit1.SetFocus;
    end;
    1: //��Ʒ����
    begin
      label1.visible :=true;
      edit1.Visible:=true;
      bitbtn6.Visible:=false;
      dtpk1.Visible :=false;
      dtpk2.Visible :=false;
      Label2.Visible:=false;
      Label3.Visible:=false;
      dttm1.Visible:=false;
      dttm2.Visible:=false;
      RadioGroup3.Visible :=true;
      edit1.SetFocus;
    end;
    2://��Ʒ����
    begin
      label1.visible :=true;
      edit1.Visible:=true;
      bitbtn6.Visible:=false;
      dtpk1.Visible :=false;
      dtpk2.Visible :=false;
      Label2.Visible:=false;
      Label3.Visible:=false;
      dttm1.Visible:=false;
      dttm2.Visible:=false;
      RadioGroup3.Visible :=true;
      edit1.SetFocus;
    end;
    3: //����
    begin
      label1.visible :=true;
      edit1.Visible:=true;
      bitbtn6.Visible:=false;
      dtpk1.Visible :=false;
      dtpk2.Visible :=false;
      Label2.Visible:=false;
      Label3.Visible:=false;
      dttm1.Visible:=false;
      dttm2.Visible:=false;
      RadioGroup3.Visible :=true;
      edit1.SetFocus;
    end;
    4: //���
    begin
      label1.visible :=true;
      edit1.Visible:=true;
      bitbtn6.Visible:=false;
      dtpk1.Visible :=false;
      dtpk2.Visible :=false;
      Label2.Visible:=false;
      Label3.Visible:=false;
      dttm1.Visible:=false;
      dttm2.Visible:=false;
      edit1.SetFocus;
      RadioGroup3.Visible :=true;
    end;
    5: //����
    begin
      bitbtn6.Visible:=false;
      edit1.Visible:=false;
      Label2.Visible :=true;
      with dtpk1 do
      begin
        Top:=  Label2.Top+Label2.Height+     5;
        Left:= Label2.Left;
        Visible :=true;
        dttm1.Top:=Top;
        dttm1.Left:=Label2.Left+ dtpk1.Width +2;
        dttm1.Visible:=true;
      end;
      with Label3 do
      begin
        Top:=  dtpk1.Top+dtpk1.Height+     10;
        Left:= dtpk1.Left;
        Visible :=true;
      end;
      with dtpk2 do
      begin
        Top:=  Label3.Top+Label3.Height+     5;
        Left:= Label3.Left;
        Visible :=true;
        dttm2.Top:=Top;
        dttm2.Left:= Width +2;
        dttm2.Left:=Label2.Left+ Width +2;
        dttm2.Visible:=true;
      end;
      Label3.Visible :=true;
      label1.Visible :=false;
    //  dtpk1.Visible :=true;
    //  dtpk2.Visible :=true;
    //  dttm1.Visible:=true;
    //  dttm2.Visible:=true;
      RadioGroup3.Visible :=false;
    end;
    6: //�����Ա
    begin
      label1.Visible :=true;
      bitbtn6.Visible:=true;
      edit1.Visible:=true;
      RadioGroup3.Visible :=true;
      edit1.SetFocus;
      Label2.Visible :=false;
      Label3.Visible :=false;
      dtpk1.Visible :=false;
      dtpk2.Visible :=false;
      dttm1.Visible:=false;
      dttm2.Visible:=false;
    end;

    7: // �ֿ�����
    begin
      label1.Visible :=true;
      bitbtn6.Visible:=true;
      edit1.Visible:=true;
      RadioGroup3.Visible :=true;
      edit1.SetFocus;
      Label2.Visible :=false;
      Label3.Visible :=false;
      dtpk1.Visible :=false;
      dtpk2.Visible :=false;
      dttm1.Visible:=false;
      dttm2.Visible:=false;
    end;

    8: // ���첿��
    begin
      label1.Visible :=true;
      bitbtn6.Visible:=true;
      edit1.Visible:=true;
      Label2.Visible :=false;
      Label3.Visible :=false;
      dtpk1.Visible :=false;
      dtpk2.Visible :=false;
      dttm1.Visible:=false;
      dttm2.Visible:=false;
      RadioGroup3.Visible :=true;
      edit1.SetFocus;
    end;

    9: // ��������
    begin
      label1.Visible :=true;
      bitbtn6.Visible:=false;
      edit1.Visible:=true;
      Label2.Visible :=false;
      Label3.Visible :=false;
      dtpk1.Visible :=false;
      dtpk2.Visible :=false;
      dttm1.Visible:=false;
      dttm2.Visible:=false;
      RadioGroup3.Visible :=true;
      edit1.SetFocus;
    end;
    10: // ��������
    begin
      label1.visible :=true;
      edit1.Visible:=true;
      bitbtn6.Visible:=true;
      dtpk1.Visible :=false;
      dtpk2.Visible :=false;
      Label2.Visible:=false;
      Label3.Visible:=false;
      dttm1.Visible:=false;
      dttm2.Visible:=false;
      RadioGroup3.Visible :=true;
      ComboBox1.Visible:=False;
      edit1.SetFocus;
    end;
    end;
  end;
  if (RGp4.Items[RGp4.ItemIndex] = '����') then
  begin
    label1.Caption:=listbox1.Items[listbox1.itemindex];
    label1.Top:=40;
    Label1.Left:=95;
    edit1.Left:=95;
    Edit1.Top:= Label1.Top + Label1.Height+5;
    BitBtn6.Top:= Edit1.Top;
    BitBtn6.Left:= Edit1.Left+Edit1.Width+2;
    edit1.Text:='';
    ComboBox1.Visible:=False;
    case listbox1.ItemIndex of
    0: //
    begin
      label1.Visible :=true;
      bitbtn6.Visible:=true;
      edit1.Visible:=true;
      RadioGroup3.Visible :=true;
      edit1.SetFocus;
      Label2.Visible :=false;
      Label3.Visible :=false;
      dtpk1.Visible :=false;
      dtpk2.Visible :=false;
      dttm1.Visible:=false;
      dttm2.Visible:=false;
    end;
    1: //��Ʒ����
    begin
      bitbtn6.Visible:=false;
      edit1.Visible:=false;
      Label2.Visible :=true;
      with dtpk1 do
      begin
        Top:=  Label2.Top+Label2.Height+     5;
        Left:= Label2.Left;
        Visible :=true;
        dttm1.Top:=Top;
        dttm1.Left:=Label2.Left+ dtpk1.Width +2;
        dttm1.Visible:=true;
      end;
      with Label3 do
      begin
        Top:=  dtpk1.Top+dtpk1.Height+     10;
        Left:= dtpk1.Left;
        Visible :=true;
      end;
      with dtpk2 do
      begin
        Top:=  Label3.Top+Label3.Height+     5;
        Left:= Label3.Left;
        Visible :=true;
        dttm2.Top:=Top;
        dttm2.Left:= Width +2;
        dttm2.Left:=Label2.Left+ Width +2;
        dttm2.Visible:=true;
      end;
      Label3.Visible :=true;
      label1.Visible :=false;
      RadioGroup3.Visible :=false;
    end;
    2://��Ʒ����
    begin
      label1.Visible :=true;
      bitbtn6.Visible:=true;
      edit1.Visible:=true;
      RadioGroup3.Visible :=true;
      edit1.SetFocus;
      Label2.Visible :=false;
      Label3.Visible :=false;
      dtpk1.Visible :=false;
      dtpk2.Visible :=false;
      dttm1.Visible:=false;
      dttm2.Visible:=false;
    end;
    3: // ��������
    begin
      label1.visible :=true;
      edit1.Visible:=true;
      bitbtn6.Visible:=true;
      dtpk1.Visible :=false;
      dtpk2.Visible :=false;
      Label2.Visible:=false;
      Label3.Visible:=false;
      dttm1.Visible:=false;
      dttm2.Visible:=false;
      RadioGroup3.Visible :=true;
      ComboBox1.Visible:=False;
      edit1.SetFocus;
    end;
    4:// �������
    begin
      label1.visible :=True;
      edit1.Visible:=false;
      bitbtn6.Visible:=false;
      dtpk1.Visible :=false;
      dtpk2.Visible :=false;
      Label2.Visible:=false;
      Label3.Visible:=false;
      dttm1.Visible:=false;
      dttm2.Visible:=false;
      RadioGroup3.Visible :=true;
      ComboBox1.Visible:=True;
    end;
    end;
  end;
end;

procedure TMain_Form.RadioGroup1Click(Sender: TObject);
var i:Integer;
begin
BitBtn2Click(nil);
  if RadioGroup1.Items[RadioGroup1.ItemIndex] = '��Ʒ���' then
  begin
   GroupBIn.Visible :=true;
   GroupBout.Visible :=false;
   GroupBKC.Visible :=false;
   GroupBChange.Visible:= False;
   //��ʼ��
    ListBox1.Items.Clear;
    v_Field_List_CN := VarArrayOf(['��Ʒ����','��Ʒ����','��Ʒ����','��Ʒ���','��ⵥ��','�������','�����Ա','�ֿ�����','���첿��','��������','��������']);
    v_Field_List_EN := VarArrayOf(['Data0007.PR_GRP_CODE','Data0008.PROD_CODE','Data0008.PRODUCT_NAME','Data0008.PRODUCT_DESC','Data0416.number','Data0416.sys_date','Data0005.EMPL_CODE','Data0016.CODE','Data0034.DEPT_CODE','Data0492.CUT_NO','Data0416.warehouse_ptr']);
    for i:= VarArrayLowBound(v_Field_List_CN,1) to VarArrayHighBound(v_Field_List_CN,1) do
      ListBox1.Items.Add(v_Field_List_CN[i]);
   listbox1.itemindex :=0;
   edit1.Text :='';
   Self.ListBox1Click(Sender);
   RGp4.Visible:=True;
   RGp4.ItemIndex:=0;
  end;
  if RadioGroup1.Items[RadioGroup1.ItemIndex] = '��Ʒ����' then
    begin
      GroupBIn.Visible :=false;
      GroupBout.Visible :=true;
      GroupBKC.Visible :=false;
      GroupBChange.Visible:= False;
      ComboBox2.Visible:=False;
        ListBOut.Items.Clear;
        v_Field_List_CN := VarArrayOf(['��Ʒ����','��Ʒ����','��Ʒ����','��Ʒ���','���ⵥ��','��������','�����������','������Ա','�ֿ�����','�ͻ�����','��������','��������']);
       // v_Field_List_EN := VarArrayOf(['Data0007.PR_GRP_CODE','Data0008.PROD_CODE','Data0008.PRODUCT_NAME','Data0008.PRODUCT_DESC','WZCP0060.sales_order','wzcp0060.sales_date','wzcp0060.CONF_DATE','Data0005.EMPL_CODE','Data0016.CODE','Data0010.CUST_CODE','wzcp0060.type','data0492.CUT_NO']);
        v_Field_List_EN := VarArrayOf(['Data0007.PR_GRP_CODE','Data0008.PROD_CODE','Data0008.PRODUCT_NAME','Data0008.PRODUCT_DESC','WZCP0060.sales_order','wzcp0063.sales_date','wzcp0060.CONF_DATE','Data0005.EMPL_CODE','Data0016.CODE','Data0010.CUST_CODE','wzcp0060.type','data0492.CUT_NO']);
        for i:= VarArrayLowBound(v_Field_List_CN,1) to VarArrayHighBound(v_Field_List_CN,1) do
          ListBOut.Items.Add(v_Field_List_CN[i]);
      listbout.itemindex :=0;
      edout.Text :='';
      Self.ListBOutClick(Sender);
      RGp4.Visible:=True;
      RGp4.ItemIndex:=0;
    end;
  if RadioGroup1.Items[RadioGroup1.ItemIndex] = '��Ʒ���' then
    begin
      GroupBIn.Visible :=false;
      GroupBout.Visible :=false;
      GroupBKC.Visible :=true;
      GroupBChange.Visible:= False;
      listbKC.itemindex :=0;
      edKC.Text :='';
      Self.ListBKCClick(sender);
      RGp4.Visible:=False;
    end;
  if RadioGroup1.Items[RadioGroup1.ItemIndex] = '��Ʒת��' then
    begin
      GroupBIn.Visible :=false;
      GroupBout.Visible :=false;
      GroupBKC.Visible :=false;
      GroupBChange.Visible:= True;
      ListBChange.itemindex :=0;
      Edit4.Text :='';
      Self.ListBChangeClick(sender);
      RGp4.Visible:=False;
    end;
end;

procedure TMain_Form.update_sgrid(sgrid_row: byte);
begin
 sgrid1.Cells[0,sgrid_row]:=listbox1.Items[listbox1.itemindex];
 sgrid1.Cells[1,sgrid_row]:=edit1.Text;
  if (RGp4.Items[RGp4.ItemIndex] = '��ϸ') then
  begin
    case listbox1.ItemIndex of
    0:   //��Ʒ����
    case radiogroup3.ItemIndex of
     0: sgrid1.Cells[2,sgrid_row]:=' Data0007.PR_GRP_CODE  = '''+trim(edit1.Text)+'''';
     1: sgrid1.Cells[2,sgrid_row]:=' Data0007.PR_GRP_CODE  LIKE ''%'+trim(edit1.Text)+'%''';
    end;
    1:   //��Ʒ����
    case radiogroup3.ItemIndex of
      0:  sgrid1.Cells[2,sgrid_row]:=' Data0008.PROD_CODE = '''+trim(edit1.Text)+'''';
      1:  sgrid1.Cells[2,sgrid_row]:=' Data0008.PROD_CODE LIKE ''%'+trim(edit1.Text)+'%''';
    end;
    2:   //��Ʒ����
    case radiogroup3.ItemIndex of
     0: sgrid1.Cells[2,sgrid_row]:=' Data0008.PRODUCT_NAME = '''+trim(edit1.Text)+'''';
     1: sgrid1.Cells[2,sgrid_row]:=' Data0008.PRODUCT_NAME LIKE ''%'+trim(edit1.Text)+'%''';
    end;
    3:   //��Ʒ���
    case radiogroup3.ItemIndex of
      0: sgrid1.Cells[2,sgrid_row]:=' Data0008.PRODUCT_DESC = '''+trim(edit1.Text)+'''';
      1:sgrid1.Cells[2,sgrid_row]:=' Data0008.PRODUCT_DESC LIKE ''%'+trim(edit1.Text)+'%''';
    end;
    4:   //��ⵥ��
      case radiogroup3.ItemIndex of
        0: sgrid1.Cells[2,sgrid_row]:=' Data0416.number = '''+trim(edit1.Text)+'''';
        1:sgrid1.Cells[2,sgrid_row]:=' Data0416.number LIKE ''%'+trim(edit1.Text)+'%''';
     end;
    5://����
    begin
     sgrid1.Cells[1,sgrid_row]:='��'+datetostr(dtpk1.date)+'��'+datetostr(dtpk2.date);
     sgrid1.Cells[2,sgrid_row]:=
     '  Data0416.sys_date>='''+FormatDateTime('yyyy-MM-dd',dtpk1.date)+' '+FormatDateTime('HH:MM:SS',dtpk1.Time)+''''+#13
     +' and Data0416.sys_date<='''+FormatDateTime('yyyy-MM-dd',dtpk2.date)+' '+FormatDateTime('HH:MM:SS',dtpk2.Time)+'''';
    end;
    6://���Ա��
    case radiogroup3.ItemIndex of
     0: sgrid1.Cells[2,sgrid_row]:=' Data0005.EMPL_CODE = '''+trim(edit1.Text)+'''';
     1: sgrid1.Cells[2,sgrid_row]:=' Data0005.EMPL_CODE LIKE ''%'+trim(edit1.Text)+'%''';
     end;
    7://�ֿ�
    case radiogroup3.ItemIndex of
     0: sgrid1.Cells[2,sgrid_row]:=' Data0016.CODE = '''+trim(edit1.Text)+'''';
     1: sgrid1.Cells[2,sgrid_row]:=' Data0016.CODE LIKE ''%'+trim(edit1.Text)+'%''';
     end;
    8://���첿��
    case radiogroup3.ItemIndex of
      0: sgrid1.Cells[2,sgrid_row]:=' Data0034.DEPT_CODE = '''+trim(edit1.Text)+'''';
      1: sgrid1.Cells[2,sgrid_row]:=' Data0034.DEPT_CODE LIKE ''%'+trim(edit1.Text)+'%''';
    end;
    9://��������
     case radiogroup3.ItemIndex of
        0: sgrid1.Cells[2,sgrid_row]:=' Data0492.CUT_NO = '''+trim(edit1.Text)+'''';
        1: sgrid1.Cells[2,sgrid_row]:=' Data0492.CUT_NO LIKE ''%'+trim(edit1.Text)+'%''';
      end;
    10://��������
     case radiogroup3.ItemIndex of
        0: sgrid1.Cells[2,sgrid_row]:=' Data0416.warehouse_ptr = '''+trim(edit1.Text)+'''';
        1: sgrid1.Cells[2,sgrid_row]:=' Data0416.warehouse_ptr LIKE ''%'+trim(edit1.Text)+'%''';
      end;
    end;
  end;
  if (RGp4.Items[RGp4.ItemIndex] = '����') then
  begin
    case listbox1.ItemIndex of
    0://���Ա��
    case radiogroup3.ItemIndex of
     0: sgrid1.Cells[2,sgrid_row]:=' Data0005.EMPL_CODE = '''+trim(edit1.Text)+'''';
     1: sgrid1.Cells[2,sgrid_row]:=' Data0005.EMPL_CODE LIKE ''%'+trim(edit1.Text)+'%''';
     end;
    1://����
    begin
     sgrid1.Cells[1,sgrid_row]:='��'+datetostr(dtpk1.date)+'��'+datetostr(dtpk2.date);
     sgrid1.Cells[2,sgrid_row]:=
     '  Data0416.sys_date>='''+FormatDateTime('yyyy-MM-dd',dtpk1.date)+' '+FormatDateTime('HH:MM:SS',dtpk1.Time)+''''+#13
     +' and Data0416.sys_date<='''+FormatDateTime('yyyy-MM-dd',dtpk2.date)+' '+FormatDateTime('HH:MM:SS',dtpk2.Time)+'''';
    end;
    2://���첿��
    case radiogroup3.ItemIndex of
      0: sgrid1.Cells[2,sgrid_row]:=' Data0034.DEPT_CODE = '''+trim(edit1.Text)+'''';
      1: sgrid1.Cells[2,sgrid_row]:=' Data0034.DEPT_CODE LIKE ''%'+trim(edit1.Text)+'%''';
    end;
    3://��������
     case radiogroup3.ItemIndex of
        0: sgrid1.Cells[2,sgrid_row]:=' Data0416.warehouse_ptr = '''+trim(edit1.Text)+'''';
        1: sgrid1.Cells[2,sgrid_row]:=' Data0416.warehouse_ptr LIKE ''%'+trim(edit1.Text)+'%''';
      end;
    4://�������
     begin
       sgrid1.Cells[1,sgrid_row]:=ComboBox1.Text;
       sgrid1.Cells[2,sgrid_row]:=' Data0416.type =  '+IntToStr(ComboBox1.ItemIndex+1)+'';
     end;
    end;
  end;
end;

procedure TMain_Form.Button3Click(Sender: TObject);
var
 i:byte;
begin
for i:=1 to sgrid1.RowCount-2 do
  if sgrid1.Cells[0,i]=listbox1.Items[listbox1.itemindex]  then
   begin
    self.update_sgrid(i);
    exit;
   end;

  if (edit1.Text ='') and (edit1.Visible =true) then //����ֵΪ��
    begin
      messagedlg('����ֵ����Ϊ��!',mtinformation,[mbok],0);
      exit;
    end;
 for i:=1 to sgrid1.RowCount-2 do
 if sgrid1.Cells[0,i]=listbox1.Items[listbox1.itemindex]  then
  begin
   messagedlg('ͬһ��������Ŀ������������!',mtinformation,[mbok],0);
   exit;
  end;

  if (RGp4.Items[RGp4.ItemIndex] = '��ϸ') then
  begin
    sgrid1.Cells[0,sgrid1.RowCount-1]:=listbox1.Items[listbox1.itemindex];
    sgrid1.Cells[1,sgrid1.RowCount-1]:=edit1.Text;
    case listbox1.ItemIndex of
    0:   //��Ʒ����
    case radiogroup3.ItemIndex of
     0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0007.PR_GRP_CODE  = '''+trim(edit1.Text)+'''';
     1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0007.PR_GRP_CODE  LIKE ''%'+trim(edit1.Text)+'%''';
    end;
    1:   //��Ʒ����
    case radiogroup3.ItemIndex of
      0:  sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0008.PROD_CODE = '''+trim(edit1.Text)+'''';
      1:  sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0008.PROD_CODE LIKE ''%'+trim(edit1.Text)+'%''';
    end;
    2:   //��Ʒ����
    case radiogroup3.ItemIndex of
     0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0008.PRODUCT_NAME = '''+trim(edit1.Text)+'''';
     1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0008.PRODUCT_NAME LIKE ''%'+trim(edit1.Text)+'%''';
    end;
    3:   //��Ʒ���
    case radiogroup3.ItemIndex of
      0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0008.PRODUCT_DESC = '''+trim(edit1.Text)+'''';
      1:sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0008.PRODUCT_DESC LIKE ''%'+trim(edit1.Text)+'%''';
    end;
    4:   //��ⵥ��
      case radiogroup3.ItemIndex of
        0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0416.number = '''+trim(edit1.Text)+'''';
        1:sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0416.number LIKE ''%'+trim(edit1.Text)+'%''';
     end;
    5://����
    begin
     sgrid1.Cells[1,sgrid1.RowCount-1]:='��'+datetostr(dtpk1.date)+'��'+datetostr(dtpk2.date);
     sgrid1.Cells[2,sgrid1.RowCount-1]:=
     '  Data0416.sys_date>='''+FormatDateTime('yyyy-MM-dd',dtpk1.date)+' '+FormatDateTime('HH:MM:SS',DTTm1.Time)+''''+#13
     +' and Data0416.sys_date<='''+FormatDateTime('yyyy-MM-dd',dtpk2.date)+' '+FormatDateTime('HH:MM:SS',DTTm2.Time)+'''';
    end;
    6://���Ա��
    case radiogroup3.ItemIndex of
     0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0005.EMPL_CODE = '''+trim(edit1.Text)+'''';
     1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0005.EMPL_CODE LIKE ''%'+trim(edit1.Text)+'%''';
     end;
    7://�ֿ�
    case radiogroup3.ItemIndex of
     0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0016.CODE = '''+trim(edit1.Text)+'''';
     1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0016.CODE LIKE ''%'+trim(edit1.Text)+'%''';
     end;
    8://���첿��
    case radiogroup3.ItemIndex of
      0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0034.DEPT_CODE = '''+trim(edit1.Text)+'''';
      1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0034.DEPT_CODE LIKE ''%'+trim(edit1.Text)+'%''';
    end;
    9://��������
     case radiogroup3.ItemIndex of
        0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0492.CUT_NO = '''+trim(edit1.Text)+'''';
        1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0492.CUT_NO LIKE ''%'+trim(edit1.Text)+'%''';
      end;
    10://��������
     case radiogroup3.ItemIndex of
        0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0416.warehouse_ptr = '''+trim(edit1.Text)+'''';
        1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0416.warehouse_ptr LIKE ''%'+trim(edit1.Text)+'%''';
      end;
    end;
  end;
  if (RGp4.Items[RGp4.ItemIndex] = '����') then
  begin
    sgrid1.Cells[0,sgrid1.RowCount-1]:=listbox1.Items[listbox1.itemindex];
    sgrid1.Cells[1,sgrid1.RowCount-1]:=edit1.Text;
    case listbox1.ItemIndex of
    0:   //
    case radiogroup3.ItemIndex of
     0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0005.EMPL_CODE = '''+trim(edit1.Text)+'''';
     1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0005.EMPL_CODE LIKE ''%'+trim(edit1.Text)+'%''';
    end;
    1:   //ʱ���
    begin
     sgrid1.Cells[1,sgrid1.RowCount-1]:='��'+datetostr(dtpk1.date)+'��'+datetostr(dtpk2.date);
     sgrid1.Cells[2,sgrid1.RowCount-1]:=
     '  Data0416.sys_date>='''+FormatDateTime('yyyy-MM-dd',dtpk1.date)+' '+FormatDateTime('HH:MM:SS',DTTm1.Time)+''''+#13
     +' and Data0416.sys_date<='''+FormatDateTime('yyyy-MM-dd',dtpk2.date)+' '+FormatDateTime('HH:MM:SS',DTTm2.Time)+'''';
    end;
    2://���첿��
    case radiogroup3.ItemIndex of
      0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0034.DEPT_CODE = '''+trim(edit1.Text)+'''';
      1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0034.DEPT_CODE LIKE ''%'+trim(edit1.Text)+'%''';
    end;
    3://��������
     case radiogroup3.ItemIndex of
        0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0416.warehouse_ptr = '''+trim(edit1.Text)+'''';
        1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0416.warehouse_ptr LIKE ''%'+trim(edit1.Text)+'%''';
     end;
    4:
     begin
        sgrid1.Cells[1,sgrid1.RowCount-1]:=ComboBox1.Text;
        sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0416.type = '+IntToStr(ComboBox1.ItemIndex+1)+'';
     end;
    end;
  end;
  sgrid1.RowCount:=sgrid1.RowCount+1;
end;

procedure TMain_Form.BitBtn6Click(Sender: TObject);
begin
  if (RGp4.Items[RGp4.ItemIndex] = '��ϸ') then
  begin
  case listbox1.ItemIndex of
  0: //��Ʒ����
    begin
       Item_Form:=TItem_Form.Create(application);
       dm.ADOQuery1.Close ;
       DM.ADOQuery1.SQL.Clear ;
       DM.ADOQuery1.SQL.text :=
       'SELECT PR_GRP_CODE AS ��Ʒ������, PRODUCT_GROUP_NAME AS ��Ʒ������� FROM Data0007' ;

       dm.ADOQuery1.Open ;
       Item_Form.DBGridEh1.Columns[0].FieldName :='��Ʒ������';
       Item_Form.DBGridEh1.Columns[1].FieldName :='��Ʒ�������';
       Item_Form.Label2.Caption := '0';
        if Item_Form.ShowModal=mrok then
         begin
            edit1.Text:=dm.ADOQuery1.Fields[0].Value;
            button3.Enabled:=true;
            SetFocus;
          end
        else
        edit1.SetFocus;
       Item_Form.Free ;
    end;
 6://Ա��
    begin
       Item_Form:=TItem_Form.Create(application);
       DM.ADOQuery1.Close ;
       DM.ADOQuery1.SQL.Clear ;
       DM.ADOQuery1.SQL.text :=
       'SELECT empl_code as Ա������,employee_name as Ա������ FROM Data0005' ;
       DM.ADOQuery1.open ;
       Item_Form.Label2.Caption := '6';
       Item_Form.DBGridEh1.Columns[0].FieldName :='Ա������';
       Item_Form.DBGridEh1.Columns[1].FieldName :='Ա������';
        if Item_Form.ShowModal=mrok then
         begin
            edit1.Text:=dm.ADOQuery1.Fields[0].Value;
            button3.Enabled:=true;
            button3.SetFocus;

          end
        else
          edit1.SetFocus;
          Item_Form.Free ;
    end;
   7://�ֿ�
    begin
       Item_Form:=TItem_Form.Create(application);
       DM.ADOQuery1.Close ;
       DM.ADOQuery1.SQL.Clear ;
       DM.ADOQuery1.SQL.text :=
       'SELECT code as �ֿ����,location as �ֿ����� FROM Data0016' ;
       DM.ADOQuery1.open ;
       Item_Form.Label2.Caption := '7';
       Item_Form.DBGridEh1.Columns[0].FieldName :='�ֿ����';
       Item_Form.DBGridEh1.Columns[1].FieldName :='�ֿ�����';
        if Item_Form.ShowModal=mrok then
         begin
            edit1.Text:=dm.ADOQuery1.Fields[0].Value;
            button3.Enabled:=true;
            button3.SetFocus;
          end
        else
          edit1.SetFocus;
         Item_Form.Free ;
    end;
   8://����
    begin
       Item_Form:=TItem_Form.Create(application);
       DM.ADOQuery1.Close ;
       DM.ADOQuery1.SQL.Clear ;
       DM.ADOQuery1.SQL.text :=
       'SELECT DEPT_CODE as ���Ŵ���,DEPT_name as �������� FROM Data0034' ;
       DM.ADOQuery1.open ;
       Item_Form.Label2.Caption := '8';
       Item_Form.DBGridEh1.Columns[0].FieldName :='���Ŵ���';
       Item_Form.DBGridEh1.Columns[1].FieldName :='��������';
        if Item_Form.ShowModal=mrok then
         begin
            edit1.Text:=dm.ADOQuery1.Fields[0].Value;
            button3.Enabled:=true;
            button3.SetFocus;
          end
        else
          edit1.SetFocus;
         Item_Form.Free ;
      end;
   10://����
    begin
       Item_Form:=TItem_Form.Create(application);
       DM.ADOQuery1.Close ;
       DM.ADOQuery1.SQL.Clear ;
       DM.ADOQuery1.SQL.text :=
       'select RKEY,WAREHOUSE_CODE as ��������,WAREHOUSE_NAME as ��������,ABBR_NAME from data0015' ;
       DM.ADOQuery1.open ;
       Item_Form.Label2.Caption := '10';
       Item_Form.DBGridEh1.Columns[0].FieldName :='��������';
       Item_Form.DBGridEh1.Columns[1].FieldName :='��������';
        if Item_Form.ShowModal=mrok then
         begin
            edit1.Text:=dm.ADOQuery1.Fields[0].Value;
            button3.Enabled:=true;
            button3.SetFocus;
          end
        else
          edit1.SetFocus;
         Item_Form.Free ;
      end;
  end;
  end;
  if (RGp4.Items[RGp4.ItemIndex] = '����') then
  begin
    case listbox1.ItemIndex of
      0://Ա��
      begin
         Item_Form:=TItem_Form.Create(application);
         DM.ADOQuery1.Close ;
         DM.ADOQuery1.SQL.Clear ;
         DM.ADOQuery1.SQL.text :=
         'SELECT empl_code as Ա������,employee_name as Ա������ FROM Data0005' ;
         DM.ADOQuery1.open ;
         Item_Form.Label2.Caption := '6';
         Item_Form.DBGridEh1.Columns[0].FieldName :='Ա������';
         Item_Form.DBGridEh1.Columns[1].FieldName :='Ա������';
          if Item_Form.ShowModal=mrok then
           begin
              edit1.Text:=dm.ADOQuery1.Fields[0].Value;
              button3.Enabled:=true;
              button3.SetFocus;
            end
          else
            edit1.SetFocus;
            Item_Form.Free ;
      end;
     2://����
      begin
       Item_Form:=TItem_Form.Create(application);
       DM.ADOQuery1.Close ;
       DM.ADOQuery1.SQL.Clear ;
       DM.ADOQuery1.SQL.text :=
       'SELECT DEPT_CODE as ���Ŵ���,DEPT_name as �������� FROM Data0034' ;
       DM.ADOQuery1.open ;
       Item_Form.Label2.Caption := '8';
       Item_Form.DBGridEh1.Columns[0].FieldName :='���Ŵ���';
       Item_Form.DBGridEh1.Columns[1].FieldName :='��������';
        if Item_Form.ShowModal=mrok then
         begin
            edit1.Text:=dm.ADOQuery1.Fields[0].Value;
            button3.Enabled:=true;
            button3.SetFocus;
          end
        else
          edit1.SetFocus;
         Item_Form.Free ;
      end;
     3://����
      begin
         Item_Form:=TItem_Form.Create(application);
         DM.ADOQuery1.Close ;
         DM.ADOQuery1.SQL.Clear ;
         DM.ADOQuery1.SQL.text :=
         'select RKEY,WAREHOUSE_CODE as ��������,WAREHOUSE_NAME as ��������,ABBR_NAME from data0015' ;
         DM.ADOQuery1.open ;
         Item_Form.Label2.Caption := '10';
         Item_Form.DBGridEh1.Columns[0].FieldName :='��������';
         Item_Form.DBGridEh1.Columns[1].FieldName :='��������';
          if Item_Form.ShowModal=mrok then
           begin
              edit1.Text:=dm.ADOQuery1.Fields[0].Value;
              button3.Enabled:=true;
              button3.SetFocus;
            end
          else
            edit1.SetFocus;
           Item_Form.Free ;
      end;
    end;
  end;
end;

//����

procedure TMain_Form.btOutClick(Sender: TObject);
var
 i:byte;
begin
  if (edout.Text ='') and (edout.Visible =true) then //����ֵΪ��
    begin
      messagedlg('����ֵ����Ϊ��!',mtinformation,[mbok],0);
      exit;
    end;
  for i:=1 to sgrid1.RowCount-2 do
    if sgrid1.Cells[0,i]=listbout.Items[listbout.itemindex]  then
    begin
        self.Outupdate_sgrid(listbout,edout,dtpout1,dtpout2,i);
        exit;
    end;

   for i:=1 to sgrid1.RowCount-2 do
   if sgrid1.Cells[0,i]=listbout.Items[listbout.itemindex]  then
    begin
     messagedlg('ͬһ��������Ŀ������������!',mtinformation,[mbok],0);
     exit;
    end;
  if (RGp4.Items[RGp4.ItemIndex] = '��ϸ') then
  begin
    sgrid1.Cells[0,sgrid1.RowCount-1]:=listbout.Items[listbout.itemindex];
    sgrid1.Cells[1,sgrid1.RowCount-1]:=edout.Text;
    case listbout.ItemIndex of
    0:
     case radiogroup2.ItemIndex of
     0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0007.PR_GRP_CODE  = '''+trim(edout.Text)+'''';
     1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0007.PR_GRP_CODE  LIKE ''%'+trim(edout.Text)+'%''';
     end;
    1:
    case radiogroup2.ItemIndex of
     0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0008.PROD_CODE = '''+trim(edout.Text)+'''';
     1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0008.PROD_CODE LIKE ''%'+trim(edout.Text)+'%''';
    end;
    2:
    case radiogroup2.ItemIndex of
     0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0008.PRODUCT_NAME = '''+trim(edout.Text)+'''';
     1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0008.PRODUCT_NAME LIKE ''%'+trim(edout.Text)+'%''';
    end;
    3://���ֵ���
    case radiogroup2.ItemIndex of
     0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0008.PRODUCT_DESC = '''+trim(edout.Text)+'''';
     1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0008.PRODUCT_DESC LIKE ''%'+trim(edout.Text)+'%''';
    end;
    4:
    case radiogroup2.ItemIndex of
     0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' WZCP0060.sales_order ='''+trim(edout.Text)+'''';
     1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' WZCP0060.sales_order LIKE ''%'+trim(edout.Text)+'%''';
    end;
    5://��������
    begin
     sgrid1.Cells[1,sgrid1.RowCount-1]:='��'+datetostr(dtpout1.date)+'��'+datetostr(dtpout2.date);
    { sgrid1.Cells[2,sgrid1.RowCount-1]:=
      '  wzcp0060.sales_date>='''+FormatDateTime('yyyy-MM-dd',dtpout1.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker1.Time)+''''
     +' and wzcp0060.sales_date<='''+FormatDateTime('yyyy-MM-dd',dtpout2.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker2.Time)+''''; }
     sgrid1.Cells[2,sgrid1.RowCount-1]:=
      '  wzcp0063.sales_date>='''+FormatDateTime('yyyy-MM-dd',dtpout1.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker1.Time)+''''
     +' and wzcp0063.sales_date<='''+FormatDateTime('yyyy-MM-dd',dtpout2.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker2.Time)+'''';

    end;
    6://�����������
    begin
     sgrid1.Cells[1,sgrid1.RowCount-1]:='��'+datetostr(dtpout1.date)+'��'+datetostr(dtpout2.date);
     sgrid1.Cells[2,sgrid1.RowCount-1]:=
      '  wzcp0060.CONF_DATE>='''+FormatDateTime('yyyy-MM-dd',dtpout1.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker1.Time)+''''
     +' and wzcp0060.CONF_DATE<='''+FormatDateTime('yyyy-MM-dd',dtpout2.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker2.Time)+'''';

    end;
    7://����Ա��
    case radiogroup2.ItemIndex of
     0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0005.EMPL_CODE = '''+trim(edout.Text)+'''';
     1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0005.EMPL_CODE LIKE ''%'+trim(edout.Text)+'%''';
    end;
    8://�ֿ�
     case radiogroup2.ItemIndex of
        0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0016.CODE = '''+trim(edout.Text)+'''';
        1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0016.CODE LIKE ''%'+trim(edout.Text)+'%''';
     end;
    9: //�ͻ�����
    case radiogroup2.ItemIndex of
      0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0010.CUST_CODE = '''+trim(edout.Text)+'''';
      1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0010.CUST_CODE like ''%'+trim(edout.Text)+'%''';
    end;
    10:
    begin
      sgrid1.Cells[1,sgrid1.RowCount-1]:= OutCBox1.Text;
      sgrid1.Cells[2,sgrid1.RowCount-1]:=' wzcp0060.type = '''+inttostr(OutCBox1.ItemIndex+1)+'''';
    end;
    11:  //��������
    case radiogroup2.ItemIndex of
      0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' data0492.CUT_NO = '''+trim(edout.Text)+'''';
      1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' data0492.CUT_NO like ''%'+trim(edout.Text)+'%''';
    end;
    end;
  end;
  if (RGp4.Items[RGp4.ItemIndex] = '����') then
  begin
    sgrid1.Cells[0,sgrid1.RowCount-1]:=listbout.Items[listbout.itemindex];
    sgrid1.Cells[1,sgrid1.RowCount-1]:=edout.Text;
    case listbout.ItemIndex of
    0:
     case radiogroup2.ItemIndex of
     0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0005.EMPL_CODE  = '''+trim(edout.Text)+'''';
     1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0005.EMPL_CODE  LIKE ''%'+trim(edout.Text)+'%''';
     end;
    1://��������
    begin
     sgrid1.Cells[1,sgrid1.RowCount-1]:='��'+datetostr(dtpout1.date)+'��'+datetostr(dtpout2.date);
     {sgrid1.Cells[2,sgrid1.RowCount-1]:=
      '  wzcp0060.sales_date>='''+FormatDateTime('yyyy-MM-dd',dtpout1.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker1.Time)+''''
     +' and wzcp0060.sales_date<='''+FormatDateTime('yyyy-MM-dd',dtpout2.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker2.Time)+''''; }
     sgrid1.Cells[2,sgrid1.RowCount-1]:=
      '  wzcp0063.sales_date>='''+FormatDateTime('yyyy-MM-dd',dtpout1.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker1.Time)+''''
     +' and wzcp0063.sales_date<='''+FormatDateTime('yyyy-MM-dd',dtpout2.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker2.Time)+'''';

    end;
    2:
    case radiogroup2.ItemIndex of
     0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0005_1.EMPL_CODE = '''+trim(edout.Text)+'''';
     1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0005_1.EMPL_CODE LIKE ''%'+trim(edout.Text)+'%''';
    end;
    3:
    begin
      sgrid1.Cells[1,sgrid1.RowCount-1]:= OutCBox1.Text;
      sgrid1.Cells[2,sgrid1.RowCount-1]:=' wzcp0060.type = '''+inttostr(OutCBox1.ItemIndex+1)+'''';
    end;
    4: //�ͻ�����
    case radiogroup2.ItemIndex of
      0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0010.CUST_CODE = '''+trim(edout.Text)+'''';
      1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' Data0010.CUST_CODE like ''%'+trim(edout.Text)+'%''';
    end;
    5://����
    begin
      sgrid1.Cells[1,sgrid1.RowCount-1]:= ComboBox2.Text;
      sgrid1.Cells[2,sgrid1.RowCount-1]:=' wzcp0060.status = '''+inttostr(ComboBox2.ItemIndex+1)+'''';
    end;
    end;
  end;
 sgrid1.RowCount:=sgrid1.RowCount+1;

end;

procedure TMain_Form.Outupdate_sgrid(const plisB:Tlistbox;const pEdit:TEdit;
pdtp1:TDateTimePicker;pdtp2:TDateTimePicker;sgrid_row: byte);
begin
  sgrid1.Cells[0,sgrid_row]:=plisB.Items[plisB.itemindex];
  sgrid1.Cells[1,sgrid_row]:=pEdit.Text;
  if (RGp4.Items[RGp4.ItemIndex] = '��ϸ') then
  begin
    case plisB.ItemIndex of
    0:
     case radiogroup2.ItemIndex of
     0: sgrid1.Cells[2,sgrid_row]:=' Data0007.PR_GRP_CODE  = '''+trim(edout.Text)+'''';
     1: sgrid1.Cells[2,sgrid_row]:=' Data0007.PR_GRP_CODE  LIKE ''%'+trim(edout.Text)+'%''';
     end;
    1:
    case radiogroup2.ItemIndex of
     0: sgrid1.Cells[2,sgrid_row]:=' Data0008.PROD_CODE = '''+trim(edout.Text)+'''';
     1: sgrid1.Cells[2,sgrid_row]:=' Data0008.PROD_CODE LIKE ''%'+trim(edout.Text)+'%''';
    end;
    2:
    case radiogroup2.ItemIndex of
     0: sgrid1.Cells[2,sgrid_row]:=' Data0008.PRODUCT_NAME = '''+trim(edout.Text)+'''';
     1: sgrid1.Cells[2,sgrid_row]:=' Data0008.PRODUCT_NAME LIKE ''%'+trim(edout.Text)+'%''';
    end;
    3://���ֵ���
    case radiogroup2.ItemIndex of
     0: sgrid1.Cells[2,sgrid_row]:=' Data0008.PRODUCT_DESC = '''+trim(edout.Text)+'''';
     1: sgrid1.Cells[2,sgrid_row]:=' Data0008.PRODUCT_DESC LIKE ''%'+trim(edout.Text)+'%''';
    end;
    4:
    case radiogroup2.ItemIndex of
     0: sgrid1.Cells[2,sgrid_row]:=' WZCP0060.sales_order ='''+trim(edout.Text)+'''';
     1: sgrid1.Cells[2,sgrid_row]:=' WZCP0060.sales_order LIKE ''%'+trim(edout.Text)+'%''';
    end;
    5://��������
    begin
     sgrid1.Cells[1,sgrid_row]:='��'+datetostr(dtpout1.date)+'��'+datetostr(dtpout2.date);
     {sgrid1.Cells[2,sgrid_row]:=
      '  wzcp0060.sales_date>='''+FormatDateTime('yyyy-MM-dd',dtpout1.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker1.Time)+''''
     +' and wzcp0060.sales_date<='''+FormatDateTime('yyyy-MM-dd',dtpout2.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker2.Time)+'''';}
     sgrid1.Cells[2,sgrid_row]:=
      '  wzcp0063.sales_date>='''+FormatDateTime('yyyy-MM-dd',dtpout1.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker1.Time)+''''
     +' and wzcp0063.sales_date<='''+FormatDateTime('yyyy-MM-dd',dtpout2.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker2.Time)+'''';
    end;
    6://�����������
    begin
     sgrid1.Cells[1,sgrid_row]:='��'+datetostr(dtpout1.date)+'��'+datetostr(dtpout2.date);
     sgrid1.Cells[2,sgrid_row]:=
      '  wzcp0060.CONF_DATE>='''+FormatDateTime('yyyy-MM-dd',dtpout1.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker1.Time)+''''
     +' and wzcp0060.CONF_DATE<='''+FormatDateTime('yyyy-MM-dd',dtpout2.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker2.Time)+'''';
    end;
    7://����Ա��
    case radiogroup2.ItemIndex of
     0: sgrid1.Cells[2,sgrid_row]:=' Data0005.EMPL_CODE = '''+trim(edout.Text)+'''';
     1: sgrid1.Cells[2,sgrid_row]:=' Data0005.EMPL_CODE LIKE ''%'+trim(edout.Text)+'%''';
    end;
    8://�ֿ�
     case radiogroup2.ItemIndex of
        0: sgrid1.Cells[2,sgrid_row]:=' Data0016.CODE = '''+trim(edout.Text)+'''';
        1: sgrid1.Cells[2,sgrid_row]:=' Data0016.CODE LIKE ''%'+trim(edout.Text)+'%''';
     end;
    9: //�ͻ�����
    case radiogroup2.ItemIndex of
      0: sgrid1.Cells[2,sgrid_row]:=' Data0010.CUST_CODE = '''+trim(edout.Text)+'''';
      1: sgrid1.Cells[2,sgrid_row]:=' Data0010.CUST_CODE like ''%'+trim(edout.Text)+'%''';
    end;
    10:
    begin
      sgrid1.Cells[1,sgrid_row]:= OutCBox1.Text;
      sgrid1.Cells[2,sgrid_row]:=' wzcp0060.type = '''+inttostr(OutCBox1.ItemIndex+1)+'''';
    end;
    11:  //��������
    case radiogroup2.ItemIndex of
      0: sgrid1.Cells[2,sgrid_row]:=' data0492.CUT_NO = '''+trim(edout.Text)+'''';
      1: sgrid1.Cells[2,sgrid_row]:=' data0492.CUT_NO like ''%'+trim(edout.Text)+'%''';
    end;
    end;//end case
  end;
  if (RGp4.Items[RGp4.ItemIndex] = '����') then
  begin
    case listbout.ItemIndex of
    0:
     case radiogroup2.ItemIndex of
     0: sgrid1.Cells[2,sgrid_row]:=' Data0005.EMPL_CODE  = '''+trim(edout.Text)+'''';
     1: sgrid1.Cells[2,sgrid_row]:=' Data0005.EMPL_CODE  LIKE ''%'+trim(edout.Text)+'%''';
     end;
    1://��������
    begin
     sgrid1.Cells[1,sgrid_row]:='��'+datetostr(dtpout1.date)+'��'+datetostr(dtpout2.date);
    { sgrid1.Cells[2,sgrid_row]:=
      '  wzcp0060.sales_date>='''+FormatDateTime('yyyy-MM-dd',dtpout1.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker1.Time)+''''
     +' and wzcp0060.sales_date<='''+FormatDateTime('yyyy-MM-dd',dtpout2.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker2.Time)+''''; }
     sgrid1.Cells[2,sgrid_row]:=
      '  wzcp0063.sales_date>='''+FormatDateTime('yyyy-MM-dd',dtpout1.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker1.Time)+''''
     +' and wzcp0063.sales_date<='''+FormatDateTime('yyyy-MM-dd',dtpout2.Date)+' '+FormatDateTime('HH:MM:SS',DateTimePicker2.Time)+'''';
    end;
    2:
    case radiogroup2.ItemIndex of
     0: sgrid1.Cells[2,sgrid_row]:=' data0005_1.EMPL_CODE = '''+trim(edout.Text)+'''';
     1: sgrid1.Cells[2,sgrid_row]:=' data0005_1.EMPL_CODE LIKE ''%'+trim(edout.Text)+'%''';
    end;
    3:
    begin
      sgrid1.Cells[1,sgrid_row]:= OutCBox1.Text;
      sgrid1.Cells[2,sgrid_row]:=' wzcp0060.type = '''+inttostr(OutCBox1.ItemIndex+1)+'''';
    end;
    4: //�ͻ�����
    case radiogroup2.ItemIndex of
      0: sgrid1.Cells[2,sgrid_row]:=' Data0010.CUST_CODE = '''+trim(edout.Text)+'''';
      1: sgrid1.Cells[2,sgrid_row]:=' Data0010.CUST_CODE like ''%'+trim(edout.Text)+'%''';
    end;
    5://����
    begin
      sgrid1.Cells[1,sgrid_row]:= ComboBox2.Text;
      sgrid1.Cells[2,sgrid_row]:=' wzcp0060.status = '''+inttostr(ComboBox2.ItemIndex+1)+'''';
    end;
    end;
  end;
end;

procedure TMain_Form.BitBtnOutClick(Sender: TObject);
begin
  if (RGp4.Items[RGp4.ItemIndex] = '��ϸ') then
  begin
    case ListBOut.ItemIndex of
    0: //��Ʒ����
      begin
         Item_Form:=TItem_Form.Create(application);
         dm.ADOQuery1.Close ;
         DM.ADOQuery1.SQL.Clear ;
         DM.ADOQuery1.SQL.text :=
         'SELECT PR_GRP_CODE AS ��Ʒ������, PRODUCT_GROUP_NAME AS ��Ʒ������� FROM Data0007' ;

         dm.ADOQuery1.Open ;
         Item_Form.DBGridEh1.Columns[0].FieldName :='��Ʒ������';
         Item_Form.DBGridEh1.Columns[1].FieldName :='��Ʒ�������';
         Item_Form.Label2.Caption := '0';
          if Item_Form.ShowModal=mrok then
           begin
              EdOut.Text:=dm.ADOQuery1.Fields[0].Value;
              btOut.Enabled:=true;
              SetFocus;
            end
          else
          EdOut.SetFocus;
         Item_Form.Free ;
      end;
   7://Ա��
      begin
         Item_Form:=TItem_Form.Create(application);
         DM.ADOQuery1.Close ;
         DM.ADOQuery1.SQL.Clear ;
         DM.ADOQuery1.SQL.text :=
         'SELECT empl_code as Ա������,employee_name as Ա������ FROM Data0005' ;
         DM.ADOQuery1.open ;
         Item_Form.Label2.Caption := '6';
         Item_Form.DBGridEh1.Columns[0].FieldName :='Ա������';
         Item_Form.DBGridEh1.Columns[1].FieldName :='Ա������';
          if Item_Form.ShowModal=mrok then
           begin
              EdOut.Text:=dm.ADOQuery1.Fields[0].Value;
              btOut.Enabled:=true;
              btOut.SetFocus;

            end
          else
            EdOut.SetFocus;
            Item_Form.Free ;
      end;
     8://�ֿ�
      begin
         Item_Form:=TItem_Form.Create(application);
         DM.ADOQuery1.Close ;
         DM.ADOQuery1.SQL.Clear ;
         DM.ADOQuery1.SQL.text :=
         'SELECT code as �ֿ����,location as �ֿ����� FROM Data0016' ;
         DM.ADOQuery1.open ;
         Item_Form.Label2.Caption := '7';
         Item_Form.DBGridEh1.Columns[0].FieldName :='�ֿ����';
         Item_Form.DBGridEh1.Columns[1].FieldName :='�ֿ�����';
          if Item_Form.ShowModal=mrok then
           begin
              EdOut.Text:=dm.ADOQuery1.Fields[0].Value;
              btOut.Enabled:=true;
              btOut.SetFocus;
            end
          else
           EdOut.SetFocus;
           Item_Form.Free ;
      end;
     9://�ͻ�����
      begin
         Item_Form:=TItem_Form.Create(application);
         DM.ADOQuery1.Close ;
         DM.ADOQuery1.SQL.Clear ;
         DM.ADOQuery1.SQL.text :=
         'SELECT CUST_CODE as �ͻ�����,CUSTOMER_NAME as �ͻ����� FROM data0010' ;
         DM.ADOQuery1.open ;
         Item_Form.Label2.Caption := '9';
         Item_Form.DBGridEh1.Columns[0].FieldName :='�ͻ�����';
         Item_Form.DBGridEh1.Columns[1].FieldName :='�ͻ�����';
          if Item_Form.ShowModal=mrok then
           begin
              EdOut.Text:=dm.ADOQuery1.Fields[0].Value;
              btOut.Enabled:=true;
              btOut.SetFocus;
            end
          else
           EdOut.SetFocus;
           Item_Form.Free ;
      end;
    { 8://����
      begin
         Item_Form:=TItem_Form.Create(application);
         DM.ADOQuery1.Close ;
         DM.ADOQuery1.SQL.Clear ;
         DM.ADOQuery1.SQL.text :=
         'SELECT DEPT_CODE as ���Ŵ���,DEPT_name as �������� FROM Data0034' ;
         DM.ADOQuery1.open ;
         Item_Form.Label2.Caption := '8';
         Item_Form.DBGrid1.Columns[0].FieldName :='���Ŵ���';
         Item_Form.DBGrid1.Columns[1].FieldName :='��������';
          if Item_Form.ShowModal=mrok then
           begin
              EdOut.Text:=dm.ADOQuery1.Fields[0].Value;
              btOut.Enabled:=true;
              btOut.SetFocus;
            end
          else
            EdOut.SetFocus;
           Item_Form.Free ;
        end;    }
    end;
  end;
  if (RGp4.Items[RGp4.ItemIndex] = '����') then
  begin
    case ListBOut.ItemIndex of
      0,2: //��Ʒ����
        begin
         Item_Form:=TItem_Form.Create(application);
         DM.ADOQuery1.Close ;
         DM.ADOQuery1.SQL.Clear ;
         DM.ADOQuery1.SQL.text :=
         'SELECT empl_code as Ա������,employee_name as Ա������ FROM Data0005' ;
         DM.ADOQuery1.open ;
         Item_Form.Label2.Caption := '6';
         Item_Form.DBGridEh1.Columns[0].FieldName :='Ա������';
         Item_Form.DBGridEh1.Columns[1].FieldName :='Ա������';
          if Item_Form.ShowModal=mrok then
           begin
              EdOut.Text:=dm.ADOQuery1.Fields[0].Value;
              btOut.Enabled:=true;
              btOut.SetFocus;

            end
          else
            EdOut.SetFocus;
            Item_Form.Free ;
        end;
     4://�ͻ�����
      begin
         Item_Form:=TItem_Form.Create(application);
         DM.ADOQuery1.Close ;
         DM.ADOQuery1.SQL.Clear ;
         DM.ADOQuery1.SQL.text :=
         'SELECT CUST_CODE as �ͻ�����,CUSTOMER_NAME as �ͻ����� FROM data0010' ;
         DM.ADOQuery1.open ;
         Item_Form.Label2.Caption := '9';
         Item_Form.DBGridEh1.Columns[0].FieldName :='�ͻ�����';
         Item_Form.DBGridEh1.Columns[1].FieldName :='�ͻ�����';
          if Item_Form.ShowModal=mrok then
           begin
              EdOut.Text:=dm.ADOQuery1.Fields[0].Value;
              btOut.Enabled:=true;
              btOut.SetFocus;
            end
          else
           EdOut.SetFocus;
           Item_Form.Free ;
      end;
    end;
  end;
end;

procedure TMain_Form.ListBOutClick(Sender: TObject);
begin
  if (RGp4.Items[RGp4.ItemIndex] = '��ϸ') then
  begin
    lbout1.Caption:=listbout.Items[listbout.itemindex];
    edout.Text:='';
    ComboBox2.Visible:=False;
    lbout2.Visible :=false;
    lbout3.Visible :=false;
    dtpout1.Visible :=false;
    dtpout2.Visible :=false;
    DateTimePicker1.Visible :=false;
    DateTimePicker2.Visible :=false;

    OutCBox1.Visible :=false;
    RadioGroup2.Visible := true;
    case listbout.ItemIndex of
     0:
      begin
       lbout1.visible :=true;
       edout.Visible:=true;
       BitBtnOut.Visible:=true;
       edout.SetFocus;
       OutCBox1.Visible:=False;
      end;
     1:
     begin
       lbout1.visible :=true;
       edout.Visible:=true;
       BitBtnOut.Visible:=false;
       edout.SetFocus;
       lbout2.Visible:=false;
       lbout3.Visible:=false;
       OutCBox1.Visible:=False;
     end;
     2://��Ʒ����
     begin
       lbout1.visible :=true;
       edout.Visible:=true;
       BitBtnOut.Visible:=false;
       edout.SetFocus;
       OutCBox1.Visible:=False;
     end;
     3: //����
     begin
       lbout1.visible :=true;
       edout.Visible:=true;
       BitBtnOut.Visible:=false;
       edout.SetFocus;
       OutCBox1.Visible:=False;
     end;
      4: //���ⵥ��
     begin
       lbout1.visible :=true;
       edout.Visible:=true;
       edout.SetFocus;
       OutCBox1.Visible:=False;
     end;
     5,6: //����
     begin
      BitBtnOut.Visible:=false;
      edout.Visible:=false;
      lbout2.Visible :=true;
      lbout3.Visible :=true;
      lbout1.Visible :=false;
      dtpout1.Visible :=true;
      dtpout2.Visible :=true;
      DateTimePicker1.Visible :=true;
      DateTimePicker2.Visible :=true;
      RadioGroup2.Visible := false;
      OutCBox1.Visible:=False;
     end;
     7: //������Ա
     begin
      lbout1.Visible :=true;
      BitBtnOut.Visible:=true;
      edout.Visible:=true;
      edout.SetFocus;
      OutCBox1.Visible:=False;
     end;

     8: // �ֿ�����
      begin
      lbout1.Visible :=true;
      BitBtnOut.Visible:=true;
      edout.Visible:=true;
      edout.SetFocus;
      OutCBox1.Visible:=False;
      end;
      9: // �ͻ�����
      begin
       lbout1.visible :=true;
       edout.Visible:=true;
       BitBtnOut.Visible:=true;
       edout.SetFocus;
       OutCBox1.Visible:=False;
      end;
      10: // ��������
      begin
      lbout1.Visible :=true;
      BitBtnOut.Visible:=false;
      edout.Visible:=false;
      OutCBox1.Visible :=true;
      RadioGroup2.Visible := false;
      end;
      11: // ��������
      begin
        lbout1.Visible :=true;
        BitBtnOut.Visible:=False;
        edout.Visible:=true;
        edout.SetFocus;
        OutCBox1.Visible:=False;
      end;

    end; //end case
  end;
  if (RGp4.Items[RGp4.ItemIndex] = '����') then
  begin
    lbout1.Caption:=listbout.Items[listbout.itemindex];
    edout.Text:='';
    ComboBox2.Visible:=False;
    lbout2.Visible :=false;
    lbout3.Visible :=false;
    dtpout1.Visible :=false;
    dtpout2.Visible :=false;
    DateTimePicker1.Visible :=false;
    DateTimePicker2.Visible :=false;

    OutCBox1.Visible :=false;
    RadioGroup2.Visible := true;
    case ListBOut.ItemIndex of
      0:
      begin
       lbout1.visible :=true;
       edout.Visible:=true;
       BitBtnOut.Visible:=true;
       edout.SetFocus;
       OutCBox1.Visible:=false;
      end;
     1: //����
      begin
      BitBtnOut.Visible:=false;
      edout.Visible:=false;
      lbout2.Visible :=true;
      lbout3.Visible :=true;
      lbout1.Visible :=false;
      dtpout1.Visible :=true;
      dtpout2.Visible :=true;
      DateTimePicker1.Visible :=true;
      DateTimePicker2.Visible :=true;
      RadioGroup2.Visible := false;
      OutCBox1.Visible:=False;
      end;
      2://��Ʒ����
      begin
       lbout1.visible :=true;
       edout.Visible:=true;
       BitBtnOut.Visible:=true;
       edout.SetFocus;
       OutCBox1.Visible:=false;
      end;
      3: // ��������
      begin
        lbout1.Visible :=true;
        BitBtnOut.Visible:=false;
        edout.Visible:=false;
        OutCBox1.Visible :=true;
        RadioGroup2.Visible := false;
        ComboBox2.Visible:=False;
      end;
      4: // �ͻ�����
      begin
       lbout1.visible :=true;
       edout.Visible:=true;
       BitBtnOut.Visible:=true;
       edout.SetFocus;
       OutCBox1.Visible:=False;
      end;
      5://����״̬
      begin
        ComboBox2.Visible:=True;
        lbout1.Visible :=true;
        BitBtnOut.Visible:=false;
        edout.Visible:=false;
        RadioGroup2.Visible := false;
       OutCBox1.Visible:=false;
      end;
    end;
  end;
end;

procedure TMain_Form.ListBKCClick(Sender: TObject);
begin
lbkc1.Caption:=listbKC.Items[listbKC.itemindex];
case listbKC.ItemIndex of
 0:
  begin
   lbKC1.visible :=true;
   edKC.Visible:=true;
   BitBtnKC.Visible:=true;
   dtpk1.Visible :=false;
   dtpk2.Visible :=false;
   lbKC2.Visible:=false;
   lbKC3.Visible:=false;
   GroupBox4.Visible:=False;
   RadioGroup4.Visible:=True;
  edKC.Text:='';
  edKC.SetFocus;
  end;
 1:
 begin
   lbKC1.visible :=true;
   edKC.Visible:=true;
   BitBtnKC.Visible:=false;
   dtpk1.Visible :=false;
   dtpk2.Visible :=false;
   lbKC2.Visible:=false;
   lbKC3.Visible:=false;
   GroupBox4.Visible:=False;
   RadioGroup4.Visible:=True;
  edKC.Text:='';
  edKC.SetFocus;
 end;
 2://��Ʒ����
 begin
   lbKC1.visible :=true;
   edKC.Visible:=true;
   BitBtnKC.Visible:=false;
   dtpKC1.Visible :=false;
   dtpKC2.Visible :=false;
   lbKC2.Visible:=false;
   lbKC3.Visible:=false;
   GroupBox4.Visible:=False;
   RadioGroup4.Visible:=True;
  edKC.Text:='';
  edKC.SetFocus;
 end;
 3: // ��Ʒ���
  begin
  lbKC1.Visible :=true;
  BitBtnKC.Visible:=false;
  edKC.Visible:=true;

  lbKC2.Visible :=false;
  lbKC3.Visible :=false;
  dtpKC1.Visible :=false;
  dtpKC2.Visible :=false;
   GroupBox4.Visible:=False;
   RadioGroup4.Visible:=True;
  edKC.Text:='';
  edKC.SetFocus;
  end;
 4: // �ֿ�����
  begin
  lbKC1.Visible :=true;
  BitBtnKC.Visible:=true;
  edKC.Visible:=true;

  lbKC2.Visible :=false;
  lbKC3.Visible :=false;
  dtpKC1.Visible :=false;
  dtpKC2.Visible :=false;
   GroupBox4.Visible:=False;
   RadioGroup4.Visible:=True;
  edKC.Text:='';
  edKC.SetFocus;
  end;
  5: // ���첿��
  begin
  lbKC1.Visible :=true;
  BitBtnKC.Visible:=true;
  edKC.Visible:=true;

  lbKC2.Visible :=false;
  lbKC3.Visible :=false;
  dtpKC1.Visible :=false;
  dtpKC2.Visible :=false;
   GroupBox4.Visible:=False;
   RadioGroup4.Visible:=True;
  edKC.Text:='';
  edKC.SetFocus;
  end;
  6://���
  begin
  lbKC1.Visible :=true;
  BitBtnKC.Visible:=true;
  edKC.Visible:=False;
  lbKC2.Visible :=false;
  lbKC3.Visible :=false;
  dtpKC1.Visible :=false;
  dtpKC2.Visible :=false;
   GroupBox4.Visible:=True;
   RadioGroup4.Visible:=False;
  end;
end; //end case
end;

procedure TMain_Form.BitBtnKCClick(Sender: TObject);
{var
  InputVar: PDlgInput ; }
begin
case ListBKC.ItemIndex of
  0: //��Ʒ����
    begin
       Item_Form:=TItem_Form.Create(application);
       dm.ADOQuery1.Close ;
       DM.ADOQuery1.SQL.Clear ;
       DM.ADOQuery1.SQL.text :=
       'SELECT PR_GRP_CODE AS ��Ʒ������, PRODUCT_GROUP_NAME AS ��Ʒ������� FROM Data0007 ORDER BY ��Ʒ������' ;

       dm.ADOQuery1.Open ;
       Item_Form.DBGridEh1.Columns[0].FieldName :='��Ʒ������';
       Item_Form.DBGridEh1.Columns[1].FieldName :='��Ʒ�������';
       Item_Form.Label2.Caption := '0';
        if Item_Form.ShowModal=mrok then
         begin
            EdKC.Text:=dm.ADOQuery1.Fields[0].Value;
            BtKC.Enabled:=true;
            BtKC.SetFocus;

          end
        else
        EdKC.SetFocus;
       Item_Form.Free ;
    end;
 {6://Ա��
    begin
       Item_Form:=TItem_Form.Create(application);
       DM.ADOQuery1.Close ;
       DM.ADOQuery1.SQL.Clear ;
       DM.ADOQuery1.SQL.text :=
       'SELECT empl_code as Ա������,employee_name as Ա������ FROM Data0005' ;
       DM.ADOQuery1.open ;
       Item_Form.Label2.Caption := '6';
       Item_Form.DBGrid1.Columns[0].FieldName :='Ա������';
       Item_Form.DBGrid1.Columns[1].FieldName :='Ա������';
        if Item_Form.ShowModal=mrok then
         begin
            EdKC.Text:=dm.ADOQuery1.Fields[0].Value;
            BtKC.Enabled:=true;
            BtKC.SetFocus;

          end
        else
          EdKC.SetFocus;
          Item_Form.Free ;
    end;  }
   4://�ֿ�
    begin
       Item_Form:=TItem_Form.Create(application);
       DM.ADOQuery1.Close ;
       DM.ADOQuery1.SQL.Clear ;
       DM.ADOQuery1.SQL.text :=
       'SELECT code as �ֿ����,location as �ֿ����� FROM Data0016' ;
       DM.ADOQuery1.open ;
       Item_Form.Label2.Caption := '7';
       Item_Form.DBGridEh1.Columns[0].FieldName :='�ֿ����';
       Item_Form.DBGridEh1.Columns[1].FieldName :='�ֿ�����';
        if Item_Form.ShowModal=mrok then
         begin
            EdKC.Text:=dm.ADOQuery1.Fields[0].Value;
            BtKC.Enabled:=true;
            BtKC.SetFocus;
          end
        else
          EdKC.SetFocus;
         Item_Form.Free ;
    end; 
   5://����
    begin
       Item_Form:=TItem_Form.Create(application);
       DM.ADOQuery1.Close ;
       DM.ADOQuery1.SQL.Clear ;
       DM.ADOQuery1.SQL.text :=
       'SELECT DEPT_CODE as ���Ŵ���,DEPT_name as �������� FROM Data0034' ;
       DM.ADOQuery1.open ;
       Item_Form.Label2.Caption := '8';
       Item_Form.DBGridEh1.Columns[0].FieldName :='���Ŵ���';
       Item_Form.DBGridEh1.Columns[1].FieldName :='��������';
        if Item_Form.ShowModal=mrok then
         begin
           EdKC.Text:=dm.ADOQuery1.Fields[0].Value;
           BtKC.Enabled:=true;
           BtKC.SetFocus;
          end
        else
          EdKC.SetFocus;
         Item_Form.Free ;
      end;
  end;
end;

//����������
procedure TMain_Form.KCupdate_sgrid(const plisB:Tlistbox;const pEdit:TEdit;
 pdtp1:TDateTimePicker;
 pdtp2:TDateTimePicker;
 sgrid_row: byte);
 var sTp:string;
 i:Integer;
begin
sgrid1.Cells[0,sgrid_row]:=plisB.Items[plisB.itemindex];
 sgrid1.Cells[1,sgrid_row]:=pEdit.Text;
 case plisB.ItemIndex of
 0:
   case radiogroup4.ItemIndex of
      0: sgrid1.Cells[2,sgrid_row]:=' Data0007.PR_GRP_CODE  = '''+trim(edKC.Text)+'''';
      1:sgrid1.Cells[2,sgrid_row]:=' Data0007.PR_GRP_CODE  LIKE ''%'+trim(edKC.Text)+'%''';
   end;
 1:
    case radiogroup4.ItemIndex of
      0: sgrid1.Cells[2,sgrid_row]:=' Data0008.PROD_CODE = '''+trim(edKC.Text)+'''';
      1: sgrid1.Cells[2,sgrid_row]:=' Data0008.PROD_CODE LIKE ''%'+trim(edKC.Text)+'%''';
    end;
 2: case radiogroup4.ItemIndex of
      0: sgrid1.Cells[2,sgrid_row]:=' Data0008.PRODUCT_NAME = '''+trim(edKC.Text)+'''';
      1: sgrid1.Cells[2,sgrid_row]:=' Data0008.PRODUCT_NAME LIKE ''%'+trim(edKC.Text)+'%''';
    end;
 3: case radiogroup4.ItemIndex of
      0: sgrid1.Cells[2,sgrid_row]:=' Data0008.PRODUCT_DESC = '''+trim(edKC.Text)+'''';
      1: sgrid1.Cells[2,sgrid_row]:=' Data0008.PRODUCT_DESC LIKE ''%'+trim(edKC.Text)+'%''';
    end;
 4://�ֿ�
    case radiogroup4.ItemIndex of
      0: sgrid1.Cells[2,sgrid_row]:=' Data0016.CODE = '''+trim(edKC.Text)+'''';
      1: sgrid1.Cells[2,sgrid_row]:=' Data0016.CODE LIKE ''%'+trim(edKC.Text)+'%''';
    end;
 5:
   case radiogroup4.ItemIndex of
      0: sgrid1.Cells[2,sgrid_row]:=' Data0034.DEPT_CODE = '''+trim(edKC.Text)+'''';
      1: sgrid1.Cells[2,sgrid_row]:=' Data0034.DEPT_CODE LIKE ''%'+trim(edKC.Text)+'%''';
   end;
 6://20160301������
   begin
     sTp:='';
     for i:=0 to GroupBox4.ControlCount-1 do
     if TCheckBox(GroupBox4.Controls[i]).Checked then
       sTp:=sTp+inttostr(TCheckBox(GroupBox4.Controls[i]).Tag)+',';
     sgrid1.Cells[1,sgrid_row]:=copy(sTp,1,length(sTp)-1);
     sgrid1.Cells[2,sgrid_row]:=' and Data0008.TTYPE in ('+sTp+'159)';
   end;
 end;//end case
end;

procedure TMain_Form.BtKCClick(Sender: TObject);
var sTp:string;
 i:byte;
begin
 if (edKC.Text ='') and (edKC.Visible =true) then //����ֵΪ��
    begin
      messagedlg('����ֵ����Ϊ��!',mtinformation,[mbok],0);
      exit;
    end;
    
for i:=1 to sgrid1.RowCount-2 do
  if sgrid1.Cells[0,i]=listbKC.Items[listbKC.itemindex]  then
   begin
    self.KCupdate_sgrid(listbKC,edKC,dtpKC1,dtpKC2,i);
    exit;
   end;

 sgrid1.Cells[0,sgrid1.RowCount-1]:=listbKC.Items[listbKC.itemindex];
 sgrid1.Cells[1,sgrid1.RowCount-1]:=edKC.Text;
 case listbKC.ItemIndex of
  0:
   case radiogroup4.ItemIndex of
      0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' and Data0007.PR_GRP_CODE  = '''+trim(edKC.Text)+'''';
      1:sgrid1.Cells[2,sgrid1.RowCount-1]:=' and Data0007.PR_GRP_CODE  LIKE ''%'+trim(edKC.Text)+'%''';
   end;
 1:
    case radiogroup4.ItemIndex of
      0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' and Data0008.PROD_CODE = '''+trim(edKC.Text)+'''';
      1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' and Data0008.PROD_CODE LIKE ''%'+trim(edKC.Text)+'%''';
    end;
 2: case radiogroup4.ItemIndex of
      0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' and Data0008.PRODUCT_NAME = '''+trim(edKC.Text)+'''';
      1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' and Data0008.PRODUCT_NAME LIKE ''%'+trim(edKC.Text)+'%''';
    end;
 3: case radiogroup4.ItemIndex of
      0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' and Data0008.PRODUCT_DESC = '''+trim(edKC.Text)+'''';
      1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' and Data0008.PRODUCT_DESC LIKE ''%'+trim(edKC.Text)+'%''';
    end;
 4://�ֿ�
    case radiogroup4.ItemIndex of
      0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' and Data0016.CODE = '''+trim(edKC.Text)+'''';
      1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' and Data0016.CODE LIKE ''%'+trim(edKC.Text)+'%''';
    end;
 5:
   case radiogroup4.ItemIndex of
      0: sgrid1.Cells[2,sgrid1.RowCount-1]:=' and Data0034.DEPT_CODE = '''+trim(edKC.Text)+'''';
      1: sgrid1.Cells[2,sgrid1.RowCount-1]:=' and Data0034.DEPT_CODE LIKE ''%'+trim(edKC.Text)+'%''';
   end;
 6://20160301������
   begin
     sTp:='';
     for i:=0 to GroupBox4.ControlCount-1 do
     if TCheckBox(GroupBox4.Controls[i]).Checked then
       sTp:=sTp+inttostr(TCheckBox(GroupBox4.Controls[i]).Tag)+',';
     sgrid1.Cells[1,sgrid1.RowCount-1]:=copy(sTp,1,length(sTp)-1);
     sgrid1.Cells[2,sgrid1.RowCount-1]:=' and Data0008.TTYPE in ('+sTp+'159)';
//     if sTp<>'' then
//     begin
//       sgrid1.Cells[1,sgrid1.RowCount-1]:=copy(sTp,1,length(sTp)-1);
//       sgrid1.Cells[2,sgrid1.RowCount-1]:=' and Data0008.TTYPE in ('+sTp+'159)';
//     end;
   end;
 end;

 sgrid1.RowCount:=sgrid1.RowCount+1;
end;

procedure TMain_Form.ListBChangeClick(Sender: TObject);
begin
 label10.Visible:=false;
 label11.Visible:=false;
 dtpk7.Visible:=false;
 dtpk8.Visible:=false;
 RadioGroup5.Visible:=false;
 bitbtn7.Visible:=true;
 edit4.Visible:=true;
 edit4.Text:='';
 Button5.Enabled:=false;
 label12.Caption:=ListBChange.Items[ListBChange.itemindex];

 case ListBChange.ItemIndex of
 0:;
 1:
  begin
   label10.Visible:=true;
   label11.Visible:=true;
   dtpk7.Visible:=true;
   dtpk8.Visible:=true;
   bitbtn7.Visible:=false;
   edit4.Visible:=false;
   Button5.Enabled:=true;
  end;
 2:
  begin
   RadioGroup5.Visible:=true;
   bitbtn7.Visible:=false;
  end;
 3,4,5,6:
  begin

  end;
 end;
end;

procedure TMain_Form.Button5Click(Sender: TObject);
var
 i,j:byte;
 hasadded:boolean;//�����жϲ�ѯ��Ŀ�Ƿ������
begin
 hasadded:=false;
 for i:=1 to sgrid1.RowCount-2 do
  if sgrid1.Cells[0,i] = ListBChange.Items[ListBChange.itemindex] then
   begin
    hasadded:=true; //��ѯ��Ŀ�����
    j:=i;          //��������ӵĲ�ѯ��Ŀ��λ��
   end;
 if hasadded=false then //��ѯ��Ŀδ���������
  begin
   sgrid1.Cells[0,sgrid1.RowCount-1]:=ListBChange.Items[ListBChange.itemindex];
   sgrid1.Cells[1,sgrid1.RowCount-1]:=edit4.Text;
   case ListBChange.ItemIndex of
   0:
    sgrid1.Cells[2,sgrid1.RowCount-1]:='and t5.EMPL_CODE LIKE ''%'+trim(edit4.Text)+'%''';
   1:
    begin
    sgrid1.Cells[1,sgrid1.RowCount-1]:='��'+datetostr(dtpk7.date)+'��'+datetostr(dtpk8.date);
    sgrid1.Cells[2,sgrid1.RowCount-1]:=
     'and t113.TDATE between '''+datetostr(dtpk7.date)+''' and '''+datetostr(dtpk8.date+1)+'''';
    end;
   2:
    case RadioGroup5.ItemIndex of
     0:sgrid1.Cells[2,sgrid1.RowCount-1]:='and t113.quantity >'+trim(edit4.Text)+'';
     1:sgrid1.Cells[2,sgrid1.RowCount-1]:='and t113.quantity ='+trim(edit4.Text)+'';
     2:sgrid1.Cells[2,sgrid1.RowCount-1]:='and t113.quantity <'+trim(edit4.Text)+'';
    end;
   3:sgrid1.Cells[2,sgrid1.RowCount-1]:='and t16.code LIKE ''%'+trim(edit4.Text)+'%''';
   4:sgrid1.Cells[2,sgrid1.RowCount-1]:='and t16_1.code LIKE ''%'+trim(edit4.Text)+'%''';
   5:sgrid1.Cells[2,sgrid1.RowCount-1]:='and t8.PROD_CODE LIKE ''%'+trim(edit4.Text)+'%''';
   6:sgrid1.Cells[2,sgrid1.RowCount-1]:='and t8_1.PROD_CODE LIKE ''%'+trim(edit4.Text)+'%''';
   end;
   sgrid1.RowCount:=sgrid1.RowCount+1;
  end
 else    //��ѯ��Ŀ��������޸�
  begin
   sgrid1.Cells[1,j]:=edit4.Text;
   case ListBChange.ItemIndex of
   0:
    sgrid1.Cells[2,j]:='and t5.EMPL_CODE LIKE ''%'+trim(edit4.Text)+'%''';
   1:
    begin
    sgrid1.Cells[1,j]:='��'+datetostr(dtpk7.date)+'��'+datetostr(dtpk8.date);
    sgrid1.Cells[2,j]:=
     'and t113.TDATE>='''+datetostr(dtpk7.date)+''' and t113.TDATE<='''+datetostr(dtpk8.date+1)+'''';
    end;
   2:
    case RadioGroup5.ItemIndex of
     0:sgrid1.Cells[2,j]:='and t113.quantity >'+trim(edit4.Text)+'';
     1:sgrid1.Cells[2,j]:='and t113.quantity ='+trim(edit4.Text)+'';
     2:sgrid1.Cells[2,j]:='and t113.quantity <'+trim(edit4.Text)+'';
    end;
   3:sgrid1.Cells[2,j]:='and t16.code LIKE ''%'+trim(edit4.Text)+'%''';
   4:sgrid1.Cells[2,j]:='and t16_1.code LIKE ''%'+trim(edit4.Text)+'%''';
   5:sgrid1.Cells[2,j]:='and t8.PROD_CODE LIKE ''%'+trim(edit4.Text)+'%''';
   6:sgrid1.Cells[2,j]:='and t8_1.PROD_CODE LIKE ''%'+trim(edit4.Text)+'%''';
   end;
  end;
end;

procedure TMain_Form.BitBtn7Click(Sender: TObject);
  var InputVar: PDlgInput ;
begin
 frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
 try
  case ListBChange.ItemIndex of
    0:
    begin
      InputVar.Fields := 'empl_code/Ա�����/100,employee_name/Ա������/250';
      InputVar.Sqlstr :='select rkey,empl_code,employee_name from data0005 order by empl_code';
      inputvar.KeyField:='empl_code';
    end;
    
    3,4:
    begin
      InputVar.Fields := 'CODE/�ֿ����/200,LOCATION/�ֿ�����/250';
      InputVar.Sqlstr :='SELECT RKEY,CODE,LOCATION FROM Data0016 where location_type=1 ORDER BY CODE';
      inputvar.KeyField:='CODE';
    end;

    5,6:
    begin
      InputVar.Fields := 'PROD_CODE/��Ʒ���/100,PRODUCT_NAME/��Ʒ����/150,PRODUCT_DESC/��Ʒ���/200';
      InputVar.Sqlstr :='select RKEY,PROD_CODE,PRODUCT_NAME,PRODUCT_DESC from Data0008 '+
                        'order by PROD_CODE';
      inputvar.KeyField:='PROD_CODE';
    end;

  end;
  InputVar.AdoConn := dm.ADOConnection1 ;
  frmPick_Item_Single.InitForm_New(InputVar);
  if frmPick_Item_Single.ShowModal=mrok then
  begin
    case ListBChange.ItemIndex of
     0:begin
         edit4.Text:=trim(frmPick_Item_Single.adsPick.FieldValues['empl_code']);
         button5.Enabled:=true;
         button5.SetFocus;
       end;
     3,4:begin
         edit4.Text:=trim(frmPick_Item_Single.adsPick.FieldValues['CODE']);
         button5.Enabled:=true;
         button5.SetFocus;
       end;
     5,6:begin
         edit4.Text:=trim(frmPick_Item_Single.adsPick.FieldValues['PROD_CODE']);
         button5.Enabled:=true;
         button5.SetFocus;
       end;
    end;
  end ;
 finally
   frmPick_Item_Single.Free ;
 end;
end;

procedure TMain_Form.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
  if ListBChange.ItemIndex=2 then
  if not (key in ['0'..'9','.',#8,#13]) then  //�ж��Ƿ���������
   abort
  else
  if key = chr(46) then      //�ж��Ƿ��ظ�����С����'.'
    if pos('.',edit4.Text)>0
     then abort;
end;

procedure TMain_Form.Edit4KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if trim(edit4.Text)<>'' then
    button5.Enabled:=true
  else
    button5.Enabled:=false;
end;

procedure TMain_Form.RGp4Click(Sender: TObject);
var i:Integer;
begin
  if (RGp4.Visible=True) then
  begin
    if (RGp4.Items[RGp4.ItemIndex] = '����') then
    begin
//      SGrid1.RowCount:=2;
//      SGrid1.Rows[1].Clear;
      if RadioGroup1.Items[RadioGroup1.ItemIndex] = '��Ʒ���' then
      begin
        GroupBIn.Visible :=true;
        GroupBout.Visible :=false;
        GroupBKC.Visible :=false;
        GroupBChange.Visible:= False;
        ComboBox2.Visible:=False;
        ListBox1.Items.Clear;
        v_Field_List_CN := VarArrayOf(['�����Ա','���ʱ��','���첿��','��������','�������']);
        v_Field_List_EN := VarArrayOf(['Data0005.EMPL_CODE','data0416.sys_date','Data0034.DEPT_CODE','data0416.warehouse_ptr','data0416.type']);
        for i:= VarArrayLowBound(v_Field_List_CN,1) to VarArrayHighBound(v_Field_List_CN,1) do
          ListBox1.Items.Add(v_Field_List_CN[i]);
      end else
      if RadioGroup1.Items[RadioGroup1.ItemIndex] = '��Ʒ����' then
      begin
        GroupBIn.Visible :=false;
        GroupBout.Visible :=true;
        GroupBKC.Visible :=false;
        GroupBChange.Visible:= False;
        ComboBox2.Visible:=False;
        ListBOut.Items.Clear;
        v_Field_List_CN := VarArrayOf(['������Ա','��������','�����Ա','��������','�ͻ�����','����״̬']);
       // v_Field_List_EN := VarArrayOf(['Data0005.EMPL_CODE','wzcp0060.sales_date','Data0005_1.EMPL_CODE','WZCP0060.type','Data0010.CUST_CODE','WZCP0060.status']);
         v_Field_List_EN := VarArrayOf(['Data0005.EMPL_CODE','wzcp0063.sales_date','Data0005_1.EMPL_CODE','WZCP0060.type','Data0010.CUST_CODE','WZCP0060.status']);
        for i:= VarArrayLowBound(v_Field_List_CN,1) to VarArrayHighBound(v_Field_List_CN,1) do
          ListBOut.Items.Add(v_Field_List_CN[i]);
      end;
    end;
    if (RGp4.Items[RGp4.ItemIndex] = '��ϸ') then
    begin
//      SGrid1.RowCount:=2;
//      SGrid1.Rows[1].Clear;
      if RadioGroup1.Items[RadioGroup1.ItemIndex] = '��Ʒ���' then
      begin
        GroupBIn.Visible :=true;
        GroupBout.Visible :=false;
        GroupBKC.Visible :=false;
        GroupBChange.Visible:= False;
        ComboBox2.Visible:=False;
        ListBox1.Items.Clear;
          v_Field_List_CN := VarArrayOf(['��Ʒ����','��Ʒ����','��Ʒ����','��Ʒ���','��ⵥ��','�������','�����Ա','�ֿ�����','���첿��','��������','��������']);
          v_Field_List_EN := VarArrayOf(['Data0007.PR_GRP_CODE','Data0008.PROD_CODE','Data0008.PRODUCT_NAME','Data0008.PRODUCT_DESC','Data0416.number','Data0416.sys_date','Data0005.EMPL_CODE','Data0016.CODE','Data0034.DEPT_CODE','Data0492.CUT_NO','Data0416.warehouse_ptr']);
          for i:= VarArrayLowBound(v_Field_List_CN,1) to VarArrayHighBound(v_Field_List_CN,1) do
            ListBox1.Items.Add(v_Field_List_CN[i]);
        ListBox1.itemindex :=0;
        edout.Text :='';
        Self.ListBox1Click(Sender);
        RGp4.Visible:=True;
        RGp4.ItemIndex:=0;
      end else
      if RadioGroup1.Items[RadioGroup1.ItemIndex] = '��Ʒ����' then
      begin
        GroupBIn.Visible :=false;
        GroupBout.Visible :=true;
        GroupBKC.Visible :=false;
        GroupBChange.Visible:= False;
        ComboBox2.Visible:=False;
          ListBOut.Items.Clear;
          v_Field_List_CN := VarArrayOf(['��Ʒ����','��Ʒ����','��Ʒ����','��Ʒ���','���ⵥ��','��������','�����������','������Ա','�ֿ�����','�ͻ�����','��������','��������']);
         // v_Field_List_EN := VarArrayOf(['Data0007.PR_GRP_CODE','Data0008.PROD_CODE','Data0008.PRODUCT_NAME','Data0008.PRODUCT_DESC','WZCP0060.sales_order','wzcp0060.sales_date','wzcp0060.CONF_DATE','Data0005.EMPL_CODE','Data0016.CODE','Data0010.CUST_CODE','wzcp0060.type','data0492.CUT_NO']);
          v_Field_List_EN := VarArrayOf(['Data0007.PR_GRP_CODE','Data0008.PROD_CODE','Data0008.PRODUCT_NAME','Data0008.PRODUCT_DESC','WZCP0060.sales_order','wzcp0063.sales_date','wzcp0060.CONF_DATE','Data0005.EMPL_CODE','Data0016.CODE','Data0010.CUST_CODE','wzcp0060.type','data0492.CUT_NO']);
          for i:= VarArrayLowBound(v_Field_List_CN,1) to VarArrayHighBound(v_Field_List_CN,1) do
            ListBOut.Items.Add(v_Field_List_CN[i]);
        listbout.itemindex :=0;
        edout.Text :='';
        Self.ListBOutClick(Sender);
        RGp4.Visible:=True;
        RGp4.ItemIndex:=0;
      end;
    end;
  end;
end;

end.

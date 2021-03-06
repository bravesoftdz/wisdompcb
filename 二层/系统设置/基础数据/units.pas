unit units;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGridEh, ExtCtrls, Menus, DB, ADODB;

type
  Tfm_unit = class(TForm)
    Panel1: TPanel;
    btn1: TBitBtn;
    btn2: TBitBtn;
    btn3: TBitBtn;
    lb_search: TLabel;
    edt1: TEdit;
    db_gridh: TDBGridEh;
    pm1: TPopupMenu;
    new: TMenuItem;
    edit: TMenuItem;
    delete: TMenuItem;
    procedure btn1Click(Sender: TObject);
    procedure db_gridhTitleClick(Column: TColumnEh);
    procedure btn2Click(Sender: TObject);
    procedure edt1Change(Sender: TObject);
    procedure newClick(Sender: TObject);
    procedure editClick(Sender: TObject);
    procedure deleteClick(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  precolumn:Tcolumneh;
  fm_unit: Tfm_unit;
  flag : Boolean;

implementation

uses
demo, mad, common;


{$R *.dfm}

procedure Tfm_unit.btn1Click(Sender: TObject);
begin
    Close;
end;

procedure Tfm_unit.db_gridhTitleClick(Column: TColumnEh);
begin
   if column.Title.SortMarker=smupeh then   //改变DBGRirdEH控件SortMarker属性的值达到切换正逆序排序目的
     begin
       column.Title.SortMarker:=smdowneh;
       DM.dsADS02.IndexFieldNames := Column.DisplayName + ' DESC';     //逆序排序
     end
   else
     begin
       column.Title.SortMarker:=smupeh;
       DM.dsADS02.IndexFieldNames := Column.DisplayName;
     end;
  if (precolumn.FieldName <> column.FieldName) and
     (Column.Field.DataType in [ftString,ftWideString]) then
   begin
    precolumn.Title.Color:=clbtnface;
    lb_search.Caption := '搜索: ' + column.Title.Caption;
    column.Title.Color:=clred;
    precolumn:=column;
    edt1.Text:='';
   end
end;

procedure Tfm_unit.btn2Click(Sender: TObject);
begin
    dm.dsADS02.Close;
    dm.dsADS02.Open;
end;

procedure Tfm_unit.edt1Change(Sender: TObject);
begin

if (trim(edt1.Text)<>'')then
begin
   DM.dsADS02.Filtered := True;        //打开过滤器
   DM.dsADS02.Filter:=precolumn.FieldName+' like ''%'+trim(edt1.text)+'%'''   //添加过滤条件
end
else
   DM.dsADS02.Filtered :=false;
end;


procedure Tfm_unit.newClick(Sender: TObject);
begin


    fm_mad:=Tfm_mad.Create(application);   //创建窗体
    try
//       fm_mad:=Tfm_mad.Create(application);
       DM.dsADS02.Append;
       DM.strngfldADS02prod.value := 'N';
       DM.strngfldADS02purch.value := 'N';
       DM.strngfldADS02stock.value := 'N';
       DM.strngfldADS02quote.value := 'N';



       fm_mad.Caption := '添加单位';
    if fm_mad.ShowModal()=mrok then
       MessageBox(0,'单位添加成功','提示',MB_ICONINFORMATION+MB_OK);
    finally                 //无论是否出现异常依然运行以下代码
       fm_mad.Free;         //释放窗体（完全关闭）

    end
 
end;

procedure Tfm_unit.editClick(Sender: TObject);
begin

    fm_mad:=Tfm_mad.Create(application);
    try
    DM.dsADS02.Edit;
    fm_mad.Caption := '修改单位';
    if  fm_mad.ShowModal()=mrok then
     MessageBox(0,'单位修改成功','提示',MB_ICONINFORMATION+MB_OK);
    finally
     fm_mad.Free;
    end

end;

procedure Tfm_unit.deleteClick(Sender: TObject);
begin


   if MessageBox(0,'你确定要删除吗？','提示',MB_ICONINFORMATION+MB_YESNO)= idYES then
      begin
        try
          DM.dsADS02.Delete;
//          MessageBox(0,'单位删除成功','提示',MB_ICONINFORMATION+MB_OK);
        except
          MessageBox(0,'该单位已发生业务,无法删除','警告',MB_ICONEXCLAMATION+MB_OK);
          Abort;
        end;
        MessageBox(0,'单位删除成功','提示',MB_ICONINFORMATION+MB_OK);
      end
  
end;

procedure Tfm_unit.btn3Click(Sender: TObject);
begin
      export_dbgrideh_to_excel(db_gridh,self.Caption);
end;



procedure Tfm_unit.FormCreate(Sender: TObject);
begin

  if not app_init(DM.cn_adocon) then
  begin
    showmsg('程序启动失败，请联系系统管理员！','提示',1);
    application.Terminate;
  end;

//  vprev:='4' ;



end;

procedure Tfm_unit.FormActivate(Sender: TObject);
begin
  DM.dsADS02.Close;
  DM.dsADS02.Open;
  precolumn:=db_gridh.Columns[0]; //给precolumn赋初始值
  lb_search.Caption := '搜索: ' + precolumn.Title.Caption;

  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    begin
      new.Enabled:=False;
      edit.Enabled:=False;
      delete.Enabled:=False;
    end;

end;

end.



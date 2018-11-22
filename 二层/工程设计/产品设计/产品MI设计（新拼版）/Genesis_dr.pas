unit Genesis_dr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils, StdConvs,ShellAPI,Grids, Registry;

type
  Phole = ^Thole;
  Thole = record     //P 0.25998 0.03508 0 P 1 0
  tool:integer;
  holetype:SHORT;
  end;
  Pslot = ^Tslot;
  Tslot = record     //P 0.25998 0.03508 0 P 1 0
  tool:integer;
  slotlen:double;
  slottype:SHORT;
  end;
  Pdrlsize=^Tdrlsize;
  Tdrlsize = record
  tool:integer;
  drltype:SHORT;
  slotype:SHORT;
  size:Extended;
  slotlen:Extended;
  drlsum:integer;
  slotsum:integer;
  end;

type
  TForm_Genesis = class(TForm)
    Label3: TLabel;
    Label4: TLabel;
    pth: TComboBox;
    npth: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    bzpth: TComboBox;
    bznpth: TComboBox;
    isvia: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    filepath: TEdit;
    jobname: TEdit;
    ziped: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    fpath,jobpath,progdir:string;
    drlpnp:integer;                 //��ʾ������Ե����Ա��
//    crttil:integer;                 //��ǰ��ͷ��ʽ
    holelist: array of  Thole;      //�ױ�
    slotlist: array of Tslot;       //�۱�
    drillsize: array of Tdrlsize;   //��״�С�б�
    procedure killexe7z();
    function drldes(origdrlsize:Extended;resvalue:string):string;
    function un7zip():Boolean;
    function Toolchar(num:Integer):string;
    procedure listdrl(dist:TStringGrid);
    procedure init();
    function analysis(drfpath:string):Boolean;
  public
    { Public declarations }
  end;


var
  Form_Genesis: TForm_Genesis;

const step:string='orig';      //ԭ��STEP������
const layer:string='1st';      //���������
const exe7z:string='7z.exe';   //7Z��ѹ��������
const fdrfmt:string='0.000';   //��ɿ׾�С����ʽ
const drlfmt:string='0.00';    //��״�СС����ʽ
const slnfmt:string='0.00';    //�ۿ׳���С����ʽ
const resup:Extended=0.025;   //��������Ӵ����  ͨ��Ϊ��׽�����1/2

  function splite(instr:string;var outsl:TStringList;ctype:integer):bool;

implementation

uses product_MIDetail;

{$R *.dfm}
procedure TForm_Genesis.killexe7z();
begin
     ShellExecute(GetDesktopWindow,
                  nil,
                  PChar('taskkill.exe'),
                  PChar('/F /IM '+exe7z+' /T'),
                  PChar(progdir),
                  SW_HIDE);
                  
end;

function TForm_Genesis.drldes(origdrlsize:Extended;resvalue:string):string;
// origdrlsize ԭʼ��״�С
// resvalue    ����ֵ 0.1 0.05
// Result      ���������״�С
var
   tmp:Extended;
begin
     tmp:=(origdrlsize+StrToFloat(resvalue))*20;
     if tmp-trunc(tmp)>resup*20 then
       Result:=FormatFloat(drlfmt,(trunc(tmp)+1)/20)
       else
       Result:=FormatFloat(drlfmt,(trunc(tmp))/20)
end;  

function TForm_Genesis.un7zip():Boolean;
var
   exeinfo:TShellExecuteInfo;
begin
     if FileExists(progdir+'tmp') then
     DeleteFile(progdir+'tmp');
     if ziped.Checked then
     begin 
     FillChar(exeinfo,SIZEOF(exeinfo),#0);
     exeinfo.cbSize:=sizeof(exeinfo);
     exeinfo.lpVerb:='open';
     exeinfo.lpFile:=pchar(exe7z);
     exeinfo.lpParameters:=pchar('e features.Z');
     exeinfo.fMask:=SEE_MASK_NOCLOSEPROCESS;
     exeinfo.lpDirectory:=pchar(progdir);
     exeinfo.Wnd:=GetDesktopWindow;
     exeinfo.nShow:=SW_HIDE;
     if ShellExecuteEx(@exeinfo) then
        WaitForSingleObject(exeinfo.hProcess,INFINITE);
     end;
     if FileExists(progdir+'features.z') then
        DeleteFile(progdir+'features.z');
     if FileExists(progdir+'features') then
        begin
        RenameFile(progdir+'features',progdir+'tmp');
        DeleteFile(progdir+'features');
        end;
     if FileExists(progdir+'tmp') then
        Result:=true
        else
        Result:=false;
end;

function TForm_Genesis.Toolchar(num:Integer):string;
var
  t1,t2:integer;
  tmp:string;
begin

        t1:=num div 27;
        t2:=num mod 27;
       if t1<>0 then
       tmp:=chr(64+t1)+chr(65+t2)
       else
       tmp:=chr(64+t2);
       Result:=tmp;
end;

procedure TForm_Genesis.listdrl(dist:TStringGrid);
var
  i,nrow:Integer;
//  tmp:string;
begin
    //�г����

    for i:=0 to High(drillsize) do
     if drillsize[i].drlsum>0 then
     begin
       nrow:=dist.RowCount-1;
       dist.RowCount:=dist.RowCount+1;
       dist.Cells[0,nrow]:=IntToStr(nrow);                            //��� ���� ������Ϊ��
       dist.Cells[1,nrow]:='T'+IntToStr(nrow);                        //T���
       dist.Cells[2,nrow]:=Toolchar(nrow);//chr(64+nrow);                              // ��ĸ���ñ��
       dist.Cells[3,nrow]:=FloatToStr(drillsize[i].size);             // ԭʼ��״�С ��ɿ׾�
       if drillsize[i].drltype=1 then  // ������ 0 PTH 1 NPTH 2 VIA
          begin
                dist.Cells[4,nrow]:='N';                                    //�������  �ǵ��
                dist.Cells[5,nrow]:=bznpth.Text;                              //����
                dist.Cells[6,nrow]:=drldes(drillsize[i].size,npth.text);    //��������״�С
          end
       else
           begin
                dist.Cells[4,nrow]:='Y';                                    //�������
                if (drillsize[i].drltype=2) and (isvia.checked) then
                begin                                       //������Ϊ2 VIA�� ѡ����ײ�����
                     dist.Cells[5,nrow]:='/';               //����Ϊ '/'
                     dist.Cells[6,nrow]:=drldes(drillsize[i].size,'0');  //������0����
                end
                else
                begin
                    dist.Cells[5,nrow]:=bzpth.Text;                          //����
                    dist.Cells[6,nrow]:=drldes(drillsize[i].size,pth.text);     //��pth����
                end;
           end;
       dist.Cells[7,nrow]:=IntToStr(drillsize[i].drlsum);        //��Ƭ����
     end;

        //�г��ۿ�
    for i:=0 to High(drillsize) do
     if drillsize[i].slotsum>0 then
     begin
       nrow:=dist.RowCount-1;
       dist.RowCount:=dist.RowCount+1;
       dist.Cells[0,nrow]:=IntToStr(nrow);                            //��� ���� ������Ϊ��
       dist.Cells[1,nrow]:='T'+IntToStr(nrow);                        //T���
       dist.Cells[2,nrow]:=chr(64+nrow);                              // ��ĸ���ñ��
       dist.Cells[3,nrow]:=FloatToStr(drillsize[i].size);             // ԭʼ��״�С ��ɿ׾�
       if drillsize[i].slotype=1 then  // ������ 0 PTH 1 NPTH 2 VIA
          begin
                dist.Cells[4,nrow]:='N';                                    //�������  �ǵ��
                dist.Cells[5,nrow]:=bznpth.text;                              //����
                dist.Cells[6,nrow]:=drldes(drillsize[i].size,npth.text);    //��������״�С
             //   tmp:=npts.Text;
             //   dist.Cells[11,nrow]:= FormatFloat(slnfmt,drillsize[i].slotlen+StrToFloat(tmp))+'*'+dist.Cells[6,nrow];
          end
       else
           begin
                dist.Cells[4,nrow]:='Y';                                    //�������
                dist.Cells[5,nrow]:=bzpth.Text;                          //����
                dist.Cells[6,nrow]:=drldes(drillsize[i].size,pth.text);     //��pth����
            //    tmp:=pts.Text;
              //  dist.Cells[11,nrow]:=FormatFloat(slnfmt,drillsize[i].slotlen+StrToFloat(tmp))+'*'+dist.Cells[6,nrow];
           end;
       dist.Cells[7,nrow]:=IntToStr(drillsize[i].slotsum);        //��Ƭ�ۿ���
      // dist.Cells[11,nrow]:= FormatFloat(slnfmt,drillsize[i].slotlen)+'*'+FormatFloat(drlfmt,drillsize[i].size);

     end;
end;

procedure TForm_Genesis.init();
begin
  drlpnp:=5;
  SetLength(holelist,0);
  SetLength(slotlist,0);
  SetLength(drillsize,0);
end;

function splite(instr:string;var outsl:TStringList;ctype:integer):bool;
var
   cc:integer;
begin
     Result:=False;
     outsl:=TStringList.create;
     cc:=0;
     case ctype of
     0: cc:= ExtractStrings([' '],[],pchar(instr),outsl);
     1: cc:= ExtractStrings([';'],[],pchar(instr),outsl);
     2: cc:= ExtractStrings([','],[],pchar(instr),outsl);
     end;
     if cc>0 then
     Result:=True;     
end;

function TForm_Genesis.analysis(drfpath:string):Boolean;
{
#
#Feature symbol names
#
$0 r10

#
#Feature attribute names
#
@0 .geometry
@1 .drill     ��DRILL�� ���Ǳ�ʾ������Եı�� ������1

#
#Layer features
#
P 0.3937 4.2126 20 P 24 0;0=0,1=1
}
var
   i,j,di:integer;
   ds: double;

   linecontext:string;
   alltext,lc,alist:TStringList;
begin
         init();
         alltext:=TStringList.Create;
         alltext.LoadFromFile(drfpath);
         if alltext[0]='#' then
         begin
         for i:=0 to alltext.Count-1 do
          begin
          linecontext:=alltext[i];
          if length(linecontext)>0 then
            begin
                 case linecontext[1] of
                 '$': begin //---������״�С�б�����---//
                        SetLength(drillsize,length(drillsize)+1);
                        splite(RightStr(linecontext,length(linecontext)-1),lc,0);
                        drillsize[High(drillsize)].tool:=StrToInt(lc.Strings[0]);
                        ds:=StrToFloat(RightStr(lc.Strings[1],length(lc.Strings[1])-1));
                        drillsize[High(drillsize)].size:=StrToFloat(formatfloat(fdrfmt,ds*0.0254));
                      end;

                 '@': begin //---���»�ñ�ʾ������Ե����Ա��---//  drlpnp
                            //--- @1 .drill       ----------------//  drlpnp
                            splite(RightStr(linecontext,length(linecontext)-1),lc,0);
                            if  lc.Strings[1]='.drill' then
                            drlpnp:=StrToInt(lc.Strings[0]);
                      end;
                 'P': begin  {P 0.3937 4.2126 20 P 24 0;0=0,1=1}
                      splite(linecontext,lc,0);
                      di:=StrToInt(lc.Strings[3]);
                      drillsize[di].drlsum:=drillsize[di].drlsum+1;

                      if drlpnp<>5 then
                      if drillsize[di].drltype=0 then
                         begin
                         splite(lc.Strings[6],alist,1);
                         splite(alist[1],alist,2);
                         for j:=0 to alist.Count-1 do
                             begin
                             if LeftStr(alist[j],length(IntToStr(drlpnp))+1)=IntToStr(drlpnp)+'=' then
                                drillsize[di].drltype:=StrToInt(RightStr(alist[j],1));
                             end;
                         end;
                       end;
                     {SetLength(holelist,length(holelist)+1);
                      splite(linecontext,lc,0);
                      tmph.tool:=StrToInt(lc.Strings[3]);
                               if drlpnp=5 then
                                  tmph.holetype:=0
                                  else
                                  begin
                                  splite(lc.Strings[6],alist,1);
                                  splite(alist[1],alist,2);
                                  for j:=0 to alist.Count-1 do
                                      begin
                                      if LeftStr(alist[j],length(IntToStr(drlpnp))+1)=IntToStr(drlpnp)+'=' then
                                      tmph.holetype:=StrToInt(RightStr(alist[j],1));
                                      end;
                                  end;
                      holelist[High(holelist)]:=tmph;
                      end;}
                 'L': begin
                           splite(linecontext,lc,0);
                           di:=StrToInt(lc.Strings[5]);
                           drillsize[di].slotsum:=drillsize[di].slotsum+1;
{                           if drillsize[di].slotlen=0 then
                           begin
                                drillsize[di].slotlen:=sqrt(
                                                            sqr(StrToFloat(lc.Strings[4])-StrToFloat(lc.Strings[2]))
                                                           +sqr(StrToFloat(lc.Strings[3])-StrToFloat(lc.Strings[1]))
                                                            )*25.4;
                           end;
}
                      if drlpnp<>5 then
                         if drillsize[di].slotype=0 then
                         begin
                           splite(RightStr(lc.Strings[8],length(lc.Strings[8])-1),alist,2);
                           for j:=0 to alist.Count-1 do
                           begin
                                if LeftStr(alist[j],length(IntToStr(drlpnp))+1)=IntToStr(drlpnp)+'=' then
                                drillsize[di].slotype:=StrToInt(RightStr(alist[j],1));
                           end;
                         end;
                      end;

                     {SetLength(slotlist,length(slotlist)+1);
                      splite(linecontext,lc,0);
                      tmps.slotlen:=sqrt(
                                                sqr(StrToFloat(lc.Strings[4])-StrToFloat(lc.Strings[2]))
                                              + sqr(StrToFloat(lc.Strings[3])-StrToFloat(lc.Strings[1]))
                                                 )*25.4;
                      tmps.tool:=StrToInt(lc.Strings[5]);
                      if  drlpnp=5 then
                      tmps.slottype:=0
                      else
                      begin
                           splite(RightStr(lc.Strings[8],length(lc.Strings[8])-1),alist,2);

                           //splite(alist[1],alist,2);
                           for j:=0 to alist.Count-1 do
                           begin
                                if LeftStr(alist[j],length(IntToStr(drlpnp))+1)=IntToStr(drlpnp)+'=' then
                                tmps.slottype:=StrToInt(RightStr(alist[j],1));
                           end;
                      end;
                      slotlist[High(slotlist)]:=tmps;
                      end; }
                 end;//case
            end;
          end;

          result:=true;
         end else
          result:=false;

          alltext.Free;
end;

procedure TForm_Genesis.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     if FileExists(progdir+'tmp') then
     DeleteFile(progdir+'tmp');
end;

procedure TForm_Genesis.FormCreate(Sender: TObject);
var
   gd,linecontext:string;
   dbfile:TextFile;
//   strgttl:string;
//   titelist:TStringList;
begin
      progdir:=ExtractFilePath(Application.ExeName);
     if FileExists(progdir+'tmp') then
     DeleteFile(progdir+'tmp');
     if FileExists(progdir+'features.z') then
     DeleteFile(progdir+'features.z');
     try
        ExpandEnvironmentStrings(PChar('%GENESIS_DIR%\sys\dblist'),PChar(gd),1024);
        gd:=trim(gd);
     except
        with TRegistry.Create do
        try
          RootKey := HKEY_LOCAL_MACHINE;
          OpenKey('SYSTEM\CurrentControlSet\Control\Session ' +
                  'Manager\Environment', False);
          gd:=ReadString('GENESIS_DIR');
        except
           ShowMessage('û�а�װGENESIS����ʹ�ô˹���');
           Exit;
        end;
     end;
     AssignFile(dbfile, gd+'\sys\dblist');
     Reset(dbfile);
     while not Eof(dbfile) do
     begin
          Readln(dbfile,linecontext);
          linecontext:=Trim(linecontext);
          if LeftStr(linecontext,5)='PATH=' then 
          begin
          jobpath:=RightStr(linecontext,length(linecontext)-5)+'/jobs/';
          jobpath:=StringReplace(jobpath,'/','\',[rfReplaceAll]); 
          break;      
          end;
     end;
end;



procedure TForm_Genesis.Button1Click(Sender: TObject);
begin
     killexe7z();
     fpath:=jobpath+jobname.Text+'\steps\'+step+'\layers\'+layer+'\features';
     if not FileExists(fpath) then
     begin
        fpath:=fpath+'.z';
        if not FileExists(fpath) then
        begin
          ShowMessage('�޷���λ����ļ�');
          ziped.Checked:=false;
          exit;
        end else
          ziped.Checked:=true;
     end else ziped.Checked:=false;
     filepath.Text:=fpath;
     if ziped.Checked then
     CopyFileEx(pchar(fpath),pchar(progdir+'features.z'),nil,nil,nil,COPY_FILE_RESTARTABLE)
     else CopyFileEx(pchar(fpath),pchar(progdir+'features'),nil,nil,nil,COPY_FILE_RESTARTABLE);
end;

procedure TForm_Genesis.Button2Click(Sender: TObject);
var
 i:integer;
begin
if filepath.Text='' then
 showmessage('���ȶ�ȡ����ļ�·��!')
else
   if not un7zip() then
    begin
     ShowMessage('����ļ���ռ�ã��޷�����');
    end
   else
    begin
     if analysis(progdir+'tmp') then
      with form2.fsg do for i := 1 to RowCount - 1 do Rows[i].Clear;
      form2.fsg.RowCount:=2;
      listdrl(form2.fsg);
      self.ModalResult:=mrok;
    end;
end;

end.

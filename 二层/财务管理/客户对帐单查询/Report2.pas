unit Report2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppModule, raCodMod, ppBands, ppCtrls, ppVar, ppPrnabl, ppClass,
  ppCache, ppProd, ppReport, ppDB, ppComm, ppRelatv, ppDBPipe, DB, ADODB,
  StdCtrls, ppStrtch, ppMemo;

type
  TFrmReport2 = class(TForm)
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    Data0493: TppDBPipeline;
    ppReport1: TppReport;
    DataSource2: TDataSource;
    Data0112: TppDBPipeline;
    Data0116: TppDBPipeline;
    ppHeaderBand2: TppHeaderBand;
    ppDBText23: TppDBText;
    ppDBText24: TppDBText;
    ppDBText25: TppDBText;
    ppDBText26: TppDBText;
    ppLabel17: TppLabel;
    ppDBImage2: TppDBImage;
    ppLabel34: TppLabel;
    ppDetailBand2: TppDetailBand;
    ppDBText13: TppDBText;
    ppDBText15: TppDBText;
    ppDBText7: TppDBText;
    ppDBText14: TppDBText;
    ppDBText8: TppDBText;
    ppDBText1: TppDBText;
    ppDBText3: TppDBText;
    ppDBMemo1: TppDBMemo;
    ppFooterBand2: TppFooterBand;
    ppLabel24: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    ppLabel20: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppDBText30: TppDBText;
    ppDBText31: TppDBText;
    ppDBText32: TppDBText;
    ppDBText33: TppDBText;
    ppDBText34: TppDBText;
    ppLabel22: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppDBText4: TppDBText;
    ppDBText9: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppLabel21: TppLabel;
    ppLabel23: TppLabel;
    ppShape4: TppShape;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppShape5: TppShape;
    ppShape3: TppShape;
    ppLabel28: TppLabel;
    ppLabel30: TppLabel;
    ppLabel31: TppLabel;
    ppLabel32: TppLabel;
    ppLabel33: TppLabel;
    ppLabel35: TppLabel;
    ppLabel36: TppLabel;
    ppLabel37: TppLabel;
    ppLabel38: TppLabel;
    ppLabel39: TppLabel;
    ppLabel40: TppLabel;
    ppLine1: TppLine;
    ppDBText2: TppDBText;
    ppDBText18: TppDBText;
    ppDBText19: TppDBText;
    ppDBText20: TppDBText;
    ppDBText21: TppDBText;
    ppDBText22: TppDBText;
    ppDBText27: TppDBText;
    ppDBText28: TppDBText;
    ppDBText29: TppDBText;
    ppDBText35: TppDBText;
    ppDBText36: TppDBText;
    ppLabel1: TppLabel;
    ppVariable1: TppVariable;
    ppLabel29: TppLabel;
    ppLine3: TppLine;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppLabel7: TppLabel;
    ppLabel10: TppLabel;
    ppDBText10: TppDBText;
    ppLabel13: TppLabel;
    ppLabel9: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel25: TppLabel;
    ppLabel26: TppLabel;
    ppLabel27: TppLabel;
    ppShape2: TppShape;
    ppLabel2: TppLabel;
    ppLabel5: TppLabel;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppShape1: TppShape;
    raCodeModule1: TraCodeModule;
    procedure ppReport1PreviewFormCreate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmReport2: TFrmReport2;

implementation
uses main;
{$R *.dfm}

procedure TFrmReport2.ppReport1PreviewFormCreate(Sender: TObject);
begin
  ppReport1.PreviewForm.WindowState := wsMaximized;
end;

procedure TFrmReport2.FormCreate(Sender: TObject);
var
  Present: TDateTime;
  Year, Month, Day: Word;
begin
  Present:= FrmMain.DateTimePicker5.Date;
  DecodeDate(Present, Year, Month, Day);

  pplabel26.Caption :='From:'+datetostr(FrmMain.DateTimePicker4.Date+1);
  pplabel27.Caption :='To:'+datetostr(FrmMain.DateTimePicker5.Date);
  pplabel34.Caption :=inttostr(year)+'��'+inttostr(month)+'��';
end;

end.

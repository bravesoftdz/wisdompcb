unit uEnterMod_20;

interface
uses
  Vcl.Forms,Vcl.Controls;

procedure EnterMod(AParent: TWinControl; out outModMainFrm: TForm; AModID: Integer);stdcall;

exports
  EnterMod;

implementation

uses MainFrm_Mod36, MainFrm_ModAll, MainFrm_ModShipped, Tree_Mod564,UMainfrm_mod496,
    UMainFrm_Mod497, UMainfrm_Mod38Caller,Mainfrm_Mod33;


procedure EnterMod(AParent: TWinControl; out outModMainFrm: TForm; AModID: Integer);stdcall;
begin
  case AModID of
    36: //�����ϼ��
    begin
      if  checkPD_Mod36() then
        outModMainFrm := TfrmMain_Mod36.Create(AParent,AModID)
    end;
    40,41,352: //�˻�����Ӧ��
    begin
      outModMainFrm := TfrmMain_Mod40Caller.Create(AParent,AModID);
    end;
    50,353: //װ�˵���Ӧ��
    begin
      outModMainFrm := TfrmMain_Mod50Caller.Create(AParent,AModID);
    end;
    564: //��Ӧ��VMI������
    begin
      outModMainFrm := TfrmTree_Mod564.Create(AParent,AModID);
    end;
    496://������������
    begin
      outModMainFrm := TFrmMain_mod496.Create(AParent,AModID);
    end;
    497://�����������
    begin
      outModMainFrm := TFrmMain_Mod497.Create(AParent,AModID);
    end;
    38://���Ϸ��ż��˲�
    begin
      outModMainFrm := TfrmMain_Mod38Caller.Create(AParent,AModID);
    end;
    33://���ɹ��������
    begin
      outModMainFrm := TfrmMain_Mod33.Create(AParent,AModID);
    end;
  else
    outModMainFrm := nil;
  end;
end;

end.

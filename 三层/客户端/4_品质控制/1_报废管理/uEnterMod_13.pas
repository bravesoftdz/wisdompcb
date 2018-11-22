unit uEnterMod_13;

interface
uses
  Vcl.Forms,Vcl.Controls;

procedure EnterMod(AParent: TWinControl; out outModMainFrm: TForm; AModID: Integer);stdcall;

exports
  EnterMod;

implementation

 uses MainFrm_Mod664,Mainfrm_Mod705CheckMrg, PassNumber_Mod709,SPCRecord_mod711;


procedure EnterMod(AParent: TWinControl; out outModMainFrm: TForm; AModID: Integer);stdcall;
begin
  case AModID of
   664: //IQC���
   begin
      outModMainFrm := TfrmMain_Mod664.Create(AParent,AModID);
    end;
   705: //FQC���
   begin
    outModMainFrm := TFrmMain_Mod705CheckMrg.Create(AParent,AModID);
   end;
   709://��ת�ܿ�
   begin
     outModMainFrm:=TfrmPassNumber_Mod709.Create(AParent,AModID);
   end;
   711://SPC����¼
   begin
     outModMainFrm:=TfrmSPCRecord_mod711.Create(AParent,AModID);
   end;
  else
    outModMainFrm := nil;
  end;
end;

end.

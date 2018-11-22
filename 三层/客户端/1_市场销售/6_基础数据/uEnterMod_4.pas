unit uEnterMod_4;

interface
uses
  Vcl.Forms,Vcl.Controls;

procedure EnterMod(AParent: TWinControl; out outModMainFrm: TForm; AModID: Integer);stdcall;

exports
  EnterMod;

implementation
uses
 mainfrm_Mod83,mainfrm_mod086,MainFrm_Mod482;
 procedure EnterMod(AParent: TWinControl; out outModMainFrm: TForm; AModID: Integer);stdcall;
begin
  case AModID of
    83: //�ͻ���Ϣ����
    begin
      outModMainFrm := TfrmMain_Mod83.Create(AParent,AModID);
    end;
    86://���߷������
    begin
      outModMainFrm := TMainFrm_Mod86.Create(AParent,AModID);
    end;
    482:
    begin
     outModMainFrm := TfrmMainFrm_Mod482.Create(AParent,AModID);
    end;
  else
    outModMainFrm := nil;
  end;
end;
end.

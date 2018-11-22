unit uEnterMod_2;

interface
uses
  Vcl.Forms,Vcl.Controls;

procedure EnterMod(AParent: TWinControl; out outModMainFrm: TForm; AModID: Integer);stdcall;

exports
  EnterMod;

implementation
uses
 MainFrm_Mod291,MainFrm_Mod599,MainFrm_OrderEditMarket_mod354,Mainfrm_OrderEditSChe_mod284
 ,MainFrm_Mod72,EP027_mod73,MainFrm_Mod623;

procedure EnterMod(AParent: TWinControl; out outModMainFrm: TForm; AModID: Integer);stdcall;
begin
  case AModID of

    291:   //��������
    begin
      outModMainFrm := TfrmMain_Mod291.Create(AParent,AModID);
    end;
    599:   //�����ظ����ڸ���
    begin
      outModMainFrm := TfrmMain_Mod599.Create(AParent,AModID);
    end;
     284://�ƻ������޸Ķ���
    begin
      outModMainFrm := TfrmMain_OrderModiSChe_mod284.Create(AParent,AModID);
    end;
    354: //�г����޸Ķ���
    begin
      outModMainFrm := TfrmMain_OrderEditMarket_mod354.Create(AParent,AModID);
    end;
     72: //��������
    begin
      outModMainFrm := Tfrm_MainMod72.Create(AParent,AModID);
    end;
    73: //����ȷ��
    begin
      outModMainFrm := TForm_mod73.Create(AParent,AModID);
    end;
   623: //����Ԥ����
    begin
      outModMainFrm := TfrmMain_Mod623.Create(AParent,AModID);
    end;
    else
    outModMainFrm := nil;


  end;
end;



end.

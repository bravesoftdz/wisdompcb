
unit CalcParam;

interface
uses
  IniFiles, Classes;

type
  TZK = record
    W,H: Double;
  end;

  TCutParam = record
    SheetW,SheetH: Double;
    PnlAMinW,PnlAMinH,PnlAMaxW,PnlAMaxH: Double;
    PnlASetW,PnlASetH: Double;
    PnlASetHorzSpace,PnlASetVertSpace: Double;
    PnlABorderLeftRightWidth, PnlABorderTopBottomWidth: Double;
    PnlAZKArr: array of TZK;
    PnlAZKPos: Integer;//1 ��� 2 ����
    PnlASelfRotate, PnlARotateSet: Boolean;

    PnlBMinW,PnlBMinH,PnlBMaxW,PnlBMaxH: Double;
    PnlBSetW,PnlBSetH: Double;
    PnlBSetHorzSpace,PnlBSetVertSpace: Double;
    PnlBBorderLeftRightWidth, PnlBBorderTopBottomWidth: Double;
    PnlBZKArr: array of TZK;
    PnlBZKPos: Integer;//1 ��� 2 ����
    PnlBSelfRotate ,PnlBRotateSet: Boolean;

    DoublePnl: Boolean;
    WDivH: Double;//��������1:7
    MinUseage: Double;//ֻ��ʾ������

    m3ZKLength,m6ZKLength: Double;//3mm�迹��6mm�迹�ĳ���
  end;
  PCutParam = ^TCutParam;

implementation


end.

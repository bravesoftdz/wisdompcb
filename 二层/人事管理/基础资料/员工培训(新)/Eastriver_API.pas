unit Eastriver_API;

interface
uses
  Windows, SysUtils, Classes;

const
  DLL_NAME = 'EastRiver.dll';

type
    ////�������ͽṹ��
    pNameList = ^NameList;
    NameList =packed record
    listtype: Integer;
    //�������� 1 ���ڰ����� 0 ������ 2 �Ž���������12,��������
    //17����ɾ����������16����ɾ����������18,��ɾ���Ž�����

    cardno: array[0..19] of char;        //����
    emp_no: array[0..15] of char;        //����
    emp_name: array[0..15] of char;      //Ա������
    devid: Integer;                      //�豸id
    Week: integer;                       //����ʱ���
    TimePass: array[0..5] of Integer;    //����ʱ���
    CustomInfo1:array[0..31] of Char;    //�Զ�����Ϣ1
    CustomInfo2:array[0..31] of Char;    //�Զ�����Ϣ2
    CustomInfo3:array[0..31] of Char;    //�Զ�����Ϣ3
    CustomInfo4:array[0..31] of Char;    //�Զ�����Ϣ4

    /////�Ž�������
    Password:array [0..3] of Char;       //��������
    Right:integer;                       //����Ȩ��

    /////���ѻ�
    allowance:integer;                                   //�������    4�ֽ�
    allowance_time:integer;                              //��������    4�ֽ�
    allowanceType:integer;                               //��������    1�ֽ�
    backnametimes:integer;                             //����������  (1���ֽ�)

    AllowanceStart:array [0..7] of Char;               //������ʼ���� YYYYMMDD
    AllowanceEnd:array [0..7] of Char;                 //������������ YYYYMMDD


    BeginPass:array [0..19] of Char;                   ///�Ž������õĿ�ʼʱ��,����08001400,��TimePassΪ0ʱ����,����ʹ��TimePass
    EndPass:array [0..19] of Char;                     ///�Ž������õĽ���ʱ��,����14001600,��TimePassΪ0ʱ����,����ʹ��TimePass
    ////�����ֶ�
    CSN:array [0..8] of Char;                          //����ID��(4���ֽڣ�HEX��)
    KeepFields:array [0..50] of Char;                  //�����ֶ�
  end;
  TNameListArray = array[0..15] of NameList;                 //16��һ������


  PICRecord=^TICRecord;
  TICRecord=packed record
    Card: array[0..19] of char; // �����ַ���
    timeString: array[0..19] of char; // 14λˢ��ʱ���ַ���, ��ʽΪyyyymmddhhnnss
    EmpId: array[0..9] of char;
    mark: Integer; // ��������ʶ�ַ�
    flag: Integer; // �洢���Ľ��
    cardTimes: Integer; // ��������, 0-15
    consume  : Integer;    // ���Ѷ�
    balance  : Integer;    // ���Ѻ����
    pos_sequ: Integer; //������ˮ��
    order_id: Integer;//���ظ�ʹ�����
     //������չ
    OrderMonth   : Integer;  //������
    OrderDay     : Integer;  //������
    Dins1 : Integer;   //����1
    Dins2 : Integer;   //����2
    Month1 : Integer;   //�·�1
    Month2 : Integer;  //�·�2 
    reserved1: DWORD;             // 983���ص���״̬
    reserved2: DWORD;             // 860���ص��ǰ��
    reserved3: array[0..19] of Char; // ����
    retranType:Integer;
    reserved4: array[0..92] of Char; // ����ԭʼ����
    Clock_id:Integer;
  end;

  PClockInfo=^TClockInfo;
  TClockInfo=record
    hPort: THandle;
    clock_id: Integer;
    port, baudrate: DWORD;        //ͨѶ�˿ں�����
    Fireware: Double;             //ģ�߰汾
    clock_type,                   //����ģʽ    ��������(0=���ڻ���1=�����Ž�����2=�Ž�����3=���ѻ���4=��������5=��������6=���ݷ�������7=����ǩ��)
    VerOrd,                       //�汾ϵ��
    model,                        //�����ͺ�
    cls,                          //��ͷ����(0: ID��, 1:IC��, 2: ���)
    CardFormat,                   //����ʽ 1=ԭ��ʱ������ʽ 2=ɽ�����ſ���ʽ 3=�ƶ�����ʽ 4=���ɿ���ʽ
    run_mode,                     //����ģʽ(0:���ڻ�, 1:�����Ž� 2:�Ž��� 3:���ѻ� 4:������ 5:����)
    Mode, SystemMode, ExtraMode,RingMode,  //���в���
    Block,                        //ʹ��IC�����
    DispCardLen, CardLen,         //��ʾ���ų���, �洢���ų���
    GroupStation: Integer;        //�����ֽ�λ��
    GroupCheck,                   //�Ƿ�򿨷���
    Connected,                    //�Ƿ�������
    CmdVerify, RWOnly: Boolean;   //�Ƿ�ר�÷�����
    mark: Char;                   //ˢ����ʶ
    CommStyle: Integer;           //ͨѶ���ͣ�0����ͨѶ 1TCP/IPͨѶ
    IPAddr: String;                //TCP/IPģ��IP��ַ
    IPPort: Integer;              //TCP/IPģ��˿�
    Vendor: Integer;              //ģ���� 0:=��ʱ�� 1=������ 2=��̩������
    IPPwd: String;                //ģ�������
    IPworkmode:string;            //TCP/IPת�����Ĺ���ģʽ
    Decimal: Integer;             //С��λ
    IsU: Boolean;                 //�Ƿ��U��
    IsSimCard: Boolean;           //�Ƿ����ˢ�ֻ���
  end;

  P690ReadData=^T690ReadData;
  T690ReadData=packed record
    Verify_Error: Boolean;                                  //�˼�¼У���Ƿ���ȷ, ���û�����,
    //�����¼У������������������һ����¼��������ΪFalse
    CardNo: array[0..19] of char;                           //����(20���ֽ�,��0�����ַ���)
    TimeString: array[0..19] of char;                       //ʱ��(20���ֽ�,��0�����ַ���)
    flag: Integer;                                          //�򿨽��
    Consume: Integer;                                       //���ѽ��,��λ��
    Balance: Integer;                                       //���Ѻ����,��λ��
    Times: Integer;                                         //��ֵ����
    Record_Total: Integer;                                  //�ɼ����ݵ��ܼ�¼��
    Record_Index: Integer;                                  //��ǰ��¼�ǵڼ�����¼

    //������Ա

    Clock_ver: Integer;                                     //���Ѽ�¼�汾��
    Clock_ID: Integer;                                      //����
    POS_Sequ: Integer;                                      //POS������ˮ��
    Card_Sequ: Integer;                                     //��������ˮ��
    Order_ID: Integer;                                      //������˳���
    Op_CardNo: array[0..19] of Char;                        //POS������Ա����
    Date_ver: array[0..19] of Char;                         //ʱ��汾��
    OverPwd: array[0..9] of char;                           // ������������
    reserved1: DWORD;                                       //983���ص���״̬
    reserved2: DWORD;
    reserved3: array[0..19] of Char;                        // ����
    reserved4: array[0..99] of Char;                       // ����
    ReaderNo:Byte;   //��ͷ��

    //������չ
    OrderMonth   : Integer;  //������
    OrderDay     : Integer;  //������
    OrderDinings : array[0..100] of char; //���ͱ�
    Dins         : Integer;

    //���ѻ�����
    transcount:integer;                                     //����ǰ��� ��  ���ؽ��׶�(4�ֽ�)
    retransta: integer;                                     //���ؽ���״̬(1�ֽ�)
    retranType: integer;                                    //���ؽ�������
    Enterp_ID:  array[0..11] of char;                        //������ҵID (6�ֽ�)
    Car_type : integer;                                     //���ؿ����ͱ�ʶ��1�ֽڣ���0x00����ͨIC����0x01��(U)SIM����
    emp_flowid: integer;                                   //����   �ƶ�������ҵԱ����ˮ�ţ�4�ֽڣ�
    pocket_index: integer;                                  //����Ǯ����Ӧ��������(1�ֽ�)
    pocket_applytype:  integer;                             //����Ӧ�����ͱ�ʶ��1 �ֽڣ�  0x01��ȫ��Ǯ����0x04��ʡǮ����0x08����ҵǮ��
    pocket_remainType:  integer;                           //����Ǯ��������ͣ�1�ֽڣ�  0x00����ҵ������0x01�����˳�ֵ���˷ѡ����Ѷ�Ϊ0xFF
    allowance_method: integer;                            //���ز�����ʽ��1�ֽڣ� �ƶ�����0x00����, 0x01�ۼӣ���Ǯ���������Ϊ��ҵ����ʱ��Ч����ЧʱΪ0xFF
                                                          //���ſ��� 0x00��ʾ����;	0x01��ʾ��׼����ģʽ; 0x02��ʾ���㲹��ģʽ;   0x03��ʾ�ۼӲ���ģʽ; 0x04 ��ʾ���ѳ���
    allowance_time:integer;                              //	���ص��ſ����Զ��������Σ�2�ֽڣ�    ���Զ�������ʱΪ0����˸�ʽ�����ֽ���ǰ�����ֽ��ں�
    pocket_type: integer;                                //  ����Ǯ������(1�ֽ�)   0x01��������0x02���������  0x11�����޴Σ�0x12�����޴�
    Car_TAC    :array [0..7]of char;                     //���ص��ſ���TAC(4�ֽ�)
    oper_id : integer;                                    //���ز���Ա���루2�ֽڣ���01-98�൱��0x0001-0x0098
    dev_ver: integer;                                     //���Ѽ�¼�汾��  ��¼�汾(1�ֽ�)    ���ſ���0x01���ƶ�����0x02

    AllowanceBalance:integer;                             ///�������
    CargoResult:integer;                                  ///�������,0��ʾ����������1��ʾ�������ϣ�255��ʾ������
  end;
  PReadData=P690ReadData;//����Ҫ��������
  TReadData=T690ReadData;//����Ҫ��������

  //      ���ݴ���ص�����
  TDataProcess = function(lpData: Pointer; lpReadData: PReadData): Boolean;stdcall;
  // lpData       : �Զ������, ��ӦReadAllRecord()�ĵڶ�������
  // lpReadData   : ��¼�ṹָ��
  //����ֵ:
  //�����Ҫ������һ����¼�򷵻�True, �����Ҫ��ֹ���ݶ�ȡ�ɷ���False,

  TTimeLapse = procedure(lpData: Pointer; microsecond: Integer);stdcall;  

  API_OpenClientSocket = function (RemoteAddr: PChar; Port: Integer):THandle; stdcall;  //��TCP/IPͨѶ�˿�
  API_ReadClockTime = function (hPort: THandle; var CurTime: Double): Boolean; stdcall;//��ȡʱ��
  API_ClosePortHandle = function (hPort: THandle): Boolean;stdcall;  //�رն˿ھ��
  API_CallClock = function (hPort: THandle; clock_id: Integer): Boolean; stdcall;   //��������
  API_UnCallClock = function (hPort: THandle): Boolean; stdcall;         //�ѻ�����
  API_ReadClockRecordTotal = function (hPort: THandle; var data: Integer): Boolean;stdcall;
  API_ReadAllRecord = function (hPort: THandle; lpData: Pointer; DataProcess: TDataProcess; Wait:TTimeLapse=nil): Integer;stdcall;//��֡(һ֡400��)��ȡ�������м�¼
  API_ClearAllReadCard = function (hPort: THandle): Boolean; stdcall ;//������п��ڼ�¼
  API_ReadListCardTotal = function (hPort: THandle;var ListCardTotal:integer;var WhiteCard:integer;var BlackCard:integer):boolean;stdcall;
  API_ReadDeviceListCard = function (hPort: THandle;FromPos: Integer; var RecordCount: Integer; var ListCards: TNameListArray): Boolean;stdcall;
  //����˵��
  //fmt:�����洢��ʽ
  //fromPos:�ӵڼ�����ʼ
  //RecordCount:��ȡ�ļ�¼��,Ҳ�Ƿ��صļ�¼��. ���16��
  //Records:���ص�������.
  API_ClearAllNamelist = function (hPort:THandle):Integer;stdcall;
  API_SetAllowedCard = function (hPort: THandle; card, empid, EmpName: PChar): Boolean;stdcall;
  API_SetClockTime = function (hPort: THandle; SetTime: Double): Boolean; stdcall;
implementation

end.

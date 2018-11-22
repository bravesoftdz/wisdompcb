unit EastRiver;

{$WEAKPACKAGEUNIT}

interface
uses
  Windows, SysUtils;

const
  {$IFDEF DIRECTDLLCALL}
  EastRiver_API     = 'OldEastRiver.dll';
  {$ELSE}
  EastRiver_API     = 'EastRiver.dll';
  {$ENDIF}
  OldEastRiver_API     = 'OldEastRiver.dll';
//�豸�汾��(Fireware), �Ƚ�ʱ�������Щ����, �������Ͳ�ƥ�佫�����Ƚϴ���
  FW119: Double     = 1.19;
  FW120: Double     = 1.20;
  FW125: Double     = 1.25;
  FW128: Double     = 1.28;
  FW129: Double     = 1.29;
  FW130: Double     = 1.30;

//���Ž�������
  INOUT_RIGHT       =$00; //����Ȩ������
  CIPHER_ENABLE     =$01; //������ʱ��
  ALERT_ENABLE      =$02; //������Чʱ��
  BUTTON_ENABLE     =$03; //������Чʱ��
  OPEN_DOOR         =$04; //��������ʱ��
  MAGNETISM_ENABLE  =$05; //�Ŵż��ʱ��
  HOLIDAY_OPENRIGHT =$06; //�ڼ��տ���ʱ����Ȩ��
  SUPERUSERPWD_ENABLE=$07; //�����û�����ʱ��

// IC����д���Ÿ�ʽ����
  CARDSTYLE_UNKNOWN= 0000; //δ֪���Ÿ�ʽ(����Ϊ��)
  CARDSTYLE_IDCARD = 0001; //ID����ʽ
  CARDSTYLE_UTFCARD= 0002; //�Զ��忨��ʽ
  CARDSTYLE_OLDCARD= 0830; //��ER-680C���ѿ���ʽ
  CARDSTYLE_NEWCARD= 0880; //��ER-880C����ʽ
  CARDSTYLE_690CARD= 0690; //�����ѻ�ER-690����ʽ

//  ͨѶ���Ÿ�ʽת������
  CS_AUTO          = $00;  //��880���ߵ���Ĭ�ϴ���880D=ID_NOCONVERT,880C=IC_CONVERT,�����Ž���=IC_CONVERT
                           //�������Ϊ16λ��׼����ID��IC�����任
  CS_GENERAL       = $01;  //��ת������ʽ(����)
  CS_NEWCARD       = $02;  //IC���ţ���Ҫ�任��IC��׼����
  CS_OLDCARD       = $03;  //ת���ɾ�ER-830C IC������
  CS_IDCARD        = $04;  //ID���ţ��任��16λ��׼���ż��������λʱ'EF'

  InitTimeOut      = 1000; //Ĭ��ͨѶ��ʱ
  
type
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



{***************��ʱ����Ʒ�ſ�*******************
��һ��(���1G)
  ER-210 C/D �������ѻ�
  ER-610 C/D ���ڻ�
  ER-680 C/D ���ѻ�
  ER-7x0 C/D �����Ž���
  ER-810 C/D ���ڻ�
  ER-830 C/D �����Ž���

�ڶ���(���2G)
  ER-880 C/D �����Ž���,�����ܶ�汾,����ȫ����,��ʽ���а���1.25-1.30(fireware)
  ER-900 IC   ͨ�÷�����
  ER-901 ID   ͨ�÷�����

������(���3G)
  ER-890C/D �����Ż�
  ER-890CT/DT ֱ����TCP/IP�����Ŀ����Ž�
  ER-980  �����Ž���,��ͷ������ICҲ������ID,���ʹ��
  ER-981C �����Ž���
  ER-983  �����Ž�
  ER-985  С���Ž�
  ER-690(1)C ���ѻ�,����ER-980�Ĵ󲿷ֹ���,ֻ�в��ֺͼ�¼�йص�ָ�����,
          ���⻹��չ�˲�������ר��ָ��
  ER-690(1)D ʵʱID�����ѻ�
  ER-692  ����������IDʵʱ���ѻ�

}



function GetLastErrCode(): DWORD; stdcall; external EASTRIVER_API
function SetLastErrCode(ErrCode: DWORD): Boolean; stdcall; external EASTRIVER_API
//      ȡ��������Ĵ������
function GetRecentErrCode(): DWORD; stdcall; external EASTRIVER_API
//      ȡ�ö˿�������Ĵ������
function GetPortRecentErrCode(Port: Byte): DWORD; stdcall; external EASTRIVER_API
//����ֵ:
const
  ERROR_IO_CHECK    = $00000001; //У�����
  ERROR_IO_READ     = $00000002; //������
  ERROR_IO_WRITE    = $00000003; //д����
  ERROR_IO_NOEND    = $00000004; //���ڽ���δ�������ж�
  ERROR_IO_NOPEN    = $00000005; //���ܴ򿪶˿�
  ERROR_IO_COMMAND  = $00000006; //�������
  ERROR_IO_NOHANDLE = $00000007; //�޾������
  ERROR_IO_TIMEOUT  = $00000008; //ͨѶ��ʱ
  ERROR_IC_PASSWORD = $00000009; //IC�������
  ERROR_NO_SUPPORT  = $00000010; //��֧�ֵ�����


{�豸������}

//      �򿪴��ж˿�
function OpenCommPort(Port: Integer; BaudRate: Integer): THandle; stdcall; external EASTRIVER_API
//����˵��:
// Port         : �˿ں�,����ֵ1-256, ��: COM1=1, COM2=2...COM256=256
// BaudRate     : �˿ڲ�����,����ֵ: 9600, 19200, 38400, ͨ����9600
//����ֵ:
// -1           : �˿���Ч������ʹ��
// 0            : �޷��򿪶˿�
// ����ֵ       : �˿ھ��,����������������
//��ע:
// ��ʹ��Windows API CloseHandle(hObject: HANDLE): BOOL; ���رն˿ھ��

//      �ر��Ѿ��򿪵Ķ˿ں�
function CloseCommPort(Port: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// Port         : �˿ں�,����ֵ1-256, ��: COM1=1, COM2=2...COM256=256
//����ֵ:
// True=�ɹ�, False=ʧ��

//      �رն˿ھ��
function ClosePortHandle(hPort: THandle): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �Ѿ��򿪵Ķ˿ھ��
//����ֵ:
// True=�ɹ�, False=ʧ��

//      ��ʼ���˿�����, �ڴ򿪶˿ں�����ʱ�Զ�����, ������Ҫ�޸Ķ˿ڲ���
//      һ�㲻��Ҫ�Լ�����
function InitCommPort(hPort: THandle; BaudRate: DWORD; Parity: Byte): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��
// BaudRate     : �µĶ˿ڲ�����,����ֵ: 9600, 19200, 38400, ��Ϊ0ʱ������ԭ������
// Parity       : �µĶ˿�У�鷽ʽ,����ֵ����:
//    NOPARITY    = 0;   //��У��
//    ODDPARITY   = 1;   //��У��
//    EVENPARITY  = 2;   //żУ��
//    MARKPARITY  = 3;   //���У��(����֮ǰ)
//    SPACEPARITY = 4;   //��У��  (����֮��)
//    255         =$FF;  //������У������
//����ֵ:
// True=�ɹ�, False=ʧ��

//����У�鷽ʽ
function SetPortParity(hPort: THandle; Parity: Byte): Byte; stdcall; external EASTRIVER_API
// Parity       : �µĶ˿�У�鷽ʽ,����ֵ����:
//    NOPARITY    = 0;   //��У��
//    ODDPARITY   = 1;   //��У��
//    EVENPARITY  = 2;   //żУ��
//    MARKPARITY  = 3;   //���У��(����֮ǰ)
//    SPACEPARITY = 4;   //��У��  (����֮��) 880,889����1.32�汾������Ҫ����
//    255         =$FF;  //������У������

//      �򿪶˿ڼ������豸(���� OpenCommPort )
function ConnectClock(Port, BaudRate: Integer; clock_id: Integer): THandle;stdcall; external EASTRIVER_API
//����˵��:
// Port         : �˿ں�,����ֵ: 1-256, ��: COM1=1, COM2=2...COM256=256
// BaudRate     : �˿ڲ�����,����ֵ: 9600, 19200, 38400, ͨ����9600
// clock_id     : ����,����ֵ: 0-255, ���ڻ�������ʾ�Ļ���ʵ��������λ16������
//                ���Ի��ŷ�Χ16���Ʊ�ʾӦ��Ϊ: 0x00-0xFF
//����ֵ:
// -1           : �˿���Ч������ʹ��
// 0            : �޷�����, �����Ƕ˿�,������,���Ż�����·����
// ����ֵ       : �����ɹ�,���ض˿ھ��,����������������

//      �Ͽ����Ӽ��رն˿ھ��
function DisConnectClock(hPort: THandle): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��,ͨ������ConnectClock�����õ�
//����ֵ:
// True         : �ѻ��ɹ�
// False        : �ѻ�ʧ��

function SetClockIDLen(Len: Integer): Boolean; stdcall; external EASTRIVER_API
//���û��ų����ֽ�����Ĭ��ֵ��1��ֻ����Ϊ1��2����ʾһ���ֽ�(���Ŵ�0��255),�����ֽ�(���Ŵ�0��65535)

//      ���ָ���Ļ����Ƿ�������״̬
function CheckConnectClock(hPort: THandle; clock_id: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��,ͨ������OpenCommPort�����õ�
//����ֵ:
// True         : ����״̬
// False        : �ѻ�״̬

//      ��ʽ��������
function CallClock(hPort: THandle; clock_id: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��,ͨ������OpenCommPort�����õ�
// clock_id     : ����,����ֵ: 0-255, ���ڻ�������ʾ�Ļ���ʵ��������λ16������
//                ���Ի��ŷ�Χ16���Ʊ�ʾӦ��Ϊ: 0x00-0xFF
//����ֵ:
// True         : �����ɹ�
// False        : ����ʧ��
//��ע:
// "1G"���Ͳ����ظ�����
// ���кͻ���ͨѶ��û�д����ŵĺ�������������������ܵ���
// �û�һ�㲻��Ҫֱ�ӵ��ô˺���, ����ʹ�� ConnectClock ����

//      �ѻ�����
function UnCallClock(hPort: THandle): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��,ͨ������OpenCommPort�����õ�
//����ֵ:
// True         : �ѻ��ɹ�
// False        : �ѻ�ʧ��
//��ע:
// �ѻ���,���кͻ���ͨѶû�д����ŵĺ�������������

//      ���ָ�������������Ƿ���Ӧ, ���޶���ʱ���ڷ���
function TestCallClock(hPort: THandle; clock_id: Integer; TimeOut: Integer=0): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��,ͨ������OpenCommPort�����õ�
// clock_id     : ����,����ֵ: 0-255, ���ڻ�������ʾ�Ļ���ʵ��������λ16������
//                ���Ի��ŷ�Χ16���Ʊ�ʾӦ��Ϊ: 0x00-0xFF
// TimeOut      : ��Ӧ��ʱ,���ڵ��������ٶ�,�Ƽ�ֵ(��λ����ms):
//    RS-232��·  = 100-120;
//    RS-485��·  = 120-200;
//    TCP/IP��·  = 500-800;
//    ���        > 1000;
//����ֵ:
// True         : ���ߴ���
// False        : ���߲�����

//      �Զ�ʶ������ͺ�(DLL�ڲ���Ҫʶ�����)
function ClockAutoModel(hPort: THandle): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
//����ֵ:
// True         : �Զ�ʶ��ɹ�
// False        : �����޷�ʶ��,�����ǿ�����û��ͺ���
//��ע:
// ���ڲ�ͬ���ͺ�,��ͬ��ͷ�Ļ��߽��ܵĿ��Ÿ�ʽ����ȫ��ͬ,����DLL��Ҫ֪����������
// ������ת����ͬ�Ŀ��Ÿ�ʽ,�������кͿ����йصĺ��������𲻵�Ԥ�ڵ�Ч��

//      ȡ�û����ͺ�(DLL�ڲ���Ҫʶ�����)
function GetClockModel(hPort: THandle; var Model: Integer; var Ver: Double; var cls: Integer): Boolean; stdcall; external EASTRIVER_API
function GetClockModelEx(hPort: THandle; var Model: Integer; var Ver: Double; var cls: Integer; var IsSimCard: Boolean; var CardFormat: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��
// Model        : ���ػ����ͺ�, ��:
//    ER-880C     = 880;
//    ER-980      = 980;
// ...
// Ver          : ���ػ��߰汾��, �������0, ��: 1.28, 1.30�ȵ�
// cls          : ���ػ�������(��ͷ)
//    ER-880C     = 1;  //IC��ͷ
//    ER-980      = 1;  //IC,ID��ͷ���
//    ER-880D     = 0;  //ID��ͷ
// CardFormat //����ʽ 1=ԭ��ʱ������ʽ 2=ɽ�����ſ���ʽ 3=�ƶ�����ʽ 4=���ɿ���ʽ 
//����ֵ:
// True=�ɹ�, False=����

//      ���ñ�ʶDLL�ڲ����������Ļ����ͺ�(���Զ�ʶ����Чʱ)
function SetClockModel(hPort: THandle; Model: Integer; Ver: Double; cls: Integer): Boolean; stdcall; external EASTRIVER_API
function SetClockModelEx(hPort: THandle; Model: Integer; Ver: Double; cls: Integer; CardFormat: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��
// Model        : �����ͺ�, ��:
//    ER-880C     = 880;
//    ER-980      = 980;
// ...
// Ver          : ���߰汾��, �������0, ��: 1.28, 1.30�ȵ�
// cls          : ��������(��ͷ)
//    ER-880C     = 1;  //IC��ͷ
//    ER-980      = 1;  //IC,ID��ͷ���
//    ER-880D     = 0;  //ID��ͷ
// CardFormat //����ʽ 1=ԭ��ʱ������ʽ 2=ɽ�����ſ���ʽ 3=�ƶ�����ʽ 4=���ɿ���ʽ 
//����ֵ:
// True=�ɹ�, False=����

//      �޸Ļ���ͨ������(^2G)
function SetClockBaudRate(hPort: THandle; BaudRate: DWORD): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// BaudRate     : �µĻ��߲�����, ����ֵ: 9600, 19200, 38400
//����ֵ:
// True         : �޸ĳɹ�
// False        : �޸�ʧ��
//��ע: ����ǰ����ʹ����ȷ�Ĳ���������, �޸ĳɹ��������Ҫ�ͻ���ͨѶ����
//      ���� InitCommPort �������˿ڲ������޸ĳɺ��µĻ��߲�����һ��

{�豸������}



{�汾������}

//      ��ѯ���ߵĻ����Ƿ�֧��ĳ���
function GetClockSupports(hPort: THandle; Index: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// Index        : ���ܱ��, ���ܵ�ֵ���±�
const
  fiStoreRecord     = $00000000; //�洢ˢ����¼
  fiAttendance      = $00000001; //֧�ֿ��ڹ���
  fiDoorGuard       = $00000002; //֧���Ž�����
  fiConsumption     = $00000003; //֧�����ѹ���
  fiIssueCard       = $00000004; //֧�ַ�������
//  ...                          //5-F ����
  fiDoorList        = $00000010; //֧���Ž�����
  fiWhiteList       = $00000011; //֧�ְ�����
  fiBlackList       = $00000012; //֧�ֺ�����
  fiHaveMark        = $00000013; //�豸֧��ˢ����ʶ
  fiIDReader        = $00000014; //��ID��ͷ
  fiICReader        = $00000015; //��IC��ͷ
  fiScreen          = $00000016; //֧�ֿ�������ʾ
  fibuzzer          = $00000017; //֧�ֿ��Ʒ�������
  fiAdminCard       = $00000018; //֧�ֹ���
  fiBrushPeriods    = $00000019; //֧��ˢ��ʱ��
  fiRingTime        = $0000001A; //֧�ִ���ʱ��
  fiGroupCard       = $0000001B; //֧�ַ����
  fiRealTime        = $0000001C; //֧��ʵʱ�ϴ�
  fiRealControl     = $0000001D; //֧��ʵʱ����
  fiChangeMode      = $0000001E; //֧�ָ�������ģʽ
  fiChangeBlock     = $0000001F; //֧�ָ���IC��ʹ�ÿ��
  fiCustomCardLen   = $00000020; //֧���Զ��忨�ų���
  fiBrushSpace      = $00000021; //֧������ˢ�����
  fiRepeatSpace     = $00000022; //֧���ظ�ˢ�����
  fiSerialNo        = $00000023; //֧�ֻ������к�
  fiClockTime       = $00000024; //������ʱ��
  fiPriceList       = $00000025; //֧�����Ѽ۸��
  fiFixPrice        = $00000026; //֧�����ö�ֵ���Ѷ�
  fiDayMaxExpend    = $00000027; //֧��������������Ѷ�
  fiDayMaxTimes     = $00000028; //֧��������������Ѵ���
  fiCardForegift    = $00000029; //֧�ֿ���������ƽ��(Ѻ��)
  fiChangeClockId   = $0000002A; //֧���޸Ļ���
  fiHaveEmpId       = $0000002B; //֧����ʾ����
  fiAllowCharge     = $0000002C; //֧�ֲ�����ֵ
  fiReadAllRecord   = $0000002D; //֧��һ���Բɼ����м�¼(ReadAllRecord)
  MAXSUPPORTINDEX   = $0000002D; //�����������ֵ(��ͬ������)

//˵���˺���Ϊ�������߹滮һ������չ�Ŀռ�,
//��ǿ����ͻ���֮�����ϵ,��Щ����Ҳ�����ڲ����ɿ�,
//�Ա�����֧��,���û��½�

//����ֵ:
// True         : ֧�ִ˹���
// False        : ��֧�ִ˹���

//      ȡ�ú�����DLL�汾��
function GetDLLVersion: Double; stdcall; external EASTRIVER_API
//����ֵ:
// �����С��   : ��汾��
// ����ֵ       : ʧ��

//      ���ػ�������ʱ���ڼ�����Ʒ
function GetClockVersionOrd(hPort: THandle; fastGet: Boolean=True): Integer; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// fastGet      : �Ƿ���ٵ���(�ӻ�����ȡ��), ������Ҫ��ȡ����(��)
//����ֵ:
// 0            : ʧ��
// 1            : ��һ��(ER-210--ER-830)
// 2            : �ڶ���(ER-880)
// 3            : ������(ER-980)

//      ����ָ��������ʱ���ڼ�����Ʒ
function ClockVerOrd(Model: Integer): Integer;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// fastGet      : �Ƿ���ٵ���(�ӻ�����ȡ��), ������Ҫ��ȡ����(��)
//����ֵ:
// 0            : ʧ��
// 1            : ��һ��(ER-210--ER-830)
// 2            : �ڶ���(ER-880)
// 3            : ������(ER-980)

//      ȡ�û��߰汾�ַ���
function GetClockVersion(hPort: THandle; Version: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// Version      : ���ذ汾������, ��������Ҫ����30���ַ�
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��ȡ�豸���к�
function ReadClockSerialNo(hPort: THandle; SerialNo: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// Version      : ������źŻ�����, ��������Ҫ����30���ַ�
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

{�汾������}

{�豸������ͨ��}

//      �޸Ļ���
function SetClockID(hPort: THandle; new_id: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ER-880ϵ����Ҫ����, ER-210--ER-830����Ҫ����
// new_id       : �»���,�ַ���ʾ���Ļ��Ͳ�����ʹ��A--F���ַ�������, ��ֻ����ʹ��
//					0x00-0x09, 0x10-0x19, 0x20-0x29, 0x30-0x39, 0x40-0x49
//					0x50-0x59, 0x60-0x69, 0x70-0x79, 0x80-0x89, 0x90-0x99
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ����ָ���˿��ϵ�Ψһ����
function GetClockID(Port, BaudRate: Integer): Byte; stdcall; external EASTRIVER_API
//����˵��:
// Port         : �˿ں�
// BaudRate     : ������
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��ȡ���߱�ʶ�ַ�(mark)
function ReadClockMark(hPort: THandle; var Mark: Char): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// Mark         : ���صĻ��߱�ʶ�ַ�
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      �޸Ļ��߱�ʶ�ַ�(mark)
function SetClockMark(hPort: THandle; Mark: Char): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// Mark         : �µĻ��߱�ʶ�ַ�
//����ֵ:
// True         : �ɹ�
// False        : ʧ��
//˵��: ������ʾ���Ļ���ֻ����ʹ�� 0-9 ������

//		  ��ȡ�����Ͽ��ų��ȱ���
function ReadCardLength(hPort: THandle; var dispLen: Integer; var dataLen: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
//		dispLen   : ������ʾ����λ��, ͬʱ�ڰ��������ʱҲ�Ը�ֵΪ׼
//		dataLen   : ���ߴ洢����λ��, �洢ˢ������ʱʹ��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  �޸Ļ����Ͽ��ų��ȱ���
function SetCardLength(hPort: THandle; dispLen: Integer; dataLen: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
//		dispLen   : �µĻ�����ʾ����λ��
//		dataLen   : �µĻ��ߴ洢����λ��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��
//��ע:
// ID����Ĭ��:  dispLen=10, dataLen=10;
// IC����Ĭ��:  dispLen=10, dataLen=16;

//		  �����ߵ�ǰ��������
function ReadManagerCard(hPort: THandle; CardNo: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// CardNo       : ���ع�������, ����������20�ֽڳ���
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  �޸Ļ��߹���(ALL)
function SetManagerCard(hPort: THandle; CardNo: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// CardNo       :
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��ȡ���߹���ģʽ(^2G)
function ReadClockMode(hPort: THandle; var Mode: Integer; var ExtraMode: Integer; var SystemMode: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// mode         : �豸�Ĺ���ģʽ
// extraMode    : �豸����չ����ģʽ
// systemMode   : ϵͳ����ģʽ
//    systemMode.7=1 : ���ڻ���ʱ�δ�
//		systemMode.7=0 : ���ڻ�ȫ���
//		systemMode.4=1 : �Ž������ű���ʹ��
//		systemMode.4=0 : �Ž������ű�����ֹ
//    systemMode.6,5,3,2,1,0 : ����
//��690C2.0��
//    extraMode.5=1 ���ڿ����
//    extraMode.7=1 ���������
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      �����豸����ģʽ(^2G)
function SetClockMode(hPort: THandle; Mode: Integer; ExtraMode: Integer; SystemMode: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// Mode         : �豸�Ĺ���ģʽ(�Ͱ�λ)
//    mode.0=1 : �豸����춿��ڻ�   mode.0=0 : �޿��ڻ�����
//		mode.1=1 : �豸������Ž���   mode.1=0 : ���Ž�������
//		mode.2=1 : �豸��������ѻ�����ͻ�  mode.2=0 : �����ѻ�����
//		mode.3   : ����
//		mode.5, mode.4 =00B : �豸���������
//		mode.5, mode.4 =01B : �豸��������Ӽ̵��� 1 ���
//		mode.5, mode.4 =10B : �豸��������Ӽ̵��� 2 ���
//		mode.5, mode.4 =11B : �豸�����ɷ��������
//		mode.6=0 : ���������Ƶ��ظ�ˢ��
//		mode.6=1 : �ظ�ˢ���� SetRepeatClockerTime ���õ�ʱ������
//		mode.7=0 : �򿨼�¼���ݴ洢����ʱֹͣ��
//		mode.7=1 : �򿨼�¼���ݴ洢����ʱѭ������ԭ���ݼ�����
//    �����ѻ�1.05��
//    mode.4=1 :���Բ鿴ͳ�ƽ��  =0���ܲ鿴ͳ�ƽ��
// ExtraMode : �豸����չ����ģʽ(�Ͱ�λ)
//  	extraMode.0=0 : ���ڻ���������õ������ڿ�(������)
//		extraMode.0=1 : ���ڻ�������õ������ڿ�(������)
//		extraMode.1=0 : ���ڻ���������õĺ�������
//		extraMode.1=1 : ���ڻ�������õĺ�������
//		extraMode.2=0 : �Ž�����������õĺ�������
//		extraMode.2=1 : �Ž���������õĺ�������
//		extraMode.3   : ����
//		extraMode.4=0 : �������򿨲���Ӧ
//		extraMode.4=1 : �������򿨱���
//		extraMode.7,6,5=000B : ������Ӽ̵���1, ������Ӽ̵���2
//		extraMode.7,6,5=011B : ������Ӽ̵���2, ������Ӽ̵���1
//		extraMode.7,6,5=100B : ��ȷָʾ����Ӽ̵���1, ����ָʾ����Ӽ̵���2
//		extraMode.7,6,5=���� : ����
//��690C2.0��
//    extraMode.5=1 ���ڿ����
//    extraMode.7=1 ���������
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��չ��ȡ���߹���ģʽ(890,����2G)
function ReadClockModeEx(hPort: THandle; var Mode: Integer; var ExtraMode: Integer; var SystemMode: Integer; var RingMode: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// Mode         : �豸�Ĺ���ģʽ(�Ͱ�λ)
// mode.2,1,0
//   000B �����޽���                    001B �������ڻ�
//   010B �����Ž���                    011B �Ž�/���ڶ���һ��
//   100B ���ѻ�                        101B ������(ER-980)
//   110B ���Ŷ�����(ER-980������)      111B ����
// mode.3 ER-980���Ժ����֧��
//     0B ������ʱ��ˢ������¼������¼    1B ������ʱ��ˢ����¼������¼
// mode.5,4
//    00B �����������������             01B �����������ӵ���Ӽ̵���1
//    10B �����������ӵ���Ӽ̵���2    11B ���÷���������
// mode.6
//     0B �����ظ�ˢ��
//     1B ��ֹ�ظ�ˢ��������ȴ����õ��ظ�ˢ�����ʱ�������ٴ�ˢ��
// mode.7
//     0B ��¼��������ֹͣ������ˢ��������������쳣
//     1B ��¼��������ѭ���������¼�¼������ɼ�¼
// ExtraMode : �豸����չ����ģʽ(�Ͱ�λ)
// extraMode.0
//     0B �����п��ڰ��������
//     1B ���ˢ�������Ƿ��ڿ��ڰ������У������򱨾�
// extraMode.1
//     0B ����ʱ�����п��ں��������
//     1B ����ʱ���ˢ�������Ƿ��ڿ��ں������У����򱨾�
// extraMode.2
//     0B �Ž�ͨ���ж�ʱ�����к��������
//     1B �Ž�ͨ���ж�ʱ�����ˢ�������Ƿ�Ϊ�����������򱨾�
// extraMode.3
//     0B ˢ��ʱ���������Ƚ�
//     1B IC��ˢ��ʱ��鿨Ƭ�ϵ������Ϣ�Ƿ���������ƥ�䣬��ƥ���򱨾�
// extraMode.4
//     0B �Ž�ͨ��ʱ������ͨ��������飬�κο�����ͨ��
//     1B �Ž�ͨ��ʱ��Ҫ���ˢ�������Ƿ����Ž�ͨ�������У������򱨾�
// extraMode.7,6,5
//   000B ������Ӽ̵���1��������Ӽ̵���2
//   011B ������Ӽ̵���2��������Ӽ̵���1
//   100B ��ȷָʾ����Ӽ̵���1������ָʾ����Ӽ̵���2
//   101B ER-980�����������Ž�ͨ�з�Ǳ�ؼ�飨ER-980���Ժ����֧�֣�
//   ���� ����
// systemMode  : ϵͳ����ģʽ ER-981��ER-890֧��
// systemMode.0
//     0B ���������ڼ�¼                 1B ����Ա���������ڼ�¼
// systemMode.1
//     0B ������ˢ��ʱ��������¼         1B ������ˢ��ʱ������¼
// systemMode.2
//     0B �Ƿ���ˢ����������¼           1B �Ƿ���ˢ��������¼
// systemMode.3
//     0B ͨѶʱʹ�ÿͻ��Զ������õĻ�����Ϊ�豸����������
//     1B ͨѶʱʹ�û��߲�Ʒ���кŵ����2λ������Ϊ�豸����������
// systemMode.4
//     0B �������Ŵ򿪳�ʱ���
//     1B �Ž�����ʱ������Ŵ��Ƿ�ʱ�����򱨾�
// systemMode.5
//     0B �Ž��޷�ͨ��ʱ������ˢ����Ϣ
//     1B �Ž�ˢ�����⵽�ÿ��޷�ͨ��ʱ������¼���Ա�����
// systemMode.6
//     0B �Ž�ͨ�к󲻴���ˢ����Ϣ�������ڼ�ͨ�п��Ƴ���
//     1B �Ž�ͨ�к�����ÿ���ͨ�м�¼���Ա�����
// systemMode.7
//     0B ����ʱ�κ�ʱ�ζ�����ˢ��
//     1B ����ʱ��ʱ��ˢ����������ʱ��ˢ������
// RingMode : ���÷�����������ƣ�ER-981��ER-890֧�֣�
// RingMode.0
//     0B ����ˢ��ʱ������ֻ��ʾˢ����Ϣ
//     1B ����ˢ��ʱ���巢������ˢ����ʾ��
// RingMode.1
//     0B �����������Ƿ���ˢ��ʱ������ֻ��ʾˢ��������ʾ��Ϣ
//     1B �����������Ƿ���ˢ��ʱ���巢��ˢ��������ʾ��
// RingMode.2
//     0B ������ˢ��ʱ��ˢ��������ֻ��ʾ�����ʾ��Ϣ
//     1B ������ˢ��ʱ��ˢ�����巢�����Ӧ����ʾ��
// RingMode.3
//     0B ˢ���޷�ͨ��ʱ������ֻ��ʾ�޷�ͨ����ʾ��Ϣ
//     1B ˢ���޷�ͨ��ʱ���壬�����޷�ͨ����ʾ��
// RingMode.4
//     0B ʹ�ó����Ŵţ��Źر�ʱ���Ŵűպϣ����ض�·
//     1B ʹ�ó����Ŵţ��Źر�ʱ���Ŵűպϣ����ض�·
// RingMode.5
//     0B �ⲿ������������Ϊ�����Ⱦ�������ЧʱӦ���Զ����ŷ���
//     1B �ⲿ������������Ϊ����������������ЧʱӦ���Զ���������
// RingMode.7,6
//    00B δʹ����Ӷ�ͷ                01B	WiegandͨѶ��ʽ��Ӷ�ͷ
//    10B	ABAͨѶ��ʽ��Ӷ�ͷ           11B ABAͨѶ��ʽWiegand���ݸ�ʽ��ͷ
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��չ�����豸����ģʽ
function SetClockModeEx(hPort: THandle; Mode: Integer; ExtraMode: Integer; SystemMode: Integer; RingMode: Integer): Boolean; stdcall; external EASTRIVER_API
// ����˵����
//     ���ն�ȡ�豸����ģʽ

function ReadClockModeStr(hPort: THandle; PMode: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵����
//1��ÿ��ģʽ�м��ö��Ÿ�����ֵ�Ƕ�����,ÿ��λ�Ĳ����������������˵��
//2��PMode�����û��SystemMode, RingMode��Ҫ����

function SetClockModeStr(hPort: THandle; PMode: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵����
//1������ģʽ��ֱ���޸Ķ���ֵ��Ȼ���ö��Ÿ�������
//2��PMode�����û��һ����Mode, ExtraMode����ֵ,��˳��Ӧ��ΪSystemMode, RingMode��������ź�û�еĻ���ʾû�д�ֵ��֧�ִ�ֵ

//����890��980��981��������Ա��
function SetClockParamManagerCard(hPort: THandle; CardNo: PChar): Boolean; stdcall; external EASTRIVER_API

//ʵʱ����״̬980
function RealReadLockState(hPort: THandle; Clock_ID: Integer; var Opening: Boolean): Boolean; stdcall; external EASTRIVER_API
//hPort:�˿ھ��������Ҫ����  Clock_ID���� Opening��״̬(True����False��)

//����ʱ��ʾ�����ͺ���������
function SetStartupShowClockModel(hPort: Thandle; Model: PChar): Boolean; stdcall; external EASTRIVER_API
//hPort������� Model�����ͺţ��磺ER-980

//      �ڻ�����Ļ����ʾ�ַ���
function ShowClockMessage(hPort: THandle; Msg: PChar; bClearScreen: Boolean; Line: Integer; Duration: Double): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// Msg          : һ����Ϣ�ַ���,���8�������ַ�����16��Ӣ���ַ�,�Զ�����
// bClearScreen : �Ƿ�������
// Line         : ��ʾ�к�,����ֵ: 1-4
// Duration     : ����ʱ��,��λ��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��ȡ���߿�����ʾ����
function ReadFirstWindowDispString(hPort: THandle; msg: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// msg          : ���ػ��߿�����ʾ����,���8�������ֻ���16��Ӣ����,�Զ�����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ���û��߿�����ʾ����
function SetFirstWindowDispString(hPort: THandle; msg: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// msg          : ���߿�����ʾ����,���8�������ֻ���16��Ӣ����,�Զ�����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ���û��߳�̬��ʾ����
function SetClockNormalMessage(hPort: THandle; msg: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// msg          : ���߳�̬��Ϣ,���8�������ֻ���16��Ӣ����,�Զ�����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��ȡ���߳�̬��ʾ����
function ReadClockNormalMessage(hPort: THandle; msg: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// msg          : ���ػ��߳�̬��Ϣ,��������Ҫ����20���ַ�
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ����ˢ���ɹ���ʾ����
function SetClockWelcomeMessage(hPort: THandle; msg: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// msg          : ˢ����ӭ��Ϣ,���8�������ֻ���16��Ӣ����,�Զ�����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��ȡˢ���ɹ���ʾ����
function ReadClockWelcomeMessage(hPort: THandle; msg: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// msg          : ����ˢ����ӭ��Ϣ,��������Ҫ����20���ַ�
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��ȡ�豸ʱ��
function ReadClockTime(hPort: THandle; var CurTime: Double): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// CurTime      : ���ػ��ߵ�ǰʱ��, Delphi��DateTime��ʽ,VB��Date��ʽ
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      �޸Ļ���ʱ��
function SetClockTime(hPort: THandle; SetTime: Double): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// SetTime      : �µ�ʱ��, Delphi��DateTime��ʽ,VB��Date��ʽ
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��ȡ����ʱ��, ���ַ�����ʽ����
function ReadClockTimeString(hPort: THandle; TimeString: PChar): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// TimeString   : ���ػ��ߵ�ǰʱ��,��ʽ:yyMMddhhnnss(yy��MM��dd��hhʱnn��ss��)
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ���ַ�����ʽ�޸Ļ���ʱ��
function SetClockTimeString(hPort: THandle; TimeString: PChar): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// TimeString   : ���ػ��ߵ�ǰʱ��,��ʽ:yyyyMMddhhnnss(^2G+w)(yyyy��MM��dd��hhʱnn��ss��)
//                ER-880������Ҫ����һ������ֵ, wΪ����ֵ, ������Ϊ0, ����һΪ1, ������Ϊ6
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ���ö˿��ϵ����л��ߵ�ʱ��(�������㲥ʽ)
function SetPortAllClockTime(hPort: THandle; SetTime: Double): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ������
// SetTime      : �µ�ʱ��, Delphi��DateTime��ʽ,VB��Date��ʽ
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ����ͨ����Ϣ(3G)
function SetNotification(hPort: THandle; msg: PChar; nDay: Integer; WordWrap: Boolean=True): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// msg          : ��Ϣ�ı�, ���Դ��س����з�, �������255*16��Ӣ���ַ�
// nDay         : ��ʾ��֪ͨ��Ϣ�ı���ʱ��, ��λ(��)
// WordWrap     : ��ÿ�г�����Ļ���ʱ�Ƿ��Զ�����,���򽫽ض���ʾ
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ���߸�λ(2G,3G)
function ResetClock(hPort: THandle; Model, Reserved: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// Model        : �����ͺ�, 0 Ϊ�Զ�
// Reserved     : ����,��Ϊ��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��
//˵��:
//  ��Ҫ�����ͽ����豸ά��ģʽ
{�豸������ͨ��}




















{���ڻ�������}
//		  ���豸�Ѿ��洢�Ŀ��ڼ�¼��
function ReadClockRecordTotal(hPort: THandle; var data: Integer): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// data         : ���ؿ��ڼ�¼����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  ���豸���Դ洢������ڼ�¼��
function ReadMaxClockRecordTotal(hPort: THandle; var data: Integer): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// data         : �����豸���Դ洢������ڼ�¼��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  �޸����⿨�򿨵�ʱ����
function SetCardTimeInterval(hPort: THandle; timeInterval: Double): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// timeInterval : �µĴ�ʱ����, ��Χ: 0.0 -- 2.25 ��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  �����⿨�򿨵�ʱ����
function ReadCardTimeInterval(hPort: THandle; var timeInterval: Double): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// timeInterval : ���ش�ʱ����, ��λ��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  ����ȫ�쿼��(����ʱ�����ˢ��)
function SetWholeTimeClock(hPort: THandle): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

type
  PClockerTime=^TClockerTime;
  TClockerTime=packed record
    StartTime,
      EndTime: array[0..5] of char;
  end;

//      ��ȡ������ˢ��ʱ���  (��෵��4��ʱ���)
function ReadClockerTime(hPort: THandle; var Clocks: array of TClockerTime{; ArraySize: Integer}): Integer; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// Clocks       : ����ʱ�������, ������Ҫ4����Ԫ
// ArraySize    : Delphi����Ҫ,�����VB����C++��Ҫ�������С����
//����ֵ:
// 0            : ��ȡʧ��
// 1-4          : ˢ��ʱ��θ���

function ReadClockerTimeEx(hPort: THandle; ClockTime: PChar): Integer; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// ClockTime    : ����ʱ����ַ�, ������Ҫ4*8=32����Ԫ��ÿ8���ַ�һ��ʱ��Σ���ʽ��hhnnhhnn
//����ֵ:
// 0            : ��ȡʧ��
// 1-4          : ˢ��ʱ��θ���

//		  ���ÿ���ʱ���  (����������4������ʱ���)
function SetClockerTime(hPort: THandle; StartTime, EndTime: PChar): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// startTime    : ��ʼʱ��, ��ʽ:hhmm, ��Χ:0000-2400
// EndTime      : ����ʱ��, ͬ��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

function SetClockerTimeEx(hPort: THandle; ClockTime: PChar): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// ClockTime    : ����ʱ���(���4��)��ÿ��ʱ��θ�ʽ:hhmmhhmm��ǰ4���ǿ�ʼʱ�䣬��4���ǽ���ʱ��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  ����ͬһ�ſ��ظ�ˢ��ʱ����
function SetRepeatClockerTime(hPort: THandle; timeLen: Integer): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// timeLen      : ʱ����, ����Ϊ 1-99 ����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  ��ͬһ�ſ��ظ�ˢ��ʱ����
function ReadRepeatClockerTime(hPort: THandle; var timeLen: Integer): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// timeLen      : ʱ����, ����Ϊ 1-99 ����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  ����豸�����д���ʱ��
function ClearRing(hPort: THandle): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

type
  TRingTime=packed record
    hour, minute, second, RingTimeLen: Integer;
  end;

//      ��ȡ�豸����ʱ�� (��෵��32������)
function ReadRing(hPort: THandle; var RingTimes: array of TRingTime{, ArraySize: Integer}): Integer;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// RingTimes    : ����ʱ������, ������Ҫ32����Ԫ
// ArraySize    : Delphi����Ҫ,�����VB����C++��Ҫ�������С����
//����ֵ:
// 0            : ʧ��
// 1-32         : ��Ч����ʱ������

//	    �����豸����ʱ�� (����������32�δ���)
function SetRing(hPort: THandle; hour: Integer; minute: Integer; second: Integer; ringTimeLen: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
//		hour, minute, second  :  Ϊ�������ʼʱ��, ��ֵ�ֱ�Ϊ : 0-23, 0-59, 0-59
//		ringTimeLen			  :  Ϊ����ĳ���ʱ��, ��ֵΪ 1-60 ��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//	  	��ˢ����¼(ALL)
function ReadRecord(hPort: THandle; data: PChar; timeString: PChar; var mark: Char; FirstRecord: Boolean): Boolean; stdcall; external EASTRIVER_API
//������Ϊͨ�ö���¼����, �����������ض����ܺ�������
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// data         : ���صĿ����ַ���, ����������20�ֽڳ���
// timeString   : ���ص�14λˢ��ʱ���ַ���, ��ʽΪyyyymmddhhmmss, ����������20�ֽڳ���
// mark         : ��������ʶ�ַ�.
// FirstRecord  : �Ƿ�ֻ��ȡ��˼�¼,����ɾ����˼�¼,��ȡ��һ����¼
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��ˢ����¼(^2G)
function ReadStandardRecord(hPort: THandle; Data: PChar; timeString: PChar; var mark: Char; var flag: Integer; var cardTimes: Integer; var cardGroup: Integer): Boolean; stdcall; external EASTRIVER_API
//ʹ�ú���ǰ��ȷ���豸���Ĵ洢����Ϊ16
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// data         : ���صĿ����ַ���, ����������20�ֽڳ���
// timeString   : ���ص�14λˢ��ʱ���ַ���, ��ʽΪyyyymmddhhmmss, ����������20�ֽڳ���
// mark         : ��������ʶ�ַ�.
// flag         : �洢���Ľ��
//    flag = 0   : ��ʾΪ������
//    flag.0 = 1 : ��ʾΪ�Ƿ��Ž���
//    flag.1 = 1 : ��ʾΪ�Ƿ����ڿ�
//    flag.2 = 1 : ��ʾΪ��������
// cardTimes    : ��������, 0-15
// cardGroup    : �������, 0-255
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��ȡˢ����¼(ALL)
function ReadClockData(hPort: THandle; CardNo: PChar; var SignTime: Double; var mark: Char; FirstRecord: Boolean): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// CardNo       : ���ؼ�¼����
// SignTime     : ���ؼ�¼ˢ��ʱ��, Delphi��TDateTime����,VB��Date����
// mark         : ���ؼ�¼��ʶ, ��Χ:'0'-'9', 'A'-'F'
// FirstRecord  : �Ƿ�ֻ��ȡ��˼�¼,����ɾ����˼�¼,��ȡ��һ����¼
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��ȡ��¼(���ı���ʽ1G)
function ReadRecordText(hPort: THandle; data: PChar; FirstRecord: Boolean): Integer; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// data         : ��¼�ı�, ��ʽ���ݾ�����Ͷ���,һ����:yy��MM��dd��hhʱnn��mark��ʶCardNo����
//����ֵ:
// -1           : ����
// 1-30         : �ɹ�


//������¼�ṹ
type
  PICRecord=^TICRecord;
  TICRecord=packed record
    Card: array[0..19] of char; // �����ַ���
    timeString: array[0..19] of char; // 14λˢ��ʱ���ַ���, ��ʽΪyyyymmddhhnnss
    EmpId: array[0..9] of char;
    mark: Integer; // ��������ʶ�ַ�
    flag: Integer; // �洢���Ľ��
//            flag = 0   : ��ʾΪ������
//            flag.0 = 1 : ��ʾΪ�Ƿ��Ž���
//            flag.1 = 1 : ��ʾΪ�Ƿ����ڿ�
//            flag.2 = 1 : ��ʾΪ��������
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
    reserved4: array[0..100] of Char; // ����ԭʼ����
  end;

//      ����������(^2G)
function BatchReadRecord(hPort: THandle; var Records: array of TICRecord{; ArraySize: Integer}): Integer; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// Records      : ���ؼ�¼����, ������Ҫ16����Ԫ
// ArraySize    : Delphi����Ҫ,�����VB����C++��Ҫ�������С����
//����ֵ:
// -1           : ����
// 0            : ��¼�Ѿ�����
// 1-16         : ��ȷ��ȡ�ļ�¼����

function BatchReadRecordEx(hPort: THandle; Action: Integer; Bytes: Integer; var Count: Integer; Data: PChar): Integer; stdcall; external EASTRIVER_API
//����˵����
//hPort         : �˿ھ������Ҫ����
//Action        : ���ܣ���һ�δ�0�������һ������Ϊ1���ض���һ��ʱ�������������ԭ��Ҫ���ض�ʱ����Ϊ0
//Bytes         : ÿ����¼�ĳ���,ĿǰΪ16
//Count         : ���ر�������ȡ�ļ�¼�������Ϊ0��ʾû�м�¼��
//Data          : ���ص�����,��ʽ������+TAB�Ʊ��+����+TAB�Ʊ��+״̬+TAB�Ʊ��+��־
//                ״̬��983����
//                ��־��and 15 ��ʾ�򿨽��������
//                flag = 0     : ��ʾ������
//                flag.0 = 1   : �Ƿ��Ž���
//                flag.1 = 1   : ��ʾΪ�Ƿ����ڿ�
//                flag.2 = 1   : ��������
//                flag.12=11   : �Ǵ�ʱ�δ洢��
//                flag.3 = 1   : δ��(��0)
//                flag.45      : 0-3 ��Ӧ1-4�Ŷ�����
//                flag.6-7     : Mark ��ʶ
//                ע��890,880,889��ʶ=flag.4-7
//                    980,981,983��ʶ=flag.6-7  ������=flag.4-5
//����ֵ
//0 :��ȷ
//1 �����������
//2 У�����
//3 ��ʱ����
//4 ��ĳһ֡�ļ�¼��������

//      ����һ�ε���BatchReadRecord�����ļ�¼(^3G)
function BatchReadPrevRecord(hPort: THandle; var Records: array of TICRecord{; ArraySize: Integer}): Integer; stdcall; external EASTRIVER_API
//ͬBatchReadRecord()

//		  ɾ�����еĴ洢���ڿ���¼
function ClearAllReadCard(hPort: THandle): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
//����ֵ:
// True         : ɾ���ɹ�
// False        : ɾ��ʧ��

const
  BytesOfRecord=64; //ÿ��¼�ֽ���
  RecordsOfFrame=400; //ÿ֡��¼��

type
  //ER-980�Ž���¼�ṹ
  P980ReadData=^T980ReadData;
  T980ReadData=packed record
    Verify_Error : Boolean;	              //�˼�¼У���Ƿ���ȷ, ���û�����,
                                          //�����¼У������������������һ����¼��������ΪFalse
    CardNo       : array[0..19] of char;	//����(20���ֽ�,��0�����ַ���)
    TimeString   : array[0..19] of char;  //ʱ��(20���ֽ�,��0�����ַ���)
    flag         : Integer;               //�򿨽��
//          flag = 0     : ��ʾ������
//          flag.0 = 1   : �Ƿ��Ž���
//          flag.1 = 1   : ��ʾΪ�Ƿ����ڿ�
//          flag.2 = 1   : ��������
//          flag.12=11   : �Ǵ�ʱ�δ洢��
//          flag.3 = 1   : δ��(��0)
//          flag.45      : 0-3 ��Ӧ1-4�Ŷ�����
//          flag.6-7     : Mark ��ʶ
//          ע��890,880,889��ʶ=flag.4-7
//              980,981,983��ʶ=flag.6-7  ������=flag.4-5
    Group        : Integer;               //����
    Times        : Integer;               //��������
    Record_Total : Integer;               //�ɼ����ݵ��ܼ�¼��
    Record_Index : Integer;               //��ǰ��¼�ǵڼ�����¼
  end;

  //ER-690���Ѽ�¼�ṹ(��С��ER-980��¼һ��)
  P690ReadData=^T690ReadData;
  T690ReadData=packed record
    Verify_Error : Boolean;	              //�˼�¼У���Ƿ���ȷ, ���û�����,
                                          //�����¼У������������������һ����¼��������ΪFalse
    CardNo       : array[0..19] of char;	//����(20���ֽ�,��0�����ַ���)
    TimeString   : array[0..19] of char;  //ʱ��(20���ֽ�,��0�����ַ���)
    flag         : Integer;               //�򿨽��
//          flag = 0     : ��ʾ������¼
//          flag = 1     : ������ֵ��¼
//          flag = 2     : ���ɻ���ֵ��¼
//          flag = 3     : �˻������ս������Ѽ�¼
//          flag = 7     : ��ʾ�˼�¼�Ŀ�Ƭ��д����ʱ���ڹ����뿪�˸�Ӧ�����п��ܽ��û������д��
//          ������־
//          flag = 5     :͸֧����
    Consume      : Integer;                  //���ѽ��,��λ��
    Balance      : Integer;                  //���Ѻ����,��λ��
    Times        : Integer;               //��ֵ����
    Record_Total : Integer;               //�ɼ����ݵ��ܼ�¼��
    Record_Index : Integer;               //��ǰ��¼�ǵڼ�����¼

    //������Ա
    Clock_ver    : Integer;              //���Ѽ�¼�汾��
    Clock_ID     : Integer;              //����
    POS_Sequ     : Integer;              //POS������ˮ��
    Card_Sequ    : Integer;              //��������ˮ��
    Order_ID : Integer;              //������˳���
    Op_CardNo    : array[0..19] of Char; //POS������Ա����
    Date_ver     : array[0..19] of Char; //ʱ��汾��
    OverPwd      : array[0..9] of char; // ������������
    reserved1    : DWORD;//983���ص���״̬
    reserved2    : DWORD;
    reserved3    : array[0..19] of Char; // ����
    reserved4    : array[0..100] of Char; // ����
  end;

  PReadData=P690ReadData;//����Ҫ��������
  TReadData=T690ReadData;//����Ҫ��������

  PArrayReadData=^TArrayReadData;
  TArrayReadData=array[0..RecordsOfFrame] of TReadData;

  //���ż�¼��ԭʼ���ݻ�����
  PTRecordData=^TRecordData;
  TRecordData=array[0..150] of Char;

  //�ƶ���¼��ԭʼ���ݻ�����
  PTCQRecordData=^TCQRecordData;
  TCQRecordData=array[0..255] of Char;

  //ɽ���¿���ʽ�ṹ
  P690SDReadData=^T690SDReadData;
  T690SDReadData=packed record
    CardFormatType: Integer;                    //ת�˿������ͣ�1�ֽڣ�0x00��2.0��ʽ���ſ���0x01����ʱ�����ڿ���0x02����ʱ�����ѿ���
    WaterCtrlBalace: Double;                    //01-04��ˮ��Ǯ��ת�ʺ���С�˸�ʽ��
    CardTimes     : Integer;                    //05-06����ʱ������ʽ�ĳ�ֵ��������˸�ʽ,2.0���ſ���ʽ���ֶ���Ч��
    CardSN        : array[0..9] of Char;        //�����к�
    CheckStr      : array[0..3] of Char;        //��֤�������ֽ�
    CardNo       	: array[0..15] of char;	      //����(8���ֽ�)
    BusiType			: Integer;        			      //�������� ��0x01�����ѣ�0x02����ֵ��
    AppType       : Integer;                    //Ӧ������ ��0x01��ȫ��Ǯ����0x04��ʡǮ����0x08����ҵǮ����
    AppCardSN     :	array[0..11] of Char;       //SAM��Ӧ�����к�
    POSSequ     	: Integer;          		      //�ն˽�����ˮ��
    CardType      : Integer;                    //���ֱ�ʶ
    CityCode			:	array[0..3] of Char;        //���д���
    CardSequ      : Integer;                    //��˳���
    OldAmount     : Double;							        //����ǰ���
    BusiAmount    : Double;							        //���׽��
    BusiDate		  : array[0..7] of char;        //��������
    BusiTime		  : array[0..5] of char;        //����ʱ��
    BusiCnt       : Integer;                    //���״���
    TACCheck			: array[0..7] of Char; 		    //TACУ��
    RecordType    : Integer;                    //��¼����
                                                { 0x00��ʾ����ˢ����¼
                                                  0x13��ʾִ�е����׵Ĳ���3�����˲������S1B0Ǯ����
                                                  0x14��ʾִ�е����׵Ĳ���4�����˲�����½�����ϸ��Ϣ��
                                                  0x15��ʾִ�е����׵Ĳ���5�����˲������S9B0������ɣ�
                                                  0x16��ʾִ�е����׵Ĳ���6�����˲��踴��S9B0��S9B1��
                                                  0x17��ʾִ�е����׵Ĳ���7�����˲��踴��S1B0��S1B1��}
    AllowanceType : Integer;                    //��¼���Ͷ���
                                                { 0x00��ʾ����(�ǲ���)
                                                  0x01��ʾ��׼����ģʽ
                                                  0x02��ʾ�������ģʽ
                                                  0x03��ʾ�Զ�����ģʽ}
    AllowanceVersion : Integer;                 //�����汾
    Record_Total  : Integer;                    //�ɼ����ݵ��ܼ�¼��
    Record_Index  : Integer;                    //��ǰ��¼�ǵڼ�����¼
    Reserved      : TRecordData;//array[0..150] of Char; 		  //ԭ��¼
  end;

  PSDReadData=P690SDReadData;//����Ҫ��������
  TSDReadData=T690SDReadData;//����Ҫ��������

  //�ƶ��¿���ʽ�ṹ
  P690CQReadData=^T690CQReadData;
  T690CQReadData=packed record
    POSID         : array[0..11] of char;         //�ն˻���
    POSSequ     	: Integer;          		        //�ն˽�����ˮ��
    CompanyID     : array[0..11] of Char;         //��ҵID
    CommonEmpID   : array[0..39] of Char;         //ͳһ����Ա��ID
    CompanyEmpID  : array[0..7] of Char;          //��ҵԱ��ID,EESQEQ
    CardAppSequ   :	array[0..15] of Char;         //Ӧ�����к�
    BusiCnt       : Integer;                      //���������
    BusiType			: Integer;        			        //�������ͣ�0x02��Ȧ�棻0x06���ѻ����ѣ�0x21���������ѣ�0x22���ѻ����ѳ�����0x23���������ѳ�����0x24���˷ѣ�
    BusiStyle     : Integer;                      //Ǯ�����ͣ�1�ֽڣ���0x01��������0x02���������  0x11�����޴Σ�0x12�����޴Σ�
    OldValue      : Double;							          //����ǰ���������
    BusiValue     : Double;							          //���׽��������
    BusiDate		  : array[0..7] of char;          //��������
    BusiTime		  : array[0..5] of char;          //����ʱ��
    TACCheck			: array[0..7] of Char; 	        //TACУ��
    AppIndex      : Integer;                      //��Ӧ��������
    RecordType    : Integer;                      //��¼���� 0=�ɹ� ��������
    CardType      : Integer;                      //�����ͱ�ʶ(0x00����ͨIC����0x01��(U)SIM����
    WalletBalType : Integer;                      //������ͣ�0x00��������0x01�����ˣ�
    OperatorID    : Integer;                      //����Ա���루2�ֽڣ�BCD��01-98�൱��0x0001-0x0098��
    AllowanceType : Integer;                      //�ƶ�����ʽ��������ʽ��1�ֽڣ�0x00����, 0x01�ۼӣ���Ǯ���������Ϊ��ҵ����ʱ��Ч����ЧʱΪ0xFF��
                                                  //���ſ���ʽ����¼���Ͷ��� 0x00��ʾ���� 0x01��ʾ��׼����ģʽ 0x02��ʾ�������ģʽ 0x03��ʾ�Զ�����ģʽ
    AllowanceVersion : Integer;                   //���ſ���ʽ���Զ��������Σ����Զ�������ʱΪ0����˸�ʽ�����ֽ���ǰ[61]�����ֽ��ں�[62]��
    AppType       : Integer;                      //���ſ���ʽ��Ӧ�����ͱ�ʶ��1 �ֽڣ�0x01��ȫ��Ǯ����0x04��ʡǮ����0x08����ҵǮ����
    CardFormatType: Integer;                      //��¼�汾	���ſ���ʽ��0x01	�ƶ�����ʽ��0x02
    Record_Total: Integer; //�ɼ����ݵ��ܼ�¼��
    Record_Index: Integer; //��ǰ��¼�ǵڼ�����¼
    Reserved      : TCQRecordData;//array[0..255] of Char; 		    //ԭ��¼
  end;

  PCQReadData=P690CQReadData;//����Ҫ��������
  TCQReadData=T690CQReadData;//����Ҫ��������

//      ���ݴ���ص�����
TDataProcess = function(lpData: Pointer; lpReadData: PReadData): Boolean;stdcall;
// lpData       : �Զ������, ��ӦReadAllRecord()�ĵڶ�������
// lpReadData   : ��¼�ṹָ��
//����ֵ:
//�����Ҫ������һ����¼�򷵻�True, �����Ҫ��ֹ���ݶ�ȡ�ɷ���False,

TTimeLapse = procedure(lpData: Pointer; microsecond: Integer);stdcall;
//��ʱ�ص�
//����˵��:
// lpData       : �Զ������, ��ӦReadAllRecord()�ĵڶ�������
// microsecond  : ���ʹ�ô˺�����Ӧ��microsecond ΢���ڰ�ʱ����
//�޷���ֵ

//      ���ݴ���ص�����
TSDDataProcess = function(lpData: Pointer; lpReadData: Pointer): Boolean;stdcall;
// lpData       : �Զ������, ��ӦReadAllRecord()�ĵڶ�������
// lpReadData   : ��¼�ṹָ��
//����ֵ:
//�����Ҫ������һ����¼�򷵻�True, �����Ҫ��ֹ���ݶ�ȡ�ɷ���False,

TSDTimeLapse = procedure(lpData: Pointer; microsecond: Integer);stdcall;
//��ʱ�ص�
//����˵��:
// lpData       : �Զ������, ��ӦReadAllRecord()�ĵڶ�������
// microsecond  : ���ʹ�ô˺�����Ӧ��microsecond ΢���ڰ�ʱ����
//�޷���ֵ

//      ��֡(һ֡400��)��ȡ�������м�¼
function ReadAllRecord(hPort: THandle; lpData: Pointer; DataProcess: TDataProcess; Wait:TTimeLapse=nil): Integer;stdcall; external EASTRIVER_API
//�����м�¼����
//����˵��:
// lpData       : ָ��������ص�����DataProcess()�Ĳ���ָ����ΪDataProcess()�ĵ�һ������������ÿ���ΪNULL
// DataProcess  : ָ��ṹ TReadData ��ָ��, ���ݿ����һ����¼
// Wait         : ��ʱ�ص�����ָ��, ���ÿ���ΪNULL
//����ֵ:
// 0            : �����ڼ�¼�ѿ�(�޼�¼)
// >0           : �ɹ���ȡ��¼��
// -1,-2        : ����ͨ�Ŵ���
// -3           : ���������У�����
// -4           : �û���ֹ�����δ���
// -5           : ��֧�ֵ�����,��Ҫ������������ɼ�����
// -8,-9        : ��Դ�������

//      ��֡(һ֡400��)��ȡ�������м�¼
function SDReadAllRecord(hPort: THandle; lpData: Pointer; DataProcess: TSDDataProcess; Wait: TSDTimeLapse=nil): Integer;stdcall; external EASTRIVER_API
//�����м�¼����
//����˵��:
// lpData       : ָ��������ص�����DataProcess()�Ĳ���ָ����ΪDataProcess()�ĵ�һ������������ÿ���ΪNULL
// DataProcess  : ָ��ṹ TReadData ��ָ��, ���ݿ����һ����¼
// Wait         : ��ʱ�ص�����ָ��, ���ÿ���ΪNULL
//����ֵ:
// 0            : �����ڼ�¼�ѿ�(�޼�¼)
// >0           : �ɹ���ȡ��¼��
// -1,-2        : ����ͨ�Ŵ���
// -3           : ���������У�����
// -4           : �û���ֹ�����δ���
// -5           : ��֧�ֵ�����,��Ҫ������������ɼ�����
// -8,-9        : ��Դ�������

//      ��֡(һ֡400��)��ȡ�������м�¼

type
  TReadProgressProc=function(Position, AMax: Integer; lpReadData: PReadData; reserved: Integer): Boolean; stdcall;

//      һ���Զ�ȡ���м�¼��ָ�����ļ�
function ReadAllRecordAsFile(hPort: THandle; clock_id: Integer; FileName: PChar; hWndParent: HWND; bShowProg: Boolean; Progress: TReadProgressProc): Integer; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// clock_id     : ����
// FileName     : ָ���ı��ļ���, ���������, �����Զ�����,
//                �������, ���յļ�¼����׷�����ļ�ĩβ
//                ����ļ���Ϊ��,�򲻱����ļ�
// ÿ����¼һ��,��ʽ����:
// ����<TAB>����ʱ��<TAB>����<TAB>��¼��ʶ<TAB>״̬(FLAG)<TAB>�ź�
// ����<TAB>Ϊ�Ʊ��(ASCIIֵ:#9)
// hWndParent   : ���̶Ի���ĸ����ھ��,����Ϊ0
// bShowProg    : �Ƿ���ʾ���ս��̶Ի���
// Progress     : ���̻ص�,���ÿ�����ΪNULL
//����ֵ:
// ͬ ReadAllRecord

{���ڻ�������}
















{�ڰ�������}
//      ������ȡ�ڰ��������̻ص�
type TProgressProc=function(TypeId, PageNo, Percent: Integer): Boolean; stdcall;
//����˵��:
// TypeId       : ��������, 0: �Ž�ͨ�п�, 1:������, 2: ������
// PageNo       : ҳ��
// Percent      : ����ɰٷֱ�, �� 80=80%
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  �������Ѿ����ص������ڿ�(������)����
function ReadSavedAllowedClockerCardNumber(hPort: THandle; var data: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// data         : �����Ѿ����صİ���������
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  �������Ѿ����صĺ�����������
function ReadSavedBlackCardNumber(hPort: THandle; var data: Integer): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// data         : �����Ѿ����صĺ���������
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  �������Ѿ����ص��Ž�ͨ�п�����
function ReadSavedLockerPassCardNumber(hPort: THandle; var data: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// data         : �����Ѿ����ص��Ž�ͨ�п�����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//�㲥���ؿ�����
function BroadCastAllCard(hPort, WinHnd:THandle; Kind: Integer; Action: Integer;Card,EmpID,EmpName,PassTime:PChar; var Count: Integer; Delay:Integer=80): Boolean; stdcall; external EASTRIVER_API
//���ܣ��������еĿ����б�
//������hPort �����Ķ˿ھ��
//      WinHand ����������������Ϣ�Ĵ��ھ�� WM_USER+$100;wParam��������
//      Kind:=0��ո������������������֮ǰ�����ô˲������е���һ�Σ����������ظ�
//           =1�Ž�������������EmpNameΪ���⣬ͨ��ʱ���������еģ���0000013008301030 ��ʾ0����1��30��8��30��10��30����ʱ���
//           =2���ڰ�����������Ҫ���룬��PassTime��Ϊ��
//           =3���ߺ�����, ����Card�����⣬����Ϊ��
//      Action=0��ʾ���������б�
//            =1��ʾ��ʼ������ҳ����
//            =2��ʾ��ʼ�㲥���ط�ʽ
//      CardStyle=1 ID��
//               =2 IC��
//       Count ��ʾ���سɹ����صĿ�����
//��ȡ������ʾ��
//{��������һ����Ϣ����ӳ����Ϣ��}
//procedure WMGETCOUNT(var Msg: TMessage); message WM_USER+$100;
//{ʵ�ָ���Ϣ������}
//procedure TForm1.WMCopydata(var Msg: TMessage);
//var Count: Integer;
//begin
//    Count := Msg.wParam;
//end;

//��״ָ̬ʾ�Ƶ�ʱ��
function SetStateLampTime(hPort: THandle; GE: Integer; Value: Integer): Boolean; stdcall; external EASTRIVER_API
//���� hPort�������
//     GE=1��ȷָʾ�� =2����ָʾ�� =3���ų�ʱʱ��
//     Value Ҫ���õ�ʱ�� 0.2��Ϊ��λ����Χ0--99

//��ȡ״ָ̬ʾ�Ƶ�ʱ��
function ReadStateLampTime(hPort: THandle; GE: Integer; var Value: Integer): Boolean; stdcall; external EASTRIVER_API
//���� ͬ��

//��ʼ��890����
function Init890(hPort:THandle; Kind:Integer): Boolean; stdcall; external EASTRIVER_API
//���� hPort �������
//     kind=1��������������õ�ʱ�����Ϣ
//         =2ʹ��Ĭ�Ϲ�����������ϵͳ�Ĺ���״̬
//         =3�����߳�ʼ���ɳ���״̬


//		  �����豸�������ڿ�(����������6���ַ����Ż�����)
function SetAllowedCard(hPort: THandle; card, empid, EmpName: PChar): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// card         : ����
// empid        : ����, ID����ʹ��, IC������ʹ��, �����6�������ַ�
// EmpName      : ����, ��ʽGB��, �����6��Ӣ���ַ�
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  ɾ���豸�������ڿ�(��������)
function DeleteAllowedCard(hPort: THandle; card: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// card         : ����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  ɾ���豸�����������ڿ�(��������)
function DeleteAllAllowedCard(hPort: THandle): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  �����豸�ĺ�������
function SetBlackCard(hPort: THandle; card: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// card         : ����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  ɾ���豸�ĺ�������
function DeleteBlackCard(hPort: THandle; card: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// card         : ����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  ɾ���豸�����к�������
function DeleteAllBlackCard(hPort: THandle): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  �����Ž����豸��ͨ�п�
function SetDoorPassCard(hPort: THandle; beginPass: PChar; endPass: PChar; card: PChar; EmpId: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// BeginPass    : ͨ�п�ʼʱ��
// endPass      : ͨ�н���ʱ��
// card         : ����
// empId        : ����,ID����ʹ��,�����6�������ַ�
//����ֵ:
// True         : �ɹ�
// False        : ʧ��
//˵��:
//���ö��ͨ��ʱ����ʹ��ͬһ�����ŵ��ö��

//		  ɾ���Ž����豸��ͨ�п�
function DeleteDoorPassCard(hPort: THandle; card: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// card         : ����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  ɾ���Ž����豸������ͨ�п�
function DeleteAllDoorPassCard(hPort: THandle): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//����������д�豸��������(^2G)
type
  PDownloadPageStruct=^TDownLoadPageStruct;
  TDownLoadPageStruct=packed record
    iPage: Integer; //ҳ��
    izData: array[0..255] of Byte; //һҳ����
    Next: PDownLoadPageStruct; //��һҳ��ָ��
  end;

  PDownLoadPageStructIndex=^TDownLoadPageStructIndex;
  TDownLoadPageStructIndex=packed record
    Index: array[0..255] of PDownLoadPageStruct; //���������������
    indexPage: array[0..255] of Integer; //��ַ������Ŵ�
    iCardNumber: Integer; //��ŵĿ�������
  end;

  PDownloadCardStruct=^TDownloadCardStruct;
  TDownloadCardStruct=packed record
    CardNo: array[0..15] of char; //16λ����
    EmpId: array[0..10] of Char; //6λ��ĸ���Ż����������ڰ�����
    case Integer of
      0: (Periods: array[0..11] of char);
        //6λ�ֽ�ͨ��ʱ��(��30����Ϊ��λһ��)�Ž�ͨ�п�
      1: (EmpName: array[0..11] of char); //�ڰ�����ʱ��Ա������
  end;

//      �����Ž���ͨ�п�����
function BatchReadDoorPassCard(hPort: THandle; var CardList: array of TDownloadCardStruct{; ArraySize: Intger}; var Number: Integer; CallBack: TProgressProc): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// CardList     : ����ͨ�п��ṹ����
// ArraySize    : Delphi����Ҫ,�����VB����C++��Ҫ�������С����
// Number       : ���������С,��������ش�С,ʵ�ʷ�����������
// CallBack     : ���̻ص�, ���ÿ���ΪNULL(0)
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��������������
function BatchReadAllowedCard(hPort: THandle; var CardList: array of TDownloadCardStruct{; ArraySize: Intger}; var Number: Integer; CallBack: TProgressProc): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// CardList     : ���ذ������ṹ����
// ArraySize    : Delphi����Ҫ,�����VB����C++��Ҫ�������С����
// Number       : ���������С,��������ش�С,ʵ�ʷ�����������
// CallBack     : ���̻ص�, ���ÿ���ΪNULL(0)
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��������������
function BatchReadBlackCard(hPort: THandle; var CardList: array of TDownloadCardStruct{; ArraySize: Intger}; var Number: Integer; CallBack: TProgressProc): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// CardList     : ���غ������ṹ����
// ArraySize    : Delphi����Ҫ,�����VB����C++��Ҫ�������С����
// Number       : ���������С,��������ش�С,ʵ�ʷ�����������
// CallBack     : ���̻ص�, ���ÿ���ΪNULL(0)
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

type
  TDoorTimePeriod=packed record //   �ֲ��ṹ��ʾһ��ʱ���
    TimeHour: Integer; //	 Сʱ[0..23]
    TimeMinute: Integer; //	 ����[0..59]
  end;

  PDoorTimePeriods=^TDoorTimePeriods;
  TDoorTimePeriods=packed record //	 �Ž���ʱ�νṹ
    StartTime: TDoorTimePeriod; //   ʱ�εĿ�ʼʱ��
    EndTime: TDoorTimePeriod;   //	 ʱ�εĽ���ʱ��
    Right: Integer;             //   ��ʱ�ε�Ȩ�ޣ�����ͬ���ܶ���ͬ
  end;


//		  ���ó����û�����(3G)
function SetSuperUserPwd(hPort: THandle; Number: Integer; Pwd: PChar; Right: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// Number       : �����û����, ��1��16 ���16�������û�
// Pwd          : ������6λ������, ����6λ����ǰ�油��
// Right        : ��4λ����4���ŵ�Ȩ��
//    Right.0=1 ����ɿ�1����
//    Right.1=1 ����ɿ�2����
//    Right.2=1 ����ɿ�3����
//    Right.3=1 ����ɿ�4����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      �����Ž���ʱ��
function SetDoorGuardPeriods(hPort: THandle; Fun: Byte; ts: array of TDoorTimePeriods; Count:Integer; week: Byte=0): Boolean;stdcall; external EASTRIVER_API
// Fun:        ʱ������(0-6) ����(����,����,������Ч,��ť��Ч,��������,�Ŵű���,���տ���)ʱ��
// ts :        ʱ�������
// Count:      ʱ�θ���
// Week:       ����(1-7)��������--��һ--����

//      ���ó���ʱ��Σ�����ʱ��Σ���Ȩ�� ÿ��������ĸ�ʱ��
function SetInOutRight(hPort: THandle; Week_Day: Integer; var ts: array of TDoorTimePeriods; Count: Integer=4): Boolean; stdcall; external EASTRIVER_API
// hPort    �� ���ھ����
// Week_Day �� ÿ�������е�һ�죬1 �����գ�2 ����һ��...��7 ������������ֵ�Ƿ���
// ts[]     �� ����ʱ��μ�Ȩ�޿�����[0..4]��ʱ�Σ�Right Ȩ��Ϊ0x00--0xFF(00--255)������Խ��Ȩ��Խ��
// ArraySize�� ��ֵ��ʹ�ÿ���Ϊ����ֵ��
// Count    �� ts[]�����õ�ʱ�θ���[0..4]��

//      ����������Чʱ�Σ�ÿ��������ĸ�ʱ��
function SetCipherSlice(hPort: THandle; var ts: array of TDoorTimePeriods; Count: Integer=4): Boolean; stdcall; external EASTRIVER_API
// hPort    �� ���ھ����
// ts[]     �� ����ʱ��Σ�������[0..4]��ʱ�Σ�Right Ȩ��bitΪ1��ʾѡ�У�
      //Right.0��ʾһ�Ŷ�ͷ��Right.1��ʾ���Ŷ�ͷ��Right.2��ʾ���Ŷ�ͷ��Right.3��ʾ�ĺŶ�ͷ��
// ArraySize�� ��ֵ��ʹ�ÿ���Ϊ����ֵ��
// Count    �� ts[]�����õ�ʱ�θ���[0..4]��

//      ���ñ�����Чʱ�Σ�ÿ��������ĸ�ʱ��
function SetAlertSlice(hPort: THandle; var ts: array of TDoorTimePeriods; Count: Integer=4): Boolean; stdcall; external EASTRIVER_API
// hPort    �� ���ھ����
// ts[]     �� ����ʱ��Σ�������[0..4]��ʱ�Σ�Right Ȩ��bitΪ1��ʾѡ�У�
             //Right.0��ʾһ�Ŷ�ͷ��Right.1��ʾ���Ŷ�ͷ��Right.2��ʾ���Ŷ�ͷ��Right.3��ʾ�ĺŶ�ͷ��
// ArraySize�� ��ֵ��ʹ�ÿ���Ϊ����ֵ��
// Count    �� ts[]�����õ�ʱ�θ���[0..4]��

//      ���ð�ť��Чʱ�Σ�ÿ��������ĸ�ʱ��
function SetButtonSlice(hPort: THandle; var ts: array of TDoorTimePeriods; Count: Integer=4): Boolean; stdcall; external EASTRIVER_API
// hPort    �� ���ھ����
// ts[]     �� ��ť��Чʱ��Σ�������[0..4]��ʱ�Σ�Right Ȩ��bitΪ1��ʾѡ�У�
         //Right.0��ʾһ�Ŷ�ͷ��Right.1��ʾ���Ŷ�ͷ��Right.2��ʾ���Ŷ�ͷ��Right.3��ʾ�ĺŶ�ͷ��
// ArraySize�� ��ֵ��ʹ�ÿ���Ϊ����ֵ��
// Count    �� ts[]�����õ�ʱ�θ���[0..4]��

//      ���õ�������ʱ�Σ�ÿ��������ĸ�ʱ��
function SetConstOpenSlice(hPort: THandle; var ts: array of TDoorTimePeriods; Count: Integer=4): Boolean; stdcall; external EASTRIVER_API
// hPort    �� ���ھ����
// ts[]     �� ��������ʱ��Σ�������[0..4]��ʱ�Σ�Right Ȩ��bitΪ1��ʾѡ�У�
       //Right.0��ʾһ�Ŷ�ͷ��Right.1��ʾ���Ŷ�ͷ��Right.2��ʾ���Ŷ�ͷ��Right.3��ʾ�ĺŶ�ͷ��
// ArraySize�� ��ֵ��ʹ�ÿ���Ϊ����ֵ��
// Count    �� ts[]�����õ�ʱ�θ���[0..4]��

//      �����ŴŴ��ڳ�������ʱ�Σ�ÿ��������ĸ�ʱ��
function SetCOAlertSlice(hPort: THandle; var ts: array of TDoorTimePeriods; Count: Integer=4): Boolean; stdcall; external EASTRIVER_API
// hPort    �� ���ھ����
// ts[]     �� ��������ʱ��Σ�������[0..4]��ʱ�Σ�Right Ȩ�޵���bit��ĳ��bitΪ1��ʾĳ����ͷѡ�У�
       //Right.0��ʾһ�Ŷ�ͷ��Right.1��ʾ���Ŷ�ͷ��Right.2��ʾ���Ŷ�ͷ��Right.3��ʾ�ĺŶ�ͷ��
// ArraySize�� ��ֵ��ʹ�ÿ���Ϊ����ֵ��
// Count    �� ts[]�����õ�ʱ�θ���[0..4]��

//      �趨�ڼ��յĿ���ʱ�κͿ���Ȩ�޵ȼ�
function SetHolidaySlice(hPort: THandle; var ts: array of TDoorTimePeriods; Count: Integer=4): Boolean; stdcall; external EASTRIVER_API
// hPort    �� ���ھ����
// ts[]     �� �ڼ��տ���ʱ�Σ�������[0..4]��ʱ�Σ�Right Ȩ��bitΪ1��ʾѡ�У�
       //Right.0��ʾһ�Ŷ�ͷ��Right.1��ʾ���Ŷ�ͷ��Right.2��ʾ���Ŷ�ͷ��Right.3��ʾ�ĺŶ�ͷ��
// ArraySize�� ��ֵ��ʹ�ÿ���Ϊ����ֵ��
// Count    �� ts[]�����õ�ʱ�θ���[0..4]��

//      ���ó����û����뿪��ʱ��
function SetSuperUserPwdSlice(hPort: THandle; var ts: array of TDoorTimePeriods; Count: Integer=4): Boolean; stdcall; external EASTRIVER_API
// hPort    �� ���ھ����
// ts[]     �� �ڼ��տ���ʱ�Σ�������[0..4]��ʱ�Σ�Right Ȩ��bitΪ1��ʾѡ�У�
       //Right.0��ʾһ�Ŷ�ͷ��Right.1��ʾ���Ŷ�ͷ��Right.2��ʾ���Ŷ�ͷ��Right.3��ʾ�ĺŶ�ͷ��
// ArraySize�� ��ֵ��ʹ�ÿ���Ϊ����ֵ��
// Count    �� ts[]�����õ�ʱ�θ���[0..4]��

//      �ڼ��յ��趨
function SetHoliday(hPort: THandle; const DayString: PChar): Boolean; stdcall; external EASTRIVER_API
// hPort    �����ھ��
// DayString��һ����ʾ������ڵ��ַ��������ʽΪ��"����0,����1,����2,����3,... ..." ���� "����0;����1;����2;����3;... ..."
// DayString �����԰���20�����ڣ�ÿһ�����ڱ�ʾ��һ��Ϊ�ڼ���
// ���ڵĸ�ʽΪ��"mmdd" �������ַ�����+�����ַ����գ�mmΪ�� ddΪ�ա���4��15��Ϊ��"0415"
// ���磺����趨5��1��,10��1�պ�12��25��Ϊ�ڼ��գ�DayString="0501��1001��1225"


//��������������Style������ȡֵ ֻ��DOOR_880STYLE ������ǰ�����ֵ�е�ĳһ��ͨ�������'|'������һ��
const
  DOOR_880STYLE = $80;  //�����Ž������Ƿ�ʹ��880����ķ�� 1-�ǣ�0-��

  //�����Ž����趨��Ȩ�޺�������Ž�ͨ�п�
function SetDoorPassCardDE(hPort: THandle; Style: Byte; Card: PChar; Code: PChar; Right: Integer=0; BeginPass: PChar=nil; EndPass: PChar=nil; EmpId: PChar=nil): Boolean; stdcall; external EASTRIVER_API
// hPort    �����ھ��
// Card     ���Ž�ͨ�п�����
// Code     ���ĸ��ֽ�����  ÿ���ֽڱ�ʾһ��16�������ּ�"0--9,A--F" (����Ϊ�ĸ��ֽڣ�����ʡ��)
// Right    ����ʾ����Ȩ�޺͵������ƣ�����ֵ0x00-0xFF)���߰��ֽ�(Right.H)�������ƣ��Ͱ��ֽ�(Right.L)��ʾȨ��
// Right.L  ���ĸ�bit��ʾ�ĸ�������ĳλ��1��ʾ���ſ�Ƭ�ܿ���Ӧ������bit0 ��ʾһ�ŵ�����bit1Ϊ���ŵ�����...
// Right.H  ����λ�ɱ�ʾ0x00-0x0F 16�����ֱ�ʾ���ſ�Ƭ��Ȩ�ޣ��������Ҫ���趨�Ŀ���ʱ�ε�Ȩ��ֵ���бȽ�
//          ��������ſ�Ƭ��Ȩ��ֵ������Ӧʱ��ε�Ȩ��ֵ���ʾ���ſ�Ƭ�����ʱ��ο��Կ��š�
//BeginPass,EndPass,EmpId���μ� SetDoorPassCard��������Style�����ڰ�λΪ1ʱ����Style|=DOOR_880STYLE����������������ǿգ������Ϊ�գ��������ԣ�
//���û��ʹ��DOOR_880STYLE������Code��������Ϊ��
//Style������ʹ�ò���SetAllowedCardDE

//      ���������ڿ�
function SetAllowedCardDE(hPort: THANDLE; Style: Byte; card: PChar; emp_id: PChar; emp_name: PChar=nil): Boolean; stdcall; external EASTRIVER_API
//���ܲ����ο�SetAllowedCard.
//Style:����ȡ����ֵ�е�һ��CARD_AUTO��IC_CONVERT��IC_NOCONVERT��ID_CONVERT��ID_NOCONVERT,
//Style=CARD_AUTO ����������Ĺ����������SetAllowedCardͬ
//�������ΪID�������û��Ѿ��任��16Ϊ���Žṹ����'EF0000000xxxxxxx')�����߶���880DҪʹ�ù��ţ���StyleӦ��ΪID_NOCONVERT
//���cardû�б任��16Ϊ���Žṹ���û�ϣ��������ʱ�任��16Ϊ���ţ������ʹ��ID_CONVERT���������ź��ԣ�,�����ϣ���任��ID_NOCONVERT
//IC����ͬ�����cardΪ16λ��׼���ţ�����ʹ�ò���IC_NOCONVERTǿ��������ʱ��Ҫ�Կ������任����cardû�б任��16λ��׼����
//Ҳ����ʹ�ô˲���ǿ�Ʋ�Ҫ���任����ʹ��IC_CONVERTǿ��������ǰ�任�ɱ�׼���š�����ͬ... ...

//      ɾ�������ڿ�
function DeleteAllowedCardDE(hPort: THANDLE; Style: Byte; card: PChar): Boolean;stdcall; external EASTRIVER_API
//���ܲ����ο�DeleteAllowedCard
//Style:����ȡ����ֵ�е�һ��CARD_AUTO��IC_CONVERT��IC_NOCONVERT��ID_CONVERT��ID_NOCONVERT,
//Style=CARD_AUTO ����������Ĺ����������DeleteAllowedCardͬ
//Style������ʹ�ò���SetAllowedCardDE

//      ���ú�����
function SetBlackCardDE(hPort: THANDLE; Style: Byte; card: PChar): Boolean;stdcall; external EASTRIVER_API
//���ܲ����ο�SetBlackCard
//Style:����ȡ����ֵ�е�һ��CARD_AUTO��IC_CONVERT��IC_NOCONVERT��ID_CONVERT��ID_NOCONVERT,
//Style=CARD_AUTO ����������Ĺ����������SetBlackAllowedCardͬ
//Style������ʹ�ò���SetAllowedCardDE

//      ɾ����������
function DeleteBlackCardDE(hPort: THANDLE; Style: Byte; card: PChar): Boolean;stdcall; external EASTRIVER_API
//���ܲ����ο�DeleteBlackCard
//Style:����ȡ����ֵ�е�һ��CARD_AUTO��IC_CONVERT��IC_NOCONVERT��ID_CONVERT��ID_NOCONVERT,
//Style=CARD_AUTO ����������Ĺ����������DeleteBlackAllowedCardͬ
//Style������ʹ�ò���SetAllowedCardDE

//      ɾ���Ž�ͨ�п�
function DeleteDoorPassCardDE(hPort: THANDLE; Style: Byte; card: PChar): Boolean; stdcall; external EASTRIVER_API
//���ܲ����ο�DeleteDoorPassCard
//Style:����ȡ����ֵ�е�һ��CARD_AUTO��IC_CONVERT��IC_NOCONVERT��ID_CONVERT��ID_NOCONVERT,
//Style=CARD_AUTO ����������Ĺ����������DeleteDoorPassCardͬ
//Style������ʹ�ò���SetAllowedCardDE

{�ڰ�������}


{���ѻ���}

//      ���۷�������ܺ�
function ReadClockMoneySum(hPort: THandle; var MoneySum: Integer): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// MoneySum     : ���5λ���Ľ��, �Խ�Ϊ��λ
//����ֵ:
// True         : �ɹ�
// False        : ʧ��
//���ݻ���->ER-680

//      ����۷�������ܺ�
function ClearClockMoneySum(hPort: THandle): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��
//���ݻ���->ER-680

//      �������ѵı�ż۸��(690)
function SetPriceList(hPort: THandle; Num: Integer; Value: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// Num          : ���Ѽ۸����, ��Χ1-9, ��Ӧ����1-9��
// Value        : ����, ��λ��, ��Χ0-65535
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��ȡ���ѵı�ż۸��(690)
function ReadPriceList(hPort: THandle; Num: Integer;var Value: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// Num          : ���Ѽ۸����, ��Χ0-9, ��Ӧ����0-9��
// Value        : ���ص���, ��λ��, ��Χ0-65535
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ���ö�ֵ���ѽ��(690)
function SetFixPrice(hPort: THandle; Value: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��
// hPort        : �˿ھ��, ��Ҫ����
// Value        : ��ֵ���Ѷ�, ��λ��, ��Χ0-65535,Ϊ��ʱȡ����ֵ����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��ȡ��ֵ���ѽ��(690)
function ReadFixPrice(hPort: THandle;var Value: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��
// hPort        : �˿ھ��, ��Ҫ����
// Value        : ���ض�ֵ���Ѷ�, ��λ��, ��Χ0-65535
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��������������޶�(690)
function SetDayMaxExpenditure(hPort: THandle; Value: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��
// hPort        : �˿ھ��, ��Ҫ����
// Value        : ��������Ѷ�, ��λ��, ��Χ0-65535, Ϊ��ʱ��ʾ������
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��ȡ����������޶�(690)
function ReadDayMaxExpenditure(hPort: THandle;var Value: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��
// hPort        : �˿ھ��, ��Ҫ����
// Value        : ��������Ѷ�, ��λ��, ��Χ0-65535
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ������������Ѵ�������(690)
function SetDayMaxConsumeTimes(hPort: THandle; Value: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��
// hPort        : �˿ھ��, ��Ҫ����
// Value        : ��������Ѵ���, ��Χ0-225, Ϊ��ʱ��ʾ������
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��ȡ����������޶�(690)
function ReadDayMaxConsumeTimes(hPort: THandle;var Value: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��
// hPort        : �˿ھ��, ��Ҫ����
// Value        : ������������Ѵ���, ��Χ0-255, Ϊ��ʱ��ʾ������
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ���ÿ���������ƽ��(690)(Ѻ��)
function SetCardForegift(hPort: THandle; Value: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��
// hPort        : �˿ھ��, ��Ҫ����
// Value        : ����������ƽ��, ��λ��, ��Χ:0-65535, Ϊ��ʱ��ʾ������
//����ֵ:
// True         : �ɹ�
// False        : ʧ��


//      ��ȡ����������ƽ��(690)(Ѻ��)
function ReadCardForegift(hPort: THandle;var Value: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��
// hPort        : �˿ھ��, ��Ҫ����
// Value        : ���ؿ���������ƽ��, ��λ��, ��Χ:0-65535, Ϊ��ʱ��ʾ������
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ���ز�����ֵ��¼(690C������)
function SetAllowCharge(hPort: THandle; Style: Byte; CardNo: PChar; Value: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��
// hPort        : �˿ھ��, ��Ҫ����
// Style        : ���Ÿ�ʽ, �����SetAllowedCardDE
// CardNo       : ��ֵ����,5-7λ�ַ���
// ˵���������2.0�����ز���ʱ�����ڿ��ź����������(yymmdd)��Ϊ�����汾��,��000001�ſ��������汾��Ϊ051129����CardNoΪ000001051129
//       1.0�治��Ҫ�汾��
// Value        : ������ֵ���, ��λ��, ��Χ:0-65535
//����ֵ:
// True         : �ɹ�
// False        : ʧ��
//˵��:
// ������ֵ��¼���ص�ר�ò�������,����Ӧ��IC��ˢ��ʱ,���������IC��,
// ������һ����ֵ��¼,���ϵĳ�ֵ�����Զ���1,����ջؼ�¼Flag=01�ж�Ϊ����
// ��ֵ��¼������ˢ����¼(Flag=00)����
// �����2.0�����ݲɼ���������һ�������汾��

{���ѻ���}















{ʵʱ������}
//      ����Windows��Ϣ��ʽ�¼�֪ͨ���ڳ���
function ERAsyncSelect(hPort, hWnd: THandle; wMsg: ulong; EventId: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��
// hWnd         : ������Ϣ֪ͨ�Ĵ��ھ��, ���Ϊ����ȡ��֪ͨ
// wMsg         : �Զ�����Ϣ��, ��ô���WM_USER��ֵ
// EventId      : ֪ͨ�¼�����, ��Ϊ����ֵ
const
  FED_READ       = $01; // ׼����������
  FED_WRITE      = $02; // ׼����������
  FD_ACCEPT      = $03; // ���մ��������
  FED_CONNECT    = $04; // �����ɹ�
  FED_DISCONNECT = $05; // �Ͽ�����
  FED_CLOSE      = $06; // �˿ڹر�
  FED_NOTIFY     = $07; // ����֪ͨ, ����½�������
  FED_MAX        = $0F; // ����¼�ID
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��ȡ����ˢ������
function ReadLastCard(hPort: THandle; CardNo: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// CardNo       : ���ؿ��Ż�����,��Ҫ20���ַ��ռ�
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��ȡ���̰���
function ReadKeyboardPressKey(hPort: THandle; var key: char): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// key          : ���ض��õļ��̰���ֵ
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��ȡ����״̬
function ReadDoorState(hPort: THandle; var Opening: Boolean): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// Opening      : ���������Ƿ��Ǵ�״̬
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ������������������Ž�������
function SetDoorOpen(hPort: THandle): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      �����豸״̬
function SetClockState(hPort: THandle; State: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// state        : ״̬��, �Զ�����λ����
//		state.1--state.0 = 10B  :  �豸��������, ��������һ��
//						 = 11B  :  �豸�������, ������������
//						 = 00B or 01B  :  ������
//		state.2 = 1  :  �����豸�������� (���Զ��ر�)
//				= 0  :  �����豸�����ر�
//		state.3 = 1  :  �����豸���������� (���Զ�ֹͣ)
//				= 0  :  �����豸������ֹͣ����
//		state.6 = 1  :  state.5, state.4 �ֱ�Ϊ8о������ Data, Clock��״̬.
//						�ÿ���ֻ����ʹ���IC����, ��ID���ͽ�ֹʹ��
//		state.6 = 0  :  state.5, state.4 ������
//		����λ����, ����0
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ���Ʊ�����״̬
function SetAlarm(hPort: THandle; Alarm: Boolean): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// Alarm        : ϣ�����õı�����״̬
//    Alarm     = True  : ����������
//    Alarm     = False : ��������
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//���û��߿��Ŵ���ʽ
function SetProcessCardStyle(hPort: THandle; Style: PChar): Boolean; stdcall; external EASTRIVER_API
//����
//  hPort: �������
//  Style: ���û���ʹ�ÿ�Ƭ��ʽ=������ͷ+��Ӷ�ͷ��ʮ�����ƣ���
//         ������ȡ��Ƭ���ݽ�����ʽ��ϵͳ֧�ֵ���Ч�������ݸ�ʽ���£�
//         0x00  ����δ��װ��ͷģ�顣
//         0x01  ��ȡIC�����кŵ���ID��ʹ�á�
//         0x02  ��ȡIC����д������ݽ��н���ʹ�á�
//         0x03  ��ȡIC�����кŽ�����Ȩ��⣬��������Ϊ���š�
//         0x08  EM4001 ID����ʮλBCD���š�
//         0x09  EM4001 ID������λBCD���š�
//         0x0A  EM4001 ID������λBCD���š�
//         0x0B  EM4001 ID������λʮ�����ƿ��š�
//         0x0C  ABAͨѶ��ʽHID������λBCD���š�
//         0x0D  ABAͨѶ��ʽHID����ʮλBCD���š�
//         ����������
//         ������Ӷ�ͷ��ȡ��Ƭ���ݽ�����ʽ���������£�
//         0x00��������Ӷ�ͷ��
//         ����ͬ���߱�����ͷ��ȡ��Ƭ���ݽ�����ʽ��

//��ȡ���߿��Ŵ���ʽ
function ReadProcessCardStyle(hPort: THandle; Style: PChar): Boolean; stdcall; external EASTRIVER_API

//�����Ž���ER-980ʵʱ����ָ��
type
  PCardInfo=^TCardInfo;
  TCardInfo=packed record
    CardNo: array[0..17] of char; //�洢����
    IsIDCard: Boolean; //���ʱID��Ϊtrue������Ϊfalse��IC��
    NoCard: Boolean; //���Ϊtrue����û�п�Ƭ�ڸ�Ӧ�����˽ṹ����������Ч
    Reader: Integer; //��Χ��1-4ָ���Ŷ�ͷ
    Flag:   Integer; //�򿨽��
    Mark:   Integer; //�򿨱�־
  end;

//      ��ȡ��������Ӧ���ϵĿ�Ƭ����(^3G)
function GetCardOnReader(hPort: THandle; clock_id: Integer; Card: PCardInfo): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ����Ҫ����
// clock_id     : ����, ����ֵ:0-255
// Card         : TCardInfo ָ�룬�洢���ؽ��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

type
  PRealCardInfo=^TRealCardInfo;
  TRealCardInfo=packed record
    Size: Integer;      //�˽ṹ��С
    CardNo: array[0..17] of char; //�洢����
    IsIDCard: Boolean; //���ʱID��Ϊtrue������Ϊfalse��IC��
    NoCard: Boolean; //���Ϊtrue����û�п�Ƭ�ڸ�Ӧ�����˽ṹ����������Ч
    Reader: Integer; //��Χ��1-4ָ���Ŷ�ͷ
    Flag:   Integer; //�򿨽��
    Mark:   Integer; //�򿨱�־
    times:  Integer; //��ֵ����
    balance: Integer; //���Ѻ����,��λ��
    consume: Integer; //���Ѷ�,��λ��
  end;

//      ʵʱ��ѯ�Ƿ���ˢ��
function RealReadCard(hPort: THandle; clock_id: Integer; Card: PRealCardInfo): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ����Ҫ����
// clock_id     : ����, ����ֵ:0-255
// Card         : TRealCardInfo ָ�룬�洢���ؽ��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

type
  //ER-690C/DʵʱͨѶ���ؽṹ
  PRealRecordInfo = ^TRealRecordInfo;
  TRealRecordInfo = packed record
    Size: Integer;                                // �˽ṹ��С(����Size), ����ǰ��Ҫ����, �Է�ֹ����Խ��
    CardNo: array[0..17] of char;                 // �洢�����16λ
    timeString: array[0..15] of char;             // ˢ��ʱ��14���ַ�
    IsIDCard: Boolean;                            // ���ʱID��Ϊtrue������Ϊfalse��IC��
    NoCard: Boolean;                              // ���Ϊtrue����û�п�Ƭ�ڸ�Ӧ�����˽ṹ����������Ч
    Reader: Integer;                              // ��Χ��1-4ָ���Ŷ�ͷ
    Flag: Integer;                                // �򿨽��
    Mark: Integer;                                // �򿨱�־
    times: Integer;                               // ��ֵ����
    balance: Integer;                             // ���Ѻ����,��λ��
    consume: Integer;                             // ���Ѷ�,��λ��
    sign_time: TDateTime;                         // Double��ʽʱ��

    //ER-690D������
    //ER690DExt: TTRealRecord690DExt;//����ER-690D�����������������ṹ,����ǰ��������Size=SizeOf(TRealRecordInfo)
    OverPwd: array[0..9] of char;                 // ������������
    reserved1: DWORD;                             // ����
    reserved2: DWORD;                             // ����
                                                  //ER-6902.0��չ��Ա
    Clock_ver: Integer;                           //���Ѽ�¼�汾��
    Clock_ID: Integer;                            //����
    POS_Sequ: Integer;                            //POS������ˮ��
    Card_Sequ: Integer;                           //��������ˮ��
    Order_ID: Integer;                            //������˳���
    Op_CardNo: array[0..19] of Char;              //������Ա����
    Date_ver: array[0..10] of Char;               //ʱ��汾��
    reserved3: array[0..100] of Char;             // ����
    reserved4: array[0..512] of Char;             // ����

    //2.0/3.0��չ
	  POSID         : array[0..11] of char;         //�ն˻���
	  CompanyID     : array[0..11] of Char;         //��ҵID
    CommonEmpID   : array[0..39] of Char;         //ͳһ����Ա��ID
    CompanyEmpID  : array[0..7] of Char;          //��ҵԱ��ID
    CardAppSequ   :	array[0..15] of Char;         //Ӧ�����к�
	  BusiType			: Integer;        			        //�������ͣ�0x02��Ȧ�棻0x06���ѻ����ѣ�0x21���������ѣ�0x22���ѻ����ѳ�����0x23���������ѳ�����0x24���˷ѣ�
    BusiStyle     : Integer;                      //Ǯ�����ͣ�1�ֽڣ���0x01��������0x02���������  0x11�����޴Σ�0x12�����޴Σ�
    TACCheck			: array[0..7] of Char; 	        //TACУ��
    AppIndex      : Integer;                      //��Ӧ��������
    WalletBalType : Integer;                      //������ͣ�0x00��������0x01�����ˣ�
    OperatorID    : Integer;                      //����Ա���루2�ֽڣ�BCD��01-98�൱��0x0001-0x0098��
    AllowanceType : Integer;                      //�ƶ�����ʽ��������ʽ��1�ֽڣ�0x00����, 0x01�ۼӣ���Ǯ���������Ϊ��ҵ����ʱ��Ч����ЧʱΪ0xFF��
                                                  //���ſ���ʽ����¼���Ͷ��� 0x00��ʾ���� 0x01��ʾ��׼����ģʽ 0x02��ʾ�������ģʽ 0x03��ʾ�Զ�����ģʽ
    AllowanceVersion : Integer;                   //���ſ���ʽ���Զ��������Σ����Զ�������ʱΪ0����˸�ʽ�����ֽ���ǰ[61]�����ֽ��ں�[62]��
    AppType       : Integer;                      //���ſ���ʽ��Ӧ�����ͱ�ʶ��1 �ֽڣ�0x01��ȫ��Ǯ����0x04��ʡǮ����0x08����ҵǮ����
    CardFormatType: Integer;                      //��¼�汾	���ſ���ʽ��0x01	�ƶ�����ʽ��0x02
    AppCardSN     :	array[0..11] of Char;         //���ſ���ʽ��SAM��Ӧ�����к�
    CardType      : Integer;                      //���ſ���ʽ�����ֱ�ʶ
    CityCode			:	array[0..3] of Char;          //���ſ���ʽ�����д���   
  end;
  
//��־λ����ֵ˵��
//a)	16�޸�PIN
//b)	17���߹�ʧ
//c)	18���߽��
//d)	19���߲���


//      ʵʱ����¼(��ˢ��ʱ��3G^)
function RealReadRecord(hPort: THandle; clock_id: Integer; ARecord: PRealRecordInfo): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ����Ҫ����
// clock_id     : ����, ����ֵ:0-255
// Card         : TRealRecordInfo ָ�룬�洢���ؽ��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��
// ˵��: ���������690D:
//    consume=0       //����״̬ˢ��,��Ҫ���ϻش��˿������
//    consume<>0      //�ն˻�����Ŀ۳����, ����ǳ�ֵ��(����=0), ��Ϊ��ֵ���
//                    //�轫�˿�ԭ���۳���ش�

function RealReadRecordBack(hPort: THandle; clock_id: Integer): Boolean; stdcall; external EASTRIVER_API
//690Cʵʱ����¼��ȷ�ϻش�

//      ʵʱ���ѻش�����(3G^ 690D)
function RealFeedback(hPort: THandle; clock_id: Integer; Money: Integer; ErrCode, Reserved: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ����Ҫ����
// clock_id     : ����, ����ֵ:0-255
// Money        : ���ݿ����, ��λ��
// ErrCode      : �������, ����:
//    ErrCode = -1   // û�д���
//    ErrCode = 0    // �˿���������
//    ErrCode = 1    // �˿��Ǻ�������
//    ErrCode = 2    // ����������
//    ErrCode = 3    // �˿��ǷǱ�ϵͳע�Ῠ
//    ErrCode = 4    // ��������
//    ErrCode = 5    // �������
//    ErrCode = 6-8  // ����
//    ErrCode = 9    // ��ע��ɹ�
// Reserved     : ����, ��Ϊ��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ���Ž�������״̬(^3G, 980)
function ReadDoorStateDE(hPort: THandle; clock_id: Integer; DoorState: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ����Ҫ����
// clock_id     : ����, ����ֵ:0-255
// DoorState    : ����5���ֽڵĻ�������ǰ�ĸ��ֽڱ�ʾ�İ�����״̬����
//      ���ĳ���ֽ�Ϊ'1'��ʾĳ����Ϊ����Ϊ'0'��ʾĳ����Ϊ�պϡ�
//����ֵ:
// True         : �ɹ�
// False        : ʧ��


//      ʵʱ�����Ž�����������(^3G, 980)
function SetDoorOpenDE(hPort: THandle; clock_id: Integer; DoorState: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ����Ҫ����
// clock_id     : ����, ����ֵ:0-255
// DoorState    : ͬ��ReadDoorState;
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

{ʵʱ������}















{�Ž���������}

//		  �����Ž�������ʱ��
function SetLockOpenTimeLen(hPort: THandle; timeLen: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// timeLen      : �µĿ���ʱ��, 1-99 ��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//	  	���Ž�������ʱ��
function ReadLockOpenTimeLen(hPort: THandle; var timeLen: Integer): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// timeLen      : ���ؿ���ʱ��, 1-99 ��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  ���Ž�������״̬
function ReadDoorOpenState(hPort: THandle; var state: Integer): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
//		state  :  ����״̬, state=0 ��ʾΪ����״̬
//							state=1 ��ʾΪ����״̬
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  �����Ž������ų�ʱ����
function SetDoorOpenTimeoutAlarmState(hPort: THandle; state: Integer): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// state        : �µĳ�ʱ����ֵ
//		state=0   : ������ų�ʱ����
//		state=1   : ���ÿ��ų�ʱ����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  Զ�̿����Ž�������(2G)
function ControlOpenDoor(hPort: THandle): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// state        : �µĳ�ʱ����ֵ
//		state=0   : ������ų�ʱ����
//		state=1   : ���ÿ��ų�ʱ����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��


{�Ž���������}












{IC�����ƺ�����}

//		  �޸�IC��������
function SetSecurityCode(hPort: THandle; oldSecurity: PChar; newSecurity: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// oldSecurity  : 12λ16���ƻ��߾�����, ���޾�����, ����Ϊ'FFFFFFFFFFFF'
// newSecurity  : 12λ16���ƻ���������, ������Ϊɾ��������, ����Ϊ'FFFFFFFFFFFF'
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      �����ߵ�ǰ�ͻ�����(IC���Ŵ洢����)
function ReadClientCode(hPort: THandle; var ClientCode: Integer): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// ClientCode   : ���ص�ǰ���߿ͻ�����, IC����Ϣ�洢���
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      �޸Ļ��ߵ�ǰ�ͻ�����
function SetClientCode(hPort: THandle; ClientCode: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// ClientCode   : �µĻ��߿ͻ�����, IC����Ϣ�洢���
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��IC����Ϣ
function ReadICCard(hPort: THandle; CardNo, CardName: PChar; var Money, Times, Ver: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// CardNo       : ���ؿ���,16λ,
// CardName     : ��������,���Ȳ�С��16λ
// Money        : ���ؿ��Ͻ��
// Times        : ���س�ֵ����
// Ver          : IC����ʽ, ����ֵ����:
//      CARDSTYLE_UNKNOWN = 0000; //δ֪���Ÿ�ʽ(����Ϊ��)
//      CARDSTYLE_IDCARD  = 0001; //ID����ʽ
//      CARDSTYLE_STDCARD = 0830; //��ʱ����׼IC����ʽ
//      CARDSTYLE_NEWCARD = 0880; //��ER-880C����ʽ
//      CARDSTYLE_690CARD = 0690; //�����ѻ�ER-690C����ʽ
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��IC����Ϣ
function ReadAllICCard(hPort: THandle; CardNo, CardName: PChar; var Money, Times, GroupStation, GroupId, Ver: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// ͬ��
// GroupStation : �����ֽ�λ��, ��Χ: 0-15, �������Ҫд�����ʶ, ����Ϊ-1
// GroupId      : ���ط����ʶ, ��Χ:0-256
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      дIC����Ϣ
function WriteICCard(hPort: THandle; CardNo, CardName: PChar; Money: Integer; Times: Integer; Ver: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// ͬ��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      дIC����Ϣ�����������ʶ
function WriteAllICCard(hPort: THandle; CardNo, CardName: PChar; Money, Times, GroupStation, GroupId, Ver: Integer; MatchCard: Boolean=False): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// ͬ��
// �������Ҫд�����ʶ, ����GroupStation=-1
// MatchCard    : �Ƿ�ֻ��дCardNo������Ӧ�Ŀ���, �������ѳ�ֵ
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��չ��IC����Ϣ�����������ʶ(ER-690��)
function ReadICCardEx(hPort: THandle; CardNo, CardName, pwd: PChar;var Money, Times,
                      day_consumed, day_times, c_month, c_day, c_flag, GroupStation, GroupId, CardStyle: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// ͬ��
//ER-690��ר�ò���
// pwd          : �߶�������֤����, �6λ'0'-'9'������
// day_consumed : ���������ۼӶ�
// day_times    : �������Ѵ�
// c_month      : �����·�
// c_day        : ��������
// c_flag       : ��־
//
// �������Ҫд�����ʶ, ����GroupStation=-1
// MatchCard    : �Ƿ�ֻ��дCardNo������Ӧ�Ŀ���, �������ѳ�ֵ
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��չдIC����Ϣ�����������ʶ(ER-690��)
function WriteICCardEx(hPort: THandle; CardNo, CardName, pwd: PChar; Money, Times,
                      day_consumed, day_times, c_month, c_day, c_flag, GroupStation, GroupId, CardStyle: Integer; MatchCard: Boolean=False): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// ͬ��
//ER-690��ר�ò���
// pwd          : �߶�������֤����, �6λ'0'-'9'������
// day_consumed : ���������ۼӶ�
// day_times    : �������Ѵ�
// c_month      : �����·�
// c_day        : ��������
// c_flag       : ��־
//
// �������Ҫд�����ʶ, ����GroupStation=-1
// MatchCard    : �Ƿ�ֻ��дCardNo������Ӧ�Ŀ���, �������ѳ�ֵ
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      дָ�����ŵĿ���Ϣ
function WriteMatchICCard(hPort: THandle; CardNo, CardName: PChar; Money: Integer; Times: Integer; Ver: Integer; blank: Boolean): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// ͬ��
//	blank: �Ƿ�����д�հ׿�(����ʱ)
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      дָ�����ŵĿ���Ϣ
function WriteMatchICCardEx(hPort: THandle; CardNo, CardName, Pwd: PChar; Money, Times,
                          day_consumed, day_times, c_month, c_day, c_flag, CardStyle: Integer; blank: Boolean): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// ͬ��
//	blank: �Ƿ�����д�հ׿�(����ʱ)
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      �����������(����ָ��Block�������������)
function ClearICCard(hPort: Thandle; block: Integer=-1): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// block        : ���������ER-880C, Block=-1 ʱ, Block=��ǰIC���洢��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  ��2����IC��������
function ReadCardMessage(hPort: THandle; cardMessage: PChar; block: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// cardMessage  : ��������16�ֽ�2��������
// block        : IC�����ݵĿ��ַ, 1.26֮ǰ�Ķ������汾����ʹ�� block=-1�Ĳ���
//����ֵ:
// True         : �ɹ�
// False        : ʧ��
function ReadCardMessageString(hPort: THandle; cardMessage: PChar; block: Integer): Boolean; stdcall; external EASTRIVER_API

//  		д2����IC��������
function WriteCardMessage(hPort: THandle; cardMessage: PChar; block: Integer): Boolean; stdcall; external EASTRIVER_API
//ͬ��
function WriteCardMessageString(hPort: THandle; cardMessage: PChar; block: Integer): Boolean; stdcall; external EASTRIVER_API
//      ��IC������
function ReadICCardPassWord(hPort: THandle; PassWord: PChar; block: integer=-1): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// PassWord     : Ϊ��ŷ��ص�����Ļ�����, ���벻С��50�ֽ�
// block        : ER-880C����������, 1G(ER-810/830C)��Ϊ-1
//                ���������ER-880C, Block=-1 ʱ, Block=��ǰIC������������
//����ֵ://����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      дIC������
function WriteICCardPassWord(hPort: THandle; PassWord: PChar; block: integer=-1): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// PassWord     : ΪҪ���õ���IC������, ����Ϊ 32 ���ֽ�
// block        : ER-880C����������, 1G(ER-810/830C)��Ϊ-1
//                ���������ER-880C, Block=-1 ʱ, Block=��ǰIC������������
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ��IC�����к�
function ReadICCardSerialNo(hPort: THandle;var SerialNo: Int64; LongSn: Boolean=True): Boolean; stdcall; overload; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// SerialNo     : �������к�, 64λ����, ���LongSn=False, ��SerialNo������ΪDWORD(32λ�޷�������)
// LongSn       : �Ƿ������س����к�, ���ΪFalse, �������г����к���ֻ���ص�32λ����(DWORD)
//����ֵ:
// True         : �ɹ�
// False        : ʧ��


//      ��IC�����к�(32λ�޷�������)
function ReadICCardSerialNo(hPort: THandle;var SerialNo: DWORD; LongSn: Boolean=False): Boolean; overload; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// ͬ��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��


{IC�����ƺ�����}











{����򿨿�����}

//		  ���÷������ֽ�λ��
function WriteGroupByteStation(hPort: THandle; groupByte: Integer): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// groupByte    : IC������ֽ�λ, ��Χ: 0-16
// 		0-15      : Ϊһ�Զ�������ֽ�λ��
//  	16        : ��ʾΪ����Զ������ķ���洢��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  ���������ֽ�λ��
function ReadGroupByteStation(hPort: THandle; var groupByte: Integer): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// groupByte    : IC������ֽ�λ, ��Χ: 0-15
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  ���÷������ֽڱ�־��Ԫ��
function WriteGroupByteChecks(hPort: THandle; groupChecks: pchar): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// groupChecks  : ��������嵥, ʮ������ֵ, ����ʹ��','��'-'����.
// 		  ���� : 0,5-8,100, 140-141,255
// 		  ��ʾ���Լ������־Ϊ0,5,6,7,8,100,140,141,255�Ŀ���
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  ���������ֽڱ�־��Ԫ��
function ReadGroupByteChecks(hPort: THandle; groupChecks: pchar; buffsize: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// groupChecks  : ��������嵥, ʮ������ֵ, ����ʹ��','��'-'����.
// 	    ���� : 0,5-8,100, 140-141,255
//      ��ʾ���Լ������־Ϊ0,5,6,7,8,100,140,141,255�Ŀ���
// buffsize     : ��������С, һ�㾡����ô�Щ, >1000
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      ������Զ�����鵥Ԫ��
function ReadCardManyGroupChecks(hPort: THandle; GroupChecks: pchar; buffersize: Integer; block: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// groupChecks  : ��������嵥, ʮ������ֵ, ����ʹ��','��'-'����.
// 	    ���� : 0,5-8,100, 140-141,255
//      ��ʾ���Լ������־Ϊ0,5,6,7,8,100,140,141,255�Ŀ���
// buffsize     : ��������С, һ�㾡����ô�Щ, >1000
// block        : ��Ŷ�Զ������Ϣ�Ŀ��, һ����ÿ�����ĵ�0��
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      д����Զ�����鵥Ԫ��
function WriteCardManyGroupChecks(hPort: THandle; GroupChecks: pchar; block: Integer): Boolean; stdcall; external EASTRIVER_API
//ͬ��
{����򿨿�����}

{690C2.0}
//д690C2.0�濨��ʽ��Ϣ������
function WriteNewICCard(hPort: THandle; ClientCode: Integer; InfoCode: Integer; CardNo: PChar; CardName: PChar; OverPwd: PChar; CardMoney: Integer; CardKind: Integer; BeginDate: PChar; EndDate: PChar; Group: PChar; DayMoney: Integer; DayTimes: Integer; TimeMoney: Integer; CardSequ: Integer; LastDate: PChar; DayTotalTimes: Integer; DayTotalMoney: Integer; CurrOrder: Integer; CurrTimes: Integer; TotalMoney: Integer; AllowanceVer: PChar; Reserve: Integer): Integer; stdcall;external EASTRIVER_API
//����˵��:
//hPort�������Ķ˿ھ��
//ClientCode��Ŀ¼����
//InfoCode����Ϣ����
//CardNo������
//CardName������
//OverPwd��������������
//CardMoney�����Ͻ��
//CardKind��������
//BeginDate������������
//EndDate������������
//Group������
//DayMoney��ÿ�����ѽ������
//DayTimes��ÿ�����Ѵ�������
//TimeMoney��ÿ�����ѽ������
//CardSequ����������ˮ�ţ���һ�δ�0��ʼ����0��65535��ѭ��
//LastDate:��������ڣ���ʽyymmddhhnn
//DayTotalTimes:һ�������ܴ���
//DayTotalMoney:һ�������ܽ��
//CurrOrder:��ǰ����ʱ�����
//CurrTimes:��ǰ����ʱ�����Ѵ���
//TotalMoney:�ۼ����ѽ��
//AllowanceVer:�����汾��
//Reserve:����
//����ֵ
//0���ɹ�
//1����������
//2��д������
//3: �������
//4������У�����
//5������ת������
//6������Ĳ�������
//7: �հ׿�
//8: ����690C2.0����ʽ

//��������ʱ���صĴ�����Ϣ



//��690C2.0�濨��ʽ��Ϣ
function ReadNewICCard(hPort: THandle; ClientCode: Integer; var InfoCode: Integer; CardNo: PChar; CardName: PChar; OverPwd: PChar; var CardMoney: Integer; var CardKind: Integer; BeginDate: PChar; EndDate: PChar; Group: PChar; var DayMoney: Integer; var DayTimes: Integer; var TimeMoney: Integer; var CardSequ: Integer; LastDate: PChar; var DayTotalTimes: Integer; var DayTotalMoney: Integer; var CurrOrder: Integer; var CurrTimes: Integer; var TotalMoney: Integer; AllowanceVer: PChar; var Reserve: Integer): Integer; stdcall;external EASTRIVER_API
//����˵��ͬ��

//��ȡ690C2.0����
function GetParam690C2(hPort: THandle; var Value: Integer; Func: Integer): Boolean; stdcall;external EASTRIVER_API
//����˵��
//    Func=1ÿ����������޶�,
//        =2��ǰ������ѽ�
//        =3���������
//        =4����Ȩ��
//        =5��������Ǯ����(������)0--4
//        =6Ѻ����С�������
//        =7ÿ��������Ѵ�������
//        =8.ͬһ�ſ��ظ�ˢ�����ʱ��1-99����
//        =9.���⿨���ˢ��ʱ��0-2.25�룬ÿ0.25��һ����λ��1-9
//        =10.�ɹ�������ɺ���Ļ��ʾ��Ϣ��ͣ��ʱ��,0-99��
//        =11ÿʱ�����Ѵ������ƣ��ܹ�4��ʱ��
//        =12ÿ�����Ѱ����������

//����690C2.0����
function SetParam690C2(hPort: THandle; Value: Integer; Func: Integer): Boolean; stdcall;external EASTRIVER_API


//      �ֶζ�ֵ����:��
//060000000001112000000002183000000003231000000004
//0600 00000001,1120 00000002,1830 00000003,2310 00000004
function ReadFixMoneyOfZone(hPort: THandle; Data: PChar): Boolean;stdcall;external EASTRIVER_API
function SetFixMoneyOfZone(hPort: THandle; Data: PChar): Boolean;stdcall;external EASTRIVER_API

{690C2.0}

{690CT}

function PosRateTime(hPort: THandle; var Value: Integer; Func, Flag: Integer): Integer; stdcall; external EASTRIVER_API
//���ܣ����úͶ�ȡ��ʱPos���ķ��ʺ�ʱ���
//������Value:Ҫ���û��ȡ�ı���
//      Func:���ܷ���
//           =1�������Ƶ�ʱ��            =2/������ʱ��(����)
//           =3����ʱ��Σ����ӣ�        =4����ʱ����շ��ʣ����ʣ��ǣ�
//           =5��ʱʱ��Σ����ӣ�        =6��ʱʱ����շѣ����ʣ��ǣ�
//           =7������ʱ���������ӣ�  =8�����������ʱ�䣨���ӣ�
//      Flag:��ȡ������
//           =1����   =2��ȡ
//���� =0�ɹ� =1�������� =2��д�˿ڴ��� =3����ת������

{690CT}

{690C2.0�ۺ�ҵ���}
function RealReadState(hPort: THandle; clock_id: Integer; var State, RecCount: Integer; CardNo, PINCode: PChar): Boolean; stdcall; external EASTRIVER_API
//����˵��
//      State:״̬=0���� =1�ȴ� =2æ =3�޸�PIN�� =4��ʧ =5���  =6����
//      RecCount:�Ѵ��ڵļ�¼��
//      CardNo:���صĿ���
//      PINCode:���صĳ�����֤����

function RealAddMoney(hPort: THandle; clock_id: Integer; Money: Integer; pDate: PChar; Flag: Integer; PurseNo: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��
//     Money:��������ȷ���֣����ܳ���16777215
//     pDate:�����汾����ʽYYMMDDHH
//     Flag:�Ƿ���Ч��=0��Ч  =1��Ч
//     PurseNo:����Ǯ����0-4

function RealAnswerLossInfo(hPort: THandle; clock_id: Integer; Flag: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:���߹�ʧ�ش�
//      Flag:=0��ʧ�ɹ� =1��ʧʧ��

function ReadAllStringRecord(hPort: THandle; Start: Integer; Count: Integer; Data: PChar): Integer; stdcall; external EASTRIVER_API
//�����м�¼��˳��ţ���������¼��Ϣ
//����˵��:
//  hPort �������
//  Start:��ʼ��¼�㣬��0��ʼ
//  Count����ȡ����
//  Data����¼�ַ�������
//����ֵ:
//  =0�ɹ�  =3��ʱ����  =5����У�����  =6����������� =8�쳣

function RealReadStrRecord(hPort: THandle; clock_id:Integer;ARecord: PChar): Boolean; stdcall; external EASTRIVER_API
function RealReadStringRecord(hPort: THandle; clock_id:Integer;Data: PChar): Boolean; stdcall; external EASTRIVER_API
//��ʵʱ��¼��Ϣ
//����˵��:
//  hPort �������
//  clock_id:����
//  Data����¼�ַ�������
//����ֵ:
//  True         : �ɹ�
//  False        : ʧ��

{690C2.0�ۺ�ҵ���}

//����麣���ⵥ    -------------------------start:yth2005.8.29
//1-----------------------------------------------------------------
//      �����ߵ�ǰ���ѡ��
function ReadSystemCheck(hPort: THandle; var SystemCheck: Integer): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// SystemCheck   :
//    b_isTimeZoneEN   bit SystemCheck.7    ;ʱ����ж�          1-��⣬0-�����
//    b_isRepeatCardEN bit SystemCheck.6	  ;�ظ�ˢ���ж�        1-��⣬0-�����
//    b_isSysCardEN    bit SystemCheck.5    ;ϵͳ���ж�          1-��⣬0-�����
//    b_isEnterKeyEN   bit SystemCheck.4	  ;�Ƿ���Ҫ��ȷ�ϼ���  1-��⣬0-����� ���Ͳ͡�������Ч��
//    b_isFreeCardEN   bit SystemCheck.3    ;����ˢ��ʱ���ж�    1-��⣬0-����� (ֻ�ԾͲ͡�������Ч������ģʽ�����)
//    b_isLightLCDEN   bit SystemCheck.2    ;������              1-��⣬0-�����
//    b_isWhiteListEN  bit SystemCheck.1    ;��������          1-��⣬0-�����
//    ; bit SystemCheck.0


//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      �޸Ļ��ߵ�ǰ���ѡ��
function SetSystemCheck(hPort: THandle; SystemCheck: Integer): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// SystemCheck   :
//    b_isTimeZoneEN   bit SystemCheck.7    ;ʱ����ж�          1-��⣬0-�����
//    b_isRepeatCardEN bit SystemCheck.6	  ;�ظ�ˢ���ж�        1-��⣬0-�����
//    b_isSysCardEN    bit SystemCheck.5    ;ϵͳ���ж�          1-��⣬0-�����
//    b_isEnterKeyEN   bit SystemCheck.4	  ;�Ƿ���Ҫ��ȷ�ϼ���  1-��⣬0-����� ���Ͳ͡�������Ч��
//    b_isFreeCardEN   bit SystemCheck.3    ;����ˢ��ʱ���ж�    1-��⣬0-����� (ֻ�ԾͲ͡�������Ч������ģʽ�����)
//    b_isLightLCDEN   bit SystemCheck.2    ;������              1-��⣬0-�����
//    b_isWhiteListEN  bit SystemCheck.1    ;��������          1-��⣬0-�����
//    ; bit SystemCheck.0
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//2-----------------------------------------------------------------
//      �����ߵ�ǰ����ģʽ����
function ReadSystemMode(hPort: THandle; var SystemMode: Integer): Boolean;stdcall;  external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// SystemMode   : 1.����ģʽ,2.�����Ǽ�ģʽ,3.�˳��Ǽ�ģʽ,4.���Ǽ�ģʽ,5.�Ͳ�ģʽ
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      �޸Ļ��ߵ�ǰ����ģʽ����
function SetSystemMode(hPort: THandle; SystemMode: Integer): Boolean; stdcall;  external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// SystemMode   :1.����ģʽ,2.�����Ǽ�ģʽ,3.�˳��Ǽ�ģʽ,4.���Ǽ�ģʽ,5.�Ͳ�ģʽ
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//3-----------------------------------------------------------------
//      ��ȡ����ϵͳ����Χ
function ReadSystemCardRange(hPort: THandle; strStartCard: PChar;strEndCard:PChar): Boolean;stdcall;  external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// TimeString   : ���ػ��߿�ʶ���ϵͳ����Χ0000000000-9999999999
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//      �޸Ļ���ϵͳ����Χ
function SetSystemCardRange(hPort: THandle; strStartCard,strEndCard:PChar): Boolean; stdcall;  external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// SetTime      : �µĿ�ʶ���ϵͳ����Χ, 0000000000-9999999999
//����ֵ:
// True         : �ɹ�
// False        : ʧ��


//����麣���ⵥ--------------------------------end:yth2005.8.29



{�洢��������}
//      ���Ź�����
function WatchDogTest(hPort: THandle): Boolean; stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
//����ֵ:
// True         : �ɹ�
// False        : ʧ��

//		  �� RAM 16�ֽ���ֵ
function ReadRAMData(hPort: THandle; address: Integer; ValueData: Pointer): Boolean; stdcall; external EASTRIVER_API
//		address   : RAM ��ַ, 0x00-0xFF
//		valueData : ���ص����ݻ�����, ��СΪ16�ֽ�

//		  �� RAM 1�ֽ���ֵ
function WriteRAMByte(hPort: THandle; address: Integer; Value: Byte): Boolean; stdcall; external EASTRIVER_API
//		address   : RAM ��ַ, 0x00-0xFF
//		valueData : 1�ֽ�����, ��СΪ16�ֽ�

//		  �� EEPROM 16�ֽ���ֵ
function ReadEEPROMData(hPort: THandle; address: Integer; ValueData: Pointer): Boolean; stdcall; external EASTRIVER_API
//		address   : EEPROM ��ַ, ֻ����ʹ��0x100--0x0FFF�ĵ�Ԫ��ַ
//		valueData : ���ص����ݻ�����, ��СΪ16�ֽ�

//		  д EEPROM 1�ֽ���ֵ
function WriteEERPOMByte(hPort: THandle; address: Integer; Value: Byte): Boolean; stdcall; external EASTRIVER_API
//		address   : EEPROM ��ַ, ֻ����ʹ��0x100 -- 0x0FFF�ĵ�Ԫ��ַ
//		value     : 1�ֽ�����

//		  д EEPROM 16�ֽ���ֵ
function WriteEEPROMData(hPort: THandle; address: Integer; valueData: Pointer): Boolean; stdcall; external EASTRIVER_API
//		address   : EEPROM ��ַ, ֻ����ʹ��0x100 -- 0x0FFF�ĵ�Ԫ��ַ
//		valueData : 16�ֽ�����, ��СΪ16�ֽ�

//		  �����ݴ洢��һҳ(256�ֽ�)����
function ReadFlashPageData(hPort: THandle; flashPage: Integer; valueData: Pointer): Boolean; stdcall; external EASTRIVER_API
//		flashPage  : ���ݴ洢����ҳ��ַ, ��ΧΪ 0x0--0x7FF, �� 0x0--0xFFF
//		valueData  : ���ص����ݻ�����, ��СΪ256�ֽ�

//		  �����ݴ洢������
function ReadFlashData(hPort: THandle; address: Integer; valueData: Pointer): Boolean; stdcall; external EASTRIVER_API
//		address  : ���ݴ洢���ĵ�ַ, ��ΧΪ 0x0--0x7FF00, �� 0x0--0xFFF00
//		valueData  : ���ص����ݻ�����, ��СΪ16�ֽ�

//		  д��һҳ(256�ֽ�)���ݵ����ݴ洢��
function WriteFlashPageData(hPort: THandle; flashPage: Integer; valueData: Pointer): Boolean; stdcall; external EASTRIVER_API
//		flashPage  : ���ݴ洢����ҳ��ַ, ��ΧΪ 0x0--0x7FF, �� 0x0--0xFFF
//		valueData  : 256�ֽ�д������, ��СΪ256�ֽ�

{�洢��������}









{�ײ�˿ڲ�����}
//      �������ģʽ
function EnterTestMode(hPort: THandle; clock_id: Integer; HoldRate: Boolean): Boolean;stdcall; external EASTRIVER_API
//����˵��:
// hPort        : �˿ھ��, ��Ҫ����
// clock_id     : ����, ��Χ: 0x00-0xFF
// HoldRate     : �ָ�ͨѶ���ʵ�����ǰ��һ��, ����������ģʽ��ͨѶ���ʻ��Զ�����Ϊ38400bps,
//����ֵ
// True         : �ɹ�
// False        : ����
//˵��: ����ͨ������Ͳ���ģʽ�������������

//      �������ȡ�÷����ִ�
function WriteBack(hPort: THandle; Cmd, Buf: PChar):Boolean;stdcall; external EASTRIVER_API
//      �����������
function WriteText(hPort: THandle; Cmd: PChar; nNumberOfBytesToWrite: DWORD=0): Boolean; stdcall; external EASTRIVER_API
//      ��������ж��Ƿ�ɹ�
function ReadText(hPort: THandle; var Buff; BytesToRead: Cardinal; var BytesOfRead: Cardinal; Delay: Cardinal): Boolean; stdcall; external EASTRIVER_API

function WriteEcho(hPort: THandle; Cmd: PChar; nNumberOfBytesToWrite: DWORD=0): Boolean; stdcall; external EASTRIVER_API
function ReadEcho(hPort: THandle; Buff: PChar; Count: Integer; Delay: Cardinal): Boolean; stdcall; external EASTRIVER_API

function WaitOK(hPort: THandle; Cmd: PChar; Delay: Integer=1000):Boolean;stdcall; external EASTRIVER_API
//      ��ȡ�˿�

procedure SetPortPara(hPort: THandle; BaudRate: Integer; ByteSize, Parity, StopBits: Byte; Flag: DWORD=0);stdcall; external EASTRIVER_API

{�ײ�˿ڲ�����}
function GetAutoTranslateCardNo:Boolean;stdcall; external EASTRIVER_API
//      �����Ƿ��Զ�ת��IC����
procedure SetAutoTranslateCardNo(Value: Boolean);stdcall; external EASTRIVER_API
//      ȡ�õ�ǰͨ�Ž����ַ�
function GetEndChar: Char;stdcall; external EASTRIVER_API
//      ����ͨ�Ž����ַ�
procedure SetEndChar(Ch: Char);stdcall; external EASTRIVER_API

function GetPortTimeOut(Value: Integer): Boolean; stdcall; external EASTRIVER_API
function SetPortTimeOut(Value: Integer): Boolean; stdcall; external EASTRIVER_API
function SetPortRWCardTimeOut(hPort: THandle; Value: Integer): Boolean; stdcall; external EASTRIVER_API
function GetCmdVerify: Boolean;stdcall; external EASTRIVER_API//ȡ��ͨѶ�����Ƿ���ҪУ��
function SetCmdVerify(Value: Boolean): Boolean;stdcall; external EASTRIVER_API;//��������У��
function GetCardStyle: Integer;stdcall; external EASTRIVER_API//ȡ���ڲ�ͨѶ����ʽת������
function SetCardStyle(style: Integer): Boolean;stdcall; external EASTRIVER_API//�����ڲ�ͨѶ����ʽת������
function CheckCRC16(Data: PChar): Boolean; stdcall;external EASTRIVER_API
function VerifyHexData(Data: PChar): Boolean; stdcall;external EASTRIVER_API

//��ȡ��ǰϵͳ����ID��950=���� 936=����
function GetSystemLangID: Integer; stdcall;external EASTRIVER_API
function GBTBIG5(const Value: PChar; outData: PChar): Boolean; stdcall;external EASTRIVER_API//��->��ת��
function BIG5TGB(const Value: PChar; outData: PChar): Boolean; stdcall;external EASTRIVER_API//��->��ת��

//TCP/IPͨѶ
function SelectCommStyle(CommStyle: Integer): Boolean; stdcall;external EASTRIVER_API
function OpenClientSocket(RemoteAddr: PChar; Port: Integer):THandle; stdcall;external EASTRIVER_API
function CloseClientSocket(hSocket: THandle): Boolean; stdcall;external EASTRIVER_API
function ClearSocketBuff(hPort: THandle; Delay: Cardinal): Boolean; stdcall; external EASTRIVER_API

type
  TDevRegInfo = packed record
    DeviceID:DWORD;

    DevPath:array[0..127] of char; //usb�豸��ַ
    DevPathlen:integer;
    DeviceDescr :array[0..127] of char;//usb �豸���������豸��������֣�
    deviceDescrlen:integer;
    DeviceTypeDescr :array[0..127] of char;//usb �豸��������
    deviceTypeDescrlen:integer;
  end;
  TDevRegInfoList = record
    DeviceCount:integer; //�ҵ���USB�豸��
    DeviceInfoList: array[0..31] of TDevRegInfo; //usb�豸�б����豸����ʹ��
  end;

//USBͨѶ
{����USB�豸��DevPath ��USB�豸·��}
function OpenUSBDevice(devPath:pchar):boolean;stdcall; external EASTRIVER_API;
{�ر��豸}
function CloseUSBDevice:boolean;stdcall; external EASTRIVER_API;
{��ȡ��ǰ�������Ѵ��ڵ�USB�豸��
 DisplayMouseAndKeyboard = false ����ȡ��׼�����̵���Ϣ
                         = true  ��ȡ��׼�����̵���Ϣ
 }
function GetUSBDevInfoList(DisplayMouseAndKeyBoard:boolean):TDevRegInfoList;stdcall; external EASTRIVER_API;

{  USBRtnMsg: array[0..20] of string =
    ('������ȷ',
    'ͨ����ͷ��',
    '������ȷ����ִ�г���',
    'ͨѶ�汾����',
    '�������',
    '���ݳ��ȳ���',
    '�̶�����XOR�ͳ���',
    '���ݶγ���',
    '�����쳣',
    '�����쳣',
    '�����쳣',
    '�����쳣',
    '�����쳣',
    '��д����Ŵ�',
    '��Ƭ���ڸ�Ӧ���� �����������!',
    '��д�������',
    '�������ʹ�',
    '������',
    'д����',
    'д�������',
    '����ʧ��!');
}
//�õ�USB�汾��
function USBGetVersion(Version: PChar): Integer; stdcall; external EASTRIVER_API;
//ѯ�����������к�
// CardType Ϊ�����ͣ� 0=IC���� 1=SIM��
function USBGetSerialNo(SerialNo: PChar; var CardType: Integer): Integer; stdcall; external EASTRIVER_API;
// ��ȡ�����˻���Ϣ��
// ���أ��û��������ţ��������
// CardType Ϊ�����ͣ� 0=IC���� 1=SIM��
function USBGetAccount(Sector: Integer; UserName: PChar; CardID: PChar;
  var Account: Double; var ChargeCnt:Integer; Password: PChar; CardType: Integer): Integer; stdcall; external EASTRIVER_API;
// д���˻���Ϣ��
// ���أ��û��������ţ��������
// CardType Ϊ�����ͣ� 0=IC���� 1=SIM��
function USBSetAccount(Sector: Integer; UserName: string; CardID: string;
  Account: Double; ChargeCnt:Integer; PassWord: string; CardType: Integer): Integer; stdcall; external EASTRIVER_API;
// ����˻���Ϣ��
// CardType Ϊ�����ͣ� 0=IC���� 1=SIM��
function USBClearAccount(Sector: Integer; CardType: Integer): Integer; stdcall; external EASTRIVER_API;
//�޸���������
function USBSetCardPWD(Sector: Integer; NewPassward: PChar; CardType: Integer): Integer; stdcall;  external EASTRIVER_API;
//�޸Ļ�������
function USBSetDevicePWD(NewPWD: PChar): Integer; stdcall; external EASTRIVER_API;

//983����ͨѶ
function RegisiterCardList(hPort: THandle; Style: Integer; inData: PChar): Integer; stdcall;external EASTRIVER_API
//�Ž�����ͨ�п��������ڿ���Ȩ��ϵͳ�������Ǽ�
function DelRegisiterCardList(hPort: THandle; Style: Integer; inData: PChar): Integer; stdcall;external EASTRIVER_API
//ɾ��ע�Ῠ��Ϣ
function ReadRegisiterCardList(hPort: THandle; Style: Integer; inData: PChar; outData: PChar): Integer; stdcall;external EASTRIVER_API
//��ѯע�Ῠ
function SetTimerAndRight(hPort: THandle; Style: Integer; inData: PChar): Integer; stdcall;external EASTRIVER_API
//�Ž�����ͨ��ʱ��κ���Ӧ�Ĳ���Ȩ�ޡ�����ˢ��������
function ReadTimerAndRight(hPort: THandle; Style: Integer; inData: PChar; outData: PChar): Integer; stdcall;external EASTRIVER_API
//��ȡ�Ž�����ͨ��ʱ��κ���Ӧ�Ĳ���Ȩ�ޡ�����ˢ����������
function DelTimerAndRight(hPort: THandle; Style: Integer; inData: PChar): Integer; stdcall;external EASTRIVER_API
//ɾ���Ž�����ͨ��ʱ��κ���Ӧ�Ĳ���Ȩ�ޡ�����ˢ����������
function RealReadRecordEx(hPort: THandle; Style: Integer; Clock_id: Integer; OutData: PChar): Integer; stdcall;external EASTRIVER_API
//ʵʱ����¼
function RealReadClockState(hPort: THandle; clock_id: Integer; outData: PChar): Integer; stdcall;external EASTRIVER_API
//ʵʱ��ѯ����״̬
function RealSetClockState(hPort: THandle; clock_id: Integer; State: Integer; Lock: PChar): Integer; stdcall;external EASTRIVER_API
//ʵʱ�򿪻�˨ס��
function ClockConfig(hPort: THandle; Style: Integer; inData: PChar; outData: PChar): Boolean;  stdcall;external EASTRIVER_API
//��������
//����˵����
//Style=
//1:���û��ȡ���߲�Ʒ���к���Ϣ
//2:���û��ȡ����LCD���߿���������ʾ����ʾ��OEM����������Log��Ϣ������Ϣ��ʾ��Splash���ĵ�1�У���ʼ�У�
//3:�������������û��ȡ����LCD���߿���������ʾ����ʾ�Ļ��߲�Ʒ�ͺ���Ϣ������Ϣ��ʾ��Splash���ĵ�2�У���ʼ��Ϊ��1�У�
//4:���û��ȡ����LCD���߿���������ʾ����ʾ�Ĳ�Ʒ������Ϣ������Ϣ��ʾ��Splash���ĵ�3�У���ʼ��Ϊ��1�У�
//5:���û��ȡ����LCD���ߴ���״̬ʱ��ʾ���û�Log��û��֪ͨ��Ϣʱ������Ϣ��ʾ�ڴ�������ĵ�1�У���ʼ�У�
//6:���û��ȡ����LCD������������ˢ����Ϣ��ʾʱ��ʾ���û�Log������Ϣ��ʾ�ڴ�������ĵ�1�У���ʼ�У������ݿ���ˢ����ʾ��Ϣ���ݵĲ��죬���û�Log���ܲ�����ʾ
//7:���û��ȡ����LCD�����Ž�����ˢ��ʱ��ʾ���û�Log
//8:(�ݲ�֧��,Ԥ��)���û��߹���Ա�Ŀ��š�����ʱ���������֤�����в�ȿ������롣Ϊ�����ϵͳ�İ�ȫ�ԣ���������Ա���޷�ֱ�ӿ��ŵģ�����Ա��ѡ��ִ�п��Ź���ʱ����������������֤��ݡ���⵽��в�����룬����Ϊ����Ա��в�ȿ��ţ�����ͨ�������֤ʱ����¼����������
//9:���û���ϵͳ��������Ա�Ŀ��ź������֤���롣ʹ�ò�������Ա����ϵͳ���ܲ˵��������ñȹ���Ա����Ļ��߹������Բ����������㲻ͬ�ͻ���ʹ����Ҫ��ͬʱ�򻯿ͻ���ʹ�ò�������������Աˢ���󣬻�Ҫ����������֤��ݲ��ܽ���������ò˵����������߳���ʱ��Ĭ�ϲ�������Ա����Ϊ0008776225����������Ա�����֤����Ϊ��
//10:(�ݲ�֧��,Ԥ��)//�޸Ļ��ߵ�ǰʹ�õ�IC������ʱ�����֤��Կ�����߳�ʼ����IC�����������֤��ԿΪFFFF FFFF FFFF�����Ը����û���ʵ��ʹ����Ҫ�����޸�
//11:���û��ȡ����ʹ�õ�Ĭ��IC�����ݴ������飯��֤��Կ���͡����߷������ֽ�λ��
//12:(�ݲ�֧��,Ԥ��)//���û��߷���ˢ�������Ϣ
//13:���û��ȡ����ʹ�õ���ʾ���ų��ȡ����ݴ����ų��ȡ�ˢ��������ظ�ˢ�������ˢ�����������
//   �û�ˢ���󣬻�ȡ�Ŀ�������ȫ�����棨���14λ�������Կ�Ƭ��Ϣ��δָ�����ų��ȵĿ��ɸ���ʹ�õ�ʵ����Ҫֻ��ʾ����λ���ţ���ʾ���ų��Ȳ��������ڿ��ƴ�ʱ��Ҫ��ʾ�Ŀ�����Ϣ��Χ����Ȩ���ȽϿ��ŷ�Χ��
//   ˢ�����������������һ�ſ�ˢ������һ�ſ��ܹ�ˢ��֮ǰ�ĵȴ�ʱ�䡣
//   �ظ�ˢ�������������һ�ſ�ˢ�����´θÿ��ܹ��ٴ�ˢ��֮ǰ�ĵȴ�ʱ�䡣
//Data��Ϊ��ʱ��ʾ��ȡ�������ֵ��ʾ����

//�������汾��Style=0������ =1������
function GetCardListVer(hPort: THandle; Style: Integer; Ver: PChar): Boolean; stdcall; external EASTRIVER_API
//���������汾��Style=0������ =1������
function SetCardListVer(hPort: THandle; Style: Integer; Ver: PChar): Boolean; stdcall; external EASTRIVER_API
//���ð�����
function SetAllowedCardX(hPort: THandle; card, empid, EmpName, Ver: PChar): Boolean; stdcall; external EASTRIVER_API
//���ú�����
function SetBlackCardX(hPort: THandle; card, Ver: PChar): Boolean; stdcall; external EASTRIVER_API

function CheckCardExists(hPort: THandle; Style: Integer; CardNo: PChar; Data: PChar): Boolean; stdcall; external EASTRIVER_API
//��������Ƿ����
//Style =0 �������� =1�������� =2 ����Ž�ͨ������
//CardNo Ҫ���Ŀ���
//Data �����������Ϊ�棬�԰��������Ž�ͨ�����������з��ؿ���һЩ�й���Ϣ������Ǻ�����û�з���
//�������ķ���ֵ��
//�Ž�ͨ�������ķ���ֵ��

/////////////�����ͻ�ר��//////////////////

//��ȡ����ʹ�ÿ�Ƭ���Ž�����ʽ
function ReadCardParseStyle(hPort: THandle; Style: PChar): Boolean; stdcall; external EASTRIVER_API
//����Style�Ŀ��Ž�����ʽ����,Ŀǰ����λ��ǰ��λ��ʾ������ȡ��Ƭ���ݽ�����ʽ������λ��ʾ��Ӷ�ͷ��ȡ��Ƭ���ݽ�����ʽ,������������:
//0x00		����δ��װ��ͷģ�顣
//0x01		��ȡ IC �����кŵ��� ID ��ʹ�á�
//0x02		��ȡ IC ����д������ݽ��н���ʹ�á�
//0x03		��ȡ IC �����кŽ�����Ȩ��⣬��������Ϊ���š�
//0x08		EM4001 ID ����ʮλ BCD ���š�
//0x09		EM4001 ID ������λ BCD ���š�
//0x0A		EM4001 ID ������λ BCD ���š�
//0x0B		EM4001 ID ������λʮ�����ƿ��š�
//0x0C		ABA ͨѶ��ʽ HID ������λ BCD ���š�
//0x0D		ABA ͨѶ��ʽ HID ����ʮλ BCD ���š�
//����		������

//���û���ʹ�ÿ�Ƭ���Ž�����ʽ
function SetCardParseStyle(hPort: THandle; Style: PChar): Boolean; stdcall; external EASTRIVER_API
//Style�Ŀ��Ž�����ʽ������

//��ȡOEM�����ͺ�
function ReadOEMMachineModel(hPort: THandle; Model: PChar): Boolean; stdcall; external EASTRIVER_API
//Model��ʾ���Ļ�Ӣ�Ļ��ͣ��ܹ�16��Ӣ�Ļ�8�����֣�ǰ������пո�

//����OEM�����ͺ�
function SetOEMMachineModel(hPort: THandle; Model: PChar): Boolean; stdcall; external EASTRIVER_API
//Model��ʾ���Ļ�Ӣ�Ļ��ͣ��ܹ�16��Ӣ�Ļ�8�����֣�ǰ������пո�

//IC�����������֤��Կ�޸�
function ModifyICAccessPassword(hPort: THandle; Style: Integer; OldPwd: PChar; NewPwd: PChar): Boolean; stdcall; external EASTRIVER_API
//����Styleȷ����Ϣ���ͣ���Ч�����������£�
//    =1����ʾ�޸���ͨ���ѻ�Ĭ�����ݴ���������������֤��Կ��
//    =2����ʾ�޸Ļ��֡�����һ���Ĭ�����ݴ���������������֤��Կ��
//    OldPwd����ԭ���룬 NewPwd: ����������

//��ȡĬ�Ϸ�����������
function ReadICSectorParameter(hPort: THandle; Style: Integer; Param: PChar): Boolean; stdcall; external EASTRIVER_API
//����Styleȷ����Ϣ���ͣ���Ч�����������£�
//    =1����ʾ��ȡ��������ͨ���ѻ�Ĭ�����ݴ������������
//    =2����ʾ��ȡ�����û��֡�����һ���Ĭ�����ݴ������������
//����Paramȷ��������Ϣ������5λ����ʽ����Կ��֤��ʽ(1λ)+���ݴ�����(2λ)+������Ϣ(2λ),��Ч�����������£�
//    ��Կ��֤��ʽ  =0��ʹ��A��Կ���������֤��=1��ʹ��B��Կ���������֤
//    ���ݴ����� =����*4+2
//    ������Ϣ =0x10��ʾʹ�ö�Զ���飬������Ϣ�����ڱ������ĵ�0�飻
//              0x06��ʾʹ��һ�Զ���飬������Ϣ�����ڱ������ȡ���ݵĵ�6�ֽڣ���ʼ�ֽ�Ϊ��0�ֽڣ�λ�ã�
//              0x00��ʾ�����÷��飬
//              ����ֵ��������ʹ��
//

function SetICSectorParameter(hPort: THandle; Style: Integer; Param: PChar): Boolean; stdcall; external EASTRIVER_API
//������Ϣͬ��

function ReadICCardStyle(hPort: THandle; Sector: Integer): Integer; stdcall; external EASTRIVER_API

//������Ϣ
function ReadICCardInfo(hPort: THandle; CardStyle: Integer; Info: PChar; Sector: Integer): Boolean; stdcall; external EASTRIVER_API
  //�����ͻ�Style=0 ����,����,�����,����,����,����,����ʱ��,������ˮ��,���ѽ��
  //690��   Style=1 ����,����,�����,����,����,�ۼ����Ѷ�,�ۼ����Ѵ�,��ǰ������,��ǰ������
  //680     Style=2 ����,����,�����,����
  //880     Style=3 ����,����
  //690��   Style=4 ����,����,�����,����,����,�ۼ����Ѷ�,�ۼ����Ѵ�,��ǰ������,��ǰ������

  //----------------------�����ͻ�------------------------------------//
//���� CardStyle =0
//���� Info��ʽ���£�
//  ����,����,����,����,����,����ʱ��,������ˮ��,�����,���ѽ��
//��ʽ˵��(ÿ�����ݼ��ö��Ÿ���)��
//  �������Ϊ4,294,967,295
//  �������10��Ӣ����ĸ��5����������
//  ����01��ʾ���ѻ���  02��ʾ���ֿ�
//  ���� 0-255
//  ����
//  ����ʱ�� yymmddhhnn ��10�����ݣ�����������
//  ������ˮ��0-65535
//  �������ѽ�� 0-167,772.15Ԫ
//-------------------------------------------------------------//

//----------------------690IC����ʽ1.5�棬��ȷ����-------------//
//���� CardStyle =1
//���� Info��ʽ���£�
//  ����,����,�����,����,����,�ۼ����Ѷ�,�ۼ����Ѵ�,��ǰ������,��ǰ������
//��ʽ˵��(ÿ�����ݼ��ö��Ÿ���)��
//  ���ţ����Ϊ1048575
//  ���������8��Ӣ����ĸ��4����������
//  ����0-16777215 ������Ϊ��
//  ���룺6λ����
//  ���Σ�0-65535
//  �ۼ����Ѷ0-16777215 ����Ϊ��
//  �ۼ����ѴΣ�0-255
//  ��ǰ�����£�1-12
//  ��ǰ�����գ�1-31
//-------------------------------------------------------------//

//д����Ϣ
function WriteICCardInfo(hPort: THandle; CardStyle: Integer; Info: PChar; Sector: Integer): Boolean; stdcall; external EASTRIVER_API
  //�����ͻ�Style=0 ����,����,�����,����,����,����,����ʱ��,������ˮ��,���ѽ��
  //690C��  Style=1 ����,����,�����,����,����,�ۼ����Ѷ�,�ۼ����Ѵ�,��ǰ������,��ǰ�Ͷ�,��ǰ������
  //680     Style=2 ����,����,�����,����
  //880     Style=3 ����
  //690��   Style=4 ����,����,�����,����,����,�ۼ����Ѷ�,�ۼ����Ѵ�,��ǰ������,��ǰ�Ͷ�,��ǰ������
  //3.0��   Style=5 ����,����,�����,����,����,�ۼ����Ѷ�,�ۼ����Ѵ�,��ǰ������,��ǰ�Ͷ�,��ǰ������,������ˮ,�����,����
  //                �����ʽ��1-16����������д���磺1�飬10����0110
  //                ���룺4λ����

/////////////�����ͻ�ר��//////////////////

function DataToRecord(Style: Integer; Data: PChar; Records: PChar): Boolean; stdcall; external EASTRIVER_API
//ת��ԭʼ���ݵ���¼
//Style:��ͬ�ļ�¼��ʽ��˵�����£�
//  1:880��889��890��980��981��985���� 2:690C���� 3:690D���� 4:692 5:983
//Data:ԭʼ����
//Records:ת��������ݣ���ͬ��ʽ���ݶ������£�
//  Style=1 :  ����,��־,��ʶ,ʱ��
//       =2 :  ����,���,���ѽ��,����,��־,ʱ��
//       =3 :  ����,���ѽ��,ʱ��
//       =4 :  ����,���,���ѽ��,��ˮ��,�ն˻���,��־,ʱ��
//       =5 :  ����,��־,��ʶ,״̬,ʱ��

function ReadCommDataString(hPort:THandle; Data: PChar): Integer; stdcall; external EASTRIVER_API
//ʵʱ������������
//Data���صĻ������ݣ�����������ص����Ѷ�ȡ�Ļ�������С

function RealBackData(hPort: Thandle; Style: Integer; Data: PChar): Boolean; stdcall; external EASTRIVER_API
//�˺����������£�
//����һ��
//     =4��ʾ���嵱ǰʵʱģʽ��Data���ص�ǰ����ʵʱģʽ��ģʽ����ֵ��������
//     =0��ѭӦ��ˢ����������ϴ�ʵʱģʽ
//     =1��ѯӦ��ˢ�����������ϴ�ʵʱģʽ
//     =2ˢ����������ϴ�ʵʱģʽ
//     =3ˢ�����������ϴ�ʵʱģʽ
//���ܶ���
//     ��DataΪ��ʱ��Style=0��3����ʾ�ֱ����û��ߵ�ʵʱģʽ��0��3����������
//��������
//     ��Data��Ϊ��ʱ��Style�������Data����������������
//     Style=0��ʾ���մ������¶���Data������
//          =1��ѭ��ʽ���¼����ˢ������ʱֻ�ش����ţ�����п��ţ���ѻ��š�����ͨ��Data���룬�м��ö��Ÿ���
//          =2�����ϴ�Ӧ��ֻȷ�Ͻ��, ͨ��Data������ż���
//          =3ˢ�����������ϴ����ȷ��ؿ��ţ�Ȼ������Ļ��Ҫ��ʾ����Ϣ�ֱ𴫣���ʽ������,����,��Ϣ

//����ʱ��κ���
function SetTimePeriod(hPort: THandle; Period: PChar): Boolean; stdcall; external EASTRIVER_API
//����Period��ʽ��
//  ʱ�θ���(1������)+hhnn(��ʼʱ��)+hhnn(����ʱ��)+ģʽ(1:��ͨ��2:��ֵ;3:�˵�,1������)+���(5�����֣���Զ�ֵ,������Ϊ5��0)+����1������+ѭ��ʱ��(�ӿ�ʼʱ�ε���������)

//��ȡʱ�����Ϣ
function ReadTimePeriod(hPort: THandle; Period: PChar): Boolean; stdcall; external EASTRIVER_API
//���ص�Period������ʽͬ��

//��ʱ����Զ��л�����
function SetTimePeriodEnable(hPort: THandle; Flag: PChar): Boolean; stdcall; external EASTRIVER_API
//����Flag��ʽ��=1����ʱ����Զ��л����ܣ�=0�ر�ʱ����Զ��л�����

//��ȡʱ����Զ��л�����
function ReadTimePeriodEnable(hPort: THandle; Flag: PChar): Boolean; stdcall; external EASTRIVER_API
//����Flag���صĸ�ʽ˵��ͬ��



function SetTimePeriodExt(hPort: THandle; Period:Pchar): Boolean; stdcall; external EASTRIVER_API
//�������ѿ�������Ϣ
//����Period��ʽ��
//  ���(0..F����0..7Ϊ�ǲ�����8..FΪ������16������)+�δ�(1�����֣�1..4����16������)+[���(5������ 10������)+ ���(5�����֣�10������)]+[������]..
//������ʽ��030001000100  0 ���3�δΣ�0001000100Ϊ�����1Ϊ 1Ԫ�����2Ϊ10Ԫ

function ReadTimePeriodExt(hPort: THandle;Period,ResultPeriod:Pchar): Boolean; stdcall; external EASTRIVER_API
//�����ѿ�������Ϣ
//����˵��
//����Period��ʽ �����(0..F����0..7Ϊ�ǲ�����8..FΪ������16������)
//����ֵ��True�ɹ���False ʧ��
//���� ResultPeriod��ʽ��
//  ���(0..F����0..7Ϊ�ǲ�����8..FΪ������16������)+�δ�(1�����֣�1..4����16������)+[���(5������ 10������)+ ���(5�����֣�10������)]+[������]..
//������ʽ��030001000100  0 ���3�δΣ�0001000100Ϊ�����1Ϊ 1Ԫ�����2Ϊ10Ԫ
function ClearTimePeriodExt(hPort: THandle; Period:Pchar): Boolean; stdcall;external EASTRIVER_API
//������ѿ�������Ϣ
//����˵��
//����Period��ʽ �����(0..F����0..7Ϊ�ǲ�����8..FΪ������16������)
//����ֵ��True�ɹ���False ʧ��


{******************************************************************************
 SIm������
 ******************************************************************************}
{******************************************************************************
��ѯMifare�ӿ��Ƿ���ڿ���
******************************************************************************}
function SimCallClock(hPort: THandle): Boolean; stdcall; external EASTRIVER_API;

{******************************************************************************
 ��ʽ�������
 ����˵��:
 hPort        : �˿ھ��,ͨ������OpenCommPort�����õ�
 clock_id     : ����,����ֵ: 0-255, ���ڻ�������ʾ�Ļ���ʵ��������λ16������
               ���Ի��ŷ�Χ16���Ʊ�ʾӦ��Ϊ: 0x00-0xFF
 ����ֵ:
 True         : �����ɹ�
 False        : ����ʧ��                                      
 ******************************************************************************}
function SimRequest(hPort: THandle; SerialNo: PChar=nil): Boolean; stdcall; external EASTRIVER_API;

{******************************************************************************
 SIM��֤��ֻ����֤����ܽ��ж�д��Ĳ���
 ������Sector=����
       PwdType=�������� 1=A���� 0=B����
       CheckType=��֤���� 0=�ڲ���֤ 6=ʹ��ָ�������ܳ���֤
       Pwd=��CheckTypeΪ6��ʹ��
 ******************************************************************************}
function SimAuthentication(hPort: THandle; Sector: Integer; PwdType: Integer;
  CheckType: Integer; Pwd:string=''): Boolean; stdcall; external EASTRIVER_API;

{******************************************************************************
 ��ȡ��֤���������Ŀ�����
 BlockID: ����֤��������ģ���
 Data��   16���ֽڵĿ����ݣ�ʮ������
 ******************************************************************************}
function SimGetBlockData(hPort: THandle; BlockID: Integer; Data: PChar): Boolean; stdcall; external EASTRIVER_API;

{******************************************************************************
 д������
 BlockID: ����֤��������ģ���
 Data��   16���ֽڵĿ����ݣ�ʮ������
 ******************************************************************************}
function SimSetBlockData(hPort: THandle; BlockID: Integer; Data: string): Boolean; stdcall; stdcall; external EASTRIVER_API;

{******************************************************************************
 ������ȡ�����˻���Ϣ��
 ���أ��û��������ţ��������
 ******************************************************************************}
function SimGetAccount(hPort: THandle; Sector: Integer;
  AuthPwd: string; UserName: PChar; CardID: PChar;
  var Account: Double; var ChargeCnt:Integer; Password: PChar): Boolean;
  stdcall; external EASTRIVER_API;

{******************************************************************************
 д���˻���Ϣ��
 ���أ��û��������ţ��������
 ******************************************************************************}
function SimSetAccount(hPort: THandle; Sector: Integer;
  AuthPwd: string; UserName: string; CardID: string;
  Account: Double; ChargeCnt:Integer; PassWord: string): Boolean; 
  stdcall; external EASTRIVER_API;
  
{******************************************************************************
 ���������Ϣ
 ******************************************************************************}
function SimClearAccount(hPort: THandle; Sector: Integer; AuthPwd: string): Boolean; stdcall; external EASTRIVER_API;

{******************************************************************************
 ����Ǯ ����������SIM���Ľ��׼�¼
 ******************************************************************************}
function SimIncrement(hPort: THandle; BlockID: Integer; IncMoney: Double): Boolean; stdcall; external EASTRIVER_API;
{******************************************************************************
 ����Ǯ  ����������SIM���Ľ��׼�¼
 ******************************************************************************}
function SimDecrement(hPort: THandle; BlockID: Integer; DecMoney: Double): Boolean; stdcall; external EASTRIVER_API;

{******************************************************************************
 ����
 ******************************************************************************}
function SimTransfer(hPort: THandle; BlockID: Integer): Boolean; stdcall; external EASTRIVER_API;

{******************************************************************************
 ����SIM����AB���� �� ������3 ,����AB��ͬ
 ******************************************************************************}
function SimSetCardAB(hPort: THandle; Sector: Integer;
  NewAuthPwd: string; OldAuthPwd: string='FFFFFFFFFFFF'): Boolean; stdcall; external EASTRIVER_API;

//����Ǯ
function USBSimIncrement(BlockID: Integer; IncMoney: Double): Integer; stdcall; external EASTRIVER_API
//����Ǯ
function USBSimDecrement(BlockID: Integer; DecMoney: Double): Integer; stdcall; external EASTRIVER_API
//��������
function USBGetBlockData(BlockID: Integer; Data: PChar; CardType: Integer): Integer; stdcall; external EASTRIVER_API;
//д������
function USBSetBlockData(BlockID: Integer; Data: PChar; CardType: Integer): Integer; stdcall; external EASTRIVER_API;
//USB�޸���������
function USBSetPWDSECTOR(Sector: Integer; Data: PChar; CardType: Integer): Integer; stdcall; external EASTRIVER_API;
//�޸��豸�������� CmdType=0 A���� =1 B����
function USBSetDevicePWDType(CmdType: Integer=0): Integer; stdcall; external EASTRIVER_API
//USB��IC��ȡ��
function USBUnChargeICCard(BlockNo: Integer; Amount: Double): Integer; stdcall; external EASTRIVER_API
//USB��IC����ֵ
function USBChargeICCard(BlockNo: Integer; Amount: Double): Integer; stdcall; external EASTRIVER_API

/////���豸�������� ���ݷ�
//function RealBatchData(PCLK: TClockInfo; var Records: array of TICRecord): integer; stdcall; external EASTRIVER_API;
function SelectClockID(ClockID: Integer): Boolean; stdcall; external EASTRIVER_API;

function SendComUsbCmd(hPort: THandle; Cmd: string; RcvBytes: PChar; CmdType: Word=$B8; Delay: Cardinal = 1000): Boolean; stdcall; external EASTRIVER_API;

//��Э��PSAM��͸����������
function SendUsbNewCmd(Cmd: Word; CmdData: string; RcvBytes: PChar; Delay: Cardinal = InitTimeOut): Boolean; stdcall; external EASTRIVER_API

function SimRequestSN(hPort: THandle; SerialNo: PChar=nil): Boolean; stdcall; external EASTRIVER_API;

//�򴮿ڷ���͸������
function SendComCmd(hPort: THandle; PData: Pchar; DataSize: Integer; RcvBytes: PChar; var BufSize: Integer; Delay: Cardinal= 1000): Boolean; stdcall; external EASTRIVER_API;

{*****************************************906�๦�ܷ������ӿں���*********************************************}
//���ӷ�����
function MFOpenReader(CommStyle, Port, BaudRate: Integer; Address: PChar; var hReader: Pointer): Boolean; stdcall; external OldEastRiver_API;

//�رշ�����
function MFCloseReader(hReader: Pointer): Boolean; stdcall; external OldEastRiver_API;

//����ͨѶ��Կ
function MFSetReaderKey(hReader: Pointer; NewKey: PChar; KeyLength: Integer): Boolean; stdcall; external OldEastRiver_API;

//��ȡ��ͷ�汾
function CMGetReaderVer(hReader: Pointer; Ver: PChar; var BufSize: Integer): Boolean; stdcall; external OldEastRiver_API;

//��ѯ��Ƭ����״̬
function CMGetSimCardConnectState(hReader: Pointer; var State: Byte): Boolean; stdcall; external OldEastRiver_API;

//�ƶ�Ѱ��
function CMSeekSimCard(hReader: Pointer; CardSN: PChar; var BufSize: Integer): Boolean; stdcall; external OldEastRiver_API;

//��͸��ָ��Ͽ�����
function CMDisConnectSimCard(hReader: Pointer): Boolean; stdcall; external OldEastRiver_API;

//ȡ�����
function CMGetChallenge(hReader: Pointer; Challenge: PChar; var RandLen: Integer): Boolean; stdcall; external OldEastRiver_API;

type
  //һ��ͨӦ�õĹ���Ӧ�û��������ļ�
  TOneCardBasicDataFile=packed record
    //��������ʶ
    PublisherID: array[0..7] of Byte;
    //Ӧ�����ͱ�ʶ
    AppTypeID: Byte;
    //������Ӧ�ð汾
    AppVer: Byte;
    //Ӧ�����к�
    AppSN: array[0..7] of Byte;
    //Ӧ����������
    OpenDate: DWORD;
    //Ӧ����Ч����
    ExpireDate: DWORD;
    //�����ͱ�ʶ
    CardType: Byte;
    //�������Զ���FCI����
    FCI: array[0..2] of Byte;
  end;
  
//ѡ��һ��ͨӦ��
function CMSelectOneCardApp(hReader: Pointer; var AppFile: TOneCardBasicDataFile): Boolean; stdcall; external OldEastRiver_API;

//��ѯ��Ӧ��״̬
function CMGetSubAppState(hReader: Pointer; EnterpriseID: PChar; SubAppID: Byte): Boolean; stdcall; external OldEastRiver_API;

//��ѯ���
function CMGetBalance(hReader: Pointer; EnterpriseID: PChar; SubAppID: Byte; var Balance, ExpireDate: DWORD): Boolean; stdcall; external OldEastRiver_API;

//�ƶ���ͷAPDU
function CMAPDU(hReader: Pointer; APDU, Answer: PChar; APDULen: Integer; var BufLen: Integer; var SW1SW2: Word): Boolean; stdcall; external OldEastRiver_API

//��ѰIC�������ݶ�ͷ��װ���ź��ƶ�ģ��������Ѱ���ſ����ƶ���
function MFSeekCard(hReader: Pointer; var CardType: Byte; CardSN: PChar; var BufSize: Integer): Boolean; stdcall; external OldEastRiver_API;
//�رտ�Ƭ
function MFCloseCard(hReader: Pointer; CardType: Byte): Boolean; stdcall; external OldEastRiver_API;
//��֤
function MFICAuthentication(hReader: Pointer; BlockNo, PwdType: Byte; AccessKey: PChar; KeyLen: Integer): Boolean; stdcall; external OldEastRiver_API;
//����
function MFICReadBlock(hReader: Pointer; BlockNo: Byte; BlockData: PChar; var DataLen: Integer): Boolean; stdcall; external OldEastRiver_API;
//д��
function MFICWriteBlock(hReader: Pointer; BlockNo: Byte; BlockData: PChar; DataLen: Integer): Boolean; stdcall; external OldEastRiver_API;
//��ֵ
function MFICIncrement(hReader: Pointer; BlockNo: Byte; Amount: DWORD): Boolean; stdcall; external OldEastRiver_API;
//��ֵ
function MFICDecrement(hReader: Pointer; BlockNo: Byte; Amount: DWORD): Boolean; stdcall; external OldEastRiver_API;
//����
function MFICDuplicate(hReader: Pointer; SrcBlockNo, DestBlockNo: Byte): Boolean; stdcall; external OldEastRiver_API;

//��AID
function CTGetReaderAID(hReader: Pointer; AID: PChar; var AIDLen: Integer): Boolean; stdcall; external OldEastRiver_API;
//дAID
function CTSetReaderAID(hReader: Pointer; AID: PChar; AIDLen: Integer): Boolean; stdcall; external OldEastRiver_API;
//����͸��ָ��
function CTReaderControl(hReader: Pointer; Cmd, Answer: PChar; CmdLen: Integer; var BufLen: Integer; var SW1SW2: Word): Boolean; stdcall; external OldEastRiver_API;
//function CT_Transparent_Begin(hReader: Pointer): Boolean; stdcall; external EASTRIVER_API;
//function CT_Transparent_End(hReader: Pointer): Boolean; stdcall; external EASTRIVER_API;
//UIM��֤
//function MFUIMAuthentication(hReader: Pointer; BlockNo, PwdType: Byte; AccessKey: PChar; KeyLen: Integer): Boolean; stdcall; external EASTRIVER_API;

function SetGroupAID(hPort: THandle; szAID: PChar): Boolean; stdcall; external OldEastRiver_API;
function SetProvinceAID(hPort: THandle; szAID: PChar): Boolean; stdcall; external OldEastRiver_API;
function SetEnterpriseAID(hPort: THandle; szAID: PChar): Boolean; stdcall; external OldEastRiver_API;

function SetConsumeKey(hPort: THandle; szHexKey: PChar; IsDelete: Boolean=False): Boolean; stdcall; external OldEastRiver_API;
function SetChargeKey(hPort: THandle; szHexKey: PChar; IsDelete: Boolean=False): Boolean; stdcall; external OldEastRiver_API;
function SetTACKey(hPort: THandle; szHexKey: PChar; IsDelete: Boolean=False): Boolean; stdcall; external OldEastRiver_API;

//USb͸�����ݴ��䣬����SendComCmd
//function USBSendCmdData(PData: Pchar; DataSize: Integer; RcvBytes: PChar; var BufSize: Integer; Delay: Cardinal=InitTimeOut): Boolean; stdcall; external OldEastRiver_API;
function USBSetCardPWDAB(Sector: Integer; PasswardA: PChar; PasswardB: PChar; CardType: Integer): Integer; stdcall; external OldEastRiver_API;

//CPU��͸������
function CPUAPDU(hReader: Pointer; APDU, Answer: PChar; APDULen: Integer; var BufLen: Integer; var SW1SW2: Word): Boolean; stdcall; external OldEastRiver_API;
//��λCPU ��
function CPUReset(hReader: Pointer; Answer: PChar; var BufLen: Integer): Boolean; stdcall; external OldEastRiver_API;
//HALT CPU ��
function CPUHalt(hReader: Pointer): Boolean; stdcall; external OldEastRiver_API;
//�ⲿ��֤
function CPUExternalAuth(hReader: Pointer; KeyID: Byte; KeyData: PChar; KeyLen: Integer; var SW1SW2: Word): Boolean; stdcall; external OldEastRiver_API;
//������Կ
function CPUWriteKey(hReader: Pointer; KeyID, KeyType, UsePower, ChangePower, KeyVer, Alg_Err: Byte; AuthKey, NewKey: PChar; AuthKeyLen, NewKeyLen: Integer; var SW1SW2: Word): Boolean; stdcall; external OldEastRiver_API;
//�滻��Կ
function CPUUpdateKey(hReader: Pointer; KeyType, KeyID: Byte; AuthKey, NewKey: PChar; AuthKeyLen, NewKeyLen: Integer; var SW1SW2: Word): Boolean; stdcall; external OldEastRiver_API;
//ȡ�����
function CPUGetChallenge(hReader: Pointer; RandData: PChar; var nLen: Integer): Boolean; stdcall; external OldEastRiver_API;
//��Ӳ���汾��Ϣ
function MFGetFirmVersion(hReader: Pointer; FirmVer: PChar; var nLen: Integer): Boolean; stdcall; external OldEastRiver_API;
//PSAM��1��λ
function PSAM1Reset(hReader: Pointer; Answer: PChar; var BufLen: Integer): Boolean; stdcall; external OldEastRiver_API;
//PSAM��2��λ
function PSAM2Reset(hReader: Pointer; Answer: PChar; var BufLen: Integer): Boolean; stdcall; external OldEastRiver_API;
//PSAM��1͸������
function PSAM1APDU(hReader: Pointer; APDU, Answer: PChar; APDULen: Integer; var BufLen: Integer; var SW1SW2: Word): Boolean; stdcall; external OldEastRiver_API;


///�����ϴ��У�ʹ�õĽṹ��
type
  pDeviceData = ^DeviceData;
  DeviceData = record                                       // �豸ˢ������
    cardno: array[0..19] of char;                           //����
    emp_no: array[0..16] of char;                           //����
    emp_name: array[0..16] of char;                         //Ա������
    dev_id: integer;                                        //����
    mark: Integer;                                          //��ʶ
    card_time: array[0..15] of char;                        //��ʱ��
    consume: integer;                                       //��λ��
    blanace: integer;                                       //��λ��
    times: integer;                                         //��ֵ����
    flag: integer;                                          // �򿨱�ʶ
    dev_ver: integer;                                       //���Ѽ�¼�汾��
    POS_Sequ: integer;                                      //POS������ˮ��
    Card_Sequ: integer;                                     //��������ˮ��
    Op_CardNo: array[0..9] of char;                         //����Ա����
    OverPwd: array[0..9] of char;                           //������������
    reserved1: array[0..19] of char;                        // ����
    reserved2: Cardinal;                                    // ������α�ʶ
    CustomInfo1:array[0..15] of Char;                       //�Զ�����Ϣ1
    CustomInfo2:array[0..15] of Char;                       //�Զ�����Ϣ2
    CustomInfo3:array[0..15] of Char;                       //�Զ�����Ϣ3
    CustomInfo4:array[0..15] of Char;                       //�Զ�����Ϣ4
    Input1:integer;
    Input2:integer;
    Input3:integer;
  end;

  DeviceDataArray = array[0..15] of DeviceData;

/////�����ϴ��õĻص�����
//type
//  FunOnRefreshDeviceState = procedure(Dev_id: integer; State: integer; RecordCount: integer);
//  FunOnRecieveRecord = procedure(Dev_id: integer; aRecord: DeviceData;var bReturnOK:boolean);


////�����ϴ� (>4G)
//Function StartUpLoad(vOnRefreshDeviceState:FunOnRefreshDeviceState;vOnRecieveRecord:FunOnRecieveRecord):integer; stdcall;  external EastRiver_API;
//procedure StopUpLoad; stdcall;   external EastRiver_API;
//function AddUpLoadDevice(DevId:integer;Ip: PChar;Port:integer): integer;  stdcall;  external EastRiver_API;
//function RemoveUpLoadDevice(DevId:integer): integer; stdcall; external EastRiver_API;

///�����������(>4G)
type
//TDeviceList���ͽṹ��
  PConnParam = ^ConnParam;                                  ///���Ӳ���
  ConnParam = record
    dev_id: Integer;                                        ///����
    ComPort: Integer;                                       ///Com��
    ComBaudRate: integer;                                   //���в�����
    IPAddress: array[0..15] of char;                        ///IP��ַ
    IPPort: Integer;                                        ///IP�˿�
    USBPath: array[0..127] of char;                          ///USB�豸·��
    CommType: Integer;                                      ///ͨѶ��ʽ, 0:RS232,1:TCP/IP,2:UDP,3:USB

  end;

  PDeviceType = ^DeviceType;                                //�豸����
  DeviceType = record
    Version: double;                                        ///�豸����汾
    VerOrd:integer;                                         ///�ڼ���Э��
    DevType: integer;                                       ///�豸�ͺ�
    Serial_Num: array[0..15] of char;                       ///�豸���к�
    DevModel: Integer;                                      ///�豸�ͺ�
    Cls: Integer;                                           ///��ͷ����, 0:ID, 1:IC,2:���,3:CPU
    clocktype: integer;                                     //�豸��;  ���ڻ� 1:�Ž��� 2:���ѻ�
    Devname: array[0..20] of char;                          //�豸����
    MAC:array[0..20] of char;                               //�豸MAC��ַ
    //DevUse: integer;                                        //�豸��;
  end;

 pDeviceRec = ^DeviceRec;                                  //
 DeviceRec = record                                        //�豸����ṹ
   DevType: DeviceType;                                    //�豸����
   pConnParam: ConnParam;                                  //�豸���Ӳ���
 end;

 TDeviceList = array[0..255] of DeviceRec;
 function SearchLanDevice(var Devices:TDeviceList;var DeviceCount:integer):boolean;stdcall; external EastRiver_API;

 type
////�������ͽṹ��
  pNameList = ^NameList;
  NameList =packed record
    listtype: Integer;                                      //�������� 0 ������ 1 ������ 2 �Ž�ͨ������
    cardno: array[0..19] of char;                           //����
    emp_no: array[0..15] of char;                           //����
    emp_name: array[0..15] of char;                         //Ա������
    devid: Integer;                                         //�豸id
    Week: integer;                                          //����ʱ���
    TimePass: array[0..5] of Integer;                     //����ʱ���
    //BeginTime:array [0..195] of Char;                       //����ʱ���-��ʼʱ��
    //EndTime:array [0..195] of Char;                         //����ʱ���-����ʱ��
    CustomInfo1:array[0..15] of Char;                       //�Զ�����Ϣ1
    CustomInfo2:array[0..15] of Char;                       //�Զ�����Ϣ2
    CustomInfo3:array[0..15] of Char;                       //�Զ�����Ϣ3
    CustomInfo4:array[0..15] of Char;                       //�Զ�����Ϣ4
  end;

  NameListArray = array[0..15] of NameList;                 //16��һ������


///���������������16��(>4G)
function DownLoadCardList(hPort: THandle; ListType: Integer; WeekTime: Integer; BeginTime: PChar; EndTime: PChar; CardList: PChar; EmpIdList: PChar; EmpNameList: PChar): Integer; stdcall;external EastRiver_API;
//ListType,��������,0,��������1��������
//WeekTime,���ڣ�λ���㣬127����ȫ���ڣ�1�������գ�2������һ��4�����ڶ���8����������16�������ģ�32�������壬64��������
//BeginTime��EndTime, ��ʼʱ�䣬����ʱ�� ��Ĭ��ȫ�죬0000,2400�� 08001400��12001800������ 08:00-12:00, 14:00-18:00
//CardList,�����б��س���Ϊ�ָ���
//EmpIdList,�����б��س���Ϊ�ָ���
//EmpNameList,�����б��س���Ϊ�ָ���

//���豸�������� (>4G)
function ReadListCardTotal(hPort: THandle;var ListCardTotal:integer;var WhiteCard:integer;var BlackCard:integer):boolean;stdcall;external EastRiver_API;
//ListCardTotal,�����洢�ռ�(��λ����)
//WhiteCard����Ч����������
//BlackCard����Ч����������

// ���豸����(>4G)
function ReadDeviceListCard(hPort: THandle;FromPos: Integer; var RecordCount: Integer; var ListCards: NameListArray): Boolean;stdcall;external EastRiver_API;
//����˵��
//fmt:�����洢��ʽ
//fromPos:�ӵڼ�����ʼ
//RecordCount:��ȡ�ļ�¼��,Ҳ�Ƿ��صļ�¼��. ���16��
//Records:���ص�������.

//����ɾ����¼(>4G)
function BatchReadDelRecord(hPort: THandle;Control: integer; var RecordCount: Integer; var Records: array of TICRecord): boolean; stdcall;  external EastRiver_API;
//�����֣�
const
  ReadDelRecord_Head = 1;                                   //��ͷ��ɾ����¼
  ReadDelRecord_Next = 2;                                   //����һ����¼
  ReadDelRecord_Retry = 3;                                  //���¶���һ����¼
//���󷵻ص����������Ϊ 16��Ҳ��ʵ�ʷ��صļ�¼��
//Records�� ��¼��

type
////�豸���к����ͣ�16���ֽڣ����һ���ֽڹ̶�Ϊ #0
  TSerialType=Array [0..16] of Char;

  FunOnRefreshDeviceStateBySerial = procedure(Dev_id: integer;Serial:TSerialType; State: integer; RecordCount: integer);
  FunOnDeviceLogin=procedure(Dev_id:integer;Serial:TSerialType;ip:PChar;port:integer;
                   var Heartbeat:integer);
  FunOnRecieveBatchRecordBySerial=procedure(Dev_id: integer;Serial:TSerialType;index:integer;RecordCount:integer;Records: DeviceDataArray;var bReturnOK:boolean);


///�����ϴ�(>4G)
function StartUpLoad(vListenPort:Integer):boolean; stdcall;   external EastRiver_API;
procedure SetUpLoadProc(vOnDeviceLogin:FunOnDeviceLogin;
              vOnRefreshDeviceState: FunOnRefreshDeviceStateBySerial;
                vOnRecieveBatchRecord: FunOnRecieveBatchRecordBySerial);  stdcall;   external EastRiver_API;
procedure StopUpLoad(); stdcall;  external EastRiver_API;
function DownLoadListCardbySerial(Serial:PChar;NameLists:NameListArray;Count:integer):integer;stdcall;    external EastRiver_API;


////�����ڻ���¼��������Ч��¼����(>4G)
function ReadDeviceRecordInfo(hPort: THandle; var RecordMax, RecordSave: Integer): boolean; stdcall;   external EastRiver_API;
////RecordMax:��¼������
////RecordSave:��Ч��¼��

////��������������(��λ����)   (>4G)
function SetListCardTotal(hPort: THandle;  var ListCardTotal: integer): boolean; stdcall;  external EastRiver_API;
///ListCardTotal:������������λ����������ʵ������ֵ��8��������

////�ɼ��������ı���ʽ��� (ÿ�����ȡ16����¼������������ 2048 ) ��ΪVB �� C#����
function BatchReadRecordAsString(hPort: THandle;  strRecords:PChar): Integer; stdcall; external EastRiver_API;

////˳��ɼ�����,��ɾ����ʽ�����ı���ʽ���(ÿ�����ȡ16����¼������������ 2048 ) ��ΪVB �� C#����
function BatchReadRecordNotDelAsString(hPort:THandle;StartPos:integer;var Recordcount:integer;  strRecords:PChar):boolean; stdcall;external EastRiver_API;

//����ɾ����¼(>4G)�����ı���ʽ���(ÿ�����ȡ16����¼������������ 2048 ) ��ΪVB �� C#����
function BatchReadDelRecordAsString(hPort: THandle;Control: integer; var RecordCount: Integer;
 strRecords:PChar): boolean; stdcall; external EastRiver_API;
//�����֣�
//const
//  ReadDelRecord_Head = 1;                                   //��ͷ��ɾ����¼
//  ReadDelRecord_Next = 2;                                   //����һ����¼
//  ReadDelRecord_Retry = 3;                                  //���¶���һ����¼
//���󷵻ص����������Ϊ 16��Ҳ��ʵ�ʷ��صļ�¼��
//Records�� ��¼��

//��ɾ���ɼ���¼(>4G)
function BatchReadRecordNotDel(hPort:THandle;StartPos:integer;var Recordcount:integer;  var Records: array of TICRecord):boolean; stdcall; external EastRiver_API;
///StartPos����ʼ���
///Recordcount:��Ҫ���صļ�¼�������16

////ɾ��ָ�������ļ�¼
function DeleteRecord(hPort:THandle;Count:integer):boolean; stdcall;  external EastRiver_API;
///ɾ����¼��

// ���豸����(>4G),���ַ������������ΪC#,VB ����
function ReadDeviceListCardAsString(hPort: THandle;FromPos: Integer; var RecordCount: Integer; strListCards: PChar): Boolean;stdcall;  external EastRiver_API;
//����˵��
//fmt:�����洢��ʽ
//fromPos:�ӵڼ�����ʼ
//RecordCount:��ȡ�ļ�¼��,Ҳ�Ƿ��صļ�¼��. ���16��

//****    ��ʽ��������  (<4G)
function QuickOldCallClock(hPort: THandle; clock_id: Integer): Boolean; stdcall; external EastRiver_API;
//����˵��:
// hPort        : �˿ھ��,ͨ������OpenCommPort�����õ�
// clock_id     : ����,����ֵ: 0-255, ���ڻ�������ʾ�Ļ���ʵ��������λ16������
//                ���Ի��ŷ�Χ16���Ʊ�ʾӦ��Ϊ: 0x00-0xFF
//����ֵ:
// True         : �����ɹ�
// False        : ����ʧ��
//��ע:
// "1G"���Ͳ����ظ�����
// ���кͻ���ͨѶ��û�д����ŵĺ�������������������ܵ���

///������������֪���͵����������
function QuickCallClock(hPort: THandle; clock_id: Integer;Is891:boolean): Boolean; stdcall;external EastRiver_API;


implementation


end.



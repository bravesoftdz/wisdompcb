unit ConstDeclare;
interface
//����ı������壬���ڼ��й���
uses
  Windows, Messages, SysUtils, Classes;

const
// ��������ģʽ
  em_Browse = 1;//1�������2��������3���༭ 4�����Ƽ�¼
  em_Add = 2;
  em_Edit = 3;
  em_copy = 4;
//----------------------------------------------------------
//  ENG_NULL_VALUE = 'NULL';
//---------------------
//������ѡ�Ի�����Ŀ����
  v_PICK_CUST_ID          = 1 ; //ѡ��ͻ����
  v_Pick_SALES_MAN        = 2 ; //ѡ������Ա
  v_Pick_Sales_Director   = 3 ;//ѡ����������
  v_Pick_Prod_Type        = 4; //ѡ���Ʒ����
  v_Pick_Eng_Param        = 5; //ѡ�񹤳̲���
  v_Pick_Qry_No           = 6;//ѡ���ѯģ����
  v_Pick_Part_No          = 201;//���ϱ���
  v_Pick_Part_Type        = 202; //�������
  v_Pick_Supplier         = 203;//��Ӧ��
  v_Pick_Factory          = 204;//����
  v_Pick_Part_Group       = 205;//�������
  v_Pick_Employee         = 206;//Ա��
  v_Pick_Department       = 207;//����
  v_Pick_WareHouse        = 208;//�ֿ�
  v_Pick_Matrl_Type       = 209;//��Ʒ���
  MOD_QRY          = 201 ; //��ѯ����ģ��

  qry_Order_Price               = 101;//�����۸����
//���ϲ�ѯ
  qry_Matrl_receiving_List      = 202;//���Ͻ�����ϸ
  qry_Matrl_receiving_Sum       = 203;//���Ͻ��ջ���
  qry_Matrl_Issue_List          = 204;//���Ϸ�����ϸ
  qry_Matrl_Issue_Sum           = 205;//���Ϸ��Ż���
  qry_Matrl_Stock_List          = 206;//���Ͽ����ϸ
  qry_Matrl_Stock_Sum           = 207;//���Ͽ�����
  qry_Matrl_ReMove              = 208;//���Ͽ��

//�ɹ���ѯ
  qry_Prchs_Req_Matrl_Prod      = 301;//���������빺
  qry_Prchs_Req_Matrl_Other     = 302;//�����������빺
  qry_Prchs_Matrl_Prod          = 303;//�������ϲɹ�
  qry_Prchs_Matrl_Other         = 304;//���������ϲɹ�
  qry_Prchs_summarizing         = 3051;//�ɹ�����--�ɹ�
  qry_Prchs_Stock_summarizing   = 3052;//�ɹ�����--���

  rpt_Item_Set                  = 401;//��������

//ѡ���Ĵ������
 type
  DlgPickItem = record
    Fields,  //ѡ����Dbgrid��ʾ���ֶ���Ϣ,�����ʽΪ'Field1/Caption1,Field2/Caption'
    KeyField,  //���������Ϊ����Ϊ'rkey'
    InPut_value : variant;    //���ڶ�λ�ڵ�ǰ��ֵ�ļ�¼
    vData: olevariant; //���������
  end;

  PMstrDtl = record
    sqlstr: array of string;
  end;

implementation

end.


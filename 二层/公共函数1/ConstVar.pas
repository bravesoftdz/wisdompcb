unit ConstVar;
interface
//����ı������壬���ڼ��й���
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  VCLCom, StdVcl, DBClient, DB, ADODB, variants;

const
// ��������ģʽ
  em_Browse = 1;//1�������2��������3���༭ 4�����Ƽ�¼
  em_Add = 2;
  em_Edit = 3;
  em_copy = 4;
//----------------------------------------------------------
//�ļ��汾

  InfoStr: array[1..9] of string = (
  'ProductName',
  'ProductVersion',
  'FileDescription',
  'LegalCopyright',
  'FileVersion',
  'CompanyName',
  'LegalTradeMarks',
  'InternalName',
  'OriginalFileName'
  );

//  ENG_NULL_VALUE = 'NULL';
//---------------------
//������ѡ�Ի�����Ŀ����
  v_PICK_CUST_ID          = 1 ; //ѡ��ͻ����
  v_Pick_SALES_MAN        = 2 ; //ѡ������Ա
  v_Pick_Sales_Director   = 3 ;//ѡ����������
  v_Pick_Prod_Type        = 4; //ѡ���Ʒ����
  v_Pick_Eng_Param        = 5; //ѡ�񹤳̲���


//ѡ���Ĵ������
 type
  PDlgInput = record
    Fields,  //ѡ����Dbgrid��ʾ���ֶ���Ϣ,�����ʽΪ'Field1/Caption1,Field2/Caption'
    KeyField,  //���������Ϊ����Ϊ'rkey'
    Sqlstr:string; //���ݼ���sql��ѯ
    InPut_value : variant;    //���ڶ�λ�ڵ�ǰ��ֵ�ļ�¼
    AdoConn: TAdoConnection; //�����Ado����
  end;
  PFile_Ver_INfo = record
    ProductName,
    ProductVersion,
    FileDescription,
    LegalCopyright,
    FileVersion,
    CompanyName,
    LegalTradeMarks,
    InternalName,
    OriginalFileName:string
  end;
  

implementation

end.

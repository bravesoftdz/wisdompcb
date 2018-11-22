{*******************************************************}
{                                                       }
{       �����  �������ݿ�����                          }
{                                                       }
{       ���ߣ� ������                                   }
{       ���ܣ� ����С��ģ���ݿ�����                     }
{       ʱ�䣺 2012-4-20                                }
{       �汾�� V1.0.0.0                                 }
{       ����޸ģ�������                                }
{       ��ע�� ��                                       }
{                                                       }
{*******************************************************}

unit DataMgr;

interface
uses
  Windows, ActiveX, SysUtils, XMLDoc, XMLIntf, Classes, StrUtils;


//���ݹ����װ��
//
type
  TFunRet = (frFailed=0, frSOK=1, frExist=2, frNotExist=3, frNotPrmit=4);
  //0-ʧ�ܣ� 1-�ɹ���  2-�Ѿ����ڣ�		3-�����ڣ�	4-ûȨ��

  TDataMgr = class
  private
    //FXMLFile: String;
    FXMLDoc: IXMLDocument;
  public
    constructor Create();
    destructor Destroy; override;

    function AddNode(AParent: IXMLNode; ANode: string): IXMLNode;
    procedure SaveToFile(AFileFullName: string);
    function LoadXML(aFileName: string): TFunRet;
    function MainNode: IXMLNode;
  end;


    
implementation

{ TDataMgr }

function TDataMgr.AddNode(AParent: IXMLNode; ANode: string): IXMLNode;
begin
  if AParent = nil then
    Result := FXMLDoc.Node.AddChild(ANode)
  else
    Result := AParent.AddChild(ANode);
end;

constructor TDataMgr.Create;
begin
  FXMLDoc := NewXMLDocument;
  FXMLDoc.Options := [doNodeAutoIndent];
  FXMLDoc.NodeIndentStr := '';
end;

destructor TDataMgr.Destroy;
begin
  inherited;
  FXMLDoc := nil;
end;

function TDataMgr.LoadXML(aFileName: string): TFunRet;
begin
  try
    FXmlDoc.LoadFromFile(aFileName);
    if FXmlDoc.ChildNodes.Count < 2 then
    begin
      Result := frFailed;
      Exit;
    end;
    Result := frSOK;
  except
    Result := frFailed;
  end;
end;

function TDataMgr.MainNode: IXMLNode;
begin
  if FXMLDoc.ChildNodes.Count >= 2 then
    Result := FXMLDoc.ChildNodes[1]
  else
    Result := nil;
end;

procedure TDataMgr.SaveToFile(AFileFullName: string);
begin
  FXMLDoc.SaveToFile(AFileFullName);
end;




end.

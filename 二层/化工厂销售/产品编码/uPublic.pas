unit uPublic;

interface
uses
  SysUtils,Classes;
function checkchar(const pstr:string;const pkey:char):boolean;

implementation
function checkchar(const pstr:string;const pkey:char):boolean;
begin
if not (pkey in ['0'..'9','.',#8]) then  //�ж��Ƿ���������
  begin
    result:=false
  end
 else
  if pkey = chr(46) then      //�ж��Ƿ��ظ�����С����'.'
   if pos('.',pstr)>0  then
      begin
        result:=false;
      end
   else
      result:=true;     
end;
end.

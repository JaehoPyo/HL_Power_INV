unit h_LanglLib;

interface

uses Classes,SysUtils,SyncObjs,Dialogs,Variants, Math ;

type
  addrRecord = record
     addrArray : array[0..6] of string;
  end;

//==============================================================================
// ��ȣȭ�� ���Ǵ� �⺻ Ű��
//==============================================================================
const
  MYKEY  = 7756;  ENCKEY  = 9089;  DECKEY  = 1441;

    // �� ��ȯ�� �´�.
    function ExGetLang( Source:String; LangNo : Integer ): String;



implementation

//==============================================================================
//  ������ ����ŭ �����Ѵ�.
//==============================================================================
function ExGetLang( Source:String; LangNo : Integer ): String;
begin
   Result := Source;

end;



end.

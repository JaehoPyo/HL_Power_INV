unit ExVarLib;

interface

uses Classes,SysUtils,SyncObjs,Dialogs,Variants, Math ;

type
  addrxRecord = record
     addrArray : array[0..6] of string;
  end;

//const
//  MYKEY  = 7756;  ENCKEY  = 9089;  DECKEY  = 1441;

    // �� ��ȯ�� �´�.
    function ExxGetLang( Source:String; LangNo : Integer ): String;



implementation

//==============================================================================
//  ������ ����ŭ �����Ѵ�.
//==============================================================================
function ExxGetLang( Source:String; LangNo : Integer ): String;
begin
   Result := Source;

end;



end.

unit h_LanglLib;

interface

uses Classes,SysUtils,SyncObjs,Dialogs,Variants, Math ;

type
  addrRecord = record
     addrArray : array[0..6] of string;
  end;

//==============================================================================
// 암호화에 사용되는 기본 키값
//==============================================================================
const
  MYKEY  = 7756;  ENCKEY  = 9089;  DECKEY  = 1441;

    // 언어를 변환해 온다.
    function ExGetLang( Source:String; LangNo : Integer ): String;



implementation

//==============================================================================
//  지정된 수만큼 증가한다.
//==============================================================================
function ExGetLang( Source:String; LangNo : Integer ): String;
begin
   Result := Source;

end;



end.

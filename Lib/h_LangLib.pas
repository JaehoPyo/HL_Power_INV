unit h_LangLib;

interface

uses Classes,SysUtils ;

//type

//  TLANG_DESC = Record
//    FORMID   : String;
//    DB_COLUMN_YN : String;
//    FIELD_NAME: String;
//    DESC : Array [1..5] of String;
//  end;
//
//  TLANG_INFO = Record // Form Field Description
//    ID   : String;
//    LANG  : Array [0..100] of TLANG_DESC ;
//  end;
//
//  TLANG_PGM = Record // Form Name Description
//    LANG  : Array [0..100] of TLANG_DESC ;
//  end;


//==============================================================================
// 암호화에 사용되는 기본 키값
//==============================================================================
const
  programClose_1 = '프로그램을 종료하시겠습니까? ';
  programClose_2 = 'Close applications?';
  //programClose_3 = '结束吗?';

    // 언어를 변환해 온다.
    function ExGetLang( Source:String; LANGUAGE : String ): String;



implementation

//==============================================================================
//  지정된 수만큼 증가한다.
//==============================================================================
function ExGetLang( Source, LANGUAGE : String ): String;
begin
   Result := Source;

end;



end.

unit h_SqlLib;

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

    //        입력된 문자가 공백인지 확인하는 펑션
    function  ExIsEmpty  ( Value  : String ): Boolean ; overload;
    //        입력된 문자가 공백이면 디폴트 값을 넘겨준다.
    function  ExIsEmpty  ( Value  : String  ; Default : String  ): String ; overload;
    //        입력 받은 숫자가 0 이면 디폴트 값을 넘겨준다.
    function  ExIsZero( Value  : Integer; Default : Integer ) : Integer ;
    //
    function  ExMakeText ( CharText : Char; TextSize : Integer  ) : String;
    //
    function  ExPlusText ( CharText : Char; TextSize : Integer  ; Value : Variant ) : String;
    //        문자열을 암호화 처리 한다.
    function  ExEncoding ( Const Value : String ; Key : Word = MYKEY ) : String;
    //        문자열을 암호화 해지 한다.
    function  ExDecoding ( Const Value : String ; Key : Word = MYKEY ) : String;
    //        문자열을 받아 넘버형 필드를 넘겨준다.
    function  ExNumbText ( value , Default : Variant   ; OnlyNumb  : Boolean = False  ) : String  ;
    //        문자 변환용 펑션
    function  ExVarToStr ( Value : Variant; DefValue : String  = ''    ) : String  ;
    function  ExVarToInt ( Value : Variant; DefValue : Integer = 0     ) : Integer ;
    function  ExVarToDob ( Value : Variant; DefValue : Double  = 0     ) : Double  ;
    function  ExVarToBol ( Value : Variant; DefValue : Boolean = False ) : Boolean ;
    function  ExVarToWon ( Value : Variant; DefValue : Double  = 0     ) : String  ;
    //        문자열을 받아 스페이스를 제거 한다.
    function  ExSqlSpace ( Const Value : String ) : String ;

    function  ExStrToSql ( Const Value : String ; StrWrite : Boolean ) : String; overload;
    function  ExStrToSql ( Const Value : String ; DefIndex , RtlIndex : Integer ) : String; overload;
    function  ExStrToSql ( Const Value : String ; TextArry : array of String                      ) : String; overload;
    function  ExStrToSql ( Const Value : String ; TextArry : array of String;  SqlWrite : Boolean ) : String; overload;
    function  ExStrToSql ( Const Value : String ; FromDate , Todate : TDateTime ) : String; overload;
    function  ExStrToSql ( Const Value : String ; FromDate , Todate : TDateTime ; StrWrite : Boolean ) : String; overload;

    //        특정 값을 입력받고 배열에서 저장된 다음 숫자를 찾아 결과를 넘겨준다.
    //        만약 다음 숫자를 찾지 못하면 처음 값을 넘겨준다.
    function  ExNextByte ( Value : Integer; LoopValue : array of Integer ) : Integer ;
    //        두 문자열을 입력 받아 참이면 앞의 문자열을 거짓이면 뒷 문자열을 넘겨준다.
    function  ExRetToStr ( TrueValue , FalseValue : String  ; RetBool : Boolean ) : String; overload;
    //        두 숫자를 입력 받아 참이면 앞의 문자열을 거짓이면 뒷 문자열을 넘겨준다.
    function  ExRetToInt ( TrueValue , FalseValue : Integer ; RetBool : Boolean ) : Integer; overload;
    //        두 문자열을 입력 받아 참이면 앞의 문자열을 거짓이면 뒷 문자열을 넘겨준다.
    function  ExRetToVar ( TrueValue , FalseValue : Variant ; RetBool : Boolean ) : Variant; overload;

    //        한 문자열을 입력 받아 배열로 입력된 문자가 있는지 확인 하여 참과 거짓을 넘겨준다.
    function  ExFindText ( Const Value : String ; TextList : array of string; UpperType : Boolean = False ) : Boolean;
    //
    function  ExCopyText ( Const Value : String ; Index , Count : Integer ) : String ;
    //
    function  ExCopyFind ( Const Value : String;  Index , Count : Integer ; FindList : Array of String ; UpperType : Boolean = False ) : Boolean  ;
    //        일자를 입력 받아 한글로 표기된 요일을 넘겨준다.
    function  ExWeekOfHan  ( Value : TDateTime=0) : String ;
    //        체크썸을 구한다.
    function  ExStrToBcc ( Const Value : String ) : Word ;
    //        주민 등록 번호를 검사 한다.
    function  ExPLicense ( Const Value : String ) : Boolean ;
              //ExStringList;
    //        등록 번호를 검사 한다.
    function  ExCLicense( Const Value : String ) : Boolean ;


    // 2개의 바이트를 받아 제일 높은 수를 구한다.
    function ExMinByte( A1 , B1 : Byte ): byte;
    // 2개를 받아 제일 높은 수를 구한다.
    function ExMaxInteger( A1 , B1 : Longint ): Longint;
    // 2개를 받아 제일 낮은 수를 구한다.
    function ExMinInteger( A1 , B1 : Longint ): Longint;
    // 특별문자 변환
    function ExReplace( Source, FromStr, ToStr : String ): String;



implementation

//==============================================================================
//  지정된 수만큼 증가한다.
//==============================================================================
function ExtInc( var X : Integer ; N : Integer = 1; Action : Boolean = True ) : Integer ;
begin
   if  Action then
       Inc( X , N );
   Result := X ;
end;

//==============================================================================
//  지정된 수만큼 감소한다.
//==============================================================================
function ExtDec( var X : Integer ; N : Integer = 1 ; Action : Boolean = True) : Integer ;
begin
   if  Action then
       Dec( X , N );
   Result := X ;
end;



//==============================================================================
//        델파이 Round 문제가 있어 수정하여 사용함
//==============================================================================
function  ExRound (Value : Extended) : Int64 ;
begin
   Result := Trunc(Value) + Trunc(Frac(Value)*2);
end;

//==============================================================================
//        델파이 Round 문제가 있어 수정하여 사용함
//==============================================================================
function  ExFloor (Value : Extended ) : Int64 ;
var BuffText : String ;
    Pos_Byte : Integer ;
begin
   BuffText := FloatToStr( Value );
   Pos_Byte := Pos( '.',BuffText );
   if  Pos_Byte > 0 then begin
       Result := StrToInt64( Copy( BuffText , 1, Pos_Byte -1 ) );
   end else
       Result := StrToInt64( BuffText );
end;


//==============================================================================
//  입력된 문자열이 공백인지 확인한다.   공백일 경우 참을 그렇지 않을 경우 거짓을 넘겨준다.
//==============================================================================
function ExIsEmpty ( Value  : String ) : Boolean;
begin
   if  Trim( Value ) = '' then Result := True else Result := False ;
end;

//==============================================================================
//  입력된 문자열이 공백인지 확인한다.   공백일 경우 디폴트 값을 넘겨준다.
//==============================================================================
function ExIsEmpty( Value  : String; Default : String ) : String;
begin
   if  Trim( Value ) = '' then Result := Default else Result := Value;
end;


//==============================================================================
//  입력된 숫자가 0 이면 디폴트 값을 넘겨준다.
//==============================================================================
function ExIsZero( Value  : Integer; Default : Integer ) : Integer ;
begin
   if  Value = 0 then Result := Default else Result := Value;
end;


//==============================================================================
//  문자열을 받아 암호화 한다.
//==============================================================================
function ExEncoding ( Const Value : String; Key : Word = MYKEY ) : String;
var  i       : Byte;
     AscChar : Char;
     EncStr  , EncAsc : string;
begin
   EncStr   := '';
   if  Key = 0 Then  Key := MYKEY;
   for i := 1 to Length( Value ) do begin
       EncStr := EncStr  + Char ( Byte ( Value [i] ) xor ( Key shr 8 ) );
       Key    := ( Byte ( EncStr [i] ) + Key ) * ENCKEY + DECKEY ;
   end;
   EncAsc := '';
   for i := 1 to Length( EncStr ) do  begin  // 암호화된 이진 문자열을 ASCII 숫자로 변경
       AscChar := EncStr[i];
       EncAsc := EncAsc + format('%.3d', [Ord(AscChar)]); // 한문자당 3자리씩
   end;
   Result := EncAsc;
end;

//==============================================================================
//  암호화된 문자열을 받아 암호를 헤제한다.
//==============================================================================
function ExDecoding ( const Value : string; Key : Word = MYKEY ) : string;

var  i       : Byte;
     AscStr  : string;
     DecStr  , DecAsc : string;
begin
   DecAsc := ''; i := 1;
   repeat
      AscStr := Copy( Value, i, 3);                         // 한문자당 3자리 숫자로 저장되어 있다
      DecAsc := DecAsc + Chr( StrToIntDef ( AscStr, 0 ) ) ; // ASCII값을 구한다
      i := i + 3;
   until i > Length( Value );
   DecStr := '';
   if  Key = 0 Then  Key := MYKEY;
   for i := 1 to Length( DecAsc ) do begin
       DecStr := DecStr  + Char ( Byte ( DecAsc [i] ) xor ( Key shr 8 ) );
       Key    := ( Byte ( DecAsc [i] ) + Key ) * ENCKEY + DECKEY ;
   end;
   Result := DecStr;
end;



//==============================================================================
//  특정 캐랙터를 받아 입력 받은 수 만큼의 문자열을 만들어 준다.
//  특정 문자로 이루어진 문자열을 만들때 사용한다.
//  ex ( 5 , C ) = 'CCCCC'    예제 ( 4 , '0' ) = '0000'
//==============================================================================
function ExMakeText ( CharText : Char; TextSize : Integer ) : String;
begin
   Result := '';
   if  0 < TextSize then begin
       if  TextSize > 255 then TextSize := 255;
       SetLength( Result , TextSize );
       FillChar ( Result[1] , Length(Result), CharText );
   end;
end;

//==============================================================================
// 숫자와 자리수를 받아 자리수 만큼의 의 문자열을 만들어 주는 함수 ( 0으로 채움 )
// 항상 지정된 자리수 만큼의 문자열을 사용할때 사용한다.
// ex (  KS , -4 , 'A' ) = 'AAKS';   (  KS , -5 , '0' ) = '000KS';
// ex (  KS ,  4 , 'A' ) = 'KSAA';   (  KS ,  5 , '0' ) = 'KS000';
//==============================================================================
function ExPlusText ( CharText : Char; TextSize : Integer; Value : Variant ) : String;
begin
   try Result := VarToStr ( Value  );
       if  TextSize > 0 then begin
           Result := Result + ExMakeText( CharText , TextSize - Length( Result )   )  ;
       end else
       if  TextSize < 0 then begin
           Result := ExMakeText( CharText  , ( TextSize * -1 ) - Length( Result ) ) + Result ;
       end;
   finally end;
end;

//==============================================================================
//  가변형을 받아 숫자형 문자만 출력해 준다.
//==============================================================================
function ExNumbText  ( value , Default  : Variant; OnlyNumb : Boolean = False  ) : String  ;
var i  : Integer;
    IvBuff , RvBuff : String;
begin
   RvBuff := ''      ;
   Result := Default ;
   try IvBuff := VarToStr ( value ) ;
       if  not ExIsEmpty ( IvBuff ) then begin
           for i := 1 to Length ( IvBuff ) do begin
               if  IvBuff[i] In [ '0'..'9','-','.' ] then begin
                   if  OnlyNumb then begin
                       if  IvBuff[i] In [ '0'..'9' ] then RvBuff := RvBuff + IvBuff[i]
                   end else RvBuff := RvBuff + IvBuff[i] ;
               end;
           end;
       end;
   finally Result := RvBuff ; end;
end;


//==============================================================================
//  가변형을 받아 문자 형태로 넘겨준다.
//==============================================================================
function ExVarToStr ( Value : Variant; DefValue : String  = ''  ) : String  ;
begin
   Result := Defvalue ;
   try Result := VarToStr ( Value );
       if  Trim( Result) = '' then Result := DefValue;
   except Result := DefValue;end;
end;


//==============================================================================
//  가변형을 받아 숫자 형태로 넘겨준다.
//==============================================================================
function ExVarToInt ( Value : Variant; DefValue : Integer = 0     ) : Integer ;
begin
   if  not ExFindText( VarToStr( Value ) , [ 'TRUE' , 'FALSE' ] , True ) then begin
       try Result := StrToInt ( ExVarToStr ( Value , IntToStr(DefValue) ) );
       except
           Result := DefValue;
       end;
   end else
   if  ExFindText( VarToStr( Value ) , ['TRUE' ] , True ) then begin
       Result := 1 ;
   end else
   if  ExFindText( VarToStr( Value ) , ['FALSE' ] , True ) then begin
       Result := 0 ;
   end ;
end;

//==============================================================================
//  가변형을 받아 실수 형태로 넘겨준다.
//==============================================================================
function ExVarToDob ( Value : Variant; DefValue : Double  = 0     ) : Double  ;
begin
   try Result := StrToFloat( ExVarToStr ( Value , FloatToStr( DefValue ) ) );
   except Result := DefValue; end;
end;

//==============================================================================
//  가변형을 받아 블린 형태로 넘겨준다.
//==============================================================================
function ExVarToBol ( Value : Variant; DefValue : Boolean = False ) : Boolean ;
var TempText : String ;
begin
   try TempText := UpperCase ( Trim( ExVarToStr( Value , BoolToStr ( DefValue ) ) ) );
       Result   := ExFindText( TempText, [ 'Y' , 'YES' , 'T' , 'TRUE' , '1', '참' ] );
   except Result := DefValue; end;
end;

//==============================================================================
//  가변형을 받아 문자 형태로 넘겨준다.
//==============================================================================
function ExVarToWon ( Value : Variant; DefValue : Double  = 0     ) : String  ;
const Suh : Array [1..9] of String = ( '일','이','삼','사','오','육','칠','팔','구');
      won : Array [1..9] of String = ( ''  ,'십','백','천','만','십','백','천','억');
var TempBuff : Double ;
    TempText : String;
    TextSize , TextSite , TextNumb : Integer  ;
begin
   TempBuff := ExVarToDob(  Value , 0 ) ;
   if  ( TempBuff > 0 ) and ( TempBuff < 1000000000 ) then begin
       TempText := ExNumbText( TempBuff  ,0  , True ) ;
       Result   :='금_';
       TextSite := 1;
       TextSize := Length(TempText);
       while TextSize > 0  do begin
             if  TempText[TextSite] <> '0' then begin
                 TextNumb := StrToInt(TempText[TextSite]);
                 Result   := Result+Suh[TextNumb]+Won[TextSize];
            end;
            Dec ( TextSize ) ;
            inc ( TextSite ) ;
      end;
      Result := Result +'원정';
   end else Result := '?';
end;

//==============================================================================
//
//==============================================================================
function  ExSqlSpace ( Const Value : String ) : String ;
var TextSize : integer ;
    TempBuff : String ;
    CharBuff , TempChar : Char ;
    CharByte , LoopByte : Integer ;
begin
   Result   := '' ;  TempBuff := '' ;
   CharBuff := ' ';  TempChar := ' ';
   CharByte := 0  ;  LoopByte := 0  ;
   TextSize := Length( Value );
   if  TextSize > 0 then begin
       while LoopByte <= TextSize do begin
             Inc(LoopByte);
             TempChar := CharBuff  ;
             CharBuff := Value[LoopByte] ;
             if  CharBuff = ' ' then begin        // 한자리를 읽은뒤 공백이면
                 Inc(CharByte);
                 if  CharByte = 1 then
                     if  TempChar <> ',' then TempBuff := TempBuff + ' ';
             end else
             begin
                CharByte := 0 ;
                if  (CharBuff = ',') and  (TempChar = ' ' ) then begin
                    TempBuff := Copy ( TempBuff , 1, Length ( TempBuff ) -1 ) + CharBuff ;
                end else TempBuff := TempBuff + CharBuff;
             end;
       end;
       Result := TempBuff ;
   end ;
end;

//==============================================================================
//  Where 문장을 넣어준다.
//==============================================================================
function ExStrToSql ( Const Value : String ; TextArry : Array of String; SqlWrite : Boolean  ) : String; overload;
var i : Integer ;
    FlagBuff , TextBuff  : String ;
begin
   Result  := '' ;
   try FlagBuff := Trim ( UpperCase( TextArry[Low(TextArry)]) );
       if  SqlWrite and not ExIsEmpty ( FlagBuff ) then begin  //
           if  High ( TextArry ) > 0 then begin //  배열의 크기가 0보다 크면
               if  ExFindText( FlagBuff , ['FIX', 'NUM', 'AND', 'ORS', 'ORM', 'ORE', 'LIKE' , 'LLK' , 'RLK' ,'DLK' ] ) then begin
                   if  (FlagBuff = 'FIX') then begin
                       Result  := Value + QuotedStr ( TextArry[1] ) ;  // StrWrite 유무 관계없이 무조건 넣어준다. 고정값으로 판정
                   end else
                   if  not ExIsEmpty ( TextArry [1] ) then begin
                       //if  FlagBuff = 'FIX'  then begin Result  := Value + QuotedStr ( TextArry[1] ) ;             end else
                       if  FlagBuff = 'NUM'  then begin Result := Value + TextArry[1]  ;                           end else
                       if  FlagBuff = 'AND'  then begin Result := Value + QuotedStr ( TextArry[1]  )             ; end else
                       if  FlagBuff = 'ORS'  then begin Result := ' AND (1=2 '+ Value + QuotedStr ( TextArry[1] ); end else
                       if  FlagBuff = 'ORM'  then begin Result := Value + QuotedStr ( TextArry[1]  )             ; end else
                       if  FlagBuff = 'ORE'  then begin Result := Value + QuotedStr ( TextArry[1] ) + ' )   '    ; end else
                       if  FlagBuff = 'LLK'  then begin Result := Value + ' LIKE  ''%' + TextArry[1] + '''  '    ; end else
                       if  FlagBuff = 'RLK'  then begin Result := Value + ' LIKE  '''  + TextArry[1] + '%'' '    ; end else
                       if  FlagBuff = 'DLK'  then begin Result := Value + ' LIKE  ''%' + TextArry[1] + '%'' '    ; end else
                       if  FlagBuff = 'LIKE' then begin Result := Value + ' LIKE  ''%' + TextArry[1] + '%'' '    ;
                       end;
                   end else begin
                       if  FlagBuff = 'ORS'  then begin Result := ' AND  ( 1 = 2 ' ;  end else
                       if  FlagBuff = 'ORE'  then begin Result := '      )       ' ;  end;
                   end;
               end else

               if  ExFindText ( FlagBuff , ['IN'] )  then begin
                   if  High (TextArry) = 1 then begin
                       if  not ExIsEmpty ( TextArry[1] ) then begin
                           Result := Value + ' = ' + QuotedStr ( TextArry[1] );
                       end;
                   end else
                   if  High (TextArry) > 1 then begin
                       FlagBuff := ''; TextBuff := '';
                       for  i := Low(TextArry) + 1  to High (TextArry) do begin
                           // ShowMessage( TextArry[i] );
                            TextBuff :=  TextBuff + FlagBuff + QuotedStr ( TextArry[i] ) ;
                            FlagBuff := ',' ;
                       end;
                       Result := Value + ' IN ( ' + TextBuff + ' ) ' ;
                   end ;
               end else
               if  not ExIsEmpty( TextArry[0] ) and not ExIsEmpty(TextArry [1] )  then begin
                   Result := Value  + ' BETWEEN ' + QuotedStr( TextArry[0]) +' AND '+ QuotedStr(TextArry[1] ) ;
               end;
           end else Result := Value  + QuotedStr ( TextArry[0] ) ;
       end;
   finally
       if  Trim ( Result ) <> '' then Result := Result + #13#10;
   end;
end;

//==============================================================================
//  Where 문장을 넣어준다.
//==============================================================================
function ExStrToSql ( Const Value : String ; TextArry : Array of String ) : String; overload;
begin
   Result := ExStrToSql ( Value , TextArry , True  ) ;
end;

//==============================================================================
//  Where 문장을 넣어준다.
//==============================================================================
function ExStrToSql ( Const Value : String ; StrWrite : Boolean ) : String; overload;
begin
   if  StrWrite then Result := Value  else Result := '';
end;

function ExStrToSql ( Const Value : String ; DefIndex , RtlIndex : Integer ) : String; overload;
begin
   Result := ExStrToSql ( Value , (DefIndex = RtlIndex) );
end;


//==============================================================================
//  Where 문장을 넣어준다.
//==============================================================================
function ExStrToSql ( Const Value : String ; FromDate , ToDate : TDateTime ) : String; overload;
begin
   Result   := Value + ' BETWEEN ''' + FormatDateTime( 'YYYY-MM-DD' , FromDate ) +
                         ''' AND ''' + FormatDateTime( 'YYYY-MM-DD' , ToDate   ) + ''' ' + #13#10 ;
end;

//==============================================================================
//  Where 문장을 넣어준다.
//==============================================================================
function ExStrToSql ( Const Value : String ; FromDate , ToDate : TDateTime ; StrWrite : Boolean ) : String; overload;
begin
   if  StrWrite then Result := ExStrToSql ( Value , FromDate , ToDate ) else Result := '';
end;



//==============================================================================
// 특정 값을 입력받고 배열에서 저장된 다음 숫자를 찾아 결과를 넘겨준다.
// 만약 다음 숫자를 찾지 못하면 처음 값을 넘겨준다.
//==============================================================================
function ExNextByte ( Value : Integer; LoopValue : array of Integer ) : Integer;
var i , j : Integer ;
begin
   if  not(ExtInc(Value)>LoopValue[High(LoopValue)]) and not(Value<LoopValue[Low(LoopValue)]) then begin
       for i := Value to LoopValue[High(LoopValue)] do begin
           for j := Low(LoopValue ) to High(LoopValue) do begin
               if  Value = LoopValue[ j ] then begin
                   Result := LoopValue[j] ;
                   Exit;
               end else Continue ;
           end;
           ExtInc( Value );
           Continue ;
       end;
       Result := LoopValue[Low( LoopValue )];
   end else Result := LoopValue[Low( LoopValue )];
end;


//==============================================================================
//  문자열을 받아 참과 거짓일 때 문자열을 넘겨준다.
//==============================================================================
function ExRetToStr ( TrueValue , FalseValue : String  ; RetBool : Boolean ) : String  ;
begin
   if  RetBool then Result := TrueValue else Result := FalseValue ;
end;

//==============================================================================
//  문자열을 받아 참과 거짓일 때 문자열을 넘겨준다.
//==============================================================================
function ExRetToInt ( TrueValue , FalseValue : Integer  ; RetBool : Boolean ) : Integer  ;
begin
   if  RetBool then Result := TrueValue else Result := FalseValue ;
end;


//==============================================================================
//  문자열을 받아 참과 거짓일 때 문자열을 넘겨준다.
//==============================================================================
function  ExRetToVar ( TrueValue , FalseValue : Variant ; RetBool : Boolean ) : Variant;
begin
   if  RetBool then Result := TrueValue else Result := FalseValue ;
end;

//==============================================================================
//  입력된 문자여세 동일한 문자열이 있는지 검색한다.
//==============================================================================
function ExFindText ( const Value : String ; TextList : Array of string; UpperType : Boolean = False ) : Boolean;
var i        : integer;
    KeyValue : String ;
    function UpperTypeAction ( TempText : String ) : String ;
    begin
       if  UpperType then Result := UpperCase ( TempText ) else Result := TempText ;
    end;
begin
   Result   := False;
   KeyValue := UpperTypeAction ( Value );
   for i := Low ( TextList ) to High ( TextList ) do begin  // 배열의 시작부터 끝까지 루프를 반복한다.
       if  KeyValue = UpperTypeAction ( TextList[i] ) then begin // 배열의 루푸지점과 KEY 값이 일치하면 True 를 반환한뒤 종료한다.
           Result  := True; exit;
       end;

   end;
end;

//==============================================================================
//  카피와 동일한 문장이다. [ 양수 ] 입력시 Left Copy [ 음수 ] 입력시 Right Copy 한다.
//  Index 가 양수 이면 앞 자리수 부터 카피
//           음수 이면 뒤 자리수 부터 카피
//  Count 가 양수 이면 Index 지점부터 + 카운트 문자열
//           음수 이면 Index 지점부터 - 카운트 문자열
//==============================================================================
function ExCopyText ( Const Value : String ; Index , Count : Integer ) : String ;
begin
   Result := Value ;
   if  Index > 0 then begin
       if  Count > 0 then
           Result  := Copy ( Value , Index , Count  )
       else Result := Copy ( Value , ( Length( Value ) + 1 ) - ( Count  * -1 ) , ( Count  * -1 ));
   end else begin
       Result := Copy ( Value , ( Length( Value ) + 1 )-(Abs(Index)) , Abs(Index));
   end;
end;

//==============================================================================
//  문자열을 주고 해당 문자가열 특정 위치와 찾고자 하는 값이 포함되어 있는지 확인한다.
//==============================================================================
function ExCopyFind (  Const Value : String; Index , Count : Integer ; FindList : Array of String ; UpperType : Boolean = False ) : Boolean  ;
begin
   Result := ExFindText ( ExCopyText( Value , Index , Count ) , FindList  ,UpperType );
end;

//==============================================================================
//  일자를 받아 한들로 된 요일을 알려준다.
//==============================================================================
function ExWeekOfHan  ( Value : TDateTime = 0 ) : String ;
const DAYSWEEK_ARRAY : Array [1..7] of String = ('일','월','화','수','목','금','토');
begin
   if  Value = 0 then begin
       Result := DAYSWEEK_ARRAY [ DayOfWeek( Now ) ];
   end else
       Result := DAYSWEEK_ARRAY [ DayOfWeek(Value) ];
end;

//==============================================================================
//  ChkSum 구하는 함수
//==============================================================================
function ExStrToBcc ( Const Value : String ) : Word ;
var  i : integer;
    /// BccSum : WORD;
begin
   Result := Byte( Value[1] ) xor Byte( Value[2] ) ;
   for i := 3 to Length ( Value ) do begin
       Result := Result xor Byte ( Value[i] );
   end;

end;



//==============================================================================
// 문자열을 받아 대한민국 주민등록 번호와 일치하는지 검사한다.
//==============================================================================
function  ExPLicense( Const Value : String ) : Boolean ;
var i,Numb : integer;
    IdNumb : String ;
    Narray : Array [ 1..13 ] of Integer ;
begin
   Result := False ;
   IdNumb := ExNumbText( Value , 0 , True );
   if  Length ( IdNumb ) = 13 then begin
       for i := 1 to Length ( IdNumb ) do Narray[i] := StrToInt ( IdNumb[i] ) ;

       Numb := 11 - ( NArray[ 1] * 2 + NArray[ 2] * 3 + NArray[ 3] * 4 +
                      NArray[ 4] * 5 + NArray[ 5] * 6 + NArray[ 6] * 7 +
                      NArray[ 7] * 8 + NArray[ 8] * 9 + NArray[ 9] * 2 +
                      NArray[10] * 3 + NArray[11] * 4 + NArray[12] * 5 ) mod 11 ;
       Case Numb  of  10 : Numb := 0 ;  11 : Numb := 1 ;  end;
       if  Numb = Narray[13] then Result := True  else Result := False ;
   end;
end;

//==============================================================================
// 문자열을 받아 대한민국 사업자 번호와 일치하는지 검사한다.
//==============================================================================
function  ExCLicense( Const Value : String ) : Boolean ;
var i      : Integer ;
    ChNumb : integer;
    IdNumb , IdChar : String ;
begin
   Result := False ;
   IdNumb := ExNumbText( Value , 0 , True );
   ChNumb := 0;
   if  Length ( IdNumb ) = 10 then begin
       for i := 1 to Length ( IdNumb ) do begin
           Case i of
                1,4,7 : begin ChNumb := ChNumb + StrToInt ( IdNumb[i] );       end;
                2,5,8 : begin ChNumb := ChNumb + StrToInt ( IdNumb[i] ) * 3 ;  end;
                3  ,6 : begin ChNumb := ChNumb + StrToInt ( IdNumb[i] ) * 7 ;  end;
                    9 : begin IdChar := ExPlusText( '0' , -2 , StrToInt ( IdNumb[i] ) * 5 ) ;
                              ChNumb := ChNumb + StrToInt ( Copy ( IdChar ,1,1 ) ) +
                                                 StrToInt ( Copy ( IdChar ,2,1 ) ) ;
                        end;
           end;
       end;
       if  FloatToStr(  ( 10 - ChNumb mod 10 ) mod 10 ) = IdNumb[10] then Result := True ;
   end;
end;


function ExMinByte( A1 , B1 : Byte ): byte;
begin
   if A1 < B1 then Result := A1 else Result := B1;
end;


//==============================================================================
//  2개의 값중 큰값을 넘겨준다.
//==============================================================================
function ExMaxInteger(A1, B1: Longint): Longint;
begin
   if A1 > B1 then Result := A1  else Result := B1;
end;

//==============================================================================
//  2개의 값중 작은값을 넘겨준다.
//==============================================================================
function ExMinInteger(A1, B1: Longint): Longint;
begin
   if A1 < B1 then Result := A1 else Result := B1;
end;


// 특별문자 변환
function ExReplace(Source, FromStr, ToStr : String ): String;
var  before : String;
begin
  Result := StringReplace(Source, FromStr, ToStr, [rfReplaceAll, rfIgnoreCase]);
end;


end.

unit ExStrLib;

interface

uses SysUtils , Variants , Controls , StrUtils , Dialogs ,Classes , ExLibrary  ;


//==============================================================================
// 암호화에 사용되는 기본 키값
//==============================================================================
//const MYKEY_old  = 7756;  ENCKEY_old  = 9089;  DECKEY_old  = 1441;




   //---- 입력된 문자가 공백인지 확인하는 펑션
   function ExIsEmpty_old  ( Value  : String ): Boolean ; overload;
   function ExIsEmpty_old  ( Value  : String  ; Default : String  ): String ; overload;

   function ExLenSize  ( Value  : String ): Integer ; overload;
   function ExLenSize  ( Value  : String  ; LenSize : Byte    ) : Boolean; overload;

   function ExIsPairs  ( Pare1 , Pare2   : Variant   ; UpperType : Boolean = False ) : Boolean ;


   function ExNumbText_old ( value , Default : Variant   ; OnlyNumb  : Boolean = False  ) : String  ;

   function ExCommaStr ( Value : String  ; ValueSite : Integer ) : String ;
   function ExSqlQuery_old ( Value : String                        ) : String ;



   //function ExReturns  ( TrueValue , FalseValue : Integer ; RetBool : Boolean ) : Integer ; overload ;

   //----  문자 변환용 펑션
   function ExVarToStr_old ( Value : Variant; DefValue : String  = ''    ) : String  ;
   function ExVarToInt_old ( Value : Variant; DefValue : Integer = 0     ) : Integer ;
   function ExVarToDob_old ( Value : Variant; DefValue : Double  = 0     ) : Double  ;
   function ExVarToBol_old ( Value : Variant; DefValue : Boolean = False ) : Boolean ;
   function ExVarToWon_old ( Value : Variant; DefValue : Double  = 0     ) : String  ;
   //----
   function ExMakeText_old ( CharText : Char; TextSize : Integer  ) : String;
   function ExPlusText_old ( CharText : Char; TextSize : Integer  ; Value : Variant ) : String;

   function ExEncoding_old ( Const Value : String ; Key : Word = 7756 ) : String;
   function ExDecoding_old ( Const Value : String ; Key : Word = 7756 ) : String;




   function ExStrToSql_old ( Const Value : String ; StrWrite : Boolean ) : String; overload;
   function ExStrToSql_old ( Const Value : String ; DefIndex , RtlIndex : Integer ) : String; overload;
   function ExStrToSql_old ( Const Value : String ; TextArry : array of String                      ) : String; overload;
   function ExStrToSql_old ( Const Value : String ; TextArry : array of String;  SqlWrite : Boolean ) : String; overload;
   function ExStrToSql_old ( Const Value : String ; FromDate , Todate : TDateTime ) : String; overload;
   function ExStrToSql_old ( Const Value : String ; FromDate , Todate : TDateTime ; StrWrite : Boolean ) : String; overload;


   function ExChrToHex ( Const Value : Char ) : Byte ;
   function ExStrToHex ( Const Value : String ) : Byte ;

   

   function ExRanToKey ( KeySize : Byte = 4 ) : Integer  ;
   //function ExStrToEnc ( Const Value : string; Key : Word = MYKEY ) : String;
   //function ExStrToDec ( const Value : string; Key : Word = MYKEY ) : string;

   function ExDateTime ( const Value : String = 'YYYY-MM-DD HH:NN:SS' ) : String ;

   function ExStrToDateMask ( const Value : string ) : string;
   function ExStrToTimeMask ( const Value : string; CopyByte : Byte = 2) : string;


   function ExDayIndex ( DateText : String ) : String ;

//   function ExTextCopy ( Value : String ;  Index , Count : Integer ; HanCheck : Boolean = False ) : String ;

implementation




//==============================================================================
//  입력된 문자열이 공백인지 확인한다.   공백일 경우 참을 그렇지 않을 경우 거짓을 넘겨준다.
//==============================================================================
function ExIsEmpty_old ( Value  : String ) : Boolean; overload;
begin
   if  Trim( Value ) = '' then Result := True else Result := False ;
end;

//==============================================================================
//  입력된 문자열이 공백인지 확인한다.   공백일 경우 디폴트 값을 넘겨준다.
//==============================================================================
function ExIsEmpty_old( Value  : String; Default : String ) : String; overload;
begin
   if  Trim( Value ) = '' then Result := Default else Result := Value;
end;


//==============================================================================
//  문자열을 입력 받아 문자열의 사이즈를 넘겨준다.
//==============================================================================
function ExLenSize ( Value  : String  ) : Integer ; overload;
begin
   if  not ExIsEmpty_old ( Value  ) then begin
       Result := Length ( Trim ( Value ) ) ;
   end else Result := 0 ;
end;

//==============================================================================
//  문자열을 입력 받고 사이즈를 입력 받은뒤 문자열의 사이즈와 요청한 사이즈가 동일한지 비교한다.
//==============================================================================
function ExLenSize ( Value  : String ; LenSize : Byte  ) : Boolean; overload;
begin
   if  ExLenSize( Value ) = LenSize then Result := True else Result := False;
end;

//==============================================================================
//  두 문자가 동일한지 입력된 문자열이 공백인지 확인한다.   공백일 경우 참을 그렇지 않을 경우 거짓을 넘겨준다. ?
//==============================================================================
function ExIsPairs ( Pare1 , Pare2 : Variant; UpperType : Boolean = False ) : Boolean ;
begin
   if  UpperType then begin
       Result := ExIsPairs(UpperCase(VarToStr(Pare1)),Uppercase(VarToStr(Pare2)), False );
   end else if  Pare1 = Pare2 then Result := True else Result := False;
end;




//==============================================================================
//  가변형을 받아 숫자형 문자만 출력해 준다.
//==============================================================================
function ExNumbText_old  ( value , Default  : Variant; OnlyNumb : Boolean = False  ) : String  ;
var i  : Integer;
    IvBuff , RvBuff : String;
begin
   RvBuff := ''      ;
   Result := Default ;
   try IvBuff := VarToStr ( value ) ;
       if  not ExIsEmpty_old ( IvBuff ) then begin
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
//  두 문자가 동일한지 입력된 문자열이 공백인지 확인한다.   공백일 경우 참을 그렇지 않을 경우 거짓을 넘겨준다. ?
//==============================================================================
function ExCommaStr ( Value : String ; ValueSite : Integer ) : String ;
var StringList : TStringList ;
begin
   Result := '';
   if  not ExIsEmpty_old ( Value ) then begin
       StringList := TStringList.Create ;
       try StringList.Clear;
           try
               with StringList do begin
                    Clear;
                    CommaText := Value ;
                    if  (StringList.Count > 0) and (Count >= ValueSite) then begin
                        try Result := Strings[ValueSite-1] ;
                        except Result := '' end;
                    end;
               end;
           finally
               StringList.Free;
           end;
       except end;
   end;
end;

//==============================================================================
//  가변형을 받아 문자 형태로 넘겨준다.
//==============================================================================
function ExVarToStr_old ( Value : Variant; DefValue : String  = ''  ) : String  ;
begin
   Result := Defvalue ;
   try Result := VarToStr ( Value );
       if  Trim( Result) = '' then Result := DefValue;
   except Result := DefValue;end;
end;

//==============================================================================
//  가변형을 받아 문자 형태로 넘겨준다.
//==============================================================================
function ExVarToWon_old ( Value : Variant; DefValue : Double  = 0     ) : String  ;
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
//  가변형을 받아 숫자 형태로 넘겨준다.
//==============================================================================
function ExVarToInt_old ( Value : Variant; DefValue : Integer = 0     ) : Integer ;
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
function ExVarToDob_old ( Value : Variant; DefValue : Double  = 0     ) : Double  ;
begin
   try Result := StrToFloat( ExVarToStr ( Value , FloatToStr( DefValue ) ) );
   except Result := DefValue; end;
end;

//==============================================================================
//  가변형을 받아 블린 형태로 넘겨준다.
//==============================================================================
function ExVarToBol_old ( Value : Variant; DefValue : Boolean = False ) : Boolean ;
var TempText : String ;
begin
   try TempText := UpperCase ( Trim( ExVarToStr( Value , BoolToStr ( DefValue ) ) ) );
       Result   := ExFindText( TempText, [ 'Y' , 'YES' , 'T' , 'TRUE' , '1', '참' ] );
   except Result := DefValue; end;
end;

{
//==============================================================================
//  문자열을 받아 암호화 한다.
//==============================================================================
function ExStrToEnc ( Const Value : String; Key : Word = MYKEY ) : String;
var  i       : Byte;
     AscChar : Char;
     EncStr  , EncHex : string;
begin
   EncStr   := '';
   if  Key = 0 Then  Key := MYKEY;
   for i := 1 to Length( Value ) do begin
       EncStr := EncStr  + Char ( Byte ( Value [i] ) xor ( Key shr 8 ) );
       Key    := ( Byte ( EncStr [i] ) + Key ) * ENCKEY + DECKEY ;
   end;
   EncHex := '';
   for i := 1 to Length( EncStr ) do  begin  // 암호화된 이진 문자열을 ASCII 숫자로 변경
       AscChar := EncStr[i];
      // ShowMessage ( IntToStr ( Byte(  AscChar ) ) );
       EncHex := EncHex + IntToHex ( Byte(AscChar) , 2 ); // 한문자당 2자리씩
   end;
   Result := EncHex;
end;

//==============================================================================
//  암호화된 문자열을 해독한다.
//==============================================================================
function ExStrToDec ( const Value : string; Key : Word = MYKEY ) : string;
var  i       : Byte;
     HexStr  : Char ;
     DecStr  , DecAsc : string;
begin            //      ExHexToInt ( Const Value : Char ) : Byte ;
   DecAsc := ''; i := 1;
   repeat
      DecAsc := DecAsc + Char( ExChrToHex( Value[i] ) Shl 4  or ExChrToHex( Value[i+1]) )  ;
      i      := i + 2;
   until i > Length( Value );

   DecStr := '';
   if  Key = 0 Then  Key := MYKEY;
   for i := 1 to Length( DecAsc ) do begin
       DecStr := DecStr  + Char ( Byte ( DecAsc [i] ) xor ( Key shr 8 ) );
       Key    := ( Byte ( DecAsc [i] ) + Key ) * ENCKEY + DECKEY ;
   end;
   Result := DecStr;
end;

}

//   Char (  Copy( Value, i, 1 )  ) ;
//   HexStr :=   ( Byte ( Copy( Value, i, 1) )  shr 4 ) or Byte ( Copy( Value, i, 1) ) ;
//   Result := ( x Shl 4 ) or y ;
//   한문자당 3자리 숫자로 저장되어 있다
//   DecAsc := DecAsc + Chr( StrToIntDef ( HexStr, 0 ) ) ; // ASCII값을 구한다


//==============================================================================
//  랜덤으로 4자리 수를 받아온다.
//==============================================================================
function ExRanToKey ( KeySize : Byte = 4 ) : Integer  ;
var Buf : Integer ;
    key : String  ;
begin
   Key := IntToStr ( StrToInt( FormatDateTime( 'ZZZSS', now ))) ;
   repeat
      Buf := Random( 9 ) ;
      if  Buf <> 0 then Key := Key + IntToStr ( Buf ) ;
   until KeySize <= Length( Key );
   Result := StrToInt(Copy(Key,1,KeySize)) ;
end;

   {
   k := Random ( 9 ) ;
   repeat
      j := 0 ;
      i := StrToInt(FormatDateTime( 'SS', now )) + k ;
      repeat
          k := Random ( 9 ) ;
          if  k <> 0 then Inc( j ) ;
      until i <= j  ;
      Key := Key + IntToStr ( k ) ;
   until 4 <= Length( Key );
   Result := StrToInt(Key) ;
   }





   //Key := IntToStr ( StrToInt (  FormatDateTime ( 'SS', now )) );
   {
   repeat
      Buf := Copy( FormatDateTime ( 'ZZZ', now ),3,1);
      if  Buf <> '0' then begin
          StrToInt( Random(  9 ) );
          Key := Key + Buf ;
      end;
   until 4 <= Length( Key);
   }


//==============================================================================
//  문자열을 받아 암호화 한다.
//==============================================================================
function ExEncoding_old ( Const Value : String; Key : Word = MYKEY ) : String;
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
function ExDecoding_old ( const Value : string; Key : Word = MYKEY ) : string;
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
function ExMakeText_old ( CharText : Char; TextSize : Integer ) : String;
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
function ExPlusText_old ( CharText : Char; TextSize : Integer; Value : Variant ) : String;
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
//  한 문자열을 받아 받아 Hex 값으로 넘겨준다.
//==============================================================================
function ExChrToHex ( Const Value : Char ) : Byte ;
begin
   Case Value of
        '1'    : Result := $1;  '2'    : Result := $2;
        '3'    : Result := $3;  '4'    : Result := $4;
        '5'    : Result := $5;  '6'    : Result := $6;
        '7'    : Result := $7;  '8'    : Result := $8;
        '9'    : Result := $9;  'A','a': Result := $A;
        'B','b': Result := $B;  'C','c': Result := $C;
        'D','d': Result := $D;  'E','e': Result := $E;
        'F','f': Result := $F;
        else     Result := $0;
    end;
end;

//==============================================================================
//  2개의 문자를 문다 HEX 값으로 변형한다.
//==============================================================================
function ExStrToHex ( Const Value : String ) : Byte ;
begin
   Result := ( ExChrToHex( Value[1] ) Shl 4 ) or ExChrToHex( Value[2] ) ; //ExChrToHex( Value[1] );
end;

{
function ExHexToStr( Const Value : Byte ) : String ;
begin
   Result := ( ExChrToHex( Value[1] ) Shl 4 ) or ExChrToHex( Value[2] ) ; //ExChrToHex( Value[1] );
end;

function ExHexToStr( Const Value : Word ) : String ;
begin
   Result := ( ExChrToHex( Value[1] ) Shl 4 ) or ExChrToHex( Value[2] ) ; //ExChrToHex( Value[1] );
end;
}

   {
   if  Length(Value) = 1 then begin
   end;


//   Char '0'
   x := $0E ;
   y := $03 ;

   }

      {
                //DelSpace SQLSpaces
       function SqlDelSpace ( SqlStr : String ) : String;
    var TextSize : integer ;
        TempBuff : String ;
        CharBuff , TempChar : Char ;
        CharByte , LoopByte : Integer ;
    begin
       Result   := '' ;  TempBuff := '' ;
       CharBuff := ' ';  TempChar := ' ';
       CharByte := 0  ;  LoopByte := 0  ;
       TextSize := Length( SqlStr );
       while LoopByte <= TextSize do begin
             Inc(LoopByte);
             TempChar := CharBuff  ;
             CharBuff := SqlStr[LoopByte] ;
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
    end;
       }

function ExSqlQuery_old ( Value : String ) : String ;
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
function ExStrToSql_old ( Const Value : String ; TextArry : Array of String; SqlWrite : Boolean  ) : String; overload;
var i : Integer ;
    FlagBuff , TextBuff  : String ;
begin
   Result  := '' ;
   try FlagBuff := Trim ( UpperCase( TextArry[Low(TextArry)]) );
       if  SqlWrite and not ExIsEmpty_old ( FlagBuff ) then begin  //
           if  High ( TextArry ) > 0 then begin //  배열의 크기가 0보다 크면
               if  ExFindText( FlagBuff , ['FIX', 'NUM', 'AND', 'ORS', 'ORM', 'ORE', 'LIKE' , 'LLK' , 'RLK' ,'DLK' ] ) then begin
                   if  (FlagBuff = 'FIX') then begin
                       Result  := Value + QuotedStr ( TextArry[1] ) ;  // StrWrite 유무 관계없이 무조건 넣어준다. 고정값으로 판정
                   end else
                   if  not ExIsEmpty_old ( TextArry [1] ) then begin
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
                       if  not ExIsEmpty_old ( TextArry[1] ) then begin
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
               if  not ExIsEmpty_old( TextArry[0] ) and not ExIsEmpty_old(TextArry [1] )  then begin
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
function ExStrToSql_old ( Const Value : String ; TextArry : Array of String ) : String; overload;
begin
   Result := ExStrToSql_old ( Value , TextArry , True  ) ;
end;

//==============================================================================
//  Where 문장을 넣어준다.
//==============================================================================
function ExStrToSql_old ( Const Value : String ; StrWrite : Boolean ) : String; overload;
begin
   if  StrWrite then Result := Value  else Result := '';
end;

function ExStrToSql_old ( Const Value : String ; DefIndex , RtlIndex : Integer ) : String; overload;
begin
   Result := ExStrToSql_old ( Value , (DefIndex = RtlIndex) );
end;


//==============================================================================
//  Where 문장을 넣어준다.
//==============================================================================
function ExStrToSql_old ( Const Value : String ; FromDate , ToDate : TDateTime ) : String; overload;
begin
   Result   := Value + ' BETWEEN ''' + FormatDateTime( 'YYYY-MM-DD' , FromDate ) +
                         ''' AND ''' + FormatDateTime( 'YYYY-MM-DD' , ToDate   ) + ''' ' + #13#10 ;
end;

//==============================================================================
//  Where 문장을 넣어준다.
//==============================================================================
function ExStrToSql_old ( Const Value : String ; FromDate , ToDate : TDateTime ; StrWrite : Boolean ) : String; overload;
begin
   if  StrWrite then Result := ExStrToSql_old ( Value , FromDate , ToDate ) else Result := '';
end;


{
//==============================================================================
//  SQL 문장을 만든다.
//==============================================================================
function ExStrToSql ( var fSql , lSql : String ; Sqls , OSqls , Comma : String ) : String ;
begin
   Result :=
   if
end;
}



function ExDateTime ( const Value : String = 'YYYY-MM-DD HH:NN:SS') : String ;
begin
   Result := FormatDateTime ( Value , now ) ;
end;

//==============================================================================
//  시간을 이용하여 유일한 인덱스 번호를 만든다.
//==============================================================================
function ExDayIndex ( DateText : String ) : String ;
var TempByte : Byte   ;
    TempDate , TempBuff : String ;
begin
   TempBuff := Char( StrToInt( Copy( DateText,5,2) ) + 64 ) ;  // 월  MM
   TempByte :=       StrToInt( Copy( DateText,7,2) )        ;
   case TempByte of
        1..9 : TempBuff := TempBuff + Char( TempByte + 47 ) ;  // 일  DD
        else   TempBuff := TempBuff + Char( TempByte + 64 ) ;  // 일  DD
   end;
   Result := TempBuff ;
end;


// =============================================================================
// function fnHanChk (Str : String; Cnt : Integer) : String;
// 복사할 경우 마지막 자릿수에 한글이 올경우 마지막 한글자리에 공백으로대치하는 함수
// 인자설명 인자1:해당문자, 인자2:전체자릿수
// Return : 전체자릿수만큼 마자막자 특수문자면 Space로 대치함.
// =============================================================================
{
function ExHanToCopy ( BuffText : String; Cnt  : Integer) : String;
var i : Integer ;
    fText , rText : String ;
   j : Integer;
   mystr,Rc : String;
begin
   if  ( Length ( BuffText ) >= Cnt then begin




   end else Result := BuffText ;


   if( length( BuffText ) >=Cnt ) then begin
      mystr := copy(Str,1,Cnt);
      j := 1;
      while ( j <= Cnt ) do begin
         if isDBCSLeadByte(Byte(mystr[j])) then begin //첫바이트가 한글이면
            If j < Cnt Then begin
               Rc := Rc + copy( mystr,j ,2 );
            end Else begin
               Rc := Rc + ' ';
            End;
            j:=j+2;
         end else begin
             Rc := Rc + copy( mystr, j , 1 );
             j:=j+1;
         end;
      end;
      result := Rc;
   end else
      result := Str;
end;

}




//==============================================================================
//  문자열을 받아 데이트 형태로 만든다.
//==============================================================================
function ExStrToDateMask ( const Value : string ) : string;
var TempBuff : String ;
begin
   Result := '';
   TempBuff := ExNumbText  ( value , ''  , True ) ; // 숫자 타입의 문자열만 뽑아온다.
   if  not ExIsEmpty_old ( TempBuff ) then begin
       Result := format( '%4s-%2s-%2s' , [ Copy(TempBuff,1,4) , Copy(TempBuff,5,2) , Copy(TempBuff,7,2) ] );
   end;
end;

//==============================================================================
//  문자열을 받아 데이트 형태로 만든다.
//==============================================================================
function ExStrToTimeMask ( const Value : string;  CopyByte : Byte = 2 ) : string;
var NextByte : Integer ;
    TempBuff , CopyBuff : String ;
    MaskFlag , FullText : String ;
begin
   Result := '';
   NextByte := 1 ;
   TempBuff := ExNumbText  ( value , '' , True ) ;  // 숫자 타입의 문자열만 뽑아온다.
   repeat
      CopyBuff := Copy ( TempBuff , NextByte  , CopyByte ) ;
      if  not ExIsEmpty_old ( CopyBuff ) then begin
          FullText := FullText + MaskFlag + CopyBuff ;
          MaskFlag := ':';
      end;
      NextByte := NextByte + 2
   until ExIsEmpty_old ( CopyBuff ) ;
   Result := FullText ;
end;







{
//==============================================================================
//  문자열을 받아 참과 거짓일 때 문자열을 넘겨준다.
//==============================================================================
function ExRetToStr ( TrueValue , FalseValue : Integer;RetBool : Boolean ) : Integer ; overload ;
begin
   if  RetBool then Result := TrueValue else Result := FalseValue ;
end;
}

end.
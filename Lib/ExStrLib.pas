unit ExStrLib;

interface

uses SysUtils , Variants , Controls , StrUtils , Dialogs ,Classes , ExLibrary  ;


//==============================================================================
// ��ȣȭ�� ���Ǵ� �⺻ Ű��
//==============================================================================
//const MYKEY_old  = 7756;  ENCKEY_old  = 9089;  DECKEY_old  = 1441;




   //---- �Էµ� ���ڰ� �������� Ȯ���ϴ� ���
   function ExIsEmpty_old  ( Value  : String ): Boolean ; overload;
   function ExIsEmpty_old  ( Value  : String  ; Default : String  ): String ; overload;

   function ExLenSize  ( Value  : String ): Integer ; overload;
   function ExLenSize  ( Value  : String  ; LenSize : Byte    ) : Boolean; overload;

   function ExIsPairs  ( Pare1 , Pare2   : Variant   ; UpperType : Boolean = False ) : Boolean ;


   function ExNumbText_old ( value , Default : Variant   ; OnlyNumb  : Boolean = False  ) : String  ;

   function ExCommaStr ( Value : String  ; ValueSite : Integer ) : String ;
   function ExSqlQuery_old ( Value : String                        ) : String ;



   //function ExReturns  ( TrueValue , FalseValue : Integer ; RetBool : Boolean ) : Integer ; overload ;

   //----  ���� ��ȯ�� ���
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
//  �Էµ� ���ڿ��� �������� Ȯ���Ѵ�.   ������ ��� ���� �׷��� ���� ��� ������ �Ѱ��ش�.
//==============================================================================
function ExIsEmpty_old ( Value  : String ) : Boolean; overload;
begin
   if  Trim( Value ) = '' then Result := True else Result := False ;
end;

//==============================================================================
//  �Էµ� ���ڿ��� �������� Ȯ���Ѵ�.   ������ ��� ����Ʈ ���� �Ѱ��ش�.
//==============================================================================
function ExIsEmpty_old( Value  : String; Default : String ) : String; overload;
begin
   if  Trim( Value ) = '' then Result := Default else Result := Value;
end;


//==============================================================================
//  ���ڿ��� �Է� �޾� ���ڿ��� ����� �Ѱ��ش�.
//==============================================================================
function ExLenSize ( Value  : String  ) : Integer ; overload;
begin
   if  not ExIsEmpty_old ( Value  ) then begin
       Result := Length ( Trim ( Value ) ) ;
   end else Result := 0 ;
end;

//==============================================================================
//  ���ڿ��� �Է� �ް� ����� �Է� ������ ���ڿ��� ������� ��û�� ����� �������� ���Ѵ�.
//==============================================================================
function ExLenSize ( Value  : String ; LenSize : Byte  ) : Boolean; overload;
begin
   if  ExLenSize( Value ) = LenSize then Result := True else Result := False;
end;

//==============================================================================
//  �� ���ڰ� �������� �Էµ� ���ڿ��� �������� Ȯ���Ѵ�.   ������ ��� ���� �׷��� ���� ��� ������ �Ѱ��ش�. ?
//==============================================================================
function ExIsPairs ( Pare1 , Pare2 : Variant; UpperType : Boolean = False ) : Boolean ;
begin
   if  UpperType then begin
       Result := ExIsPairs(UpperCase(VarToStr(Pare1)),Uppercase(VarToStr(Pare2)), False );
   end else if  Pare1 = Pare2 then Result := True else Result := False;
end;




//==============================================================================
//  �������� �޾� ������ ���ڸ� ����� �ش�.
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
//  �� ���ڰ� �������� �Էµ� ���ڿ��� �������� Ȯ���Ѵ�.   ������ ��� ���� �׷��� ���� ��� ������ �Ѱ��ش�. ?
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
//  �������� �޾� ���� ���·� �Ѱ��ش�.
//==============================================================================
function ExVarToStr_old ( Value : Variant; DefValue : String  = ''  ) : String  ;
begin
   Result := Defvalue ;
   try Result := VarToStr ( Value );
       if  Trim( Result) = '' then Result := DefValue;
   except Result := DefValue;end;
end;

//==============================================================================
//  �������� �޾� ���� ���·� �Ѱ��ش�.
//==============================================================================
function ExVarToWon_old ( Value : Variant; DefValue : Double  = 0     ) : String  ;
const Suh : Array [1..9] of String = ( '��','��','��','��','��','��','ĥ','��','��');
      won : Array [1..9] of String = ( ''  ,'��','��','õ','��','��','��','õ','��');
var TempBuff : Double ;
    TempText : String;
    TextSize , TextSite , TextNumb : Integer  ;
begin
   TempBuff := ExVarToDob(  Value , 0 ) ;
   if  ( TempBuff > 0 ) and ( TempBuff < 1000000000 ) then begin
       TempText := ExNumbText( TempBuff  ,0  , True ) ;
       Result   :='��_';
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
      Result := Result +'����';
   end else Result := '?';
end;

//==============================================================================
//  �������� �޾� ���� ���·� �Ѱ��ش�.
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
//  �������� �޾� �Ǽ� ���·� �Ѱ��ش�.
//==============================================================================
function ExVarToDob_old ( Value : Variant; DefValue : Double  = 0     ) : Double  ;
begin
   try Result := StrToFloat( ExVarToStr ( Value , FloatToStr( DefValue ) ) );
   except Result := DefValue; end;
end;

//==============================================================================
//  �������� �޾� �� ���·� �Ѱ��ش�.
//==============================================================================
function ExVarToBol_old ( Value : Variant; DefValue : Boolean = False ) : Boolean ;
var TempText : String ;
begin
   try TempText := UpperCase ( Trim( ExVarToStr( Value , BoolToStr ( DefValue ) ) ) );
       Result   := ExFindText( TempText, [ 'Y' , 'YES' , 'T' , 'TRUE' , '1', '��' ] );
   except Result := DefValue; end;
end;

{
//==============================================================================
//  ���ڿ��� �޾� ��ȣȭ �Ѵ�.
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
   for i := 1 to Length( EncStr ) do  begin  // ��ȣȭ�� ���� ���ڿ��� ASCII ���ڷ� ����
       AscChar := EncStr[i];
      // ShowMessage ( IntToStr ( Byte(  AscChar ) ) );
       EncHex := EncHex + IntToHex ( Byte(AscChar) , 2 ); // �ѹ��ڴ� 2�ڸ���
   end;
   Result := EncHex;
end;

//==============================================================================
//  ��ȣȭ�� ���ڿ��� �ص��Ѵ�.
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
//   �ѹ��ڴ� 3�ڸ� ���ڷ� ����Ǿ� �ִ�
//   DecAsc := DecAsc + Chr( StrToIntDef ( HexStr, 0 ) ) ; // ASCII���� ���Ѵ�


//==============================================================================
//  �������� 4�ڸ� ���� �޾ƿ´�.
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
//  ���ڿ��� �޾� ��ȣȭ �Ѵ�.
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
   for i := 1 to Length( EncStr ) do  begin  // ��ȣȭ�� ���� ���ڿ��� ASCII ���ڷ� ����
       AscChar := EncStr[i];
       EncAsc := EncAsc + format('%.3d', [Ord(AscChar)]); // �ѹ��ڴ� 3�ڸ���
   end;
   Result := EncAsc;
end;

//==============================================================================
//  ��ȣȭ�� ���ڿ��� �޾� ��ȣ�� �����Ѵ�.
//==============================================================================
function ExDecoding_old ( const Value : string; Key : Word = MYKEY ) : string;
var  i       : Byte;
     AscStr  : string;
     DecStr  , DecAsc : string;
begin
   DecAsc := ''; i := 1;
   repeat
      AscStr := Copy( Value, i, 3);                         // �ѹ��ڴ� 3�ڸ� ���ڷ� ����Ǿ� �ִ�
      DecAsc := DecAsc + Chr( StrToIntDef ( AscStr, 0 ) ) ; // ASCII���� ���Ѵ�
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
//  Ư�� ĳ���͸� �޾� �Է� ���� �� ��ŭ�� ���ڿ��� ����� �ش�.
//  Ư�� ���ڷ� �̷���� ���ڿ��� ���鶧 ����Ѵ�.
//  ex ( 5 , C ) = 'CCCCC'    ���� ( 4 , '0' ) = '0000'
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
// ���ڿ� �ڸ����� �޾� �ڸ��� ��ŭ�� �� ���ڿ��� ����� �ִ� �Լ� ( 0���� ä�� )
// �׻� ������ �ڸ��� ��ŭ�� ���ڿ��� ����Ҷ� ����Ѵ�.
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
//  �� ���ڿ��� �޾� �޾� Hex ������ �Ѱ��ش�.
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
//  2���� ���ڸ� ���� HEX ������ �����Ѵ�.
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
             if  CharBuff = ' ' then begin        // ���ڸ��� ������ �����̸�
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
             if  CharBuff = ' ' then begin        // ���ڸ��� ������ �����̸�
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
//  Where ������ �־��ش�.
//==============================================================================
function ExStrToSql_old ( Const Value : String ; TextArry : Array of String; SqlWrite : Boolean  ) : String; overload;
var i : Integer ;
    FlagBuff , TextBuff  : String ;
begin
   Result  := '' ;
   try FlagBuff := Trim ( UpperCase( TextArry[Low(TextArry)]) );
       if  SqlWrite and not ExIsEmpty_old ( FlagBuff ) then begin  //
           if  High ( TextArry ) > 0 then begin //  �迭�� ũ�Ⱑ 0���� ũ��
               if  ExFindText( FlagBuff , ['FIX', 'NUM', 'AND', 'ORS', 'ORM', 'ORE', 'LIKE' , 'LLK' , 'RLK' ,'DLK' ] ) then begin
                   if  (FlagBuff = 'FIX') then begin
                       Result  := Value + QuotedStr ( TextArry[1] ) ;  // StrWrite ���� ������� ������ �־��ش�. ���������� ����
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
//  Where ������ �־��ش�.
//==============================================================================
function ExStrToSql_old ( Const Value : String ; TextArry : Array of String ) : String; overload;
begin
   Result := ExStrToSql_old ( Value , TextArry , True  ) ;
end;

//==============================================================================
//  Where ������ �־��ش�.
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
//  Where ������ �־��ش�.
//==============================================================================
function ExStrToSql_old ( Const Value : String ; FromDate , ToDate : TDateTime ) : String; overload;
begin
   Result   := Value + ' BETWEEN ''' + FormatDateTime( 'YYYY-MM-DD' , FromDate ) +
                         ''' AND ''' + FormatDateTime( 'YYYY-MM-DD' , ToDate   ) + ''' ' + #13#10 ;
end;

//==============================================================================
//  Where ������ �־��ش�.
//==============================================================================
function ExStrToSql_old ( Const Value : String ; FromDate , ToDate : TDateTime ; StrWrite : Boolean ) : String; overload;
begin
   if  StrWrite then Result := ExStrToSql_old ( Value , FromDate , ToDate ) else Result := '';
end;


{
//==============================================================================
//  SQL ������ �����.
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
//  �ð��� �̿��Ͽ� ������ �ε��� ��ȣ�� �����.
//==============================================================================
function ExDayIndex ( DateText : String ) : String ;
var TempByte : Byte   ;
    TempDate , TempBuff : String ;
begin
   TempBuff := Char( StrToInt( Copy( DateText,5,2) ) + 64 ) ;  // ��  MM
   TempByte :=       StrToInt( Copy( DateText,7,2) )        ;
   case TempByte of
        1..9 : TempBuff := TempBuff + Char( TempByte + 47 ) ;  // ��  DD
        else   TempBuff := TempBuff + Char( TempByte + 64 ) ;  // ��  DD
   end;
   Result := TempBuff ;
end;


// =============================================================================
// function fnHanChk (Str : String; Cnt : Integer) : String;
// ������ ��� ������ �ڸ����� �ѱ��� �ð�� ������ �ѱ��ڸ��� �������δ�ġ�ϴ� �Լ�
// ���ڼ��� ����1:�ش繮��, ����2:��ü�ڸ���
// Return : ��ü�ڸ�����ŭ ���ڸ��� Ư�����ڸ� Space�� ��ġ��.
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
         if isDBCSLeadByte(Byte(mystr[j])) then begin //ù����Ʈ�� �ѱ��̸�
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
//  ���ڿ��� �޾� ����Ʈ ���·� �����.
//==============================================================================
function ExStrToDateMask ( const Value : string ) : string;
var TempBuff : String ;
begin
   Result := '';
   TempBuff := ExNumbText  ( value , ''  , True ) ; // ���� Ÿ���� ���ڿ��� �̾ƿ´�.
   if  not ExIsEmpty_old ( TempBuff ) then begin
       Result := format( '%4s-%2s-%2s' , [ Copy(TempBuff,1,4) , Copy(TempBuff,5,2) , Copy(TempBuff,7,2) ] );
   end;
end;

//==============================================================================
//  ���ڿ��� �޾� ����Ʈ ���·� �����.
//==============================================================================
function ExStrToTimeMask ( const Value : string;  CopyByte : Byte = 2 ) : string;
var NextByte : Integer ;
    TempBuff , CopyBuff : String ;
    MaskFlag , FullText : String ;
begin
   Result := '';
   NextByte := 1 ;
   TempBuff := ExNumbText  ( value , '' , True ) ;  // ���� Ÿ���� ���ڿ��� �̾ƿ´�.
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
//  ���ڿ��� �޾� ���� ������ �� ���ڿ��� �Ѱ��ش�.
//==============================================================================
function ExRetToStr ( TrueValue , FalseValue : Integer;RetBool : Boolean ) : Integer ; overload ;
begin
   if  RetBool then Result := TrueValue else Result := FalseValue ;
end;
}

end.
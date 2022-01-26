unit ExLibrary;

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
  SidoTo : array[1..23] of String = (
          '����' ,//  0
          '���' ,//  1
          '�泲' ,//  2
          '�泲' ,//  3
          '���' ,//  4
          '���' ,//  5
          '����' ,//  6
          '�뱸' ,//  7
          '����' ,//  8
          '�λ�' ,//  9
          '����' ,//  0
          '����' ,//  1
          '���' ,//  2
          '��õ' ,//  3
          '����' ,//  4
          '����' ,//  5
          '����' ,//  6
          '����' ,//  7
          '����' ,//  8
          '�泲' ,//  9
          '�泲' ,//  0
          '���' ,//  1
          '���'  //  2
          );
  SidoFrom : array[1..23] of String = (
          '����'  ,//  0
          '���'  ,//  1
          '�泲'  ,//  2
          '���',//  3
          '���'  ,//  4
          '����',//  5
          '����'  ,//  6
          '�뱸'  ,//  7
          '����'  ,//  8
          '�λ�'  ,//  9
          '����'  ,//  0
          '����'  ,//  1
          '���'  ,//  2
          '��õ'  ,//  3
          '����'  ,//  4
          '����',//  5
          '����'  ,//  6
          '�����',//  7
          '����'  ,//  8
          '�泲'  ,//  9
          '��û��',//  0
          '���'  ,//  1
          '��û��' //  2
          );

{
    //        �Է¹��� ���ڿ��� ���̸� ���Ѵ�.
    function  ExLen( Value : String ) : Integer ; overload;
    //        �Է¹��� ���ڿ��� ���̰� LonSize �� ������ Ȯ���ѵ� ����� �Ѱ��ش�.
    function  ExLen( Value : String ; LenSize : Byte  ) : Boolean; overload;
    //        �Է� ���� X �� N ��ŭ ���� �ѵ� ���� �Ѱ��ش�.
    function  ExInc( var X : Integer ; N : Integer = 1 ; Action : Boolean = True) : Integer ;
    //        �Է� ���� X �� N ��ŭ ���� �ѵ� ���� �Ѱ��ش�.
    function  ExDec( var X : Integer ; N : Integer = 1 ; Action : Boolean = True) : Integer ;
    //        Round ������ ���忡 ������ �־� �����Ͽ� �����
    }
//    function  ExRound (Value : Extended ) : Int64 ;
//    function  ExFloor (Value : Extended ) : Int64 ;


    //        �Էµ� ���ڰ� �������� Ȯ���ϴ� ���
    function  ExIsEmpty  ( Value  : String ): Boolean ; overload;
    //        �Էµ� ���ڰ� �����̸� ����Ʈ ���� �Ѱ��ش�.
    function  ExIsEmpty  ( Value  : String  ; Default : String  ): String ; overload;
    //        �Է� ���� ���ڰ� 0 �̸� ����Ʈ ���� �Ѱ��ش�.
    function  ExIsZero( Value  : Integer; Default : Integer ) : Integer ;
    //
    function  ExMakeText ( CharText : Char; TextSize : Integer  ) : String;
    //
    function  ExPlusText ( CharText : Char; TextSize : Integer  ; Value : Variant ) : String;
    //        ���ڿ��� ��ȣȭ ó�� �Ѵ�.
    function  ExEncoding ( Const Value : String ; Key : Word = MYKEY ) : String;
    //        ���ڿ��� ��ȣȭ ���� �Ѵ�.
    function  ExDecoding ( Const Value : String ; Key : Word = MYKEY ) : String;
    //        ���ڿ��� �޾� �ѹ��� �ʵ带 �Ѱ��ش�.
    function  ExNumbText ( value , Default : Variant   ; OnlyNumb  : Boolean = False  ) : String  ;
    //        ���� ��ȯ�� ���
    function  ExVarToStr ( Value : Variant; DefValue : String  = ''    ) : String  ;
    function  ExVarToInt ( Value : Variant; DefValue : Integer = 0     ) : Integer ;
    function  ExVarToDob ( Value : Variant; DefValue : Double  = 0     ) : Double  ;
    function  ExVarToBol ( Value : Variant; DefValue : Boolean = False ) : Boolean ;
    function  ExVarToWon ( Value : Variant; DefValue : Double  = 0     ) : String  ;
    //        ���ڿ��� �޾� �����̽��� ���� �Ѵ�.
    function  ExSqlSpace ( Const Value : String ) : String ;

    function  ExStrToSql ( Const Value : String ; StrWrite : Boolean ) : String; overload;
    function  ExStrToSql ( Const Value : String ; DefIndex , RtlIndex : Integer ) : String; overload;
    function  ExStrToSql ( Const Value : String ; TextArry : array of String                      ) : String; overload;
    function  ExStrToSql ( Const Value : String ; TextArry : array of String;  SqlWrite : Boolean ) : String; overload;
    function  ExStrToSql ( Const Value : String ; FromDate , Todate : TDateTime ) : String; overload;
    function  ExStrToSql ( Const Value : String ; FromDate , Todate : TDateTime ; StrWrite : Boolean ) : String; overload;

    //        Ư�� ���� �Է¹ް� �迭���� ����� ���� ���ڸ� ã�� ����� �Ѱ��ش�.
    //        ���� ���� ���ڸ� ã�� ���ϸ� ó�� ���� �Ѱ��ش�.
    function  ExNextByte ( Value : Integer; LoopValue : array of Integer ) : Integer ;
    //        �� ���ڿ��� �Է� �޾� ���̸� ���� ���ڿ��� �����̸� �� ���ڿ��� �Ѱ��ش�.
    function  ExRetToStr ( TrueValue , FalseValue : String  ; RetBool : Boolean ) : String; overload;
    //        �� ���ڸ� �Է� �޾� ���̸� ���� ���ڿ��� �����̸� �� ���ڿ��� �Ѱ��ش�.
    function  ExRetToInt ( TrueValue , FalseValue : Integer ; RetBool : Boolean ) : Integer; overload;
    //        �� ���ڿ��� �Է� �޾� ���̸� ���� ���ڿ��� �����̸� �� ���ڿ��� �Ѱ��ش�.
    function  ExRetToVar ( TrueValue , FalseValue : Variant ; RetBool : Boolean ) : Variant; overload;

    //        �� ���ڿ��� �Է� �޾� �迭�� �Էµ� ���ڰ� �ִ��� Ȯ�� �Ͽ� ���� ������ �Ѱ��ش�.
    function  ExFindText ( Const Value : String ; TextList : array of string; UpperType : Boolean = False ) : Boolean;
    //
    function  ExCopyText ( Const Value : String ; Index , Count : Integer ) : String ;
    //
    function  ExCopyFind ( Const Value : String;  Index , Count : Integer ; FindList : Array of String ; UpperType : Boolean = False ) : Boolean  ;
    //        ���ڸ� �Է� �޾� �ѱ۷� ǥ��� ������ �Ѱ��ش�.
    function  ExWeekOfHan  ( Value : TDateTime=0) : String ;
    //        üũ���� ���Ѵ�.
    function  ExStrToBcc ( Const Value : String ) : Word ;
    //        �ֹ� ��� ��ȣ�� �˻� �Ѵ�.
    function  ExPLicense ( Const Value : String ) : Boolean ;
              //ExStringList;
    //        ��� ��ȣ�� �˻� �Ѵ�.
    function  ExCLicense( Const Value : String ) : Boolean ;


    // 2���� ����Ʈ�� �޾� ���� ���� ���� ���Ѵ�.
    function ExMinByte( A1 , B1 : Byte ): byte;
///    function ExMinByte ( Value : Array of Byte  ): byte;
    // 2���� �޾� ���� ���� ���� ���Ѵ�.
    function ExMaxInteger( A1 , B1 : Longint ): Longint;
    // 2���� �޾� ���� ���� ���� ���Ѵ�.
    function ExMinInteger( A1 , B1 : Longint ): Longint;
    // Ư������ ��ȯ
    function ExReplace( Source, FromStr, ToStr : String ): String;

    // ��ü�ּҸ� �޾� �õ�,�ñ���, ���鵿, ���ּҷ� �и� �Ѵ�.
    function ExAddressSplite( Source: String ): addrRecord;

    // �õ��� ª���õ�2�ڸ��� �����.
    function ExAddressSidoShort( Source: String ): String;

    // Ư������ ��ȯ
    //function ExReplace(Source, FromStr, ToStr : String ): String;
    //function ExReplace(Source, FromStr, ToStr : String ): String;


    //       ������ ROUND �� ������ �־� �ҽ� ����� �����
    //       �����̿����� ��ũ ���� ���¸� ����


{function Myround(Value : Extended): Int64;
var
  TempVal : Int64;
begin
  Result := round(Value);
  Temp := Trunc(Value);
  if (Value - TempVal) = 0.5 then Result := TempVal + 1
  else if (Value - TempVal) = -0.5 then Result := TempVal;
end;
   }


implementation


{
//==============================================================================
//  ���ڿ��� �Է� �޾� ���ڿ��� ����� �Ѱ��ش�.
//==============================================================================
function  ExLen( Value : String ) : Integer ;
begin
   if  not ExIsEmpty ( Value ) then Result := Length ( Trim( Value ) ) else Result := 0 ;
end;

//==============================================================================
//  �Է� ���� ���ڿ��� ���̿� �Էµ� ����� ������ ���� �Ѱ��ش�.
//==============================================================================
function  ExLen( Value  : String  ; LenSize : Byte  ) : Boolean;
begin
   if  ExLen( Value ) = LenSize then Result := True else Result := False;
end;


}
//==============================================================================
//  ������ ����ŭ �����Ѵ�.
//==============================================================================
function ExtInc( var X : Integer ; N : Integer = 1; Action : Boolean = True ) : Integer ;
begin
   if  Action then
       Inc( X , N );
   Result := X ;
end;

//==============================================================================
//  ������ ����ŭ �����Ѵ�.
//==============================================================================
function ExtDec( var X : Integer ; N : Integer = 1 ; Action : Boolean = True) : Integer ;
begin
   if  Action then
       Dec( X , N );
   Result := X ;
end;



//==============================================================================
//        ������ Round ������ �־� �����Ͽ� �����
//==============================================================================
function  ExRound (Value : Extended) : Int64 ;
begin
   Result := Trunc(Value) + Trunc(Frac(Value)*2);
end;

//==============================================================================
//        ������ Round ������ �־� �����Ͽ� �����
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
//  �Էµ� ���ڿ��� �������� Ȯ���Ѵ�.   ������ ��� ���� �׷��� ���� ��� ������ �Ѱ��ش�.
//==============================================================================
function ExIsEmpty ( Value  : String ) : Boolean;
begin
   if  Trim( Value ) = '' then Result := True else Result := False ;
end;

//==============================================================================
//  �Էµ� ���ڿ��� �������� Ȯ���Ѵ�.   ������ ��� ����Ʈ ���� �Ѱ��ش�.
//==============================================================================
function ExIsEmpty( Value  : String; Default : String ) : String;
begin
   if  Trim( Value ) = '' then Result := Default else Result := Value;
end;


//==============================================================================
//  �Էµ� ���ڰ� 0 �̸� ����Ʈ ���� �Ѱ��ش�.
//==============================================================================
function ExIsZero( Value  : Integer; Default : Integer ) : Integer ;
begin
   if  Value = 0 then Result := Default else Result := Value;
end;


//==============================================================================
//  ���ڿ��� �޾� ��ȣȭ �Ѵ�.
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
   for i := 1 to Length( EncStr ) do  begin  // ��ȣȭ�� ���� ���ڿ��� ASCII ���ڷ� ����
       AscChar := EncStr[i];
       EncAsc := EncAsc + format('%.3d', [Ord(AscChar)]); // �ѹ��ڴ� 3�ڸ���
   end;
   Result := EncAsc;
end;

//==============================================================================
//  ��ȣȭ�� ���ڿ��� �޾� ��ȣ�� �����Ѵ�.
//==============================================================================
function ExDecoding ( const Value : string; Key : Word = MYKEY ) : string;

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
// ���ڿ� �ڸ����� �޾� �ڸ��� ��ŭ�� �� ���ڿ��� ����� �ִ� �Լ� ( 0���� ä�� )
// �׻� ������ �ڸ��� ��ŭ�� ���ڿ��� ����Ҷ� ����Ѵ�.
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
//  �������� �޾� ������ ���ڸ� ����� �ش�.
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
//  �������� �޾� ���� ���·� �Ѱ��ش�.
//==============================================================================
function ExVarToStr ( Value : Variant; DefValue : String  = ''  ) : String  ;
begin
   Result := Defvalue ;
   try Result := VarToStr ( Value );
       if  Trim( Result) = '' then Result := DefValue;
   except Result := DefValue;end;
end;


//==============================================================================
//  �������� �޾� ���� ���·� �Ѱ��ش�.
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
//  �������� �޾� �Ǽ� ���·� �Ѱ��ش�.
//==============================================================================
function ExVarToDob ( Value : Variant; DefValue : Double  = 0     ) : Double  ;
begin
   try Result := StrToFloat( ExVarToStr ( Value , FloatToStr( DefValue ) ) );
   except Result := DefValue; end;
end;

//==============================================================================
//  �������� �޾� �� ���·� �Ѱ��ش�.
//==============================================================================
function ExVarToBol ( Value : Variant; DefValue : Boolean = False ) : Boolean ;
var TempText : String ;
begin
   try TempText := UpperCase ( Trim( ExVarToStr( Value , BoolToStr ( DefValue ) ) ) );
       Result   := ExFindText( TempText, [ 'Y' , 'YES' , 'T' , 'TRUE' , '1', '��' ] );
   except Result := DefValue; end;
end;

//==============================================================================
//  �������� �޾� ���� ���·� �Ѱ��ش�.
//==============================================================================
function ExVarToWon ( Value : Variant; DefValue : Double  = 0     ) : String  ;
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
function ExStrToSql ( Const Value : String ; TextArry : Array of String; SqlWrite : Boolean  ) : String; overload;
var i : Integer ;
    FlagBuff , TextBuff  : String ;
begin
   Result  := '' ;
   try FlagBuff := Trim ( UpperCase( TextArry[Low(TextArry)]) );
       if  SqlWrite and not ExIsEmpty ( FlagBuff ) then begin  //
           if  High ( TextArry ) > 0 then begin //  �迭�� ũ�Ⱑ 0���� ũ��
               if  ExFindText( FlagBuff , ['FIX', 'NUM', 'AND', 'ORS', 'ORM', 'ORE', 'LIKE' , 'LLK' , 'RLK' ,'DLK' ] ) then begin
                   if  (FlagBuff = 'FIX') then begin
                       Result  := Value + QuotedStr ( TextArry[1] ) ;  // StrWrite ���� ������� ������ �־��ش�. ���������� ����
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
//  Where ������ �־��ش�.
//==============================================================================
function ExStrToSql ( Const Value : String ; TextArry : Array of String ) : String; overload;
begin
   Result := ExStrToSql ( Value , TextArry , True  ) ;
end;

//==============================================================================
//  Where ������ �־��ش�.
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
//  Where ������ �־��ش�.
//==============================================================================
function ExStrToSql ( Const Value : String ; FromDate , ToDate : TDateTime ) : String; overload;
begin
   Result   := Value + ' BETWEEN ''' + FormatDateTime( 'YYYY-MM-DD' , FromDate ) +
                         ''' AND ''' + FormatDateTime( 'YYYY-MM-DD' , ToDate   ) + ''' ' + #13#10 ;
end;

//==============================================================================
//  Where ������ �־��ش�.
//==============================================================================
function ExStrToSql ( Const Value : String ; FromDate , ToDate : TDateTime ; StrWrite : Boolean ) : String; overload;
begin
   if  StrWrite then Result := ExStrToSql ( Value , FromDate , ToDate ) else Result := '';
end;



//==============================================================================
// Ư�� ���� �Է¹ް� �迭���� ����� ���� ���ڸ� ã�� ����� �Ѱ��ش�.
// ���� ���� ���ڸ� ã�� ���ϸ� ó�� ���� �Ѱ��ش�.
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
//  ���ڿ��� �޾� ���� ������ �� ���ڿ��� �Ѱ��ش�.
//==============================================================================
function ExRetToStr ( TrueValue , FalseValue : String  ; RetBool : Boolean ) : String  ;
begin
   if  RetBool then Result := TrueValue else Result := FalseValue ;
end;

//==============================================================================
//  ���ڿ��� �޾� ���� ������ �� ���ڿ��� �Ѱ��ش�.
//==============================================================================
function ExRetToInt ( TrueValue , FalseValue : Integer  ; RetBool : Boolean ) : Integer  ;
begin
   if  RetBool then Result := TrueValue else Result := FalseValue ;
end;


//==============================================================================
//  ���ڿ��� �޾� ���� ������ �� ���ڿ��� �Ѱ��ش�.
//==============================================================================
function  ExRetToVar ( TrueValue , FalseValue : Variant ; RetBool : Boolean ) : Variant;
begin
   if  RetBool then Result := TrueValue else Result := FalseValue ;
end;

//==============================================================================
//  �Էµ� ���ڿ��� ������ ���ڿ��� �ִ��� �˻��Ѵ�.
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
   for i := Low ( TextList ) to High ( TextList ) do begin  // �迭�� ���ۺ��� ������ ������ �ݺ��Ѵ�.
       if  KeyValue = UpperTypeAction ( TextList[i] ) then begin // �迭�� ��Ǫ������ KEY ���� ��ġ�ϸ� True �� ��ȯ�ѵ� �����Ѵ�.
           Result  := True; exit;
       end;

   end;
end;

//==============================================================================
//  ī�ǿ� ������ �����̴�. [ ��� ] �Է½� Left Copy [ ���� ] �Է½� Right Copy �Ѵ�.
//  Index �� ��� �̸� �� �ڸ��� ���� ī��
//           ���� �̸� �� �ڸ��� ���� ī��
//  Count �� ��� �̸� Index �������� + ī��Ʈ ���ڿ�
//           ���� �̸� Index �������� - ī��Ʈ ���ڿ�
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
//  ���ڿ��� �ְ� �ش� ���ڰ��� Ư�� ��ġ�� ã���� �ϴ� ���� ���ԵǾ� �ִ��� Ȯ���Ѵ�.
//==============================================================================
function ExCopyFind (  Const Value : String; Index , Count : Integer ; FindList : Array of String ; UpperType : Boolean = False ) : Boolean  ;
begin
   Result := ExFindText ( ExCopyText( Value , Index , Count ) , FindList  ,UpperType );
end;

//==============================================================================
//  ���ڸ� �޾� �ѵ�� �� ������ �˷��ش�.
//==============================================================================
function ExWeekOfHan  ( Value : TDateTime = 0 ) : String ;
const DAYSWEEK_ARRAY : Array [1..7] of String = ('��','��','ȭ','��','��','��','��');
begin
   if  Value = 0 then begin
       Result := DAYSWEEK_ARRAY [ DayOfWeek( Now ) ];
   end else
       Result := DAYSWEEK_ARRAY [ DayOfWeek(Value) ];
end;

//==============================================================================
//  ChkSum ���ϴ� �Լ�
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


{
//==============================================================================
//  Hex ���� �ؽ�Ʈ ���·� �ٲ��ش�.
//==============================================================================
function ExHexToHex ( HexByte : Byte; ResultSize : Byte = 4  ) : String ; overload;
begin
   Result := IntToHex ( HexByte  ,  ResultSize )  ;
end;
}

{
//==============================================================================
//  HEX ������ �ؽ�Ʈ�� �޾� Hex���·� �ٲ��ش�.
//==============================================================================
function ExHexToHex ( HexText : String ) : Byte ; overload;
//var ix , iy : Char ;
   // ix , iy : Char ;
begin
 // Str :=  ( x Shl 4 ) or y  );
//     ExStrToHex
end;
}
{
//==============================================================================
//  2���� ���Ͽ� ū ���� �Ѱ��ش�.
//==============================================================================
function ExMaxValue ( A1 , B1 : Longint ): Longint; overload;
begin
   if A1 > B1 then Result := A1 else Result := B1;
end;

//==============================================================================
//  2���� ���Ͽ� ���� ���� �Ѱ��ش�.
//==============================================================================
function ExMInValue ( A1 , B1 : Longint ): Longint; overload;
begin
   if A1 < B1 then Result := A1 else Result := B1;
end;
}


//==============================================================================
// ���ڿ��� �޾� ���ѹα� �ֹε�� ��ȣ�� ��ġ�ϴ��� �˻��Ѵ�.
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
// ���ڿ��� �޾� ���ѹα� ����� ��ȣ�� ��ġ�ϴ��� �˻��Ѵ�.
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
//  2���� ���� ū���� �Ѱ��ش�.
//==============================================================================
function ExMaxInteger(A1, B1: Longint): Longint;
begin
   if A1 > B1 then Result := A1  else Result := B1;
end;

//==============================================================================
//  2���� ���� �������� �Ѱ��ش�.
//==============================================================================
function ExMinInteger(A1, B1: Longint): Longint;
begin
   if A1 < B1 then Result := A1 else Result := B1;
end;


// Ư������ ��ȯ
function ExReplace(Source, FromStr, ToStr : String ): String;
var  before : String;
begin
  Result := StringReplace(Source, FromStr, ToStr, [rfReplaceAll, rfIgnoreCase]);
end;

// -----------------------------------------------------------------------------
// ��ü�ּҸ� �޾� �õ�,�ñ���, ���鵿, ���ּҷ� �и� �Ѵ�.
// ��⵵ ����� �һ籸 �һ絿 �Ҿƾ���Ʈ 123-4567
// -----------------------------------------------------------------------------
function ExAddressSplite( Source: String ): addrRecord;
var //addrArray : array[0..4] of string;
    ar : addrRecord;
    iSearch : Integer;
    Str, Str1, Str2 : String;
    sido, gungu, dong, etc : String;

    function getPos(SourceStr : String) : String;
    var iPos : Integer;
    begin
      Result := '';
      iPos :=  Pos(' ', SourceStr);  // ��ȯ�� = 3
      if iPos > 0 then begin
         result := Trim(Copy(SourceStr, 1,iPos));
         Str := Trim(Copy(SourceStr, iPos, 200));
      end else Str := Trim(SourceStr);
    end;

begin

    sido  := '';
    gungu := '';
    dong  := '';

    Str  := Source;
    etc  := Trim(Str);
    sido := getPos(Str); //�õ�
    if Trim(Str) <> '' then begin
        etc   := Trim(Str);
        gungu := getPos(Trim(Str)); //�ñ���
        if Trim(Str) <> '' then begin
           dong := getPos(Trim(Str)); //���鵿
           etc  := Trim(Str);         //������ �ּ�
        end;
    end;
    Str2 := Copy(dong, Length(dong)-1, 2);
    if  Str2 = '��' then begin
       sido  := sido + gungu;
       gungu := dong;
       dong  := getPos(Trim(Str)); //���鵿
       etc   := Trim(Str);         //������ �ּ�
    end;

    ar.addrArray[0] := Source;
    ar.addrArray[1] := sido;
    ar.addrArray[2] := gungu;
    ar.addrArray[3] := dong;
    ar.addrArray[4] := etc;
    ar.addrArray[5] := IntToStr(length(sido));
    //ar.addrArray[5] := IntToStr(ByteToCharLen(sido, Length(sido)*2));
    ar.addrArray[6] := ExAddressSidoShort(sido);
    Result := ar;

end;


// �õ��� ª���õ�2�ڸ��� �����.
function ExAddressSidoShort( Source: String ): String;
var i, No : Integer;
    StrFrom, StrTo : String;
begin

   Result := '';
   for I := Low(SidoFrom) to High(SidoFrom) do begin
       StrFrom := SidoFrom[I];
       StrTo   := SidoTo[I];
       No := Pos(StrFrom, Source); //�õ�
       if No > 0 then begin
          Result := StrTo;
//sHOWmESSAGE('tO=>'+StrTo);
          break;
       end;
   end;


end;

//// Ư������ ��ȯ
//function ExReplace(Source, FromStr, ToStr : String ): String;
//var  before : String;
//begin
//  Result := StringReplace(Source, FromStr, ToStr, [rfReplaceAll, rfIgnoreCase]);
//end;

end.
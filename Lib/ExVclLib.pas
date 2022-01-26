unit ExVclLib;

interface

uses SysUtils , Variants , Db , ADODB ,Classes , ExStrLib , ValEdit ,Dialogs,  DBGridEh,
     DBGridEhImpExp, ExLibrary ;

type
  TExSqlMode  = ( mdfORA   , mdfSQL ) ;

const
       TM_MULTI_LANG_TO_XML =
        'S=20^WRHS,S=50^LANG_ID,S=200^LANG_DESC,S=200^KOR,S=600^ENGLH,S=20^CHI,S=20^ETC_1,' +
        'S=50^ETC_2,S=50^ETC_3,' +
        'S=1^CHKYN,S=20^ER_STAT,S=20^ER_CODE';

type

  TExModifySQL = class
    private
      ValueList : TValueListEditor ;
    public
      KeyTable  : String ;
      KeyWhere  : String ;

      procedure   Clear;
      function    INSERT_SQL : String ;
      function    UPDATE_SQL : String ;
      function    MODIFY_MSQ ( ModiType : Boolean = True  ) : String ;
      function    MODIFY_ORA ( ModiType : Boolean = True  ) : String ;
      function    MODIFY_SQL ( SqlMode : TExSqlMode; ModiType : Boolean = True  ) : String ;
      procedure   AddValue   ( KeyField, KeyValue: String; QuterValue : Boolean ; AddValue : Boolean = True );
      procedure   KeyValue   ( KeyField, KeyValue: String; QuterValue : Boolean ; AddValue : Boolean = True );
                
      //      function    MofifySQL ( ModiType : Boolean = True ): String ;  // Only Sql or Msde
//      function    INSERTSQL : String ;
      Destructor  Destroy;
      Constructor Create( AOwner : TComponent );
    published
    end;


    {  TStringList = class(TStrings)
  private
    FList: PStringItemList;
    FCount: Integer;
    FCapacity: Integer;
    FSorted: Boolean;
    FDuplicates: TDuplicates;
    FCaseSensitive: Boolean;
    FOnChange: TNotifyEvent;
    FOnChanging: TNotifyEvent;
    procedure ExchangeItems(Index1, Index2: Integer);
    procedure Grow;
    procedure QuickSort(L, R: Integer; SCompare: TStringListSortCompare);
    procedure SetSorted(Value: Boolean);
    procedure SetCaseSensitive(const Value: Boolean);
  protected
    procedure Changed; virtual;
    procedure Changing; virtual;
    function Get(Index: Integer): string; override;
    function GetCapacity: Integer; override;
    function GetCount: Integer; override;
    function GetObject(Index: Integer): TObject; override;
    procedure Put(Index: Integer; const S: string); override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetCapacity(NewCapacity: Integer); override;
    procedure SetUpdateState(Updating: Boolean); override;
    function CompareStrings(const S1, S2: string): Integer; override;
    procedure InsertItem(Index: Integer; const S: string; AObject: TObject); virtual;
  public
    destructor Destroy; override;
    function Add(const S: string): Integer; override;
    function AddObject(const S: string; AObject: TObject): Integer; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Exchange(Index1, Index2: Integer); override;
    function Find(const S: string; var Index: Integer): Boolean; virtual;
    function IndexOf(const S: string): Integer; override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure InsertObject(Index: Integer; const S: string;
      AObject: TObject); override;
    procedure Sort; virtual;
    procedure CustomSort(Compare: TStringListSortCompare); virtual;
    property Duplicates: TDuplicates read FDuplicates write FDuplicates;
    property Sorted: Boolean read FSorted write SetSorted;
    property CaseSensitive: Boolean read FCaseSensitive write SetCaseSensitive;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChanging: TNotifyEvent read FOnChanging write FOnChanging;
  end;
}



  TExStringList = class( TStringList )
  private
    //

  protected
  public
      destructor Destroy; override;

    //StringList : array [0..1] of TStringList ;
    //procedure   Clear;
    //constructor Create;//( AParent : TPersistent );
    //destructor  Destroy; override;
  published
    //property StringList : TStringList read FStringList write FStringList ;
  end;




    {
     //Connection = class

  TExModifySQL = class
    private
      ValueList : TValueListEditor ;

    public
      KeyTable  : String ;
      KeyWhere  : String ;

      procedure   Clear;
      function    INSERT_SQL : String ;
      function    UPDATE_SQL : String ;
      function    MODIFY_SQL (  SqlMode : Boolean   ; ModiType : Boolean = True  ) : String ; overload ;
      function    MODIFY_SQL (  SqlMode : TExSqlMode; ModiType : Boolean = True  ) : String ; overload ;


      procedure   AddValue  ( KeyField, KeyValue: String; QuterValue : Boolean ; AddValue : Boolean = True );
      procedure   KeyValue  ( KeyField, KeyValue: String; QuterValue : Boolean ; AddValue : Boolean = True );

      function    MofifySQL ( ModiType : Boolean = True ): String ;  // Only Sql or Msde
      function    INSERTSQL : String ;

      Destructor  Destroy;
      Constructor Create( AOwner : TComponent );
    published
    end;
     }

 procedure ExDataComma ( DataSet : TDataSet; DefaultMask : String = '#,##0'  ); overload;
 procedure ExDataComma ( DataSet : TDataSet; DefaultMask , KeyField : String ); overload;
 procedure ExDataComma ( DataSet : TDataSet; DefaultMask : String; KeyField : Array of String ); overload;

 procedure ExSaveValue ( KeyField : String  ; SetValue : Variant ; DataSet  : TDataSet ); overload ;
 procedure ExSaveValue ( KeyField : String  ; DataSet  : TDataSet; SetValue : Variant ); overload ;
 function  ExLoadValue ( KeyField : String  ; DataSet  : TDataSet; DefValue : Variant ) : Variant ; overload;
 function  ExLoadValue ( DataSet  : TDataSet ; KeyField : String  ; DefValue : Variant ) : Variant ; overload;

 function  ExXmlSource ( XmlFile , XmlText : String  ; var DataSet : TAdoQuery  ) : Boolean ; overload ;
 function  ExXmlSource ( XmlFile , XmlText : String  ; AdoFile : Boolean = True ) : Boolean ; overload ;

 function hlbEhgridListExcel( RvGrid : TDBGridEh ; FileName : String ; bSel : Boolean = True ) : Boolean ;


implementation

//##############################################################################

//==============================================================================
//
//==============================================================================
constructor TExModifySQL.Create( AOwner : TComponent );
begin
   ValueList := TValueListEditor.Create( AOwner );
end;

//==============================================================================
//
//==============================================================================
destructor TExModifySQL.Destroy;
begin
   ValueList.Free;
   inherited Destroy;
end;

//==============================================================================
//  값을 모두 해지 시킨다.
//==============================================================================
procedure TExModifySQL.Clear;
var i : Integer ;
begin
   try
       with ValueList do begin
            ValueList.InsertRow( 'ID_XXXX' , 'DELETE' , False ); // 최초 클리어 할때 에러방지용
            if  ValueList.RowCount > 1 then begin
                for i := ValueList.RowCount -1 DownTo 1 do begin
                    ValueList.DeleteRow(i);
                end;
            end;
       end;
   finally
      KeyTable := '';
      KeyWhere := '';
   end;
end;

//==============================================================================
// 일반적인 값을 등록 한다.
//==============================================================================
procedure TExModifySQL.AddValue(KeyField, KeyValue: String; QuterValue: Boolean ; AddValue : Boolean = True );
begin
   {
   if  QuterValue then begin
       KeyValue := StringReplace( KeyValue , '&' , '&' , [ rfReplaceAll ]) ;
       KeyValue := StringReplace( KeyValue , '"' , '"' , [ rfReplaceAll ]) ;
   end;
   }
   if  AddValue then begin
       ValueList.InsertRow('NK-'+ KeyField, ExRetToStr(QuotedStr(KeyValue) , KeyValue ,QuterValue ),True );
   end;
end;

//==============================================================================
// Key 값을 등록 한다.
//==============================================================================
procedure TExModifySQL.KeyValue(KeyField, KeyValue: String; QuterValue: Boolean ; AddValue : Boolean = True );
begin
   {
   if  QuterValue then begin
       KeyValue := StringReplace( KeyValue , '&' , '''&''' , [ rfReplaceAll ]) ;
       KeyValue := StringReplace( KeyValue , '"' , '''"''' , [ rfReplaceAll ]) ;
   end;
   }
   if  AddValue then begin
       ValueList.InsertRow('PK-'+ KeyField, ExRetToStr(QuotedStr(KeyValue), KeyValue ,QuterValue ),True );
   end;
end;

{
//==============================================================================
//  신규 SQL 문을 만든다.
//==============================================================================
function TExModifySQL.INSERTSQL  : String;
var i    : Integer ;
    Mark : String ;
    Buff : array [1..2 ] of string;
begin
   with ValueList do begin
        Buff[1]:=''; Buff[2]:='';Mark := '';
        for i := 1 to RowCount -1 do begin
            Buff[1] := Buff[1] + Mark + Copy(ValueList.Cells[0,i],4,Length(ValueList.Cells[0,i])) ;
            Buff[2] := Buff[2] + Mark + ValueList.Cells[1,i] ;
            Mark := ' , ' ;
        end;
        Result :=  ' INSERT INTO ' + KeyTable + '(' + Buff[1] + ')VALUES(' + Buff[2] + ') ' ;
   end;
end;
}
{
//==============================================================================
//  데이터를 입력하고 데이터가 있으면 업데이트 한다.
//==============================================================================
function TExModifySQL.MofifySQL( ModiType : Boolean = True )  : String;
begin
   Result := ' IF NOT EXISTS  ( ' + #13#10    +
             '    SELECT * FROM ' + KeyTable  + ' WITH (NOLOCK) '+ KeyWhere + ' ) ' + #13#10 +
             ' '+ INSERT_SQL       + #13#10    ;
   if  ModiType then
       Result := Result + ' ELSE ' + #13#10 + ' '+ UPDATE_SQL ;
end;

}
//==============================================================================
//
//==============================================================================
function TExModifySQL.INSERT_SQL: String;
var i    : Integer ;
    Mark : String ;
    Buff : array [1..2 ] of string;
begin
   with ValueList do begin
        Buff[1]:=''; Buff[2]:='';Mark := '';
        for i := 1 to RowCount -1 do begin
            Buff[1] := Buff[1] + Mark + Copy(ValueList.Cells[0,i],4,Length(ValueList.Cells[0,i])) ;
            Buff[2] := Buff[2] + Mark + ValueList.Cells[1,i] ;
            Mark := ' , ' ;
        end;
        Result :=  ' INSERT INTO ' + KeyTable + '(' + Buff[1] + ')VALUES(' + Buff[2] + ') ' ;
   end;
end;


//==============================================================================
//
//==============================================================================
function TExModifySQL.UPDATE_SQL: String;
var i    : Integer ;
    Buff , Mark : String ;
begin
   with ValueList do begin
        Buff:= ''; Mark := '';
        for i := 1 to RowCount - 1 do begin
            if  UpperCase( Copy( ValueList.Cells[0,i],1,3 ) ) <> 'PK-' then begin
                Buff := Buff + Mark + Copy( ValueList.Cells[0,i],4,Length(ValueList.Cells[0,i])) +
                                     ' = '+ ValueList.Cells[1,i];
                Mark := ' , ' + #13#10 ;
            end;
        end;
        Result := '   UPDATE ' + KeyTable + ' SET ' + #13#10 +  Buff +' '+ #13#10 +
                  '          ' + KeyWhere ;
   end;
end;

//==============================================================================
//
//==============================================================================
function TExModifySQL.MODIFY_MSQ( ModiType : Boolean = True ): String;
begin
   Result := MODIFY_SQL( mdfSQL , ModiType );
end;

//==============================================================================
//
//==============================================================================
function TExModifySQL.MODIFY_ORA(ModiType: Boolean): String;
begin
   Result := MODIFY_SQL( mdfORA , ModiType );
end;

//==============================================================================
//
//==============================================================================
function TExModifySQL.MODIFY_SQL(SqlMode: TExSqlMode; ModiType : Boolean = True ): String;
begin
   case SqlMode of
      mdfORA : begin  // 오라클
                  Result :=  ' DECLARE                                 ' + #13#10 +
                             '   FUNCTION EXISTSCODE RETURN NUMBER IS  ' + #13#10 +
                             '   RETCOUNT NUMBER(5);                   ' + #13#10 +
                             '   BEGIN                                 ' + #13#10 +
                             '      SELECT COUNT(*) INTO RETCOUNT FROM ' + #13#10 +
                             ' ' +  KeyTable  + '  ' + KeyWhere  + ' ; ' + #13#10 +
                             '      RETURN RETCOUNT ;                  ' + #13#10 +
                             '   END;                                  ' + #13#10 +
                             ' BEGIN                                   ' + #13#10 +
                             '   IF  EXISTSCODE = 0 THEN               ' + #13#10 +
                             '      ' +  INSERT_SQL              + ' ; ' + #13#10 +
                  ExStrToSql(' ELSE ' +  UPDATE_SQL + ' ; ' , ModiType ) + #13#10 +
                             '   END IF;                               ' + #13#10 +
                             ' END;                                    ' ;
               end;
      mdfSQL : begin  // MS-SQL
                  Result :=  ' IF NOT EXISTS  ( '                                 + #13#10 +
                             '    SELECT * FROM ' + KeyTable  + ' WITH (NOLOCK) ' + #13#10 +
                             '      '             + KeyWhere  + ' ) '    + #13#10 +
                             '      ' + INSERT_SQL                       + #13#10 +
                  ExStrToSql(' ELSE ' + UPDATE_SQL  , ModiType           ) ;
               end;
   end;
end;


{ TExStringLists }
//##############################################################################

//==============================================================================
//
//==============================================================================

destructor TExStringList.Destroy;
begin
  inherited Destroy;
end;

{
constructor TExStringLists.Create;//(AParent: TPersistent);
var i : Integer ;
begin
   for i := Low( StringList ) to high ( StringList ) do begin
       StringList[i] := TStringList.Create ;
   end;
end;
}
//==============================================================================
//
//==============================================================================
{
destructor TExStringLists.Destroy;
var i : Integer ;
begin
   for i := Low( StringList ) to high ( StringList ) do begin
       FreeAndNil( StringList[i] );
   end;
   inherited ;
end;
}
//==============================================================================
//
//==============================================================================
{
procedure TExStringLists.Clear;
var i : Integer;
begin
   for i := Low( StringList ) to high ( StringList ) do begin
       StringList[i].Clear ;
   end;
end;
}

//##############################################################################

//==============================================================================
//  DataSet 을 오픈한후 넘버형 필드이면 컴마를 넣어준다.
//==============================================================================
procedure ExDataComma ( DataSet : TDataSet; DefaultMask : String = '#,##0' ); overload;
var i        : Integer;
    TheField : TField ;
begin
    with DataSet do begin
         if  Active then begin
             for i := 0 to FieldCount -1 do begin
                 TheField := Fields[i];
                 if  ( TheField is TNumericField ) then
                     TNumericField(TheField).DisplayFormat := DefaultMask;
             end;
        end;
    end;
end;


//==============================================================================
//  DataSet 을 오픈한후 필요한 필드에만 컴마를 설정한다.
//==============================================================================
procedure ExDataComma ( DataSet : TDataSet; DefaultMask , KeyField : String ); overload;
var  TheField : TField ;
begin
    with DataSet do begin
         if  Active then begin
             TheField := FindField( KeyField );
             if  TheField <> nil then begin
                 if  ( TheField is TNumericField ) then
                     TNumericField(TheField).DisplayFormat := DefaultMask ;

             end;
         end;
    end;
end;

//==============================================================================
//  DataSet 을 오픈한후 필요한 필드에만 컴마를 설정한다.
//==============================================================================
procedure ExDataComma ( DataSet : TDataSet; DefaultMask : String; KeyField : Array of String ); overload;
var i : Integer ;
begin
    for i := Low( KeyField ) to High ( KeyField ) do begin
        ExDataComma ( DataSet , DefaultMask , KeyField[i]  );
    end;
end;


//==============================================================================
//  DataSet 과 필드명을 받아 그 필드가 존재한다면 값을 설정한다.
//==============================================================================
procedure ExSaveValue( KeyField : String; SetValue  : Variant ;DataSet : TDataSet  ); overload;
begin
   ExSaveValue( KeyField , DataSet , SetValue );
end;

//==============================================================================
//  DataSet 과 필드명을 받아 그 필드가 존재한다면 값을 설정한다.
//==============================================================================
procedure ExSaveValue( KeyField : String; DataSet : TDataSet ; SetValue  : Variant  ); overload;
var  TheField : TField ;
begin
   with DataSet do begin
        TheField := FindField( KeyField );
        if  TheField <> nil then begin
            if  ( TheField is TNumericField ) then begin
                if  VarToStr ( SetValue ) = '' then begin
                    FieldValues[ KeyField  ] := 0 ;
                end else FieldValues[ KeyField  ] := SetValue ;
            end else FieldValues[ KeyField  ] := SetValue ;
        end;
   end;
end;

//==============================================================================
//  DataSet 과 필드명을 받아 그 필드가 존재한다면 값을 그필드에 설정된 값을 반환한다.
//  만약 필드가 없거나 숫자형 필드인데 공백이면 디폴드 값을 반환한다.
//==============================================================================
function  ExLoadValue ( DataSet : TDataSet ; KeyField : String   ; DefValue : Variant ) : Variant ; overload;
begin
   Result := ExLoadValue(  KeyField , DataSet , DefValue ) ;
end;

//==============================================================================
//  DataSet 과 필드명을 받아 그 필드가 존재한다면 값을 그필드에 설정된 값을 반환한다.
//  만약 필드가 없거나 숫자형 필드인데 공백이면 디폴드 값을 반환한다.
//==============================================================================
function  ExLoadValue(  KeyField : String  ; DataSet  : TDataSet ; DefValue : Variant ) : Variant ; overload;
var  TheField : TField ;
     SetValue : String ;
begin
   try Result := DefValue ;
       with DataSet do begin
                TheField := FindField(KeyField);
                if  TheField <> nil then begin
                    SetValue := VarToStr( FieldByName(KeyField ).Value );
                    if  Trim ( SetValue ) <> '' then begin
                        Result := FieldByName(KeyField ).Value ;
                    end else Result := DefValue ;
                end;
       end;
   except
       Result := DefValue;
   end;
end;

//==============================================================================
// Ex : XmlText := 'S=5/ID_WORK,S=4/ID_LOCA,S=20/ID_CODE,S=80/ID_DESC,N=18/QUANTITY,N=18/PRICE'
// XML  파일을 만든뒤 오픈 한다.
//==============================================================================
function  ExXmlSource ( XmlFile , XmlText : String ; var DataSet : TAdoQuery  ) : Boolean ; overload ;
{   //
   function LoadFromFile_XML : Boolean ;
   begin
      Result := False;
   end;
   }
begin
   Result := False;
   DataSet.Close;
   if  ExXmlSource( ExIsEmpty ( XmlFile ,'C:\TempXmlSourceFile.Xml' ) , XmlText , True ) then begin
       try DataSet.Close;
           DataSet.LoadFromFile ( XmlFile  );
           Result := True;
       except DataSet.Close; end;
   end;
   {

           Result := LoadFromFile_XML;
       end else begin
           if   Owner <> nil then begin
                DataSet := TAdoQuery.Create(Owner);
                with DataSet do begin
                     CursorType := ctStatic ;
                     EnableBCD  := False ;
                     LockType   := ltBatchOptimistic;
                end;
                Result := LoadFromFile_XML;
           end;
       end;
   end;
   }
end;

//==============================================================================
// Ex : XmlText := 'S=5/ID_WORK,S=4/ID_LOCA,S=20/ID_CODE,S=80/ID_DESC,N=18/QUANTITY,N=18/PRICE'
// XML  파일을 생성 한다.
//==============================================================================
function  ExXmlSource( XmlFile , XmlText : String ; AdoFile : Boolean = True ) : Boolean ; overload ;
var F         : TextFile;
    i         : Integer;
    XmlList   : TStringList;
    TempStr, XmlType, XmlData, XmlSize  : String;
begin
   Result  := False   ;

   XmlList := TStringList.Create;  // 스트링 리스트를 오픈한다.
   try XmlList.Clear;
       XmlText := StringReplace( XmlText , '=' ,''  , [ rfReplaceAll ]);  // 공백을 제외하고 CommaText 콤마선 분리를 한다.
       XmlText := StringReplace( XmlText , '/' ,'^' , [ rfReplaceAll ]);  // 공백을 제외하고 CommaText 콤마선 분리를 한다.

       XmlLIst.CommaText := StringReplace( XmlText , ' ' ,'' , [ rfReplaceAll ]);  // 공백을 제외하고 CommaText 콤마선 분리를 한다.
       if  XmlList.Count > 0 then begin
           try AssignFile( F, ExIsEmpty ( XmlFile ,'C:\TempXmlSourceFile.Xml' )  );
               try Rewrite( F );
                   if  AdoFile then begin // Ado DataSource Type
                       Writeln( F , '<xml xmlns:s=''uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882'''                );
                       Writeln( F , '     xmlns:dt=''uuid:C2F41010-65B3-11d1-A29F-00AA00C14882'''               );
                       Writeln( F , '     xmlns:rs=''urn:schemas-microsoft-com:rowset'''                        );
                       Writeln( F , '     xmlns:z=''#RowsetSchema''>'                                           );
                       Writeln( F , '<s:Schema id=''RowsetSchema''>'                                            );
                       Writeln( F , '   <s:ElementType name=''row'' content=''eltOnly'' rs:updatable=''true''>' );
                   end else
                   begin                  // Cds DataSource Type
                      Writeln( F , '<?xml version="1.0" standalone="yes"?>'                        );
                      Writeln( F , '<DATAPACKET Version="2.0">'                                    );
                      Writeln( F , '<METADATA> <FIELDS>'                                           );
                   end;
                   for i := 0 to XmlList.Count - 1  do begin
                       TempStr := Trim( XmlList.Strings[i] );
                       XmlType := TempStr[1];//  Copy( TempStr , 1, 1     );
                       XmlSize := Copy( TempStr , 2 ,Pos( '^' , TempStr )- 2  ) ;
                       XmlData := Copy( TempStr ,    Pos( '^' , TempStr )+ 1  , Length ( TempStr ) );

                       if  AdoFile then begin // Ado DataSource Type
                           Writeln( F , ' <s:AttributeType name='''+XmlData+''' rs:number='''+IntToStr(i+1)+''' rs:writeunknown=''true'' rs:basetable=''TEMP_INFO'' rs:basecolumn='''+XmlData+'''>');
                           if  XmlType = 'N' then begin
                               Writeln( F , ' <s:datatype dt:type=''number'' rs:dbtype=''numeric'' dt:maxLength=''19'' rs:scale=''2'' rs:precision=''15'' rs:fixedlength=''true'' rs:maybenull=''false''/>');
                           end else Writeln( F , ' <s:datatype dt:type=''string'' rs:dbtype=''str'' dt:maxLength='''+XmlSize+''' rs:maybenull=''false''/>' );
                           Writeln( F , '</s:AttributeType>' );
                       end else          // Cds DataSource Type
                       begin
                          if  UpperCase ( XmlType ) = 'N' then begin  Writeln( F , '<FIELD attrname="'+XmlData+ '" fieldtype="r8"/>' );
                          end else Writeln( F , '<FIELD attrname="'+XmlData+'" fieldtype="string.uni" WIDTH="'+XmlSize+'"/>' );
                       end;
                       XmlType := '';
                   end;
                   if  AdoFile then begin  // Ado DataSource Type
                       Writeln( F , '       <s:extends type=''rs:rowbase''/>'                                   );
                       Writeln( F , '   </s:ElementType>'                                                       );
                       Writeln( F , '</s:Schema>'                                                               );
                       Writeln( F , '<rs:data>'                                                                 );
                       Writeln( F , '</rs:data>'                                                                );
                       Writeln( F , '</xml>'                                                                    );
                   end else           // Cds DataSource Type
                   begin
                      Writeln( F , '</FIELDS><PARAMS/></METADATA><ROWDATA></ROWDATA>'              );
                      Writeln( F , '</DATAPACKET>'                                                 );
                   end;
               finally
                   CloseFile(F);
               end;
               Result := True;
           except end;
       end;
   finally
       XmlList.Free;
   end;
end;





//==============================================================================
//        Eh Grid 내용을 엑셀 파일 로 저장 한다.
//==============================================================================
//  non in RvGrid  : TDBGridEh ; Grid
//  non in FileName : String ; 기록할 디폴트 파일명
//==============================================================================
function hlbEhgridListExcel( RvGrid : TDBGridEh ; FileName : String ; bSel : Boolean = True ) : Boolean ;
var
  Save_Dlg : TSaveDialog;
begin
   Result := False;

  if RvGrid.DataSource.DataSet.Active and not RvGrid.DataSource.DataSet.IsEmpty then
  begin
    Save_Dlg := TSaveDialog.Create(nil);
    try
      Save_Dlg.FileName := ChangeFileExt ( FileName , '.xlsx'  );
      Save_Dlg.Title    := '엑셀로 저장';
      Save_Dlg.Filter   := '엑셀문서[ *.xlsx ]|*.xlsx';
      if Save_Dlg.Execute then
      begin
        ExportDBGridEhToXlsx(RvGrid,Save_Dlg.FileName,[]);
        Result := True;
        //SaveDBGridEhToExportFile( TDBGridEhExportAsXLS,RvGrid,ChangeFileExt(Save_Dlg.FileName,'.xls'),bSel);
      end;
    finally
      FreeAndNil( Save_Dlg );
    end;
  end ;//else ufShowMessage( '저장할 데이터가 없거나 조회 되지 않았습니다.' );
end;
          {
//==============================================================================
//  Eh Grid의 내용을 엑셀로 저장한다.
//==============================================================================
procedure ExEhGridXls ( Value : TDbGridEh ; FileName : String );
begin


procedure fnEhGridExcel ( RvGrid : TDBGridEh  ; RvStr : String    );
var FullName : String;
begin

   if  RvGrid.DataSource.DataSet.Active then begin
       with MainDm do begin
            SaveDlg.FileName := RvStr+ '.xls';
            SaveDlg.Title    := '엑셀로 저장';
            SaveDlg.Filter   := '엑셀문서[ *.xls ]|*.xls';
            if  SaveDlg.Execute then begin
                FullName := ChangeFileExt ( SaveDlg.FileName , '.xls'  );
                SaveDBGridEhToExportFile( TDBGridEhExportAsXLS, RvGrid , FullName , True);
            end;
       end;
   end else fnShowMessage ( '엑셀로 저장' , '조회 하신후 엑셀로 저장 하여 주시기 바랍니다.' , [ dmtError ] ) ;

end;
}















end.
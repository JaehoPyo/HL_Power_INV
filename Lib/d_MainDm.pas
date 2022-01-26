unit d_MainDm;

interface

uses
  Windows, SysUtils, Classes, DB, ADODB, Messages, Dialogs, Inifiles,
  ComObj, StdCtrls, h_MainLib, Variants, DBGrids, h_LangLib, Graphics,
  ExLibrary  ;

type
  TFORM_DESC = Record
    FORMID   : String;
    FORMNM   : String;
    FIELD_NAME: String;
  end;

  TLANG_PGM = Record // Form Name Description
    LANG  : Array [0..200] of TFORM_DESC ;
  end;

  TJobOrder = Record
   REG_TIME,
   LUGG,
   JOBD,
   SRCSITE,
   SRCAISLE,
   SRCBAY,
   SRCLEVEL,
   DSTSITE,
   DSTAISLE,
   DSTBAY,
   DSTLEVEL,
   NOWMC,
   JOBSTATUS,
   NOWSTATUS,
   BUFFSTATUS,
   JOBREWORK,
   JOBERRORT,
   JOBERRORC,
   JOBERRORD,
   JOB_END,
   CVFR,
   CVTO,
   CVCURR,
   ETC,
   EMG,
   ITM_CD,
   UP_TIME,
   ID_CODE : String;
  end;


  TPlanInfor = Record
    PLAN_CD, ITM_CD, ITM_DESC, MODEL_SPEC, MODEL_CODE, MACHTP,
    STOCK_QTY, PLAN_QTY, PROCESS_QTY, COMPLE_QTY : String;
    ResultCd : String; // Save, Delete, Close
  end;

  TUser_AUTH = Record // Form Field Description
    FORM_ID,
    AUTH_YN, AUTH_READ, AUTH_WRITE : String;
  end;

  TPopupData = Record // Popup Form data Send Recv
    in_id_code, in_id_desc, in_etc1, in_etc2, in_etc3, in_etc4, in_id_hogi : String;
    ot_id_code, ot_id_desc, ot_etc1, ot_etc2, ot_etc3, ot_etc4, ot_id_hogi : String;
    ResultCd : String; // Save, Delete, Close
    ID   : String;
  end;

  Main_Info = Record
    MainHd   : Hwnd;
    IdPass   : Boolean;
    MenuName, MenuNumber, MenuTitle  : String ;
    CompanyName : String;
    DbOle    , DbType  , DbUser  , DbPswd  , DbAlais, DbFile  : String;
    UserCode, UserName, UserPermit, UserUse   : String ;
    WRHS : String ; //창고구분 (열처리,완제품)
    ActiveFormID, ActiveFormName : String; //실행 시킨 폼
    RunFormID : String; //메뉴에서 누른 메뉴코드
    Pgm : TLANG_PGM;   //등록된 프로그램명칭.
    Form : TLANG_PGM; //등록된 프로그램명칭.
    mPop : TPopupData;
    mPlan : TPlanInfor;
    ConChk : Boolean ;
    position : String ;
    AwsNo : String; // 1: 하우징, 2: 케이스
  end;

  TMainDm = class(TDataModule)
    MainDB: TADOConnection;
    qryTemp: TADOQuery;
    SaveDlg: TSaveDialog;
    qryCommand: TADOQuery;
    qryInfo: TADOQuery;
    qrySearch: TADOQuery;
    procedure MainDBAfterConnect(Sender: TObject);
    procedure MainDBAfterDisconnect(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;
  function fnFileFilter( var FileName : String; Const FilterName : String   ) : Boolean ;
  function DBGridToExcel(var ADBG: TDBGrid; ATitle, ASubtitle, AFoot: String) : Boolean ;
  procedure fnWmMsgSend   ( const WMsg, LMsg : LongWord );
  procedure fnWmMsgSend_100(const WMsg, LMsg: LongWord);

  function  IniRead ( IniRoot , KeyName  , FieldName , ReadStr   : String ) : String;
  function  IniWrite( IniRoot , KeyName  , FieldName , WriteStr  : String ) : Boolean;
  function  ADOConnection : Boolean;
  procedure AddComboList(var ComboBox : TComboBox; Table, Field, WhereStr : String);
  function SearchReturn(Table, Field, WhereStr : String) : String;
  procedure fnNameGet(var StrName : Array of String; frmNo,Language : String)  ;
  procedure fnMenuNameGet(var MnNo,MnName : Array of String; WRHS, Language : String)  ;
  function SeartchTableData(TableName, ResultFieldName, SearchFieldName, KeyData: String): Boolean;
  function UniCodeToWideStr(Data:String) : WideString ;

  // Form의 캡션명을 가져 온다.
  function fnSetFormCaption(FormNo : String) : String;
  function fnMenuNameGetRecord( WRHS : String) : TLANG_PGM ;
  // 필드명의 내용을 선택된 언어로 변환 한다.
  Function getLangString(FieldName, Default : String; LangNo : Integer; addField : String = '') : String;
  Function getLangMenuString(FormId, Default : String; LangNo : Integer; addField : String = '') : String;
  // SpeedButton Caption name Find
  // TJobOrder 변수 초기화
  procedure IntiJobOrder(var jOrder : TJobOrder);
  Function getUserFormAuth(WRHS, UserId, PgmId : String ) : TUser_AUTH;

  function fnPGMUsedChk(GetField,WRHS,USR_ID,PGM_ID:String) : Boolean ;

Const

  INI_PATH           : String = 'AWHOUSE.INI';

var
  MainDm: TMainDm;
  m : Main_Info;

implementation

{$R *.dfm}

uses Main;

{ TMainDm }

//==============================================================================
// Eh grid 를 excel로
//==============================================================================
procedure fnEhGridExcel  ( RvStr : String; RvGrid : TDBGrid );
var
  FullName : String;
  ExApp : olevariant;
begin
  with MainDm do
  begin
    SaveDlg.FileName := RvStr+'.xls';
    SaveDlg.Title    := '엑셀로 저장';
    SaveDlg.Filter   := '엑셀문서[ *.xls ]|*.xls';
    if  SaveDlg.Execute then
    begin
      FullName := SaveDlg.FileName;
      if  fnFileFilter ( FullName , 'xls') then
      begin
        //SaveDbGridEhToExportFile ( TDbgridEhExportasHtml , RvGrid , FullName , True );
        ExApp := createoleobject('excel.application');
        ExApp.workbooks.add(FullName);
        ExApp.displayalerts := false;
        ExApp.activeworkbook.saveas(FullName, 1);
        ExApp.activeworkbook.close;
      end;
    end;
  end;
end;

//==============================================================================
// DB grid 를 excel로
//==============================================================================
function DBGridToExcel(var ADBG: TDBGrid; ATitle, ASubtitle, AFoot: String) : Boolean ;
const
  xlHairline = 1;
  xlThin = 2;
  xlHAlignLeft   = -4131;
  xlHAlignRight  = -4152;
  xlHAlignCenter = -4108;
  xlVAlignTop    = -4160;
  xlVAlignCenter = -4108;
var
  XL, XArr, XRange: Variant;
  i, j, k: Integer;
  s,FullName: String;
begin
  Result := False ;
  with MainDm do
  begin
    SaveDlg.FileName := ATitle+'.xls';
    SaveDlg.Title    := 'Save as ';
    SaveDlg.Filter   := '엑셀문서[ *.xls ]|*.xls';
    if  SaveDlg.Execute then
    begin
      FullName := SaveDlg.FileName;
      if  fnFileFilter ( FullName , 'xls') then
      begin
        with ADBG do
        begin
          if not ADBG.DataSource.DataSet.Active then Exit;

          XArr := VarArrayCreate([1, Columns.Count], VarVariant);
          try
            XL := CreateOLEObject('Excel.Application');
            XL.DisplayAlerts := False;
          except
            on E: Exception do
            begin
              ShowMessage('Unable to open Excel OLE Object.'+#13#10+E.Message);
              Exit;
            end;
          end;

          try
            // New Page
            XL.WorkBooks.Add;
            XL.Visible := False;
            k := 1;

            // 필드 범위 설정
            i := Columns.Count div 26;
            if i > 0 then s := Chr(64 + i)
            else s := '';
            j := Columns.Count mod 26;
            s := s + Chr(64 + j);

            // Title
            if ATitle <> '' then
            begin
              XArr[1] := ATitle;
              XRange := XL.Range['A' + IntToStr(k), s + IntToStr(k)];
              XL.Range['A' + IntToStr(k), s + IntToStr(k)].Select;
              XL.Selection.MergeCells := True;
              XRange.Value := XArr;
              XRange.HorizontalAlignment := xlHAlignCenter;
              XRange.VerticalAlignment := xlVAlignCenter;
              XRange.Font.Bold := True;
              Inc(k);
            end;

            // Subtitle
            if ASubtitle <> '' then
            begin
              XArr[1] := ASubtitle;
              XRange := XL.Range['A' + IntToStr(k), s + IntToStr(k)];
              XL.Range['A' + IntToStr(k), s + IntToStr(k)].Select;
              XL.Selection.MergeCells := True;
              XRange.Value := XArr;
              XRange.HorizontalAlignment := xlHAlignRight;
              XRange.VerticalAlignment := xlVAlignCenter;
              XRange.Font.Bold := False;
              Inc(k);
            end;

            // Field Title
            i := 1;
            while i <= Columns.Count do
            begin
              XArr[i] := Columns[i-1].Field.FieldName ;
              Inc(i);
            end;
            XRange := XL.Range['A' + IntToStr(k), s + IntToStr(k)];
            XRange.Value := XArr;
            XRange.HorizontalAlignment := xlHAlignCenter;
            XRange.VerticalAlignment := xlVAlignCenter;
            XRange.Interior.ColorIndex := '36' ;
            XRange.Font.Bold := True;
            Inc(k);

            // 내용
            try
              DataSource.DataSet.DisableControls;
              DataSource.DataSet.First;
              while not DataSource.DataSet.Eof do
              begin
                i := 1;
                while i <= Columns.Count do
                begin
                  if Columns[i-1].Field.IsNull then XArr[i] := ''
                  else if Columns[i-1].Field.DataType = ftString then
                    XArr[i] := #39 + Columns[i-1].Field.Value
                  else if Columns[i-1].Field.DataType in [ftTimeStamp] then
                    XArr[i] := DateTimeToStr(Columns[i-1].Field.Value)
                  else XArr[i] := Columns[i-1].Field.Value;
                  Inc(i);
                end;
                XRange := XL.Range['A' + IntToStr(k), s + IntToStr(k)];
                XRange.Value := XArr;
                XRange.VerticalAlignment := xlVAlignCenter;
                XRange.Font.Bold := False;
                Inc(k);
                DataSource.DataSet.Next;
              end;
            finally
              DataSource.DataSet.EnableControls;
            end;

            // Footer
            if AFoot <> '' then
            begin
              for i := 2 to FieldCount - 1 do XArr[i] := '';
              XArr[1] := AFoot;
              XRange := XL.Range['A' + IntToStr(k), 'A' + IntToStr(k)];
              XRange.Value := XArr;
              XRange.HorizontalAlignment := xlHAlignLeft;
              XRange.VerticalAlignment := xlVAlignCenter;
              XRange.Font.Bold := True;
            end;

            // Cell 크기 조정
            XL.Range['A1', s + IntToStr(k)].Select;
            XL.Selection.RowHeight := 15.75;
            XL.Selection.Columns.AutoFit;
            XL.Range['A1', 'A1'].Select;
            XL.Selection.RowHeight := 30;
            XL.Selection.Font.Bold := True;
            XL.Selection.Font.Size := 20 ;
            DataSource.DataSet.First;

            // Excel 저장
            XL.ActiveWorkBook.SaveAs(FullName, 1);
            XL.ActiveWorkBook.Close;
            Result := True ;
          except
            on E: Exception do
            begin
              Result := False ;
              ShowMessage('An error occurred while sending data to Excel.'+#13#10+E.Message);
              Exit;
            end;
          end;
        end;
      end;
    end;
  end;
end;

//==============================================================================
// AddComboList -> Combobox데이터 추가
//==============================================================================
procedure AddComboList(var ComboBox: TComboBox; Table, Field, WhereStr: String);
var
  StrSql : String ;
begin
  with MainDm.qryCommand do
  begin
    Close;
    SQL.Clear;
    StrSql   := ' SELECT DISTINCT('+Field+') as DATA ' +
                '   FROM ' + Table + ' ' + WhereStr +
                '  ORDER BY ' + Field ;
    SQL.Text := StrSql ;

    Open;
    First;
    ComboBox.Items.Clear;
    ComboBox.Items.Add('전체');
    while Not Eof do
    begin
      if (FieldByName('DATA').AsString <> '') then
        ComboBox.Items.Add(FieldByName('DATA').AsString);
      Next;
    end;
    Close;
  end;
  ComboBox.ItemIndex := 0;
end;

//==============================================================================
// SearchReturn -> 조회조건에 맞는 데이터 찾기
//==============================================================================
function SearchReturn(Table, Field, WhereStr: String) : String;
begin
  Result := '';
  with MainDm.qryCommand do
  begin
    close;
    SQL.Clear;
    SQL.Text := 'SELECT  DISTINCT ' + Field + ' FROM ' + Table +
                WhereStr +  ' ORDER BY ' + Field + ' ';
    open;
    if Not (eof and Bof) then
      Result := FieldByName(Field).AsString;
    Close;
  end;
end;

//==============================================================================
// IniRead -> INI 파일에서 Key Field 의 값을 읽음
//==============================================================================
function IniRead( IniRoot , KeyName , FieldName , ReadStr : String ): String;
var Ini_File    : TIniFile;
begin
  try
    Ini_File := TIniFile.Create( ExpandFileName ( IniRoot )  );
    try
      Result := PChar ( Ini_File.ReadString ( KeyName ,FieldName , ReadStr ) );
    finally
      Ini_File := nil;
      Ini_File.Free;
    end;
  except
    Result := ReadStr;
  end;
end;

//==============================================================================
// IniWrite -> INI 파일에서 Key Field의 값을 기록
//==============================================================================
function IniWrite ( IniRoot , KeyName, FieldName, WriteStr : String ): Boolean ;
var Ini_File   : TIniFile;
begin
  try
    Ini_File := TIniFile.Create( ExpandFileName ( IniRoot )  );
    try
      Ini_File.WriteString( KeyName, FieldName, WriteStr  );
      Result := True;
    finally
      Ini_File := nil;
      Ini_File.Free;
    end;
  except
    Result := False;
  end;
end;

//==============================================================================
// ADOConnection -> Database Connect
//==============================================================================
function ADOConnection: Boolean;
begin
  Result := False;
  m.DbType := UpperCase ( IniRead( INI_PATH, 'Database', 'Connection', 'ORACLE' ) );
  if  m.DbType = 'ORACLE' then
  begin
    MainDm.qryTemp.Connection := MainDM.MainDb;
    m.DbOle   := IniRead( INI_PATH, 'Database', 'Provider', 'OraOLEDB.Oracle.1' );
    m.DbAlais := IniRead( INI_PATH, 'Database', 'Alais'   , 'ORCL201'  );
    m.DbUser  := IniRead( INI_PATH, 'Database', 'User'    , 'DYMOSUSER2'  );
    m.DbPswd  := IniRead( INI_PATH, 'Database', 'Pswd'    , 'DYMOSPASS2'  );
  end;

  try
    with MainDm.MainDB do
    begin
      Close;
//      ConnectionString := 'Provider=' + m.DbOle +
//                          ';Data Source=' + m.DbAlais+
//                          ';Persist Security Info=True' +
//                          ';Password=' + m.DbPswd +
//                          ';User ID =' + m.DbUser ;
      ConnectionString := 'Provider=' + m.DbOle +
                          ';Persist Security Info=True;User ID=' + m.DbUser +
                          ';Data Source=' + m.DbAlais +
                          ';Password=' + m.DbPswd +
                          ';Initial Catalog=WMS_TEMP';

      Connected := True;
      Result := True;
      m.ConChk := True ;
    end;
  except
    m.ConChk := False ;
  end;
end;

procedure fnWmMsgSend(const WMsg, LMsg: LongWord);
begin
  SendMessage( m.MainHd ,  WM_USER, WMsg, LMsg );
end;

procedure fnWmMsgSend_100(const WMsg, LMsg: LongWord);
begin
  SendMessage( m.MainHd ,  WM_USER+100, WMsg, LMsg );
end;

//==============================================================================
// fnNameGet
//==============================================================================
procedure fnNameGet(var StrName : Array of String; frmNo,Language : String)  ;
var
  StrSql : String ;
  i : integer;
begin
  try
    i := 0 ;
    with MainDm.qryInfo do
    begin
      Close;
      SQL.Clear;
      SQL.Text :=
              ' Select KOR, DB_COLUMN_YN,FIELD_NAME '+ //
              '   From TM_MULTI_LANG ' +
              '  Where WRHS = :WRHS '  + // + m.WRHS + ''' ' +
              '    and LANG_ID = :LANG_ID ' +// LIKE ''' + frmNo + '%''' +
              '  Order By DB_COLUMN_YN, FIELD_NAME ' ;
      MainDm.qryInfo.Parameters[0].Value := m.WRHS;
      MainDm.qryInfo.Parameters[1].Value := frmNo;

      Open;
      First ;
      While not eof do
      begin
        StrName[i] := FieldByName('KOR').AsString;
        inc(i);
        Next ;
      end;
      Close ;
    end;
  except
  //
  end;
end;

//==============================================================================
// fnMenuNameGet
//==============================================================================
procedure fnMenuNameGet(var MnNo,MnName : Array of String; WRHS, Language : String)  ;
var
  StrSql : String ;
  i : integer;
begin
  try
    i := 0 ;
    StrSql := ' Select WRHS, USE_YN, PGM_ID, PGM_NM ' + // 한국어 -> Unicode
              '   From TM_PGM ' +
              '  Where WRHS = ''' + WRHS + ''' ' +
              '  Order By PGM_ID ' ;

    with MainDm.qryInfo do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSql;
      Open;
      First ;
      While not eof do
      begin
        MnNo[i]   := FieldByName('PGM_ID').AsString ;
        MnName[i] := FieldByName('PGM_NM').AsString;
        inc(i);
        Next ;
      end;
      Close ;
    end;
  except
  //
  end;
end;

//==============================================================================
// fnMenuNameGetRecord
//==============================================================================
function fnMenuNameGetRecord( WRHS : String) : TLANG_PGM ;
var
  Menu : TLANG_PGM;
  StrSql : String ;
  i : integer;
begin
  try
    i := 0 ;
    with MainDm.qryInfo do
    begin
      Close;
      SQL.Clear;
      SQL.Text :=
              ' Select WRHS, USE_YN, PGM_ID, PGM_NM ' + // 한국어 -> Unicode
              '   From TM_PGM ' +
              '  Where WRHS = ''' + WRHS + ''' ' +
              '  Order By PGM_ID ' ;

      Open;
      First ;
      While not eof do
      begin

        Menu.LANG[i].FORMID := FieldByName('PGM_ID').AsString ;
        Menu.LANG[i].FORMNM := FieldByName('PGM_NM').AsString ;

        inc(i);
        Next ;
      end;
      Close ;
    end;
  except
  //
  end;
  Result := Menu;
end;

//==============================================================================
// SeartchTableData -> 해당 테이블의  데이터 체크
//==============================================================================
function SeartchTableData(TableName, ResultFieldName, SearchFieldName, KeyData: String): Boolean;
var
  StrSql : String ;
begin
  Result := False;
  with MainDm.qryInfo do
  begin
    Close;
    SQL.Clear;
    StrSql   := ' SELECT * FROM '+ TableName +
                '  WHERE ' + SearchFieldName + '=' + QuotedStr(KeyData) ;
    SQL.Text := StrSql ;
    Open;

    if RecordCount > 0 then Result := True ;
    Close;
  end;
end;

//==============================================================================
// fnFileFilter -> 파일명을 받아 뒤의 확장자를 붙여넣어준다.
//==============================================================================
function fnFileFilter ( var FileName : String; Const FilterName : String   ) : Boolean ;
var PosCheck : Integer;
begin
   Result := False;
   if  Trim ( FileName ) = '' then Exit;
   PosCheck := Pos ( '.' , FileName  );
   if  PosCheck = 0 then FileName := FileName + '.' + FilterName
   else FileName := Copy ( FileName, 1 , PosCheck - 1 ) + '.' + FilterName;
   Result := True;
end;

//==============================================================================
// UniCodeToWideStr -> UniCodeString To WideString
//==============================================================================
function UniCodeToWideStr(Data:String) : WideString ;
var
  i : integer ;
  j,k, DataCnt : integer ;
  TmpNoString : String ;
  TmpChar : Array of WideChar ;
  ResultStr : WideChar ;
  tStr  : String;
  tChr  : Char ;
begin
  Result  := '';
  DataCnt := Length(Data) ;    // 총길이

  j:=1; k:=0 ;
  SetLength(TmpChar,DataCnt) ;
  While j <= DataCnt do
  begin
    if Copy(Data,j,1) ='\' then
    begin
      tStr := Copy(Data,j+1,4) ;
      TmpChar[k] := WideChar(StrToInt('$' + tStr));

      Result := Result + TmpChar[k];

      inc(k); inc(j,5);
    end else
    begin
      While Copy(Data,j,1) <> '\' do
      begin
        StrMove(@tChr, Pchar(Copy(Data,j,1)), 1) ;
        TmpChar[k] := WideChar(tChr);


        Result := Result + TmpChar[k];
        inc(k); inc(j);
        if DataCnt < j then break  ;
      end;
    end;

  end;
end;

//==============================================================================
// fnSetFormCaption
// Form의 캡션명을 가져 온다.
//==============================================================================
function fnSetFormCaption(FormNo : String) : String;
var i : Integer;
begin

  m.ActiveFormID     := FormNo; //실행시킨 Menu-ID
  for I := Low(m.Pgm.LANG) to High(m.Pgm.LANG) do
  begin
    if Trim(m.Pgm.LANG[i].FORMID) = '' then Break;
    if m.Pgm.LANG[i].FORMID = FormNo then
       m.ActiveFormName := ' '+FormNo+'. '+ m.Pgm.LANG[i].FORMNM ; //실행시킨 Menu-명
  end;
  Result := m.ActiveFormName;
  //fnWmMsgSend_100 ( 100, 1 ); //타이틀 캡션 변경
  //frmU130H.Caption :=  m.ActiveFormName;

end;

// 필드명의 내용을 선택된 언어로 변환 한다.
Function getLangString(FieldName, Default : String; LangNo : Integer; addField : String = '') : String;
var
  i : Integer;
begin
  Result := Default;
  for i := Low(m.Form.LANG) to High(m.Form.LANG) do
  begin
    if Trim(m.Form.LANG[I].FIELD_NAME) = '' then Break;
    if UpperCase(FieldName) = UpperCase(m.Form.LANG[I].FIELD_NAME) then
    begin
       case LangNo of
         1..3 :
         begin
           Result := m.Form.LANG[i].FORMNM;
         end;
       end;
       if addField = 'Y' then Result := '[ ' +Result+' ]';
       break;
    end;
  end;
end;

// 필드명의 메뉴내용을 선택된 언어로 변환 한다.
Function getLangMenuString(FormId, Default : String; LangNo : Integer; addField : String = '') : String;
var i : Integer;
begin
  Result := Default;
  for i := Low(m.Pgm.LANG) to High(m.Pgm.LANG) do begin
    if Trim(m.Pgm.LANG[I].FORMID) = '' then Break;
    if FormId = m.Pgm.LANG[I].FORMID then begin
       Result := m.Pgm.LANG[I].FORMNM[LangNo];

       m.ActiveFormID     := FormId; //실행시킨 Menu-ID
       m.ActiveFormName := ' '+FormId+'. '+ m.Pgm.LANG[I].FORMNM[LangNo];
       break;
    end;
  end;
end;

procedure IntiJobOrder(var jOrder : TJobOrder);
begin
//  jOrder.REG_TIME    := '';
//  jOrder.LUGG        := '';
//  jOrder.JOBD        := '';
//  jOrder.SRCSITE     := '';
//  jOrder.SRCAISLE    := '';
//  jOrder.SRCBAY      := '';
//  jOrder.SRCLEVEL    := '';
//  jOrder.DSTSITE     := '';
//  jOrder.DSTAISLE    := '';
//  jOrder.DSTBAY      := '';
//  jOrder.DSTLEVEL    := '';
//  jOrder.JOBSTATUS   := '';
//  jOrder.NOWSTATUS   := '';
//  jOrder.NOWMC       := '';
//  jOrder.JOBREWORK   := '';
//  jOrder.JOBERRORT   := '';
//  jOrder.JOBERRORC   := '';
//  jOrder.JOBERRORD   := '';
//  jOrder.CVFR        := '';
//  jOrder.CVTO        := '';
//  jOrder.CVCURR      := '';
//  jOrder.WORKUSER    := '';
//  jOrder.ETC         := '';
//  jOrder.ITM_CD      := '';
//  jOrder.ITM_QTY     := '';
//  jOrder.ID_CODE     := '';
end;



//==============================================================================
// SELECT  USER 권한
//==============================================================================
Function getUserFormAuth(WRHS, UserId, PgmId : String ) : TUser_AUTH;
var
  StrSql : String ;
  i :Integer;
  ua : TUser_AUTH;
begin

  ua.FORM_ID    := PgmId;
  ua.AUTH_YN    := 'N';
  ua.AUTH_READ  := 'N';
  ua.AUTH_WRITE := 'N';
  Result := ua;

  with MainDm.qryCommand do
  begin
    Close;
    SQL.Clear;
    SQL.Text :=
                   ' SELECT * ' +
                   '  FROM TM_USER_PGM ' +
                   ' WHERE 1=1 ' +
                   '   AND WRHS   = :WRHS   ' +
                   '   AND USR_ID = :USR_ID ' +
                   '   AND PGM_ID = :PGM_ID ' ;
      i := 0;
      Parameters[i].Value := WRHS;  inc(i);
      Parameters[i].Value := UserId;  inc(i);
      Parameters[i].Value := PgmId;  inc(i);
      ;
    Open;
    if RecordCount = 0 then Exit;

    ua.AUTH_YN    := FieldByName('AUTH_YN').AsString;
    ua.AUTH_READ  := FieldByName('AUTH_READ').AsString;
    ua.AUTH_WRITE := FieldByName('AUTH_WRITE').AsString;
    Result := ua;
    Close;

  end;

end;


//==============================================================================
// fnPGMUsedChk (사용자에 따른 메뉴 사용권한 체크)
//==============================================================================
function fnPGMUsedChk(GetField,WRHS,USR_ID,PGM_ID:String) : Boolean ;
var
  StrSQL : String ;
begin
  Result := False ;
  StrSQL := ' SELECT ' + GetField + ' AS DATA ' +
            '   FROM TM_USER_PGM ' +
            '  WHERE WRHS   =''' + WRHS   + ''' ' +
            '    AND USR_ID =''' + USR_ID + ''' ' +
            '    AND PGM_ID =''' + PGM_ID + ''' ' ;

  try
    with MainDm.qrySearch do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open ;

      if not ( Bof and Eof) then
      begin
        Result := Boolean( FieldByName('DATA').AsString = 'Y' ) ;
      end;
      Close ;
    end;
  except
    MainDm.qrySearch.Close;
  end;
end;

{ TMainDm }

 procedure TMainDm.MainDBAfterConnect(Sender: TObject);
begin
  m.ConChk := True ;
end;

procedure TMainDm.MainDBAfterDisconnect(Sender: TObject);
begin
  m.ConChk := False ;
end;


end.

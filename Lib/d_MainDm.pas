unit d_MainDm;

interface

uses
  Windows, SysUtils, Classes, DB, ADODB, Messages, Dialogs, Inifiles,
  ComObj, StdCtrls, h_MainLib, Variants, DBGrids, h_LangLib, Graphics,
  ExLibrary, h_ReferLib  ;

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
    ConChk, MESConChk : Boolean ;
    MenuName, MenuNumber, MenuTitle  : String ;
    UserCode, UserName, UserPwd, UserGrade, UserAdmin, UserETC1, UserETC2 : String;
    DbOle, DbType, DbUser, DbPswd, DbAlais, DbFile  : String;
    WMS_NO : String;
    Popup_ItemInfo : TPopupData;


    CompanyName : String;
    WRHS : String ; //â���� (��ó��,����ǰ)
    ActiveFormID, ActiveFormName : String; //���� ��Ų ��
    RunFormID : String; //�޴����� ���� �޴��ڵ�
    Pgm : TLANG_PGM;   //��ϵ� ���α׷���Ī.
    Form : TLANG_PGM; //��ϵ� ���α׷���Ī.
    mPop : TPopupData;
    mPlan : TPlanInfor;
    position : String ;
    AwsNo : String; // 1: �Ͽ�¡, 2: ���̽�

    LANG_TYPE : integer;
    LANG_STR  : String;
    LANG_PGM  : TLANG_PGM;
    PCPosition : integer;

    MAINT_PW_410 : String;

    ReLogin : Boolean;


    ActivePCName, ActivePCAddr : String;
  end;

  TMainDm = class(TDataModule)
    MainDB: TADOConnection;
    qryTemp: TADOQuery;
    SaveDlg: TSaveDialog;
    qryCommand: TADOQuery;
    qryInfo: TADOQuery;
    qrySearch: TADOQuery;
    PD_INS_PGM_HIST: TADOStoredProc;
    procedure MainDBAfterConnect(Sender: TObject);
    procedure MainDBAfterDisconnect(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    M_Info : Main_Info;
    pVersion : String;
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

  // Form�� ĸ�Ǹ��� ���� �´�.
  function fnSetFormCaption(FormNo : String) : String;
  function fnMenuNameGetRecord( WRHS : String) : TLANG_PGM ;
  // �ʵ���� ������ ���õ� ���� ��ȯ �Ѵ�.
  Function getLangString(FieldName, Default : String; LangNo : Integer; addField : String = '') : String;
  Function getLangMenuString(FormId, Default : String; LangNo : Integer; addField : String = '') : String;
  // SpeedButton Caption name Find
  // TJobOrder ���� �ʱ�ȭ
  procedure IntiJobOrder(var jOrder : TJobOrder);
  Function getUserFormAuth(WRHS, UserId, PgmId : String ) : TUser_AUTH;

  function fnPGMUsedChk(GetField,WRHS,USR_ID,PGM_ID:String) : Boolean ;

  procedure InsertPGMHist(MENU_ID, HIST_TYPE, FUNC_NAME, EVENT_NAME, EVENT_DESC, COMMAND_TYPE, COMMAND_TEXT, PARAM, ERROR_MSG: String);
  function fnGetFileVersionInfo(FileName: String): String;

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
// Eh grid �� excel��
//==============================================================================
procedure fnEhGridExcel  ( RvStr : String; RvGrid : TDBGrid );
var
  FullName : String;
  ExApp : olevariant;
begin
  with MainDm do
  begin
    SaveDlg.FileName := RvStr+'.xls';
    SaveDlg.Title    := '������ ����';
    SaveDlg.Filter   := '��������[ *.xls ]|*.xls';
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
// DB grid �� excel��
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
    SaveDlg.Filter   := '��������[ *.xls ]|*.xls';
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

            // �ʵ� ���� ����
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

            // ����
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

            // Cell ũ�� ����
            XL.Range['A1', s + IntToStr(k)].Select;
            XL.Selection.RowHeight := 15.75;
            XL.Selection.Columns.AutoFit;
            XL.Range['A1', 'A1'].Select;
            XL.Selection.RowHeight := 30;
            XL.Selection.Font.Bold := True;
            XL.Selection.Font.Size := 20 ;
            DataSource.DataSet.First;

            // Excel ����
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
// AddComboList -> Combobox������ �߰�
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
    ComboBox.Items.Add('��ü');
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
// SearchReturn -> ��ȸ���ǿ� �´� ������ ã��
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
// IniRead -> INI ���Ͽ��� Key Field �� ���� ����
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
// IniWrite -> INI ���Ͽ��� Key Field�� ���� ���
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
var
  st : string;
begin
  Result := False;
  MainDm.M_Info.DbType := UpperCase(IniRead(INI_PATH, 'Database', 'Connection', 'MSSQL'));
  if MainDm.M_Info.DbType = 'MSSQL' then
  begin
    MainDm.M_Info.DbOle   := IniRead(INI_PATH, 'Database', 'Provider', '');
    MainDm.M_Info.DbAlais := IniRead(INI_PATH, 'Database', 'Alais'   , '');
    MainDm.M_Info.DbUser  := IniRead( INI_PATH, 'Database', 'User'    , 'sa'  );
    MainDm.M_Info.DbPswd  := IniRead( INI_PATH, 'Database', 'Pswd'    , 'netis4321'  );
    MainDm.M_Info.DbFile  := 'WMS_TEMP';
  end else
  if MainDm.M_Info.DbType = 'ORACLE' then
  begin
    MainDm.M_Info.DbOle   := IniRead(INI_PATH, 'Database', 'Provider', '');
    MainDm.M_Info.DbAlais := IniRead(INI_PATH, 'Database', 'Alais'   , '');
    MainDm.M_Info.DbUser  := IniRead(INI_PATH, 'Database', 'User'    , '');
    MainDm.M_Info.DbPswd  := IniRead(INI_PATH, 'Database', 'Pswd'    , '');
  end;

  try
    with MainDm.MainDB do
    begin
      Close;

      ConnectionString := '';
      ConnectionString := 'Provider=' + MainDm.M_Info.DbOle +
                          ';Persist Security Info=False;User ID=' +
                          MainDm.M_Info.DbUser +
                          ';Data Source=' + MainDm.M_Info.DbAlais +
                          ';Password=' + MainDm.M_Info.DbPswd +
                          ';Initial Catalog=' + MainDm.M_Info.DbFile ;

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
    StrSql := ' Select WRHS, USE_YN, PGM_ID, PGM_NM ' + // �ѱ��� -> Unicode
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
              ' Select WRHS, USE_YN, PGM_ID, PGM_NM ' + // �ѱ��� -> Unicode
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
// SeartchTableData -> �ش� ���̺���  ������ üũ
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
// fnFileFilter -> ���ϸ��� �޾� ���� Ȯ���ڸ� �ٿ��־��ش�.
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
  DataCnt := Length(Data) ;    // �ѱ���

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
// Form�� ĸ�Ǹ��� ���� �´�.
//==============================================================================
function fnSetFormCaption(FormNo : String) : String;
var i : Integer;
begin

  m.ActiveFormID     := FormNo; //�����Ų Menu-ID
  for I := Low(m.Pgm.LANG) to High(m.Pgm.LANG) do
  begin
    if Trim(m.Pgm.LANG[i].FORMID) = '' then Break;
    if m.Pgm.LANG[i].FORMID = FormNo then
       m.ActiveFormName := ' '+FormNo+'. '+ m.Pgm.LANG[i].FORMNM ; //�����Ų Menu-��
  end;
  Result := m.ActiveFormName;
  //fnWmMsgSend_100 ( 100, 1 ); //Ÿ��Ʋ ĸ�� ����
  //frmU130H.Caption :=  m.ActiveFormName;

end;

// �ʵ���� ������ ���õ� ���� ��ȯ �Ѵ�.
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

// �ʵ���� �޴������� ���õ� ���� ��ȯ �Ѵ�.
Function getLangMenuString(FormId, Default : String; LangNo : Integer; addField : String = '') : String;
var i : Integer;
begin
  Result := Default;
  for i := Low(m.Pgm.LANG) to High(m.Pgm.LANG) do begin
    if Trim(m.Pgm.LANG[I].FORMID) = '' then Break;
    if FormId = m.Pgm.LANG[I].FORMID then begin
       Result := m.Pgm.LANG[I].FORMNM[LangNo];

       m.ActiveFormID     := FormId; //�����Ų Menu-ID
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
// SELECT  USER ����
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
// fnPGMUsedChk (����ڿ� ���� �޴� ������ üũ)
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

//==============================================================================
// InsertPGMHist ( W_PROGRAM_HIST ���̺� �̷��� ����)                       //
//==============================================================================
procedure InsertPGMHist(MENU_ID, HIST_TYPE, FUNC_NAME, EVENT_NAME, EVENT_DESC, COMMAND_TYPE, COMMAND_TEXT, PARAM, ERROR_MSG: String);
begin
  try
    with MainDm.PD_INS_PGM_HIST do
    begin
      Close;
      ProcedureName := 'PD_INS_PGM_HIST';
      Parameters.ParamByName('i_MENU_ID'     ).Value := MENU_ID;
      Parameters.ParamByName('i_HIST_TYPE'   ).Value := HIST_TYPE;
      Parameters.ParamByName('i_PGM_FUNCTION').Value := FUNC_NAME;
      Parameters.ParamByName('i_EVENT_NAME'  ).Value := EVENT_NAME;
      Parameters.ParamByName('i_EVENT_DESC'  ).Value := EVENT_DESC;
      Parameters.ParamByName('i_COMMAND_TYPE').Value := COMMAND_TYPE;
      Parameters.ParamByName('i_COMMAND_TEXT').Value := COMMAND_TEXT;
      Parameters.ParamByName('i_PARAM'       ).Value := PARAM;
      Parameters.ParamByName('i_ERROR_MSG'   ).Value := ERROR_MSG;
      Parameters.ParamByName('i_USER_ID'     ).Value := MainDm.M_Info.UserCode + ' ['+MainDm.M_Info.ActivePCAddr+']';
      ExecProc;
      Close;
    end;
  except
    on E : Exception do
    begin
      MainDm.PD_INS_PGM_HIST.Close;
      TraceLogWrite('[000] procedure InsertPGMHist Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// fnGetFileVersionInfo                                                       //
//==============================================================================
function fnGetFileVersionInfo(FileName: String): String;
var
  Size, Size2: DWord;
  Pt, Pt2: Pointer;
begin
  Result := '';
  try
    Size := GetFileVersionInfoSize(pChar(FileName), Size2);
    if Size > 0 then
    begin
      GetMem(Pt, Size);
      try
        GetFileVersionInfo(pChar(FileName), 0, Size, Pt);
        VerQueryValue (Pt, '\', Pt2, Size2);
        with TVSFixedFileInfo(Pt2^) do
        begin
{
          Result := Format('%d.%d.%d.%d', [HiWord(dwFileVersionMS),
                                           LoWord(dwFileVersionMS),
                                           HiWord(dwFileVersionLS),
                                           LoWord(dwFileVersionLS)]);
}

          Result := Format('%d.%d', [HiWord(dwFileVersionMS),
                                     LoWord(dwFileVersionLS)]);
        end;
      finally
        FreeMem(Pt);
      end;
    end;
  except
    on E: Exception do
    begin
      InsertPGMHist('[000]', 'E', 'fnGetFileVersionInfo', '����', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('[000] function fnGetFileVersionInfo Fail || ERR['+E.Message+'], STR['+FileName+']');
    end;
  end;
end;


end.

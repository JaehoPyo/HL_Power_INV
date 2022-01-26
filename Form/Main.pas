unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ComCtrls, ToolWin, Menus, ExtCtrls,  StdCtrls, DB, ADODB,
  d_MainDm, h_MainLib, h_ReferLib, Grids, DBGrids, DBCtrls, Mask,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh,
  Vcl.Imaging.GIFImg, ShellAPI, CPort, Vcl.Tabs, System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList;

type
  TfrmMain = class(TForm)
    tmrSystem: TTimer;
    qryCommChk: TADOQuery;
    tmrConnectCheck: TTimer;
    qryDBChk: TADOQuery;
    mnuMain: TMainMenu;
    M1000: TMenuItem;
    M1100: TMenuItem;
    M2000: TMenuItem;
    M2100: TMenuItem;
    M2200: TMenuItem;
    M2300: TMenuItem;
    M3000: TMenuItem;
    M3100: TMenuItem;
    M3200: TMenuItem;
    M4000: TMenuItem;
    M4100: TMenuItem;
    M4200: TMenuItem;
    M5000: TMenuItem;
    M5100: TMenuItem;
    M5200: TMenuItem;
    Img_Main: TImage;
    qryOrderDel: TADOQuery;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel22: TPanel;
    LblMenu000: TLabel;
    Panel11: TPanel;
    Pnl_BTN: TPanel;
    Pnl_Btn5: TPanel;
    cmdEXCEL: TSpeedButton;
    Pnl_Btn6: TPanel;
    cmdPRINT: TSpeedButton;
    Pnl_Btn7: TPanel;
    cmdINQUIRY: TSpeedButton;
    Pnl_Btn10: TPanel;
    cmdCLOSE: TSpeedButton;
    Pnl_Btn2: TPanel;
    cmdREGISTER: TSpeedButton;
    Pnl_Btn8: TPanel;
    cmdPREV: TSpeedButton;
    Pnl_Btn9: TPanel;
    cmdNEXT: TSpeedButton;
    Pnl_Btn3: TPanel;
    cmdDELETE: TSpeedButton;
    Pnl_Btn1: TPanel;
    cmdORDER: TSpeedButton;
    Pnl_Btn4: TPanel;
    cmdUPDATE: TSpeedButton;
    Panel28: TPanel;
    staLoginInfo: TStatusBar;
    PnlDatabaseConn: TPanel;
    LblDatabaseConn: TLabel;
    ShpDatabaseConn: TShape;
    PnlMFCInterfaceConn: TPanel;
    LblMFCInterfaceConn: TLabel;
    ShpMFCInterfaceConn1: TShape;
    ShpMFCInterfaceConn2: TShape;
    tmrLogFileCheck: TTimer;
    PnlSBar2: TPanel;
    LblVersion: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnClick(Sender: TObject);
    procedure execMenuClick(Sender: TObject);
    procedure tmrSystemTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tmrConnectCheckTimer(Sender: TObject);
    procedure tmrLogFileCheckTimer(Sender: TObject);
    procedure staLoginInfoDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
  private
    { Private declarations }
    procedure execMenuActive( Menu_Number : Integer );
  public
    { Public declarations }
    procedure CommChk ;
    procedure OrderDel;
    procedure fnCloseSet;
    procedure CloseChkMsg(Sender: TObject);
    procedure WmMsgRecv( var Message : TMessage); message WM_USER;
    function  fnDBConChk: Boolean;

    // 로그자동삭제 관련
    procedure LogFileDelete;
    Function  DeleteRecodingFile(fileDir: string; iOption: integer): boolean;
    function  MinDeleteFile(const DirName : string; const UseRecycleBin: Boolean): Boolean;

    // 프로그램 초기 설정
    procedure CreateConfig;
  end;

const
  FormNo ='000';

var
  frmMain: TfrmMain;
  DeleteOption : integer ;

  CloseChk : Boolean ;
  SC_COMM  : Boolean ;

implementation

uses U110;//, U210, U220, U230, U310, U320, U410, U420, U510, U520 ;

{$R *.dfm}

//==============================================================================
// FormCreate
//==============================================================================
procedure TfrmMain.FormCreate(Sender: TObject);
var
  tmp : String ;
begin
  m.MainHd := Handle;
  MainDm.M_Info.ReLogin := False;
  CloseChk := False;

  MainDm.pVersion := 'v' + fnGetFileVersionInfo(Application.Exename);
  lblVerSion.Caption := MainDm.pVersion;

  MainDm.M_Info.ActivePCName := SysGetComputerName; // PC Name
  MainDm.M_Info.ActivePCAddr := SysGetLocalIp(1);   // PC Ip-Address

  if not ADOConnection then
  begin
    MessageDlg('서버 연결에 실패하였습니다.', mtError, [mbYes], 0) ;
    ExitProcess(0);
  end;

  CloseChk := False ;
  CreateConfig;

  frmMain.Caption := IniRead( INI_PATH, 'PROGRAM', 'ProgramName' ,'부산교통공사 자동 창고 관리시스템' );
  fnWmMsgSend( 22222,22222 );
end;

//==============================================================================
// FormActivate
//==============================================================================
procedure TfrmMain.FormActivate(Sender: TObject);
begin
  if not tmrConnectCheck.Enabled then tmrConnectCheck.Enabled := True ;
end;

//==============================================================================
// FormCloseQuery
//==============================================================================
procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not CloseChk then
  begin
    CloseChkMsg(nil);
    CanClose := False;
  end;
end;

//==============================================================================
// CloseChkMsg
//==============================================================================
procedure TfrmMain.CloseChkMsg(Sender: TObject);
begin
  if MessageDlg('프로그램을 종료하시겠습니까?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    CloseChk := True ;
    Close;
  end;
end;

//==============================================================================
// fnCloseSet
//==============================================================================
procedure TfrmMain.fnCloseSet;
var
  i : integer ;
begin
  for i := 0 to Self.ComponentCount-1 do
  begin
    if (Self.Components[i] is TTimer) then
       (Self.Components[i] as TTimer).Enabled := False ;
  end;

  for i := 0 to Self.ComponentCount-1 Do
  begin
    if (Self.Components[i] is TADOQuery) then
       (Self.Components[i] as TADOQuery).Active := False ;
  end;
  if MainDM.MainDB.Connected then MainDM.MainDB.Close ;
end;

//==============================================================================
// FormClose
//==============================================================================
procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fnCloseSet;
  ExitProcess(0);
end;

//==============================================================================
// CreateConfig
//==============================================================================
procedure TfrmMain.CreateConfig;
var
  i : integer;
  tFName, tFSize, tFPath, tCDate, tADate, tUDate, TitleStr : String;
begin
  try
    if not DirectoryExists('.\Log') then ForceDirectories('.\Log');

    //inDm.M_Info.LANG_PGM := fnMenuNameGetRecord(MainDm.M_Info.WRHS, MainDm.M_Info.LANG_TYPE); // 메뉴명
    //fnMenuChange;

    frmMain.Caption    := IniRead(INI_PATH, 'PROGRAM', 'CompanyName', '') + ' ' +
                          IniRead(INI_PATH, 'PROGRAM', 'CompanyKind', '') + ' ' +
                          IniRead(INI_PATH, 'PROGRAM', 'ProgramName', '') + ' ' +
                          MainDm.pVersion;
    frmMain.Hint       := IniRead(INI_PATH, 'PROGRAM', 'ProgramName', '') + ' ' + MainDm.pVersion;
    LblMenu000.Caption := frmMain.Hint;
    MainDm.M_Info.ActiveFormID   := '000';
    MainDm.M_Info.ActiveFormName := frmMain.Hint;

    fnDBConChk;

    staLoginInfo.Panels[00].Text := IniRead(INI_PATH, 'PROGRAM', 'CompanyName', '');
    staLoginInfo.Panels[01].Text := MainDm.M_Info.ActivePCName + ' [' + MainDm.M_Info.ActivePCAddr + ']';
    staLoginInfo.Panels[02].Text := FormatDateTime( 'YYYY-MM-DD HH:NN:SS', Now);

    staLoginInfo.Panels[03].Style := psOwnerDraw ;
    PnlSBar2.Parent := staLoginInfo ;

    staLoginInfo.Panels[04].Style := psOwnerDraw ;
    PnlMFCInterfaceConn.Parent := staLoginInfo ;

    staLoginInfo.Panels[05].Style := psOwnerDraw ;
    PnlDatabaseConn.Parent := staLoginInfo ;

    tmrConnectCheck.Enabled := True ;
    tmrSystem.Enabled := True;

    LblVersion.Hint := TitleStr;
  except
    on E : Exception do
    begin
      InsertPGMHist('[000]', 'E', 'CreateConfig', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('[000] procedure CreateConfig Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// WmMsgRecv (툴바 버튼 활성화 여부)
//==============================================================================
procedure TfrmMain.WmMsgRecv(var Message : TMessage);
  Procedure ToolBtnSet(TBtnNo: Integer; Status: String);
  var
    BtnStatus : Boolean;
  begin
    if Status = '1' then BtnStatus := True else BtnStatus := False;
    case TBtnNo of
      1  : begin cmdORDER.Enabled    := BtnStatus ; cmdORDER.Font.Color    := BTN_FONT_COLOR[StrToInt(Status)];   {cmdORDER.Caption    := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// 지시
      2  : begin cmdREGISTER.Enabled := BtnStatus ; cmdREGISTER.Font.Color := BTN_FONT_COLOR[StrToInt(Status)];   {cmdREGISTER.Caption := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// 등록
      3  : begin cmdDELETE.Enabled   := BtnStatus ; cmdDELETE.Font.Color   := BTN_FONT_COLOR[StrToInt(Status)];   {cmdDELETE.Caption   := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// 삭제
      4  : begin cmdUPDATE.Enabled   := BtnStatus ; cmdUPDATE.Font.Color   := BTN_FONT_COLOR[StrToInt(Status)];   {cmdUPDATE.Caption   := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// 수정
      5  : begin cmdEXCEL.Enabled    := BtnStatus ; cmdEXCEL.Font.Color    := BTN_FONT_COLOR[StrToInt(Status)];   {cmdEXCEL.Caption    := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// 엑셀
      6  : begin cmdPRINT.Enabled    := BtnStatus ; cmdPRINT.Font.Color    := BTN_FONT_COLOR[StrToInt(Status)];   {cmdPRINT.Caption    := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// 인쇄
      7  : begin cmdINQUIRY.Enabled  := BtnStatus ; cmdINQUIRY.Font.Color  := BTN_FONT_COLOR[StrToInt(Status)];   {cmdINQUIRY.Caption  := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// 조회
      8  : begin cmdPREV.Enabled     := BtnStatus ; cmdPREV.Font.Color     := BTN_FONT_COLOR[StrToInt(Status)];   {cmdPREV.Caption     := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// 이전
      9  : begin cmdNEXT.Enabled     := BtnStatus ; cmdNEXT.Font.Color     := BTN_FONT_COLOR[StrToInt(Status)];   {cmdNEXT.Caption     := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// 다음
      10 : begin cmdCLOSE.Enabled    := BtnStatus ; cmdCLOSE.Font.Color    := BTN_FONT_COLOR[StrToInt(Status)];   {cmdCLOSE.Caption    := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// 닫기
    end;
  end;
var
  i : Integer;
  RecvStr : String;
begin
  RecvStr := IntToStr(Message.WParam) + IntToStr(Message.LParam);
  for i := 1 to Length(RecvStr) do
  begin
    ToolBtnSet(i, Copy(RecvStr, i , 1));
  end;
end;

//==============================================================================
// btnClick (툴바버튼 클릭 이벤트 -> [엑셀][등록][인쇄][조회][닫기][언어])
//==============================================================================
procedure TfrmMain.btnClick(Sender: TObject);
begin
  if      ( Sender As  TSpeedButton ) =  cmdNEXT then // 다음 폼
    Next
  else if ( Sender As  TSpeedButton ) =  cmdPREV then // 이전 폼
    Previous
  else if ( ActiveMDIChild  <>  nil ) then
    SendMessage( ActiveMDIChild.Handle, WM_USER , TSpeedButton(Sender).Tag , 0 );
end;

//==============================================================================
// tmrSystemTimer
//==============================================================================
procedure TfrmMain.tmrSystemTimer(Sender: TObject);
begin
  try
    tmrSystem.Enabled := False;
    staLoginInfo.Panels[05].Text := FormatDateTime( 'YYYY-MM-DD HH:NN:SS', Now);

    if MdiChildCount = 0 then
    begin
      fnWmMsgSend(2222222, 222);
      MainDm.M_Info.ActiveFormID   := '000';
      MainDm.M_Info.ActiveFormName := frmMain.Hint;
      LblMenu000.Caption := frmMain.Hint;
    end;
  finally
    tmrSystem.Enabled := True;
  end;
end;

//==============================================================================
// execMenuClick (상단 메뉴버튼 클릭 이벤트)
//==============================================================================
procedure TfrmMain.execMenuClick(Sender: TObject);
begin
  if StrToInt(Copy ( TMenuItem( Sender).Name , 2, 4 )) <> 0 Then
  begin
    m.ActiveFormID := Copy ( TMenuItem( Sender).Name , 2, 4 );
    execMenuActive( StrToInt(Copy ( TMenuItem( Sender).Name , 2, 4 )) );
  end;
end;

//==============================================================================
// execMenuActive (메뉴번호에 따라 해당하는 폼을 활성화)
//==============================================================================
procedure TfrmMain.execMenuActive(Menu_Number: Integer);
begin
  case Menu_Number of

    // 코드관리------------------------------------------
    1100 : U110Create() ;          // 기종정보관리
    // 입출고관리------------------------------------------
//    2100 : U210Create();           // 입출고 진행현황
//    2200 : U220Create();           // 입고 작업등록
//    2300 : U230Create();           // 출고 작업등록
    // 재고관리
//    3100 : U310Create();           // Cell 모니터링
//    3200 : U320Create();           // 지정출고
    // 실적관리------------------------------------------
//    4100 : U410Create();           // 출고검사
//    4200 : U420Create();           // 지정출고
    // 모니터링------------------------------------------
//    5100 : U510Create();           // 설비 모니터링
//    5200 : U520Create();           // 설비 에러 이력 조회
//    else exit;
  end;
end;

//==============================================================================
// tmrConnectCheckTimer
//==============================================================================
procedure TfrmMain.tmrConnectCheckTimer(Sender: TObject);
var
  i : integer;
begin
  try
    tmrConnectCheck.Enabled := False ;
    if not fnDBConChk then
    begin
      ADOConnection ;
    end;
  finally
    tmrConnectCheck.Enabled := True ;
  end;
end;

//==============================================================================
// fnDBConChk
//==============================================================================
function TfrmMain.fnDBConChk: Boolean;
var
  StrSQL : String;
begin
  Result := False ;
  try
    with qryDBChk do
    begin
      Close;
      SQL.Clear ;
      StrSQL := ' SELECT GETDATE() as DBCheck ' ;
      SQL.Text := StrSQL ;
      Open ;
      if not (Bof and Eof) then
      begin
        Result := True ;
        m.ConChk := True ;
        frmMain.ShpDatabaseConn.Brush.Color := CONN_STATUS_COLOR[1];

        SQL.Clear;
        StrSQL := ' SELECT INT_NAME, INT_M_NO, (CASE WHEN INT_DATE > DATEADD(SECOND, -5, GETDATE()) THEN 1 ELSE 0 END) STATUS ' +
                  '   FROM TC_INT_STATUS WITH (NOLOCK) ' ;
        SQL.Text := StrSQL;
        Open;
        if not (Bof and Eof) then
        begin
          while not (Eof) do
          begin
            TShape(Self.FindComponent('ShpMFCInterfaceConn'+FieldByName('INT_M_NO').AsString)).Brush.Color := CONN_STATUS_COLOR[FieldByName('STATUS').AsInteger];
            Next;
          end;
        end else
        begin
          frmMain.ShpMFCInterfaceConn1.Brush.Color := CONN_STATUS_COLOR[0];
          frmMain.ShpMFCInterfaceConn2.Brush.Color := CONN_STATUS_COLOR[0];
        end;
      end else
      begin
        frmMain.ShpDatabaseConn.Brush.Color      := CONN_STATUS_COLOR[0];
        frmMain.ShpMFCInterfaceConn1.Brush.Color := CONN_STATUS_COLOR[0];
        frmMain.ShpMFCInterfaceConn2.Brush.Color := CONN_STATUS_COLOR[0];
      end;
      Close;
    end;
  except
    on E : Exception do
    begin
      qryDBChk.Close;
      m.ConChk := False ;
      frmMain.ShpDatabaseConn.Brush.Color     := CONN_STATUS_COLOR[0];
      frmMain.ShpMFCInterfaceConn1.Brush.Color := CONN_STATUS_COLOR[0];
      frmMain.ShpMFCInterfaceConn2.Brush.Color := CONN_STATUS_COLOR[0];
    end;
  end;
end;

//==============================================================================
// CommChk
//==============================================================================
procedure TfrmMain.CommChk;
var
  StrSQL : String;
begin
  try
    StrSQL := ' SELECT (CASE WHEN SCC_DT > (SELECT SYSDATE - (((1/24)/60)/12) FROM DUAL) ' +
              '              THEN 1 ELSE 0 END) AS STATUS ' +
              '  FROM TT_SCC ' +
              ' WHERE SCC_SR=''R'' ' ;

    with qryCommChk do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL;
      Open;
      if Not (eof and bof) then
      begin
        SC_COMM := Boolean(StrToInt(FieldByName('STATUS').AsString)) ;
      end;
      Close;
    end;
  except
    if qryCommChk.Active then qryCommChk.Close ;
  end;
end;

//==============================================================================
// OrderDel
//==============================================================================
procedure TfrmMain.OrderDel;
var
  StrSQL, DelDate : String;
begin
  try
    DelDate := IntToStr(StrToInt(FormatDateTime('YYYYMMDD',Now))-1) ;

    DelDate := DelDate + '000000' ;

    StrSQL := ' DELETE FROM TT_ORDER ' +
              '  WHERE REG_TIME <  ''' + DelDate + ''' ';

    with qryOrderDel do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL;
      ExecSQL;
      Close;
    end;
  except
    if qryOrderDel.Active then qryOrderDel.Close ;
  end;
end;

//==============================================================================
// staLoginInfoDrawPanel
//==============================================================================
procedure TfrmMain.staLoginInfoDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
begin
  try
    if Panel = staLoginInfo.Panels[03] then
    begin
      with PnlSBar2 do
      begin
        Top := Rect.Top - 1 ;
        Left := Rect.Left ;
      end;
    end;

    if Panel = staLoginInfo.Panels[04] then
    begin
      with PnlMFCInterfaceConn do
      begin
        Top := Rect.Top - 1 ;
        Left := Rect.Left ;
      end;
    end;

    if Panel = staLoginInfo.Panels[05] then
    begin
      with PnlDatabaseConn do
      begin
        Top := Rect.Top - 1 ;
        Left := Rect.Left ;
      end;
    end;
  except
    on E : Exception do
    begin
      InsertPGMHist('[000]', 'E', 'staLoginInfoDrawPanel', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('[000] procedure staLoginInfoDrawPanel Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// 로그자동 삭제 관련 함수
//==============================================================================
procedure TfrmMain.tmrLogFileCheckTimer(Sender: TObject);
begin
  try
    tmrLogFileCheck.Enabled := False ;
    LogFileDelete ;
  finally
    tmrLogFileCheck.Enabled := True ;
  end;
end;

procedure TfrmMain.LogFileDelete;
var
  i : integer ;
  DeleteDir : String ;
begin
  DeleteDir := '.\Log\';
  if (DeleteDir <> '') and
     (DeleteOption in [0..2])then
  begin
    DeleteRecodingFile(DeleteDir, DeleteOption);
    InsertPGMHist('[000]', 'N', 'LogFileDelete', '', 'Automatically Delete Log ['+IntToStr(DeleteOption)+']', 'PGM', '', '', '');
  end;
end;

function TfrmMain.DeleteRecodingFile(fileDir: String; iOption: integer): Boolean;
var
  FoundFile : Integer;
  SearchRec : TSearchRec;
  stLogDir  : string;
  Sdate : TDateTime;
begin
  Sdate :=  Now();
  result := true;
  stLogDir := fileDir + '*';
  try
    FoundFile := findfirst(stLogDir,faAnyFile,SearchRec);
    while FoundFile = 0 do
    begin
      Application.ProcessMessages;
      case iOption of
       0 : if (Sdate - FileDateToDateTime(SearchRec.Time)) >= 30 then
           begin
             if (SearchRec.name <> '.') and (SearchRec.name <> '..') then
             MinDeleteFile(fileDir + SearchRec.name, true); //
           end;
       1 : if (Sdate - FileDateToDateTime(SearchRec.Time)) >= 7 then
           begin
             if (SearchRec.name <> '.') and (SearchRec.name <> '..') then
             MinDeleteFile(fileDir + SearchRec.name, true); //
           end;
       2 : if (SearchRec.name <> '.') and (SearchRec.name <> '..') then
           MinDeleteFile(fileDir + SearchRec.name, true); //
      end;
      FoundFile := findnext(SearchRec);
    end;
    FindClose(SearchRec);
  except
    FindClose(SearchRec);
    result := false;
  end;
end;

function TfrmMain.MinDeleteFile(const DirName : string;
const UseRecycleBin: Boolean): Boolean;
var
  SHFileOpStruct: TSHFileOpStruct;
  DirBuf: array [0..255] of char;
  Directory: string;
begin
  try
    Directory := ExcludeTrailingPathDelimiter(DirName);

    Fillchar(SHFileOpStruct, sizeof(SHFileOpStruct), 0);
    FillChar(DirBuf, sizeof(DirBuf), 0);
    StrPCopy(DirBuf, Directory);

    with SHFileOpStruct do
    begin
      Wnd := 0;
      pFrom := @DirBuf;
      wFunc := FO_DELETE;
      if UseRecycleBin = True then
      fFlags := FOF_NOCONFIRMATION or FOF_SILENT;
    end;
    Result := (SHFileOperation(SHFileOpStruct)=0);
  except
    Result := False;
  end;
end;

initialization
  //중복 실행 방지 코드 부분
  CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, 1, 'BST_AWS');
  if GetlastError = ERROR_ALREADY_EXISTS then halt;
end.

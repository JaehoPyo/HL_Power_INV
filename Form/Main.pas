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
    M2400: TMenuItem;
    qryTemp: TADOQuery;
    M5300: TMenuItem;
    M4300: TMenuItem;
    Lbl_error: TLabel;
    qryInfo: TADOQuery;
    tmrQry: TTimer;
    tmrErrorColor: TTimer;
    ShpMFCInterfaceConn3: TShape;
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
    procedure tmrQryTimer(Sender: TObject);
    procedure tmrErrorColorTimer(Sender: TObject);
  private
    { Private declarations }
    procedure execMenuActive( Menu_Number : Integer );
  public
    { Public declarations }
    procedure fnCloseSet;
    procedure CloseChkMsg(Sender: TObject);
    procedure WmMsgRecv( var Message : TMessage); message WM_USER;
    function fnDBConChk: Boolean;
    function fnErrorMsg(Signal: string): Boolean;
    function fnCaptionMsg(Signal, Number: string): String;
    function fnCaptionErrorMsg(Signal: string): String;
    function fnJobErrorChk(Signal: string): String;

    procedure SCTREAD(SC_NO: Integer);
    procedure SC_StatusDisplay(SC_NO: Integer);

    // �α��ڵ����� ����
    procedure LogFileDelete;
    procedure HistoryDelete;
    Function  DeleteRecodingFile(fileDir: string; iOption: integer): boolean;
    function  MinDeleteFile(const DirName : string; const UseRecycleBin: Boolean): Boolean;

    // ���α׷� �ʱ� ����
    procedure CreateConfig;
  end;

const
  FormNo ='000';

var
  frmMain: TfrmMain;
  DeleteOption : integer ;
  SC_STATUS : Array [START_SCNO..End_SCNO] of TSC_STATUS ;    // SC ����

  CloseChk : Boolean ;
  ErrorChk_Visibel : Boolean ;
  ErrorChk_Caption : Boolean ;
  SC_COMM  : Boolean ;

implementation

uses U110, U210, U220, U230, U240, U310, U320, U410, U420, U430, U510, U520, U530 ;

{$R *.dfm}

//==============================================================================
// FormCreate
//==============================================================================
procedure TfrmMain.FormCreate(Sender: TObject);
var
  tmp : String ;
begin
  try
    m.MainHd := Handle;
    MainDm.M_Info.ReLogin := False;
    CloseChk := False;

    LblMenu000.Caption := '';

    MainDm.pVersion := 'v' + fnGetFileVersionInfo(Application.Exename);
    lblVerSion.Caption := MainDm.pVersion;

    MainDm.M_Info.ActivePCName := SysGetComputerName; // PC Name
    MainDm.M_Info.ActivePCAddr := SysGetLocalIp(1);   // PC Ip-Address

    MainDm.M_Info.WRHS       := IniRead(INI_PATH, 'UserSeting', 'WRHS', 'D');                 // WareHouse Kind
    MainDm.M_Info.LANG_TYPE  := 1;

    if not ADOConnection then
    begin
      MessageDlg('���� ���ῡ �����Ͽ����ϴ�.', mtError, [mbYes], 0) ;
      ExitProcess(0);
    end;

    CloseChk := False ;
    CreateConfig;

    frmMain.Caption := IniRead( INI_PATH, 'PROGRAM', 'ProgramName' ,'�λ걳����� �ڵ� â�� �����ý���' );
    fnWmMsgSend( 22222,22222 );

    // �α� ���� �ɼ�
    DeleteOption := StrToIntDef(IniRead(INI_PATH, 'Delete', 'DeleteOption', '0'), 0);
    LogFileDelete;
    HistoryDelete;

    InsertPGMHist('[000]', 'N', 'FormCreate', '����', 'Program Start ' + MainDm.pVersion, 'PGM', '', '', '');
    TraceLogWrite('Program Start ' + MainDm.pVersion + ' ['+MainDm.M_Info.UserCode+']');
  except
    on E : Exception do
    begin
      InsertPGMHist('[000]', 'E', 'FormCreate', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('[000] procedure FormCreate Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// FormActivate
//==============================================================================
procedure TfrmMain.FormActivate(Sender: TObject);
begin
  if not tmrConnectCheck.Enabled then tmrConnectCheck.Enabled := True ;
  if not tmrQry.Enabled then tmrQry.Enabled := True ;
  if not tmrErrorColor.Enabled then tmrErrorColor.Enabled := True ;
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
  if MessageDlg('���α׷��� �����Ͻðڽ��ϱ�?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
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

    MainDm.M_Info.LANG_PGM := fnMenuNameGetRecord(MainDm.M_Info.WRHS, MainDm.M_Info.LANG_TYPE); // �޴���
    //fnMenuChange;

    frmMain.Caption    := IniRead(INI_PATH, 'PROGRAM', 'CompanyName', '') + ' ' +
                          IniRead(INI_PATH, 'PROGRAM', 'CompanyKind', '') + ' ' +
                          IniRead(INI_PATH, 'PROGRAM', 'ProgramName', '') + ' ' +
                          MainDm.pVersion;
    frmMain.Hint       := IniRead(INI_PATH, 'PROGRAM', 'ProgramName', '') + ' ' + MainDm.pVersion;
    LblMenu000.Caption := '000. ����ȭ��';
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
// WmMsgRecv (���� ��ư Ȱ��ȭ ����)
//==============================================================================
procedure TfrmMain.WmMsgRecv(var Message : TMessage);
  Procedure ToolBtnSet(TBtnNo: Integer; Status: String);
  var
    BtnStatus : Boolean;
  begin
    if Status = '1' then BtnStatus := True else BtnStatus := False;
    case TBtnNo of
      1  : begin cmdORDER.Enabled    := BtnStatus ; cmdORDER.Font.Color    := BTN_FONT_COLOR[StrToInt(Status)];   {cmdORDER.Caption    := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// ����
      2  : begin cmdREGISTER.Enabled := BtnStatus ; cmdREGISTER.Font.Color := BTN_FONT_COLOR[StrToInt(Status)];   {cmdREGISTER.Caption := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// ���
      3  : begin cmdDELETE.Enabled   := BtnStatus ; cmdDELETE.Font.Color   := BTN_FONT_COLOR[StrToInt(Status)];   {cmdDELETE.Caption   := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// ����
      4  : begin cmdUPDATE.Enabled   := BtnStatus ; cmdUPDATE.Font.Color   := BTN_FONT_COLOR[StrToInt(Status)];   {cmdUPDATE.Caption   := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// ����
      5  : begin cmdEXCEL.Enabled    := BtnStatus ; cmdEXCEL.Font.Color    := BTN_FONT_COLOR[StrToInt(Status)];   {cmdEXCEL.Caption    := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// ����
      6  : begin cmdPRINT.Enabled    := BtnStatus ; cmdPRINT.Font.Color    := BTN_FONT_COLOR[StrToInt(Status)];   {cmdPRINT.Caption    := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// �μ�
      7  : begin cmdINQUIRY.Enabled  := BtnStatus ; cmdINQUIRY.Font.Color  := BTN_FONT_COLOR[StrToInt(Status)];   {cmdINQUIRY.Caption  := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// ��ȸ
      8  : begin cmdPREV.Enabled     := BtnStatus ; cmdPREV.Font.Color     := BTN_FONT_COLOR[StrToInt(Status)];   {cmdPREV.Caption     := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// ����
      9  : begin cmdNEXT.Enabled     := BtnStatus ; cmdNEXT.Font.Color     := BTN_FONT_COLOR[StrToInt(Status)];   {cmdNEXT.Caption     := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// ����
      10 : begin cmdCLOSE.Enabled    := BtnStatus ; cmdCLOSE.Font.Color    := BTN_FONT_COLOR[StrToInt(Status)];   {cmdCLOSE.Caption    := BTN_CAPTION[TBtnNo, StrToInt(Status)];} end;// �ݱ�
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
// btnClick (���ٹ�ư Ŭ�� �̺�Ʈ -> [����][���][�μ�][��ȸ][�ݱ�][���])
//==============================================================================
procedure TfrmMain.btnClick(Sender: TObject);
begin
  if      ( Sender As  TSpeedButton ) =  cmdNEXT then // ���� ��
    Next
  else if ( Sender As  TSpeedButton ) =  cmdPREV then // ���� ��
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
    try
      tmrSystem.Enabled := False;
      staLoginInfo.Panels[05].Text := FormatDateTime( 'YYYY-MM-DD HH:NN:SS', Now);

      if MdiChildCount = 0 then
      begin
        fnWmMsgSend(2222222, 22222);
        MainDm.M_Info.ActiveFormID   := '000';
        MainDm.M_Info.ActiveFormName := frmMain.Hint;
        LblMenu000.Caption := MainDm.M_Info.ActiveFormID + '. ' + getLangMenuString(MainDm.M_Info.ActiveFormID, frmMain.LblMenu000.Caption, MainDm.M_Info.LANG_TYPE, 'N');
      end;
    finally
      tmrSystem.Enabled := True;
    end;
  except
    on E : Exception do
    begin
      InsertPGMHist('[000]', 'E', 'tmrSystemTimer', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('[000] procedure tmrSystemTimer Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// execMenuClick (��� �޴���ư Ŭ�� �̺�Ʈ)
//==============================================================================
procedure TfrmMain.execMenuClick(Sender: TObject);
begin
  try
    if StrToInt(Copy ( TMenuItem( Sender).Name , 2, 4 )) <> 0 Then
    begin
      m.ActiveFormID := Copy ( TMenuItem( Sender).Name , 2, 4 );
      execMenuActive( StrToInt(Copy ( TMenuItem( Sender).Name , 2, 4 )) );
    end;
  except
    on E : Exception do
    begin
      InsertPGMHist('[000]', 'E', 'execMenuLblClick', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('[000] procedure execMenuLblClick Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// execMenuActive (�޴���ȣ�� ���� �ش��ϴ� ���� Ȱ��ȭ)
//==============================================================================
procedure TfrmMain.execMenuActive(Menu_Number: Integer);
begin
  case Menu_Number of

    // �ڵ����------------------------------------------
    1100 : U110Create() ;          // ������������
    // ��������------------------------------------------
    2100 : U210Create();           // ����� ������Ȳ
    2200 : U220Create();           // �԰� �۾����
    2300 : U230Create();           // ��� �۾����
    2400 : U240Create();           // ��� �۾����
    // ������
    3100 : U310Create();           // Cell ����͸�
    3200 : U320Create();           // �������
    // ��������------------------------------------------
    4100 : U410Create();           // ���˻�
    4200 : U420Create();           // �������
    4300 : U430Create();           // �������
    // ����͸�------------------------------------------
    5100 : U510Create();           // ���� ����͸�
    5200 : U520Create();           // ���� ���� �̷� ��ȸ
    5300 : U530Create();           // ���α׷� ����̷�
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
    try
      tmrConnectCheck.Enabled := False ;
      if not fnDBConChk then
      begin
        ADOConnection ;
      end;
    finally
      tmrConnectCheck.Enabled := True ;
    end;
  except
    on E : Exception do
    begin
      InsertPGMHist('[000]', 'E', 'tmrConnectCheckTimer', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('[000] procedure tmrConnectCheckTimer Fail || ERR['+E.Message+']');
    end;
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
        StrSQL := ' SELECT SCC_SR, SCC_NO, (CASE WHEN SCC_DT > DATEADD(SECOND, -5, GETDATE()) THEN 1 ELSE 0 END) STATUS ' +
                  '   FROM TT_SCC WITH (NOLOCK) ' ;
        SQL.Text := StrSQL;
        Open;
        if not (Bof and Eof) then
        begin
          while not (Eof) do
          begin
            TShape(Self.FindComponent('ShpMFCInterfaceConn1')).Brush.Color := CONN_STATUS_COLOR[FieldByName('STATUS').AsInteger];
            Next;
          end;
        end else
        begin
          frmMain.ShpMFCInterfaceConn2.Brush.Color := CONN_STATUS_COLOR[0];
        end;
        SQL.Clear;
        StrSQL := ' SELECT (CASE WHEN OPTION1 = ''1'' THEN 1 ELSE 0 END) STATUS ' +
                  '   FROM TC_CURRENT WITH (NOLOCK) ' +
                  '  WHERE CURRENT_NAME = ''ACS_INT'' ';
        SQL.Text := StrSQL;
        Open;
        if not (Bof and Eof) then
        begin
          while not (Eof) do
          begin
            TShape(Self.FindComponent('ShpMFCInterfaceConn2')).Brush.Color := CONN_STATUS_COLOR[FieldByName('STATUS').AsInteger];
            Next;
          end;
        end else
        begin
          frmMain.ShpMFCInterfaceConn2.Brush.Color := CONN_STATUS_COLOR[0];
        end;
        SQL.Clear;
        StrSQL := ' SELECT (CASE WHEN OPTION1 = ''1'' THEN 1 ELSE 0 END) STATUS ' +
                  '   FROM TC_CURRENT WITH (NOLOCK) ' +
                  '  WHERE CURRENT_NAME = ''RCP'' ';
        SQL.Text := StrSQL;
        Open;
        if not (Bof and Eof) then
        begin
          while not (Eof) do
          begin
            TShape(Self.FindComponent('ShpMFCInterfaceConn3')).Brush.Color := CONN_STATUS_COLOR[FieldByName('STATUS').AsInteger];
            Next;
          end;
        end else
        begin
          frmMain.ShpMFCInterfaceConn3.Brush.Color := CONN_STATUS_COLOR[0];
        end;
      end else
      begin
        frmMain.ShpDatabaseConn.Brush.Color      := CONN_STATUS_COLOR[0];
        frmMain.ShpMFCInterfaceConn1.Brush.Color := CONN_STATUS_COLOR[0];
        frmMain.ShpMFCInterfaceConn2.Brush.Color := CONN_STATUS_COLOR[0];
        frmMain.ShpMFCInterfaceConn3.Brush.Color := CONN_STATUS_COLOR[0];
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
// �α��ڵ� ���� ���� �Լ�
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


//==============================================================================
// HistoryDelete
//==============================================================================
procedure TfrmMain.HistoryDelete;
var
  ExecNo : integer;
  StrSQL : String;
begin
  try
    with qryTemp do
    begin
{
      ExecNo := 0;
      Close;
      SQL.Clear;
      StrSQL := ' DELETE FROM TT_PROGRAM_HIST ' +
                '  WHERE CRT_DT < GETDATE() - 15 ' ;
      SQL.Text := StrSQL;
      ExecNo := ExecSQL;

      if ExecNo > 0 then
      begin
        InsertPGMHist('[000]', 'N', 'HistoryDelete', '', 'Automatically Delete Program History ['+IntToStr(ExecNo)+']', 'PGM', '', '', '');
      end;
}
      ExecNo := 0;
      Close;
      SQL.Clear;
      StrSQL := ' DELETE FROM TT_ERROR ' +
                '  WHERE ERR_END < GETDATE() - 30 ' ;
      SQL.Text := StrSQL;
      ExecNo := ExecSQL;

      if ExecNo > 0 then
      begin
        InsertPGMHist('[000]', 'N', 'HistoryDelete', '', 'Automatically Delete Error History ['+IntToStr(ExecNo)+']', 'PGM', '', '', '');
      end;

      ExecNo := 0;
      Close;
      SQL.Clear;
      StrSQL := ' DELETE FROM TC_RFID_HIST ' +
                '  WHERE CRT_DT < GETDATE() - 3 ' ;
      SQL.Text := StrSQL;
      ExecNo := ExecSQL;

      if ExecNo > 0 then
      begin
        InsertPGMHist('[000]', 'N', 'HistoryDelete', '', 'Automatically Delete RFID History ['+IntToStr(ExecNo)+']', 'PGM', '', '', '');
      end;

      Close;
    end;
  except
    on E : Exception do
    begin
      qryTemp.Close;
      InsertPGMHist('[000]', 'E', 'HistoryDelete', '', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('[000] procedure HistoryDelete Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;

//==============================================================================
// SCTREAD
//==============================================================================
procedure TfrmMain.SCTREAD(SC_NO: Integer);
var
  j, k : integer ;
  StrSql, TmpCol, StrLog, D210, D211, D212, D213 : String ;
begin
  D210:=''; D211:='';

  StrSql := ' SELECT * FROM VW_SC_STAUS ' +
            '  WHERE SC_NO =''' + IntToStr(SC_NO) + ''' ';

  try
    with qryInfo do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSql;
      Open;
      if not (Bof and Eof ) then
      begin
        // Word Data -> 10 Word
        SC_STATUS[SC_NO].D200 := FormatFloat('0000',StrToInt('$' + FieldByName('D200').AsString)) ; // Hex -> Dec
        SC_STATUS[SC_NO].D201 := FormatFloat('0000',StrToInt('$' + FieldByName('D201').AsString)) ; // Hex -> Dec
        SC_STATUS[SC_NO].D202 := FieldByName('D202').AsString ;
        SC_STATUS[SC_NO].D203 := FieldByName('D203').AsString ;
        SC_STATUS[SC_NO].D204 := FieldByName('D204').AsString ;
        SC_STATUS[SC_NO].D205 := FormatFloat('0000',StrToInt('$' + FieldByName('D205').AsString)) ; // Hex -> Dec
        SC_STATUS[SC_NO].D206 := FieldByName('D206').AsString ;
        SC_STATUS[SC_NO].D207 := FieldByName('D207').AsString ;
        SC_STATUS[SC_NO].D208 := FieldByName('D208').AsString ;
        SC_STATUS[SC_NO].D209 := FieldByName('D209').AsString ;


        // Bit Data -> 2 Word
        for j := 0 to 15 do
        begin
          TmpCol := 'D210_' + FormatFloat('00',j) ;
          SC_STATUS[SC_NO].D210[j] := FieldByName(TmpCol).AsString ;
          D210 := D210 + SC_STATUS[SC_NO].D210[j] ;
          TmpCol := 'D211_' + FormatFloat('00',j) ;
          SC_STATUS[SC_NO].D211[j] := FieldByName(TmpCol).AsString ;
          D211 := D211 + SC_STATUS[SC_NO].D211[j] ;
          TmpCol := 'D212_' + FormatFloat('00',j) ;
          SC_STATUS[SC_NO].D212[j] := FieldByName(TmpCol).AsString ;
          D212 := D212 + SC_STATUS[SC_NO].D212[j] ;
          TmpCol := 'D213_' + FormatFloat('00',j) ;
          SC_STATUS[SC_NO].D213[j] := FieldByName(TmpCol).AsString ;
          D212 := D213 + SC_STATUS[SC_NO].D213[j] ;
        end;
      end;
      Close;
    end;
  except
    if qryInfo.Active then qryInfo.Close;
  end;
end;
//==============================================================================
// tmrQryTimer
//==============================================================================
procedure TfrmMain.tmrQryTimer(Sender: TObject);
var
  i : integer ;
begin
  try
    tmrQry.Enabled := False ;
    if m.ConChk then
    begin
      for i := START_SCNO to END_SCNO do
      begin
        SCTREAD(i);          // SC ���� Get  ���ο��� ����
        SC_StatusDisplay(i);
      end;
    end;
    tmrQry.Enabled := True ;
  except
    on E : Exception do
    begin
      tmrQry.Enabled := False ;
      ErrorLogWrite('Procedure tmrQryTimer, ' + 'Error[' + E.Message + ']');
    end;
  end;
end;

//==============================================================================
// tmrErrorColorTimer
//==============================================================================
procedure TfrmMain.tmrErrorColorTimer(Sender: TObject);
begin
  try
    tmrErrorColor.Enabled := False ;
    if m.ConChk then
    begin
      if ErrorChk_Visibel or
         ErrorChk_Caption then
      begin
        if TLabel(Self.FindComponent('Lbl_error')).Font.Color = clFuchsia then
        begin
          TLabel(Self.FindComponent('Lbl_error')).Font.Color := clRed;
        end else
        begin
          TLabel(Self.FindComponent('Lbl_error')).Font.Color := clFuchsia;
        end;
      end
    end;
    tmrErrorColor.Enabled := True ;
  except
    on E : Exception do
    begin
      tmrErrorColor.Enabled := False ;
      ErrorLogWrite('Procedure tmrErrorColorTimer, ' + 'Error[' + E.Message + ']');
    end;
  end;
end;

//==============================================================================
// SC_StatusDisplay
//==============================================================================
procedure TfrmMain.SC_StatusDisplay(SC_NO: Integer);
var
  jobError : String;
begin
  jobError := '1';

  //RFID
  jobError := fnJobErrorChk('');
  //�����߻�
  TLabel(Self.FindComponent('Lbl_error')).Caption := fnCaptionErrorMsg(SC_STATUS[SC_NO].D205);


{
  TLabel(Self.FindComponent('Lbl_error')).Caption := fnCaptionMsg(SC_STATUS[SC_NO].D210[15],'10'); // �̻�߻�
  TLabel(Self.FindComponent('Lbl_error')).Caption := fnCaptionMsg(SC_STATUS[SC_NO].D211[03],'11'); //�����԰�
  TLabel(Self.FindComponent('Lbl_error')).Caption := fnCaptionMsg(SC_STATUS[SC_NO].D211[04],'12'); //�����
}



  //���� ���� ���� ȭ��
  TLabel(Self.FindComponent('Lbl_error')).Caption := fnCaptionMsg(SC_STATUS[SC_NO].D212[10],'13'); // ȭ��溸��1
  TLabel(Self.FindComponent('Lbl_error')).Caption := fnCaptionMsg(SC_STATUS[SC_NO].D212[11],'13'); // ȭ��溸��2
  TLabel(Self.FindComponent('Lbl_error')).Caption := fnCaptionMsg(SC_STATUS[SC_NO].D212[12],'13'); // ȭ��溸��3
  TLabel(Self.FindComponent('Lbl_error')).Caption := fnCaptionMsg(SC_STATUS[SC_NO].D212[13],'13'); // ȭ��溸��4
  TLabel(Self.FindComponent('Lbl_error')).Caption := fnCaptionMsg(SC_STATUS[SC_NO].D212[14],'13'); // ȭ��溸��5
  TLabel(Self.FindComponent('Lbl_error')).Caption := fnCaptionMsg(SC_STATUS[SC_NO].D212[15],'13'); // ȭ��溸��6

  //���� ǥ��
  TLabel(Self.FindComponent('Lbl_error')).Visible := fnErrorMsg(SC_STATUS[SC_NO].D210[15]); // �̻�߻�
  TLabel(Self.FindComponent('Lbl_error')).Visible := fnErrorMsg(SC_STATUS[SC_NO].D211[03]); // �����԰�
  TLabel(Self.FindComponent('Lbl_error')).Visible := fnErrorMsg(SC_STATUS[SC_NO].D211[04]); // �����
  TLabel(Self.FindComponent('Lbl_error')).Visible := fnErrorMsg(SC_STATUS[SC_NO].D212[10]); // ȭ��溸��1
  TLabel(Self.FindComponent('Lbl_error')).Visible := fnErrorMsg(SC_STATUS[SC_NO].D212[11]); // ȭ��溸��2
  TLabel(Self.FindComponent('Lbl_error')).Visible := fnErrorMsg(SC_STATUS[SC_NO].D212[12]); // ȭ��溸��3
  TLabel(Self.FindComponent('Lbl_error')).Visible := fnErrorMsg(SC_STATUS[SC_NO].D212[13]); // ȭ��溸��4
  TLabel(Self.FindComponent('Lbl_error')).Visible := fnErrorMsg(SC_STATUS[SC_NO].D212[14]); // ȭ��溸��5
  TLabel(Self.FindComponent('Lbl_error')).Visible := fnErrorMsg(SC_STATUS[SC_NO].D212[15]); // ȭ��溸��6

  if (SC_STATUS[SC_NO].D210[15] = '0') And
     (SC_STATUS[SC_NO].D212[10] = '0') And
     (SC_STATUS[SC_NO].D212[11] = '0') And
     (SC_STATUS[SC_NO].D212[12] = '0') And
     (SC_STATUS[SC_NO].D212[13] = '0') And
     (SC_STATUS[SC_NO].D212[14] = '0') And
     (SC_STATUS[SC_NO].D212[15] = '0') And
     (jobError = '') then
  begin
    ErrorChk_Caption := False;
    ErrorChk_Visibel := False;
  end;


end;

//==============================================================================
// fnCurtainMsg   clRed  clFuchsia
//==============================================================================
function TfrmMain.fnErrorMsg(Signal: string): Boolean;
begin
  Result := TLabel(Self.FindComponent('Lbl_error')).Visible;
  if ErrorChk_Visibel then Exit;

  if Signal='0'    then
  begin
    Result := False;
  end else
  if Signal='1'    then
  begin
    ErrorChk_Visibel := True;
    Result := True;
  end else
  begin
    Result := False;
  end;
end;

//==============================================================================
// fnModeMsg
//==============================================================================
function TfrmMain.fnCaptionMsg(Signal, Number: string): String;
begin
  Result := TLabel(Self.FindComponent('Lbl_error')).Caption;
{
  if ErrorChk_Caption then
  begin
    Exit;
  end;
}
  if Signal='0'    then
  begin
    Result := TLabel(Self.FindComponent('Lbl_error')).Caption;
  end else
  if Signal='1'    then
  begin
    if Number = '10' then
    begin
      Result := '#���� �溸 - SC�̻�߻�';
    end else
    if Number = '11' then
    begin
      Result := '#���� �溸 - SC�����԰�';
    end else
    if Number = '12' then
    begin
      Result := '#���� �溸 - SC�����';
    end else
    begin
      Result := '#ȭ�� �溸 - ȭ�簨��';
    end;
    ErrorChk_Caption := True;
  end else
  begin
    Result := Signal;
  end;
end;

//==============================================================================
// fnModeMsg
//==============================================================================
function TfrmMain.fnCaptionErrorMsg(Signal : string): String;
var
  StrSQL : String;
begin
  try
    Result := TLabel(Self.FindComponent('Lbl_error')).Caption;

    if Signal = '0000' then Exit;

    with qryTemp do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' SELECT *      ' +
                '   FROM TM_ERROR      ' +
                '  WHERE ERR_CODE = '''  + Signal + ''' ';
      SQL.Text := StrSQL;
      Open;

      if not (Bof and Eof ) then
      begin
        Result := '#ER - ' + FieldByName('ERR_NAME').AsString;
        ErrorChk_Caption := True;
      end;
      Close;
    end;
  except
    on E : Exception do
    begin
      qryTemp.Close;
      InsertPGMHist('[000]', 'E', 'fnJobErrorChk', '', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('[000] function fnJobErrorChk Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;

//==============================================================================
// fnCurtainMsg   clRed  clFuchsia
//==============================================================================
function TfrmMain.fnJobErrorChk(Signal: string): String;
var
  StrSQL : String;
begin
  try
    Result := '';
    with qryTemp do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' SELECT TOP(1) *      ' +
                '   FROM TT_ORDER      ' +
                '  WHERE JOBERRORC = 1 ' +
                '  ORDER BY REG_TIME   ' ;
      SQL.Text := StrSQL;
      Open;

      if not (Bof and Eof ) then
      begin
        Result := '#��û����ġ - ' + FieldByName('LUGG').AsString;
        TLabel(Self.FindComponent('Lbl_error')).Caption := '#'+ FieldByName('JOBERRORD').AsString +
                                                        ' - ' + FieldByName('LUGG').AsString +
                                                        ' - St.0' + FieldByName('LINE_NO').AsString;
        TLabel(Self.FindComponent('Lbl_error')).Visible := True;
        ErrorChk_Caption := True;
        ErrorChk_Visibel := True;
      end;
      Close;
    end;
  except
    on E : Exception do
    begin
      qryTemp.Close;
      InsertPGMHist('[000]', 'E', 'fnJobErrorChk', '', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('[000] function fnJobErrorChk Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;

initialization
  //�ߺ� ���� ���� �ڵ� �κ�
  CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, 1, 'BST_AWS');
  if GetlastError = ERROR_ALREADY_EXISTS then halt;
end.

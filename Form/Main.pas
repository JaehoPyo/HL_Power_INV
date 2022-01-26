unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ComCtrls, ToolWin, Menus, ExtCtrls,  StdCtrls, DB, ADODB,
  d_MainDm, h_MainLib, h_ReferLib, Grids, DBGrids, DBCtrls, Mask, ExLibrary,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, System.ImageList, Vcl.ImgList;

type
  TfrmMain = class(TForm)
    Pnl_Top : TPanel;
    staLoginInfo: TStatusBar;
    tmrSystem: TTimer;
    Pnl_BTN: TPanel;
    Pnl_Btn1: TPanel;
    Pnl_Btn3: TPanel;
    Pnl_Btn4: TPanel;
    Pnl_Btn7: TPanel;
    cmdEXCEL: TSpeedButton;
    cmdPRINT: TSpeedButton;
    cmdINQUIRY: TSpeedButton;
    cmdCLOSE: TSpeedButton;
    Pnl_Btn0: TPanel;
    cmdREGISTER: TSpeedButton;
    qryCommChk: TADOQuery;
    tmrConnectCheck: TTimer;
    qryDBChk: TADOQuery;
    Pnl_Btn5: TPanel;
    Pnl_Btn6: TPanel;
    cmdNEXT: TSpeedButton;
    Pnl_Btn2: TPanel;
    cmdDELETE: TSpeedButton;
    Panel21: TPanel;
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
    cmdPREV: TSpeedButton;
    Img_Main: TImage;
    PnlSCComm: TPanel;
    PnlMainMenu: TPanel;
    PnlDBComm: TPanel;
    shpDBComm: TShape;
    Shape3: TShape;
    shpSCComm: TShape;
    Label1: TLabel;
    Label2: TLabel;
    qryOrderDel: TADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnClick(Sender: TObject);
    procedure execMenuClick(Sender: TObject);
    procedure tmrSystemTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tmrConnectCheckTimer(Sender: TObject);
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
  end;

const
  FormNo ='000';

var
  frmMain: TfrmMain;

  CloseChk : Boolean ;
  SC_COMM  : Boolean ;

implementation

uses U110, U210, U220, U230, U310, U320, U410, U420, U510, U520 ;

{$R *.dfm}

//==============================================================================
// FormCreate
//==============================================================================
procedure TfrmMain.FormCreate(Sender: TObject);
var
  tmp : String ;
begin
  m.MainHd := Handle;

  if not ADOConnection then
  begin
    MessageDlg('���� ���ῡ �����Ͽ����ϴ�.', mtError, [mbYes], 0) ;
    ExitProcess(0);
  end;

  CloseChk := False ;
  PnlMainMenu.Caption := '';

  frmMain.Caption := IniRead( INI_PATH, 'PROGRAM', 'ProgramName' ,'�λ걳����� �ڵ� â�� �����ý���' );
  staLoginInfo.Panels[0].Text := IniRead( INI_PATH, 'PROGRAM', 'CompanyName' ,'�λ걳�����' );
  fnWmMsgSend( 22222,222 );
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
// WmMsgRecv (���� ��ư Ȱ��ȭ ����)
//==============================================================================
procedure TfrmMain.WmMsgRecv(var Message : TMessage);
  Procedure ToolBtnSet ( TBtnNo : Integer; Status : String  );
  var
    BtnStatus : Boolean;
  begin
    if   Status = '1' Then BtnStatus := True Else BtnStatus := False;
    case TBtnNo of
      1  : cmdREGISTER.Enabled := BtnStatus ; // cmdReset
      2  : cmdEXCEL.Enabled    := BtnStatus ; // cmdExcel
      3  : cmdDELETE.Enabled   := BtnStatus ; // cmdDelete
      4  : cmdPRINT.Enabled    := BtnStatus ; // cmdPrint
      5  : cmdINQUIRY.Enabled  := BtnStatus ; // cmdQuery
      6  : cmdPREV.Enabled     := BtnStatus ; // cmdPREV
      7  : cmdNEXT.Enabled     := BtnStatus ; // cmdNEXT
      8  : cmdCLOSE.Enabled    := BtnStatus ; // cmdClose
    end;
  end;
var
  i : Integer;
  RecvStr : String;
begin
  RecvStr  :=  IntToStr ( Message.WParam ) +  IntToStr ( Message.LParam );

  for i := 1 to  Length ( RecvStr ) do
    ToolBtnSet ( i , Copy( RecvStr, i , 1 ) );
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
    tmrSystem.Enabled := False;
    staLoginInfo.Panels[1].Text := formatdatetime ( 'YYYY-MM-DD HH:NN:SS' ,Now() );
    if m.ConChk then
    begin
      CommChk ;
      OrderDel ;

      shpDBComm.Brush.Color := clLime;
      if SC_COMM then
           shpSCComm.Brush.Color := clLime
      else shpSCComm.Brush.Color := clRed;

      if MdiChildCount=0 then
      begin
        fnWmMsgSend( 22222,222 );
        PnlMainMenu.Caption := '';
      end;

    end else
    begin
      shpDBComm.Brush.Color := clRed;
      shpSCComm.Brush.Color := clRed;
    end;
  finally
    tmrSystem.Enabled := True;
  end;
end;

//==============================================================================
// execMenuClick (��� �޴���ư Ŭ�� �̺�Ʈ)
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
    // ������
    3100 : U310Create();           // Cell ����͸�
    3200 : U320Create();           // �������
    // ��������------------------------------------------
    4100 : U410Create();           // ���˻�
    4200 : U420Create();           // �������
    // ����͸�------------------------------------------
    5100 : U510Create();           // ���� ����͸�
    5200 : U520Create();           // ���� ���� �̷� ��ȸ
    else exit;
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
  StrSQL : string;
begin
  Result := False ;
//  StrSQL := ' SELECT SYSDATE FROM DUAL ' ;
  StrSQL := ' SELECT GETDATE() ';

  try
    with qryDBChk do
    begin
      Close;
      SQL.Clear ;
      SQL.Text := StrSQL ;
      Open ;
      if not (Bof and Eof) then
      begin
        Result := True ;
        m.ConChk := True ;
      end;
    end;
  except
    if qryDBChk.Active then qryDBChk.Close;
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
//    StrSQL := ' SELECT (CASE WHEN SCC_DT > (SELECT SYSDATE - (((1/24)/60)/12) FROM DUAL) ' +
//              '              THEN 1 ELSE 0 END) AS STATUS ' +
//              '  FROM TT_SCC ' +
//              ' WHERE SCC_SR=''R'' ' ;
    StrSQL := ' SELECT (CASE WHEN SCC_DT > DATEADD(SECOND, 5, GETDATE()) ' +
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

initialization
  //�ߺ� ���� ���� �ڵ� �κ�
  CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, 1, 'BST_AWS');
  if GetlastError = ERROR_ALREADY_EXISTS then halt;
end.

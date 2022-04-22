unit U510;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, d_MainDm, h_MainLib, h_ReferLib, StdCtrls, DB, ADODB, ExLibrary, ExVclLib,
  Grids, StrUtils, DBGrids, comobj, frxClass, frxDBSet, DBGridEhGrouping, EhLibADO,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,DBGridEhImpExp,
  DBGridEh, Vcl.Mask, Vcl.DBCtrls, DBCtrlsEh, PrnDbgeh, Vcl.Buttons,
  Vcl.Imaging.pngimage ;

type
  TfrmU510 = class(TForm)
    qryTemp: TADOQuery;
    qryInfo: TADOQuery;
    dsInfo: TDataSource;
    Pnl_Main: TPanel;
    Pnl_Sub: TPanel;
    Shape2: TShape;
    Panel4: TPanel;
    Panel1: TPanel;
    Pnl_Top: TPanel;
    gbCode: TGroupBox;
    Panel157: TPanel;
    RackBay02: TPanel;
    Bay02: TPanel;
    RackBay03: TPanel;
    Bay03: TPanel;
    RackBay04: TPanel;
    Bay04: TPanel;
    RackBay05: TPanel;
    Bay05: TPanel;
    RackBay06: TPanel;
    Bay06: TPanel;
    RackBay07: TPanel;
    Bay07: TPanel;
    RackBay08: TPanel;
    Bay08: TPanel;
    RackBay09: TPanel;
    Bay09: TPanel;
    RackBay01: TPanel;
    Bay01: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel24: TPanel;
    Panel25: TPanel;
    Panel201: TPanel;
    Panel231: TPanel;
    Panel26: TPanel;
    Panel232: TPanel;
    Panel55: TPanel;
    Panel56: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    edt_SCCMode: TEdit;
    Panel27: TPanel;
    Panel28: TPanel;
    edt_DrvPosition: TEdit;
    Panel29: TPanel;
    edt_UDPosition: TEdit;
    Panel30: TPanel;
    edt_UnLoading: TEdit;
    Panel31: TPanel;
    edt_Emergency: TEdit;
    Panel32: TPanel;
    edt_ForkCenter: TEdit;
    edt_StroreOut: TEdit;
    Panel33: TPanel;
    Panel34: TPanel;
    edt_Loading: TEdit;
    edt_StroreIn: TEdit;
    Panel35: TPanel;
    edt_CargoExist: TEdit;
    Panel36: TPanel;
    edt_SCTMode: TEdit;
    Panel37: TPanel;
    edt_CurrLevel: TEdit;
    Panel38: TPanel;
    Panel39: TPanel;
    edt_ErrorCode: TEdit;
    edt_CurrBay: TEdit;
    Panel40: TPanel;
    Panel41: TPanel;
    edt_Error: TEdit;
    edt_Working: TEdit;
    Panel42: TPanel;
    Panel43: TPanel;
    edt_ForceComplete: TEdit;
    Panel44: TPanel;
    edt_Empty: TEdit;
    Panel45: TPanel;
    edt_Complete: TEdit;
    Panel46: TPanel;
    edt_InReady1: TEdit;
    edt_Double: TEdit;
    Panel47: TPanel;
    edt_OutReady1: TEdit;
    Panel48: TPanel;
    edt_StandBy: TEdit;
    Panel49: TPanel;
    Panel50: TPanel;
    edt_ErrorDesc: TEdit;
    Panel51: TPanel;
    edt_MoveOn: TEdit;
    Panel52: TPanel;
    edt_DstBay: TEdit;
    Panel53: TPanel;
    edt_DataReset: TEdit;
    Panel54: TPanel;
    edt_SrcBay: TEdit;
    edt_DstBank: TEdit;
    Panel57: TPanel;
    edt_SrcLevel: TEdit;
    Panel58: TPanel;
    edt_DstLevel: TEdit;
    Panel59: TPanel;
    edt_SrcBank: TEdit;
    Panel60: TPanel;
    edt_Lugg: TEdit;
    Panel62: TPanel;
    tmrQry: TTimer;
    SCLine1: TPanel;
    Panel159: TPanel;
    Panel161: TPanel;
    Panel162: TPanel;
    SC: TPanel;
    SCStatus: TPanel;
    SCRFork: TPanel;
    Panel63: TPanel;
    Panel64: TPanel;
    Panel68: TPanel;
    Panel69: TPanel;
    Panel70: TPanel;
    Panel71: TPanel;
    Panel72: TPanel;
    Panel73: TPanel;
    Panel74: TPanel;
    Panel75: TPanel;
    Panel76: TPanel;
    Panel77: TPanel;
    대기중: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    imgRFork_Left: TImage;
    Label17: TLabel;
    Label18: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label64: TLabel;
    Label66: TLabel;
    Label65: TLabel;
    Panel66: TPanel;
    Panel67: TPanel;
    Panel78: TPanel;
    Panel79: TPanel;
    Panel80: TPanel;
    Panel81: TPanel;
    Image1: TImage;
    Image2: TImage;
    imgRFork_Right: TImage;
    Label4: TLabel;
    Label5: TLabel;
    btnReset: TButton;
    btnRetry: TButton;
    Panel18: TPanel;
    Panel19: TPanel;
    Image4: TImage;
    Image3: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Panel20: TPanel;
    edt_InReady2: TEdit;
    Panel21: TPanel;
    edt_OutReady2: TEdit;
    Panel22: TPanel;
    edt_InReady3: TEdit;
    Panel23: TPanel;
    edt_OutReady3: TEdit;
    pnlCurtain1: TPanel;
    pnlCurtain2: TPanel;
    pnlCurtain3: TPanel;
    pnlCurtain4: TPanel;
    pnlCurtain5: TPanel;
    pnlCurtain6: TPanel;
    ImgCV_Cago1: TImage;
    ImgCV_Cago2: TImage;
    ImgCV_Cago3: TImage;
    ImgCV_Cago4: TImage;
    ImgCV_Cago5: TImage;
    ImgCV_Cago6: TImage;
    Panel104: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    lblLineName1_RF01: TLabel;
    Label7: TLabel;
    lblLineName2_RF01: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    lblPalletBma3_RF01: TLabel;
    lblPalletNo1_RF01: TLabel;
    lblPalletNo2_RF01: TLabel;
    lblModelNo1_RF01: TLabel;
    lblModelNo2_RF01: TLabel;
    lblBmaNo_RF01: TLabel;
    lblArea_RF01: TLabel;
    lblPalletBma1_RF01: TLabel;
    lblPalletBma2_RF01: TLabel;
    Panel65: TPanel;
    Label36: TLabel;
    Label37: TLabel;
    lblLineName1_RF02: TLabel;
    Label39: TLabel;
    lblLineName2_RF02: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    lblPalletBma3_RF02: TLabel;
    lblPalletNo1_RF02: TLabel;
    lblPalletNo2_RF02: TLabel;
    lblModelNo1_RF02: TLabel;
    lblModelNo2_RF02: TLabel;
    lblBmaNo_RF02: TLabel;
    lblArea_RF02: TLabel;
    lblPalletBma1_RF02: TLabel;
    lblPalletBma2_RF02: TLabel;
    Panel83: TPanel;
    Label59: TLabel;
    Label60: TLabel;
    lblLineName1_RF03: TLabel;
    Label62: TLabel;
    lblLineName2_RF03: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    lblPalletBma3_RF03: TLabel;
    lblPalletNo1_RF03: TLabel;
    lblPalletNo2_RF03: TLabel;
    lblModelNo1_RF03: TLabel;
    lblModelNo2_RF03: TLabel;
    lblBmaNo_RF03: TLabel;
    lblArea_RF03: TLabel;
    lblPalletBma1_RF03: TLabel;
    lblPalletBma2_RF03: TLabel;
    Panel61: TPanel;
    Label6: TLabel;
    Label85: TLabel;
    lblLineName1_RF04: TLabel;
    Label87: TLabel;
    lblLineName2_RF04: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    lblPalletBma3_RF04: TLabel;
    lblPalletNo1_RF04: TLabel;
    lblPalletNo2_RF04: TLabel;
    lblModelNo1_RF04: TLabel;
    lblModelNo2_RF04: TLabel;
    lblBmaNo_RF04: TLabel;
    lblArea_RF04: TLabel;
    lblPalletBma1_RF04: TLabel;
    lblPalletBma2_RF04: TLabel;
    Panel82: TPanel;
    Label107: TLabel;
    Label108: TLabel;
    lblLineName1_RF05: TLabel;
    Label110: TLabel;
    lblLineName2_RF05: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    Label120: TLabel;
    lblPalletBma3_RF05: TLabel;
    lblPalletNo1_RF05: TLabel;
    lblPalletNo2_RF05: TLabel;
    lblModelNo1_RF05: TLabel;
    lblModelNo2_RF05: TLabel;
    lblBmaNo_RF05: TLabel;
    lblArea_RF05: TLabel;
    lblPalletBma1_RF05: TLabel;
    lblPalletBma2_RF05: TLabel;
    Panel84: TPanel;
    Label130: TLabel;
    Label131: TLabel;
    lblLineName1_RF06: TLabel;
    Label133: TLabel;
    lblLineName2_RF06: TLabel;
    Label135: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    Label142: TLabel;
    Label143: TLabel;
    lblPalletBma3_RF06: TLabel;
    lblPalletNo1_RF06: TLabel;
    lblPalletNo2_RF06: TLabel;
    lblModelNo1_RF06: TLabel;
    lblModelNo2_RF06: TLabel;
    lblBmaNo_RF06: TLabel;
    lblArea_RF06: TLabel;
    lblPalletBma1_RF06: TLabel;
    lblPalletBma2_RF06: TLabel;
    Panel85: TPanel;
    Panel86: TPanel;
    Panel87: TPanel;
    Panel88: TPanel;
    Panel89: TPanel;
    Panel90: TPanel;
    Panel91: TPanel;
    Panel92: TPanel;
    Panel93: TPanel;
    Panel94: TPanel;
    Panel95: TPanel;
    Panel96: TPanel;
    edt_Curtain1: TEdit;
    edt_Curtain3: TEdit;
    edt_Curtain5: TEdit;
    edt_Fire1: TEdit;
    edt_Fire3: TEdit;
    edt_Fire5: TEdit;
    edt_Curtain2: TEdit;
    edt_Curtain4: TEdit;
    edt_Curtain6: TEdit;
    edt_Fire2: TEdit;
    edt_Fire4: TEdit;
    edt_Fire6: TEdit;
    tmrRFID: TTimer;
    Label10: TLabel;
    Label11: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    btnCurtain6: TButton;
    btnCurtain5: TButton;
    btnCurtain1: TButton;
    btnCurtain2: TButton;
    btnCurtain3: TButton;
    btnCurtain4: TButton;
    Panel97: TPanel;
    Panel98: TPanel;
    Panel99: TPanel;
    edt_Docking5: TEdit;
    edt_Docking3: TEdit;
    edt_Docking1: TEdit;
    Panel100: TPanel;
    Panel101: TPanel;
    Panel102: TPanel;
    edt_Docking6: TEdit;
    edt_Docking4: TEdit;
    edt_Docking2: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Pnl_MainResize(Sender: TObject);
    procedure tmrQryTimer(Sender: TObject);
    procedure btnClick(Sender: TObject);
    procedure tmrRFIDTimer(Sender: TObject);
    procedure btnCurtainClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure fnCommandStart;
    procedure fnCommandOrder;
    procedure fnCommandAdd;
    procedure fnCommandExcel;
    procedure fnCommandDelete;
    procedure fnCommandUpdate;
    procedure fnCommandPrint;
    procedure fnCommandQuery;
    procedure fnCommandClose;
    procedure fnCommandLang;
    procedure fnWmMsgRecv (var MSG : TMessage) ; message WM_USER ;

    procedure SCTREAD(SC_NO: Integer);
    procedure SC_StatusDisplay(SC_NO: Integer);
    procedure fnRFIDUpdate(Number, Flag: string);

    function fnSignalMsg(Signal: string): String;
    function fnModeMsg(Signal: string): String;
    function fnCagoMsg(Signal: string): Boolean;
    function fnCurMsg(FName : string): Boolean;
    function fnCurtainMsg(Signal: string): String;
    function fnSignalEditColor(Signal,Flag: string): TColor;
    function fnSignalFontColor(Signal,Flag: string): TColor;
    function fnGetErrMsg(SC_NO: integer; GetField,ErrCode: String): String;

    function fnSCIO_Exist(SC_NO: integer): Boolean;
    function fnSCIO_Load(SC_NO: integer): Boolean;
    function GetTextMsg(SC_NO:integer; Kind:String): String;

    function fnGetSCSetInfo(SC_NO: Integer; GetField: String): String;
    function fnSetSCSetInfo(SC_NO: Integer; SetField, SetValue: String): Boolean;

  end;
  procedure U510Create();

const
  FormNo ='510';
var
  frmU510: TfrmU510;
  SrtFlag : integer = 0 ;


  SC_JOB    : Array [START_SCNO..END_SCNO] of TSC_JOB ; // SC 작업
//  SC_STATUS : Array [START_SCNO..End_SCNO] of TSC_STATUS ;    // SC 상태



implementation

uses Main ;

{$R *.dfm}

//==============================================================================
// U230Create
//==============================================================================
procedure U510Create();
begin
  if not Assigned( frmU510 ) then
  begin
    frmU510 := TfrmU510.Create(Application);
    with frmU510 do
    begin
      fnCommandStart;
    end;
  end;
  frmU510.Show;
end;

//==============================================================================
// fnWmMsgRecv
//==============================================================================
procedure TfrmU510.fnWmMsgRecv(var MSG: TMessage);
begin
  case MSG.WParam of
    MSG_MDI_WIN_ORDER   : begin fnCommandOrder   ; end;           // MSG_MDI_WIN_ORDER   = 11 ; // 지시
    MSG_MDI_WIN_ADD     : begin fnCommandAdd     ; end;           // MSG_MDI_WIN_ADD     = 12 ; // 신규
    MSG_MDI_WIN_DELETE  : begin fnCommandDelete  ; end;           // MSG_MDI_WIN_DELETE  = 13 ; // 삭제
    MSG_MDI_WIN_UPDATE  : begin fnCommandUpdate  ; end;           // MSG_MDI_WIN_UPDATE  = 14 ; // 수정
    MSG_MDI_WIN_EXCEL   : begin fnCommandExcel   ; end;           // MSG_MDI_WIN_EXCEL   = 15 ; // 엑셀
    MSG_MDI_WIN_PRINT   : begin fnCommandPrint   ; end;           // MSG_MDI_WIN_PRINT   = 16 ; // 인쇄
    MSG_MDI_WIN_QUERY   : begin fnCommandQuery   ; end;           // MSG_MDI_WIN_QUERY   = 17 ; // 조회
    MSG_MDI_WIN_CLOSE   : begin fnCommandClose   ; Close; end;    // MSG_MDI_WIN_CLOSE   = 20 ; // 닫기
    MSG_MDI_WIN_LANG    : begin fnCommandLang    ; end;           // MSG_MDI_WIN_LANG    = 21 ; // 언어
  end;
end;

//==============================================================================
// FormActivate
//==============================================================================
procedure TfrmU510.FormActivate(Sender: TObject);
begin
  MainDm.M_Info.ActiveFormID := '510';
  frmMain.LblMenu000.Caption := MainDm.M_Info.ActiveFormID + '. ' + getLangMenuString(MainDm.M_Info.ActiveFormID, frmMain.LblMenu000.Caption, MainDm.M_Info.LANG_TYPE, 'N');
  frmU510.Caption := MainDm.M_Info.ActiveFormName;
  fnWmMsgSend( 22222,22111 );

  fnCommandQuery ;
  if not tmrQry.Enabled then tmrQry.Enabled := True ;
  if not tmrRFID.Enabled then tmrRFID.Enabled := True ;
end;

//==============================================================================
// FormDeactivate
//==============================================================================
procedure TfrmU510.FormDeactivate(Sender: TObject);
var
  i : integer ;
begin
{
  for i := 0 to Self.ComponentCount-1 do
  begin
    if (Self.Components[i] is TTimer) then
       (Self.Components[i] as TTimer).Enabled := False ;
  end;
 }
  tmrQry.Enabled := False;
  for i := 0 to Self.ComponentCount-1 Do
  begin
    if (Self.Components[i] is TADOQuery) then
       (Self.Components[i] as TADOQuery).Active := False ;
  end;
end;

//==============================================================================
// FormClose
//==============================================================================
procedure TfrmU510.FormClose(Sender: TObject; var Action: TCloseAction);
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

  Action := Cafree;
  try frmU510 := Nil ;
  except end;
end;

//==============================================================================
// fnCommandStart
//==============================================================================
procedure TfrmU510.fnCommandStart;
begin
//
end;

//==============================================================================
// fnCommandOrder [지시]
//==============================================================================
procedure TfrmU510.fnCommandOrder  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [엑셀]
//==============================================================================
procedure TfrmU510.fnCommandExcel;
begin
//
end;

//==============================================================================
// fnCommandAdd [신규]                                                        //
//==============================================================================
procedure TfrmU510.fnCommandAdd  ;
begin
//
end;

//==============================================================================
// fnCommandDelete [삭제]
//==============================================================================
procedure TfrmU510.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandUpdate [수정]                                                     //
//==============================================================================
procedure TfrmU510.fnCommandUpdate;
begin
//
end;

//==============================================================================
// fnCommandPrint [인쇄]
//==============================================================================
procedure TfrmU510.fnCommandPrint;
begin
//
end;

//==============================================================================
// fnCommandQuery
//==============================================================================
procedure TfrmU510.fnCommandQuery;
var
  i : integer ;
begin
  try
    for i := START_SCNO to END_SCNO do
    begin
//      SCTREAD(i);          // SC 상태 Get  메인에서 실행
      SC_StatusDisplay(i); // SC상태 Display
    end;
  except
    on E : Exception do
    begin
      ErrorLogWrite('Procedure fnCommandQuery, ' + 'Error[' + E.Message + ']');
    end;
  end;
end;

//==============================================================================
// fnCommandClose
//==============================================================================
procedure TfrmU510.fnCommandClose;
begin
  Close;
end;

//==============================================================================
// fnCommandLang [언어]                                                       //
//==============================================================================
procedure TfrmU510.fnCommandLang;
begin
//
end;

//==============================================================================
// Pnl_MainResize
//==============================================================================
procedure TfrmU510.Pnl_MainResize(Sender: TObject);
begin
  Pnl_Sub.Top  := (Pnl_Main.Height - Pnl_Sub.Height) div 2 ;
  Pnl_Sub.Left := (Pnl_Main.Width  - Pnl_Sub.Width ) div 2 ;
end;

//==============================================================================
// tmrQryTimer
//==============================================================================
procedure TfrmU510.tmrQryTimer(Sender: TObject);
begin
  try
    tmrQry.Enabled := False ;
    if m.ConChk then fnCommandQuery ;
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
// tmrRFIDTimer
//==============================================================================
procedure TfrmU510.tmrRFIDTimer(Sender: TObject);
var
  i : Integer;
  Number : string;
begin
  try
    for i := START_SCNO to END_SCNO do
    begin

      if SC_STATUS[i].D211[08] = '0' then  //화물감지
      begin
        fnRFIDUpdate('1', '0');
      end else
      if SC_STATUS[i].D213[00] = '1' then  ///RFID READ 신호
      begin
        fnRFIDUpdate('1', '1');
      end else
      if SC_STATUS[i].D213[00] = '0' then  ///RFID READ 신호
      begin
        fnRFIDUpdate('1', '2');
      end;

      if SC_STATUS[i].D211[09] = '0' then
      begin
        fnRFIDUpdate('2', '0');
      end else
      if SC_STATUS[i].D213[01] = '1' then
      begin
        fnRFIDUpdate('2', '1');
      end else
      if SC_STATUS[i].D213[01] = '0' then
      begin
        fnRFIDUpdate('2', '2');
      end;

      if SC_STATUS[i].D211[10] = '0' then
      begin
        fnRFIDUpdate('3', '0');
      end else
      if SC_STATUS[i].D213[02] = '1' then
      begin
        fnRFIDUpdate('3', '1');
      end else
      if SC_STATUS[i].D213[02] = '0' then
      begin
        fnRFIDUpdate('3', '2');
      end;

      if SC_STATUS[i].D211[11] = '0' then
      begin
        fnRFIDUpdate('4', '0');
      end else
      if SC_STATUS[i].D213[03] = '1' then
      begin
        fnRFIDUpdate('4', '1');
      end else
      if SC_STATUS[i].D213[03] = '0' then
      begin
        fnRFIDUpdate('4', '2');
      end;

      if SC_STATUS[i].D211[12] = '0' then
      begin
        fnRFIDUpdate('5', '0');
      end else
      if SC_STATUS[i].D213[04] = '1' then
      begin
        fnRFIDUpdate('5', '1');
      end else
      if SC_STATUS[i].D213[04] = '0' then
      begin
        fnRFIDUpdate('5', '2');
      end;

      if SC_STATUS[i].D211[13] = '0' then
      begin
        fnRFIDUpdate('6', '0');
      end else
      if SC_STATUS[i].D213[05] = '1' then
      begin
        fnRFIDUpdate('6', '1');
      end else
      if SC_STATUS[i].D213[05] = '0' then
      begin
        fnRFIDUpdate('6', '2');
      end;
    end;

{
  TEdit(Self.FindComponent('edt_InReady1'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[08]); // 입고레디1
  TEdit(Self.FindComponent('edt_OutReady1'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[09]); // 출고레디1
  TEdit(Self.FindComponent('edt_InReady2'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[10]); // 입고레디2
  TEdit(Self.FindComponent('edt_OutReady2'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[11]); // 출고레디2
  TEdit(Self.FindComponent('edt_InReady3'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[12]); // 입고레디3
  TEdit(Self.FindComponent('edt_OutReady3'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[13]); // 출고레디3
}
    tmrRFID.Enabled := True ;
  except
    on E : Exception do
    begin
      tmrQry.Enabled := False ;
      ErrorLogWrite('Procedure tmrQryTimer, ' + 'Error[' + E.Message + ']');
    end;
  end;
end;

//==============================================================================
// SCTREAD
//==============================================================================
procedure TfrmU510.SCTREAD(SC_NO: Integer);
var
  j, k : integer ;
  StrSql, TmpCol, StrLog, D210, D211, D212 : String ;
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
        end;
      end;
      Close;
    end;
  except
    if qryInfo.Active then qryInfo.Close;
  end;
end;

//==============================================================================
// SC_StatusDisplay
//==============================================================================
procedure TfrmU510.SC_StatusDisplay(SC_NO: Integer);
begin
  // D200
  TEdit(Self.FindComponent('edt_CurrBay'      )).Text := SC_STATUS[SC_NO].D200;  // 현재위치 연
  // D201
  TEdit(Self.FindComponent('edt_CurrLevel'    )).Text := SC_STATUS[SC_NO].D201;  // 현재위치 단
  // D205
  TEdit(Self.FindComponent('edt_ErrorCode'    )).Text := SC_STATUS[SC_NO].D205;  // 이상코드
  TEdit(Self.FindComponent('edt_ErrorDesc'    )).Text := fnGetErrMsg(SC_NO, 'ERR_NAME', SC_STATUS[SC_NO].D205);  // 이상내용

  if (SC_STATUS[SC_NO].D205='0071') or
     (SC_STATUS[SC_NO].D205='0072') then
  begin
    btnRetry.Enabled := True ;
  end else btnRetry.Enabled := False ;


  //++++++++++++++++++++++++++++++++++++++++++++
  // 커튼 버튼 변경
  //++++++++++++++++++++++++++++++++++++++++++++
  TButton(Self.FindComponent('btnCurtain1')).Enabled := fnCurMsg('OPTION1');
  TButton(Self.FindComponent('btnCurtain2')).Enabled := fnCurMsg('OPTION2');
  TButton(Self.FindComponent('btnCurtain3')).Enabled := fnCurMsg('OPTION3');
  TButton(Self.FindComponent('btnCurtain4')).Enabled := fnCurMsg('OPTION4');
  TButton(Self.FindComponent('btnCurtain5')).Enabled := fnCurMsg('OPTION5');
  TButton(Self.FindComponent('btnCurtain6')).Enabled := fnCurMsg('OPTION6');

  //++++++++++++++++++++++++++++++++++++++++++++
  // 상태값 표시 (D210.00 ~ D210.15)
  //++++++++++++++++++++++++++++++++++++++++++++
  TEdit(Self.FindComponent('edt_SCTMode'      )).Text := fnModeMsg(  SC_STATUS[SC_NO].D210[00]); // 지상반 모드
  TEdit(Self.FindComponent('edt_SCCMode'      )).Text := fnModeMsg(  SC_STATUS[SC_NO].D210[01]); // 기상반 모드
  TEdit(Self.FindComponent('edt_Emergency'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[02]); // 비상정지
  TEdit(Self.FindComponent('edt_StroreIn'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[03]); // 입고작업 중
  TEdit(Self.FindComponent('edt_StroreOut'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[04]); // 출고작업 중
  TEdit(Self.FindComponent('edt_DrvPosition'  )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[06]); // 주행 정위치
  TEdit(Self.FindComponent('edt_UDPosition'   )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[07]); // 승강 정위치
  TEdit(Self.FindComponent('edt_ForkCenter'   )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[08]); // 포크 센터
  TEdit(Self.FindComponent('edt_CargoExist'   )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[09]); // 포크 제품 유무
  TEdit(Self.FindComponent('edt_Loading'      )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[10]); // 로딩 중
  TEdit(Self.FindComponent('edt_UnLoading'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[11]); // 언로딩 중
  TEdit(Self.FindComponent('edt_Error'        )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[15]); // 이상발생
  // D211.00 ~ D211.15
  TEdit(Self.FindComponent('edt_StandBy'      )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[00]); // 대기중
  TEdit(Self.FindComponent('edt_Working'      )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[01]); // 작업중
  TEdit(Self.FindComponent('edt_Complete'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[02]); // 작업완료
  TEdit(Self.FindComponent('edt_Double'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[03]); // 이중입고
  TEdit(Self.FindComponent('edt_Empty'        )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[04]); // 공출고
  TEdit(Self.FindComponent('edt_ForceComplete')).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[07]); // 강제완료
  TEdit(Self.FindComponent('edt_InReady1'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[08]); // 입고레디1
  TEdit(Self.FindComponent('edt_OutReady1'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[09]); // 출고레디1
  TEdit(Self.FindComponent('edt_InReady2'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[10]); // 입고레디2
  TEdit(Self.FindComponent('edt_OutReady2'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[11]); // 출고레디2
  TEdit(Self.FindComponent('edt_InReady3'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[12]); // 입고레디3
  TEdit(Self.FindComponent('edt_OutReady3'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[13]); // 출고레디3
  // D212.00 ~ D212.15
  TEdit(Self.FindComponent('edt_Curtain1'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[00]); // 라이트커튼1
  TEdit(Self.FindComponent('edt_Curtain2'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[01]); // 라이트커튼2
  TEdit(Self.FindComponent('edt_Curtain3'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[02]); // 라이트커튼3
  TEdit(Self.FindComponent('edt_Curtain4'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[03]); // 라이트커튼4
  TEdit(Self.FindComponent('edt_Curtain5'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[04]); // 라이트커튼5
  TEdit(Self.FindComponent('edt_Curtain6'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[05]); // 라이트커튼6
  TEdit(Self.FindComponent('edt_Fire1'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[10]); // 화재경보기1
  TEdit(Self.FindComponent('edt_Fire2'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[11]); // 화재경보기2
  TEdit(Self.FindComponent('edt_Fire3'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[12]); // 화재경보기3
  TEdit(Self.FindComponent('edt_Fire4'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[13]); // 화재경보기4
  TEdit(Self.FindComponent('edt_Fire5'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[14]); // 화재경보기5
  TEdit(Self.FindComponent('edt_Fire6'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[15]); // 화재경보기6
  // D213.00 ~ D213.15
  TEdit(Self.FindComponent('edt_Docking1'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D213[10]); // 도킹1
  TEdit(Self.FindComponent('edt_Docking2'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D213[11]); // 도킹2
  TEdit(Self.FindComponent('edt_Docking3'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D213[12]); // 도킹3
  TEdit(Self.FindComponent('edt_Docking4'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D213[13]); // 도킹4
  TEdit(Self.FindComponent('edt_Docking5'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D213[14]); // 도킹5
  TEdit(Self.FindComponent('edt_Docking6'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D213[15]); // 도킹6



  //입출고대 화물표시
  TImage(Self.FindComponent('ImgCV_Cago1')).Visible := fnCagoMsg(SC_STATUS[SC_NO].D211[08]);
  TImage(Self.FindComponent('ImgCV_Cago2')).Visible := fnCagoMsg(SC_STATUS[SC_NO].D211[09]);
  TImage(Self.FindComponent('ImgCV_Cago3')).Visible := fnCagoMsg(SC_STATUS[SC_NO].D211[10]);
  TImage(Self.FindComponent('ImgCV_Cago4')).Visible := fnCagoMsg(SC_STATUS[SC_NO].D211[11]);
  TImage(Self.FindComponent('ImgCV_Cago5')).Visible := fnCagoMsg(SC_STATUS[SC_NO].D211[12]);
  TImage(Self.FindComponent('ImgCV_Cago6')).Visible := fnCagoMsg(SC_STATUS[SC_NO].D211[13]);

  //커튼 ON/OFF
  TPanel(Self.FindComponent('pnlCurtain1'    )).Caption := fnCurtainMsg(SC_STATUS[SC_NO].D212[00]); // 라이트커튼1
  TPanel(Self.FindComponent('pnlCurtain2'    )).Caption := fnCurtainMsg(SC_STATUS[SC_NO].D212[01]); // 라이트커튼1
  TPanel(Self.FindComponent('pnlCurtain3'    )).Caption := fnCurtainMsg(SC_STATUS[SC_NO].D212[02]); // 라이트커튼1
  TPanel(Self.FindComponent('pnlCurtain4'    )).Caption := fnCurtainMsg(SC_STATUS[SC_NO].D212[03]); // 라이트커튼1
  TPanel(Self.FindComponent('pnlCurtain5'    )).Caption := fnCurtainMsg(SC_STATUS[SC_NO].D212[04]); // 라이트커튼1
  TPanel(Self.FindComponent('pnlCurtain6'    )).Caption := fnCurtainMsg(SC_STATUS[SC_NO].D212[05]); // 라이트커튼1

  if SC_STATUS[SC_NO].D212[00] = '1' then TButton(Self.FindComponent('btnCurtain1')).Caption := fnCurtainMsg('0')
  else                                    TButton(Self.FindComponent('btnCurtain1')).Caption := fnCurtainMsg('1');
  if SC_STATUS[SC_NO].D212[01] = '1' then TButton(Self.FindComponent('btnCurtain2')).Caption := fnCurtainMsg('0')
  else                                    TButton(Self.FindComponent('btnCurtain2')).Caption := fnCurtainMsg('1');
  if SC_STATUS[SC_NO].D212[02] = '1' then TButton(Self.FindComponent('btnCurtain3')).Caption := fnCurtainMsg('0')
  else                                    TButton(Self.FindComponent('btnCurtain3')).Caption := fnCurtainMsg('1');
  if SC_STATUS[SC_NO].D212[03] = '1' then TButton(Self.FindComponent('btnCurtain4')).Caption := fnCurtainMsg('0')
  else                                    TButton(Self.FindComponent('btnCurtain4')).Caption := fnCurtainMsg('1');
  if SC_STATUS[SC_NO].D212[04] = '1' then TButton(Self.FindComponent('btnCurtain5')).Caption := fnCurtainMsg('0')
  else                                    TButton(Self.FindComponent('btnCurtain5')).Caption := fnCurtainMsg('1');
  if SC_STATUS[SC_NO].D212[05] = '1' then TButton(Self.FindComponent('btnCurtain6')).Caption := fnCurtainMsg('0')
  else                                    TButton(Self.FindComponent('btnCurtain6')).Caption := fnCurtainMsg('1');

  //++++++++++++++++++++++++++++++++++++++++++++
  // 에디트 색상 변경 (D210.00 ~ D210.15)
  //++++++++++++++++++++++++++++++++++++++++++++
  TEdit(Self.FindComponent('edt_SCTMode'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[00],'4'); // 지상반 모드
  TEdit(Self.FindComponent('edt_SCCMode'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[01],'4'); // 기상반 모드
  TEdit(Self.FindComponent('edt_Emergency'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[02],'1'); // 비상정지
  TEdit(Self.FindComponent('edt_StroreIn'     )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[03],'0'); // 입고작업 중
  TEdit(Self.FindComponent('edt_StroreOut'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[04],'0'); // 출고작업 중
  TEdit(Self.FindComponent('edt_DrvPosition'  )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[06],'0'); // 주행 정위치
  TEdit(Self.FindComponent('edt_UDPosition'   )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[07],'0'); // 승강 정위치
  TEdit(Self.FindComponent('edt_ForkCenter'   )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[08],'0'); // 포크 센터
  TEdit(Self.FindComponent('edt_CargoExist'   )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[09],'0'); // 포크 제품 유무
  TEdit(Self.FindComponent('edt_Loading'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[10],'0'); // 로딩 중
  TEdit(Self.FindComponent('edt_UnLoading'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[11],'0'); // 언로딩 중
  TEdit(Self.FindComponent('edt_Error'        )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[15],'1'); // 이상발생
  // D211.00 ~ D211.15
  TEdit(Self.FindComponent('edt_StandBy'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[00],'0'); // 대기중
  TEdit(Self.FindComponent('edt_Working'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[01],'0'); // 작업중
  TEdit(Self.FindComponent('edt_Complete'     )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[02],'3'); // 작업완료
  TEdit(Self.FindComponent('edt_Double'       )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[03],'1'); // 이중입고
  TEdit(Self.FindComponent('edt_Empty'        )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[04],'1'); // 공출고
  TEdit(Self.FindComponent('edt_ForceComplete')).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[07],'3'); // 강제완료
  TEdit(Self.FindComponent('edt_InReady1'     )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[08],'2'); // 입고레디1
  TEdit(Self.FindComponent('edt_OutReady1'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[09],'2'); // 출고레디1
  TEdit(Self.FindComponent('edt_InReady2'     )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[10],'2'); // 입고레디2
  TEdit(Self.FindComponent('edt_OutReady2'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[11],'2'); // 출고레디2
  TEdit(Self.FindComponent('edt_InReady3'     )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[12],'2'); // 입고레디3
  TEdit(Self.FindComponent('edt_OutReady3'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[13],'2'); // 출고레디3
  // D212.00 ~ D212.15
  TEdit(Self.FindComponent('edt_Curtain1'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[00],'2'); // 라이트커튼1
  TEdit(Self.FindComponent('edt_Curtain2'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[01],'2'); // 라이트커튼2
  TEdit(Self.FindComponent('edt_Curtain3'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[02],'2'); // 라이트커튼3
  TEdit(Self.FindComponent('edt_Curtain4'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[03],'2'); // 라이트커튼4
  TEdit(Self.FindComponent('edt_Curtain5'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[04],'2'); // 라이트커튼5
  TEdit(Self.FindComponent('edt_Curtain6'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[05],'2'); // 라이트커튼6
  TEdit(Self.FindComponent('edt_Fire1'       )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[10],'1'); // 화재경보기1
  TEdit(Self.FindComponent('edt_Fire2'       )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[11],'1'); // 화재경보기2
  TEdit(Self.FindComponent('edt_Fire3'       )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[12],'1'); // 화재경보기3
  TEdit(Self.FindComponent('edt_Fire4'       )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[13],'1'); // 화재경보기4
  TEdit(Self.FindComponent('edt_Fire5'       )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[14],'1'); // 화재경보기5
  TEdit(Self.FindComponent('edt_Fire6'       )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[15],'1'); // 화재경보기6
  // D213.00 ~ D213.15
  TEdit(Self.FindComponent('edt_Docking1'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D213[10],'2');  // 도킹1
  TEdit(Self.FindComponent('edt_Docking2'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D213[11],'2');  // 도킹2
  TEdit(Self.FindComponent('edt_Docking3'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D213[12],'2');  // 도킹3
  TEdit(Self.FindComponent('edt_Docking4'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D213[13],'2');  // 도킹4
  TEdit(Self.FindComponent('edt_Docking5'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D213[14],'2');  // 도킹5
  TEdit(Self.FindComponent('edt_Docking6'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D213[15],'2');  // 도킹6

  TPanel(Self.FindComponent('RackBay08'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D213[10],'2');  // 도킹1
  TPanel(Self.FindComponent('RackBay07'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D213[11],'2');  // 도킹2
  TPanel(Self.FindComponent('RackBay05'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D213[12],'2');  // 도킹3
  TPanel(Self.FindComponent('RackBay04'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D213[13],'2');  // 도킹4
  TPanel(Self.FindComponent('RackBay02'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D213[14],'2');  // 도킹5
  TPanel(Self.FindComponent('RackBay01'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D213[15],'2');  // 도킹6

  //커튼 ON/OFF
  TPanel(Self.FindComponent('pnlCurtain1'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[00],'5'); // 라이트커튼1
  TPanel(Self.FindComponent('pnlCurtain2'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[01],'5'); // 라이트커튼1
  TPanel(Self.FindComponent('pnlCurtain3'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[02],'5'); // 라이트커튼1
  TPanel(Self.FindComponent('pnlCurtain4'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[03],'5'); // 라이트커튼1
  TPanel(Self.FindComponent('pnlCurtain5'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[04],'5'); // 라이트커튼1
  TPanel(Self.FindComponent('pnlCurtain6'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[05],'5'); // 라이트커튼1

  //++++++++++++++++++++++++++++++++++++++++++++
  // 에디트 폰트 색상 변경 (D210.00 ~ D210.15)
  //++++++++++++++++++++++++++++++++++++++++++++
  TEdit(Self.FindComponent('edt_SCTMode'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[00],'4'); // 지상반 모드
  TEdit(Self.FindComponent('edt_SCCMode'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[01],'4'); // 기상반 모드
  TEdit(Self.FindComponent('edt_Emergency'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[02],'1'); // 비상정지
  TEdit(Self.FindComponent('edt_StroreIn'     )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[03],'0'); // 입고작업 중
  TEdit(Self.FindComponent('edt_StroreOut'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[04],'0'); // 출고작업 중
  TEdit(Self.FindComponent('edt_DrvPosition'  )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[06],'0'); // 주행 정위치
  TEdit(Self.FindComponent('edt_UDPosition'   )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[07],'0'); // 승강 정위치
  TEdit(Self.FindComponent('edt_ForkCenter'   )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[08],'0'); // 포크 센터
  TEdit(Self.FindComponent('edt_CargoExist'   )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[09],'0'); // 포크 제품 유무
  TEdit(Self.FindComponent('edt_Loading'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[10],'0'); // 로딩 중
  TEdit(Self.FindComponent('edt_UnLoading'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[11],'0'); // 언로딩 중
  TEdit(Self.FindComponent('edt_Error'        )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[15],'1'); // 이상발생
  // D211.00 ~ D211.15
  TEdit(Self.FindComponent('edt_StandBy'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[00],'0'); // 대기중
  TEdit(Self.FindComponent('edt_Working'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[01],'0'); // 작업중
  TEdit(Self.FindComponent('edt_Complete'     )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[02],'3'); // 작업완료
  TEdit(Self.FindComponent('edt_Double'       )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[03],'1'); // 이중입고
  TEdit(Self.FindComponent('edt_Empty'        )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[04],'1'); // 공출고
  TEdit(Self.FindComponent('edt_ForceComplete')).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[07],'3'); // 강제완료
  TEdit(Self.FindComponent('edt_InReady1'     )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[08],'2'); // 입고레디1
  TEdit(Self.FindComponent('edt_OutReady1'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[09],'2'); // 출고레디1
  TEdit(Self.FindComponent('edt_InReady2'     )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[10],'2'); // 입고레디2
  TEdit(Self.FindComponent('edt_OutReady2'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[11],'2'); // 출고레디2
  TEdit(Self.FindComponent('edt_InReady3'     )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[12],'2'); // 입고레디3
  TEdit(Self.FindComponent('edt_OutReady3'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[13],'2'); // 출고레디3
  // D212.00 ~ D212.15
  TEdit(Self.FindComponent('edt_Curtain1'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[00],'2'); // 라이트커튼1
  TEdit(Self.FindComponent('edt_Curtain2'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[01],'2'); // 라이트커튼2
  TEdit(Self.FindComponent('edt_Curtain3'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[02],'2'); // 라이트커튼3
  TEdit(Self.FindComponent('edt_Curtain4'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[03],'2'); // 라이트커튼4
  TEdit(Self.FindComponent('edt_Curtain5'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[04],'2'); // 라이트커튼5
  TEdit(Self.FindComponent('edt_Curtain6'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[05],'2'); // 라이트커튼6
  TEdit(Self.FindComponent('edt_Fire1'       )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[10],'2'); // 화재경보기1
  TEdit(Self.FindComponent('edt_Fire2'       )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[11],'2'); // 화재경보기2
  TEdit(Self.FindComponent('edt_Fire3'       )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[12],'2'); // 화재경보기3
  TEdit(Self.FindComponent('edt_Fire4'       )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[13],'2'); // 화재경보기4
  TEdit(Self.FindComponent('edt_Fire5'       )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[14],'2'); // 화재경보기5
  TEdit(Self.FindComponent('edt_Fire6'       )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[15],'2'); // 화재경보기6
  // D213.00 ~ D213.15
  TEdit(Self.FindComponent('edt_Docking1'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D213[10],'2');  // 도킹1
  TEdit(Self.FindComponent('edt_Docking2'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D213[11],'2');  // 도킹2
  TEdit(Self.FindComponent('edt_Docking3'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D213[12],'2');  // 도킹3
  TEdit(Self.FindComponent('edt_Docking4'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D213[13],'2');  // 도킹4
  TEdit(Self.FindComponent('edt_Docking5'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D213[14],'2');  // 도킹5
  TEdit(Self.FindComponent('edt_Docking6'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D213[15],'2');  // 도킹6

  //++++++++++++++++++++++++++++++++++++++++++++
  // SC상태
  //++++++++++++++++++++++++++++++++++++++++++++
  if (SC_STATUS[SC_NO].D210[15] ='1') then
  begin
    TPanel(Self.FindComponent('SCStatus')).Color := clRed ;
  end else
  if (SC_STATUS[SC_NO].D211[00] ='1') then
  begin
    TPanel(Self.FindComponent('SCStatus')).Color := clSilver ;
  end else
  if (SC_STATUS[SC_NO].D211[01] ='1') then
  begin
    TPanel(Self.FindComponent('SCStatus')).Color := clLime ;
  end else
  begin
    TPanel(Self.FindComponent('SCStatus')).Color := clSilver ;
  end;


  //++++++++++++++++++++++
  // 화물유무
  //++++++++++++++++++++++
  if (SC_STATUS[SC_NO].D210[09]='1') then
  begin
    TPanel(Self.FindComponent('SCRFork')).Color := $00C08000 ;
  end else
  begin
    TPanel(Self.FindComponent('SCRFork')).Color := clWhite ;
  end;


  //++++++++++++++++++++++
  // 지시단계
  //++++++++++++++++++++++
//  edt_Step.Text := fnGetSCSetInfo(SC_NO, 'SC_STATUS');

{
  //++++++++++++++++++++++
  // 기동지시
  //++++++++++++++++++++++
  if fnGetSCSetInfo(SC_NO,'MOVE_ON')='1' then
  begin
    TEdit(Self.FindComponent('edt_MoveOn')).Text := 'O';
  end else
  begin
    TEdit(Self.FindComponent('edt_MoveOn')).Text := '';
  end;
}
  // LHB
  TEdit(Self.FindComponent('edt_MoveOn')).Text := '';

  //++++++++++++++++++++++
  // 데이터초기화
  //++++++++++++++++++++++
  if fnGetSCSetInfo(SC_NO,'DATA_RESET')='1' then
  begin
    TEdit(Self.FindComponent('edt_DataReset')).Text := 'O';
  end else
  begin
    TEdit(Self.FindComponent('edt_DataReset')).Text := '';
  end;


  //++++++++++++++++++++++
  // 작업정보 (TT_SCIO)
  //++++++++++++++++++++++
  if fnSCIO_Exist(SC_NO) then
  begin
    if fnSCIO_Load(SC_NO) then
    begin
      TLabel(Self.FindComponent('lbl_JobType')).Caption := '  '+GetTextMsg(SC_NO, 'ORD_TYPE') ; // 작업유형
  //    TLabel(Self.FindComponent('lbl_JobType')).Color   := clLime ;

      TEdit(Self.FindComponent('edt_Lugg'    )).Text := SC_JOB[SC_NO].ID_ORDLUGG ;      // 작업번호
      TEdit(Self.FindComponent('edt_SrcBank' )).Text := SC_JOB[SC_NO].LOAD_BANK ;       // 지령 시작 열
      TEdit(Self.FindComponent('edt_SrcBay'  )).Text := SC_JOB[SC_NO].LOAD_BAY ;        // 지령 시작 연
      TEdit(Self.FindComponent('edt_SrcLevel')).Text := SC_JOB[SC_NO].LOAD_LEVEL ;      // 지령 시작 단
      TEdit(Self.FindComponent('edt_DstBank' )).Text := SC_JOB[SC_NO].UNLOAD_BANK ;     // 지령 종료 열
      TEdit(Self.FindComponent('edt_DstBay'  )).Text := SC_JOB[SC_NO].UNLOAD_BAY ;      // 지령 종료 연
      TEdit(Self.FindComponent('edt_DstLevel')).Text := SC_JOB[SC_NO].UNLOAD_LEVEL ;    // 지령 종료 단

      if (SC_JOB[SC_NO].IO_TYPE='I') then
      begin
        if (SC_STATUS[SC_NO].D210[08]='0') and (SC_STATUS[SC_NO].D210[10]='1') then
        begin
          imgRFork_Left.Visible  := False;
          imgRFork_Right.Visible := True;
        end else
        if (SC_STATUS[SC_NO].D210[08]='0') and (SC_STATUS[SC_NO].D210[11]='1') and (SC_JOB[SC_NO].UNLOAD_BANK='0001')  then
        begin
          imgRFork_Left.Visible  := True;
          imgRFork_Right.Visible := False;
        end else
        if (SC_STATUS[SC_NO].D210[08]='0') and (SC_STATUS[SC_NO].D210[11]='1') and (SC_JOB[SC_NO].UNLOAD_BANK='0002')  then
        begin
          imgRFork_Left.Visible  := False;
          imgRFork_Right.Visible := True;
        end else
        begin
          imgRFork_Left.Visible  := False;
          imgRFork_Right.Visible := False;
        end;
      end else
      if (SC_JOB[SC_NO].IO_TYPE='O') then
      begin
        if (SC_STATUS[SC_NO].D210[08]='0') and (SC_STATUS[SC_NO].D210[11]='1') then
        begin
          imgRFork_Left.Visible  := False;
          imgRFork_Right.Visible := True;
        end else
        if (SC_STATUS[SC_NO].D210[08]='0') and (SC_STATUS[SC_NO].D210[10]='1') and (SC_JOB[SC_NO].LOAD_BANK='0001')  then
        begin
          imgRFork_Left.Visible  := True;
          imgRFork_Right.Visible := False;
        end else
        if (SC_STATUS[SC_NO].D210[08]='0') and (SC_STATUS[SC_NO].D210[10]='1') and (SC_JOB[SC_NO].LOAD_BANK='0002')  then
        begin
          imgRFork_Left.Visible  := False;
          imgRFork_Right.Visible := False;
        end else
        begin
          imgRFork_Left.Visible  := False;
          imgRFork_Right.Visible := True;
        end;
      end else
      begin
        imgRFork_Left.Visible  := False;
        imgRFork_Right.Visible := False;
      end;
    end else
    begin
      TLabel(Self.FindComponent('lbl_JobType')).Caption := '' ; // 작업유형
//      TLabel(Self.FindComponent('lbl_JobType')).Color   := clWhite ;

      TEdit(Self.FindComponent('edt_Lugg'    )).Text := '';    // 작업번호
      TEdit(Self.FindComponent('edt_SrcBank' )).Text := '';    // 지령 시작 열
      TEdit(Self.FindComponent('edt_SrcBay'  )).Text := '';    // 지령 시작 연
      TEdit(Self.FindComponent('edt_SrcLevel')).Text := '';    // 지령 시작 단
      TEdit(Self.FindComponent('edt_DstBank' )).Text := '';    // 지령 종료 열
      TEdit(Self.FindComponent('edt_DstBay'  )).Text := '';    // 지령 종료 연
      TEdit(Self.FindComponent('edt_DstLevel')).Text := '';    // 지령 종료 단

      imgRFork_Left.Visible  := False;
      imgRFork_Right.Visible := False;
    end;
  end else
  begin
    TLabel(Self.FindComponent('lbl_JobType')).Caption := '' ; // 작업유형
//    TLabel(Self.FindComponent('lbl_JobType')).Color   := clWhite ;

    TEdit(Self.FindComponent('edt_Lugg'    )).Text := '';    // 작업번호
    TEdit(Self.FindComponent('edt_SrcBank' )).Text := '';    // 지령 시작 열
    TEdit(Self.FindComponent('edt_SrcBay'  )).Text := '';    // 지령 시작 연
    TEdit(Self.FindComponent('edt_SrcLevel')).Text := '';    // 지령 시작 단
    TEdit(Self.FindComponent('edt_DstBank' )).Text := '';    // 지령 종료 열
    TEdit(Self.FindComponent('edt_DstBay'  )).Text := '';    // 지령 종료 연
    TEdit(Self.FindComponent('edt_DstLevel')).Text := '';    // 지령 종료 단

    imgRFork_Left.Visible  := False;
    imgRFork_Right.Visible := False;
  end;


  //++++++++++++++++++++++
  // 기상반 위치
  //++++++++++++++++++++++
  if StrToInt(SC_STATUS[SC_NO].D200)=0 then
    TPanel(Self.FindComponent('SC')).Left := TPanel(Self.FindComponent('RackBay01')).Left+315
  else
  begin
    if StrToInt(SC_STATUS[SC_NO].D200) < 12 then
      TPanel(Self.FindComponent('SC')).Left := TPanel(Self.FindComponent('RackBay'+FormatFloat('00',StrToInt(SC_STATUS[SC_NO].D200)))).Left + 315
    else
      TPanel(Self.FindComponent('SC')).Left := TPanel(Self.FindComponent('RackBay11')).Left+315
  end;
end;

//==============================================================================
// fnSignalMsg
//==============================================================================
function TfrmU510.fnSignalMsg(Signal: string): String;
begin
  Result := '';
  if      Signal='0'    then Result := ''
  else if Signal='1'    then Result := 'O'
  else                       Result := Signal;
end;

//==============================================================================
// fnCagoMsg                                                                            Curtain
//==============================================================================
function TfrmU510.fnCagoMsg(Signal: string): Boolean;
begin
  Result := False;
  if      Signal='0'    then Result := False
  else if Signal='1'    then Result := True
  else                       Result := False;
end;

//==============================================================================
// fnCurMsg                                                                            Curtain
//==============================================================================
function TfrmU510.fnCurMsg(FName : string): Boolean;
var
  StrSQL, Param : String ;
  ExecNo : Integer;
begin
  try
    StrSQL := ' SELECT * FROM TC_CURRENT WHERE CURRENT_NAME = ''CUR_PARAM'' ';

    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open;
      if not (Bof and Eof ) then
      begin
        Param := FieldByName(FName).AsString;
        if Param = '2' then Result := False
        else                Result := True;
      end;
      Close;
    end;
  except
    on E : Exception do
    begin
      qryTemp.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'fnCurMsg', '', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnCurMsg Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;

//==============================================================================
// fnCurtainMsg
//==============================================================================
function TfrmU510.fnCurtainMsg(Signal: string): String;
begin
  Result := '';
  if      Signal='1'    then Result := '커튼 OFF'
  else if Signal='0'    then Result := '커튼 ON'
  else                       Result := '';
end;

//==============================================================================
// fnModeMsg
//==============================================================================
function TfrmU510.fnModeMsg(Signal: string): String;
begin
  Result := '';
  if      Signal='0'    then Result := '수동'
  else if Signal='1'    then Result := '자동'
  else                       Result := Signal;
end;

//==============================================================================
// fnSignalEditColor
//==============================================================================
function TfrmU510.fnSignalEditColor(Signal,Flag: string): TColor;
begin
  Result := clWhite ;
  if Flag='0' then
  begin // 일반
    Result := clWhite
  end else
  if Flag='1' then
  begin // 에러
    if      Signal='0'    then Result := clWhite
    else if Signal='1'    then Result := clRed
    else                       Result := clWhite;
  end else
  if Flag='2' then
  begin // 레디
    if      Signal='0'    then Result := clWhite
    else if Signal='1'    then Result := clLime
    else                       Result := clWhite;
  end else
  if Flag='3' then
  begin // 완료
    if      Signal='0'    then Result := clWhite
    else if Signal='1'    then Result := clNavy
    else                       Result := clWhite;
  end else
  if Flag='4' then
  begin // 모드
    if      Signal='0'    then Result := clYellow
    else if Signal='1'    then Result := clLime
    else                       Result := clWhite;
  end else
  if Flag='5' then
  begin // 커튼
    if      Signal='1'    then Result := clYellow
    else if Signal='0'    then Result := clLime
    else                       Result := clWhite;
  end else
end;

//==============================================================================
// fnSignalFontColor
//==============================================================================
function TfrmU510.fnSignalFontColor(Signal,Flag: string): TColor;
begin
  Result := clBlack ;
  if Flag='0' then
  begin // 일반
    Result := clNavy;
  end else
  if Flag='1' then
  begin // 에러
    if      Signal='0'    then Result := clBlack
    else if Signal='1'    then Result := clWhite
    else                       Result := clBlack;
  end else
  if Flag='2' then
  begin // 레디
    Result := clBlack;
  end else
  if Flag='3' then
  begin // 완료
    if      Signal='0'    then Result := clBlack
    else if Signal='1'    then Result := clWhite
    else                       Result := clBlack;
  end else
  if Flag='4' then
  begin // 모드
    Result := clBlack;
  end else
end;

//==============================================================================
// fnGetErrMsg : 에러내용 Get
//==============================================================================
function TfrmU510.fnGetErrMsg(SC_NO: integer; GetField,ErrCode: String): String;
var
  StrSQL : String ;
begin
  Result := '' ;
  StrSQL := ' SELECT ' + GetField + ' AS MSG ' +
            '   FROM TM_ERROR ' +
            '  WHERE ERR_DEV  = ''SC'' ' +
            '    AND ERR_CODE = ''' + ErrCode + ''' ';

  try
    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open ;

      if not ( Bof and Eof) then
      begin
        Result := FieldByName('MSG').AsString ;
      end;
      Close ;
    end;
  except
    on E : Exception do
    begin
      qryTemp.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'fnGetErrMsg', '', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnGetErrMsg Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;


//==============================================================================
// fnSCIO_Exist : 해당 호기가 현재 작업지시 중인 건이 있는지 확인
//==============================================================================
function TfrmU510.fnSCIO_Exist(SC_NO: integer): Boolean;
var
  StrSQL : String ;
begin
  try
    Result := False;
    StrSQL := ' SELECT COUNT(*) as CNT ' +
              '   FROM TT_SCIO         ' +
              '    WHERE ID_NO = ''' + IntToStr(SC_NO) + ''' ';

    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open;

      if not ( Bof and Eof) then
      begin
        Result := Boolean( FieldByName('CNT').AsInteger > 0 ) ;
      end;
      Close ;
    end;
  except
    on E : Exception do
    begin
      qryTemp.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'fnSCIO_Exist', '', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnSCIO_Exist Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;

//==============================================================================
// fnSCIO_Load : SCIO 지시 데이터 Get
//==============================================================================
function TfrmU510.fnSCIO_Load(SC_NO: integer): Boolean;
var
  StrSQL : String ;
begin
  try
    Result := False ;
    StrSQL := ' SELECT SCIO.*, ORD.* ' +
              '   FROM TT_SCIO SCIO  ' +
              '      , TT_ORDER ORD  ' +
              '  WHERE SCIO.ID_NO = ''' + IntToStr(SC_NO) + ''' ' +
              '    AND LTRIM(SCIO.ID_INDEX) = LTRIM(ORD.LUGG)' +
              '    AND LTRIM(SCIO.ID_DATE)  = SUBSTRING(LTRIM(ORD.REG_TIME),1,8)  ' +
              '    AND LTRIM(SCIO.ID_TIME)  = SUBSTRING(LTRIM(ORD.REG_TIME),9,6)  ' ;

    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open;

      if not ( Bof and Eof ) then
      begin
        SC_JOB[SC_NO].ID_ORDLUGG   := FieldByName('ID_INDEX' ).AsString ;       // 작업 번호
        SC_JOB[SC_NO].ID_ORDDATE   := FieldByName('ID_DATE'  ).AsString ;       // 작업 생성 일자
        SC_JOB[SC_NO].ID_ORDTIME   := FieldByName('ID_TIME'  ).AsString ;       // 작업 생성 일시
        SC_JOB[SC_NO].ID_REGTIME   := SC_JOB[SC_NO].ID_ORDDATE +                // 작업 등록 시간 ( 작업 생성 일자 + 작업 생성 일시 )
                                      SC_JOB[SC_NO].ID_ORDTIME ;
        SC_JOB[SC_NO].IO_TYPE      := FieldByName('IO_TYPE'     ).AsString ;    // 입출고 유형 ( I:입고, O:출고, M:Rack To Rack, C:SC Site to SC Site )
        SC_JOB[SC_NO].LOAD_BANK    := FieldByName('LOAD_BANK'   ).AsString ;    // 적재 열
        SC_JOB[SC_NO].LOAD_BAY     := FieldByName('LOAD_BAY'    ).AsString ;    // 적재 연
        SC_JOB[SC_NO].LOAD_LEVEL   := FieldByName('LOAD_LEVEL'  ).AsString ;    // 적재 단
        SC_JOB[SC_NO].UNLOAD_BANK  := FieldByName('UNLOAD_BANK' ).AsString ;    // 하역 열
        SC_JOB[SC_NO].UNLOAD_BAY   := FieldByName('UNLOAD_BAY'  ).AsString ;    // 하역 연
        SC_JOB[SC_NO].UNLOAD_LEVEL := FieldByName('UNLOAD_LEVEL').AsString ;    // 하역 단

        SC_JOB[SC_NO].SC_STEP      := FieldByName('SC_STEP').AsString ;         // 작업 단계

        Result := True ;
      end;
      Close ;
    end;
  except
    on E : Exception do
    begin
      qryTemp.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'fnSCIO_Load', '', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnSCIO_Load Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;

//==============================================================================
// GetTextMsg
//==============================================================================
function TfrmU510.GetTextMsg(SC_NO:integer; Kind:String): String;
var
  RtnStr : String;
begin
  RtnStr := '';

  if (Kind = 'ORD_TYPE') then
  begin
    if      (SC_JOB[SC_NO].IO_TYPE='I') then RtnStr := '입고작업 중'
    else if (SC_JOB[SC_NO].IO_TYPE='O') then RtnStr := '출고작업 중'
    else                                     RtnStr := '대기 중';
  end;
  Result := RtnStr;
end;


//==============================================================================
// fnGetSCSetInfo : 설비 명령 관련 데이터 반환
//==============================================================================
function TfrmU510.fnGetSCSetInfo(SC_NO: Integer; GetField: String): String;
var
  StrSQL : String ;
begin
  Result := '' ;
  StrSQL := ' SELECT ' + GetField + ' AS DATA ' +
            '   FROM TC_SCSETINFO ' +
            '  WHERE SC_NO = ' + IntToStr(SC_No)  ;

  try
    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open ;

      if not ( Bof and Eof) then
      begin
        Result := FieldByName('Data').AsString ;
      end;
      Close ;
    end;
  except
    on E : Exception do
    begin
      qryTemp.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'fnGetSCSetInfo', '', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnGetSCSetInfo Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;

//==============================================================================
// btnResetClick
//==============================================================================
procedure TfrmU510.btnClick(Sender: TObject);
var
  SC_NO, idx : integer ;
begin
  SC_NO := 1 ;
  Idx := (Sender as TButton).Tag ;

  if Idx=1 then
  begin
    if MessageDlg('현재 진행 중인 작업을 초기화 하시겠습니까?' , mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit ;
    if ( fnGetSCSetInfo(SC_NO,'JOB_CANCLE')<>'1' ) then fnSetSCSetInfo (SC_NO,'JOB_CANCLE', '1') ;
  end else
  begin
    if MessageDlg('현재 진행 중인 작업을 재기동 하시겠습니까?' , mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit ;
    if ( fnGetSCSetInfo(SC_NO,'JOB_RETRY')<>'1' ) then fnSetSCSetInfo (SC_NO,'JOB_RETRY', '1') ;
  end;

end;

//==============================================================================
// fnSetSCSetInfo : 설비 명령 관련 데이터 저장
//==============================================================================
function TfrmU510.fnSetSCSetInfo(SC_NO: Integer; SetField, SetValue: String): Boolean;
var
  StrSQL : String ;
  ExecNo : Integer;
begin
  try
    Result := False;
    StrSQL := ' UPDATE TC_SCSETINFO ' +
              '    SET ' + SetField + ' = ''' + SetValue + '''  ' +
              '  WHERE SC_NO = '    + IntToStr(SC_No)  ;

    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      ExecNo := ExecSQL ;
      if ExecNo > 0 then Result := True ;
      Close ;
    end;
  except
    on E : Exception do
    begin
      qryTemp.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'fnSetSCSetInfo', '', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnSetSCSetInfo Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;

//==============================================================================
// fnRFIDUpdate
//==============================================================================
procedure TfrmU510.fnRFIDUpdate(Number, Flag: string);
var
  StrSQL : String ;
  ExecNo : Integer;
begin
  try
    if Flag = '0' then
    begin
      TLabel(Self.FindComponent('lblLineName1_RF0'  + Number)).Caption := '-';
      TLabel(Self.FindComponent('lblLineName2_RF0'  + Number)).Caption := '-';
      TLabel(Self.FindComponent('lblPalletNo1_RF0'  + Number)).Caption := '-';
      TLabel(Self.FindComponent('lblPalletNo2_RF0'  + Number)).Caption := '-';
      TLabel(Self.FindComponent('lblModelNo1_RF0'   + Number)).Caption := '-';
      TLabel(Self.FindComponent('lblModelNo2_RF0'   + Number)).Caption := '-';
      TLabel(Self.FindComponent('lblBmaNo_RF0'      + Number)).Caption := '-';
      TLabel(Self.FindComponent('lblArea_RF0'       + Number)).Caption := '-';
      TLabel(Self.FindComponent('lblPalletBma1_RF0' + Number)).Caption := '-';
      TLabel(Self.FindComponent('lblPalletBma2_RF0' + Number)).Caption := '-';
      TLabel(Self.FindComponent('lblPalletBma3_RF0' + Number)).Caption := '-';
      Exit;
    end;

    if Flag = '1' then StrSQL := ' SELECT TOP(1) * FROM TC_RFID_HIST WHERE PORT_NO = ' + ' '''+Number+''' ORDER BY CRT_DT DESC '
    else               StrSQL := ' SELECT * FROM TC_RFID WHERE PORT_NO = ' + ' '''+Number+''' ';

    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open;

      TLabel(Self.FindComponent('lblLineName1_RF0'  + Number)).Caption := FieldByName('H00').AsString ;
      TLabel(Self.FindComponent('lblLineName2_RF0'  + Number)).Caption := FieldByName('H01').AsString ;
      TLabel(Self.FindComponent('lblPalletNo1_RF0'  + Number)).Caption := FieldByName('H02').AsString ;
      TLabel(Self.FindComponent('lblPalletNo2_RF0'  + Number)).Caption := FieldByName('H03').AsString ;
      TLabel(Self.FindComponent('lblModelNo1_RF0'   + Number)).Caption := FieldByName('H16').AsString ;
      TLabel(Self.FindComponent('lblModelNo2_RF0'   + Number)).Caption := FieldByName('H17').AsString ;
      TLabel(Self.FindComponent('lblBmaNo_RF0'      + Number)).Caption := FieldByName('H18').AsString ;
      TLabel(Self.FindComponent('lblArea_RF0'       + Number)).Caption := FieldByName('H19').AsString ;
      TLabel(Self.FindComponent('lblPalletBma1_RF0' + Number)).Caption := FieldByName('H20').AsString ;
      TLabel(Self.FindComponent('lblPalletBma2_RF0' + Number)).Caption := FieldByName('H21').AsString ;
      TLabel(Self.FindComponent('lblPalletBma3_RF0' + Number)).Caption := FieldByName('H22' ).AsString ;

      Close;
    end;
  except
    on E : Exception do
    begin
      qryTemp.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'fnRFIDUpdate', '', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnRFIDUpdate Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;

//==============================================================================
// btnCurtainClick
//==============================================================================
procedure TfrmU510.btnCurtainClick(Sender: TObject);
var
  StrSQL, StrSQL2, CurtainNo : String ;
  ExecNo : Integer;
begin
  CurtainNo := IntToStr((Sender as TButton).Tag);

  if (Sender as TButton).Caption = '커튼 OFF' then
  begin
    if ((CurtainNo = '2') and (SC_STATUS[1].D211[09] = '0')) or
       ((CurtainNo = '4') and (SC_STATUS[1].D211[11] = '0')) or
       ((CurtainNo = '6') and (SC_STATUS[1].D211[13] = '0')) then
    begin
      MessageDlg('출고스테이션에 경우 화물이 있어야 커튼 OFF 가능합니다.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end;

    StrSQL := ' UPDATE TC_CURRENT ' +
              '    SET OPTION1 = ''' + CurtainNo + ''' ' +
              '  WHERE CURRENT_NAME = ''CURTAIN'' ';
    StrSQL2 := ' UPDATE TC_CURRENT ' +
               '    SET OPTION'+CurtainNo+' = ''1''' +
               '  WHERE CURRENT_NAME = ''CUR_PARAM'' ';
  end else
  begin
    StrSQL := ' UPDATE TC_CURRENT ' +
              '    SET OPTION2 = ''' + CurtainNo + ''' ' +
              '  WHERE CURRENT_NAME = ''CURTAIN'' ';
    StrSQL2 := ' UPDATE TC_CURRENT ' +
               '    SET OPTION'+CurtainNo+' = ''0''' +
               '  WHERE CURRENT_NAME = ''CUR_PARAM'' ';
  end;

  try
    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      ExecNo := ExecSQL ;
      if ExecNo > 0 then
      begin
        Close;
        SQL.Clear;
        SQL.Text := StrSQL2;
        ExecSQL;
      end;
    end;
  except
    on E : Exception do
    begin
      qryTemp.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'btnCurtainClick', '', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure btnCurtainClick Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;
end.





unit U510;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, d_MainDm, h_MainLib, h_ReferLib, StdCtrls, DB, ADODB, ExLibrary, ExVclLib,
  Grids, StrUtils, DBGrids, comobj, frxClass, frxDBSet, DBGridEhGrouping, EhLibADO,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,DBGridEhImpExp,
  DBGridEh, Vcl.Mask, Vcl.DBCtrls, DBCtrlsEh, PrnDbgeh, Vcl.Buttons ;

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
    RackBay10: TPanel;
    Bay10: TPanel;
    RackBay11: TPanel;
    Bay11: TPanel;
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
    Panel18: TPanel;
    Panel19: TPanel;
    Panel20: TPanel;
    Panel21: TPanel;
    Panel22: TPanel;
    Panel23: TPanel;
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
    edt_InReady: TEdit;
    edt_Double: TEdit;
    Panel47: TPanel;
    edt_OutReady: TEdit;
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
    Panel65: TPanel;
    PnlOtRdy: TPanel;
    PnlInRdy: TPanel;
    shpInRdy: TShape;
    shpOtRdy: TShape;
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
    �����: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    imgRFork_Left: TImage;
    Label11: TLabel;
    Label12: TLabel;
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
    Panel82: TPanel;
    Panel83: TPanel;
    Panel84: TPanel;
    lbl_JobType: TLabel;
    btnReset: TButton;
    btnRetry: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Pnl_MainResize(Sender: TObject);
    procedure tmrQryTimer(Sender: TObject);
    procedure btnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure fnCommandStart;
    procedure fnCommandNew;
    procedure fnCommandExcel;
    procedure fnCommandDelete;
    procedure fnCommandPrint;
    procedure fnCommandQuery;
    procedure fnCommandClose;
    procedure fnWmMsgRecv (var MSG : TMessage) ; message WM_USER ;

    procedure SCTREAD(SC_NO: Integer);
    procedure SC_StatusDisplay(SC_NO: Integer);

    function fnSignalMsg(Signal: string): String;
    function fnModeMsg(Signal: string): String;
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


  SC_JOB    : Array [START_SCNO..END_SCNO] of TSC_JOB ; // SC �۾�
  SC_STATUS : Array [START_SCNO..End_SCNO] of TSC_STATUS ;    // SC ����



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
    MSG_MDI_WIN_NEW     : begin fnCommandNew     ; end;
    MSG_MDI_WIN_EXCEL   : begin fnCommandExcel   ; end;
    MSG_MDI_WIN_DELETE  : begin fnCommandDelete  ; end;
    MSG_MDI_WIN_PRINT   : begin fnCommandPrint   ; end;
    MSG_MDI_WIN_QUERY   : begin fnCommandQuery   ; end;
    MSG_MDI_WIN_CLOSE   : begin fnCommandClose   ; Close; end;
  end;
end;

//==============================================================================
// FormActivate
//==============================================================================
procedure TfrmU510.FormActivate(Sender: TObject);
begin
  frmMain.PnlMainMenu.Caption := (Sender as TForm).Caption ;
  fnWmMsgSend( 22222,111 );

  fnCommandQuery ;
  if not tmrQry.Enabled then tmrQry.Enabled := True ;
end;

//==============================================================================
// FormDeactivate
//==============================================================================
procedure TfrmU510.FormDeactivate(Sender: TObject);
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
// fnCommandNew [�ű�]
//==============================================================================
procedure TfrmU510.fnCommandNew  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [����]
//==============================================================================
procedure TfrmU510.fnCommandExcel;
begin
//
end;

//==============================================================================
// fnCommandDelete [����]
//==============================================================================
procedure TfrmU510.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandPrint [�μ�]
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
      SCTREAD(i);          // SC ���� Get
      SC_StatusDisplay(i); // SC���� Display
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
// SCTREAD
//==============================================================================
procedure TfrmU510.SCTREAD(SC_NO: Integer);
var
  j, k : integer ;
  StrSql, TmpCol, StrLog, D210, D211 : String ;
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
  TEdit(Self.FindComponent('edt_CurrBay'      )).Text := SC_STATUS[SC_NO].D200;  // ������ġ ��
  // D201
  TEdit(Self.FindComponent('edt_CurrLevel'    )).Text := SC_STATUS[SC_NO].D201;  // ������ġ ��
  // D205
  TEdit(Self.FindComponent('edt_ErrorCode'    )).Text := SC_STATUS[SC_NO].D205;  // �̻��ڵ�
  TEdit(Self.FindComponent('edt_ErrorDesc'    )).Text := fnGetErrMsg(SC_NO, 'ERR_NAME', SC_STATUS[SC_NO].D205);  // �̻󳻿�

  if (SC_STATUS[SC_NO].D205='0071') or
     (SC_STATUS[SC_NO].D205='0072') then
  begin
    btnRetry.Enabled := True ;
  end else btnRetry.Enabled := False ;



  //++++++++++++++++++++++++++++++++++++++++++++
  // ���°� ǥ�� (D210.00 ~ D210.15)
  //++++++++++++++++++++++++++++++++++++++++++++
  TEdit(Self.FindComponent('edt_SCTMode'      )).Text := fnModeMsg(  SC_STATUS[SC_NO].D210[00]); // ����� ���
  TEdit(Self.FindComponent('edt_SCCMode'      )).Text := fnModeMsg(  SC_STATUS[SC_NO].D210[01]); // ���� ���
  TEdit(Self.FindComponent('edt_Emergency'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[02]); // �������
  TEdit(Self.FindComponent('edt_StroreIn'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[03]); // �԰��۾� ��
  TEdit(Self.FindComponent('edt_StroreOut'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[04]); // ����۾� ��
  TEdit(Self.FindComponent('edt_DrvPosition'  )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[06]); // ���� ����ġ
  TEdit(Self.FindComponent('edt_UDPosition'   )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[07]); // �°� ����ġ
  TEdit(Self.FindComponent('edt_ForkCenter'   )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[08]); // ��ũ ����
  TEdit(Self.FindComponent('edt_CargoExist'   )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[09]); // ��ũ ��ǰ ����
  TEdit(Self.FindComponent('edt_Loading'      )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[10]); // �ε� ��
  TEdit(Self.FindComponent('edt_UnLoading'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[11]); // ��ε� ��
  TEdit(Self.FindComponent('edt_Error'        )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[15]); // �̻�߻�
  // D211.00 ~ D211.15
  TEdit(Self.FindComponent('edt_StandBy'      )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[00]); // �����
  TEdit(Self.FindComponent('edt_Working'      )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[01]); // �۾���
  TEdit(Self.FindComponent('edt_Complete'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[02]); // �۾��Ϸ�
  TEdit(Self.FindComponent('edt_Double'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[03]); // �����԰�
  TEdit(Self.FindComponent('edt_Empty'        )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[04]); // �����
  TEdit(Self.FindComponent('edt_ForceComplete')).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[07]); // �����Ϸ�
  TEdit(Self.FindComponent('edt_InReady'      )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[08]); // �԰���
  TEdit(Self.FindComponent('edt_OutReady'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[09]); // �����

  //++++++++++++++++++++++++++++++++++++++++++++
  // ����Ʈ ���� ���� (D210.00 ~ D210.15)
  //++++++++++++++++++++++++++++++++++++++++++++
  TEdit(Self.FindComponent('edt_SCTMode'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[00],'4'); // ����� ���
  TEdit(Self.FindComponent('edt_SCCMode'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[01],'4'); // ���� ���
  TEdit(Self.FindComponent('edt_Emergency'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[02],'1'); // �������
  TEdit(Self.FindComponent('edt_StroreIn'     )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[03],'0'); // �԰��۾� ��
  TEdit(Self.FindComponent('edt_StroreOut'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[04],'0'); // ����۾� ��
  TEdit(Self.FindComponent('edt_DrvPosition'  )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[06],'0'); // ���� ����ġ
  TEdit(Self.FindComponent('edt_UDPosition'   )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[07],'0'); // �°� ����ġ
  TEdit(Self.FindComponent('edt_ForkCenter'   )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[08],'0'); // ��ũ ����
  TEdit(Self.FindComponent('edt_CargoExist'   )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[09],'0'); // ��ũ ��ǰ ����
  TEdit(Self.FindComponent('edt_Loading'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[10],'0'); // �ε� ��
  TEdit(Self.FindComponent('edt_UnLoading'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[11],'0'); // ��ε� ��
  TEdit(Self.FindComponent('edt_Error'        )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[15],'1'); // �̻�߻�
  // D211.00 ~ D211.15
  TEdit(Self.FindComponent('edt_StandBy'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[00],'0'); // �����
  TEdit(Self.FindComponent('edt_Working'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[01],'0'); // �۾���
  TEdit(Self.FindComponent('edt_Complete'     )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[02],'3'); // �۾��Ϸ�
  TEdit(Self.FindComponent('edt_Double'       )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[03],'1'); // �����԰�
  TEdit(Self.FindComponent('edt_Empty'        )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[04],'1'); // �����
  TEdit(Self.FindComponent('edt_ForceComplete')).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[07],'3'); // �����Ϸ�
  TEdit(Self.FindComponent('edt_InReady'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[08],'2'); // �԰���
  TEdit(Self.FindComponent('edt_OutReady'     )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[09],'2'); // �����

  //++++++++++++++++++++++++++++++++++++++++++++
  // ����Ʈ ��Ʈ ���� ���� (D210.00 ~ D210.15)
  //++++++++++++++++++++++++++++++++++++++++++++
  TEdit(Self.FindComponent('edt_SCTMode'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[00],'4'); // ����� ���
  TEdit(Self.FindComponent('edt_SCCMode'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[01],'4'); // ���� ���
  TEdit(Self.FindComponent('edt_Emergency'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[02],'1'); // �������
  TEdit(Self.FindComponent('edt_StroreIn'     )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[03],'0'); // �԰��۾� ��
  TEdit(Self.FindComponent('edt_StroreOut'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[04],'0'); // ����۾� ��
  TEdit(Self.FindComponent('edt_DrvPosition'  )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[06],'0'); // ���� ����ġ
  TEdit(Self.FindComponent('edt_UDPosition'   )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[07],'0'); // �°� ����ġ
  TEdit(Self.FindComponent('edt_ForkCenter'   )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[08],'0'); // ��ũ ����
  TEdit(Self.FindComponent('edt_CargoExist'   )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[09],'0'); // ��ũ ��ǰ ����
  TEdit(Self.FindComponent('edt_Loading'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[10],'0'); // �ε� ��
  TEdit(Self.FindComponent('edt_UnLoading'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[11],'0'); // ��ε� ��
  TEdit(Self.FindComponent('edt_Error'        )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[15],'1'); // �̻�߻�
  // D211.00 ~ D211.15
  TEdit(Self.FindComponent('edt_StandBy'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[00],'0'); // �����
  TEdit(Self.FindComponent('edt_Working'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[01],'0'); // �۾���
  TEdit(Self.FindComponent('edt_Complete'     )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[02],'3'); // �۾��Ϸ�
  TEdit(Self.FindComponent('edt_Double'       )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[03],'1'); // �����԰�
  TEdit(Self.FindComponent('edt_Empty'        )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[04],'1'); // �����
  TEdit(Self.FindComponent('edt_ForceComplete')).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[07],'3'); // �����Ϸ�
  TEdit(Self.FindComponent('edt_InReady'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[08],'2'); // �԰���
  TEdit(Self.FindComponent('edt_OutReady'     )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[09],'2'); // �����


  //++++++++++++++++++++++++++++++++++++++++++++
  // ��&��� ����
  //++++++++++++++++++++++++++++++++++++++++++++
  if SC_STATUS[SC_NO].D211[08]='1' then
  begin
    shpInRdy.Brush.Color := clLime;
    PnlInRdy.Caption := '   �԰���';
  end else
  begin
    shpInRdy.Brush.Color := clYellow;
    PnlInRdy.Caption := '    �԰� �Ұ���';
  end;

  if SC_STATUS[SC_NO].D211[09]='1' then
  begin
    shpOtRdy.Brush.Color := clLime;
    PnlOtRdy.Caption := '   �����';
  end else
  begin
    shpOtRdy.Brush.Color := clYellow;
    PnlOtRdy.Caption := '    ��� �Ұ���';
  end;



  //++++++++++++++++++++++++++++++++++++++++++++
  // SC����
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
  // ȭ������
  //++++++++++++++++++++++
  if (SC_STATUS[SC_NO].D210[09]='1') then
  begin
    TPanel(Self.FindComponent('SCRFork')).Color := $00C08000 ;
  end else
  begin
    TPanel(Self.FindComponent('SCRFork')).Color := clWhite ;
  end;


  //++++++++++++++++++++++
  // ���ôܰ�
  //++++++++++++++++++++++
//  edt_Step.Text := fnGetSCSetInfo(SC_NO, 'SC_STATUS');


  //++++++++++++++++++++++
  // �⵿����
  //++++++++++++++++++++++
  if fnGetSCSetInfo(SC_NO,'MOVE_ON')='1' then
  begin
    TEdit(Self.FindComponent('edt_MoveOn')).Text := 'O';
  end else
  begin
    TEdit(Self.FindComponent('edt_MoveOn')).Text := '';
  end;


  //++++++++++++++++++++++
  // �������ʱ�ȭ
  //++++++++++++++++++++++
  if fnGetSCSetInfo(SC_NO,'DATA_RESET')='1' then
  begin
    TEdit(Self.FindComponent('edt_DataReset')).Text := 'O';
  end else
  begin
    TEdit(Self.FindComponent('edt_DataReset')).Text := '';
  end;


  //++++++++++++++++++++++
  // �۾����� (TT_SCIO)
  //++++++++++++++++++++++
  if fnSCIO_Exist(SC_NO) then
  begin
    if fnSCIO_Load(SC_NO) then
    begin
      TLabel(Self.FindComponent('lbl_JobType')).Caption := '  '+GetTextMsg(SC_NO, 'ORD_TYPE') ; // �۾�����
  //    TLabel(Self.FindComponent('lbl_JobType')).Color   := clLime ;

      TEdit(Self.FindComponent('edt_Lugg'    )).Text := SC_JOB[SC_NO].ID_ORDLUGG ;      // �۾���ȣ
      TEdit(Self.FindComponent('edt_SrcBank' )).Text := SC_JOB[SC_NO].LOAD_BANK ;       // ���� ���� ��
      TEdit(Self.FindComponent('edt_SrcBay'  )).Text := SC_JOB[SC_NO].LOAD_BAY ;        // ���� ���� ��
      TEdit(Self.FindComponent('edt_SrcLevel')).Text := SC_JOB[SC_NO].LOAD_LEVEL ;      // ���� ���� ��
      TEdit(Self.FindComponent('edt_DstBank' )).Text := SC_JOB[SC_NO].UNLOAD_BANK ;     // ���� ���� ��
      TEdit(Self.FindComponent('edt_DstBay'  )).Text := SC_JOB[SC_NO].UNLOAD_BAY ;      // ���� ���� ��
      TEdit(Self.FindComponent('edt_DstLevel')).Text := SC_JOB[SC_NO].UNLOAD_LEVEL ;    // ���� ���� ��

      if (SC_JOB[SC_NO].IO_TYPE='I') then
      begin
        if (SC_STATUS[SC_NO].D210[08]='0') and (SC_STATUS[SC_NO].D210[10]='1') then
        begin
          imgRFork_Left.Visible  := True;
          imgRFork_Right.Visible := False;
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
          imgRFork_Left.Visible  := True;
          imgRFork_Right.Visible := False;
        end else
        if (SC_STATUS[SC_NO].D210[08]='0') and (SC_STATUS[SC_NO].D210[10]='1') and (SC_JOB[SC_NO].LOAD_BANK='0001')  then
        begin
          imgRFork_Left.Visible  := True;
          imgRFork_Right.Visible := False;
        end else
        if (SC_STATUS[SC_NO].D210[08]='0') and (SC_STATUS[SC_NO].D210[10]='1') and (SC_JOB[SC_NO].LOAD_BANK='0002')  then
        begin
          imgRFork_Left.Visible  := False;
          imgRFork_Right.Visible := True;
        end else
        begin
          imgRFork_Left.Visible  := False;
          imgRFork_Right.Visible := False;
        end;
      end else
      begin
        imgRFork_Left.Visible  := False;
        imgRFork_Right.Visible := False;
      end;
    end else
    begin
      TLabel(Self.FindComponent('lbl_JobType')).Caption := '' ; // �۾�����
//      TLabel(Self.FindComponent('lbl_JobType')).Color   := clWhite ;

      TEdit(Self.FindComponent('edt_Lugg'    )).Text := '';    // �۾���ȣ
      TEdit(Self.FindComponent('edt_SrcBank' )).Text := '';    // ���� ���� ��
      TEdit(Self.FindComponent('edt_SrcBay'  )).Text := '';    // ���� ���� ��
      TEdit(Self.FindComponent('edt_SrcLevel')).Text := '';    // ���� ���� ��
      TEdit(Self.FindComponent('edt_DstBank' )).Text := '';    // ���� ���� ��
      TEdit(Self.FindComponent('edt_DstBay'  )).Text := '';    // ���� ���� ��
      TEdit(Self.FindComponent('edt_DstLevel')).Text := '';    // ���� ���� ��

      imgRFork_Left.Visible  := False;
      imgRFork_Right.Visible := False;
    end;
  end else
  begin
    TLabel(Self.FindComponent('lbl_JobType')).Caption := '' ; // �۾�����
//    TLabel(Self.FindComponent('lbl_JobType')).Color   := clWhite ;

    TEdit(Self.FindComponent('edt_Lugg'    )).Text := '';    // �۾���ȣ
    TEdit(Self.FindComponent('edt_SrcBank' )).Text := '';    // ���� ���� ��
    TEdit(Self.FindComponent('edt_SrcBay'  )).Text := '';    // ���� ���� ��
    TEdit(Self.FindComponent('edt_SrcLevel')).Text := '';    // ���� ���� ��
    TEdit(Self.FindComponent('edt_DstBank' )).Text := '';    // ���� ���� ��
    TEdit(Self.FindComponent('edt_DstBay'  )).Text := '';    // ���� ���� ��
    TEdit(Self.FindComponent('edt_DstLevel')).Text := '';    // ���� ���� ��

    imgRFork_Left.Visible  := False;
    imgRFork_Right.Visible := False;
  end;


  //++++++++++++++++++++++
  // ���� ��ġ
  //++++++++++++++++++++++
  if StrToInt(SC_STATUS[SC_NO].D200)=0 then
    TPanel(Self.FindComponent('SC')).Left := TPanel(Self.FindComponent('RackBay01')).Left+85
  else
  begin
    if StrToInt(SC_STATUS[SC_NO].D200) < 12 then
      TPanel(Self.FindComponent('SC')).Left := TPanel(Self.FindComponent('RackBay'+FormatFloat('00',StrToInt(SC_STATUS[SC_NO].D200)))).Left + 85
    else
      TPanel(Self.FindComponent('SC')).Left := TPanel(Self.FindComponent('RackBay11')).Left+85
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
// fnModeMsg
//==============================================================================
function TfrmU510.fnModeMsg(Signal: string): String;
begin
  Result := '';
  if      Signal='0'    then Result := '����'
  else if Signal='1'    then Result := '�ڵ�'
  else                       Result := Signal;
end;

//==============================================================================
// fnSignalEditColor
//==============================================================================
function TfrmU510.fnSignalEditColor(Signal,Flag: string): TColor;
begin
  Result := clWhite ;
  if Flag='0' then
  begin // �Ϲ�
    Result := clWhite
  end else
  if Flag='1' then
  begin // ����
    if      Signal='0'    then Result := clWhite
    else if Signal='1'    then Result := clRed
    else                       Result := clWhite;
  end else
  if Flag='2' then
  begin // ����
    if      Signal='0'    then Result := clWhite
    else if Signal='1'    then Result := clLime
    else                       Result := clWhite;
  end else
  if Flag='3' then
  begin // �Ϸ�
    if      Signal='0'    then Result := clWhite
    else if Signal='1'    then Result := clNavy
    else                       Result := clWhite;
  end else
  if Flag='4' then
  begin // ���
    if      Signal='0'    then Result := clYellow
    else if Signal='1'    then Result := clLime
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
  begin // �Ϲ�
    Result := clNavy;
  end else
  if Flag='1' then
  begin // ����
    if      Signal='0'    then Result := clBlack
    else if Signal='1'    then Result := clWhite
    else                       Result := clBlack;
  end else
  if Flag='2' then
  begin // ����
    Result := clBlack;
  end else
  if Flag='3' then
  begin // �Ϸ�
    if      Signal='0'    then Result := clBlack
    else if Signal='1'    then Result := clWhite
    else                       Result := clBlack;
  end else
  if Flag='4' then
  begin // ���
    Result := clBlack;
  end else
end;

//==============================================================================
// fnGetErrMsg : �������� Get
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
    qryTemp.Close;
  end;
end;


//==============================================================================
// fnSCIO_Exist : �ش� ȣ�Ⱑ ���� �۾����� ���� ���� �ִ��� Ȯ��
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
    if qryTemp.Active then qryTemp.Close;
  end;
end;

//==============================================================================
// fnSCIO_Load : SCIO ���� ������ Get
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
              '    AND LTRIM(SCIO.ID_DATE)  = SUBSTR(LTRIM(ORD.REG_TIME),1,8)  ' +
              '    AND LTRIM(SCIO.ID_TIME)  = SUBSTR(LTRIM(ORD.REG_TIME),9,6)  ' ;

    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open;

      if not ( Bof and Eof ) then
      begin
        SC_JOB[SC_NO].ID_ORDLUGG   := FieldByName('ID_INDEX' ).AsString ;       // �۾� ��ȣ
        SC_JOB[SC_NO].ID_ORDDATE   := FieldByName('ID_DATE'  ).AsString ;       // �۾� ���� ����
        SC_JOB[SC_NO].ID_ORDTIME   := FieldByName('ID_TIME'  ).AsString ;       // �۾� ���� �Ͻ�
        SC_JOB[SC_NO].ID_REGTIME   := SC_JOB[SC_NO].ID_ORDDATE +                // �۾� ��� �ð� ( �۾� ���� ���� + �۾� ���� �Ͻ� )
                                      SC_JOB[SC_NO].ID_ORDTIME ;
        SC_JOB[SC_NO].IO_TYPE      := FieldByName('IO_TYPE'     ).AsString ;    // ����� ���� ( I:�԰�, O:���, M:Rack To Rack, C:SC Site to SC Site )
        SC_JOB[SC_NO].LOAD_BANK    := FieldByName('LOAD_BANK'   ).AsString ;    // ���� ��
        SC_JOB[SC_NO].LOAD_BAY     := FieldByName('LOAD_BAY'    ).AsString ;    // ���� ��
        SC_JOB[SC_NO].LOAD_LEVEL   := FieldByName('LOAD_LEVEL'  ).AsString ;    // ���� ��
        SC_JOB[SC_NO].UNLOAD_BANK  := FieldByName('UNLOAD_BANK' ).AsString ;    // �Ͽ� ��
        SC_JOB[SC_NO].UNLOAD_BAY   := FieldByName('UNLOAD_BAY'  ).AsString ;    // �Ͽ� ��
        SC_JOB[SC_NO].UNLOAD_LEVEL := FieldByName('UNLOAD_LEVEL').AsString ;    // �Ͽ� ��

        SC_JOB[SC_NO].SC_STEP      := FieldByName('SC_STEP').AsString ;         // �۾� �ܰ�

        Result := True ;
      end;
      Close ;
    end;
  except
    if qryTemp.Active then qryTemp.Close;
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
    if      (SC_JOB[SC_NO].IO_TYPE='I') then RtnStr := '�԰��۾� ��'
    else if (SC_JOB[SC_NO].IO_TYPE='O') then RtnStr := '����۾� ��'
    else                                     RtnStr := '��� ��';
  end;
  Result := RtnStr;
end;


//==============================================================================
// fnGetSCSetInfo : ���� ��� ���� ������ ��ȯ
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
    if qryTemp.Active then qryTemp.Close;
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
    if MessageDlg('���� ���� ���� �۾��� �ʱ�ȭ �Ͻðڽ��ϱ�?' , mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit ;
    if ( fnGetSCSetInfo(SC_NO,'JOB_CANCLE')<>'1' ) then fnSetSCSetInfo (SC_NO,'JOB_CANCLE', '1') ;
  end else
  begin
    if MessageDlg('���� ���� ���� �۾��� ��⵿ �Ͻðڽ��ϱ�?' , mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit ;
    if ( fnGetSCSetInfo(SC_NO,'JOB_RETRY')<>'1' ) then fnSetSCSetInfo (SC_NO,'JOB_RETRY', '1') ;
  end;

end;

//==============================================================================
// fnSetSCSetInfo : ���� ��� ���� ������ ����
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
    if qryTemp.Active then qryTemp.Close;
  end;
end;


end.





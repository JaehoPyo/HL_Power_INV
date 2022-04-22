unit U220;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, d_MainDm, h_MainLib, h_ReferLib, StdCtrls, DB, ADODB, ExLibrary, ExVclLib,
  Grids, StrUtils, DBGrids, comobj, frxClass, frxDBSet, DBGridEhGrouping, EhLibADO,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,DBGridEhImpExp,
  DBGridEh, Vcl.Mask, Vcl.DBCtrls, DBCtrlsEh, PrnDbgeh, Vcl.Buttons,
  Vcl.ComCtrls ;

type
  TfrmU220 = class(TForm)
    qryTemp: TADOQuery;
    qryInfo: TADOQuery;
    dsInfo: TDataSource;
    EhPrint: TPrintDBGridEh;
    Pnl_Main: TPanel;
    Pnl_Sub: TPanel;
    Panel1: TPanel;
    Panel5: TPanel;
    Shape2: TShape;
    PD_GET_JOBNO: TADOStoredProc;
    Panel9: TPanel;
    Panel7: TPanel;
    Panel12: TPanel;
    btnOrder: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    Panel8: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel13: TPanel;
    Pnl_ITM1: TPanel;
    edtCode: TEdit;
    Panel14: TPanel;
    Pnl_ITM2: TPanel;
    Panel15: TPanel;
    Pnl_Cell1: TPanel;
    Panel16: TPanel;
    Pnl_Cell2: TPanel;
    Pnl_InputCell: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cbLevel: TComboBox;
    cbBay: TComboBox;
    cbBank: TComboBox;
    cbOut: TComboBox;
    lbloutstation: TLabel;
    Panel17: TPanel;
    dtDateFr: TDateTimePicker;
    Panel18: TPanel;
    dtTimeFr: TDateTimePicker;
    edtLineName1: TEdit;
    edtPalletNo1: TEdit;
    edtModelNo1: TEdit;
    edtITM_QTY: TEdit;
    edtLineName2: TEdit;
    edtPalletNo2: TEdit;
    edtModelNo2: TEdit;
    edtArea: TEdit;
    Button1: TButton;
    tmrRFID: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Pnl_MainResize(Sender: TObject);
    procedure Pnl_ITMClick(Sender: TObject);
    procedure Pnl_CellClick(Sender: TObject);
    procedure btnOrderClick(Sender: TObject);
    procedure cbOutChange(Sender: TObject);
    procedure edtCodeChange;
    procedure getRFIDData;
    procedure setRFIDOption;
    procedure Button1Click(Sender: TObject);
    procedure tmrRFIDTimer(Sender: TObject);
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

    procedure OrderDataClear(OrderData:TJobOrder) ;
    function  GetJobNo : Integer;
    function  GetLocation : Boolean;
    function  SetJobOrder : Boolean;
    function  fnGetCHData(SCC_NO,SCC_SR,CH_NO,POS_NO:String) : String ;
  end;
  procedure U220Create();

const
  FormNo ='220';
var
  frmU220: TfrmU220;
  SrtFlag : integer = 0 ;

  OrderData : TJobOrder;

implementation

uses Main, Popup_Item_Search ;

{$R *.dfm}

//==============================================================================
// U220Create
//==============================================================================
procedure U220Create();
begin
  if not Assigned( frmU220 ) then
  begin
    frmU220 := TfrmU220.Create(Application);
    with frmU220 do
    begin
      fnCommandStart;
    end;
  end;
  frmU220.Show;
end;

//==============================================================================
// fnWmMsgRecv
//==============================================================================
procedure TfrmU220.fnWmMsgRecv(var MSG: TMessage);
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
procedure TfrmU220.FormActivate(Sender: TObject);
begin
  MainDm.M_Info.ActiveFormID := '220';
  frmMain.LblMenu000.Caption := MainDm.M_Info.ActiveFormID + '. ' + getLangMenuString(MainDm.M_Info.ActiveFormID, frmMain.LblMenu000.Caption, MainDm.M_Info.LANG_TYPE, 'N');
  frmU220.Caption := MainDm.M_Info.ActiveFormName;
  fnWmMsgSend( 22222,22111 );

  dtDateFr.Date := StrToDate(FormatDateTime('YYYY-MM-DD',Now));
  dtTimeFr.Time := StrToTime(FormatDateTime('HH:NN:SS',Now));

  if      pnl_ITM1.BevelInner=bvLowered then edtCode.Text := 'EPLT'
  else if pnl_ITM2.BevelInner=bvLowered then edtCode.Text := ''
  else                                       edtCode.Text := '';
  if not tmrRFID.Enabled then tmrRFID.Enabled := True ;
end;

//==============================================================================
// FormDeactivate
//==============================================================================
procedure TfrmU220.FormDeactivate(Sender: TObject);
var
  i : integer ;
begin
  for i := 0 to Self.ComponentCount-1 Do
  begin
    if (Self.Components[i] is TADOQuery) then
       (Self.Components[i] as TADOQuery).Active := False ;
  end;
end;

//==============================================================================
// FormClose
//==============================================================================
procedure TfrmU220.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i : integer ;
begin
  for i := 0 to Self.ComponentCount-1 Do
  begin
    if (Self.Components[i] is TADOQuery) then
       (Self.Components[i] as TADOQuery).Active := False ;
  end;

  Action := Cafree;
  try frmU220 := Nil ;
  except end;
end;

//==============================================================================
// fnCommandStart
//==============================================================================
procedure TfrmU220.fnCommandStart;
begin
  cbOut.ItemIndex := 0;
  Pnl_CellClick(Pnl_Cell1);
end;

//==============================================================================
// fnCommandOrder [지시]
//==============================================================================
procedure TfrmU220.fnCommandOrder  ;
begin
//
end;

//==============================================================================
// fnCommandAdd [신규]                                                        //
//==============================================================================
procedure TfrmU220.fnCommandAdd  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [엑셀]
//==============================================================================
procedure TfrmU220.fnCommandExcel;
begin
//
end;

//==============================================================================
// fnCommandDelete [삭제]
//==============================================================================
procedure TfrmU220.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandUpdate [수정]                                                     //
//==============================================================================
procedure TfrmU220.fnCommandUpdate;
begin
//
end;

//==============================================================================
// fnCommandPrint [인쇄]
//==============================================================================
procedure TfrmU220.fnCommandPrint;
begin
//
end;

//==============================================================================
// fnCommandQuery
//==============================================================================
procedure TfrmU220.fnCommandQuery;
begin
//
end;

//==============================================================================
// fnCommandClose
//==============================================================================
procedure TfrmU220.fnCommandClose;
begin
  Close;
end;

//==============================================================================
// fnCommandLang [언어]                                                       //
//==============================================================================
procedure TfrmU220.fnCommandLang;
begin
//
end;

//==============================================================================
// Pnl_ITMClick
//==============================================================================
procedure TfrmU220.Pnl_ITMClick(Sender: TObject);
var
  i, Idx : Integer ;
begin
  Idx := (Sender as TPanel).Tag ;

  if (Sender as TPanel).BevelInner = bvRaised then
  begin
    TPanel(Self.FindComponent('Pnl_ITM'+IntToStr(Idx))).BevelInner := bvLowered ;
    TPanel(Self.FindComponent('Pnl_ITM'+IntToStr(Idx))).Font.Color := clBlue ;

    for i := 1 to 2 do
    begin
      if i<>Idx then
      begin
        TPanel(Self.FindComponent('Pnl_ITM'+IntToStr(i))).BevelInner := bvRaised ;
        TPanel(Self.FindComponent('Pnl_ITM'+IntToStr(i))).Font.Color := clBlack ;
      end;
    end;

    if Idx=2 then
    begin
      edtCode.Text := '';
      frmPopup_Item_Search := TfrmPopup_Item_Search.Create(Application);
      frmPopup_Item_Search.ShowModal ;

      edtLineName1.Enabled := True;
      edtLineName2.Enabled := True;
      edtPalletNo1.Enabled := True;
      edtPalletNo2.Enabled := True;
      edtModelNo1.Enabled  := True;
      edtModelNo2.Enabled  := True;
      edtITM_QTY.Enabled   := True;
      edtArea.Enabled      := True;
    end else
    begin
      edtCode.Text := 'EPLT';
      edtLineName1.Text := '';
      edtLineName2.Text := '';
      edtPalletNo1.Text := '';
      edtPalletNo2.Text := '';
      edtModelNo1.Text  := '';
      edtModelNo2.Text  := '';
      edtITM_QTY.Text   := '0';
      edtArea.Text      := '';

      edtLineName1.Enabled := False;
      edtLineName2.Enabled := False;
      edtPalletNo1.Enabled := False;
      edtPalletNo2.Enabled := False;
      edtModelNo1.Enabled  := False;
      edtModelNo2.Enabled  := False;
      edtITM_QTY.Enabled   := False;
      edtArea.Enabled      := False;
    end;
    edtCodeChange;
  end else
  begin
    edtCode.Text := '';
    TPanel(Self.FindComponent('Pnl_ITM'+IntToStr(Idx))).BevelInner := bvRaised ;
    TPanel(Self.FindComponent('Pnl_ITM'+IntToStr(Idx))).Font.Color := clBlack ;
  end;
end;

//==============================================================================
// Pnl_CellClick
//==============================================================================
procedure TfrmU220.Pnl_CellClick(Sender: TObject);
var
  i, Idx : Integer ;
begin
  Idx := (Sender as TPanel).Tag ;

  if (Sender as TPanel).BevelInner = bvRaised then
  begin
    TPanel(Self.FindComponent('Pnl_Cell'+IntToStr(Idx))).BevelInner := bvLowered ;
    TPanel(Self.FindComponent('Pnl_Cell'+IntToStr(Idx))).Font.Color := clBlue ;

    for i := 1 to 2 do
    begin
      if i<>Idx then
      begin
        TPanel(Self.FindComponent('Pnl_Cell'+IntToStr(i))).BevelInner := bvRaised ;
        TPanel(Self.FindComponent('Pnl_Cell'+IntToStr(i))).Font.Color := clBlack ;
      end;
    end;

    if Idx=2 then Pnl_InputCell.Visible := True
    else          Pnl_InputCell.Visible := False ;
  end else
  begin
    TPanel(Self.FindComponent('Pnl_Cell'+IntToStr(Idx))).BevelInner := bvRaised ;
    TPanel(Self.FindComponent('Pnl_Cell'+IntToStr(Idx))).Font.Color := clBlack ;
    if Idx=2 then Pnl_InputCell.Visible := False ;
  end;
end;

//==============================================================================
// Pnl_MainResize
//==============================================================================
procedure TfrmU220.Pnl_MainResize(Sender: TObject);
begin
  Pnl_Sub.Top  := (Pnl_Main.Height - Pnl_Sub.Height) div 2 ;
  Pnl_Sub.Left := (Pnl_Main.Width  - Pnl_Sub.Width ) div 2 ;
end;

//==============================================================================
// btnOrderClick [입고지시]
//==============================================================================
procedure TfrmU220.btnOrderClick(Sender: TObject);
begin
  try
    if Trim(edtCode.Text)='' then
    begin
      MessageDlg('코드를 확인해 주십시오.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end;

    if StrToInt(Trim(edtITM_QTY.Text)) > 36 then
    begin
      MessageDlg('36개가 최대 추량입니다.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end;

    if ( Pnl_Cell2.BevelInner=bvLowered ) then
    begin
      if ( (Trim(cbBank.Text)='') or (Trim(cbBay.Text)='') or (Trim(cbLevel.Text)='') ) then
      begin
        MessageDlg('적재위치를 확인해 주십시오.', mtConfirmation, [mbYes], 0) ;
        Exit;
      end else
      if ( StrToInt(cbBank.Text) > 2 ) then
      begin
        MessageDlg('적재[열]위치를 확인해 주십시오.', mtConfirmation, [mbYes], 0) ;
        Exit;
      end else
      if ( StrToInt(cbBay.Text) > 9 ) then
      begin
        MessageDlg('적재[연]위치를 확인해 주십시오.', mtConfirmation, [mbYes], 0) ;
        Exit;
      end else
      if ( StrToInt(cbLevel.Text) > 6 ) then
      begin
        MessageDlg('적재[단]위치를 확인해 주십시오.', mtConfirmation, [mbYes], 0) ;
        Exit;
      end;
    end;

    if cbOut.ItemIndex = 0 then
    begin
      MessageDlg('입고대를 선택해 주십시오.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end;

    if (cbOut.Text = '1') and (SC_STATUS[1].D213[10] = '1') or
       (cbOut.Text = '3') and (SC_STATUS[1].D213[12] = '1') or
       (cbOut.Text = '5') and (SC_STATUS[1].D213[14] = '1') then
    begin
      MessageDlg('AGV가 도킹중 입니다.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end;

 {
    if edtLineName1.Text = '' then
    begin
      MessageDlg('식별자이름1을 확인해 주십시오.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end else
    if edtLineName2.Text = '' then
    begin
      MessageDlg('식별자이름2를 확인해 주십시오.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end else
    if edtPalletNo1.Text = '' then
    begin
      MessageDlg('식별번호1을 확인해 주십시오.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end else
    if edtPalletNo2.Text = '' then
    begin
      MessageDlg('실별번호2를 확인해 주십시오.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end else
    if edtModelNo1.Text = '' then
    begin
      MessageDlg('차종#1을 확인해 주십시오.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end else
    if edtModelNo2.Text = '' then
    begin
      MessageDlg('차종#2를 확인해 주십시오.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end else
    if edtArea.Text = '' then
    begin
      MessageDlg('생산지를 확인해 주십시오.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end;
   }

    OrderDataClear(OrderData) ;

    OrderData.REG_TIME   := FormatDateTime('YYYYMMDD',dtDateFr.Date) + FormatDateTime('HHNNSS',dtTimeFr.Time) ;

    OrderData.LUGG       := Format('%.4d', [GetJobNo]) ;  // 작업번호

    OrderData.JOBD       := '1';     // 입고지시
    OrderData.IS_AUTO    := 'N';
    OrderData.LINE_NO    := cbOut.Text; //LINE_NO

    OrderData.SRCSITE    := '0001';  // 적재 호기
{
    OrderData.SRCAISLE   := '0001';  // 적재 열
    case cbOut.ItemIndex of   // 적재 연
      1  : begin OrderData.SRCBAY     := '0002'; end;
      2  : begin OrderData.SRCBAY     := '0005'; end;
      3  : begin OrderData.SRCBAY     := '0008'; end;
    end;
}
    OrderData.SRCAISLE   := '0000';
    OrderData.SRCBAY     := '0000';
    OrderData.SRCLEVEL   := Format('%.4d', [StrToInt(cbOut.Text)]);  // 적재 단


    if Pnl_Cell1.BevelInner=bvLowered then
    begin
      if not GetLocation then
      begin
        MessageDlg('셀 찾기 실패 입니다.', mtError, [mbYes], 0) ;
        Exit ;
      end;
    end else
    if Pnl_Cell2.BevelInner=bvLowered then
    begin
      OrderData.DSTSITE    := Format('%.4d', [StrToInt('1'         )]) ;
      OrderData.DSTAISLE   := Format('%.4d', [StrToInt(cbBank.Text )]) ;
      OrderData.DSTBAY     := Format('%.4d', [StrToInt(cbBay.Text  )]) ;
      OrderData.DSTLEVEL   := Format('%.4d', [StrToInt(cbLevel.Text)]) ;
      OrderData.ID_CODE    := FormatFloat('0' ,StrToInt(cbBank.Text )) +
                              FormatFloat('00',StrToInt(cbBay.Text  )) +
                              FormatFloat('00',StrToInt(cbLevel.Text));
    end else
    begin
      MessageDlg('셀 찾기 실패 입니다.', mtError, [mbYes], 0) ;
      Exit;
    end;


    if (OrderData.DSTAISLE='0001') and (OrderData.DSTBAY='0001') and (OrderData.DSTLEVEL='0001')  then
    begin
      MessageDlg('입고위치를 입/출고대로 지정하셨습니다.' + #13#10 +
                 '다시 설정해주시기 바랍니다.', mtError, [mbYes], 0) ;
      Exit;
    end;



    OrderData.NOWMC      := '4';
    OrderData.JOBSTATUS  := '4';
    OrderData.NOWSTATUS  := '4';
    OrderData.BUFFSTATUS := fnGetCHData('1','R','CH05','9'); // 입고레디
    OrderData.JOBREWORK  := '';
    OrderData.JOBERRORT  := '';
    OrderData.JOBERRORC  := '';
    OrderData.JOBERRORD  := '';
    OrderData.JOB_END    := '0';
    OrderData.CVFR       := cbOut.Text;
    OrderData.CVTO       := cbOut.Text;
    OrderData.CVCURR     := cbOut.Text;
    OrderData.ETC        := '수동입고' ;
    OrderData.EMG        := '0';
    OrderData.ITM_CD     := edtCode.Text ;
    OrderData.UP_TIME    := '';
    OrderData.RF_LINE_NAME1 := edtLineName1.Text;
    OrderData.RF_LINE_NAME2 := edtLineName2.Text;
    OrderData.RF_PALLET_NO1 := edtPalletNo1.Text;
    OrderData.RF_PALLET_NO2 := edtPalletNo2.Text;
    OrderData.RF_MODEL_NO1  := edtModelNo1.Text;
    OrderData.RF_MODEL_NO2  := edtModelNo2.Text;
    OrderData.RF_BMA_NO     := edtITM_QTY.Text;
    OrderData.RF_AREA       := edtArea.Text;


    if SetJobOrder then
    begin
      MessageDlg('입고지시가 완료되었습니다.' + #13#10  + #13#10+
                 '===============================' + #13#10+
                 '▷작업번호 ['+ OrderData.LUGG   +'] ' + #13#10+
                 '▷기종코드 ['+ OrderData.ITM_CD +'] ' + #13#10+
                 '▷적재위치 ['+ Copy(OrderData.ID_CODE,1,1)+'-'
                               + Copy(OrderData.ID_CODE,2,2)+'-'
                               + Copy(OrderData.ID_CODE,4,2)+'] ' + #13#10+
                 '===============================' + #13#10+
                 '', mtConfirmation, [mbYes], 0) ;

      edtCode.Text  := '';
      dtDateFr.Date := StrToDate(FormatDateTime('YYYY-MM-DD',Now));
      dtTimeFr.Time := StrToTime(FormatDateTime('HH:NN:SS',Now));
      cbOut.ItemIndex := 0;
      edtLineName1.Text := '';
      edtLineName2.Text := '';
      edtPalletNo1.Text := '';
      edtPalletNo2.Text := '';
      edtModelNo1.Text  := '';
      edtModelNo2.Text  := '';
      edtITM_QTY.Text   := '';
      edtArea.Text      := '';
    end;

    dtDateFr.Date := StrToDate(FormatDateTime('YYYY-MM-DD',Now));
    dtTimeFr.Time := StrToTime(FormatDateTime('HH:NN:SS',Now));
  except
    on E : Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'btnOrderClick', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure btnOrderClick Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// OrderDataClear [구조체 초기화]
//==============================================================================
procedure TfrmU220.OrderDataClear(OrderData: TJobOrder);
begin
  OrderData.REG_TIME   := '';
  OrderData.LUGG       := '';
  OrderData.JOBD       := '';
  OrderData.IS_AUTO    := '';
  OrderData.LINE_NO    := '';
  OrderData.SRCSITE    := '';
  OrderData.SRCAISLE   := '';
  OrderData.SRCBAY     := '';
  OrderData.SRCLEVEL   := '';
  OrderData.DSTSITE    := '';
  OrderData.DSTAISLE   := '';
  OrderData.DSTBAY     := '';
  OrderData.DSTLEVEL   := '';
  OrderData.NOWMC      := '';
  OrderData.JOBSTATUS  := '';
  OrderData.NOWSTATUS  := '';
  OrderData.BUFFSTATUS := '';
  OrderData.JOBREWORK  := '';
  OrderData.JOBERRORT  := '';
  OrderData.JOBERRORC  := '';
  OrderData.JOBERRORD  := '';
  OrderData.JOB_END    := '';
  OrderData.CVFR       := '';
  OrderData.CVTO       := '';
  OrderData.CVCURR     := '';
  OrderData.ETC        := '';
  OrderData.EMG        := '';
  OrderData.ITM_CD     := '';
  OrderData.UP_TIME    := '';
  OrderData.ID_CODE    := '';
  OrderData.RF_LINE_NAME1 := '';
  OrderData.RF_LINE_NAME2 := '';
  OrderData.RF_PALLET_NO1 := '';
  OrderData.RF_PALLET_NO2 := '';
  OrderData.RF_MODEL_NO1  := '';
  OrderData.RF_MODEL_NO2  := '';
  OrderData.RF_BMA_NO     := '';
  OrderData.RF_AREA       := '';
end;

//==============================================================================
// GetJobNo [작업번호 생성]
//==============================================================================
function TfrmU220.GetJobNo : Integer;
var
  StrSQL : String;
  returnValue : String;
begin
  try
    Result := 0;
    with PD_GET_JOBNO do
    begin
      Close;
      ProcedureName := 'PD_GET_JOBNO';
      Parameters.ParamByName('@I_TYPE').Value := 1;
      ExecProc;
      returnValue := Parameters.ParamValues['@o_JobNo'];

      if (returnValue.Substring(0, 2) = 'OK') then
        Result := StrToInt(returnValue.Substring(3, 4));
    end;
  except
    on E : Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'GetJobNo', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure GetJobNo Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// GetLocation [셀 찾기]
//==============================================================================
function TfrmU220.GetLocation : Boolean;
var
  StrSQL : String;
  ScNo : integer ;
begin
  try
    Result := False;
    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := ' Select WMS_HL.DBO.fn_GetFreeLoc(:type) ID_CODE ';
      Parameters[0].Value := 0 ;
      Open;

      if ( RecordCount = 0 ) or
         ( Copy(FieldByName('ID_CODE').AsString, 1, 2) <> 'OK' ) then
      begin
        Exit;
      end;

      OrderData.DSTSITE    := Format('%.4d', [StrToInt(Copy(FieldByName('ID_CODE').AsString, 4, 1))]) ;
      OrderData.DSTAISLE   := Format('%.4d', [StrToInt(Copy(FieldByName('ID_CODE').AsString, 5, 1))]) ;
      OrderData.DSTBAY     := Format('%.4d', [StrToInt(Copy(FieldByName('ID_CODE').AsString, 6, 2))]) ;
      OrderData.DSTLEVEL   := Format('%.4d', [StrToInt(Copy(FieldByName('ID_CODE').AsString, 8, 2))]) ;
      OrderData.ID_CODE    := Copy(FieldByName('ID_CODE').AsString, 5, 5);
      Result := True;
      Close;
    end;
  except
    on E : Exception do
    begin
      qryTemp.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'GetLocation', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure GetLocation Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// SetJobOrder [입고지시 데이터 저장]
//==============================================================================
function TfrmU220.SetJobOrder : Boolean;
var
  i : Integer;
begin
  try
    Result := False;

    if not MainDm.MainDB.InTransaction then
           MainDm.MainDB.BeginTrans;

    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text :=
      ' INSERT INTO TT_ORDER (                             ' + #13#10+
      '    REG_TIME, LUGG, JOBD, IS_AUTO, LINE_NO,         ' + #13#10 +
      '    SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL,            ' + #13#10 +
      '    DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL,            ' + #13#10 +
      '    NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS,        ' + #13#10 +
      '    JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD,     ' + #13#10 +
      '    JOB_END, CVFR, CVTO, CVCURR,                    ' + #13#10 +
      '    ETC, EMG, ITM_CD,                               ' + #13#10 +
      '    RF_LINE_NAME1, RF_LINE_NAME2, RF_PALLET_NO1,    ' + #13#10 +
      '    RF_PALLET_NO2, RF_MODEL_NO1, RF_MODEL_NO2,      ' + #13#10 +
      '    RF_BMA_NO, RF_AREA                             ' + #13#10 +
      '  ) VALUES (                                        ' + #13#10 +
      '    :REG_TIME, :LUGG, :JOBD, :IS_AUTO, :LINE_NO,    ' + #13#10 +
      '    :SRCSITE, :SRCAISLE, :SRCBAY, :SRCLEVEL,        ' + #13#10 +
      '    :DSTSITE, :DSTAISLE, :DSTBAY, :DSTLEVEL,        ' + #13#10 +
      '    :NOWMC, :JOBSTATUS, :NOWSTATUS, :BUFFSTATUS,    ' + #13#10 +
      '    :JOBREWORK, :JOBERRORT, :JOBERRORC, :JOBERRORD, ' + #13#10 +
      '    :JOB_END, :CVFR, :CVTO, :CVCURR,                ' + #13#10 +
      '    :ETC, :EMG, :ITM_CD,                            ' + #13#10 +
      '    :RF_LINE_NAME1, :RF_LINE_NAME2, :RF_PALLET_NO1, ' + #13#10 +
      '    :RF_PALLET_NO2, :RF_MODEL_NO1, :RF_MODEL_NO2,   ' + #13#10 +
      '    :RF_BMA_NO, :RF_AREA                            ' + #13#10 +
      ' )';


      i := 0;
      Parameters[i].Value := OrderData.REG_TIME;    Inc(i);
      Parameters[i].Value := OrderData.LUGG;        Inc(i);
      Parameters[i].Value := OrderData.JOBD;        Inc(i);
      Parameters[i].Value := OrderData.IS_AUTO;     Inc(i);
      Parameters[i].Value := OrderData.LINE_NO;     Inc(i); //LINE_NO
      Parameters[i].Value := OrderData.SRCSITE;     Inc(i);
      Parameters[i].Value := OrderData.SRCAISLE;    Inc(i);
      Parameters[i].Value := OrderData.SRCBAY;      Inc(i);
      Parameters[i].Value := OrderData.SRCLEVEL;    Inc(i);
      Parameters[i].Value := OrderData.DSTSITE;     Inc(i);
      Parameters[i].Value := OrderData.DSTAISLE;    Inc(i);
      Parameters[i].Value := OrderData.DSTBAY;      Inc(i);
      Parameters[i].Value := OrderData.DSTLEVEL;    Inc(i);
      Parameters[i].Value := OrderData.NOWMC;       Inc(i);
      Parameters[i].Value := OrderData.JOBSTATUS;   Inc(i);
      Parameters[i].Value := OrderData.NOWSTATUS;   Inc(i);
      Parameters[i].Value := OrderData.BUFFSTATUS;  Inc(i);
      Parameters[i].Value := OrderData.JOBREWORK;   Inc(i);
      Parameters[i].Value := OrderData.JOBERRORT;   Inc(i);
      Parameters[i].Value := OrderData.JOBERRORC;   Inc(i);
      Parameters[i].Value := OrderData.JOBERRORD;   Inc(i);
      Parameters[i].Value := OrderData.JOB_END;     Inc(i);
      Parameters[i].Value := OrderData.CVFR;        Inc(i);
      Parameters[i].Value := OrderData.CVTO;        Inc(i);
      Parameters[i].Value := OrderData.CVCURR;      Inc(i);
      Parameters[i].Value := OrderData.ETC;         Inc(i);
      Parameters[i].Value := OrderData.EMG;         Inc(i);
      Parameters[i].Value := OrderData.ITM_CD;      Inc(i);

      Parameters[i].Value := OrderData.RF_LINE_NAME1; Inc(i);
      Parameters[i].Value := OrderData.RF_LINE_NAME2; Inc(i);
      Parameters[i].Value := OrderData.RF_PALLET_NO1; Inc(i);
      Parameters[i].Value := OrderData.RF_PALLET_NO2; Inc(i);
      Parameters[i].Value := OrderData.RF_MODEL_NO1;  Inc(i);
      Parameters[i].Value := OrderData.RF_MODEL_NO2;  Inc(i);
      Parameters[i].Value := OrderData.RF_BMA_NO;     Inc(i);
      Parameters[i].Value := OrderData.RF_AREA;       Inc(i);
      ExecSql;

      //+++++++++++++++++++++++++++++++++++++
      // 셀상태 변경  ( 공셀(0) -> 공셀(4) )
      //+++++++++++++++++++++++++++++++++++++
      Close;
      SQL.Clear;
      SQL.Text :=
      ' UPDATE TT_STOCK               ' + #13#10 +
      '    SET ID_STATUS = :ID_STATUS ' + #13#10 +
      '  WHERE ID_HOGI = :ID_HOGI     ' + #13#10+
      '    AND ID_CODE = :ID_CODE ' ;
      Parameters[0].Value := '4';                         // 입고예약
      Parameters[1].Value := Copy(OrderData.DSTSITE,4,1); // 호기
      Parameters[2].Value := OrderData.ID_CODE;           // 셀위치
      ExecSql;
      Close;
    end;
    Result := True;

    if MainDm.MainDB.InTransaction then
       MainDm.MainDB.CommitTrans;
  except
    on E : Exception do
    begin
      if MainDm.MainDB.InTransaction then
       MainDm.MainDB.RollbackTrans;
      if qryTemp.Active then qryTemp.Close;
      qryTemp.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'SetJobOrder', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure SetJobOrder Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// fnGetCHData [입&출고 레디 체크]
//==============================================================================
function TfrmU220.fnGetCHData(SCC_NO,SCC_SR,CH_NO,POS_NO:String) : String ;
var
  StrSQL : String;
begin
  try
    Result := '0';
    StrSQL := ' Select SubString(' + CH_NO + ',' + POS_NO + ',1) as Data ' +
              '   From TT_SCC    ' +
              '  Where SCC_NO= ''' + SCC_NO + ''' ' +
              '    and SCC_SR= ''' + SCC_SR + ''' ' ; // 'R' or 'S'

    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL;
      Open;

      if Not (Bof and Eof) then
      begin
        Result := FieldByName('Data').AsString ;
      end;
      Close;
    end;
  except
    on E : Exception do
    begin
      qryTemp.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'fnGetCHData', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnGetCHData Fail || ERR['+E.Message+']');
    end;
  end;
end;
//==============================================================================
// cbOutChange
//==============================================================================
procedure TfrmU220.cbOutChange(Sender: TObject);
var
  tmpBay : string;
begin
  case (Sender as TComboBox).ItemIndex of
    0  : begin lbloutstation.Caption := '입고대를 선택해 주십시오.' end;
    1  : begin lbloutstation.Caption := '02-08-01 입고대' end;
    2  : begin lbloutstation.Caption := '02-05-01 입고대' end;
    3  : begin lbloutstation.Caption := '02-02-01 입고대' end;
  end;

  edtLineName1.Text := '';
  edtLineName2.Text := '';
  edtPalletNo1.Text := '';
  edtPalletNo2.Text := '';
  edtModelNo1.Text  := '';
  edtModelNo2.Text  := '';
  edtArea.Text      := '';
end;

//==============================================================================
// cbOutChange
//==============================================================================
procedure TfrmU220.edtCodeChange;
begin
    if edtCode.Text = 'FULL' then
    begin
      frmU220.edtITM_QTY.Text := '36';
      frmU220.edtITM_QTY.Enabled := False;
    end else
    if edtCode.Text = 'EPLT' then
    begin
      edtLineName1.Text := '';
      edtLineName2.Text := '';
      edtPalletNo1.Text := '';
      edtPalletNo2.Text := '';
      edtModelNo1.Text  := '';
      edtModelNo2.Text  := '';
      edtITM_QTY.Text   := '0';
      edtArea.Text      := '';

      edtLineName1.Enabled := False;
      edtLineName2.Enabled := False;
      edtPalletNo1.Enabled := False;
      edtPalletNo2.Enabled := False;
      edtModelNo1.Enabled  := False;
      edtModelNo2.Enabled  := False;
      edtITM_QTY.Enabled   := False;
      edtArea.Enabled      := False;
    end else
    begin
      edtLineName1.Enabled := True;
      edtLineName2.Enabled := True;
      edtPalletNo1.Enabled := True;
      edtPalletNo2.Enabled := True;
      edtModelNo1.Enabled  := True;
      edtModelNo2.Enabled  := True;
      edtITM_QTY.Enabled   := True;
      edtArea.Enabled      := True;
    end;
end;

//==============================================================================
// Button1Click
//==============================================================================
procedure TfrmU220.Button1Click(Sender: TObject);
var
  StrSQL, Station_No : String ;
begin

  if cbOut.ItemIndex = 0 then
  begin
    MessageDlg('입고대를 선택해 주십시오.', mtConfirmation, [mbYes], 0) ;
    Exit;
  end;

  btnOrder.Enabled := False;

  Station_No := cbOut.Text;

  if ((Station_No = '1') and (SC_STATUS[1].D211[08] = '0')) or
     ((Station_No = '3') and (SC_STATUS[1].D211[10] = '0')) or
     ((Station_No = '5') and (SC_STATUS[1].D211[12] = '0')) then
  begin
    MessageDlg('선택한 입고대에 화물이 없습니다.', mtConfirmation, [mbYes], 0) ;
    Exit;
  end;

  StrSQL := ' UPDATE TC_CURRENT ' +
              '    SET OPTION' + Station_No + ' = ''1'''+
              '  WHERE CURRENT_NAME = ''RF_READ'' ';

  try
    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      ExecSQL ;
    end;
    tmrRFID.Enabled := True;
  except
    on E : Exception do
    begin
      qryTemp.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'Button1Click', '', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure Button1Click Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;

//==============================================================================
// Button1Click
//==============================================================================
procedure TfrmU220.tmrRFIDTimer(Sender: TObject);
begin
  if cbOut.ItemIndex = 0 then Exit;

  try
    getRFIDData;
  finally
  //
  end;
end;

//==============================================================================
// getRFIDOption
//==============================================================================
procedure TfrmU220.getRFIDData;
var
  StrSQL, StrSQL2, Station_No : String ;
begin
  StrSQL  := ' SELECT * FROM TC_CURRENT WHERE CURRENT_NAME = ''RF_READ'' ';
  StrSQL2 := ' SELECT * FROM TC_RFID WHERE PORT_NO = ' + ' '''+cbOut.Text+''' ';
  try
    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      open ;
      if Not (Bof and Eof) then
      begin
        if FieldByName('OPTION'+cbOut.Text).AsString = '2' then
        begin
          Close;
          SQL.Clear;
          SQL.Text := StrSQL2 ;
          open ;
          if Not (Bof and Eof) then
          begin
            edtLineName1.Text := FieldByName('H00').AsString ;
            edtLineName2.Text := FieldByName('H01').AsString ;
            edtPalletNo1.Text := FieldByName('H03').AsString ;
            edtPalletNo2.Text := FieldByName('H04').AsString ;
            edtModelNo1.Text  := FieldByName('H16').AsString ;
            edtModelNo2.Text  := FieldByName('H17').AsString ;
            edtITM_QTY.Text   := FieldByName('H18').AsString ;
            edtArea.Text      := FieldByName('H19').AsString ;
          end;
          setRFIDOption
        end;
      end;
    end;
  except
    on E : Exception do
    begin
      qryTemp.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'getRFIDOption', '', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure getRFIDOption Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;

//==============================================================================
// getRFIDOption
//==============================================================================
procedure TfrmU220.setRFIDOption;
var
  StrSQL, Station_No : String ;
  ExecNo : Integer;
begin

  if cbOut.ItemIndex = 0 then
  begin
    MessageDlg('입고대를 선택해 주십시오.', mtConfirmation, [mbYes], 0) ;
    Exit;
  end;

  Station_No := cbOut.Text;

  StrSQL := ' UPDATE TC_CURRENT ' +
              '    SET OPTION' + Station_No + ' = ''3'''+
              '  WHERE CURRENT_NAME = ''RF_READ'' ';

  try
    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      ExecNo := ExecSQL ;
      if ExecNo > 0 then
      begin
        btnOrder.Enabled := True;
        tmrRFID.Enabled := False;
      end;
    end;
  except
    on E : Exception do
    begin
      qryTemp.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'getRFIDOption', '', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure getRFIDOption Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;

end.





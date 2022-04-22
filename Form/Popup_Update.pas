unit Popup_Update;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, Buttons, d_MainDm, h_MainLib, h_ReferLib,
  DB, ADODB, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,
  Vcl.Mask, Vcl.DBCtrls, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh,
  Vcl.ComCtrls;

type
  TfrmPopup_Update = class(TForm)
    Pnl_Main: TPanel;
    Pnl_Sub: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel18: TPanel;
    Panel19: TPanel;
    Panel16: TPanel;
    Panel23: TPanel;
    Panel1: TPanel;
    Panel26: TPanel;
    Panel27: TPanel;
    Panel30: TPanel;
    Panel31: TPanel;
    Panel32: TPanel;
    ComboBoxHogi: TComboBox;
    ComboBoxBank: TComboBox;
    ComboBoxBay: TComboBox;
    ComboBoxLevel: TComboBox;
    CB_ID_STATUS: TComboBox;
    edtITM_CD: TEdit;
    edtITM_NAME: TEdit;
    edtITM_SPEC: TEdit;
    edtITM_QTY: TEdit;
    cbInUSED: TCheckBox;
    cbOtUSED: TCheckBox;
    Panel8: TPanel;
    edtID_MEMO: TEdit;
    dtDate: TDateTimePicker;
    dtTime: TDateTimePicker;
    Panel2: TPanel;
    Panel11: TPanel;
    Panel20: TPanel;
    Panel21: TPanel;
    Panel22: TPanel;
    Panel25: TPanel;
    Panel28: TPanel;
    edtLineName1: TEdit;
    edtLineName2: TEdit;
    edtPalletNo1: TEdit;
    edtPalletNo2: TEdit;
    edtModelNo1: TEdit;
    edtModelNo2: TEdit;
    edtArea: TEdit;
    Pnl_Top: TPanel;
    Pnl_BTN: TPanel;
    Pnl_Btn5: TPanel;
    btnClose: TSpeedButton;
    Pnl_Btn0: TPanel;
    btnSave: TSpeedButton;
    PnlFormName: TPanel;
    Shape3: TShape;
    Panel24: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    qryUpdate: TADOQuery;
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CB_ID_STATUSChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPopup_Update: TfrmPopup_Update;
  BeforeRACK_INFO, AfterRACK_INFO : TSTOCK;

implementation

{$R *.dfm}


//==============================================================================
// btnCloseClick
//==============================================================================
procedure TfrmPopup_Update.btnCloseClick(Sender: TObject);
begin
  Close;
end;

//==============================================================================
// btnSaveClick
//==============================================================================
procedure TfrmPopup_Update.btnSaveClick(Sender: TObject);
var
  StrSQL, ID_HOGI, ID_CODE, IN_USE, OT_USE, INdt, tmpLogStr : String;
begin
  try
    if  (CB_ID_STATUS.ItemIndex <> 0) and       //공셀
        (CB_ID_STATUS.ItemIndex <> 3) and       //금지셀
        (CB_ID_STATUS.ItemIndex <> 7) then      //공출고
    begin
      if StrToInt(Trim(edtITM_QTY.Text)) > 36 then
      begin
        MessageDlg('36개가 최대 추량입니다.', mtConfirmation, [mbYes], 0) ;
        Exit;
      end;

      if edtITM_CD.Text = '' then
      begin
        MessageDlg('기종코드를 확인해 주십시오.', mtConfirmation, [mbYes], 0) ;
        Exit;
      end else
      if edtITM_NAME.Text = '' then
      begin
        MessageDlg('기종명을 확인해 주십시오.', mtConfirmation, [mbYes], 0) ;
        Exit;
      end else
      if edtITM_SPEC.Text = '' then
      begin
        MessageDlg('기종사양을 확인해 주십시오.', mtConfirmation, [mbYes], 0) ;
        Exit;
      end else
      if edtITM_QTY.Text = '0' then
      begin
        MessageDlg('수량을 확인해 주십시오.', mtConfirmation, [mbYes], 0) ;
        Exit;
      end else
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
    end;

    INdt := '';

    ID_HOGI := ComboBoxHogi.Text;
    ID_CODE := ComboBoxBank.Text + ComboBoxBay.Text + ComboBoxLevel.Text;

    if cbInUSED.Checked then IN_USE := '0' else IN_USE := '1';
    if cbOtUSED.Checked then OT_USE := '0' else OT_USE := '1';

    if CB_ID_STATUS.ItemIndex = 0 then
    begin
      StrSQL := ' Update TT_STOCK ' +
                '    Set ITM_CD       = ''''  ' +
                '      , ITM_NAME     = ''''  ' +
                '      , ITM_SPEC     = ''''  ' +
                '      , ITM_QTY      = 0     ' +
                '      , ID_ZONE      = ''A'' ' +
                '      , ID_STATUS    = ' + QuotedStr(IntToStr(CB_ID_STATUS.ItemIndex)) +
                '      , OT_USED      = ' + QuotedStr(OT_USE) +
                '      , IN_USED      = ' + QuotedStr(IN_USE) +
                '      , ID_MEMO      = ' + QuotedStr(edtID_MEMO.Text) +
                '      , RF_LINE_NAME1 = ''''  ' +
                '      , RF_LINE_NAME2 = ''''  ' +
                '      , RF_PALLET_NO1 = ''''  ' +
                '      , RF_PALLET_NO2 = ''''  ' +
                '      , RF_MODEL_NO1 = ''''  ' +
                '      , RF_MODEL_NO2 = ''''  ' +
                '      , RF_BMA_NO = ''''  ' +
                '      , RF_AREA = ''''  ' +
                '      , STOCK_REG_DT = GETDATE()   ' +
                '  Where ID_HOGI = ' + QuotedStr(ID_HOGI) +
                '    And ID_CODE = ' + QuotedStr(ID_CODE) ;
    end else
    begin
      if CB_ID_STATUS.ItemIndex in [1,2] then INdt := ' , STOCK_IN_DT = GETDATE() '
      else                                    INdt := '';

      StrSQL := ' Update TT_STOCK ' +
                '    Set ITM_CD       = ' + QuotedStr(edtITM_CD.Text) +
                '      , ITM_NAME     = ' + QuotedStr(edtITM_NAME.Text) +
                '      , ITM_SPEC     = ' + QuotedStr(edtITM_SPEC.Text) +
                '      , ITM_QTY      = ' + QuotedStr(edtITM_QTY.Text) +
                '      , ID_ZONE      = ''A'' ' +
                '      , ID_STATUS    = ' + QuotedStr(IntToStr(CB_ID_STATUS.ItemIndex)) +
                '      , OT_USED      = ' + QuotedStr(OT_USE) +
                '      , IN_USED      = ' + QuotedStr(IN_USE) +
                '      , ID_MEMO      = ' + QuotedStr(edtID_MEMO.Text) + INdt +
                '      , STOCK_REG_DT = GETDATE() ' +
                '      , RF_LINE_NAME1 = ' + QuotedStr(edtLineName1.Text) +
                '      , RF_LINE_NAME2 = ' + QuotedStr(edtLineName2.Text) +
                '      , RF_PALLET_NO1 = ' + QuotedStr(edtPalletNo1.Text) +
                '      , RF_PALLET_NO2 = ' + QuotedStr(edtPalletNo2.Text) +
                '      , RF_MODEL_NO1 = '  + QuotedStr(edtModelNo1.Text)  +
                '      , RF_MODEL_NO2 = '  + QuotedStr(edtModelNo2.Text)  +
                '      , RF_BMA_NO = '     + QuotedStr(edtITM_QTY.Text)   +
                '      , RF_AREA = '       + QuotedStr(edtArea.Text)      +
                '  Where ID_HOGI = ' + QuotedStr(ID_HOGI) +
                '    And ID_CODE = ' + QuotedStr(ID_CODE) ;
    end;

    AfterRACK_INFO.ID_STATUS := CB_ID_STATUS.Text;
    AfterRACK_INFO.ITM_CD    := edtITM_CD.Text;
    AfterRACK_INFO.ITM_NAME  := edtITM_NAME.Text;
    AfterRACK_INFO.ITM_SPEC  := edtITM_SPEC.Text;
    AfterRACK_INFO.ITM_QTY   := edtITM_QTY.Text;

    if cbInUSED.Checked = True then AfterRACK_INFO.IN_USED   := '0'
    else AfterRACK_INFO.IN_USED   := '1';
    if cbOtUSED.Checked = True then AfterRACK_INFO.OT_USED   := '0'
    else AfterRACK_INFO.OT_USED   := '1';

    AfterRACK_INFO.RF_LINE_NAME1 := edtLineName1.Text;
    AfterRACK_INFO.RF_LINE_NAME2 := edtLineName2.Text;
    AfterRACK_INFO.RF_PALLET_NO1 := edtPalletNo1.Text;
    AfterRACK_INFO.RF_PALLET_NO2 := edtPalletNo2.Text;
    AfterRACK_INFO.RF_MODEL_NO1  := edtModelNo1.Text;
    AfterRACK_INFO.RF_MODEL_NO2  := edtModelNo2.Text;
    AfterRACK_INFO.RF_BMA_NO     := edtITM_QTY.Text;
    AfterRACK_INFO.RF_AREA       := edtArea.Text;

    with qryUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL;
      if ExecSQL > 0 then
      begin
        ShowMessage('적재 정보 수정');

        tmpLogStr := ' - ' +
                     '적재위치['    + ID_CODE + '], ' +
                     '셀상태['      + BeforeRACK_INFO.ID_STATUS + '], ' +
                     '기종코드['    + BeforeRACK_INFO.ITM_CD    + '], ' +
                     '기종명['      + BeforeRACK_INFO.ITM_NAME  + '], ' +
                     '기종사양['    + BeforeRACK_INFO.ITM_SPEC  + '], ' +
                     '수량['        + BeforeRACK_INFO.ITM_QTY   + '], ' +
                     '입고금지['    + BeforeRACK_INFO.IN_USED   + '], ' +
                     '출고금지['    + BeforeRACK_INFO.OT_USED   + '],' +
                     '식별자이름1[' + BeforeRACK_INFO.RF_LINE_NAME1 + '] ' +
                     '식별자이름2[' + BeforeRACK_INFO.RF_LINE_NAME2 + '] ' +
                     '식별번호1['   + BeforeRACK_INFO.RF_PALLET_NO1 + '] ' +
                     '식별번호2['   + BeforeRACK_INFO.RF_PALLET_NO2 + '] ' +
                     '차종#1['      + BeforeRACK_INFO.RF_MODEL_NO1  + '] ' +
                     '차종#2['      + BeforeRACK_INFO.RF_MODEL_NO2  + '] ' +
                     '생산지['      + BeforeRACK_INFO.RF_AREA       + '] => ' +

                     '적재위치['    + ID_CODE + '], ' +
                     '셀상태['      + AfterRACK_INFO.ID_STATUS + '], ' +
                     '기종코드['    + AfterRACK_INFO.ITM_CD    + '], ' +
                     '기종명['      + AfterRACK_INFO.ITM_NAME  + '], ' +
                     '기종사양['    + AfterRACK_INFO.ITM_SPEC  + '], ' +
                     '수량['        + AfterRACK_INFO.ITM_QTY   + '], ' +
                     '입고금지['    + AfterRACK_INFO.IN_USED   + '], ' +
                     '출고금지['    + AfterRACK_INFO.OT_USED   + '],' +
                     '식별자이름1[' + AfterRACK_INFO.RF_LINE_NAME1 + '] ' +
                     '식별자이름2[' + AfterRACK_INFO.RF_LINE_NAME2 + '] ' +
                     '식별번호1['   + AfterRACK_INFO.RF_PALLET_NO1 + '] ' +
                     '식별번호2['   + AfterRACK_INFO.RF_PALLET_NO2 + '] ' +
                     '차종#1['      + AfterRACK_INFO.RF_MODEL_NO1  + '] ' +
                     '차종#2['      + AfterRACK_INFO.RF_MODEL_NO2  + '] ' +
                     '생산지['      + AfterRACK_INFO.RF_AREA       + '] ' ;

        InsertPGMHist('[Popup_Update]', 'N', 'btnSaveClick', '수정','수정 - ' + tmpLogStr,'SQL', StrSQL, '', '');
      end;
    end;
    Close;
  except
    on E : Exception do
    begin
      qryUpdate.Close;
      InsertPGMHist('[Popup_Update]', 'E', 'btnSaveClick', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('[Popup_Update] procedure btnSaveClick Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// FormActivate
//==============================================================================
procedure TfrmPopup_Update.FormActivate(Sender: TObject);
begin
  BeforeRACK_INFO.ID_STATUS := CB_ID_STATUS.Text;
  BeforeRACK_INFO.ITM_CD    := edtITM_CD.Text;
  BeforeRACK_INFO.ITM_NAME  := edtITM_NAME.Text;
  BeforeRACK_INFO.ITM_SPEC  := edtITM_SPEC.Text;
  BeforeRACK_INFO.ITM_QTY   := edtITM_QTY.Text;

  if cbInUSED.Checked = True then BeforeRACK_INFO.IN_USED   := '0'
  else BeforeRACK_INFO.IN_USED   := '1';
  if cbOtUSED.Checked = True then BeforeRACK_INFO.OT_USED   := '0'
  else BeforeRACK_INFO.OT_USED   := '1';

  BeforeRACK_INFO.RF_LINE_NAME1 := edtLineName1.Text;
  BeforeRACK_INFO.RF_LINE_NAME2 := edtLineName2.Text;
  BeforeRACK_INFO.RF_PALLET_NO1 := edtPalletNo1.Text;
  BeforeRACK_INFO.RF_PALLET_NO2 := edtPalletNo2.Text;
  BeforeRACK_INFO.RF_MODEL_NO1  := edtModelNo1.Text;
  BeforeRACK_INFO.RF_MODEL_NO2  := edtModelNo2.Text;
  BeforeRACK_INFO.RF_BMA_NO     := edtITM_QTY.Text;
  BeforeRACK_INFO.RF_AREA       := edtArea.Text;
end;

//==============================================================================
// FormClose
//==============================================================================
procedure TfrmPopup_Update.FormClose(Sender: TObject; var Action: TCloseAction);
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
  try frmPopup_Update := Nil ;
  except end;
end;

//==============================================================================
// FormDeactivate
//==============================================================================
procedure TfrmPopup_Update.FormDeactivate(Sender: TObject);
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
// CB_ID_STATUSChange
//==============================================================================
procedure TfrmPopup_Update.CB_ID_STATUSChange(Sender: TObject);
begin
  if (Sender as TComboBox).ItemIndex=0 then
  begin
    edtITM_CD.Text   := '';
    edtITM_NAME.Text := '';
    edtITM_SPEC.Text := '';
    edtITM_QTY.Text  := '0';
    edtID_MEMO.Text  := '';
    edtLineName1.Text := '';
    edtLineName2.Text := '';
    edtPalletNo1.Text := '';
    edtPalletNo2.Text := '';
    edtModelNo1.Text  := '';
    edtModelNo2.Text  := '';
    edtArea.Text      := '';
  end else
  if (Sender as TComboBox).ItemIndex=1 then
  begin
    edtITM_CD.Text   := 'EPLT';
    edtITM_NAME.Text := '공파레트';
    edtITM_SPEC.Text := '공파레트';
    edtITM_QTY.Text  := '1';
  end;

end;

end.

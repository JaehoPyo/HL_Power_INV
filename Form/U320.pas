unit U320;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, d_MainDm, h_MainLib, h_ReferLib, StdCtrls, DB, ADODB, ExLibrary, ExVclLib,
  Grids, StrUtils, DBGrids, comobj, frxClass, frxDBSet, DBGridEhGrouping, EhLibADO,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,DBGridEhImpExp,
  DBGridEh, Vcl.Mask, Vcl.DBCtrls, DBCtrlsEh, PrnDbgeh, Vcl.Buttons,
  Vcl.ComCtrls ;

type
  TfrmU320 = class(TForm)
    qryTemp: TADOQuery;
    qryInfo: TADOQuery;
    dsInfo: TDataSource;
    EhPrint: TPrintDBGridEh;
    Pnl_Top1: TPanel;
    Pnl_Main: TPanel;
    dgInfo: TDBGridEh;
    GroupBox1: TGroupBox;
    dtDateFr: TDateTimePicker;
    dtTimeFr: TDateTimePicker;
    dtDateTo: TDateTimePicker;
    dtTimeTo: TDateTimePicker;
    Label31: TLabel;
    cbDateUse: TCheckBox;
    Pnl_Top2: TPanel;
    gbCell: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ComboBoxBank: TComboBox;
    ComboBoxBay: TComboBox;
    ComboBoxLevel: TComboBox;
    gbCode: TGroupBox;
    cbCode: TComboBox;
    GroupBox2: TGroupBox;
    cbStatus: TComboBox;
    rgType: TRadioGroup;
    GroupBox3: TGroupBox;
    edtModelNo: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBoxChange(Sender: TObject);
    procedure dtDateTimeChange(Sender: TObject);
    procedure ComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure dtDateTimeKeyPress(Sender: TObject; var Key: Char);
    procedure cbDateUseClick(Sender: TObject);
    procedure dgInfoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure dgInfoTitleClick(Column: TColumnEh);
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

    procedure SetComboBox;
  end;
  procedure U320Create();

const
  FormNo ='320';
var
  frmU320: TfrmU320;
  SrtFlag : integer = 0 ;

implementation

uses Main, Popup_Update ;

{$R *.dfm}

//==============================================================================
// U320Create
//==============================================================================
procedure U320Create();
begin
  if not Assigned( frmU320 ) then
  begin
    frmU320 := TfrmU320.Create(Application);
    with frmU320 do
    begin
      fnCommandStart;
    end;
  end;
  frmU320.Show;
end;

//==============================================================================
// fnWmMsgRecv
//==============================================================================
procedure TfrmU320.fnWmMsgRecv(var MSG: TMessage);
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
procedure TfrmU320.FormActivate(Sender: TObject);
begin

  MainDm.M_Info.ActiveFormID := '320';
  frmMain.LblMenu000.Caption := MainDm.M_Info.ActiveFormID + '. ' + getLangMenuString(MainDm.M_Info.ActiveFormID, frmMain.LblMenu000.Caption, MainDm.M_Info.LANG_TYPE, 'N');
  frmU320.Caption := MainDm.M_Info.ActiveFormName;
  fnWmMsgSend( 22211,11111 );

  dtDateFr.Date := StrToDate(FormatDateTime('YYYY-MM-DD',Now));
  dtTimeFr.Time := StrToTime('00:00:00');

  dtDateTo.Date := StrToDate(FormatDateTime('YYYY-MM-DD',Now));
  dtTimeTo.Time := StrToTime(FormatDateTime('HH:NN:SS',Now));

  SetComboBox ;
  fnCommandQuery ;
end;

//==============================================================================
// FormDeactivate
//==============================================================================
procedure TfrmU320.FormDeactivate(Sender: TObject);
var
  i : integer ;
begin
  for i := 0 to Self.ComponentCount-1 do
  begin
    if (Self.Components[i] is TTimer) then
       (Self.Components[i] as TTimer).Enabled := False ;
  end;
end;

//==============================================================================
// FormClose
//==============================================================================
procedure TfrmU320.FormClose(Sender: TObject; var Action: TCloseAction);
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
  try frmU320 := Nil ;
  except end;
end;

//==============================================================================
// fnCommandStart
//==============================================================================
procedure TfrmU320.fnCommandStart;
begin
//
end;

//==============================================================================
// fnCommandOrder [지시]
//==============================================================================
procedure TfrmU320.fnCommandOrder  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [엑셀]
//==============================================================================
procedure TfrmU320.fnCommandExcel;
begin
  try
    if hlbEhgridListExcel(dgInfo, frmMain.LblMenu000.Caption + '_' + FormatDatetime('YYYYMMDD', Now)) then
    begin
      MessageDlg('엑셀 저장을 완료하였습니다.', mtConfirmation, [mbYes], 0);
    end else
    begin
      MessageDlg('엑셀 저장을 실패하였습니다.', mtWarning, [mbYes], 0);
    end;
  except
    on E : Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'fnCommandExcel', '엑셀', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnCommandExcel Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// fnCommandAdd [신규]                                                        //
//==============================================================================
procedure TfrmU320.fnCommandAdd  ;
begin
//
end;

//==============================================================================
// fnCommandDelete [삭제]
//==============================================================================
procedure TfrmU320.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandUpdate [수정]                                                     //
//==============================================================================
procedure TfrmU320.fnCommandUpdate;
var
  ID_HOGI, ID_BANK, ID_BAY, ID_LEVEL, ID_CODE : String ;
begin
  try

    if (qryInfo.FieldByName('ID_STATUS').AsInteger = 8) or
       (qryInfo.FieldByName('ID_STATUS').AsInteger = 9) then
    begin
      MessageDlg('입출고대 및 비상렉은 수정할수 없습니다.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end;


    frmPopup_Update := TfrmPopup_Update.Create(Application);

    ID_HOGI  := '1' ;
    ID_CODE  := qryInfo.FieldByName('ID_CODE'  ).AsString;
    ID_BANK  := Copy(ID_CODE,1,1) ;
    ID_BAY   := Copy(ID_CODE,2,2) ;
    ID_LEVEL := Copy(ID_CODE,4,2) ;

    frmPopup_Update.ComboBoxHogi.Text  := ID_HOGI;
    frmPopup_Update.ComboBoxBank.Text  := ID_BANK;
    frmPopup_Update.ComboBoxBay.Text   := ID_BAY;
    frmPopup_Update.ComboBoxLevel.Text := ID_LEVEL;
    frmPopup_Update.CB_ID_STATUS.ItemIndex  := qryInfo.FieldByName('ID_STATUS').AsInteger;

    frmPopup_Update.edtITM_CD.Text   := qryInfo.FieldByName('ITM_CD'  ).AsString;
    frmPopup_Update.edtITM_NAME.Text := qryInfo.FieldByName('ITM_NAME').AsString;
    frmPopup_Update.edtITM_SPEC.Text := qryInfo.FieldByName('ITM_SPEC').AsString;
    frmPopup_Update.edtITM_QTY.Text  := qryInfo.FieldByName('RF_BMA_NO').AsString;
    frmPopup_Update.edtID_MEMO.Text  := qryInfo.FieldByName('ID_MEMO'  ).AsString;

    frmPopup_Update.dtDate.Date := qryInfo.FieldByName('STOCK_IN_DT').AsDateTime;
    frmPopup_Update.dtTime.Time := qryInfo.FieldByName('STOCK_IN_DT').AsDateTime;

    if qryInfo.FieldByName('IN_USED').AsString = '0' then  frmPopup_Update.cbInUSED.Checked := True
    else frmPopup_Update.cbInUSED.Checked := False;
    if qryInfo.FieldByName('OT_USED').AsString = '0' then  frmPopup_Update.cbOtUSED.Checked := True
    else frmPopup_Update.cbOtUSED.Checked := False;

    frmPopup_Update.edtLineName1.Text := qryInfo.FieldByName('RF_LINE_NAME1').AsString;
    frmPopup_Update.edtLineName2.Text := qryInfo.FieldByName('RF_LINE_NAME2').AsString;
    frmPopup_Update.edtPalletNo1.Text := qryInfo.FieldByName('RF_PALLET_NO1').AsString;
    frmPopup_Update.edtPalletNo2.Text := qryInfo.FieldByName('RF_PALLET_NO2').AsString;
    frmPopup_Update.edtModelNo1.Text  := qryInfo.FieldByName('RF_MODEL_NO1' ).AsString;;
    frmPopup_Update.edtModelNo2.Text  := qryInfo.FieldByName('RF_MODEL_NO2' ).AsString;
    frmPopup_Update.edtArea.Text      := qryInfo.FieldByName('RF_AREA'      ).AsString;
    frmPopup_Update.edtNewBMA.Text    := qryInfo.FieldByName('RF_NEW_BMA'   ).AsString;
    frmPopup_Update.ShowModal ;
    fnCommandQuery;
  except
    on E : Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'fnCommandUpdate', '수정', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnCommandUpdate Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// fnCommandPrint [인쇄]
//==============================================================================
procedure TfrmU320.fnCommandPrint;
begin
  try
    if not qryInfo.Active then Exit;
    fnCommandQuery;
    EhPrint.DBGridEh := dgInfo;
    EhPrint.PageHeader.LeftText.Clear;
    EhPrint.PageHeader.LeftText.Add(Copy(MainDm.M_Info.ActiveFormName, 6,
                                    Length(MainDm.M_Info.ActiveFormName)-5) );
    EhPrint.PageHeader.Font.Name := '돋움';
    EhPrint.PageHeader.Font.Size := 10;
    EhPrint.PageFooter.RightText.Clear;
    EhPrint.PageFooter.RightText.Add(FormatDateTime('YYYY-MM-DD HH:NN:SS', Now) + '   ' +
                                     MainDM.M_Info.UserCode+' / '+MainDM.M_Info.UserName);
    EhPrint.PageFooter.Font.Name := '돋움';
    EhPrint.PageFooter.Font.Size := 10;

    EhPrint.Preview;
  except
    on E : Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'fnCommandPrint', '인쇄', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnCommandPrint Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// fnCommandQuery
//==============================================================================
procedure TfrmU320.fnCommandQuery;
var
  StrSQL : String;
begin
  try
    with qryInfo do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' Select ID_CODE, ID_BANK, ID_BAY, ID_LEVEL, ' +
                '        STOCK_REG_DT, STOCK_IN_DT, ' +
                '        ITM_CD, ITM_NAME, ITM_SPEC, ITM_QTY, ' +
                '        ID_ZONE, ID_STATUS, ID_MEMO, ' +
                '       (Case IN_USED when ''0'' then ''Y'' ' +
                '                     when ''1'' then ''N'' end ) as IN_USED, ' +
                '       (Case OT_USED when ''0'' then ''Y'' ' +
                '                     when ''1'' then ''N'' end ) as OT_USED, ' +
                '       (Case ID_STATUS when ''0'' then ''공셀''     ' +
                '                       when ''1'' then ''공파레트'' ' +
                '                       when ''2'' then ''실셀''     ' +
                '                       when ''3'' then ''금지셀''   ' +
                '                       when ''4'' then ''입고예약'' ' +
                '                       when ''5'' then ''출고예약'' ' +
                '                       when ''6'' then ''이중입고'' ' +
                '                       when ''7'' then ''공출고''   ' +
                '                       when ''8'' then ''입출고대''   ' +
                '                       when ''9'' then ''비상렉'' end) as ID_STATUS_DESC, ' +
                '       (SUBSTRING(ID_CODE,1,1)+''-''+SUBSTRING(ID_CODE,2,2)+''-''+SUBSTRING(ID_CODE,4,2)) as ID_CODE_DESC, ' +
                '        RF_LINE_NAME1, RF_LINE_NAME2, RF_PALLET_NO1, RF_PALLET_NO2, RF_MODEL_NO1, ' +
                '        RF_MODEL_NO2, RF_BMA_NO, RF_PALLET_BMA1, RF_PALLET_BMA2, RF_PALLET_BMA3,  ' +
                '        RF_AREA, RF_NEW_BMA  ' +
                '   From TT_STOCK ' +
                '  Where 1=1 ' +
                '    And ID_STATUS not in (''8'', ''9'') ' ;


      if (Trim(UpperCase(edtModelNo.Text)) <> '') then
        StrSQL := StrSQL + ' And UPPER(RF_MODEL_NO1) like ' + QuotedStr('%' + Trim(UpperCase(edtModelNo.Text)) + '%');

      if (rgType.ItemIndex = 1) then
        StrSQL := StrSQL + ' And ITM_CD = ''FULL'' '
      else if (rgType.ItemIndex = 2) then
        StrSQL := StrSQL + ' And ITM_CD = ''EPLT'' '
      else if (rgType.ItemIndex = 3) then
        StrSQL := StrSQL + ' And ITM_CD not in (''FULL'', ''EPLT'')' ;

      if (Trim(ComboBoxBank.Text)<>'') and (Trim(ComboBoxBank.Text)<>'전체') then
        StrSQL := StrSQL + ' And ID_BANK= ' + QuotedStr(Trim(ComboBoxBank.Text)) ;

      if (Trim(ComboBoxBay.Text)<>'') and (Trim(ComboBoxBay.Text)<>'전체') then
        StrSQL := StrSQL + ' And ID_BAY= ' + QuotedStr(Trim(ComboBoxBay.Text)) ;

      if (Trim(ComboBoxLevel.Text)<>'') and (Trim(ComboBoxLevel.Text)<>'전체') then
        StrSQL := StrSQL + ' And ID_LEVEL= ' + QuotedStr(Trim(ComboBoxLevel.Text)) ;

      if (Trim(cbStatus.Text)<>'') and (Trim(cbStatus.Text)<>'전체') then
        StrSQL := StrSQL + ' And ID_STATUS= ' + QuotedStr(IntToStr(cbStatus.ItemIndex-1)) ;

      if (Trim(cbCode.Text)<>'') and (Trim(cbCode.Text)<>'전체') then
        StrSQL := StrSQL + ' And ITM_CD= ' + QuotedStr(Trim(cbCode.Text)) ;

      if cbDateUse.Checked then
        StrSQL := StrSQL + ' And STOCK_IN_DT BetWeen ' +
                           '      '''+FormatDateTime('YYYY/MM/DD', dtDateFr.Date)+''+FormatDateTime('HH:NN:SS', dtTimeFr.Time)+''' '+
                           '  And '''+FormatDateTime('YYYY/MM/DD', dtDateTo.Date)+''+FormatDateTime('HH:NN:SS', dtTimeTo.Time)+''' ';

      StrSQL := StrSQL + ' Order By ID_CODE ' ;

      SQL.Text := StrSQL;
      Open;
    end;
  except
    if qryInfo.Active then qryInfo.Close;
  end;
end;

//==============================================================================
// fnCommandClose
//==============================================================================
procedure TfrmU320.fnCommandClose;
begin
  Close;
end;

//==============================================================================
// fnCommandLang [언어]                                                       //
//==============================================================================
procedure TfrmU320.fnCommandLang;
begin
//
end;

//==============================================================================
// SetComboBox [콤보박스 데이터 추가]
//==============================================================================
procedure TfrmU320.SetComboBox;
var
  StrSQL : String;
begin
  try
    cbCode.Clear ;
    cbCode.Items.Add('전체');
    cbCode.ItemIndex := 0;

    StrSQL := ' Select ITM_CD From TM_ITEM ' +
              '  Order By ITM_CD ' ;

    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open ;
      First;

      while not(Eof) do
      begin
        cbCode.Items.Add(fieldByName('ITM_CD').AsString);
        Next ;
      end;

    end;
  except
    on E : Exception do
    begin
      qryInfo.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'SetComboBox', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure SetComboBox Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// ComboBoxChange [콤보박스 이벤트 ]
//==============================================================================
procedure TfrmU320.ComboBoxChange(Sender: TObject);
begin
  fnCommandQuery;
end;

//==============================================================================
// dtDateFrChange
//==============================================================================
procedure TfrmU320.dtDateTimeChange(Sender: TObject);
begin
  fnCommandQuery;
end;

//==============================================================================
// dtDateTimeKeyPress
//==============================================================================
procedure TfrmU320.dtDateTimeKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    fnCommandQuery;
  end;
end;

//==============================================================================
// ComboBoxKeyPress
//==============================================================================
procedure TfrmU320.ComboBoxKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    fnCommandQuery;
  end;
end;

//==============================================================================
// cbDateUseClick
//==============================================================================
procedure TfrmU320.cbDateUseClick(Sender: TObject);
begin
  fnCommandQuery;
end;

//==============================================================================
// dgInfoDrawColumnCell
//==============================================================================
procedure TfrmU320.dgInfoDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
  with Sender as TDBGridEh do
  begin
    try
      if DataSource.DataSet.Active and not DataSource.DataSet.IsEmpty then
      begin
        with DataSource.DataSet do
        begin
          if DataCol=1 then
          begin
            if (FieldByName('ID_STATUS').AsString = '3') or
               (FieldByName('ID_STATUS').AsString = '6') or
               (FieldByName('ID_STATUS').AsString = '7') then
            begin
              Canvas.Font.Color := clRed;
              Canvas.Font.Style := [fsBold];
            end else
            begin
              Canvas.Font.Color := clBlack;
              Canvas.Font.Style := [];
            end;
          end;
        end;
        DefaultDrawColumnCell( Rect, DataCol, Column , State );
      end;
    except
      DataSource.DataSet.Close;
    end;
  end;
end;

//==============================================================================
// dgInfoTitleClick [그리드 정렬]
//==============================================================================
procedure TfrmU320.dgInfoTitleClick(Column: TColumnEh);
begin
  if Column.Field.DataSet is TADOQuery then
  begin
    with TADOQuery(Column.Field.DataSet) do
    begin
      if RecordCount=0 then Exit ;
      if SrtFlag = 0 then
      begin
        SrtFlag := 1; Sort := Column.FieldName + ' DESC' ;
      end else
      begin
        SrtFlag := 0; Sort := Column.FieldName + ' ASC' ;
      end;
    end;
  end;
end;

end.





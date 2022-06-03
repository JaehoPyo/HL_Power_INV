unit U230;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, d_MainDm, h_MainLib, h_ReferLib, StdCtrls, DB, ADODB, ExLibrary, ExVclLib,
  Grids, StrUtils, DBGrids, comobj, frxClass, frxDBSet, DBGridEhGrouping, EhLibADO,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,DBGridEhImpExp,
  DBGridEh, Vcl.Mask, Vcl.DBCtrls, DBCtrlsEh, PrnDbgeh, Vcl.Buttons ;

type
  TfrmU230 = class(TForm)
    qryTemp: TADOQuery;
    qryInfo: TADOQuery;
    dsInfo: TDataSource;
    EhPrint: TPrintDBGridEh;
    Pnl_Main: TPanel;
    PD_GET_JOBNO: TADOStoredProc;
    btnOrder: TButton;
    Panel4: TPanel;
    Panel1: TPanel;
    Pnl_Top: TPanel;
    sbtReset: TSpeedButton;
    rgITM_YN: TRadioGroup;
    gbCell: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ComboBoxBank: TComboBox;
    ComboBoxBay: TComboBox;
    ComboBoxLevel: TComboBox;
    rgEMG: TRadioGroup;
    GroupBox2: TGroupBox;
    lbloutstation: TLabel;
    cbOut: TComboBox;
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    edtOutCode: TEdit;
    edtOutCell: TEdit;
    edtOutInDate: TEdit;
    dgInfo: TDBGridEh;
    GroupBox3: TGroupBox;
    edtModelNo: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Pnl_MainResize(Sender: TObject);
    procedure ComboBoxChange(Sender: TObject);
    procedure ComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure rgITM_YNClick(Sender: TObject);
    procedure dgInfoTitleClick(Column: TColumnEh);
    procedure cbCodeChange(Sender: TObject);
    procedure sbtResetClick(Sender: TObject);
    procedure dgInfoCellClick(Column: TColumnEh);
    procedure btnOrderClick(Sender: TObject);
    procedure cbOutChange(Sender: TObject);

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

    function  SetJobOrder : Boolean;
    function  SetOutputOrder(sIdStatus: String) : Boolean;
    function  fnGetCHData(SCC_NO,SCC_SR,CH_NO,POS_NO:String) : String ;
    procedure OrderDataClear(OrderData: TJobOrder);
    function  GetJobNo : Integer;
  end;
  procedure U230Create();

const
  FormNo ='230';
var
  frmU230: TfrmU230;
  SrtFlag : integer = 0 ;

  OrderData  : TJobOrder;
  OrderCount : Integer ;

implementation

uses Main ;

{$R *.dfm}

//==============================================================================
// U230Create
//==============================================================================
procedure U230Create();
begin
  if not Assigned( frmU230 ) then
  begin
    frmU230 := TfrmU230.Create(Application);
    with frmU230 do
    begin
      fnCommandStart;
    end;
  end;
  frmU230.Show;
end;

//==============================================================================
// fnWmMsgRecv
//==============================================================================
procedure TfrmU230.fnWmMsgRecv(var MSG: TMessage);
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
procedure TfrmU230.FormActivate(Sender: TObject);
begin
  MainDm.M_Info.ActiveFormID := '230';
  frmMain.LblMenu000.Caption := MainDm.M_Info.ActiveFormID + '. ' + getLangMenuString(MainDm.M_Info.ActiveFormID, frmMain.LblMenu000.Caption, MainDm.M_Info.LANG_TYPE, 'N');
  frmU230.Caption := MainDm.M_Info.ActiveFormName;
  fnWmMsgSend( 22221,11111 );

  fnCommandQuery ;
end;

//==============================================================================
// FormDeactivate
//==============================================================================
procedure TfrmU230.FormDeactivate(Sender: TObject);
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
procedure TfrmU230.FormClose(Sender: TObject; var Action: TCloseAction);
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
  try frmU230 := Nil ;
  except end;
end;

//==============================================================================
// fnCommandStart
//==============================================================================
procedure TfrmU230.fnCommandStart;
begin
//
end;

//==============================================================================
// fnCommandOrder [지시]
//==============================================================================
procedure TfrmU230.fnCommandOrder  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [엑셀]
//==============================================================================
procedure TfrmU230.fnCommandExcel;
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
procedure TfrmU230.fnCommandAdd  ;
begin
//
end;

//==============================================================================
// fnCommandDelete [삭제]
//==============================================================================
procedure TfrmU230.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandUpdate [수정]                                                     //
//==============================================================================
procedure TfrmU230.fnCommandUpdate;
begin
//
end;

//==============================================================================
// fnCommandPrint [인쇄]
//==============================================================================
procedure TfrmU230.fnCommandPrint;
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
procedure TfrmU230.fnCommandQuery;
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
                '                       when ''7'' then ''공출고'' end) as ID_STATUS_DESC, ' +
                '       (SUBSTRING(ID_CODE,1,1)+''-''+SUBSTRING(ID_CODE,2,2)+''-''+SUBSTRING(ID_CODE,4,2)) as ID_CODE_DESC, ' +
                '        RF_LINE_NAME1, RF_LINE_NAME2, RF_PALLET_NO1, RF_PALLET_NO2, RF_MODEL_NO1, ' +
                '        RF_MODEL_NO2, RF_BMA_NO, RF_PALLET_BMA1, RF_PALLET_BMA2, RF_PALLET_BMA3,  ' +
                '        RF_AREA, RF_NEW_BMA  ' +
                '   From TT_STOCK ' +
                '  Where 1=1 ' +
                '    And ID_STATUS not in (''0'', ''8'', ''9'') ' +
                '    And OT_USED = ''1'' ' ;


      if (Trim(ComboBoxBank.Text)<>'') and (Trim(ComboBoxBank.Text)<>'전체') then
        StrSQL := StrSQL + ' And ID_BANK= ' + QuotedStr(Trim(ComboBoxBank.Text)) ;

      if (Trim(ComboBoxBay.Text)<>'') and (Trim(ComboBoxBay.Text)<>'전체') then
        StrSQL := StrSQL + ' And ID_BAY= ' + QuotedStr(Trim(ComboBoxBay.Text)) ;

      if (Trim(ComboBoxLevel.Text)<>'') and (Trim(ComboBoxLevel.Text)<>'전체') then
        StrSQL := StrSQL + ' And ID_LEVEL= ' + QuotedStr(Trim(ComboBoxLevel.Text)) ;

      if (Trim(edtModelNo.Text) <> '') then
        StrSQL := StrSQL + ' And UPPER(RF_MODEL_NO1) Like ''%' + UpperCase(Trim(edtModelNo.Text)) + '%'' ' ;

      if (rgITM_YN.ItemIndex = 1) then
        StrSQL := StrSQL + ' And ITM_CD = ''FULL'' '
      else if (rgITM_YN.ItemIndex = 2) then
        StrSQL := StrSQL + ' And ITM_CD = ''EPLT'' '
      else if (rgITM_YN.ItemIndex = 3) then
        StrSQL := StrSQL + ' And ITM_CD not in (''FULL'', ''EPLT'')' ;

      StrSQL := StrSQL + ' Order By STOCK_IN_DT, ID_CODE, ITM_CD ' ;

      SQL.Text := StrSQL;
      Open;
    end;
  except
    on E : Exception do
    begin
      qryInfo.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'fnCommandQuery', '조회', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnCommandQuery Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;

//==============================================================================
// fnCommandClose
//==============================================================================
procedure TfrmU230.fnCommandClose;
begin
  Close;
end;

//==============================================================================
// fnCommandLang [언어]                                                       //
//==============================================================================
procedure TfrmU230.fnCommandLang;
begin
//
end;

//==============================================================================
// dgInfoCellClick
//==============================================================================
procedure TfrmU230.dgInfoCellClick(Column: TColumnEh);
begin
  try
    if (dgInfo.SelectedRows.Count = 1) then
    begin
      edtOutCode.Text   := qryInfo.FieldByName('ITM_CD' ).AsString ;
      edtOutCell.Text   := qryInfo.FieldByName('ID_CODE_DESC').AsString ;
      edtOutIndate.Text := FormatDateTime('YYYY-MM-DD HH:NN:SS',qryInfo.FieldByName('STOCK_IN_DT' ).AsDateTime);
    end else
    if (dgInfo.SelectedRows.Count > 1) then
    begin
      edtOutCode.Text   := '[다중출고]';
      edtOutCell.Text   := '[다중출고]';
      edtOutIndate.Text := '[다중출고]';
    end else
    begin
      edtOutCode.Text   := '';
      edtOutCell.Text   := '';
      edtOutIndate.Text := '';
    end;
  except
    on E : Exception do
    begin
      qryInfo.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'dgInfoCellClick', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure dgInfoCellClick Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// btnOrderClick [출고지시]
//==============================================================================
procedure TfrmU230.btnOrderClick(Sender: TObject);
var
  i : integer ;
  LogStr : String;
begin
  try
    OrderCount := 0;
    if not qryInfo.Active then Exit;

    if cbOut.ItemIndex = 0 then
    begin
      MessageDlg('출고대를 선택해 주십시오.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end;

    if (cbOut.Text = '2') and (SC_STATUS[1].D213[11] = '1') or
       (cbOut.Text = '4') and (SC_STATUS[1].D213[13] = '1') or
       (cbOut.Text = '6') and (SC_STATUS[1].D213[15] = '1') then
    begin
      MessageDlg('AGV가 도킹중 입니다.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end;

    if (dgInfo.SelectedRows.Count = 1) then
    begin
      LogStr := '▷기종코드 ['+ edtOutCode.Text +'] ' + #13#10+
                '▷차종 [' + qryInfo.FieldByName('RF_MODEL_NO1').AsString +'] ' + #13#10+
                '▷적재위치 ['+ edtOutCell.Text +'] ' + #13#10+
                '▷입고일자 ['+ edtOutIndate.Text +'] ' + #13#10;


      if MessageDlg(' 선택 한 기종을 출고 하시겠습니까?' + #13#10  + #13#10+
                    '===============================' + #13#10+
                    LogStr +
                    '===============================' + #13#10+
                    '',
                    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit ;

      InsertPGMHist('['+FormNo+']', 'N', 'btnOrderClick', '', LogStr, 'PGM', '', '', '');
    end else
    if (dgInfo.SelectedRows.Count > 1) then
    begin
      if MessageDlg(' 선택 한 ['+IntToStr(dgInfo.SelectedRows.Count) +']개의 기종을 출고 하시겠습니까?' + #13#10  + #13#10+
                    '', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit ;
    end else
    begin
      MessageDlg(' 출고 할 기종을 선택해주십시오.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end;

    for i := 0 to (dgInfo.SelectedRows.Count-1) do
    begin
      with dgInfo.DataSource.DataSet do
      begin
        GotoBookmark(Pointer(dgInfo.SelectedRows.Items[i]));
        SetOutputOrder(IntToStr(i)) ;
      end;
    end;

    if OrderCount = dgInfo.SelectedRows.Count then
    begin
//      MessageDlg('출고지시['+IntToStr(OrderCount)+']가 완료되었습니다.' + #13#10  + #13#10+
//                 '', mtConfirmation, [mbYes], 0) ;
    end;

    edtOutCode.Text   := '';
    edtOutCell.Text   := '';
    edtOutIndate.Text := '';
    fnCommandQuery ;
  except
    on E : Exception do
    begin
      if qryInfo.Active then qryInfo.Close;
      if qryTemp.Active then qryTemp.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'btnOrderClick', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure btnOrderClick Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// SetOutputOrder [출고지시 데이터 생성]
//==============================================================================
function TfrmU230.SetOutputOrder(sIdStatus: String): Boolean;
begin
  try
    OrderDataClear(OrderData) ;

    OrderData.REG_TIME   := FormatDateTime('YYYYMMDDHHNNSS',Now);

    OrderData.LUGG       := Format('%.4d', [GetJobNo]) ; // 작업번호

    OrderData.JOBD       := '2'; // 출고지시
    OrderData.IS_AUTO    := 'N';
    OrderData.LINE_NO    := cbOut.Text; //LINE_NO

    OrderData.SRCSITE    := Format('%.4d', [StrToInt('1')]) ;                                      // 적재 호기
    OrderData.SRCAISLE   := Format('%.4d', [StrToInt(qryInfo.FieldByName('ID_BANK' ).AsString)]) ; // 적재 열
    OrderData.SRCBAY     := Format('%.4d', [StrToInt(qryInfo.FieldByName('ID_BAY'  ).AsString)]) ; // 적재 연
    OrderData.SRCLEVEL   := Format('%.4d', [StrToInt(qryInfo.FieldByName('ID_LEVEL').AsString)]) ; // 적재 단


    OrderData.DSTSITE    := '0001'; // 하역 위치
{
    OrderData.DSTAISLE   := '0001'; // 하역 열
    case cbOut.ItemIndex of   // 하역 연
      1  : begin OrderData.DSTBAY     := '0001'; end;
      2  : begin OrderData.DSTBAY     := '0004'; end;
      3  : begin OrderData.DSTBAY     := '0007'; end;
    end;
}
    OrderData.DSTAISLE   := '0000';
    OrderData.DSTBAY     := '0000';
    OrderData.DSTLEVEL   := Format('%.4d', [StrToInt(cbOut.Text)]); // 하역 단

    OrderData.ID_CODE    := qryInfo.FieldByName('ID_CODE').AsString ;

    OrderData.NOWMC      := '2';
    OrderData.JOBSTATUS  := '1';
    OrderData.NOWSTATUS  := '1';
    OrderData.BUFFSTATUS := '';//fnGetCHData('1','R','CH05','10'); // 출고레디
    OrderData.JOBREWORK  := '';
    OrderData.JOBERRORT  := '';
    OrderData.JOBERRORC  := '';
    OrderData.JOBERRORD  := '';
    OrderData.JOB_END    := '0';
    OrderData.CVFR       := cbOut.Text;
    OrderData.CVTO       := cbOut.Text;
    OrderData.CVCURR     := cbOut.Text;
    OrderData.ETC        := qryInfo.FieldByName('ID_MEMO').AsString ;
    OrderData.EMG        := IntToStr(rgEMG.ItemIndex);
    OrderData.ITM_CD     := qryInfo.FieldByName('ITM_CD').AsString ;
    OrderData.UP_TIME    := 'GETDATE()';

    OrderData.RF_LINE_NAME1  := qryInfo.FieldByName('RF_LINE_NAME1').AsString;
    OrderData.RF_LINE_NAME2  := qryInfo.FieldByName('RF_LINE_NAME2').AsString;
    OrderData.RF_PALLET_NO1  := qryInfo.FieldByName('RF_PALLET_NO1').AsString;
    OrderData.RF_PALLET_NO2  := qryInfo.FieldByName('RF_PALLET_NO2').AsString;
    OrderData.RF_MODEL_NO1   := qryInfo.FieldByName('RF_MODEL_NO1').AsString;
    OrderData.RF_MODEL_NO2   := qryInfo.FieldByName('RF_MODEL_NO2').AsString;
    OrderData.RF_BMA_NO      := qryInfo.FieldByName('RF_BMA_NO').AsString;
    OrderData.RF_PALLET_BMA1 := qryInfo.FieldByName('RF_PALLET_BMA1').AsString;
    OrderData.RF_PALLET_BMA2 := qryInfo.FieldByName('RF_PALLET_BMA2').AsString;
    OrderData.RF_PALLET_BMA3 := qryInfo.FieldByName('RF_PALLET_BMA3').AsString;
    OrderData.RF_AREA        := qryInfo.FieldByName('RF_AREA').AsString;
    OrderData.RF_NEW_BMA     := qryInfo.FieldByName('RF_NEW_BMA').AsString;

    if SetJobOrder then
    begin
      Inc(OrderCount) ;
    end;


  except
    on E : Exception do
    begin
      qryInfo.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'SetOutputOrder', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure SetOutputOrder Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// SetJobOrder [출고지시 데이터 저장]
//==============================================================================
function TfrmU230.SetJobOrder : Boolean;
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
      '    ETC, EMG, ITM_CD, UP_TIME,                      ' + #13#10 +
      '    RF_LINE_NAME1, RF_LINE_NAME2, RF_PALLET_NO1,    ' + #13#10 +
      '    RF_PALLET_NO2, RF_MODEL_NO1, RF_MODEL_NO2,      ' + #13#10 +
      '    RF_BMA_NO, RF_PALLET_BMA1, RF_PALLET_BMA2,      ' + #13#10 +
      '    RF_PALLET_BMA3, RF_AREA, RF_NEW_BMA             ' + #13#10 +
      '  ) VALUES (                                        ' + #13#10 +
      '    :REG_TIME, :LUGG, :JOBD, :IS_AUTO, :LINE_NO,    ' + #13#10 +
      '    :SRCSITE, :SRCAISLE, :SRCBAY, :SRCLEVEL,        ' + #13#10 +
      '    :DSTSITE, :DSTAISLE, :DSTBAY, :DSTLEVEL,        ' + #13#10 +
      '    :NOWMC, :JOBSTATUS, :NOWSTATUS, :BUFFSTATUS,    ' + #13#10 +
      '    :JOBREWORK, :JOBERRORT, :JOBERRORC, :JOBERRORD, ' + #13#10 +
      '    :JOB_END, :CVFR, :CVTO, :CVCURR,                ' + #13#10 +
      '    :ETC, :EMG, :ITM_CD, GETDATE(),                 ' + #13#10 +
      '    :RF_LINE_NAME1, :RF_LINE_NAME2, :RF_PALLET_NO1, ' + #13#10 +
      '    :RF_PALLET_NO2, :RF_MODEL_NO1, :RF_MODEL_NO2,   ' + #13#10 +
      '    :RF_BMA_NO, :RF_PALLET_BMA1, :RF_PALLET_BMA2,   ' + #13#10 +
      '    :RF_PALLET_BMA3, :RF_AREA, :RF_NEW_BMA          ' + #13#10 +
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
      Parameters[i].Value := OrderData.RF_LINE_NAME1;  inc(i);
      Parameters[i].Value := OrderData.RF_LINE_NAME2;  inc(i);
      Parameters[i].Value := OrderData.RF_PALLET_NO1;  inc(i);
      Parameters[i].Value := OrderData.RF_PALLET_NO2;  inc(i);
      Parameters[i].Value := OrderData.RF_MODEL_NO1;   inc(i);
      Parameters[i].Value := OrderData.RF_MODEL_NO2;   inc(i);
      Parameters[i].Value := OrderData.RF_BMA_NO;      inc(i);
      Parameters[i].Value := OrderData.RF_PALLET_BMA1; inc(i);
      Parameters[i].Value := OrderData.RF_PALLET_BMA2; inc(i);
      Parameters[i].Value := OrderData.RF_PALLET_BMA3; inc(i);
      Parameters[i].Value := OrderData.RF_AREA;        inc(i);
      Parameters[i].Value := OrderData.RF_NEW_BMA;     inc(i);
      ExecSql;

      //+++++++++++++++++++++++++++++++++++++
      // 셀상태 변경  ( 공셀(0) -> 공셀(5) )
      //+++++++++++++++++++++++++++++++++++++
      Close;
      SQL.Clear;
      SQL.Text :=
      ' UPDATE TT_STOCK               ' + #13#10 +
      '    SET ID_STATUS = :ID_STATUS ' + #13#10 +
      '  WHERE ID_HOGI = :ID_HOGI     ' + #13#10+
      '    AND ID_CODE = :ID_CODE ' ;
      Parameters[0].Value := '5';                         // 출고예약
      Parameters[1].Value := Copy(OrderData.SRCSITE,4,1); // 호기
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
      InsertPGMHist('['+FormNo+']', 'E', 'SetJobOrder', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure SetJobOrder Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// Pnl_MainResize
//==============================================================================
procedure TfrmU230.Pnl_MainResize(Sender: TObject);
begin
//
end;

//==============================================================================
// cbCodeChange
//==============================================================================
procedure TfrmU230.cbCodeChange(Sender: TObject);
begin
  fnCommandQuery ;
end;

//==============================================================================
// ComboBoxChange
//==============================================================================
procedure TfrmU230.ComboBoxChange(Sender: TObject);
begin
  fnCommandQuery ;
end;

//==============================================================================
// ComboBoxChange
//==============================================================================
procedure TfrmU230.ComboBoxKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    fnCommandQuery;
  end;
end;

//==============================================================================
// rgITM_YNClick
//==============================================================================
procedure TfrmU230.rgITM_YNClick(Sender: TObject);
begin
  fnCommandQuery;
end;

//==============================================================================
// dgInfoTitleClick [그리드 정렬]
//==============================================================================
procedure TfrmU230.dgInfoTitleClick(Column: TColumnEh);
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


//==============================================================================
// sbtResetClick
//==============================================================================
procedure TfrmU230.sbtResetClick(Sender: TObject);
begin
  rgITM_YN.ItemIndex      := 0 ;
  edtModelNo.Text         := '';
  rgITM_YN.ItemIndex      := 0 ;
  ComboBoxBank.ItemIndex  := 0 ;
  ComboBoxBay.ItemIndex   := 0 ;
  ComboBoxLevel.ItemIndex := 0 ;
  cbOut.ItemIndex         := 0 ;
  lbloutstation.Caption := '';
  fnCommandQuery;
end;


//==============================================================================
// fnGetCHData [입&출고 레디 체크]
//==============================================================================
function TfrmU230.fnGetCHData(SCC_NO,SCC_SR,CH_NO,POS_NO:String) : String ;
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
// OrderDataClear [구조체 초기화]
//==============================================================================
procedure TfrmU230.OrderDataClear(OrderData: TJobOrder);
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

  OrderData.RF_LINE_NAME1  := '';
  OrderData.RF_LINE_NAME2  := '';
  OrderData.RF_PALLET_NO1  := '';
  OrderData.RF_PALLET_NO2  := '';
  OrderData.RF_MODEL_NO1   := '';
  OrderData.RF_MODEL_NO2   := '';
  OrderData.RF_BMA_NO      := '';
  OrderData.RF_PALLET_BMA1 := '';
  OrderData.RF_PALLET_BMA2 := '';
  OrderData.RF_PALLET_BMA3 := '';
  OrderData.RF_AREA        := '';
  OrderData.RF_NEW_BMA     := '';
end;

//==============================================================================
// GetJobNo [작업번호 생성]
//==============================================================================
function TfrmU230.GetJobNo : Integer;
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
      Parameters.ParamByName('@I_TYPE').Value := 2;
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
// cbOutChange
//==============================================================================
procedure TfrmU230.cbOutChange(Sender: TObject);
var
  tmpBay : string;
begin
  case (Sender as TComboBox).ItemIndex of
    0  : begin lbloutstation.Caption := '' end;
    1  : begin lbloutstation.Caption := '02-07-01 출고대' end;
    2  : begin lbloutstation.Caption := '02-04-01 출고대' end;
    3  : begin lbloutstation.Caption := '02-01-01 출고대' end;
  end;
end;

end.





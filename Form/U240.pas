unit U240;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, d_MainDm, h_MainLib, h_ReferLib, StdCtrls, DB, ADODB, ExLibrary, ExVclLib,
  Grids, StrUtils, DBGrids, comobj, frxClass, frxDBSet, DBGridEhGrouping, EhLibADO,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,DBGridEhImpExp,
  DBGridEh, Vcl.Mask, Vcl.DBCtrls, DBCtrlsEh, PrnDbgeh, Vcl.Buttons ;

type
  TfrmU240 = class(TForm)
    dsInfo: TDataSource;
    qryInfo: TADOQuery;
    qryTemp: TADOQuery;
    EhPrint: TPrintDBGridEh;
    PD_GET_JOBNO: TADOStoredProc;
    Pnl_Main: TPanel;
    qryRackCheck: TADOQuery;
    btnOrder: TButton;
    Panel4: TPanel;
    dgInfo: TDBGridEh;
    Panel1: TPanel;
    Pnl_Top: TPanel;
    sbtReset: TSpeedButton;
    gbCell: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ComboBoxBank: TComboBox;
    ComboBoxBay: TComboBox;
    ComboBoxLevel: TComboBox;
    rgEMG: TRadioGroup;
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    edtOutCode: TEdit;
    edtOutCell: TEdit;
    edtOutInDate: TEdit;
    rgITM_YN: TRadioGroup;
    GroupBox2: TGroupBox;
    edtModelNo: TEdit;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    cbMoveBank: TComboBox;
    cbMoveBay: TComboBox;
    cbMoveLevel: TComboBox;
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
    function fnRack_check(ID_Code: string): Boolean;
  end;
  procedure U240Create();

const
  FormNo ='240';
var
  frmU240: TfrmU240;
  SrtFlag : integer = 0 ;

  OrderData  : TJobOrder;
  OrderCount : Integer ;

implementation

uses Main ;

{$R *.dfm}

//==============================================================================
// U240Create
//==============================================================================
procedure U240Create();
begin
  if not Assigned( frmU240 ) then
  begin
    frmU240 := TfrmU240.Create(Application);
    with frmU240 do
    begin
      fnCommandStart;
    end;
  end;
  frmU240.Show;
end;

//==============================================================================
// fnWmMsgRecv
//==============================================================================
procedure TfrmU240.fnWmMsgRecv(var MSG: TMessage);
begin
  case MSG.WParam of
    MSG_MDI_WIN_ORDER   : begin fnCommandOrder   ; end;           // MSG_MDI_WIN_ORDER   = 11 ; // ????
    MSG_MDI_WIN_ADD     : begin fnCommandAdd     ; end;           // MSG_MDI_WIN_ADD     = 12 ; // ????
    MSG_MDI_WIN_DELETE  : begin fnCommandDelete  ; end;           // MSG_MDI_WIN_DELETE  = 13 ; // ????
    MSG_MDI_WIN_UPDATE  : begin fnCommandUpdate  ; end;           // MSG_MDI_WIN_UPDATE  = 14 ; // ????
    MSG_MDI_WIN_EXCEL   : begin fnCommandExcel   ; end;           // MSG_MDI_WIN_EXCEL   = 15 ; // ????
    MSG_MDI_WIN_PRINT   : begin fnCommandPrint   ; end;           // MSG_MDI_WIN_PRINT   = 16 ; // ????
    MSG_MDI_WIN_QUERY   : begin fnCommandQuery   ; end;           // MSG_MDI_WIN_QUERY   = 17 ; // ????
    MSG_MDI_WIN_CLOSE   : begin fnCommandClose   ; Close; end;    // MSG_MDI_WIN_CLOSE   = 20 ; // ????
    MSG_MDI_WIN_LANG    : begin fnCommandLang    ; end;           // MSG_MDI_WIN_LANG    = 21 ; // ????
  end;
end;

//==============================================================================
// FormActivate
//==============================================================================
procedure TfrmU240.FormActivate(Sender: TObject);
begin
  MainDm.M_Info.ActiveFormID := '240';
  frmMain.LblMenu000.Caption := MainDm.M_Info.ActiveFormID + '. ' + getLangMenuString(MainDm.M_Info.ActiveFormID, frmMain.LblMenu000.Caption, MainDm.M_Info.LANG_TYPE, 'N');
  frmU240.Caption := MainDm.M_Info.ActiveFormName;
  fnWmMsgSend( 22221,11111 );

  fnCommandQuery ;
end;

//==============================================================================
// FormDeactivate
//==============================================================================
procedure TfrmU240.FormDeactivate(Sender: TObject);
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
procedure TfrmU240.FormClose(Sender: TObject; var Action: TCloseAction);
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
  try frmU240 := Nil ;
  except end;
end;

//==============================================================================
// fnCommandStart
//==============================================================================
procedure TfrmU240.fnCommandStart;
begin
//
end;

//==============================================================================
// fnCommandOrder [????]
//==============================================================================
procedure TfrmU240.fnCommandOrder  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [????]
//==============================================================================
procedure TfrmU240.fnCommandExcel;
begin
  try
    if hlbEhgridListExcel(dgInfo, frmMain.LblMenu000.Caption + '_' + FormatDatetime('YYYYMMDD', Now)) then
    begin
      MessageDlg('???? ?????? ??????????????.', mtConfirmation, [mbYes], 0);
    end else
    begin
      MessageDlg('???? ?????? ??????????????.', mtWarning, [mbYes], 0);
    end;
  except
    on E : Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'fnCommandExcel', '????', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnCommandExcel Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// fnCommandAdd [????]                                                        //
//==============================================================================
procedure TfrmU240.fnCommandAdd  ;
begin
//
end;

//==============================================================================
// fnCommandDelete [????]
//==============================================================================
procedure TfrmU240.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandUpdate [????]                                                     //
//==============================================================================
procedure TfrmU240.fnCommandUpdate;
begin
//
end;

//==============================================================================
// fnCommandPrint [????]
//==============================================================================
procedure TfrmU240.fnCommandPrint;
begin
  try
    if not qryInfo.Active then Exit;
    fnCommandQuery;
    EhPrint.DBGridEh := dgInfo;
    EhPrint.PageHeader.LeftText.Clear;
    EhPrint.PageHeader.LeftText.Add(Copy(MainDm.M_Info.ActiveFormName, 6,
                                    Length(MainDm.M_Info.ActiveFormName)-5) );
    EhPrint.PageHeader.Font.Name := '????';
    EhPrint.PageHeader.Font.Size := 10;
    EhPrint.PageFooter.RightText.Clear;
    EhPrint.PageFooter.RightText.Add(FormatDateTime('YYYY-MM-DD HH:NN:SS', Now) + '   ' +
                                     MainDM.M_Info.UserCode+' / '+MainDM.M_Info.UserName);
    EhPrint.PageFooter.Font.Name := '????';
    EhPrint.PageFooter.Font.Size := 10;

    EhPrint.Preview;
  except
    on E : Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'fnCommandPrint', '????', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnCommandPrint Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// fnCommandQuery
//==============================================================================
procedure TfrmU240.fnCommandQuery;
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
                '        ID_ZONE, ID_STATUS, ID_MEMO, OT_USED, IN_USED, ' +
                '       (Case ID_STATUS when ''0'' then ''????''     ' +
                '                       when ''1'' then ''????????'' ' +
                '                       when ''2'' then ''????''     ' +
                '                       when ''3'' then ''??????''   ' +
                '                       when ''4'' then ''????????'' ' +
                '                       when ''5'' then ''????????'' ' +
                '                       when ''6'' then ''????????'' ' +
                '                       when ''7'' then ''??????'' end) as ID_STATUS_DESC, ' +
                '       (SUBSTRING(ID_CODE,1,1)+''-''+SUBSTRING(ID_CODE,2,2)+''-''+SUBSTRING(ID_CODE,4,2)) as ID_CODE_DESC, ' +
                '        RF_LINE_NAME1, RF_LINE_NAME2, RF_PALLET_NO1, RF_PALLET_NO2, RF_MODEL_NO1, ' +
                '        RF_MODEL_NO2, RF_BMA_NO, RF_PALLET_BMA1, RF_PALLET_BMA2, RF_PALLET_BMA3,  ' +
                '        RF_AREA, RF_NEW_BMA  ' +
                '   From TT_STOCK ' +
                '  Where 1=1 ' +
                '    And ID_STATUS not in (''0'', ''8'', ''9'') ' +
                '    And OT_USED = ''1'' ' ;


      if (Trim(ComboBoxBank.Text)<>'') and (Trim(ComboBoxBank.Text)<>'????') then
        StrSQL := StrSQL + ' And ID_BANK= ' + QuotedStr(Trim(ComboBoxBank.Text)) ;

      if (Trim(ComboBoxBay.Text)<>'') and (Trim(ComboBoxBay.Text)<>'????') then
        StrSQL := StrSQL + ' And ID_BAY= ' + QuotedStr(Trim(ComboBoxBay.Text)) ;

      if (Trim(ComboBoxLevel.Text)<>'') and (Trim(ComboBoxLevel.Text)<>'????') then
        StrSQL := StrSQL + ' And ID_LEVEL= ' + QuotedStr(Trim(ComboBoxLevel.Text)) ;

      if (Trim(edtModelNo.Text) <> '') then
        StrSQL := StrSQL + ' And UPPER(RF_MODEL_NO1) Like ''%' + UpperCase(Trim(edtModelNo.Text)) + '%'' ' ;

      if (rgITM_YN.ItemIndex = 1) then
        StrSQL := StrSQL + ' And ITM_CD = ''FULL'' '
      else if (rgITM_YN.ItemIndex = 2) then
        StrSQL := StrSQL + ' And ITM_CD = ''EPLT'' '
      else if (rgITM_YN.ItemIndex = 3) then
        StrSQL := StrSQL + ' And ITM_CD not in (''FULL'', ''EPLT'')' ;

      StrSQL := StrSQL + ' Order By ID_CODE, ITM_CD, STOCK_IN_DT ' ;

      SQL.Text := StrSQL;
      Open;
    end;
  except
    on E : Exception do
    begin
      qryInfo.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'fnCommandQuery', '????', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnCommandQuery Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;

//==============================================================================
// fnCommandClose
//==============================================================================
procedure TfrmU240.fnCommandClose;
begin
  Close;
end;

//==============================================================================
// fnCommandLang [????]                                                       //
//==============================================================================
procedure TfrmU240.fnCommandLang;
begin
//
end;

//==============================================================================
// dgInfoCellClick
//==============================================================================
procedure TfrmU240.dgInfoCellClick(Column: TColumnEh);
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
      edtOutCode.Text   := '[????????]';
      edtOutCell.Text   := '[????????]';
      edtOutIndate.Text := '[????????]';
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
// btnOrderClick [????????]
//==============================================================================
procedure TfrmU240.btnOrderClick(Sender: TObject);
var
  i : integer ;
begin
  try
    OrderCount := 0;
    if not qryInfo.Active then Exit;

    if (cbMoveBank.ItemIndex = 0) or
       (cbMoveBay.ItemIndex = 0) or
       (cbMoveLevel.ItemIndex = 0) then
    begin
      MessageDlg('???? ?????? ?????? ????????.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end;

    if fnRack_check(cbMoveBank.Text + cbMoveBay.Text + cbMoveLevel.Text) then
    begin
      MessageDlg('?????? ????????. ???? ?????? ?????? ????????.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end;

    if (dgInfo.SelectedRows.Count = 1) then
    begin
      if MessageDlg(' ???? ?? ?????? ???? ?????????????' + #13#10  + #13#10+
                    '===============================' + #13#10+
                    '?????????? ['+ edtOutCode.Text +'] ' + #13#10+
                    '?????????? ['+ edtOutCell.Text +'] ' + #13#10+
                    '?????????? ['+ edtOutIndate.Text +'] ' + #13#10+
                    '===============================' + #13#10+
                    '', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit ;
    end else
    begin
      MessageDlg(' ???? ?? ?????? ??????????????.', mtConfirmation, [mbYes], 0) ;
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
//      MessageDlg('????????['+IntToStr(OrderCount)+']?? ??????????????.' + #13#10  + #13#10+
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
// SetOutputOrder [???????? ?????? ????]
//==============================================================================
function TfrmU240.SetOutputOrder(sIdStatus: String): Boolean;
begin
  try
    OrderDataClear(OrderData) ;

    OrderData.REG_TIME   := FormatDateTime('YYYYMMDDHHNNSS',Now);

    OrderData.LUGG       := Format('%.4d', [GetJobNo]) ; // ????????

    OrderData.JOBD       := '7'; // ?? ?? ?? ????????
    OrderData.IS_AUTO    := 'N';
    OrderData.LINE_NO    := '0';

    OrderData.SRCSITE    := Format('%.4d', [StrToInt('1')]) ;                                      // ???? ????
    OrderData.SRCAISLE   := Format('%.4d', [StrToInt(qryInfo.FieldByName('ID_BANK' ).AsString)]) ; // ???? ??
    OrderData.SRCBAY     := Format('%.4d', [StrToInt(qryInfo.FieldByName('ID_BAY'  ).AsString)]) ; // ???? ??
    OrderData.SRCLEVEL   := Format('%.4d', [StrToInt(qryInfo.FieldByName('ID_LEVEL').AsString)]) ; // ???? ??


    OrderData.DSTSITE    := Format('%.4d', [StrToInt('1')]) ;              // ???? ????
    OrderData.DSTAISLE   := Format('%.4d', [StrToInt(cbMoveBank.Text)])  ; // ???? ??
    OrderData.DSTBAY     := Format('%.4d', [StrToInt(cbMoveBay.Text)])   ; // ???? ??
    OrderData.DSTLEVEL   := Format('%.4d', [StrToInt(cbMoveLevel.Text)]) ; // ???? ??

    OrderData.ID_CODE    := qryInfo.FieldByName('ID_CODE').AsString ;

    OrderData.NOWMC      := '2';
    OrderData.JOBSTATUS  := '1';
    OrderData.NOWSTATUS  := '1';
    OrderData.BUFFSTATUS := ''; //fnGetCHData('1','R','CH05','10'); // ????????
    OrderData.JOBREWORK  := '';
    OrderData.JOBERRORT  := '';
    OrderData.JOBERRORC  := '';
    OrderData.JOBERRORD  := '';
    OrderData.JOB_END    := '0';
    OrderData.CVFR       := '1';
    OrderData.CVTO       := '1';
    OrderData.CVCURR     := '1';
    OrderData.ETC        := qryInfo.FieldByName('ID_MEMO').AsString ;
    if (cbMoveBank.Text + cbMoveBay.Text + cbMoveLevel.Text = '20301') or
       (cbMoveBank.Text + cbMoveBay.Text + cbMoveLevel.Text = '20601') then
    begin
      OrderData.EMG := '2'
    end else
    begin
      OrderData.EMG := IntToStr(rgEMG.ItemIndex);
    end;

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
// SetJobOrder [???????? ?????? ????]
//==============================================================================
function TfrmU240.SetJobOrder : Boolean;
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
      Parameters[i].Value := OrderData.LINE_NO;     Inc(i);
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
      // ?????? ????  ( ????(0) -> ????(5) )
      //+++++++++++++++++++++++++++++++++++++
      Close;
      SQL.Clear;
      SQL.Text :=
      ' UPDATE TT_STOCK               ' + #13#10 +
      '    SET ID_STATUS = :ID_STATUS ' + #13#10 +
      '  WHERE ID_HOGI = :ID_HOGI     ' + #13#10+
      '    AND ID_CODE = :ID_CODE ' ;
      Parameters[0].Value := '5';                         // ????????
      Parameters[1].Value := Copy(OrderData.SRCSITE,4,1); // ????
      Parameters[2].Value := OrderData.ID_CODE;           // ??????
      ExecSql;
      Close;

      //+++++++++++++++++++++++++++++++++++++
      // ?????? ????  ( ????(0) -> ????(4) )
      //+++++++++++++++++++++++++++++++++++++
      if (cbMoveBank.Text + cbMoveBay.Text + cbMoveLevel.Text = '20301') or
         (cbMoveBank.Text + cbMoveBay.Text + cbMoveLevel.Text = '20601') then
      begin
        Close;
      end else
      begin
        Close;
        SQL.Clear;
        SQL.Text :=
        ' UPDATE TT_STOCK               ' + #13#10 +
        '    SET ID_STATUS = :ID_STATUS ' + #13#10 +
        '  WHERE ID_HOGI = :ID_HOGI     ' + #13#10+
        '    AND ID_CODE = :ID_CODE ' ;
        Parameters[0].Value := '4';                         // ????????
        Parameters[1].Value := Copy(OrderData.SRCSITE,4,1); // ????
        Parameters[2].Value := cbMoveBank.Text + cbMoveBay.Text + cbMoveLevel.Text;           // ??????
        ExecSql;
        Close;
      end;
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
procedure TfrmU240.Pnl_MainResize(Sender: TObject);
begin
//
end;

//==============================================================================
// cbCodeChange
//==============================================================================
procedure TfrmU240.cbCodeChange(Sender: TObject);
begin
  fnCommandQuery ;
end;

//==============================================================================
// ComboBoxChange
//==============================================================================
procedure TfrmU240.ComboBoxChange(Sender: TObject);
begin
  fnCommandQuery ;
end;

//==============================================================================
// ComboBoxChange
//==============================================================================
procedure TfrmU240.ComboBoxKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    fnCommandQuery;
  end;
end;

//==============================================================================
// rgITM_YNClick
//==============================================================================
procedure TfrmU240.rgITM_YNClick(Sender: TObject);
begin
  fnCommandQuery;
end;

//==============================================================================
// dgInfoTitleClick [?????? ????]
//==============================================================================
procedure TfrmU240.dgInfoTitleClick(Column: TColumnEh);
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
procedure TfrmU240.sbtResetClick(Sender: TObject);
begin
  rgITM_YN.ItemIndex      := 0 ;
  edtModelNo.Text         := '';
  ComboBoxBank.ItemIndex  := 0 ;
  ComboBoxBay.ItemIndex   := 0 ;
  ComboBoxLevel.ItemIndex := 0 ;
  cbMoveBank.ItemIndex    := 0 ;
  cbMoveBay.ItemIndex     := 0 ;
  cbMoveLevel.ItemIndex   := 0 ;

  fnCommandQuery;
end;


//==============================================================================
// fnGetCHData [??&???? ???? ????]
//==============================================================================
function TfrmU240.fnGetCHData(SCC_NO,SCC_SR,CH_NO,POS_NO:String) : String ;
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
// OrderDataClear [?????? ??????]
//==============================================================================
procedure TfrmU240.OrderDataClear(OrderData: TJobOrder);
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
// GetJobNo [???????? ????]
//==============================================================================
function TfrmU240.GetJobNo : Integer;
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
      Parameters.ParamByName('@I_TYPE').Value := 3;
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
// fnRack_check : ?????????? ????
//==============================================================================
function TfrmU240.fnRack_check(ID_Code: string): Boolean;
var
  StrSQL, StrLog : String ;
begin
  try
    Result := False;

    StrSQL  := ' SELECT * FROM TT_STOCK ' +
               '  WHERE ID_CODE = ''' + ID_Code + ''' ' +
               '    AND ID_STATUS = ''0'' ';  // AGV?? ???? ???????? ???? ???? CV?? ?????? ????
    with qryRackCheck do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL;
      Open;

      if (Bof and Eof) then
      begin
        Result := True;
      end;
      Close;
    end;
  except
    qryRackCheck.Close;
    Result := True;
  end;
end;

end.

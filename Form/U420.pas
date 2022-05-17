unit U420;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, d_MainDm, h_MainLib, h_ReferLib, StdCtrls, DB, ADODB, ExLibrary, ExVclLib,
  Grids, StrUtils, DBGrids, comobj, frxClass, frxDBSet, DBGridEhGrouping, EhLibADO,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,DBGridEhImpExp,
  DBGridEh, Vcl.Mask, Vcl.DBCtrls, DBCtrlsEh, PrnDbgeh, Vcl.Buttons,
  Vcl.ComCtrls ;

type
  TfrmU420 = class(TForm)
    qryTemp: TADOQuery;
    qryInfo: TADOQuery;
    dsInfo: TDataSource;
    EhPrint: TPrintDBGridEh;
    Pnl_Top: TPanel;
    Pnl_Main: TPanel;
    GroupBox1: TGroupBox;
    Label31: TLabel;
    dtDateFr: TDateTimePicker;
    dtTimeFr: TDateTimePicker;
    dtDateTo: TDateTimePicker;
    dtTimeTo: TDateTimePicker;
    cbDateUse: TCheckBox;
    gbCell: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ComboBoxBank: TComboBox;
    ComboBoxBay: TComboBox;
    ComboBoxLevel: TComboBox;
    dgInfo: TDBGridEh;
    GroupBox3: TGroupBox;
    edtModelNo: TEdit;
    rgType: TRadioGroup;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dtDateTimeChange(Sender: TObject);
    procedure cbCodeChange(Sender: TObject);
    procedure ComboBoxChange(Sender: TObject);
    procedure dgInfoTitleClick(Column: TColumnEh);
    procedure FormShow(Sender: TObject);
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

  end;
  procedure U420Create();

const
  FormNo ='420';
var
  frmU420: TfrmU420;
  SrtFlag : integer = 0 ;

implementation

uses Main ;

{$R *.dfm}

//==============================================================================
// U230Create
//==============================================================================
procedure U420Create();
begin
  if not Assigned( frmU420 ) then
  begin
    frmU420 := TfrmU420.Create(Application);
    with frmU420 do
    begin
      fnCommandStart;
    end;
  end;
  frmU420.Show;
end;

//==============================================================================
// fnWmMsgRecv
//==============================================================================
procedure TfrmU420.fnWmMsgRecv(var MSG: TMessage);
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
procedure TfrmU420.FormActivate(Sender: TObject);
begin
  MainDm.M_Info.ActiveFormID := '420';
  frmMain.LblMenu000.Caption := MainDm.M_Info.ActiveFormID + '. ' + getLangMenuString(MainDm.M_Info.ActiveFormID, frmMain.LblMenu000.Caption, MainDm.M_Info.LANG_TYPE, 'N');
  frmU420.Caption := MainDm.M_Info.ActiveFormName;
  fnWmMsgSend( 22221,11111 );

  fnCommandQuery ;
end;

//==============================================================================
// FormDeactivate
//==============================================================================
procedure TfrmU420.FormDeactivate(Sender: TObject);
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
// FormShow
//==============================================================================
procedure TfrmU420.FormShow(Sender: TObject);
begin
  dtDateFr.Date := StrToDate(FormatDateTime('YYYY-MM-DD',Now));
  dtTimeFr.Time := StrToTime('00:00:00');

  dtDateTo.Date := StrToDate(FormatDateTime('YYYY-MM-DD',Now));
  dtTimeTo.Time := StrToTime(FormatDateTime('HH:NN:SS',Now));
end;

//==============================================================================
// FormClose
//==============================================================================
procedure TfrmU420.FormClose(Sender: TObject; var Action: TCloseAction);
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
  try frmU420 := Nil ;
  except end;
end;

//==============================================================================
// fnCommandStart
//==============================================================================
procedure TfrmU420.fnCommandStart;
begin
//
end;

//==============================================================================
// fnCommandOrder [지시]
//==============================================================================
procedure TfrmU420.fnCommandOrder  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [엑셀]
//==============================================================================
procedure TfrmU420.fnCommandExcel;
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
procedure TfrmU420.fnCommandAdd  ;
begin
//
end;

//==============================================================================
// fnCommandDelete [삭제]
//==============================================================================
procedure TfrmU420.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandUpdate [수정]                                                     //
//==============================================================================
procedure TfrmU420.fnCommandUpdate;
begin
//
end;

//==============================================================================
// fnCommandPrint [인쇄]
//==============================================================================
procedure TfrmU420.fnCommandPrint;
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
procedure TfrmU420.fnCommandQuery;
var
  StrSQL : String;
begin
  try
    with qryInfo do
    begin
      Close;
      SQL.Clear;
      StrSQL   := ' Select REG_TIME, LUGG, JOBD, LINE_NO,             ' +  #13#10+
                  '        SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL        ' +  #13#10+
                  '        DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL        ' +  #13#10+
                  '        NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS    ' +  #13#10+
                  '        JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD ' +  #13#10+
                  '        CVFR, CVTO, CVCURR, ETC, EMG, ITM_CD,      ' +  #13#10+
                  '       (Case when (JOBD=''1'') then ''입고'' ' +  #13#10+
                  '             when (JOBD=''2'') and (EMG=''0'') then ''출고'' ' +  #13#10+
                  '             when (JOBD=''2'') and (EMG=''1'') then ''긴급출고'' end) as JOBD_DESC, ' +  #13#10+
                  '       (Case NOWMC when ''1'' then ''컨베어 작업'' ' +  #13#10+
                  '                   when ''2'' then ''스태커 적재'' ' +  #13#10+
                  '                   when ''3'' then ''스태커 하역'' ' + #13#10+
                  '                   when ''4'' then ''AGV작업'' end) as NOWMC_DESC, ' +  #13#10+
                  '       (Case NOWSTATUS when ''1'' then ''등록'' ' +  #13#10+
                  '                       when ''2'' then ''지시'' ' +  #13#10+
                  '                       when ''3'' then ''진행'' ' +  #13#10+
                  '                       when ''4'' then ''완료'' end) as NOWSTATUS_DESC, ' +  #13#10+
                  '       (Case JOBERRORC when ''''  then ''정상'' ' +  #13#10+
                  '                       when ''0'' then ''정상'' ' +  #13#10+
                  '                       when NULL  then ''정상'' ' +  #13#10+
                  '                       when ''1'' then ''에러'' ' +  #13#10+
                  '                       else ''정상'' end) as JOBERRORC_DESC, ' +  #13#10+
                  '       (Case when (JOBERRORD = ''0000'') or  ' +
	                  '                  (JOBERRORD = '''') or ' +
				            '                  (IsNull(JOBERRORD, '''') = '''') then ''정상'' ' +
                    '             when JOBERRORD not like ''%불일치%'' then (SELECT ERR_NAME FROM TM_ERROR WHERE ERR_CODE = A.JOBERRORD) ' +
			              '             else JOBERRORD end ) as JOBERRORD_DESC, ' +
                  '       (Case BUFFSTATUS when ''0'' then ''대기'' ' +  #13#10+
                  '                        when ''1'' then ''입고가능'' end) as BUFFSTATUS_DESC, ' +  #13#10+
                  '       (SUBSTRING(SRCAISLE,4,1)+''-''+SUBSTRING(SRCBAY,3,2)+''-''+SUBSTRING(SRCLEVEL,3,2)) as ID_CODE, ' +  #13#10+
                  '       (SUBSTRING(REG_TIME,1,4)+''-''+SUBSTRING(REG_TIME,5,2)+''-''+SUBSTRING(REG_TIME,7,2)+''  ''+ ' +  #13#10+
                  '        SUBSTRING(REG_TIME,9,2)+'':''+SUBSTRING(REG_TIME,11,2)+'':''+SUBSTRING(REG_TIME,13,2)) as REG_TIME_CONV, ' +  #13#10+
                  '       CONVERT(VARCHAR, REG_TIME, 120) as REG_TIME_DESC ,' +
                  '        RF_LINE_NAME1, RF_LINE_NAME2, RF_PALLET_NO1, RF_PALLET_NO2, RF_MODEL_NO1, ' +
                  '        RF_MODEL_NO2, RF_BMA_NO, RF_PALLET_BMA1, RF_PALLET_BMA2, RF_PALLET_BMA3,  ' +
                  '        RF_AREA  ' +
                  '   From TT_HISTORY as A ' +  #13#10+
                  '  Where JOBD    = ''2'' ' +  #13#10+
                  '    And JOB_END = ''1'' ' ;

      if (Trim(ComboBoxBank.Text)<>'') and (Trim(ComboBoxBank.Text)<>'전체') then
        StrSQL := StrSQL + ' And SRCAISLE= ' + QuotedStr(FormatFloat('0000',StrToInt(Trim(ComboBoxBank.Text)))) ;

      if (Trim(ComboBoxBay.Text)<>'') and (Trim(ComboBoxBay.Text)<>'전체') then
        StrSQL := StrSQL + ' And SRCBAY= ' + QuotedStr(FormatFloat('0000',StrToInt(Trim(ComboBoxBay.Text)))) ;

      if (Trim(ComboBoxLevel.Text)<>'') and (Trim(ComboBoxLevel.Text)<>'전체') then
        StrSQL := StrSQL + ' And SRCLEVEL= ' + QuotedStr(FormatFloat('0000',StrToInt(Trim(ComboBoxLevel.Text)))) ;

      if cbDateUse.Checked then
        StrSQL := StrSQL + ' And REG_TIME BetWeen ' +
                           '      '''+FormatDateTime('YYYYMMDD', dtDateFr.Date)+''+FormatDateTime('HHNNSS', dtTimeFr.Time)+''' '+
                           '  And '''+FormatDateTime('YYYYMMDD', dtDateTo.Date)+''+FormatDateTime('HHNNSS', dtTimeTo.Time)+''' ';

      if (Trim(UpperCase(edtModelNo.Text)) <> '') then
        StrSQL := StrSQL + ' And UPPER(RF_MODEL_NO1) like ' + QuotedStr('%' + Trim(UpperCase(edtModelNo.Text)) + '%');

      if (rgType.ItemIndex = 1) then
        StrSQL := StrSQL + ' And ITM_CD = ''FULL'' '
      else if (rgType.ItemIndex = 2) then
        StrSQL := StrSQL + ' And ITM_CD = ''EPLT'' '
      else if (rgType.ItemIndex = 3) then
        StrSQL := StrSQL + ' And ITM_CD not in (''FULL'', ''EPLT'')' ;

      StrSQL := StrSQL + '  Order By REG_TIME, LUGG ' ;
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
procedure TfrmU420.fnCommandClose;
begin
  Close;
end;

//==============================================================================
// fnCommandLang [언어]                                                       //
//==============================================================================
procedure TfrmU420.fnCommandLang;
begin
//
end;

//==============================================================================
// dtDateTimeChange
//==============================================================================
procedure TfrmU420.dtDateTimeChange(Sender: TObject);
begin
  fnCommandQuery;
end;

//==============================================================================
// cbCodeChange
//==============================================================================
procedure TfrmU420.cbCodeChange(Sender: TObject);
begin
  fnCommandQuery;
end;

//==============================================================================
// ComboBoxChange
//==============================================================================
procedure TfrmU420.ComboBoxChange(Sender: TObject);
begin
  fnCommandQuery;
end;

//==============================================================================
// dgInfoTitleClick
//==============================================================================
procedure TfrmU420.dgInfoTitleClick(Column: TColumnEh);
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





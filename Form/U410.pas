unit U410;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, d_MainDm, h_MainLib, h_ReferLib, StdCtrls, DB, ADODB, ExLibrary, ExVclLib,
  Grids, StrUtils, DBGrids, comobj, frxClass, frxDBSet, DBGridEhGrouping, EhLibADO,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,DBGridEhImpExp,
  DBGridEh, Vcl.Mask, Vcl.DBCtrls, DBCtrlsEh, PrnDbgeh, Vcl.Buttons,
  Vcl.ComCtrls ;

type
  TfrmU410 = class(TForm)
    qryTemp: TADOQuery;
    qryInfo2: TADOQuery;
    dsInfo2: TDataSource;
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
    gbCode: TGroupBox;
    cbCode: TComboBox;
    gbCell: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ComboBoxBank: TComboBox;
    ComboBoxBay: TComboBox;
    ComboBoxLevel: TComboBox;
    DBGridEh1: TDBGridEh;
    Shape2: TShape;
    Panel1: TPanel;
    dgInfo: TDBGridEh;
    Shape1: TShape;
    qryInfo1: TADOQuery;
    dsInfo1: TDataSource;
    qryInfo3: TADOQuery;
    dsInfo3: TDataSource;
    GroupBox2: TGroupBox;
    rgType: TRadioGroup;
    edtModelNo: TEdit;
    DBGridEh2: TDBGridEh;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dtDateTimeChange(Sender: TObject);
    procedure cbCodeChange(Sender: TObject);
    procedure ComboBoxChange(Sender: TObject);
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

    procedure  SetComboBox;

    procedure fnInfo1;
    procedure fnInfo2;
    procedure fnInfo3;
  end;
  procedure U410Create();

const
  FormNo ='410';
var
  frmU410: TfrmU410;
  SrtFlag : integer = 0 ;

implementation

uses Main ;

{$R *.dfm}

//==============================================================================
// U230Create
//==============================================================================
procedure U410Create();
begin
  if not Assigned( frmU410 ) then
  begin
    frmU410 := TfrmU410.Create(Application);
    with frmU410 do
    begin
      fnCommandStart;
    end;
  end;
  frmU410.Show;
end;

//==============================================================================
// fnWmMsgRecv
//==============================================================================
procedure TfrmU410.fnWmMsgRecv(var MSG: TMessage);
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
procedure TfrmU410.FormActivate(Sender: TObject);
begin
  MainDm.M_Info.ActiveFormID := '410';
  frmMain.LblMenu000.Caption := MainDm.M_Info.ActiveFormID + '. ' + getLangMenuString(MainDm.M_Info.ActiveFormID, frmMain.LblMenu000.Caption, MainDm.M_Info.LANG_TYPE, 'N');
  frmU410.Caption := MainDm.M_Info.ActiveFormName;
  fnWmMsgSend( 22221,11111 );

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
procedure TfrmU410.FormDeactivate(Sender: TObject);
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
procedure TfrmU410.FormClose(Sender: TObject; var Action: TCloseAction);
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
  try frmU410 := Nil ;
  except end;
end;

//==============================================================================
// fnCommandStart
//==============================================================================
procedure TfrmU410.fnCommandStart;
begin
//
end;

//==============================================================================
// fnCommandOrder [지시]
//==============================================================================
procedure TfrmU410.fnCommandOrder  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [엑셀]
//==============================================================================
procedure TfrmU410.fnCommandExcel;
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
procedure TfrmU410.fnCommandAdd  ;
begin
//
end;

//==============================================================================
// fnCommandDelete [삭제]
//==============================================================================
procedure TfrmU410.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandUpdate [수정]                                                     //
//==============================================================================
procedure TfrmU410.fnCommandUpdate;
begin
//
end;

//==============================================================================
// fnCommandPrint [인쇄]
//==============================================================================
procedure TfrmU410.fnCommandPrint;
begin
  try
    if not qryInfo1.Active then Exit;
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
procedure TfrmU410.fnCommandQuery;
var
  StrSQL : String;
begin
  try

      fnInfo1;
      fnInfo2;
      fnInfo3;

//
//    with qryInfo do
//    begin
//      Close;
//      SQL.Clear;
//      StrSQL   := ' Select REG_TIME, LUGG, JOBD, LINE_NO,             ' +  #13#10+
//                  '        SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL,        ' +  #13#10+
//                  '        DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL,        ' +  #13#10+
//                  '        NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS,    ' +  #13#10+
//                  '        JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD, ' +  #13#10+
//                  '        CVFR, CVTO, CVCURR, ETC, EMG, ITM_CD,      ' +  #13#10+
//                  '       (Case JOBD  when ''1'' then ''입고'' ' +  #13#10+
//                  '                   when ''2'' then ''출고'' end) as JOBD_DESC, ' +  #13#10+
//                  '       (Case NOWMC when ''1'' then ''컨베어 작업'' ' +  #13#10+
//                  '                   when ''2'' then ''스태커 적재'' ' +  #13#10+
//                  '                   when ''3'' then ''스태커 하역'' ' + #13#10+
//                  '                   when ''4'' then ''AGV작업'' end) as NOWMC_DESC, ' +  #13#10+
//                  '       (Case NOWSTATUS when ''1'' then ''등록'' ' +  #13#10+
//                  '                       when ''2'' then ''지시'' ' +  #13#10+
//                  '                       when ''3'' then ''진행'' ' +  #13#10+
//                  '                       when ''4'' then ''완료'' end) as NOWSTATUS_DESC, ' +  #13#10+
//                  '       (Case JOBERRORC when ''''  then ''정상'' ' +  #13#10+
//                  '                       when ''0'' then ''정상'' ' +  #13#10+
//                  '                       when NULL  then ''정상'' ' +  #13#10+
//                  '                       when ''1'' then ''에러'' ' +  #13#10+
//                  '                       else ''정상'' end) as JOBERRORC_DESC, ' +  #13#10+
//                  '       (Case when (JOBERRORD = ''0000'') or  ' +
//	                  '                  (JOBERRORD = '''') or ' +
//				            '                  (IsNull(JOBERRORD, '''') = '''') then ''정상'' ' +
//                    '             when JOBERRORD not like ''%불일치%'' then (SELECT ERR_NAME FROM TM_ERROR WHERE ERR_CODE = A.JOBERRORD) ' +
//			              '             else JOBERRORD end ) as JOBERRORD_DESC, ' +
//                  '       (Case BUFFSTATUS when ''0'' then ''대기'' ' +  #13#10+
//                  '                        when ''1'' then ''입고가능'' end) as BUFFSTATUS_DESC, ' +  #13#10+
//                  '       (SUBSTRING(DSTAISLE,4,1)+''-''+SUBSTRING(DSTBAY,3,2)+''-''+SUBSTRING(DSTLEVEL,3,2)) as ID_CODE, ' +  #13#10+
//                  '       (SUBSTRING(REG_TIME,1,4)+''-''+SUBSTRING(REG_TIME,5,2)+''-''+SUBSTRING(REG_TIME,7,2)+''  ''+ ' +  #13#10+
//                  '        SUBSTRING(REG_TIME,9,2)+'':''+SUBSTRING(REG_TIME,11,2)+'':''+SUBSTRING(REG_TIME,13,2)) as REG_TIME_CONV, ' +  #13#10+
//                  '        CONVERT(VARCHAR, REG_TIME, 120) as REG_TIME_DESC, ' +
//                  '        RF_LINE_NAME1, RF_LINE_NAME2, RF_PALLET_NO1, RF_PALLET_NO2, RF_MODEL_NO1, ' +
//                  '        RF_MODEL_NO2, RF_BMA_NO, RF_PALLET_BMA1, RF_PALLET_BMA2, RF_PALLET_BMA3,  ' +
//                  '        RF_AREA  ' +
//                  '   From TT_HISTORY as A ' +  #13#10+
//                  '  Where JOBD    = ''1'' ' +  #13#10+
//                  '    And JOB_END = ''1'' ' ;
//
//                  if (Trim(cbCode.Text)<>'') and (Trim(cbCode.Text)<>'전체') then
//                    StrSQL := StrSQL + ' And ITM_CD= ' + QuotedStr(Trim(cbCode.Text)) ;
//
//                  if (Trim(ComboBoxBank.Text)<>'') and (Trim(ComboBoxBank.Text)<>'전체') then
//                    StrSQL := StrSQL + ' And DSTAISLE= ' + QuotedStr(FormatFloat('0000',StrToInt(Trim(ComboBoxBank.Text)))) ;
//
//                  if (Trim(ComboBoxBay.Text)<>'') and (Trim(ComboBoxBay.Text)<>'전체') then
//                    StrSQL := StrSQL + ' And DSTBAY= ' + QuotedStr(FormatFloat('0000',StrToInt(Trim(ComboBoxBay.Text)))) ;
//
//                  if (Trim(ComboBoxLevel.Text)<>'') and (Trim(ComboBoxLevel.Text)<>'전체') then
//                    StrSQL := StrSQL + ' And DSTLEVEL= ' + QuotedStr(FormatFloat('0000',StrToInt(Trim(ComboBoxLevel.Text)))) ;
//
//                  if cbDateUse.Checked then
//                    StrSQL := StrSQL + ' And REG_TIME Between ' +
//                                       '      '''+FormatDateTime('YYYYMMDD', dtDateFr.Date)+''+FormatDateTime('HHNNSS', dtTimeFr.Time)+''' '+
//                                       '  And '''+FormatDateTime('YYYYMMDD', dtDateTo.Date)+''+FormatDateTime('HHNNSS', dtTimeTo.Time)+''' ';
//
//                  StrSQL := StrSQL + '  Order By REG_TIME, LUGG ' ;
//      SQL.Text := StrSQL ;
//      Open;
//    end;
  except
    on E : Exception do
    begin
      //qryInfo.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'fnCommandQuery', '조회', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnCommandQuery Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;

//==============================================================================
// fnCommandClose
//==============================================================================
procedure TfrmU410.fnCommandClose;
begin
  Close;
end;

//==============================================================================
// fnCommandLang [언어]                                                       //
//==============================================================================
procedure TfrmU410.fnCommandLang;
begin
//
end;

//==============================================================================
// fnInfo1  시간별 입출고 실적
//==============================================================================
procedure TfrmU410.fnInfo1;
var
  StrSQL : String;
  WhereStr : String;
begin
  try
    WhereStr := '';
    if (rgType.ItemIndex = 1) then
    begin
      WhereStr := WhereStr + ' AND ITM_CD = ' + QuotedStr('FULL');
    end else
    if (rgType.ItemIndex = 2) then
    begin
      WhereStr := WhereStr + ' AND ITM_CD = ' + QuotedStr('EPLT');
    end else
    if (rgType.ItemIndex = 3) then
    begin
      WhereStr := WhereStr + ' AND ITM_CD not in (''FULL'', ''EPLT'') ';
    end;

    if (Trim(edtModelNo.Text) <> '') then
    begin
      WhereStr := WhereStr + ' AND UPPER(RF_MODEL_NO1) like ' + QuotedStr('%' + Trim(UpperCase(edtModelNo.Text)) + '%');
    end;


    with qryInfo1 do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' SELECT JOB_HOUR, ISNULL(IN_CNT, 0) AS IN_CNT, ISNULL(OT_CNT, 0) AS OT_CNT ' +
                  ' FROM (SELECT ''08H'' AS JOB_HOUR ' +
                             ' , SUM(CASE WHEN JOBD = ''1'' THEN 1 ELSE 0 END) AS IN_CNT ' +
                             ' , SUM(CASE WHEN JOBD = ''2'' THEN 1 ELSE 0 END) AS OT_CNT ' +
                          ' FROM TT_HISTORY ' +
                         ' WHERE HIS_TIME BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD', dtDateFr.Date) + ' 08:00:00') +
                                            ' AND ' + QuotedStr(FormatdateTime('YYYY-MM-DD', dtDateFr.Date) + ' 08:59:59') +
                           ' AND JOB_END = ''1'' ' +
                           WhereStr +
                         ' UNION ALL ' +
                         'SELECT ''09H'' AS JOB_HOUR ' +
                             ' , SUM(CASE WHEN JOBD = ''1'' THEN 1 ELSE 0 END) AS IN_CNT ' +
                             ' , SUM(CASE WHEN JOBD = ''2'' THEN 1 ELSE 0 END) AS OT_CNT ' +
                          ' FROM TT_HISTORY ' +
                         ' WHERE HIS_TIME BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD', dtDateFr.Date) + ' 09:00:00') +
                                            ' AND ' + QuotedStr(FormatdateTime('YYYY-MM-DD', dtDateFr.Date) + ' 09:59:59') +
                           ' AND JOB_END = ''1'' ' +
                           WhereStr +
                         ' UNION ALL ' +
                         'SELECT ''10H'' AS JOB_HOUR ' +
                             ' , SUM(CASE WHEN JOBD = ''1'' THEN 1 ELSE 0 END) AS IN_CNT ' +
                             ' , SUM(CASE WHEN JOBD = ''2'' THEN 1 ELSE 0 END) AS OT_CNT ' +
                          ' FROM TT_HISTORY ' +
                         ' WHERE HIS_TIME BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD', dtDateFr.Date) + ' 10:00:00') +
                                            ' AND ' + QuotedStr(FormatdateTime('YYYY-MM-DD', dtDateFr.Date) + ' 10:59:59') +
                           ' AND JOB_END = ''1'' ' +
                           WhereStr +
                         ' UNION ALL ' +
                         'SELECT ''11H'' AS JOB_HOUR ' +
                             ' , SUM(CASE WHEN JOBD = ''1'' THEN 1 ELSE 0 END) AS IN_CNT ' +
                             ' , SUM(CASE WHEN JOBD = ''2'' THEN 1 ELSE 0 END) AS OT_CNT ' +
                          ' FROM TT_HISTORY ' +
                         ' WHERE HIS_TIME BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD', dtDateFr.Date) + ' 11:00:00') +
                                            ' AND ' + QuotedStr(FormatdateTime('YYYY-MM-DD', dtDateFr.Date) + ' 11:59:59') +
                           ' AND JOB_END = ''1'' ' +
                           WhereStr +
                         ' UNION ALL ' +
                         'SELECT ''12H'' AS JOB_HOUR ' +
                             ' , SUM(CASE WHEN JOBD = ''1'' THEN 1 ELSE 0 END) AS IN_CNT ' +
                             ' , SUM(CASE WHEN JOBD = ''2'' THEN 1 ELSE 0 END) AS OT_CNT ' +
                          ' FROM TT_HISTORY ' +
                         ' WHERE HIS_TIME BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD', dtDateFr.Date) + ' 12:00:00') +
                                            ' AND ' + QuotedStr(FormatdateTime('YYYY-MM-DD', dtDateFr.Date) + ' 12:59:59') +
                           ' AND JOB_END = ''1'' ' +
                           WhereStr +
                         ' UNION ALL ' +
                         'SELECT ''13H'' AS JOB_HOUR ' +
                             ' , SUM(CASE WHEN JOBD = ''1'' THEN 1 ELSE 0 END) AS IN_CNT ' +
                             ' , SUM(CASE WHEN JOBD = ''2'' THEN 1 ELSE 0 END) AS OT_CNT ' +
                          ' FROM TT_HISTORY ' +
                         ' WHERE HIS_TIME BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD', dtDateFr.Date) + ' 13:00:00') +
                                            ' AND ' + QuotedStr(FormatdateTime('YYYY-MM-DD', dtDateFr.Date) + ' 13:59:59') +
                           ' AND JOB_END = ''1'' ' +
                           WhereStr +
                         ' UNION ALL ' +
                         'SELECT ''14H'' AS JOB_HOUR ' +
                             ' , SUM(CASE WHEN JOBD = ''1'' THEN 1 ELSE 0 END) AS IN_CNT ' +
                             ' , SUM(CASE WHEN JOBD = ''2'' THEN 1 ELSE 0 END) AS OT_CNT ' +
                          ' FROM TT_HISTORY ' +
                         ' WHERE HIS_TIME BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD', dtDateFr.Date) + ' 14:00:00') +
                                            ' AND ' + QuotedStr(FormatdateTime('YYYY-MM-DD', dtDateFr.Date) + ' 14:59:59') +
                           ' AND JOB_END = ''1'' ' +
                           WhereStr +
                         ' UNION ALL ' +
                         'SELECT ''15H'' AS JOB_HOUR ' +
                             ' , SUM(CASE WHEN JOBD = ''1'' THEN 1 ELSE 0 END) AS IN_CNT ' +
                             ' , SUM(CASE WHEN JOBD = ''2'' THEN 1 ELSE 0 END) AS OT_CNT ' +
                          ' FROM TT_HISTORY ' +
                         ' WHERE HIS_TIME BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD', dtDateFr.Date) + ' 15:00:00') +
                                            ' AND ' + QuotedStr(FormatdateTime('YYYY-MM-DD', dtDateFr.Date) + ' 15:59:59') +
                           ' AND JOB_END = ''1'' ' +
                           WhereStr +
                         ' UNION ALL ' +
                         'SELECT ''16H'' AS JOB_HOUR ' +
                             ' , SUM(CASE WHEN JOBD = ''1'' THEN 1 ELSE 0 END) AS IN_CNT ' +
                             ' , SUM(CASE WHEN JOBD = ''2'' THEN 1 ELSE 0 END) AS OT_CNT ' +
                          ' FROM TT_HISTORY ' +
                         ' WHERE HIS_TIME BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD', dtDateFr.Date) + ' 16:00:00') +
                                            ' AND ' + QuotedStr(FormatdateTime('YYYY-MM-DD', dtDateFr.Date) + ' 16:59:59') +
                           ' AND JOB_END = ''1'' ' +
                           WhereStr +
                         ' UNION ALL ' +
                         'SELECT ''17H'' AS JOB_HOUR ' +
                             ' , SUM(CASE WHEN JOBD = ''1'' THEN 1 ELSE 0 END) AS IN_CNT ' +
                             ' , SUM(CASE WHEN JOBD = ''2'' THEN 1 ELSE 0 END) AS OT_CNT ' +
                          ' FROM TT_HISTORY ' +
                         ' WHERE HIS_TIME BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD', dtDateFr.Date) + ' 17:00:00') +
                                            ' AND ' + QuotedStr(FormatdateTime('YYYY-MM-DD', dtDateFr.Date) + ' 17:59:59') +
                           ' AND JOB_END = ''1'' ' +
                           WhereStr +
                         ' UNION ALL ' +
                         'SELECT ''18H'' AS JOB_HOUR ' +
                             ' , SUM(CASE WHEN JOBD = ''1'' THEN 1 ELSE 0 END) AS IN_CNT ' +
                             ' , SUM(CASE WHEN JOBD = ''2'' THEN 1 ELSE 0 END) AS OT_CNT ' +
                          ' FROM TT_HISTORY ' +
                         ' WHERE HIS_TIME BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD', dtDateFr.Date) + ' 18:00:00') +
                                            ' AND ' + QuotedStr(FormatdateTime('YYYY-MM-DD', dtDateFr.Date) + ' 18:59:59') +
                           ' AND JOB_END = ''1'' ' +
                           WhereStr +
                         ' UNION ALL ' +
                         'SELECT ''19H'' AS JOB_HOUR ' +
                             ' , SUM(CASE WHEN JOBD = ''1'' THEN 1 ELSE 0 END) AS IN_CNT ' +
                             ' , SUM(CASE WHEN JOBD = ''2'' THEN 1 ELSE 0 END) AS OT_CNT ' +
                          ' FROM TT_HISTORY ' +
                         ' WHERE HIS_TIME BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD', dtDateFr.Date) + ' 19:00:00') +
                                            ' AND ' + QuotedStr(FormatdateTime('YYYY-MM-DD', dtDateFr.Date) + ' 19:59:59') +
                           ' AND JOB_END = ''1'' ' +
                           WhereStr +
                         ' UNION ALL ' +
                         'SELECT ''20H'' AS JOB_HOUR ' +
                             ' , SUM(CASE WHEN JOBD = ''1'' THEN 1 ELSE 0 END) AS IN_CNT ' +
                             ' , SUM(CASE WHEN JOBD = ''2'' THEN 1 ELSE 0 END) AS OT_CNT ' +
                          ' FROM TT_HISTORY ' +
                         ' WHERE HIS_TIME BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD', dtDateFr.Date) + ' 20:00:00') +
                                            ' AND ' + QuotedStr(FormatdateTime('YYYY-MM-DD', dtDateFr.Date) + ' 20:59:59') +
                           ' AND JOB_END = ''1'' ' +
                           WhereStr +
                         ' UNION ALL ' +
                         'SELECT ''21H'' AS JOB_HOUR ' +
                             ' , SUM(CASE WHEN JOBD = ''1'' THEN 1 ELSE 0 END) AS IN_CNT ' +
                             ' , SUM(CASE WHEN JOBD = ''2'' THEN 1 ELSE 0 END) AS OT_CNT ' +
                          ' FROM TT_HISTORY ' +
                         ' WHERE HIS_TIME BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD', dtDateFr.Date) + ' 21:00:00') +
                                            ' AND ' + QuotedStr(FormatdateTime('YYYY-MM-DD', dtDateFr.Date) + ' 21:59:59') +
                           ' AND JOB_END = ''1'' ' +
                           WhereStr +
                         ' UNION ALL ' +
                         'SELECT ''22H'' AS JOB_HOUR ' +
                             ' , SUM(CASE WHEN JOBD = ''1'' THEN 1 ELSE 0 END) AS IN_CNT ' +
                             ' , SUM(CASE WHEN JOBD = ''2'' THEN 1 ELSE 0 END) AS OT_CNT ' +
                          ' FROM TT_HISTORY ' +
                         ' WHERE HIS_TIME BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD', dtDateFr.Date) + ' 22:00:00') +
                                            ' AND ' + QuotedStr(FormatdateTime('YYYY-MM-DD', dtDateFr.Date) + ' 22:59:59') +
                           ' AND JOB_END = ''1'' ' +
                           WhereStr +
                         ' UNION ALL ' +
                         'SELECT ''23H'' AS JOB_HOUR ' +
                             ' , SUM(CASE WHEN JOBD = ''1'' THEN 1 ELSE 0 END) AS IN_CNT ' +
                             ' , SUM(CASE WHEN JOBD = ''2'' THEN 1 ELSE 0 END) AS OT_CNT ' +
                          ' FROM TT_HISTORY ' +
                         ' WHERE HIS_TIME BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD', dtDateFr.Date) + ' 23:00:00') +
                                            ' AND ' + QuotedStr(FormatdateTime('YYYY-MM-DD', dtDateFr.Date) + ' 23:59:59') +
                           ' AND JOB_END = ''1'' ' +
                           WhereStr +
                         ' UNION ALL ' +
                         'SELECT ''합계'' AS JOB_HOUR ' +
                             ' , SUM(CASE WHEN JOBD = ''1'' THEN 1 ELSE 0 END) AS IN_CNT ' +
                             ' , SUM(CASE WHEN JOBD = ''2'' THEN 1 ELSE 0 END) AS OT_CNT ' +
                          ' FROM TT_HISTORY ' +
                         ' WHERE HIS_TIME BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD', dtDateFr.Date) + ' 08:00:00') +
                                            ' AND ' + QuotedStr(FormatdateTime('YYYY-MM-DD', dtDateFr.Date) + ' 23:59:59') +
                           ' AND JOB_END = ''1'' ' +
                           WhereStr +
                         ' ) as A ' ;
      SQL.Text := StrSQL;
      Open;
    end;
  except
    on E : Exception do
    begin
      qryInfo1.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'fnInfo1', '조회', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnInfo1 Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;

//==============================================================================
// fnInfo2  일간 입고 실적
//==============================================================================
procedure TfrmU410.fnInfo2;
var
  StrSQL : String;
  WhereStr : String;
begin
  try
    WhereStr := '';
    if (rgType.ItemIndex = 1) then
    begin
      WhereStr := WhereStr + ' AND ITM_CD = ' + QuotedStr('FULL');
    end else
    if (rgType.ItemIndex = 2) then
    begin
      WhereStr := WhereStr + ' AND ITM_CD = ' + QuotedStr('EPLT');
    end else
    if (rgType.ItemIndex = 3) then
    begin
      WhereStr := WhereStr + ' AND ITM_CD not in (''FULL'', ''EPLT'') ';
    end;

    if (Trim(edtModelNo.Text) <> '') then
    begin
      WhereStr := WhereStr + ' AND UPPER(RF_MODEL_NO1) like ' + QuotedStr('%' + Trim(UpperCase(edtModelNo.Text)) + '%');
    end;


    with qryInfo2 do
    begin
      Close;
      SQL.Clear;
      StrSQL   := ' Select REG_TIME, LUGG, JOBD, LINE_NO,             ' +  #13#10+
                  '        SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL,        ' +  #13#10+
                  '        DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL,        ' +  #13#10+
                  '        NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS,    ' +  #13#10+
                  '        JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD, ' +  #13#10+
                  '        CVFR, CVTO, CVCURR, ETC, EMG, ITM_CD,      ' +  #13#10+
                  '       (Case JOBD  when ''1'' then ''입고'' ' +  #13#10+
                  '                   when ''2'' then ''출고'' end) as JOBD_DESC, ' +  #13#10+
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
                  '       (SUBSTRING(DSTAISLE,4,1)+''-''+SUBSTRING(DSTBAY,3,2)+''-''+SUBSTRING(DSTLEVEL,3,2)) as ID_CODE, ' +  #13#10+
                  '       (SUBSTRING(REG_TIME,1,4)+''-''+SUBSTRING(REG_TIME,5,2)+''-''+SUBSTRING(REG_TIME,7,2)+''  ''+ ' +  #13#10+
                  '        SUBSTRING(REG_TIME,9,2)+'':''+SUBSTRING(REG_TIME,11,2)+'':''+SUBSTRING(REG_TIME,13,2)) as REG_TIME_CONV, ' +  #13#10+
                  '        CONVERT(VARCHAR, REG_TIME, 120) as REG_TIME_DESC, ' +
                  '        RF_LINE_NAME1, RF_LINE_NAME2, RF_PALLET_NO1, RF_PALLET_NO2, RF_MODEL_NO1, ' +
                  '        RF_MODEL_NO2, RF_BMA_NO, RF_PALLET_BMA1, RF_PALLET_BMA2, RF_PALLET_BMA3,  ' +
                  '        RF_AREA, RF_NEW_BMA  ' +
                  '   From TT_HISTORY as A ' +  #13#10+
                  '  Where JOBD    = ''1'' ' +  #13#10+
                  '    And JOB_END = ''1'' ' +
                  '    And HIS_TIME BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD', dtDateFr.Date) + ' 00:00:00') +
                                  ' AND ' + QuotedStr(FormatdateTime('YYYY-MM-DD', dtDateFr.Date) + ' 23:59:59') +
                  WhereStr ;
                  StrSQL := StrSQL + '  Order By REG_TIME, LUGG ' ;
      SQL.Text := StrSQL ;
      Open;
    end;
  except
    on E : Exception do
    begin
      qryInfo2.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'fnInfo2', '조회', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnInfo2 Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;

//==============================================================================
// fnInfo3  일간 출고 실적
//==============================================================================
procedure TfrmU410.fnInfo3;
var
  StrSQL : String;
  WhereStr : String;
begin
  try
    WhereStr := '';
    if (rgType.ItemIndex = 1) then
    begin
      WhereStr := WhereStr + ' AND ITM_CD = ' + QuotedStr('FULL');
    end else
    if (rgType.ItemIndex = 2) then
    begin
      WhereStr := WhereStr + ' AND ITM_CD = ' + QuotedStr('EPLT');
    end else
    if (rgType.ItemIndex = 3) then
    begin
      WhereStr := WhereStr + ' AND ITM_CD not in (''FULL'', ''EPLT'') ';
    end;

    if (Trim(edtModelNo.Text) <> '') then
    begin
      WhereStr := WhereStr + ' AND UPPER(RF_MODEL_NO1) like ' + QuotedStr('%' + Trim(UpperCase(edtModelNo.Text)) + '%');
    end;


    with qryInfo3 do
    begin
      Close;
      SQL.Clear;
      StrSQL   := ' Select REG_TIME, LUGG, JOBD, LINE_NO,             ' +  #13#10+
                  '        SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL,        ' +  #13#10+
                  '        DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL,        ' +  #13#10+
                  '        NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS,    ' +  #13#10+
                  '        JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD, ' +  #13#10+
                  '        CVFR, CVTO, CVCURR, ETC, EMG, ITM_CD,      ' +  #13#10+
                  '       (Case JOBD  when ''1'' then ''입고'' ' +  #13#10+
                  '                   when ''2'' then ''출고'' end) as JOBD_DESC, ' +  #13#10+
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
                  '       (SUBSTRING(DSTAISLE,4,1)+''-''+SUBSTRING(DSTBAY,3,2)+''-''+SUBSTRING(DSTLEVEL,3,2)) as ID_CODE, ' +  #13#10+
                  '       (SUBSTRING(REG_TIME,1,4)+''-''+SUBSTRING(REG_TIME,5,2)+''-''+SUBSTRING(REG_TIME,7,2)+''  ''+ ' +  #13#10+
                  '        SUBSTRING(REG_TIME,9,2)+'':''+SUBSTRING(REG_TIME,11,2)+'':''+SUBSTRING(REG_TIME,13,2)) as REG_TIME_CONV, ' +  #13#10+
                  '        CONVERT(VARCHAR, REG_TIME, 120) as REG_TIME_DESC, ' +
                  '        RF_LINE_NAME1, RF_LINE_NAME2, RF_PALLET_NO1, RF_PALLET_NO2, RF_MODEL_NO1, ' +
                  '        RF_MODEL_NO2, RF_BMA_NO, RF_PALLET_BMA1, RF_PALLET_BMA2, RF_PALLET_BMA3,  ' +
                  '        RF_AREA, RF_NEW_BMA  ' +
                  '   From TT_HISTORY as A ' +  #13#10+
                  '  Where JOBD    = ''2'' ' +  #13#10+
                  '    And JOB_END = ''1'' ' +
                  '    And HIS_TIME BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD', dtDateFr.Date) + ' 00:00:00') +
                                  ' AND ' + QuotedStr(FormatdateTime('YYYY-MM-DD', dtDateFr.Date) + ' 23:59:59') +
                  WhereStr ;
                  StrSQL := StrSQL + '  Order By REG_TIME, LUGG ' ;
      SQL.Text := StrSQL ;
      Open;
    end;
  except
    on E : Exception do
    begin
      qryInfo3.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'fnInfo3', '조회', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnInfo3 Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;

//==============================================================================
// SetComboBox [콤보박스 데이터 추가]
//==============================================================================
procedure TfrmU410.SetComboBox;
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
      qryInfo1.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'SetComboBox', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure SetComboBox Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// dtDateFrChange
//==============================================================================
procedure TfrmU410.dtDateTimeChange(Sender: TObject);
begin
  fnCommandQuery;
end;

//==============================================================================
// cbCodeChange
//==============================================================================
procedure TfrmU410.cbCodeChange(Sender: TObject);
begin
  fnCommandQuery;
end;

//==============================================================================
// ComboBoxChange
//==============================================================================
procedure TfrmU410.ComboBoxChange(Sender: TObject);
begin
  fnCommandQuery;
end;

//==============================================================================
// dgInfoTitleClick
//==============================================================================
procedure TfrmU410.dgInfoTitleClick(Column: TColumnEh);
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





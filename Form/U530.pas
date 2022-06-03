unit U530;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, d_MainDm, h_MainLib, h_ReferLib, StdCtrls, DB, ADODB, ExLibrary, ExVclLib,
  Grids, StrUtils, DBGrids, comobj, frxClass, frxDBSet, DBGridEhGrouping, EhLibADO,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,DBGridEhImpExp,
  DBGridEh, Vcl.Mask, Vcl.DBCtrls, DBCtrlsEh, PrnDbgeh, Vcl.Buttons,
  Vcl.ComCtrls ;

type
  TfrmU530 = class(TForm)
    Pnl_Top: TPanel;
    GroupBox1: TGroupBox;
    Label31: TLabel;
    dtDateFr: TDateTimePicker;
    dtTimeFr: TDateTimePicker;
    dtDateTo: TDateTimePicker;
    dtTimeTo: TDateTimePicker;
    cbDateUse: TCheckBox;
    GroupBox4: TGroupBox;
    GroupBox2: TGroupBox;
    edtName: TEdit;
    GroupBox3: TGroupBox;
    GroupBox5: TGroupBox;
    edtMenu: TEdit;
    edtDesc: TEdit;
    cbType: TComboBox;
    Pnl_Main: TPanel;
    dgInfo: TDBGridEh;
    dsInfo: TDataSource;
    qryInfo: TADOQuery;
    qryTemp: TADOQuery;
    EhPrint: TPrintDBGridEh;
    GroupBox6: TGroupBox;
    edtRowHeight: TEdit;
    UpDown1: TUpDown;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dgInfoTitleClick(Column: TColumnEh);
    procedure KeyPress(Sender: TObject; var Key: Char);
    procedure cbTypeClick(Sender: TObject);
    procedure DatePickerKeyPress(Sender: TObject; var Key: Char);
    procedure edtRowHeightChange(Sender: TObject);
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
  procedure U530Create();

const
  FormNo ='530';
var
  frmU530: TfrmU530;
  SrtFlag : integer = 0 ;

implementation

uses Main ;

{$R *.dfm}

//==============================================================================
// U530Create
//==============================================================================
procedure U530Create();
begin
  if not Assigned( frmU530 ) then
  begin
    frmU530 := TfrmU530.Create(Application);
    with frmU530 do
    begin
      fnCommandStart;
    end;
  end;
  frmU530.Show;
end;

//==============================================================================
// fnWmMsgRecv
//==============================================================================
procedure TfrmU530.fnWmMsgRecv(var MSG: TMessage);
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
procedure TfrmU530.FormActivate(Sender: TObject);
begin
  MainDm.M_Info.ActiveFormID := '530';
  frmMain.LblMenu000.Caption := MainDm.M_Info.ActiveFormID + '. ' + getLangMenuString(MainDm.M_Info.ActiveFormID, frmMain.LblMenu000.Caption, MainDm.M_Info.LANG_TYPE, 'N');
  frmU530.Caption := MainDm.M_Info.ActiveFormName;
  fnWmMsgSend( 22221,11111 );

  dtDateFr.Date := StrToDate(FormatDateTime('YYYY-MM-DD',Now));
  dtTimeFr.Time := StrToTime('00:00:00');

  dtDateTo.Date := StrToDate(FormatDateTime('YYYY-MM-DD',Now));
  dtTimeTo.Time := StrToTime(FormatDateTime('HH:NN:SS',Now));

  fnCommandQuery ;
end;

//==============================================================================
// FormDeactivate
//==============================================================================
procedure TfrmU530.FormDeactivate(Sender: TObject);
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
procedure TfrmU530.FormClose(Sender: TObject; var Action: TCloseAction);
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
  try frmU530 := Nil ;
  except end;
end;

//==============================================================================
// fnCommandStart
//==============================================================================
procedure TfrmU530.fnCommandStart;
begin
//
end;

//==============================================================================
// fnCommandOrder [지시]
//==============================================================================
procedure TfrmU530.fnCommandOrder  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [엑셀]
//==============================================================================
procedure TfrmU530.fnCommandExcel;
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
procedure TfrmU530.fnCommandAdd  ;
begin
//
end;

//==============================================================================
// fnCommandDelete [삭제]
//==============================================================================
procedure TfrmU530.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandUpdate [수정]                                                     //
//==============================================================================
procedure TfrmU530.fnCommandUpdate;
begin
//
end;

//==============================================================================
// fnCommandPrint [인쇄]
//==============================================================================
procedure TfrmU530.fnCommandPrint;
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
procedure TfrmU530.fnCommandQuery;
var
  WhereStr, StrSQL : String;
  TmpDate1, TmpDate2, TmpTime1, TmpTime2 : String;
begin
  WhereStr := '' ;

  // 메뉴코드/명
  if (Trim(edtMenu.Text) <> '') then
    WhereStr := WhereStr + ' AND (UPPER(H.MENU_ID  ) LIKE ' + QuotedStr('%'+UpperCase(edtMenu.Text)+'%') + ' OR ' +
                           '      UPPER(M.MENU_NAME) LIKE ' + QuotedStr('%'+UpperCase(edtMenu.Text)+'%') + ' ) ' ;

  // 이벤트타입
  if (cbType.ItemIndex > 0) then
    WhereStr := WhereStr + ' AND H.HIST_TYPE = ' + QuotedStr(Copy(cbType.Text,1,1)) ;

  // 이벤트명
  if (Trim(edtName.Text) <> '') then
    WhereStr := WhereStr + ' AND UPPER(H.EVENT_NAME) LIKE ' + QuotedStr('%'+UpperCase(edtName.Text)+'%');

  // 이벤트정보
  if (Trim(edtDesc.Text) <> '') then
    WhereStr := WhereStr + ' AND UPPER(H.EVENT_DESC) LIKE ' + QuotedStr('%'+UpperCase(edtDesc.Text)+'%');

  // 완료일시
  TmpDate1 := FormatDateTime('YYYY-MM-DD'   , dtDateFr.Date);
  TmpTime1 := FormatDateTime(' HH:NN:SS.ZZZ', dtTimeFr.Time);

  TmpDate2 := FormatDateTime('YYYY-MM-DD'   , dtDateTo.Date);
  TmpTime2 := FormatDateTime(' HH:NN:SS.ZZZ', dtTimeTo.Time);

  WhereStr := WhereStr + ' AND H.CRT_DT BETWEEN ''' + TmpDate1 + TmpTime1 + ''' ' +
                         '                  AND ''' + TmpDate2 + TmpTime2 + ''' ' ;
  try
    with qryInfo do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' SELECT H.SEQ, H.CRT_DT, H.MENU_ID, H.HIST_TYPE, H.PGM_FUNCTION, ' +
                '        H.EVENT_NAME, H.EVENT_DESC, H.COMMAND_TYPE, ' +
                '        H.COMMAND_TEXT, H.PARAM, H.ERROR_MSG, H.USER_ID, ' +
                '        M.MENU_NAME, ' +
                '        CONVERT(VARCHAR(19), H.CRT_DT, 20) AS CRT_DT_DESC ' +
                '   FROM TT_SYSTEM_HIST H WITH (NOLOCK) ' +
                '   LEFT JOIN TM_MENU M WITH (NOLOCK) ' +
                '     ON REPLACE(REPLACE(H.MENU_ID,''['',''''),'']'','''') = M.MENU_ID ' +
                '  WHERE 1 = 1 ' + WhereStr +
                '  ORDER BY H.CRT_DT DESC ';
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
procedure TfrmU530.fnCommandClose;
begin
  Close;
end;

//==============================================================================
// fnCommandLang [언어]                                                       //
//==============================================================================
procedure TfrmU530.fnCommandLang;
begin
//
end;

//==============================================================================
// dgInfoTitleClick
//==============================================================================
procedure TfrmU530.dgInfoTitleClick(Column: TColumnEh);
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
// edtRowHeightChange
//==============================================================================
procedure TfrmU530.edtRowHeightChange(Sender: TObject);
begin
  dgInfo.RowLines := StrToIntDef((Sender as TEdit).Text,0);
end;

//==============================================================================
// KeyPress
//==============================================================================
procedure TfrmU530.KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    fnCommandQuery;
  end else
  if (Key = #27) then
  begin
    (Sender as TEdit).Text := '';
  end;
end;

//==============================================================================
// cbTypeClick
//==============================================================================
procedure TfrmU530.cbTypeClick(Sender: TObject);
begin
  fnCommandQuery;
end;

//==============================================================================
// DatePickerKeyPress
//==============================================================================
procedure TfrmU530.DatePickerKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) then
  begin
    fnCommandQuery;
  end else
  if (Key = #27) then
  begin
    Case (Sender as TDateTimePicker).Tag of
      0 : (Sender as TDateTimePicker).Date := Now;
      1 : (Sender as TDateTimePicker).Time := StrToTime('00:00:00.000');
      2 : (Sender as TDateTimePicker).Time := StrToTime('23:59:59.999');
    end;
  end;
end;

end.

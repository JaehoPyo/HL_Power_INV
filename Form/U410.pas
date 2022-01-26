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
    qryInfo: TADOQuery;
    dsInfo: TDataSource;
    EhPrint: TPrintDBGridEh;
    Pnl_Top: TPanel;
    Pnl_Main: TPanel;
    dgInfo: TDBGridEh;
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
    procedure fnCommandNew;
    procedure fnCommandExcel;
    procedure fnCommandDelete;
    procedure fnCommandPrint;
    procedure fnCommandQuery;
    procedure fnCommandClose;
    procedure fnWmMsgRecv (var MSG : TMessage) ; message WM_USER ;

    procedure  SetComboBox;
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
procedure TfrmU410.FormActivate(Sender: TObject);
begin
  frmMain.PnlMainMenu.Caption := (Sender as TForm).Caption ;
  fnWmMsgSend( 21211,111 );

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

  for i := 0 to Self.ComponentCount-1 Do
  begin
    if (Self.Components[i] is TADOQuery) then
       (Self.Components[i] as TADOQuery).Active := False ;
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
// fnCommandNew [신규]
//==============================================================================
procedure TfrmU410.fnCommandNew  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [엑셀]
//==============================================================================
procedure TfrmU410.fnCommandExcel;
begin
  hlbEhgridListExcel ( dgInfo , frmU410.Caption + '_' + FormatDatetime('YYYYMMDDHHNN', Now) );
  MessageDlg('엑셀 저장을 완료하였습니다.', mtConfirmation, [mbYes], 0);
end;

//==============================================================================
// fnCommandDelete [삭제]
//==============================================================================
procedure TfrmU410.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandPrint [인쇄]
//==============================================================================
procedure TfrmU410.fnCommandPrint;
begin
  if not qryInfo.Active then Exit;
  EhPrint.PrinterSetupDialog;
  EhPrint.Preview;
end;

//==============================================================================
// fnCommandQuery
//==============================================================================
procedure TfrmU410.fnCommandQuery;
var
  StrSQL : String;
begin
  try
    with qryInfo do
    begin
      Close;
      SQL.Clear;
      StrSQL   := ' Select REG_TIME, LUGG, JOBD,                      ' +  #13#10+
                  '        SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL        ' +  #13#10+
                  '        DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL        ' +  #13#10+
                  '        NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS    ' +  #13#10+
                  '        JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD ' +  #13#10+
                  '        CVFR, CVTO, CVCURR, ETC, EMG, ITM_CD,      ' +  #13#10+
                  '       (Case JOBD  when ''1'' then ''입고'' ' +  #13#10+
                  '                   when ''2'' then ''출고'' end) as JOBD_DESC, ' +  #13#10+
                  '       (Case NOWMC when ''1'' then ''컨베어 작업'' ' +  #13#10+
                  '                   when ''2'' then ''스태커 적재'' ' +  #13#10+
                  '                   when ''3'' then ''스태커 하역'' end) as NOWMC_DESC, ' +  #13#10+
                  '       (Case NOWSTATUS when ''1'' then ''등록'' ' +  #13#10+
                  '                       when ''2'' then ''지시'' ' +  #13#10+
                  '                       when ''3'' then ''진행'' ' +  #13#10+
                  '                       when ''4'' then ''완료'' end) as NOWSTATUS_DESC, ' +  #13#10+
                  '       (Case JOBERRORC when ''''  then ''정상'' ' +  #13#10+
                  '                       when ''0'' then ''정상'' ' +  #13#10+
                  '                       when NULL  then ''정상'' ' +  #13#10+
                  '                       when ''1'' then ''에러'' ' +  #13#10+
                  '                       else ''정상'' end) as JOBERRORC_DESC, ' +  #13#10+
                  '       (Case JOBERRORD when ''0000'' then ''정상'' ' +  #13#10+
                  '                       else JOBERRORD end) as JOBERRORD_DESC, ' +  #13#10+
                  '       (Case BUFFSTATUS when ''0'' then ''대기'' ' +  #13#10+
                  '                        when ''1'' then ''입고가능'' end) as BUFFSTATUS_DESC, ' +  #13#10+
                  '       (SUBSTR(DSTAISLE,4,1)||''-''||SUBSTR(DSTBAY,3,2)||''-''||SUBSTR(DSTLEVEL,3,2)) as ID_CODE, ' +  #13#10+
                  '       (SUBSTR(REG_TIME,1,4)||''-''||SUBSTR(REG_TIME,5,2)||''-''||SUBSTR(REG_TIME,7,2)||''  ''|| ' +  #13#10+
                  '        SUBSTR(REG_TIME,9,2)||'':''||SUBSTR(REG_TIME,11,2)||'':''||SUBSTR(REG_TIME,13,2)) as REF_TIME_CONV, ' +  #13#10+
                  '       TO_DATE(REG_TIME,''YYYYMMDDHH24MISS'') as REG_TIME_DESC ' +
                  '   From TT_HISTORY ' +  #13#10+
                  '  Where JOBD    = ''1'' ' +  #13#10+
                  '    And JOB_END = ''1'' ' ;

                  if (Trim(cbCode.Text)<>'') and (Trim(cbCode.Text)<>'전체') then
                    StrSQL := StrSQL + ' And ITM_CD= ' + QuotedStr(Trim(cbCode.Text)) ;

                  if (Trim(ComboBoxBank.Text)<>'') and (Trim(ComboBoxBank.Text)<>'전체') then
                    StrSQL := StrSQL + ' And DSTAISLE= ' + QuotedStr(FormatFloat('0000',StrToInt(Trim(ComboBoxBank.Text)))) ;

                  if (Trim(ComboBoxBay.Text)<>'') and (Trim(ComboBoxBay.Text)<>'전체') then
                    StrSQL := StrSQL + ' And DSTBAY= ' + QuotedStr(FormatFloat('0000',StrToInt(Trim(ComboBoxBay.Text)))) ;

                  if (Trim(ComboBoxLevel.Text)<>'') and (Trim(ComboBoxLevel.Text)<>'전체') then
                    StrSQL := StrSQL + ' And DSTLEVEL= ' + QuotedStr(FormatFloat('0000',StrToInt(Trim(ComboBoxLevel.Text)))) ;

                  if cbDateUse.Checked then
                    StrSQL := StrSQL + ' And REG_TIME BetWeen ' +
                                       '      '''+FormatDateTime('YYYYMMDD', dtDateFr.Date)+''+FormatDateTime('HHNNSS', dtTimeFr.Time)+''' '+
                                       '  And '''+FormatDateTime('YYYYMMDD', dtDateTo.Date)+''+FormatDateTime('HHNNSS', dtTimeTo.Time)+''' ';

                  StrSQL := StrSQL + '  Order By REG_TIME, LUGG ' ;
      SQL.Text := StrSQL ;
      Open;
    end;
  except
    if qryInfo.Active then qryInfo.Close;
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
    if qryTemp.Active then qryTemp.Close;
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





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
    procedure fnCommandNew;
    procedure fnCommandExcel;
    procedure fnCommandDelete;
    procedure fnCommandPrint;
    procedure fnCommandQuery;
    procedure fnCommandClose;
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

uses Main ;

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
procedure TfrmU320.FormActivate(Sender: TObject);
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
procedure TfrmU320.FormDeactivate(Sender: TObject);
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
// fnCommandNew [신규]
//==============================================================================
procedure TfrmU320.fnCommandNew  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [엑셀]
//==============================================================================
procedure TfrmU320.fnCommandExcel;
begin
  hlbEhgridListExcel ( dgInfo , frmU320.Caption + '_' + FormatDatetime('YYYYMMDDHHNN', Now) );
  MessageDlg('엑셀 저장을 완료하였습니다.', mtConfirmation, [mbYes], 0)
end;

//==============================================================================
// fnCommandDelete [삭제]
//==============================================================================
procedure TfrmU320.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandPrint [인쇄]
//==============================================================================
procedure TfrmU320.fnCommandPrint;
begin
  if not qryInfo.Active then Exit;
  EhPrint.PrinterSetupDialog;
  EhPrint.Preview;
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
                '        ID_ZONE, ID_STATUS, ID_MEMO, OT_USED, IN_USED, ' +
                '       (Case ID_STATUS when ''0'' then ''공셀''     ' +
                '                       when ''1'' then ''공파레트'' ' +
                '                       when ''2'' then ''실셀''     ' +
                '                       when ''3'' then ''금지셀''   ' +
                '                       when ''4'' then ''입고예약'' ' +
                '                       when ''5'' then ''출고예약'' ' +
                '                       when ''6'' then ''이중입고'' ' +
                '                       when ''7'' then ''공출고'' end) as ID_STATUS_DESC, ' +
                '       (SUBSTR(ID_CODE,1,1)||''-''||SUBSTR(ID_CODE,2,2)||''-''||SUBSTR(ID_CODE,4,2)) as ID_CODE_DESC ' +
                '   From TT_STOCK ' +
                '  Where 1=1 ' ;


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
    if qryTemp.Active then qryTemp.Close;
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





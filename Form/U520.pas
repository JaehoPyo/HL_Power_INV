unit U520;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, d_MainDm, h_MainLib, h_ReferLib, StdCtrls, DB, ADODB, ExLibrary, ExVclLib,
  Grids, StrUtils, DBGrids, comobj, frxClass, frxDBSet, DBGridEhGrouping, EhLibADO,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,DBGridEhImpExp,
  DBGridEh, Vcl.Mask, Vcl.DBCtrls, DBCtrlsEh, PrnDbgeh, Vcl.Buttons,
  Vcl.ComCtrls ;

type
  TfrmU520 = class(TForm)
    qryTemp: TADOQuery;
    qryInfo: TADOQuery;
    dsInfo: TDataSource;
    EhPrint: TPrintDBGridEh;
    Pnl_Main: TPanel;
    dgInfo: TDBGridEh;
    Pnl_Top: TPanel;
    GroupBox1: TGroupBox;
    Label31: TLabel;
    dtDateFr: TDateTimePicker;
    dtTimeFr: TDateTimePicker;
    dtDateTo: TDateTimePicker;
    dtTimeTo: TDateTimePicker;
    cbDateUse: TCheckBox;
    gbCode: TGroupBox;
    cbCode: TComboBox;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dtDateTimeChange(Sender: TObject);
    procedure cbCodeChange(Sender: TObject);
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
  procedure U520Create();

const
  FormNo ='520';
var
  frmU520: TfrmU520;
  SrtFlag : integer = 0 ;

implementation

uses Main ;

{$R *.dfm}

//==============================================================================
// U230Create
//==============================================================================
procedure U520Create();
begin
  if not Assigned( frmU520 ) then
  begin
    frmU520 := TfrmU520.Create(Application);
    with frmU520 do
    begin
      fnCommandStart;
    end;
  end;
  frmU520.Show;
end;

//==============================================================================
// fnWmMsgRecv
//==============================================================================
procedure TfrmU520.fnWmMsgRecv(var MSG: TMessage);
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
procedure TfrmU520.FormActivate(Sender: TObject);
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
procedure TfrmU520.FormDeactivate(Sender: TObject);
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
procedure TfrmU520.FormClose(Sender: TObject; var Action: TCloseAction);
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
  try frmU520 := Nil ;
  except end;
end;

//==============================================================================
// fnCommandStart
//==============================================================================
procedure TfrmU520.fnCommandStart;
begin
//
end;

//==============================================================================
// fnCommandNew [신규]
//==============================================================================
procedure TfrmU520.fnCommandNew  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [엑셀]
//==============================================================================
procedure TfrmU520.fnCommandExcel;
begin
  hlbEhgridListExcel ( dgInfo , frmU520.Caption + '_' + FormatDatetime('YYYYMMDDHHNN', Now) );
  MessageDlg('엑셀 저장을 완료하였습니다.', mtConfirmation, [mbYes], 0);
end;

//==============================================================================
// fnCommandDelete [삭제]
//==============================================================================
procedure TfrmU520.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandPrint [인쇄]
//==============================================================================
procedure TfrmU520.fnCommandPrint;
begin
  if not qryInfo.Active then Exit;
  EhPrint.PrinterSetupDialog;
  EhPrint.Preview;
end;

//==============================================================================
// fnCommandQuery
//==============================================================================
procedure TfrmU520.fnCommandQuery;
var
  StrSQL : String;
begin
  try
    with qryInfo do
    begin
      Close;
      SQL.Clear;
      StrSQL   := ' Select ERR_DEV, ERR_DEVNO, ERR_CODE,                   ' +  #13#10+
                  '        ERR_NAME, ERR_DESC, CR_DATE,                     ' +  #13#10+
                  '       (Case ERR_DEV when ''SC'' then ''스태커크레인''  ' +  #13#10+
                  '                     else ERR_DEV end) as ERR_DEV_DESC  ' +  #13#10+

                  '   From TT_ERROR ' +  #13#10+
                  '  Where 1=1 ';

                  if (Trim(cbCode.Text)<>'') and (Trim(cbCode.Text)<>'전체') then
                    StrSQL := StrSQL + ' And ERR_CODE= ' + QuotedStr(Trim(Copy(cbCode.Text,1,4))) ;


                  if cbDateUse.Checked then
                    StrSQL := StrSQL + ' And TRIM(TO_CHAR(CR_DATE,''YYYYMMDDHH24MISS'')) BetWeen ' +
                                       '      '''+FormatDateTime('YYYYMMDD', dtDateFr.Date)+''+FormatDateTime('HHNNSS', dtTimeFr.Time)+''' '+
                                       '  And '''+FormatDateTime('YYYYMMDD', dtDateTo.Date)+''+FormatDateTime('HHNNSS', dtTimeTo.Time)+''' ';

                  StrSQL := StrSQL + '  Order By CR_DATE ' ;
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
procedure TfrmU520.fnCommandClose;
begin
  Close;
end;

//==============================================================================
// SetComboBox [콤보박스 데이터 추가]
//==============================================================================
procedure TfrmU520.SetComboBox;
var
  StrSQL : String;
begin
  try
    cbCode.Clear ;
    cbCode.Items.Add('전체');
    cbCode.ItemIndex := 0;

    StrSQL := ' Select ERR_CODE, ERR_NAME From TM_ERROR ' +
              '  Order By ERR_CODE ' ;

    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open ;
      First;

      while not(Eof) do
      begin
        cbCode.Items.Add((FieldByName('ERR_CODE').AsString) +
                         ' : ' +
                         (FieldByName('ERR_NAME').AsString) );
        Next ;
      end;

    end;
  except
    if qryTemp.Active then qryTemp.Close;
  end;
end;

//==============================================================================
// dtDateTimeChange
//==============================================================================
procedure TfrmU520.dtDateTimeChange(Sender: TObject);
begin
  fnCommandQuery;
end;

//==============================================================================
// cbCodeChange
//==============================================================================
procedure TfrmU520.cbCodeChange(Sender: TObject);
begin
  fnCommandQuery;
end;

//==============================================================================
// dgInfoTitleClick
//==============================================================================
procedure TfrmU520.dgInfoTitleClick(Column: TColumnEh);
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





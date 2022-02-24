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
    MSG_MDI_WIN_ORDER   : begin fnCommandOrder   ; end;           // MSG_MDI_WIN_ORDER   = 11 ; // Áö½Ã
    MSG_MDI_WIN_ADD     : begin fnCommandAdd     ; end;           // MSG_MDI_WIN_ADD     = 12 ; // ½Å±Ô
    MSG_MDI_WIN_DELETE  : begin fnCommandDelete  ; end;           // MSG_MDI_WIN_DELETE  = 13 ; // »èÁ¦
    MSG_MDI_WIN_UPDATE  : begin fnCommandUpdate  ; end;           // MSG_MDI_WIN_UPDATE  = 14 ; // ¼öÁ¤
    MSG_MDI_WIN_EXCEL   : begin fnCommandExcel   ; end;           // MSG_MDI_WIN_EXCEL   = 15 ; // ¿¢¼¿
    MSG_MDI_WIN_PRINT   : begin fnCommandPrint   ; end;           // MSG_MDI_WIN_PRINT   = 16 ; // ÀÎ¼â
    MSG_MDI_WIN_QUERY   : begin fnCommandQuery   ; end;           // MSG_MDI_WIN_QUERY   = 17 ; // Á¶È¸
    MSG_MDI_WIN_CLOSE   : begin fnCommandClose   ; Close; end;    // MSG_MDI_WIN_CLOSE   = 20 ; // ´Ý±â
    MSG_MDI_WIN_LANG    : begin fnCommandLang    ; end;           // MSG_MDI_WIN_LANG    = 21 ; // ¾ð¾î
  end;
end;

//==============================================================================
// FormActivate
//==============================================================================
procedure TfrmU520.FormActivate(Sender: TObject);
begin
  MainDm.M_Info.ActiveFormID := '520';
  frmMain.LblMenu000.Caption := MainDm.M_Info.ActiveFormID + '. ' + getLangMenuString(MainDm.M_Info.ActiveFormID, frmMain.LblMenu000.Caption, MainDm.M_Info.LANG_TYPE, 'N');
  frmU520.Caption := MainDm.M_Info.ActiveFormName;
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
procedure TfrmU520.FormDeactivate(Sender: TObject);
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
// fnCommandOrder [Áö½Ã]
//==============================================================================
procedure TfrmU520.fnCommandOrder  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [¿¢¼¿]
//==============================================================================
procedure TfrmU520.fnCommandExcel;
begin
  try
    if hlbEhgridListExcel(dgInfo, frmMain.LblMenu000.Caption + '_' + FormatDatetime('YYYYMMDD', Now)) then
    begin
      MessageDlg('¿¢¼¿ ÀúÀåÀ» ¿Ï·áÇÏ¿´½À´Ï´Ù.', mtConfirmation, [mbYes], 0);
    end else
    begin
      MessageDlg('¿¢¼¿ ÀúÀåÀ» ½ÇÆÐÇÏ¿´½À´Ï´Ù.', mtWarning, [mbYes], 0);
    end;
  except
    on E : Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'fnCommandExcel', '¿¢¼¿', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnCommandExcel Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// fnCommandAdd [½Å±Ô]                                                        //
//==============================================================================
procedure TfrmU520.fnCommandAdd  ;
begin
//
end;

//==============================================================================
// fnCommandDelete [»èÁ¦]
//==============================================================================
procedure TfrmU520.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandUpdate [¼öÁ¤]                                                     //
//==============================================================================
procedure TfrmU520.fnCommandUpdate;
begin
//
end;

//==============================================================================
// fnCommandPrint [ÀÎ¼â]
//==============================================================================
procedure TfrmU520.fnCommandPrint;
begin
  try
    if not qryInfo.Active then Exit;
    fnCommandQuery;
    EhPrint.DBGridEh := dgInfo;
    EhPrint.PageHeader.LeftText.Clear;
    EhPrint.PageHeader.LeftText.Add(Copy(MainDm.M_Info.ActiveFormName, 6,
                                    Length(MainDm.M_Info.ActiveFormName)-5) );
    EhPrint.PageHeader.Font.Name := 'µ¸¿ò';
    EhPrint.PageHeader.Font.Size := 10;
    EhPrint.PageFooter.RightText.Clear;
    EhPrint.PageFooter.RightText.Add(FormatDateTime('YYYY-MM-DD HH:NN:SS', Now) + '   ' +
                                     MainDM.M_Info.UserCode+' / '+MainDM.M_Info.UserName);
    EhPrint.PageFooter.Font.Name := 'µ¸¿ò';
    EhPrint.PageFooter.Font.Size := 10;

    EhPrint.Preview;
  except
    on E : Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'fnCommandPrint', 'ÀÎ¼â', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnCommandPrint Fail || ERR['+E.Message+']');
    end;
  end;
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
                  '       (Case ERR_DEV when ''SC'' then ''½ºÅÂÄ¿Å©·¹ÀÎ''  ' +  #13#10+
                  '                     else ERR_DEV end) as ERR_DEV_DESC  ' +  #13#10+

                  '   From TT_ERROR ' +  #13#10+
                  '  Where 1=1 ';

                  if (Trim(cbCode.Text)<>'') and (Trim(cbCode.Text)<>'ÀüÃ¼') then
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
    on E : Exception do
    begin
      qryInfo.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'fnCommandQuery', 'Á¶È¸', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnCommandQuery Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
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
// fnCommandLang [¾ð¾î]                                                       //
//==============================================================================
procedure TfrmU520.fnCommandLang;
begin
//
end;

//==============================================================================
// SetComboBox [ÄÞº¸¹Ú½º µ¥ÀÌÅÍ Ãß°¡]
//==============================================================================
procedure TfrmU520.SetComboBox;
var
  StrSQL : String;
begin
  try
    cbCode.Clear ;
    cbCode.Items.Add('ÀüÃ¼');
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
    on E : Exception do
    begin
      qryTemp.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'SetComboBox', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure SetComboBox Fail || ERR['+E.Message+']');
    end;
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





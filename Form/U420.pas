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
    gbCode: TGroupBox;
    cbCode: TComboBox;
    gbCell: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ComboBoxBank: TComboBox;
    ComboBoxBay: TComboBox;
    ComboBoxLevel: TComboBox;
    dgInfo: TDBGridEh;
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

    procedure SetComboBox;
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
    MSG_MDI_WIN_ORDER   : begin fnCommandOrder   ; end;           // MSG_MDI_WIN_ORDER   = 11 ; // ����
    MSG_MDI_WIN_ADD     : begin fnCommandAdd     ; end;           // MSG_MDI_WIN_ADD     = 12 ; // �ű�
    MSG_MDI_WIN_DELETE  : begin fnCommandDelete  ; end;           // MSG_MDI_WIN_DELETE  = 13 ; // ����
    MSG_MDI_WIN_UPDATE  : begin fnCommandUpdate  ; end;           // MSG_MDI_WIN_UPDATE  = 14 ; // ����
    MSG_MDI_WIN_EXCEL   : begin fnCommandExcel   ; end;           // MSG_MDI_WIN_EXCEL   = 15 ; // ����
    MSG_MDI_WIN_PRINT   : begin fnCommandPrint   ; end;           // MSG_MDI_WIN_PRINT   = 16 ; // �μ�
    MSG_MDI_WIN_QUERY   : begin fnCommandQuery   ; end;           // MSG_MDI_WIN_QUERY   = 17 ; // ��ȸ
    MSG_MDI_WIN_CLOSE   : begin fnCommandClose   ; Close; end;    // MSG_MDI_WIN_CLOSE   = 20 ; // �ݱ�
    MSG_MDI_WIN_LANG    : begin fnCommandLang    ; end;           // MSG_MDI_WIN_LANG    = 21 ; // ���
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
// fnCommandOrder [����]
//==============================================================================
procedure TfrmU420.fnCommandOrder  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [����]
//==============================================================================
procedure TfrmU420.fnCommandExcel;
begin
  try
    if hlbEhgridListExcel(dgInfo, frmMain.LblMenu000.Caption + '_' + FormatDatetime('YYYYMMDD', Now)) then
    begin
      MessageDlg('���� ������ �Ϸ��Ͽ����ϴ�.', mtConfirmation, [mbYes], 0);
    end else
    begin
      MessageDlg('���� ������ �����Ͽ����ϴ�.', mtWarning, [mbYes], 0);
    end;
  except
    on E : Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'fnCommandExcel', '����', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnCommandExcel Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// fnCommandAdd [�ű�]                                                        //
//==============================================================================
procedure TfrmU420.fnCommandAdd  ;
begin
//
end;

//==============================================================================
// fnCommandDelete [����]
//==============================================================================
procedure TfrmU420.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandUpdate [����]                                                     //
//==============================================================================
procedure TfrmU420.fnCommandUpdate;
begin
//
end;

//==============================================================================
// fnCommandPrint [�μ�]
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
    EhPrint.PageHeader.Font.Name := '����';
    EhPrint.PageHeader.Font.Size := 10;
    EhPrint.PageFooter.RightText.Clear;
    EhPrint.PageFooter.RightText.Add(FormatDateTime('YYYY-MM-DD HH:NN:SS', Now) + '   ' +
                                     MainDM.M_Info.UserCode+' / '+MainDM.M_Info.UserName);
    EhPrint.PageFooter.Font.Name := '����';
    EhPrint.PageFooter.Font.Size := 10;

    EhPrint.Preview;
  except
    on E : Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'fnCommandPrint', '�μ�', 'Exception Error', 'PGM', '', '', E.Message);
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
                  '       (Case when (JOBD=''1'') then ''�԰�'' ' +  #13#10+
                  '             when (JOBD=''2'') and (EMG=''0'') then ''���'' ' +  #13#10+
                  '             when (JOBD=''2'') and (EMG=''1'') then ''������'' end) as JOBD_DESC, ' +  #13#10+
                  '       (Case NOWMC when ''1'' then ''������ �۾�'' ' +  #13#10+
                  '                   when ''2'' then ''����Ŀ ����'' ' +  #13#10+
                  '                   when ''3'' then ''����Ŀ �Ͽ�'' end) as NOWMC_DESC, ' +  #13#10+
                  '       (Case NOWSTATUS when ''1'' then ''���'' ' +  #13#10+
                  '                       when ''2'' then ''����'' ' +  #13#10+
                  '                       when ''3'' then ''����'' ' +  #13#10+
                  '                       when ''4'' then ''�Ϸ�'' end) as NOWSTATUS_DESC, ' +  #13#10+
                  '       (Case JOBERRORC when ''''  then ''����'' ' +  #13#10+
                  '                       when ''0'' then ''����'' ' +  #13#10+
                  '                       when NULL  then ''����'' ' +  #13#10+
                  '                       when ''1'' then ''����'' ' +  #13#10+
                  '                       else ''����'' end) as JOBERRORC_DESC, ' +  #13#10+
                  '       (Case JOBERRORD when ''0000'' then ''����'' ' +  #13#10+
                  '                       else JOBERRORD end) as JOBERRORD_DESC, ' +  #13#10+
                  '       (Case BUFFSTATUS when ''0'' then ''���'' ' +  #13#10+
                  '                        when ''1'' then ''�԰���'' end) as BUFFSTATUS_DESC, ' +  #13#10+
                  '       (SUBSTRING(SRCAISLE,4,1)+''-''+SUBSTRING(SRCBAY,3,2)+''-''+SUBSTRING(SRCLEVEL,3,2)) as ID_CODE, ' +  #13#10+
                  '       (SUBSTRING(REG_TIME,1,4)+''-''+SUBSTRING(REG_TIME,5,2)+''-''+SUBSTRING(REG_TIME,7,2)+''  ''+ ' +  #13#10+
                  '        SUBSTRING(REG_TIME,9,2)+'':''+SUBSTRING(REG_TIME,11,2)+'':''+SUBSTRING(REG_TIME,13,2)) as REF_TIME_CONV, ' +  #13#10+
                  '       CONVERT(VARCHAR, REG_TIME, 120) as REG_TIME_DESC ,' +
                  '        RF_LINE_NAME1, RF_LINE_NAME2, RF_PALLET_NO1, RF_PALLET_NO2, RF_MODEL_NO1, ' +
                  '        RF_MODEL_NO2, RF_BMA_NO, RF_PALLET_BMA1, RF_PALLET_BMA2, RF_PALLET_BMA3,  ' +
                  '        RF_AREA  ' +
                  '   From TT_HISTORY ' +  #13#10+
                  '  Where JOBD    = ''2'' ' +  #13#10+
                  '    And JOB_END = ''1'' ' ;

                  if (Trim(cbCode.Text)<>'') and (Trim(cbCode.Text)<>'��ü') then
                    StrSQL := StrSQL + ' And ITM_CD= ' + QuotedStr(Trim(cbCode.Text)) ;

                  if (Trim(ComboBoxBank.Text)<>'') and (Trim(ComboBoxBank.Text)<>'��ü') then
                    StrSQL := StrSQL + ' And SRCAISLE= ' + QuotedStr(FormatFloat('0000',StrToInt(Trim(ComboBoxBank.Text)))) ;

                  if (Trim(ComboBoxBay.Text)<>'') and (Trim(ComboBoxBay.Text)<>'��ü') then
                    StrSQL := StrSQL + ' And SRCBAY= ' + QuotedStr(FormatFloat('0000',StrToInt(Trim(ComboBoxBay.Text)))) ;

                  if (Trim(ComboBoxLevel.Text)<>'') and (Trim(ComboBoxLevel.Text)<>'��ü') then
                    StrSQL := StrSQL + ' And SRCLEVEL= ' + QuotedStr(FormatFloat('0000',StrToInt(Trim(ComboBoxLevel.Text)))) ;

                  if cbDateUse.Checked then
                    StrSQL := StrSQL + ' And REG_TIME BetWeen ' +
                                       '      '''+FormatDateTime('YYYYMMDD', dtDateFr.Date)+''+FormatDateTime('HHNNSS', dtTimeFr.Time)+''' '+
                                       '  And '''+FormatDateTime('YYYYMMDD', dtDateTo.Date)+''+FormatDateTime('HHNNSS', dtTimeTo.Time)+''' ';

                  StrSQL := StrSQL + '  Order By REG_TIME, LUGG ' ;
      SQL.Text := StrSQL;
      Open;
    end;
  except
    on E : Exception do
    begin
      qryInfo.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'fnCommandQuery', '��ȸ', 'Exception Error', 'SQL', StrSQL, '', E.Message);
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
// fnCommandLang [���]                                                       //
//==============================================================================
procedure TfrmU420.fnCommandLang;
begin
//
end;

//==============================================================================
// SetComboBox [�޺��ڽ� ������ �߰�]
//==============================================================================
procedure TfrmU420.SetComboBox;
var
  StrSQL : String;
begin
  try
    cbCode.Clear ;
    cbCode.Items.Add('��ü');
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
      qryTemp.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'SetComboBox', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure SetComboBox Fail || ERR['+E.Message+']');
    end;
  end;
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





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
    Pnl_Sub: TPanel;
    Shape2: TShape;
    btnOrder: TButton;
    Panel4: TPanel;
    Panel1: TPanel;
    Pnl_Top: TPanel;
    rgITM_YN: TRadioGroup;
    gbCode: TGroupBox;
    cbCode: TComboBox;
    gbCell: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ComboBoxBank: TComboBox;
    ComboBoxBay: TComboBox;
    ComboBoxLevel: TComboBox;
    sbtReset: TSpeedButton;
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    edtOutCode: TEdit;
    edtOutCell: TEdit;
    edtOutInDate: TEdit;
    rgEMG: TRadioGroup;
    PD_GET_JOBNO: TADOStoredProc;
    GroupBox2: TGroupBox;
    lbloutstation: TLabel;
    cbOut: TComboBox;
    dgInfo: TDBGridEh;
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

    procedure SetComboBox;
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
procedure TfrmU230.FormActivate(Sender: TObject);
begin
  MainDm.M_Info.ActiveFormID := '230';
  frmMain.LblMenu000.Caption := MainDm.M_Info.ActiveFormID + '. ' + getLangMenuString(MainDm.M_Info.ActiveFormID, frmMain.LblMenu000.Caption, MainDm.M_Info.LANG_TYPE, 'N');
  frmU230.Caption := MainDm.M_Info.ActiveFormName;
  fnWmMsgSend( 22221,11111 );

  SetComboBox ;
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
// fnCommandOrder [����]
//==============================================================================
procedure TfrmU230.fnCommandOrder  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [����]
//==============================================================================
procedure TfrmU230.fnCommandExcel;
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
procedure TfrmU230.fnCommandAdd  ;
begin
//
end;

//==============================================================================
// fnCommandDelete [����]
//==============================================================================
procedure TfrmU230.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandUpdate [����]                                                     //
//==============================================================================
procedure TfrmU230.fnCommandUpdate;
begin
//
end;

//==============================================================================
// fnCommandPrint [�μ�]
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
                '        ID_ZONE, ID_STATUS, ID_MEMO, OT_USED, IN_USED, ' +
                '       (Case ID_STATUS when ''0'' then ''����''     ' +
                '                       when ''1'' then ''���ķ�Ʈ'' ' +
                '                       when ''2'' then ''�Ǽ�''     ' +
                '                       when ''3'' then ''������''   ' +
                '                       when ''4'' then ''�԰���'' ' +
                '                       when ''5'' then ''�����'' ' +
                '                       when ''6'' then ''�����԰�'' ' +
                '                       when ''7'' then ''�����'' end) as ID_STATUS_DESC, ' +
                '       (SUBSTRING(ID_CODE,1,1)+''-''+SUBSTRING(ID_CODE,2,2)+''-''+SUBSTRING(ID_CODE,4,2)) as ID_CODE_DESC, ' +
                '        RF_LINE_NAME1, RF_LINE_NAME2, RF_PALLET_NO1, RF_PALLET_NO2, RF_MODEL_NO1, ' +
                '        RF_MODEL_NO2, RF_BMA_NO, RF_PALLET_BMA1, RF_PALLET_BMA2, RF_PALLET_BMA3,  ' +
                '        RF_AREA  ' +
                '   From TT_STOCK ' +
                '  Where 1=1 ' ;


      if (Trim(ComboBoxBank.Text)<>'') and (Trim(ComboBoxBank.Text)<>'��ü') then
        StrSQL := StrSQL + ' And ID_BANK= ' + QuotedStr(Trim(ComboBoxBank.Text)) ;

      if (Trim(ComboBoxBay.Text)<>'') and (Trim(ComboBoxBay.Text)<>'��ü') then
        StrSQL := StrSQL + ' And ID_BAY= ' + QuotedStr(Trim(ComboBoxBay.Text)) ;

      if (Trim(ComboBoxLevel.Text)<>'') and (Trim(ComboBoxLevel.Text)<>'��ü') then
        StrSQL := StrSQL + ' And ID_LEVEL= ' + QuotedStr(Trim(ComboBoxLevel.Text)) ;

      if (Trim(cbCode.Text) <> '') and (Trim(cbCode.Text) <> '��ü') then
        StrSQL := StrSQL + ' And ITM_CD Like ''%' + UpperCase(Trim(cbCode.Text)) + '%'' ' ;

      if (rgITM_YN.ItemIndex in [1,2]) then // ���� or ���ķ�Ʈ
      begin
        if (rgITM_YN.ItemIndex = 1 ) then StrSQL := StrSQL + ' And ID_STATUS= ''2'' '  // ����
        else                              StrSQL := StrSQL + ' And ID_STATUS= ''1'' ' ;// ���ķ�Ʈ
      end else StrSQL := StrSQL + ' And ID_STATUS in (''1'',''2'') ' ;

      StrSQL := StrSQL + ' And OT_USED= ''1'' ' ;

      StrSQL := StrSQL + ' Order By ID_CODE, ITM_CD, STOCK_IN_DT ' ;

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
procedure TfrmU230.fnCommandClose;
begin
  Close;
end;

//==============================================================================
// fnCommandLang [���]                                                       //
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
      edtOutCode.Text   := '[�������]';
      edtOutCell.Text   := '[�������]';
      edtOutIndate.Text := '[�������]';
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
// btnOrderClick [�������]
//==============================================================================
procedure TfrmU230.btnOrderClick(Sender: TObject);
var
  i : integer ;
begin
  try
    OrderCount := 0;
    if not qryInfo.Active then Exit;

    if cbOut.ItemIndex = 0 then
    begin
      MessageDlg('���븦 ������ �ֽʽÿ�.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end;

    if (cbOut.Text = '2') and (SC_STATUS[1].D213[11] = '1') or
       (cbOut.Text = '4') and (SC_STATUS[1].D213[13] = '1') or
       (cbOut.Text = '6') and (SC_STATUS[1].D213[15] = '1') then
    begin
      MessageDlg('AGV�� ��ŷ�� �Դϴ�.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end;

    if (dgInfo.SelectedRows.Count = 1) then
    begin
      if MessageDlg(' ���� �� ������ ��� �Ͻðڽ��ϱ�?' + #13#10  + #13#10+
                    '===============================' + #13#10+
                    '�������ڵ� ['+ edtOutCode.Text +'] ' + #13#10+
                    '��������ġ ['+ edtOutCell.Text +'] ' + #13#10+
                    '���԰����� ['+ edtOutIndate.Text +'] ' + #13#10+
                    '===============================' + #13#10+
                    '', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit ;
    end else
    if (dgInfo.SelectedRows.Count > 1) then
    begin
      if MessageDlg(' ���� �� ['+IntToStr(dgInfo.SelectedRows.Count) +']���� ������ ��� �Ͻðڽ��ϱ�?' + #13#10  + #13#10+
                    '', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit ;
    end else
    begin
      MessageDlg(' ��� �� ������ �������ֽʽÿ�.', mtConfirmation, [mbYes], 0) ;
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
//      MessageDlg('�������['+IntToStr(OrderCount)+']�� �Ϸ�Ǿ����ϴ�.' + #13#10  + #13#10+
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
// SetOutputOrder [������� ������ ����]
//==============================================================================
function TfrmU230.SetOutputOrder(sIdStatus: String): Boolean;
begin
  try
    OrderDataClear(OrderData) ;

    OrderData.REG_TIME   := FormatDateTime('YYYYMMDDHHNNSS',Now);

    OrderData.LUGG       := Format('%.4d', [GetJobNo]) ; // �۾���ȣ

    OrderData.JOBD       := '2'; // �������
    OrderData.IS_AUTO    := 'N';
    OrderData.LINE_NO    := cbOut.Text; //LINE_NO

    OrderData.SRCSITE    := Format('%.4d', [StrToInt('1')]) ;                                      // ���� ȣ��
    OrderData.SRCAISLE   := Format('%.4d', [StrToInt(qryInfo.FieldByName('ID_BANK' ).AsString)]) ; // ���� ��
    OrderData.SRCBAY     := Format('%.4d', [StrToInt(qryInfo.FieldByName('ID_BAY'  ).AsString)]) ; // ���� ��
    OrderData.SRCLEVEL   := Format('%.4d', [StrToInt(qryInfo.FieldByName('ID_LEVEL').AsString)]) ; // ���� ��


    OrderData.DSTSITE    := '0001'; // �Ͽ� ��ġ
{
    OrderData.DSTAISLE   := '0001'; // �Ͽ� ��
    case cbOut.ItemIndex of   // �Ͽ� ��
      1  : begin OrderData.DSTBAY     := '0001'; end;
      2  : begin OrderData.DSTBAY     := '0004'; end;
      3  : begin OrderData.DSTBAY     := '0007'; end;
    end;
}
    OrderData.DSTAISLE   := '0000';
    OrderData.DSTBAY     := '0000';
    OrderData.DSTLEVEL   := Format('%.4d', [StrToInt(cbOut.Text)]); // �Ͽ� ��

    OrderData.ID_CODE    := qryInfo.FieldByName('ID_CODE').AsString ;

    OrderData.NOWMC      := '2';
    OrderData.JOBSTATUS  := '1';
    OrderData.NOWSTATUS  := '1';
    OrderData.BUFFSTATUS := fnGetCHData('1','R','CH05','10'); // �����
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
    OrderData.UP_TIME    := '';



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
// SetJobOrder [������� ������ ����]
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
      '    ETC, EMG, ITM_CD                                ' + #13#10 +
      '  ) VALUES (                                        ' + #13#10 +
      '    :REG_TIME, :LUGG, :JOBD, :IS_AUTO, :LINE_NO,    ' + #13#10 +
      '    :SRCSITE, :SRCAISLE, :SRCBAY, :SRCLEVEL,        ' + #13#10 +
      '    :DSTSITE, :DSTAISLE, :DSTBAY, :DSTLEVEL,        ' + #13#10 +
      '    :NOWMC, :JOBSTATUS, :NOWSTATUS, :BUFFSTATUS,    ' + #13#10 +
      '    :JOBREWORK, :JOBERRORT, :JOBERRORC, :JOBERRORD, ' + #13#10 +
      '    :JOB_END, :CVFR, :CVTO, :CVCURR,                ' + #13#10 +
      '    :ETC, :EMG, :ITM_CD                             ' + #13#10 +
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
      ExecSql;

      //+++++++++++++++++++++++++++++++++++++
      // ������ ����  ( ����(0) -> ����(5) )
      //+++++++++++++++++++++++++++++++++++++
      Close;
      SQL.Clear;
      SQL.Text :=
      ' UPDATE TT_STOCK               ' + #13#10 +
      '    SET ID_STATUS = :ID_STATUS ' + #13#10 +
      '  WHERE ID_HOGI = :ID_HOGI     ' + #13#10+
      '    AND ID_CODE = :ID_CODE ' ;
      Parameters[0].Value := '5';                         // �����
      Parameters[1].Value := Copy(OrderData.SRCSITE,4,1); // ȣ��
      Parameters[2].Value := OrderData.ID_CODE;           // ����ġ
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
  Pnl_Sub.Top  := (Pnl_Main.Height - Pnl_Sub.Height) div 2 ;
  Pnl_Sub.Left := (Pnl_Main.Width  - Pnl_Sub.Width ) div 2 ;
end;

//==============================================================================
// SetComboBox [�޺��ڽ� ������ �߰�]
//==============================================================================
procedure TfrmU230.SetComboBox;
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
// dgInfoTitleClick [�׸��� ����]
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
  cbCode.ItemIndex        := 0 ;
  ComboBoxBank.ItemIndex  := 0 ;
  ComboBoxBay.ItemIndex   := 0 ;
  ComboBoxLevel.ItemIndex := 0 ;
  cbOut.ItemIndex         := 0 ;
  lbloutstation.Caption := '';
  fnCommandQuery;
end;


//==============================================================================
// fnGetCHData [��&��� ���� üũ]
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
// OrderDataClear [����ü �ʱ�ȭ]
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
end;

//==============================================================================
// GetJobNo [�۾���ȣ ����]
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
    1  : begin lbloutstation.Caption := '02-07-01 ����' end;
    2  : begin lbloutstation.Caption := '02-04-01 ����' end;
    3  : begin lbloutstation.Caption := '02-01-01 ����' end;
  end;
end;

end.





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
    dgInfo: TDBGridEh;
    sbtReset: TSpeedButton;
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    edtOutCode: TEdit;
    edtOutCell: TEdit;
    edtOutInDate: TEdit;
    rgEMG: TRadioGroup;
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
    procedure fnCommandNew;
    procedure fnCommandExcel;
    procedure fnCommandDelete;
    procedure fnCommandPrint;
    procedure fnCommandQuery;
    procedure fnCommandClose;
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
procedure TfrmU230.FormActivate(Sender: TObject);
begin
  frmMain.PnlMainMenu.Caption := (Sender as TForm).Caption ;
  fnWmMsgSend( 22222,111 );

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

  for i := 0 to Self.ComponentCount-1 Do
  begin
    if (Self.Components[i] is TADOQuery) then
       (Self.Components[i] as TADOQuery).Active := False ;
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
// fnCommandNew [신규]
//==============================================================================
procedure TfrmU230.fnCommandNew  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [엑셀]
//==============================================================================
procedure TfrmU230.fnCommandExcel;
begin
//
end;

//==============================================================================
// fnCommandDelete [삭제]
//==============================================================================
procedure TfrmU230.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandPrint [인쇄]
//==============================================================================
procedure TfrmU230.fnCommandPrint;
begin
//
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

      if (Trim(cbCode.Text) <> '') and (Trim(cbCode.Text) <> '전체') then
        StrSQL := StrSQL + ' And ITM_CD Like ''%' + UpperCase(Trim(cbCode.Text)) + '%'' ' ;

      if (rgITM_YN.ItemIndex in [1,2]) then // 기종 or 공파레트
      begin
        if (rgITM_YN.ItemIndex = 1 ) then StrSQL := StrSQL + ' And ID_STATUS= ''2'' '  // 기종
        else                              StrSQL := StrSQL + ' And ID_STATUS= ''1'' ' ;// 공파레트
      end else StrSQL := StrSQL + ' And ID_STATUS in (''1'',''2'') ' ;

      StrSQL := StrSQL + ' And OT_USED= ''1'' ' ;

      StrSQL := StrSQL + ' Order By ID_CODE, ITM_CD, STOCK_IN_DT ' ;

      SQL.Text := StrSQL;
      Open;
    end;
  except
    if qryInfo.Active then qryInfo.Close;
  end;
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
      edtOutCode.Text   := '[다중출고]';
      edtOutCell.Text   := '[다중출고]';
      edtOutIndate.Text := '[다중출고]';
    end else
    begin
      edtOutCode.Text   := '';
      edtOutCell.Text   := '';
      edtOutIndate.Text := '';
    end;
  except
    if qryInfo.Active then qryInfo.Close;
  end;
end;

//==============================================================================
// btnOrderClick [출고지시]
//==============================================================================
procedure TfrmU230.btnOrderClick(Sender: TObject);
var
  i : integer ;
begin
  try
    OrderCount := 0;
    if not qryInfo.Active then Exit;

    if (dgInfo.SelectedRows.Count = 1) then
    begin
      if MessageDlg(' 선택 한 기종을 출고 하시겠습니까?' + #13#10  + #13#10+
                    '===============================' + #13#10+
                    '▷기종코드 ['+ edtOutCode.Text +'] ' + #13#10+
                    '▷적재위치 ['+ edtOutCell.Text +'] ' + #13#10+
                    '▷입고일자 ['+ edtOutIndate.Text +'] ' + #13#10+
                    '===============================' + #13#10+
                    '', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit ;
    end else
    if (dgInfo.SelectedRows.Count > 1) then
    begin
      if MessageDlg(' 선택 한 ['+IntToStr(dgInfo.SelectedRows.Count) +']개의 기종을 출고 하시겠습니까?' + #13#10  + #13#10+
                    '', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit ;
    end else
    begin
      MessageDlg(' 출고 할 기종을 선택해주십시오.', mtConfirmation, [mbYes], 0) ;
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
//      MessageDlg('출고지시['+IntToStr(OrderCount)+']가 완료되었습니다.' + #13#10  + #13#10+
//                 '', mtConfirmation, [mbYes], 0) ;
    end;

    edtOutCode.Text   := '';
    edtOutCell.Text   := '';
    edtOutIndate.Text := '';
    fnCommandQuery ;
  except
    if qryInfo.Active then qryInfo.Close;
    if qryTemp.Active then qryTemp.Close;
  end;
end;

//==============================================================================
// SetOutputOrder [출고지시 데이터 생성]
//==============================================================================
function TfrmU230.SetOutputOrder(sIdStatus: String): Boolean;
begin
  try
    OrderDataClear(OrderData) ;

    OrderData.REG_TIME   := FormatDateTime('YYYYMMDDHHNNSS',Now);

    OrderData.LUGG       := Format('%.4d', [GetJobNo]) ; // 작업번호

    OrderData.JOBD       := '2'; // 출고지시

    OrderData.SRCSITE    := Format('%.4d', [StrToInt('1')]) ;                                      // 적재 호기
    OrderData.SRCAISLE   := Format('%.4d', [StrToInt(qryInfo.FieldByName('ID_BANK' ).AsString)]) ; // 적재 열
    OrderData.SRCBAY     := Format('%.4d', [StrToInt(qryInfo.FieldByName('ID_BAY'  ).AsString)]) ; // 적재 연
    OrderData.SRCLEVEL   := Format('%.4d', [StrToInt(qryInfo.FieldByName('ID_LEVEL').AsString)]) ; // 적재 단


    OrderData.DSTSITE    := '0100'; // 하역 위치
    OrderData.DSTAISLE   := '0000'; // 하역 열
    OrderData.DSTBAY     := '0000'; // 하역 연
    OrderData.DSTLEVEL   := '0001'; // 하역 단

    OrderData.ID_CODE    := qryInfo.FieldByName('ID_CODE').AsString ;

    OrderData.NOWMC      := '2';
    OrderData.JOBSTATUS  := '1';
    OrderData.NOWSTATUS  := '1';
    OrderData.BUFFSTATUS := fnGetCHData('1','R','CH05','10'); // 출고레디
    OrderData.JOBREWORK  := '';
    OrderData.JOBERRORT  := '';
    OrderData.JOBERRORC  := '';
    OrderData.JOBERRORD  := '';
    OrderData.JOB_END    := '0';
    OrderData.CVFR       := '100';
    OrderData.CVTO       := '100';
    OrderData.CVCURR     := '100';
    OrderData.ETC        := qryInfo.FieldByName('ID_MEMO').AsString ;
    OrderData.EMG        := IntToStr(rgEMG.ItemIndex);
    OrderData.ITM_CD     := qryInfo.FieldByName('ITM_CD').AsString ;
    OrderData.UP_TIME    := '';



    if SetJobOrder then
    begin
      Inc(OrderCount) ;
    end;


  except
    if qryInfo.Active then qryInfo.Close;
  end;
end;

//==============================================================================
// SetJobOrder [출고지시 데이터 저장]
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
      '    REG_TIME, LUGG, JOBD,                           ' + #13#10 +
      '    SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL,            ' + #13#10 +
      '    DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL,            ' + #13#10 +
      '    NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS,        ' + #13#10 +
      '    JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD,     ' + #13#10 +
      '    JOB_END, CVFR, CVTO, CVCURR,                    ' + #13#10 +
      '    ETC, EMG, ITM_CD                                ' + #13#10 +
      '  ) VALUES (                                        ' + #13#10 +
      '    :REG_TIME, :LUGG, :JOBD,                        ' + #13#10 +
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
      // 셀상태 변경  ( 공셀(0) -> 공셀(4) )
      //+++++++++++++++++++++++++++++++++++++
      Close;
      SQL.Clear;
      SQL.Text :=
      ' UPDATE TT_STOCK               ' + #13#10 +
      '    SET ID_STATUS = :ID_STATUS ' + #13#10 +
      '  WHERE ID_HOGI = :ID_HOGI     ' + #13#10+
      '    AND ID_CODE = :ID_CODE ' ;
      Parameters[0].Value := '5';                         // 입고예약
      Parameters[1].Value := Copy(OrderData.SRCSITE,4,1); // 호기
      Parameters[2].Value := OrderData.ID_CODE;           // 셀위치
      ExecSql;
      Close;
    end;
    Result := True;

    if MainDm.MainDB.InTransaction then
       MainDm.MainDB.CommitTrans;
  except
    if MainDm.MainDB.InTransaction then
       MainDm.MainDB.RollbackTrans;
    if qryTemp.Active then qryTemp.Close;
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
// Pnl_MainResize
//==============================================================================
procedure TfrmU230.Pnl_MainResize(Sender: TObject);
begin
  Pnl_Sub.Top  := (Pnl_Main.Height - Pnl_Sub.Height) div 2 ;
  Pnl_Sub.Left := (Pnl_Main.Width  - Pnl_Sub.Width ) div 2 ;
end;

//==============================================================================
// SetComboBox [콤보박스 데이터 추가]
//==============================================================================
procedure TfrmU230.SetComboBox;
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
// dgInfoTitleClick [그리드 정렬]
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
  fnCommandQuery;
end;


//==============================================================================
// fnGetCHData [입&출고 레디 체크]
//==============================================================================
function TfrmU230.fnGetCHData(SCC_NO,SCC_SR,CH_NO,POS_NO:String) : String ;
var
  StrSQL : String;
begin
  try
    Result := '0';
    StrSQL := ' Select SubStr(' + CH_NO + ',' + POS_NO + ',1) as Data ' +
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
    if qryTemp.Active then qryTemp.Close;
  end;
end;

//==============================================================================
// OrderDataClear [구조체 초기화]
//==============================================================================
procedure TfrmU230.OrderDataClear(OrderData: TJobOrder);
begin
  OrderData.REG_TIME   := '';
  OrderData.LUGG       := '';
  OrderData.JOBD       := '';
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
// GetJobNo [작업번호 생성]
//==============================================================================
function TfrmU230.GetJobNo : Integer;
var
  StrSQL : String;
begin
  try
    Result := 0;
    with qryTemp do
    begin
      Close;
      SQL.Clear;
      StrSQL :=  ' Select JobSeq.Nextval as JobSeq From Dual ';
      SQL.Text := StrSQL;
      Open;
      if Not (Eof and Bof) then
      begin
        Result := FieldByName('JobSeq').AsInteger;
      end;
      Close;
    end;
  except
    if qryTemp.Active then qryTemp.Close;
  end;
end;

end.





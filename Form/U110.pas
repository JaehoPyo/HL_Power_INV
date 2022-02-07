unit U110;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, d_MainDm, h_MainLib, h_ReferLib, StdCtrls, DB, ADODB, ExLibrary, ExVclLib,
  Grids, StrUtils, DBGrids, comobj, frxClass, frxDBSet, DBGridEhGrouping, EhLibADO,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,DBGridEhImpExp,
  DBGridEh, Vcl.Mask, Vcl.DBCtrls, DBCtrlsEh, PrnDbgeh, Vcl.Buttons ;

type
  TfrmU110 = class(TForm)
    qryTemp: TADOQuery;
    dsInfo: TDataSource;
    Pnl_Top: TPanel;
    Pnl_Main: TPanel;
    dgInfo: TDBGridEh;
    rgITM_YN: TRadioGroup;
    gbCode: TGroupBox;
    cbCode: TComboBox;
    EhPrint: TPrintDBGridEh;
    qryInfo: TADOQuery;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rgITM_YNClick(Sender: TObject);
    procedure dgInfoDblClick(Sender: TObject);
    procedure dgInfoTitleClick(Column: TColumnEh);
    procedure cbCodeChange(Sender: TObject);
    procedure cbCodeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure fnCommandStart;
    procedure fnCommandOrder;
    procedure fnCommandUpdate;
    procedure fnCommandDelete;
    procedure fnCommandExcel;
    procedure fnCommandPrint;
    procedure fnCommandQuery;
    procedure fnCommandClose;
    procedure fnCommandLang;
    procedure fnCommandAdd;

    procedure fnWmMsgRecv (var MSG : TMessage) ; message WM_USER ;

    procedure SetComboBox ;
    procedure ProcDeleteCode(ITM_CD:String) ;
  end;
  procedure U110Create();

const
  FormNo ='110';
var
  frmU110: TfrmU110;
  SrtFlag : integer = 0 ;

implementation

uses Main, Popup_Item ;

{$R *.dfm}

//==============================================================================
// U110FCreate
//==============================================================================
procedure U110Create();
begin
  if not Assigned( frmU110 ) then
  begin
    frmU110 := TfrmU110.Create(Application);
    with frmU110 do
    begin
      fnCommandStart;
    end;
  end;
  frmU110.Show;
end;

//==============================================================================
// fnWmMsgRecv
//==============================================================================
procedure TfrmU110.fnWmMsgRecv(var MSG: TMessage);
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
procedure TfrmU110.FormActivate(Sender: TObject);
begin
  MainDm.M_Info.ActiveFormID := '110';
  frmMain.LblMenu000.Caption := MainDm.M_Info.ActiveFormID + '. ' + getLangMenuString(MainDm.M_Info.ActiveFormID, frmMain.LblMenu000.Caption, MainDm.M_Info.LANG_TYPE, 'N');
  frmU110.Caption := MainDm.M_Info.ActiveFormName;
  fnWmMsgSend( 21111,11111 );
  SetComboBox ;
  fnCommandQuery ;
end;

//==============================================================================
// FormDeactivate
//==============================================================================
procedure TfrmU110.FormDeactivate(Sender: TObject);
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
procedure TfrmU110.FormClose(Sender: TObject; var Action: TCloseAction);
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
  try
    frmU110 := Nil ;
  except
  end;
end;

//==============================================================================
// fnCommandStart
//==============================================================================
procedure TfrmU110.fnCommandStart;
begin
//
end;

//==============================================================================
// fnCommandOrder [지시]
//==============================================================================
procedure TfrmU110.fnCommandOrder  ;
begin
//
end;

//==============================================================================
// fnCommandAdd [신규]                                                        //
//==============================================================================
procedure TfrmU110.fnCommandAdd  ;
begin
  try
    frmPopup_Item := TfrmPopup_Item.Create(Application);
    frmPopup_Item.PnlFormName.Caption := '코드 등록';
    frmPopup_Item.btnSave.Caption := '등 록';
    frmPopup_Item.edtITM_CD.Text  := '';
    frmPopup_Item.edtITM_CD.Color := clWhite;
    frmPopup_Item.edtITM_CD.ReadOnly := False;
    frmPopup_Item.edtITM_QTY.Text := '1';
    frmPopup_Item.ShowModal ;
  except
    on E : Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'fnCommandAdd', '등록', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnCommandAdd Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// fnCommandExcel [엑셀]
//==============================================================================
procedure TfrmU110.fnCommandExcel;
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
// fnCommandDelete [삭제]
//==============================================================================
procedure TfrmU110.fnCommandDelete;
var
  i : Integer;
begin
  if not qryInfo.Active then Exit;

  if MessageDlg('선택['+IntToStr(dgInfo.SelectedRows.Count)+']한 코드를 [삭제] 하시겠습니까?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit ;

  for i := 0 to (dgInfo.SelectedRows.Count-1) do
  begin
    with dgInfo.DataSource.DataSet do
    begin
      GotoBookmark(pointer(dgInfo.SelectedRows.Items[i]));
      ProcDeleteCode(UpperCase(Trim(qryInfo.FieldByName('ITM_CD').AsString)));
    end;
  end;
  SetComboBox;
  fnCommandQuery;
end;

//==============================================================================
// fnCommandUpdate [수정]                                                     //
//==============================================================================
procedure TfrmU110.fnCommandUpdate;
var
  PROD_LINE : String ;
begin
  try
    frmPopup_Item := TfrmPopup_Item.Create(Application);
    frmPopup_Item.PnlFormName.Caption := '코드 수정';
    frmPopup_Item.btnSave.Caption := '수 정';
    frmPopup_Item.edtITM_QTY.Text := '1';

    //자재코드
    frmPopup_Item.edtITM_CD.Text := qryInfo.FieldByName('ITM_CD').AsString;
    frmPopup_Item.edtITM_CD.Color := $00DDDDDD;
    frmPopup_Item.edtITM_CD.ReadOnly := True;

    frmPopup_Item.edtITM_NAME.Text := qryInfo.FieldByName('ITM_NAME').AsString;
    frmPopup_Item.edtITM_SPEC.Text := qryInfo.FieldByName('ITM_SPEC').AsString;
    frmPopup_Item.edtITM_QTY.Text := qryInfo.FieldByName('ITM_QTY').AsString;
    if qryInfo.FieldByName('ITM_YN').AsString = 'Y' then frmPopup_Item.cbITM_YN.Checked := True
    else                                                 frmPopup_Item.cbITM_YN.Checked := False;
    frmPopup_Item.edtMemo.Text := qryInfo.FieldByName('MEMO').AsString;


    frmPopup_Item.ShowModal ;
  except
    on E : Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'fnCommandUpdate', '수정', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnCommandUpdate Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// fnCommandPrint [인쇄]
//==============================================================================
procedure TfrmU110.fnCommandPrint;
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
procedure TfrmU110.fnCommandQuery;
var
  ITM_YN, StrSQL : String;
begin
  try
    if      rgITM_YN.ItemIndex=1 then ITM_YN := 'Y'
    else if rgITM_YN.ItemIndex=2 then ITM_YN := 'N'
    else                              ITM_YN := '';


    StrSQL := ' Select ITM_CD, ITM_NAME, ITM_SPEC, ITM_QTY, ' +
              '        ITM_YN, MEMO, UP_DATE, CR_DATE       ' +
              '   From TM_ITEM ' +
              '  Where 1=1 ' ;

    // 코드
    if (Trim(cbCode.Text) <> '') and (Trim(cbCode.Text) <> '전체') then
      StrSQL := StrSQL + ' And ITM_CD Like ''%' + UpperCase(Trim(cbCode.Text)) + '%'' ' ;
    // 기종여부
    if ITM_YN <> '' then
      StrSQL := StrSQL + ' And ITM_YN = ' + QuotedStr(ITM_YN);

    StrSQL := StrSQL + ' Order By ITM_CD ' ;

    with qryInfo do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open ;
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
procedure TfrmU110.fnCommandClose;
begin
  Close;
end;

//==============================================================================
// fnCommandLang [언어]                                                       //
//==============================================================================
procedure TfrmU110.fnCommandLang;
begin
//
end;

//==============================================================================
// rgITM_YNClick
//==============================================================================
procedure TfrmU110.rgITM_YNClick(Sender: TObject);
begin
  fnCommandQuery ;
end;

//==============================================================================
// dgInfoDblClick
//==============================================================================
procedure TfrmU110.dgInfoDblClick(Sender: TObject);
begin
  frmPopup_Item := TfrmPopup_Item.Create(Application);
  frmPopup_Item.PnlFormName.Caption := '코드 수정';
  frmPopup_Item.btnSave.Caption := '수 정';
  frmPopup_Item.edtITM_CD.Text  := UpperCase(qryInfo.FieldByName('ITM_CD').AsString);
  frmPopup_Item.edtITM_CD.Color := $008EE6D9;
  frmPopup_Item.edtITM_CD.ReadOnly := True;
  frmPopup_Item.edtITM_QTY.Text := '1';
  frmPopup_Item.ShowModal ;
end;

//==============================================================================
// ProcDeleteCode [코드삭제]
//==============================================================================
procedure TfrmU110.ProcDeleteCode(ITM_CD: String);
var
  StrSQL : String;
begin
  try
    StrSQL := ' Delete From TM_ITEM ' +
              '  Where ITM_CD = ' + QuotedStr(Trim(ITM_CD)) ;

    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL;
      ExecSQL;
    end;
  except
    if qryTemp.Active then qryTemp.Close;
  end;
end;

//==============================================================================
// dgInfoTitleClick [그리드 정렬]
//==============================================================================
procedure TfrmU110.dgInfoTitleClick(Column: TColumnEh);
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
// SetComboBox [콤보박스 데이터 추가]
//==============================================================================
procedure TfrmU110.SetComboBox;
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
// cbCodeChange [콤보박스 이벤트]
//==============================================================================
procedure TfrmU110.cbCodeChange(Sender: TObject);
begin
  fnCommandQuery ;
end;

//==============================================================================
// cbCodeKeyPress [키 입력 이벤트]
//==============================================================================
procedure TfrmU110.cbCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    fnCommandQuery;
  end;
end;

end.





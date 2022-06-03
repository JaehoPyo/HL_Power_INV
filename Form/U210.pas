unit U210;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, d_MainDm, h_MainLib, h_ReferLib, StdCtrls, DB, ADODB, ExLibrary, ExVclLib,
  Grids, StrUtils, DBGrids, comobj, frxClass, frxDBSet, DBGridEhGrouping, EhLibADO,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,DBGridEhImpExp,
  DBGridEh, Vcl.Mask, Vcl.DBCtrls, DBCtrlsEh, PrnDbgeh, Vcl.Buttons ;

type
  TfrmU210 = class(TForm)
    qryTemp: TADOQuery;
    qryInfo_In: TADOQuery;
    dsInfo_In: TDataSource;
    EhPrint: TPrintDBGridEh;
    Pnl_Main: TPanel;
    Pnl_Ot: TPanel;
    PnlTitle_Ot: TPanel;
    Pnl_In: TPanel;
    PnlTitle_In: TPanel;
    dgInfo_In: TDBGridEh;
    dsInfo_Ot: TDataSource;
    qryInfo_Ot: TADOQuery;
    Panel1: TPanel;
    Panel2: TPanel;
    Pnl_AutoQry_In: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Pnl_AutoQry_Ot: TPanel;
    imgNo: TImage;
    imgOK: TImage;
    tmrQry: TTimer;
    dgInfo_Ot: TDBGridEh;
    ImgIn: TImage;
    ImgOt: TImage;
    chkGridOut: TCheckBox;
    chkGridIn: TCheckBox;
    Panel3: TPanel;
    Panel6: TPanel;
    PnlSelInfo1: TPanel;
    PnlManual: TPanel;
    Panel57: TPanel;
    sbtCancel1: TSpeedButton;
    Panel38: TPanel;
    sbtComplete1: TSpeedButton;
    Panel7: TPanel;
    edtJOB_NO_SEL1: TEdit;
    PnlSelInfo2: TPanel;
    Panel12: TPanel;
    Panel14: TPanel;
    sbtCancel2: TSpeedButton;
    Panel17: TPanel;
    sbtComplete2: TSpeedButton;
    Panel19: TPanel;
    edtJOB_NO_SEL2: TEdit;
    Panel23: TPanel;
    Panel16: TPanel;
    Panel13: TPanel;
    Pnl_Rack: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Pnl_AutoQry_Rack: TPanel;
    ImgRack: TImage;
    chkGridRack: TCheckBox;
    Panel18: TPanel;
    PnlSelInfo3: TPanel;
    Panel21: TPanel;
    Panel22: TPanel;
    sbtCancel3: TSpeedButton;
    Panel24: TPanel;
    sbtComplete3: TSpeedButton;
    Panel25: TPanel;
    edtJOB_NO_SEL3: TEdit;
    Panel26: TPanel;
    dgInfo_Rack: TDBGridEh;
    dsInfo_Rack: TDataSource;
    qryInfo_Rack: TADOQuery;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Pnl_MainResize(Sender: TObject);
    procedure PnlAutoQryClick(Sender: TObject);
    procedure tmrQryTimer(Sender: TObject);
    procedure dgInfoTitleClick(Column: TColumnEh);
    procedure dgInfoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure ImgAutoQryClick(Sender: TObject);
    procedure chkGridInClick(Sender: TObject);
    procedure chkGridOutClick(Sender: TObject);
    procedure dgInfoCellClick_In(Column: TColumnEh);
    procedure dgInfoCellClick_Ot(Column: TColumnEh);
    procedure dgInfoCellClick_Rack(Column: TColumnEh);
    procedure chkGridRackClick(Sender: TObject);
    procedure sbtClick(Sender: TObject);
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
    procedure fnAutoQuery(IO : String);
    procedure fnWmMsgRecv (var MSG : TMessage) ; message WM_USER ;
    procedure fnRFIDDataUpdate;

    procedure OrderDataClear(OrderData: TJobOrder);

    function fnJobCheck(JobNo: String): Boolean; //작업진행 체크
    function fnOrderCancelAndComplet(IO, JobNo, Order: String): Boolean; //작업완료,삭제
    function fnOrderDataSet(JobNo : String): Boolean; // TT_ORDER 데이터 저장
    function fnITEM_Value(FName, FValue : String): String;

    procedure fnUpdateSCSetInfo(FieldName: String); // TC_SCSETINFO UPDATE
    procedure fnIns_History(JobNo: String);
    
  end;
  procedure U210Create();

const
  FormNo ='210';
var
  frmU210: TfrmU210;
  SrtFlag : integer = 0 ;

  OrderData  : TJobOrder;

implementation

uses Main ;

{$R *.dfm}

//==============================================================================
// U210Create
//==============================================================================
procedure U210Create();
begin
  if not Assigned( frmU210 ) then
  begin
    frmU210 := TfrmU210.Create(Application);
    with frmU210 do
    begin
      fnCommandStart;
    end;
  end;
  frmU210.Show;
end;

//==============================================================================
// fnWmMsgRecv
//==============================================================================
procedure TfrmU210.fnWmMsgRecv(var MSG: TMessage);
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
procedure TfrmU210.FormActivate(Sender: TObject);
begin
  MainDm.M_Info.ActiveFormID := '210';
  frmMain.LblMenu000.Caption := MainDm.M_Info.ActiveFormID + '. ' + getLangMenuString(MainDm.M_Info.ActiveFormID, frmMain.LblMenu000.Caption, MainDm.M_Info.LANG_TYPE, 'N');
  frmU210.Caption := MainDm.M_Info.ActiveFormName;
  fnWmMsgSend( 22221,11111 );
  fnCommandQuery ;
  if not tmrQry.Enabled then tmrQry.Enabled := True;
end;

//==============================================================================
// FormDeactivate
//==============================================================================
procedure TfrmU210.FormDeactivate(Sender: TObject);
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
procedure TfrmU210.FormClose(Sender: TObject; var Action: TCloseAction);
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
  try frmU210 := Nil ;
  except end;
end;

//==============================================================================
// fnCommandStart
//==============================================================================
procedure TfrmU210.fnCommandStart;
begin
//
end;

//==============================================================================
// fnCommandOrder [지시]
//==============================================================================
procedure TfrmU210.fnCommandOrder  ;
begin
//
end;

//==============================================================================
// fnCommandAdd [신규]                                                        //
//==============================================================================
procedure TfrmU210.fnCommandAdd  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [엑셀]
//==============================================================================
procedure TfrmU210.fnCommandExcel;
var
  TmpGrid : TDBGridEh;
  tStr : String;
begin
  try
    if chkGridIn.Checked then
    begin
      TmpGrid := dgInfo_In;
      tStr := '';
    end else
    if chkGridOut.Checked then
    begin
      TmpGrid := dgInfo_Ot;
      tStr := '';
    end else
    begin
      TmpGrid := dgInfo_Rack;
      tStr := '';
    end;
    

    if hlbEhgridListExcel(TmpGrid, frmMain.LblMenu000.Caption + '_' + FormatDatetime('YYYYMMDD', Now)) then
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
procedure TfrmU210.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandUpdate [수정]                                                     //
//==============================================================================
procedure TfrmU210.fnCommandUpdate;
begin
//
end;

//==============================================================================
// fnCommandPrint [인쇄]
//==============================================================================
procedure TfrmU210.fnCommandPrint;
var
  TmpGrid : TDBGridEh;
  tStr : String;
begin
  try
    if chkGridIn.Checked then
    begin
      TmpGrid := dgInfo_In;
      tStr := '';
      if not qryInfo_In.Active then Exit;
    end else
    if chkGridOut.Checked then
    begin
      TmpGrid := dgInfo_Ot;
      tStr := '';
      if not qryInfo_Ot.Active then Exit;
    end else
    begin
      TmpGrid := dgInfo_Rack;
      tStr := '';
      if not qryInfo_Rack.Active then Exit;    
    end;

    fnCommandQuery;
    EhPrint.DBGridEh := TmpGrid;
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
procedure TfrmU210.fnCommandQuery;
var
  StrSQL : String;
begin
  try
    // 입고현황
    if Pnl_AutoQry_In.Tag=1 then
    begin
      with qryInfo_In do
      begin
        Close;
        SQL.Clear;
        SQL.Text := ' Select REG_TIME, LUGG, JOBD, LINE_NO, ' +
                    '        SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL, ' +
                    '        DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL, ' +
                    '        NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS, ' +
                    '        JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD, ' +
                    '        IS_AUTO, CVFR, CVTO, CVCURR, ETC, EMG, ITM_CD, ' +
                    '       (Case JOBD  when ''1'' then ''입고'' ' +
                    '                   when ''2'' then ''출고'' end) as JOBD_DESC, ' +
                    '       (Case NOWMC when ''1'' then ''컨베어 작업'' ' +
                    '                   when ''2'' then ''스태커 적재'' ' +
                    '                   when ''3'' then ''스태커 하역'' ' +
                    '                   when ''4'' then ''AGV작업'' end) as NOWMC_DESC, ' +
                    '       (Case NOWSTATUS when ''1'' then ''등록'' ' +
                    '                       when ''2'' then ''지시'' ' +
                    '                       when ''3'' then ''이동중'' ' +
                    '                       when ''4'' then ''완료'' end) as NOWSTATUS_DESC, ' +
                    '       (Case JOBERRORC when ''0'' then ''정상'' ' +
                    '                       when ''1'' then ''에러'' end) as JOBERRORC_DESC, ' +
                    '       (Case when (JOBERRORD = ''0000'') or  ' +
	                  '                  (JOBERRORD = '''') or ' +
				            '                  (IsNull(JOBERRORD, '''') = '''') then ''정상'' ' +
                    '             when JOBERRORD not like ''%불일치%'' then (SELECT ERR_NAME FROM TM_ERROR WHERE ERR_CODE = A.JOBERRORD) ' +
			              '             else JOBERRORD end ) as JOBERRORD_DESC, ' +
                    '       (Case BUFFSTATUS when ''0'' then ''대기'' ' +
                    '                        when ''1'' then ''입고가능'' end) as BUFFSTATUS_DESC, ' +
                    '       (SUBSTRING(DSTAISLE,4,1)+''-''+SUBSTRING(DSTBAY,3,2)+''-''+SUBSTRING(DSTLEVEL,3,2)) as ID_CODE, ' +
                    '       (SUBSTRING(SRCAISLE,4,1)+''-''+SUBSTRING(SRCBAY,3,2)+''-''+FORMAT(CONVERT(INT,SRCLEVEL), ''D2'')) as OD_CODE, ' +
                    '       (SUBSTRING(REG_TIME,1,4)+''-''+SUBSTRING(REG_TIME,5,2)+''-''+SUBSTRING(REG_TIME,7,2)+ '' '' + ' +
                    '        SUBSTRING(REG_TIME,9,2)+'':''+SUBSTRING(REG_TIME,11,2)+'':''+SUBSTRING(REG_TIME,13,2)) as REG_TIME_CONV, ' +
                    '       CONVERT(VARCHAR, REG_TIME, 120) as REG_TIME_DESC ' +
                    '   From TT_ORDER as A     ' +
                    '  Where JOBD    = ''1''   ' +
                    '    And JOB_END = ''0''   ' +
                    '  Order By REG_TIME, LUGG ';
        Open;
      end;
    end;

    // 출고현황
    if Pnl_AutoQry_Ot.Tag=1 then
    begin
      with qryInfo_Ot do
      begin
        Close;
        SQL.Clear;
        SQL.Text := ' Select REG_TIME, LUGG, JOBD, LINE_NO,             ' +  #13#10+
                    '        SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL,        ' +  #13#10+
                    '        DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL,        ' +  #13#10+
                    '        NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS,    ' +  #13#10+
                    '        JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD, ' +  #13#10+
                    '        IS_AUTO, CVFR, CVTO, CVCURR, ETC, EMG, ITM_CD,      ' +  #13#10+
                    '       (Case when (JOBD=''1'') then ''입고'' ' +  #13#10+
                    '             when (JOBD=''2'') and (EMG=''0'') then ''출고'' ' +  #13#10+
                    '             when (JOBD=''2'') and (EMG=''1'') then ''긴급출고'' end) as JOBD_DESC, ' +  #13#10+
                    '       (Case NOWMC when ''1'' then ''컨베어 작업'' ' +  #13#10+
                    '                   when ''2'' then ''스태커 적재'' ' +  #13#10+
                    '                   when ''3'' then ''스태커 하역'' ' +  #13#10+
                    '                   when ''4'' then ''AGV 작업'' end) as NOWMC_DESC, ' +  #13#10+
                    '       (Case NOWSTATUS when ''1'' then ''등록'' ' +  #13#10+
                    '                       when ''2'' then ''지시'' ' +  #13#10+
                    '                       when ''3'' then ''이동중'' ' +  #13#10+
                    '                       when ''4'' then ''완료'' end) as NOWSTATUS_DESC, ' +  #13#10+
                    '       (Case JOBERRORC when ''0'' then ''정상'' ' +  #13#10+
                    '                       when ''1'' then ''에러'' end) as JOBERRORC_DESC, ' +  #13#10+
                    '       (Case when (JOBERRORD = ''0000'') or  ' + #13#10 +
	                  '                  (JOBERRORD = '''') or ' + #13#10 +
				            '                  (IsNull(JOBERRORD, '''') = '''') then ''정상'' ' +  #13#10 +
                    '             when JOBERRORD not like ''%불일치%'' then (SELECT ERR_NAME FROM TM_ERROR WHERE ERR_CODE = A.JOBERRORD) ' + #13#10 +
			              '             else JOBERRORD end ) as JOBERRORD_DESC, ' + #13#10 +
                    '       (Case BUFFSTATUS when ''0'' then ''대기'' ' +  #13#10+
                    '                        when ''1'' then ''입고가능'' end) as BUFFSTATUS_DESC, ' +  #13#10+
                    '       (SUBSTRING(DSTAISLE,4,1)+''-''+SUBSTRING(DSTBAY,3,2)+''-''+FORMAT(CONVERT(INT,DSTLEVEL), ''D2'')) as ID_CODE,           ' +
                    '       (SUBSTRING(SRCAISLE,4,1)+''-''+SUBSTRING(SRCBAY,3,2)+''-''+FORMAT(CONVERT(INT,SRCLEVEL), ''D2'')) as OD_CODE,           ' +
                    '       (SUBSTRING(REG_TIME,1,4)+''-''+SUBSTRING(REG_TIME,5,2)+''-''+SUBSTRING(REG_TIME,7,2)+ '' '' + ' +
                    '        SUBSTRING(REG_TIME,9,2)+'':''+SUBSTRING(REG_TIME,11,2)+'':''+SUBSTRING(REG_TIME,13,2)) as REG_TIME_CONV, ' +
                    '       CONVERT(VARCHAR, REG_TIME, 120) as REG_TIME_DESC ' +
                    '   From TT_ORDER as A ' +  #13#10+
                    '  Where JOBD    = ''2'' ' +  #13#10+
                    '    And JOB_END = ''0'' ' +  #13#10+
                    '  Order By EMG DESC, REG_TIME, LUGG ASC ' ;
        Open;
      end;
    end;

    // 렉이동현황
    if Pnl_AutoQry_Rack.Tag=1 then
    begin
      with qryInfo_Rack do
      begin
        Close;
        SQL.Clear;
        SQL.Text := ' Select REG_TIME, LUGG, JOBD, LINE_NO,             ' +  #13#10+
                    '        SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL,        ' +  #13#10+
                    '        DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL,        ' +  #13#10+
                    '        NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS,    ' +  #13#10+
                    '        JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD, ' +  #13#10+
                    '        IS_AUTO, CVFR, CVTO, CVCURR, ETC, EMG, ITM_CD,      ' +  #13#10+
                    '       (Case when (JOBD=''1'') then ''입고'' ' +  #13#10+
                    '             when (JOBD=''2'') and (EMG=''0'') then ''출고'' ' +  #13#10+
                    '             when (JOBD=''2'') and (EMG=''1'') then ''긴급출고'' ' +  #13#10+
                    '             when (JOBD=''7'') then ''랙이동'' end) as JOBD_DESC, ' +  #13#10+
                    '       (Case NOWMC when ''1'' then ''컨베어 작업'' ' +  #13#10+
                    '                   when ''2'' then ''스태커 적재'' ' +  #13#10+
                    '                   when ''3'' then ''스태커 하역'' end) as NOWMC_DESC, ' +  #13#10+
                    '       (Case NOWSTATUS when ''1'' then ''등록'' ' +  #13#10+
                    '                       when ''2'' then ''지시'' ' +  #13#10+
                    '                       when ''3'' then ''이동중'' ' +  #13#10+
                    '                       when ''4'' then ''완료'' end) as NOWSTATUS_DESC, ' +  #13#10+
                    '       (Case JOBERRORC when ''0'' then ''정상'' ' +  #13#10+
                    '                       when ''1'' then ''에러'' end) as JOBERRORC_DESC, ' +  #13#10+
                    '       (Case when (JOBERRORD = ''0000'') or  ' + #13#10 +
	                  '                  (JOBERRORD = '''') or ' + #13#10 +
				            '                  (IsNull(JOBERRORD, '''') = '''') then ''정상'' ' +  #13#10 +
                    '             when JOBERRORD not like ''%불일치%'' then (SELECT ERR_NAME FROM TM_ERROR WHERE ERR_CODE = A.JOBERRORD) ' + #13#10 +
			              '             else JOBERRORD end ) as JOBERRORD_DESC, ' + #13#10 +
                    '       (Case BUFFSTATUS when ''0'' then ''대기'' ' +  #13#10+
                    '                        when ''1'' then ''입고가능'' end) as BUFFSTATUS_DESC, ' +  #13#10+
                    '       (SUBSTRING(DSTAISLE,4,1)+''-''+SUBSTRING(DSTBAY,3,2)+''-''+FORMAT(CONVERT(INT,DSTLEVEL), ''D2'')) as ID_CODE,           ' +
                    '       (SUBSTRING(SRCAISLE,4,1)+''-''+SUBSTRING(SRCBAY,3,2)+''-''+FORMAT(CONVERT(INT,SRCLEVEL), ''D2'')) as OD_CODE,           ' +
                    '       (SUBSTRING(REG_TIME,1,4)+''-''+SUBSTRING(REG_TIME,5,2)+''-''+SUBSTRING(REG_TIME,7,2)+ '' '' + ' +
                    '        SUBSTRING(REG_TIME,9,2)+'':''+SUBSTRING(REG_TIME,11,2)+'':''+SUBSTRING(REG_TIME,13,2)) as REG_TIME_CONV, ' +
                    '       CONVERT(VARCHAR, REG_TIME, 120) as REG_TIME_DESC ' +
                    '   From TT_ORDER as A' +  #13#10+
                    '  Where JOBD    = ''7'' ' +  #13#10+
                    '    And JOB_END = ''0'' ' +  #13#10+
                    '  Order By EMG DESC, REG_TIME, LUGG ASC ' ;
        Open;
      end;
    end;    
  except
    on E : Exception do
    begin
      qryInfo_In.Close;
      qryInfo_Ot.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'fnCommandQuery', 'Inquiry', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnCommandQuerySub Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;

//==============================================================================
// fnCommandClose
//==============================================================================
procedure TfrmU210.fnCommandClose;
begin
  Close;
end;

//==============================================================================
// fnCommandLang [언어]                                                       //
//==============================================================================
procedure TfrmU210.fnCommandLang;
begin
//
end;

//==============================================================================
// Pnl_MainResize
//==============================================================================
procedure TfrmU210.Pnl_MainResize(Sender: TObject);
begin
  Pnl_In.Height := ((Sender as TPanel).Height div 3) -2 ;
  Pnl_Ot.Height := ((Sender as TPanel).Height div 3) -2 ;
end;

//==============================================================================
// tmrQryTimer
//==============================================================================
procedure TfrmU210.tmrQryTimer(Sender: TObject);
begin
  try
    (Sender as TTimer).Enabled := False ;
    fnCommandQuery;
  finally
    (Sender as TTimer).Enabled := True ;
  end;
end;

//==============================================================================
// AutoQryClick
//==============================================================================
procedure TfrmU210.PnlAutoQryClick(Sender: TObject);
begin
  if (Sender as TPanel).Tag = 1 then // 자동조회 -> 조회중지
  begin
    (Sender as TPanel).Tag := 2 ;
    (Sender as TPanel).BevelInner := bvLowered ;

    if (Sender as TPanel).Hint='IN' then
    begin
      ImgIn.Tag := 2;
      ImgIn.Picture.Bitmap := imgNO.Picture.Bitmap;
      PnlSelInfo1.Visible := True;
      edtJOB_NO_SEL1.Text := '';
    end else
    if (Sender as TPanel).Hint='OUT' then
    begin
      ImgOt.Tag := 2;
      ImgOt.Picture.Bitmap := imgNO.Picture.Bitmap;
      PnlSelInfo2.Visible := True;
      edtJOB_NO_SEL2.Text := '';
    end else
    begin
      ImgRack.Tag := 2;
      ImgRack.Picture.Bitmap := imgNO.Picture.Bitmap;
      PnlSelInfo3.Visible := True;
      edtJOB_NO_SEL3.Text := '';
    end;
  end else
  begin
    (Sender as TPanel).Tag := 1 ;
    (Sender as TPanel).BevelInner := bvRaised ;

    if (Sender as TPanel).Hint='IN' then
    begin
      ImgIn.Tag := 1;
      ImgIn.Picture.Bitmap := imgOK.Picture.Bitmap;
      PnlSelInfo1.Visible := False;
      edtJOB_NO_SEL1.Text := '';
    end else
    if (Sender as TPanel).Hint='OUT' then
    begin
      ImgOt.Tag := 1;
      ImgOt.Picture.Bitmap := imgOK.Picture.Bitmap;
      PnlSelInfo2.Visible := False;
      edtJOB_NO_SEL2.Text := '';
    end else
    begin
      ImgRack.Tag := 1;
      ImgRack.Picture.Bitmap := imgOK.Picture.Bitmap;
      PnlSelInfo3.Visible := False;
      edtJOB_NO_SEL3.Text := '';
    end;
  end;
end;

//==============================================================================
// ImgInClick
//==============================================================================
procedure TfrmU210.ImgAutoQryClick(Sender: TObject);
begin
  if (Sender as TImage).Tag = 1 then // 자동조회 -> 조회중지
  begin
    (Sender as TImage).Tag := 2 ;

    if (Sender as TImage).Hint='IN' then
    begin
      Pnl_AutoQry_In.Tag := 2 ;
      Pnl_AutoQry_In.BevelInner := bvLowered ;
      ImgIn.Picture.Bitmap := imgNO.Picture.Bitmap;
      PnlSelInfo1.Visible := True;
      edtJOB_NO_SEL1.Text := '';
    end else
    if (Sender as TImage).Hint='OUT' then
    begin
      Pnl_AutoQry_Ot.Tag := 2 ;
      Pnl_AutoQry_Ot.BevelInner := bvLowered ;
      ImgOt.Picture.Bitmap := imgNO.Picture.Bitmap;
      PnlSelInfo2.Visible := True;
      edtJOB_NO_SEL2.Text := '';
    end else
    begin
      Pnl_AutoQry_Rack.Tag := 2;
      Pnl_AutoQry_Rack.BevelInner := bvLowered ;
      ImgRack.Picture.Bitmap := imgNO.Picture.Bitmap;
      PnlSelInfo3.Visible := True;
      edtJOB_NO_SEL3.Text := '';
    end;
  end else
  begin
    (Sender as TImage).Tag := 1 ;

    if (Sender as TImage).Hint='IN' then
    begin
      Pnl_AutoQry_In.Tag := 1 ;
      Pnl_AutoQry_In.BevelInner := bvRaised ;
      ImgIn.Picture.Bitmap := imgOK.Picture.Bitmap;
      PnlSelInfo1.Visible := False;
      edtJOB_NO_SEL1.Text := '';
    end else
    if (Sender as TImage).Hint='OUT' then
    begin
      Pnl_AutoQry_Ot.Tag := 1 ;
      Pnl_AutoQry_Ot.BevelInner := bvRaised ;
      ImgOt.Picture.Bitmap := imgOK.Picture.Bitmap;
      PnlSelInfo2.Visible := False;
      edtJOB_NO_SEL2.Text := '';
    end else
    begin
      Pnl_AutoQry_Rack.Tag := 1 ;
      Pnl_AutoQry_Rack.BevelInner := bvRaised ;
      ImgRack.Picture.Bitmap := imgOK.Picture.Bitmap;
      PnlSelInfo3.Visible := False;
      edtJOB_NO_SEL3.Text := '';
    end;
  end;
end;

//==============================================================================
// dgInfo_InTitleClick
//==============================================================================
procedure TfrmU210.dgInfoTitleClick(Column: TColumnEh);
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
// dgInfoDrawColumnCell
//==============================================================================
procedure TfrmU210.dgInfoDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
  with Sender as TDBGridEh do
  begin
    try
      if DataSource.DataSet.Active and not DataSource.DataSet.IsEmpty then
      begin
        with DataSource.DataSet do
        begin
          if (FieldByName('JOBERRORC').AsString = '1') then
          begin
            Canvas.Font.Color := clRed;
            Canvas.Font.Style := [fsBold];
          end else
          begin
            Canvas.Font.Color := clBlack;
            Canvas.Font.Style := [];

            if DataCol=0 then
            begin
              if (FieldByName('JOBD').AsString = '1') then   // 입고
              begin
                Canvas.Font.Color := clNavy;
              end else                                       // 출고
              if (FieldByName('JOBD').AsString = '2') then
              begin
                if (FieldByName('EMG').AsString = '0') then
                     Canvas.Font.Color := clMaroon      // 일반출고
                else Canvas.Font.Color := clRed;        // 긴급출고
              end else
              begin
                Canvas.Font.Color := clGreen;
              end;
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
// chkGridInClick
//==============================================================================
procedure TfrmU210.chkGridInClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then
  begin
    chkGridOut.Checked := False;
    chkGridRack.Checked := False;
  end;
end;

//==============================================================================
// chkGridOutClick
//==============================================================================
procedure TfrmU210.chkGridOutClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then
  begin
    chkGridIn.Checked := False;
    chkGridRack.Checked := False;
  end;
end;

//==============================================================================
// chkGridOutClick
//==============================================================================
procedure TfrmU210.chkGridRackClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then
  begin
    chkGridIn.Checked := False;
    chkGridOut.Checked := False;
  end;
end;

//==============================================================================
// dgInfoCellClick
//==============================================================================
procedure TfrmU210.dgInfoCellClick_In(Column: TColumnEh);
begin
  try
    if (not qryInfo_In.Active) or (qryInfo_In.RecordCount = 0) then Exit;

    if ImgIn.Tag = 2 then
    begin // 자동조회 OFF 상태
      edtJOB_NO_SEL1.Text   := qryInfo_In.FieldByName('LUGG').AsString;
    end;
  except
    on E : Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'dgInfoCellClick_In', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure dgInfoCellClick Fail || ERR['+E.Message+']');
    end;
  end;
end;

procedure TfrmU210.dgInfoCellClick_Ot(Column: TColumnEh);
begin
  try
    if (not qryInfo_Ot.Active) or (qryInfo_Ot.RecordCount = 0) then Exit;

    if ImgOt.Tag = 2 then
    begin // 자동조회 OFF 상태
      edtJOB_NO_SEL2.Text   := qryInfo_Ot.FieldByName('LUGG').AsString;
    end;
  except
    on E : Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'dgInfoCellClick_Ot', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure dgInfoCellClick Fail || ERR['+E.Message+']');
    end;
  end;
end;

procedure TfrmU210.dgInfoCellClick_Rack(Column: TColumnEh);
begin
  try
    if (not qryInfo_Rack.Active) or (qryInfo_Rack.RecordCount = 0) then Exit;

    if ImgRack.Tag = 2 then
    begin // 자동조회 OFF 상태
      edtJOB_NO_SEL3.Text   := qryInfo_Rack.FieldByName('LUGG').AsString;
    end;
  except
    on E : Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'dgInfoCellClick_Rack', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure dgInfoCellClick Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// dgInfoCellClick 작업 취소/강제완료
//==============================================================================
procedure TfrmU210.sbtClick(Sender: TObject);
var
  IO, JobNo, ItmCd, IsAuto, Station, Loc, NowMc, NowStatus, ErrorStatus : String;
  LogStr : String;
begin
  if (((Sender as TSpeedButton).Tag = 1) or ((Sender as TSpeedButton).Tag = 2)) and
     ((Trim(edtJOB_NO_SEL1.Text) = '') or
      (not qryInfo_In.Active) or
      (qryInfo_In.RecordCount < 1) or
      (dgInfo_In.SelectedRows.Count <1) ) then
  begin
      MessageDlg('  입고 작업을 선택하지 않았습니다.' + #13#10 + #13#10 +
                 '  수동처리 할 입고 작업을 선택 후 진행해 주십시오.', mtConfirmation, [mbYes], 0);
      dgInfo_In.SetFocus;
      Exit;  
  end;
  
  if (((Sender as TSpeedButton).Tag = 3) or ((Sender as TSpeedButton).Tag = 4)) and 
     ((Trim(edtJOB_NO_SEL2.Text) = '') or
      (not qryInfo_Ot.Active) or
      (qryInfo_Ot.RecordCount < 1) or
      (dgInfo_Ot.SelectedRows.Count <1) ) then
  begin
      MessageDlg('  출고 작업을 선택하지 않았습니다.' + #13#10 + #13#10 +
                 '  수동처리 할 출고 작업을 선택 후 진행해 주십시오.', mtConfirmation, [mbYes], 0);
      dgInfo_Ot.SetFocus;
      Exit;  
  end;
  
  if (((Sender as TSpeedButton).Tag = 5) or ((Sender as TSpeedButton).Tag = 6)) and 
     ((Trim(edtJOB_NO_SEL3.Text) = '') or
      (not qryInfo_Rack.Active) or
      (qryInfo_Rack.RecordCount < 1) or
      (dgInfo_Rack.SelectedRows.Count <1) ) then
  begin
      MessageDlg('  이동 작업을 선택하지 않았습니다.' + #13#10 + #13#10 +
                 '  수동처리 할 이동 작업을 선택 후 진행해 주십시오.', mtConfirmation, [mbYes], 0);
      dgInfo_Rack.SetFocus;
      Exit;  
  end;
  
  Case (Sender as TSpeedButton).Tag of
    1,2 :
    begin
      JobNo := edtJOB_NO_SEL1.Text;
      IO := '입고';
      ItmCd       := qryInfo_In.FieldByName('ITM_CD').AsString;
      IsAuto      := qryInfo_In.FieldByName('IS_AUTO').AsString;
      Station     := qryInfo_In.FieldByName('LINE_NO').AsString;
      Loc         := qryInfo_In.FieldByName('ID_CODE').AsString;
      NowMc       := qryInfo_In.FieldByName('NOWMC_DESC').AsString;
      NowStatus   := qryInfo_In.FieldByName('NOWSTATUS_DESC').AsString;
      ErrorStatus := qryInfo_In.FieldByName('JOBERRORC_DESC').AsString + '-' +
                     qryInfo_In.FieldByName('JOBERRORD_DESC').AsString;
    end;
    3,4 :
    begin
      JobNo := edtJOB_NO_SEL2.Text;
      IO := '출고';
      ItmCd       := qryInfo_Ot.FieldByName('ITM_CD').AsString;
      IsAuto      := qryInfo_Ot.FieldByName('IS_AUTO').AsString;
      Station     := qryInfo_Ot.FieldByName('LINE_NO').AsString;
      Loc         := qryInfo_Ot.FieldByName('OD_CODE').AsString;
      NowMc       := qryInfo_Ot.FieldByName('NOWMC_DESC').AsString;
      NowStatus   := qryInfo_Ot.FieldByName('NOWSTATUS_DESC').AsString;
      ErrorStatus := qryInfo_Ot.FieldByName('JOBERRORC_DESC').AsString + '-' +
                     qryInfo_Ot.FieldByName('JOBERRORD_DESC').AsString;
    end;
    5,6 :
    begin
      JobNo := edtJOB_NO_SEL3.Text;
      IO := '랙이동';
      ItmCd       := qryInfo_Rack.FieldByName('ITM_CD').AsString;
      IsAuto      := qryInfo_Rack.FieldByName('IS_AUTO').AsString;
      Station     := qryInfo_Rack.FieldByName('LINE_NO').AsString;
      Loc         := qryInfo_Rack.FieldByName('OD_CODE').AsString + '->' + qryInfo_Ot.FieldByName('ID_CODE').AsString;
      NowMc       := qryInfo_Rack.FieldByName('NOWMC_DESC').AsString;
      NowStatus   := qryInfo_Rack.FieldByName('NOWSTATUS_DESC').AsString;
      ErrorStatus := qryInfo_Rack.FieldByName('JOBERRORC_DESC').AsString + '-' +
                     qryInfo_Rack.FieldByName('JOBERRORD_DESC').AsString;
    end;
  End;

  if MessageDlg('  [ '+JobNo+' ] 번 작업 처리 하시겠습니까?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit ;

  if not fnOrderDataSet(JobNo) then Exit;

  if (OrderData.JOBERRORC = '1') and (OrderData.JOBERRORD = 'RFID 불일치') then fnRFIDDataUpdate; // 알람 OFF

  LogStr := '기종코드[' + ItmCd + '], ' + #13#10 +
            '자동작업[' + IsAuto + '], ' + #13#10 +
            '스테이션[' + Station + '], ' + #13#10 +
            '랙위치[' + Loc + '], ' + #13#10 +
            '작업정보[' + NowMc + '], ' + #13#10 +
            '진행상태[' + NowStatus + '], ' + #13#10 +
            '에러상태[' + ErrorStatus + ']';
  if fnJobCheck(JobNo) then //작업중
  begin
    if (Sender as tSpeedButton).Tag mod 2 = 1 then
    begin
      fnUpdateSCSetInfo('JOB_CANCLE');//취소
      LogStr := 'SC 진행작업 취소' + #13#10 + LogStr ;
      InsertPGMHist('['+FormNo+']', 'N', 'sbtClick', '', LogStr, 'PGM', '', '', '');
    end else
    begin
      fnUpdateSCSetInfo('JOB_COMPLETE');//완료
      LogStr := 'SC 진행작업 강제완료'+ #13#10 + LogStr ;
      InsertPGMHist('['+FormNo+']', 'N', 'sbtClick', '', LogStr, 'PGM', '', '', '');
    end;
  end else //대기중
  begin
    if (Sender as tSpeedButton).Tag mod 2 = 1 then //취소
    begin
      fnOrderCancelAndComplet(IO,JobNo,'취소');
      LogStr := '작업취소' + #13#10 + LogStr ;
      InsertPGMHist('['+FormNo+']', 'N', 'sbtClick', '', LogStr, 'PGM', '', '', '');
    end else                                       //완료
    begin
      fnOrderCancelAndComplet(IO,JobNo,'완료');
      LogStr := '강제완료' + #13#10 + LogStr ;
      InsertPGMHist('['+FormNo+']', 'N', 'sbtClick', '', LogStr, 'PGM', '', '', '');
    end;
  end;
  fnAutoQuery(IO);
  fnCommandQuery;
end;
                     
//==============================================================================
// fnJobCheck 작업중 체크
//==============================================================================
function TfrmU210.fnJobCheck(JobNo: String): Boolean;
begin
  try
    Result := True;

    with qryTemp do
    begin  
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT * FROM TT_SCIO ' +
                  ' WHERE ID_INDEX = ''' + JobNo + ''' ' ;
      Open;
      
      if RecordCount < 1 then
      begin
        Result := False;                        
      end;
      Close;
    end;
  except
    on E : Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'dgInfoCellClick_Rack', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure dgInfoCellClick Fail || ERR['+E.Message+']');
      qryTemp.Close;
      Result := True;
    end;
  end;
end;
//==============================================================================
// fnUpdateSCSetInfo TC_SCSETINFO 업데이트
//==============================================================================
procedure TfrmU210.fnUpdateSCSetInfo(FieldName: String);
var
  StrSQL : String;
begin
  try
    strSQL := 'UPDATE TC_SCSETINFO SET '+ FieldName + ' = 1';
    with qryTemp do
    begin  
      Close;
      SQL.Clear;
      SQL.Text := strSQL;
      ExecSQL;     
    end;
  except
    on E : Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'fnUpdateSCSetInfo', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnUpdateSCSetInfo Fail || ERR['+E.Message+']');
      qryTemp.Close;
    end;
  end;
end;

//==============================================================================
// fnOrderCancelAndComplet 작업 완료 삭제
//==============================================================================
function TfrmU210.fnOrderCancelAndComplet(IO, JobNo, Order: String): Boolean;
var
  StrSQL, StrSQL2, StrSQL3, CellStatus, ITM_NAME, ITM_SPEC  : String;
  ExecNo : Integer;
begin
  if   UpperCase(OrderData.ITM_CD)='EPLT' then
  begin
    CellStatus := '1';
    ITM_NAME := '공팔레트';
    ITM_SPEC := '공팔레트';
  end else
  begin
    CellStatus := '2';
    ITM_NAME := '실팔레트';
    ITM_SPEC := '실팔레트';
  end;

  try
    if Order = '완료' then //완료
    begin
      if IO = '입고' then
      begin
        strSQL := ' UPDATE TT_ORDER ' +
                  '    SET NOWMC     = ''2'' ' +
                  '      , NOWSTATUS = ''4'' ' +
                  '      , JOBSTATUS = ''4'' ' +
                  '      , JOB_END   = ''1'' ' +
                  '      , ETC       = ''강제완료'' ' +
                  '  WHERE LUGG      = ''' + JobNo + ''' ' ;

        strSQL2 := ' Update TT_STOCK ' +
                   '    Set ITM_CD       = ' + QuotedStr(UpperCase(OrderData.ITM_CD)) +
                   '      , ITM_NAME     = ' + QuotedStr(fnITEM_Value('ITM_NAME', UpperCase(OrderData.ITM_CD))) +
                   '      , ITM_SPEC     = ' + QuotedStr(fnITEM_Value('ITM_SPEC', UpperCase(OrderData.ITM_CD))) +
                   '      , ITM_QTY      = 1' +
                   '      , ID_STATUS    = ' + QuotedStr(CellStatus) +
                   '      , STOCK_IN_DT  = GETDATE()   ' +
                   '      , ID_MEMO      = ' + QuotedStr(OrderData.ETC) +
                   '  Where ID_HOGI   = ''' + Copy(OrderData.DSTSITE,  4, 1)  + ''' ' +
                   '    AND ID_BANK   = ''' + Copy(OrderData.DSTAISLE, 4, 1)  + ''' ' + // 하역 열
                   '    AND ID_BAY    = ''' + Copy(OrderData.DSTBAY,   3, 2)  + ''' ' + // 하역 연
                   '    AND ID_LEVEL  = ''' + Copy(OrderData.DSTLEVEL, 3, 2)  + ''' ' ; // 하역 단
      end else
      if IO = '출고' then
      begin
        strSQL := ' UPDATE TT_ORDER ' +
                  '    SET NOWMC     = ''3'' ' +
                  '      , NOWSTATUS = ''4'' ' +
                  '      , JOBSTATUS = ''4'' ' +
                  '      , JOB_END   = ''1'' ' +
                  '      , ETC       = ''강제완료'' ' +                  
                  '  WHERE LUGG      = ''' + JobNo + ''' ' ;

        strSQL2 := ' Update TT_STOCK ' +
                   '    Set ITM_CD       = ''''  ' +
                   '      , ITM_NAME     = ''''  ' +
                   '      , ITM_SPEC     = ''''  ' +
                   '      , ITM_QTY      = 0     ' +
                   '      , ID_STATUS    = ''0'' ' +
                   '      , ID_MEMO      = ''''  ' +
                   '  Where ID_HOGI   = ''' + Copy(OrderData.SRCSITE,  4, 1)  + ''' ' +
                   '    AND ID_BANK   = ''' + Copy(OrderData.SRCAISLE, 4, 1)  + ''' ' + // 적재 열
                   '    AND ID_BAY    = ''' + Copy(OrderData.SRCBAY,   3, 2)  + ''' ' + // 적재 연
                   '    AND ID_LEVEL  = ''' + Copy(OrderData.SRCLEVEL, 3, 2)  + ''' ' ; // 적재 단
      end else
      begin
        strSQL := ' UPDATE TT_ORDER ' +
                  '    SET NOWMC     = ''2'' ' +
                  '      , NOWSTATUS = ''4'' ' +
                  '      , JOBSTATUS = ''4'' ' +
                  '      , JOB_END   = ''1'' ' +
                  '      , ETC       = ''강제완료'' ' +
                  '  WHERE LUGG      = ''' + JobNo + ''' ' ;

        strSQL2 := ' Update TT_STOCK ' +
                   '    Set ITM_CD       = ' + QuotedStr(UpperCase(OrderData.ITM_CD)) +
                   '      , ITM_NAME     = ' + QuotedStr(fnITEM_Value('ITM_NAME', UpperCase(OrderData.ITM_CD))) +
                   '      , ITM_SPEC     = ' + QuotedStr(fnITEM_Value('ITM_SPEC', UpperCase(OrderData.ITM_CD))) +
                   '      , ITM_QTY      = 1' +
                   '      , ID_STATUS    = ' + QuotedStr(CellStatus) +
                   '      , STOCK_IN_DT  = GETDATE()   ' +
                   '      , ID_MEMO      = ' + QuotedStr(OrderData.ETC) +
                   '  Where ID_HOGI   = ''' + Copy(OrderData.DSTSITE,  4, 1)  + ''' ' +
                   '    AND ID_BANK   = ''' + Copy(OrderData.DSTAISLE, 4, 1)  + ''' ' + // 하역 열
                   '    AND ID_BAY    = ''' + Copy(OrderData.DSTBAY,   3, 2)  + ''' ' + // 하역 연
                   '    AND ID_LEVEL  = ''' + Copy(OrderData.DSTLEVEL, 3, 2)  + ''' ' ; // 하역 단

        strSQL3 := ' Update TT_STOCK ' +
                   '    Set ITM_CD       = ''''  ' +
                   '      , ITM_NAME     = ''''  ' +
                   '      , ITM_SPEC     = ''''  ' +
                   '      , ITM_QTY      = 0     ' +
                   '      , ID_STATUS    = ''0'' ' +
                   '      , ID_MEMO      = ''''  ' +
                   '  Where ID_HOGI   = ''' + Copy(OrderData.SRCSITE,  4, 1)  + ''' ' +
                   '    AND ID_BANK   = ''' + Copy(OrderData.SRCAISLE, 4, 1)  + ''' ' + // 적재 열
                   '    AND ID_BAY    = ''' + Copy(OrderData.SRCBAY,   3, 2)  + ''' ' + // 적재 연
                   '    AND ID_LEVEL  = ''' + Copy(OrderData.SRCLEVEL, 3, 2)  + ''' ' ; // 적재 단
      end;
    end else               //취소
    begin
      strSQL := ' UPDATE TT_ORDER ' +
                '    SET JOB_END   = ''1'' ' +
                '      , ETC       = ''작업취소'' ' +
                '  WHERE LUGG      = ''' + JobNo + ''' ' ;
      if IO = '입고' then
      begin
        strSQL2 := ' Update TT_STOCK ' +
                   '    Set ID_STATUS    = ''0'' ' +
                   '  Where ID_HOGI   = ''' + Copy(OrderData.DSTSITE,  4, 1)  + ''' ' +
                   '    AND ID_BANK   = ''' + Copy(OrderData.DSTAISLE, 4, 1)  + ''' ' + // 적재 열
                   '    AND ID_BAY    = ''' + Copy(OrderData.DSTBAY,   3, 2)  + ''' ' + // 적재 연
                   '    AND ID_LEVEL  = ''' + Copy(OrderData.DSTLEVEL, 3, 2)  + ''' ' ; // 적재 단
      end else
      if IO = '출고' then
      begin
        strSQL2 := ' Update TT_STOCK ' +
                   '    Set ITM_CD       = ' + QuotedStr(OrderData.ITM_CD) +
                   '      , ITM_NAME     = ' + QuotedStr(ITM_NAME) +
                   '      , ITM_SPEC     = ' + QuotedStr(ITM_SPEC) +
                   '      , ITM_QTY      = ' + QuotedStr(OrderData.RF_BMA_NO) +
                   '      , ID_STATUS    = ' + QuotedStr(CellStatus) +
                   '      , ID_MEMO      = ' + QuotedStr(OrderData.ETC) +
                   '      , RF_LINE_NAME1  = ' + QuotedStr(OrderData.RF_LINE_NAME1) +
                   '      , RF_LINE_NAME2  = ' + QuotedStr(OrderData.RF_LINE_NAME2) +
                   '      , RF_PALLET_NO1  = ' + QuotedStr(OrderData.RF_PALLET_NO1) +
                   '      , RF_PALLET_NO2  = ' + QuotedStr(OrderData.RF_PALLET_NO2) +
                   '      , RF_MODEL_NO1   = ' + QuotedStr(OrderData.RF_MODEL_NO1) +
                   '      , RF_MODEL_NO2   = ' + QuotedStr(OrderData.RF_MODEL_NO2) +
                   '      , RF_BMA_NO      = ' + QuotedStr(OrderData.RF_BMA_NO) +
                   '      , RF_PALLET_BMA1 = ' + QuotedStr(OrderData.RF_PALLET_BMA1) +
                   '      , RF_PALLET_BMA2 = ' + QuotedStr(OrderData.RF_PALLET_BMA2) +
                   '      , RF_PALLET_BMA3 = ' + QuotedStr(OrderData.RF_PALLET_BMA3) +
                   '      , RF_NEW_BMA     = ' + QuotedStr(OrderData.RF_NEW_BMA) +
                   '  Where ID_HOGI   = ''' + Copy(OrderData.SRCSITE,  4, 1)  + ''' ' +
                   '    AND ID_BANK   = ''' + Copy(OrderData.SRCAISLE, 4, 1)  + ''' ' + // 적재 열
                   '    AND ID_BAY    = ''' + Copy(OrderData.SRCBAY,   3, 2)  + ''' ' + // 적재 연
                   '    AND ID_LEVEL  = ''' + Copy(OrderData.SRCLEVEL, 3, 2)  + ''' ' ; // 적재 단

      end else
      begin
        strSQL2 := ' Update TT_STOCK ' +
                   '    Set ID_STATUS    = ''0'' ' +
                   '  Where ID_HOGI   = ''' + Copy(OrderData.DSTSITE,  4, 1)  + ''' ' +
                   '    AND ID_BANK   = ''' + Copy(OrderData.DSTAISLE, 4, 1)  + ''' ' + // 적재 열
                   '    AND ID_BAY    = ''' + Copy(OrderData.DSTBAY,   3, 2)  + ''' ' + // 적재 연
                   '    AND ID_LEVEL  = ''' + Copy(OrderData.DSTLEVEL, 3, 2)  + ''' ' ; // 적재 단

        strSQL3 := ' Update TT_STOCK ' +
                   '    Set ID_STATUS = ' + QuotedStr(CellStatus) +
                   '  Where ID_HOGI   = ''' + Copy(OrderData.SRCSITE,  4, 1)  + ''' ' +
                   '    AND ID_BANK   = ''' + Copy(OrderData.SRCAISLE, 4, 1)  + ''' ' + // 적재 열
                   '    AND ID_BAY    = ''' + Copy(OrderData.SRCBAY,   3, 2)  + ''' ' + // 적재 연
                   '    AND ID_LEVEL  = ''' + Copy(OrderData.SRCLEVEL, 3, 2)  + ''' ' ; // 적재 단
      end;
    end;
    with qryTemp do
    begin
      Close;
      SQL.Clear;

      if not MainDM.MainDB.InTransaction then
             MainDM.MainDB.BeginTrans ;

      SQL.Text := strSQL;
      ExecNo := ExecSQL;

      if ExecNo > 0 then
      begin
        SQL.Text := strSQL2;
        ExecNo := ExecSQL;

        if (ExecNo > 0) And
           (IO = '랙이동') then
        begin
          SQL.Text := strSQL3;
          ExecNo := ExecSQL;
        end;
      end;

      InsertPGMHist('['+FormNo+']', 'N', 'fnOrderCancelAndComplet', Order,Order+'-'+IO+'-'+JobNo,'SQL', StrSQL, '', '');
      MainDM.MainDB.CommitTrans;
      fnIns_History(JobNo);
      qryTemp.Close;
    end;
  except
    on E : Exception do
    begin
      MainDM.MainDB.RollbackTrans;
      InsertPGMHist('['+FormNo+']', 'E', 'fnOrderCancelAndComplet', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnOrderCancelAndComplet Fail || ERR['+E.Message+']');
      qryTemp.Close;
    end;
  end;
end;

//==============================================================================
// fnUpdateSCSetInfo TC_SCSETINFO 업데이트
//==============================================================================
function TfrmU210.fnOrderDataSet(JobNo : String): Boolean;
var
  StrSQL : String;
begin

  try
    StrSQL := ' SELECT * FROM TT_ORDER ' +
              '  WHERE LUGG = ''' + JobNo + ''' ';
    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := strSQL;
      Open;
    end;
    OrderData.REG_TIME       := '';
    OrderData.LUGG           := qryTemp.FieldByName('LUGG').AsString;
    OrderData.JOBD           := '';
    OrderData.IS_AUTO        := '';
    OrderData.LINE_NO        := '';
    OrderData.SRCSITE        := qryTemp.FieldByName('SRCSITE' ).AsString;
    OrderData.SRCAISLE       := qryTemp.FieldByName('SRCAISLE').AsString;
    OrderData.SRCBAY         := qryTemp.FieldByName('SRCBAY'  ).AsString;
    OrderData.SRCLEVEL       := qryTemp.FieldByName('SRCLEVEL').AsString;
    OrderData.DSTSITE        := qryTemp.FieldByName('DSTSITE' ).AsString;
    OrderData.DSTAISLE       := qryTemp.FieldByName('DSTAISLE').AsString;
    OrderData.DSTBAY         := qryTemp.FieldByName('DSTBAY'  ).AsString;
    OrderData.DSTLEVEL       := qryTemp.FieldByName('DSTLEVEL').AsString;
    OrderData.NOWMC          := qryTemp.FieldByName('NOWMC'   ).AsString;
    OrderData.JOBSTATUS      := '';
    OrderData.NOWSTATUS      := '';
    OrderData.BUFFSTATUS     := '';
    OrderData.JOBREWORK      := '';
    OrderData.JOBERRORT      := '';
    OrderData.JOBERRORC      := qryTemp.FieldByName('JOBERRORC').AsString;
    OrderData.JOBERRORD      := qryTemp.FieldByName('JOBERRORD').AsString;
    OrderData.JOB_END        := '';
    OrderData.CVFR           := '';
    OrderData.CVTO           := '';
    OrderData.CVCURR         := '';
    OrderData.ETC            := qryTemp.FieldByName('ETC').AsString;
    OrderData.EMG            := '';
    OrderData.ITM_CD         := qryTemp.FieldByName('ITM_CD').AsString;
    OrderData.UP_TIME        := '';
    OrderData.ID_CODE        := '';
    OrderData.RF_LINE_NAME1  := qryTemp.FieldByName('RF_LINE_NAME1' ).AsString;
    OrderData.RF_LINE_NAME2  := qryTemp.FieldByName('RF_LINE_NAME2' ).AsString;
    OrderData.RF_PALLET_NO1  := qryTemp.FieldByName('RF_PALLET_NO1' ).AsString;
    OrderData.RF_PALLET_NO2  := qryTemp.FieldByName('RF_PALLET_NO2' ).AsString;
    OrderData.RF_MODEL_NO1   := qryTemp.FieldByName('RF_MODEL_NO1'  ).AsString;
    OrderData.RF_MODEL_NO2   := qryTemp.FieldByName('RF_MODEL_NO2'  ).AsString;
    OrderData.RF_BMA_NO      := qryTemp.FieldByName('RF_BMA_NO'     ).AsString;
    OrderData.RF_PALLET_BMA1 := qryTemp.FieldByName('RF_PALLET_BMA1').AsString;
    OrderData.RF_PALLET_BMA2 := qryTemp.FieldByName('RF_PALLET_BMA2').AsString;
    OrderData.RF_PALLET_BMA3 := qryTemp.FieldByName('RF_PALLET_BMA3').AsString;
    OrderData.RF_AREA        := qryTemp.FieldByName('RF_AREA'       ).AsString;
    Result := True;
  except
    on E : Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'fnOrderDataSet', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnOrderDataSet Fail || ERR['+E.Message+']');
      qryTemp.Close;
      Result := False;
    end;
  end;
end;

//==============================================================================
// OrderDataClear [구조체 초기화]
//==============================================================================
procedure TfrmU210.OrderDataClear(OrderData: TJobOrder);
begin
  OrderData.REG_TIME       := '';
  OrderData.LUGG           := '';
  OrderData.JOBD           := '';
  OrderData.IS_AUTO        := '';
  OrderData.LINE_NO        := '';
  OrderData.SRCSITE        := '';
  OrderData.SRCAISLE       := '';
  OrderData.SRCBAY         := '';
  OrderData.SRCLEVEL       := '';
  OrderData.DSTSITE        := '';
  OrderData.DSTAISLE       := '';
  OrderData.DSTBAY         := '';
  OrderData.DSTLEVEL       := '';
  OrderData.NOWMC          := '';
  OrderData.JOBSTATUS      := '';
  OrderData.NOWSTATUS      := '';
  OrderData.BUFFSTATUS     := '';
  OrderData.JOBREWORK      := '';
  OrderData.JOBERRORT      := '';
  OrderData.JOBERRORC      := '';
  OrderData.JOBERRORD      := '';
  OrderData.JOB_END        := '';
  OrderData.CVFR           := '';
  OrderData.CVTO           := '';
  OrderData.CVCURR         := '';
  OrderData.ETC            := '';
  OrderData.EMG            := '';
  OrderData.ITM_CD         := '';
  OrderData.UP_TIME        := '';
  OrderData.ID_CODE        := '';
  OrderData.RF_LINE_NAME1  := '';
  OrderData.RF_LINE_NAME2  := '';
  OrderData.RF_PALLET_NO1  := '';
  OrderData.RF_PALLET_NO2  := '';
  OrderData.RF_MODEL_NO1   := '';
  OrderData.RF_MODEL_NO2   := '';
  OrderData.RF_BMA_NO      := '';
  OrderData.RF_PALLET_BMA1 := '';
  OrderData.RF_PALLET_BMA2 := '';
  OrderData.RF_PALLET_BMA3 := '';
  OrderData.RF_AREA        := '';
end;

//==============================================================================
// fnITEM_Value : TM_ITEM 데이터 반환
//==============================================================================
function TfrmU210.fnITEM_Value(FName, FValue : String): String;
var
  StrSQL : string;
begin
  Result := '' ;
  StrSQL := ' SELECT ' + Fname + ' as DATA ' +
            '   FROM TM_ITEM    ' +
            '  WHERE ITM_CD = ''' + FValue + ''' ' ;


  try
    with qryTemp do
    begin
      Close;
      SQL.Clear ;
      SQL.Text := StrSQL ;
      Open ;
      if not (Bof and Eof) then
      begin
        Result := FieldByName('Data').AsString ;
      end;
      Close ;
    end;
  except
    on E: Exception do
    begin
      InsertPGMHist('['+FormNo+']', 'E', 'fnITEM_Value', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnITEM_Value Fail || ERR['+E.Message+']');
      qryTemp.Close;
    end;
  end;
end;

//==============================================================================
// fnIns_History : TT_ORDER를 History에 넣고 삭제
//==============================================================================
procedure TfrmU210.fnIns_History(JobNo: String);
var
  StrSQL : string;
  ExecNo : Integer;
begin
  StrSQL := '';
  try
    with qryTemp do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' INSERT INTO TT_HISTORY (REG_TIME, LUGG, JOBD, IS_AUTO, LINE_NO, ' +
                                        ' SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL, ' +
                            					  ' DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL, ' +
					                              '	NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS, ' +
					                              '	JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD, ' +
					                              ' JOB_END, CVFR, CVTO, CVCURR, ' +
					                              '	ETC, EMG, ITM_CD, UP_TIME, HIS_TIME, ' +
					                              '	RF_LINE_NAME1, RF_LINE_NAME2, RF_PALLET_NO1, ' +
                                        ' RF_PALLET_NO2, RF_MODEL_NO1, RF_MODEL_NO2, ' +
                                        ' RF_BMA_NO, RF_PALLET_BMA1,RF_PALLET_BMA2, ' +
                                        ' RF_PALLET_BMA3, RF_AREA) ' +
                      ' SELECT REG_TIME, LUGG, JOBD, IS_AUTO, LINE_NO, ' +
                             ' SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL, ' +
		                         ' DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL, ' +
		                         ' NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS, ' +
		                         ' JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD, ' +
		                         ' JOB_END, CVFR, CVTO, CVCURR, ' +
		                         ' ETC, EMG, ITM_CD, UP_TIME, GETDATE(), ' +
                             ' RF_LINE_NAME1, RF_LINE_NAME2, RF_PALLET_NO1, ' +
                             ' RF_PALLET_NO2, RF_MODEL_NO1, RF_MODEL_NO2, ' +
                             ' RF_BMA_NO, RF_PALLET_BMA1,RF_PALLET_BMA2, ' +
                             ' RF_PALLET_BMA3, RF_AREA ' +
                        ' FROM TT_ORDER ' +
                       ' WHERE LUGG = '  + QuotedStr(JobNo) ;
      SQL.Text := StrSQL ;
      ExecNo := ExecSql ;

      if (ExecNo > 0) then
      begin
        Close;
        SQL.Clear;
        StrSQL := ' DELETE FROM TT_ORDER ' +
                  '  WHERE LUGG = '  + QuotedStr(JobNo) ;
        SQL.Text := StrSQL;
        ExecSql;
      end;

      Close ;
    end;
  except
    on E: Exception do
    begin
      qryTemp.Close ;
      InsertPGMHist('['+FormNo+']', 'E', 'fnIns_History', '', 'Exception Error', 'PGM', '', '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnIns_History Fail || ERR['+E.Message+']');
    end;
  end;
end;

//==============================================================================
// fnAutoQuery
//==============================================================================
procedure TfrmU210.fnAutoQuery(IO : String);
begin
  if IO = '입고' then
  Begin
    Pnl_AutoQry_In.Tag := 1;
    Pnl_AutoQry_In.BevelInner := bvRaised ;
    ImgIn.Tag := 1;
    ImgIn.Picture.Bitmap := imgOK.Picture.Bitmap;
    PnlSelInfo1.Visible := False;
    edtJOB_NO_SEL1.Text := '';
  End else
  if IO = '출고' then
  begin
    Pnl_AutoQry_Ot.Tag := 1;
    Pnl_AutoQry_Ot.BevelInner := bvRaised ;
    ImgOt.Tag := 1;
    ImgOt.Picture.Bitmap := imgOK.Picture.Bitmap;
    PnlSelInfo2.Visible := False;
    edtJOB_NO_SEL2.Text := '';
  end else
  begin
    Pnl_AutoQry_Rack.Tag := 1;
    Pnl_AutoQry_Rack.BevelInner := bvRaised ;
    ImgRack.Tag := 1;
    ImgRack.Picture.Bitmap := imgOK.Picture.Bitmap;
    PnlSelInfo3.Visible := False;
    edtJOB_NO_SEL3.Text := '';
  end;
end;

//==============================================================================
// fnCurtainMsg   clRed  clFuchsia
//==============================================================================
procedure TfrmU210.fnRFIDDataUpdate;
var
  StrSQL : String ;
begin
  StrSQL := ' UPDATE TC_CURRENT ' +
            '    SET OPTION1 = ''1'''+
            '  WHERE CURRENT_NAME = ''ALRAM_OFF'' ';
  try
    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      ExecSQL;
    end;
  except
    on E : Exception do
    begin
      qryTemp.Close;
      InsertPGMHist('['+FormNo+']', 'E', 'fnRFIDDataUpdate', '', 'Exception Error', 'SQL', StrSQL, '', E.Message);
      TraceLogWrite('['+FormNo+'] procedure fnRFIDDataUpdate Fail || ERR['+E.Message+'], SQL['+StrSQL+']');
    end;
  end;
end;


end.



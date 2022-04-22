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

    function fnJobCheck(JobNo: String): Boolean; //�۾����� üũ
    function fnOrderCancelAndComplet(IO, JobNo, Order: String): Boolean; //�۾��Ϸ�,����
    function fnOrderDataSet(JobNo : String): Boolean; // TT_ORDER ������ ����
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
// fnCommandOrder [����]
//==============================================================================
procedure TfrmU210.fnCommandOrder  ;
begin
//
end;

//==============================================================================
// fnCommandAdd [�ű�]                                                        //
//==============================================================================
procedure TfrmU210.fnCommandAdd  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [����]
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
// fnCommandDelete [����]
//==============================================================================
procedure TfrmU210.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandUpdate [����]                                                     //
//==============================================================================
procedure TfrmU210.fnCommandUpdate;
begin
//
end;

//==============================================================================
// fnCommandPrint [�μ�]
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
procedure TfrmU210.fnCommandQuery;
var
  StrSQL : String;
begin
  try
    // �԰���Ȳ
    if Pnl_AutoQry_In.Tag=1 then
    begin
      with qryInfo_In do
      begin
        Close;
        SQL.Clear;
        SQL.Text := ' Select REG_TIME, LUGG, JOBD, LINE_NO,                                                                       ' +
                    '        SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL                                                                  ' +
                    '        DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL                                                                  ' +
                    '        NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS                                                              ' +
                    '        JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD                                                           ' +
                    '        CVFR, CVTO, CVCURR, ETC, EMG, ITM_CD,                                                                ' +
                    '       (Case JOBD  when ''1'' then ''�԰�''                                                                      ' +
                    '                   when ''2'' then ''���'' end) as JOBD_DESC,                                                   ' +
                    '       (Case NOWMC when ''1'' then ''������ �۾�''                                                               ' +
                    '                   when ''2'' then ''����Ŀ ����''                                                               ' +
                    '                   when ''3'' then ''����Ŀ �Ͽ�'' end) as NOWMC_DESC,                                           ' +
                    '       (Case NOWSTATUS when ''1'' then ''���''                                                                  ' +
                    '                       when ''2'' then ''����''                                                                  ' +
                    '                       when ''3'' then ''����''                                                                  ' +
                    '                       when ''4'' then ''�Ϸ�'' end) as NOWSTATUS_DESC,                                          ' +
                    '       (Case JOBERRORC when ''0'' then ''����''                                                                  ' +
                    '                       when ''1'' then ''����'' end) as JOBERRORC_DESC,                                          ' +
                    '       (Case JOBERRORD when ''0000'' then ''����''                                                               ' +
                    '                       else JOBERRORD end) as JOBERRORD_DESC,                                                ' +
                    '       (Case BUFFSTATUS when ''0'' then ''���''                                                                 ' +
                    '                        when ''1'' then ''�԰���'' end) as BUFFSTATUS_DESC,                                    ' +
                    '       (SUBSTRING(DSTAISLE,4,1)+''-''+SUBSTRING(DSTBAY,3,2)+''-''+SUBSTRING(DSTLEVEL,3,2)) as ID_CODE,           ' +
                    '       (SUBSTRING(REG_TIME,1,4)+''-''+SUBSTRING(REG_TIME,5,2)+''-''+SUBSTRING(REG_TIME,7,2)+                     ' +
                    '        SUBSTRING(REG_TIME,9,2)+'':''+SUBSTRING(REG_TIME,11,2)+'':''+SUBSTRING(REG_TIME,13,2)) as REF_TIME_CONV, ' +
                    '       CONVERT(VARCHAR, REG_TIME, 120) as REG_TIME_DESC ' +
                    '   From TT_ORDER          ' +
                    '  Where JOBD    = ''1''   ' +
                    '    And JOB_END = ''0''   ' +
                    '  Order By REG_TIME, LUGG ';
        Open;
      end;
    end;

    // �����Ȳ
    if Pnl_AutoQry_Ot.Tag=1 then
    begin
      with qryInfo_Ot do
      begin
        Close;
        SQL.Clear;
        SQL.Text := ' Select REG_TIME, LUGG, JOBD, LINE_NO,             ' +  #13#10+
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
                    '       (Case JOBERRORC when ''0'' then ''����'' ' +  #13#10+
                    '                       when ''1'' then ''����'' end) as JOBERRORC_DESC, ' +  #13#10+
                    '       (Case JOBERRORD when ''0000'' then ''����'' ' +  #13#10+
                    '                       else JOBERRORD end) as JOBERRORD_DESC, ' +  #13#10+
                    '       (Case BUFFSTATUS when ''0'' then ''���'' ' +  #13#10+
                    '                        when ''1'' then ''�԰���'' end) as BUFFSTATUS_DESC, ' +  #13#10+
                    '       (SUBSTRING(DSTAISLE,4,1)+''-''+SUBSTRING(DSTBAY,3,2)+''-''+FORMAT(CONVERT(INT,DSTLEVEL), ''D2'')) as ID_CODE,           ' +
                    '       (SUBSTRING(REG_TIME,1,4)+''-''+SUBSTRING(REG_TIME,5,2)+''-''+SUBSTRING(REG_TIME,7,2)+                     ' +
                    '        SUBSTRING(REG_TIME,9,2)+'':''+SUBSTRING(REG_TIME,11,2)+'':''+SUBSTRING(REG_TIME,13,2)) as REF_TIME_CONV, ' +
                    '       CONVERT(VARCHAR, REG_TIME, 120) as REG_TIME_DESC ' +
                    '   From TT_ORDER ' +  #13#10+
                    '  Where JOBD    = ''2'' ' +  #13#10+
                    '    And JOB_END = ''0'' ' +  #13#10+
                    '  Order By EMG DESC, REG_TIME, LUGG ASC ' ;
        Open;
      end;
    end;

    // ���̵���Ȳ
    if Pnl_AutoQry_Rack.Tag=1 then
    begin
      with qryInfo_Rack do
      begin
        Close;
        SQL.Clear;
        SQL.Text := ' Select REG_TIME, LUGG, JOBD, LINE_NO,             ' +  #13#10+
                    '        SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL        ' +  #13#10+
                    '        DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL        ' +  #13#10+
                    '        NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS    ' +  #13#10+
                    '        JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD ' +  #13#10+
                    '        CVFR, CVTO, CVCURR, ETC, EMG, ITM_CD,      ' +  #13#10+
                    '       (Case when (JOBD=''1'') then ''�԰�'' ' +  #13#10+
                    '             when (JOBD=''2'') and (EMG=''0'') then ''���'' ' +  #13#10+
                    '             when (JOBD=''2'') and (EMG=''1'') then ''������'' ' +  #13#10+
                    '             when (JOBD=''7'') then ''���̵�'' end) as JOBD_DESC, ' +  #13#10+
                    '       (Case NOWMC when ''1'' then ''������ �۾�'' ' +  #13#10+
                    '                   when ''2'' then ''����Ŀ ����'' ' +  #13#10+
                    '                   when ''3'' then ''����Ŀ �Ͽ�'' end) as NOWMC_DESC, ' +  #13#10+
                    '       (Case NOWSTATUS when ''1'' then ''���'' ' +  #13#10+
                    '                       when ''2'' then ''����'' ' +  #13#10+
                    '                       when ''3'' then ''����'' ' +  #13#10+
                    '                       when ''4'' then ''�Ϸ�'' end) as NOWSTATUS_DESC, ' +  #13#10+
                    '       (Case JOBERRORC when ''0'' then ''����'' ' +  #13#10+
                    '                       when ''1'' then ''����'' end) as JOBERRORC_DESC, ' +  #13#10+
                    '       (Case JOBERRORD when ''0000'' then ''����'' ' +  #13#10+
                    '                       else JOBERRORD end) as JOBERRORD_DESC, ' +  #13#10+
                    '       (Case BUFFSTATUS when ''0'' then ''���'' ' +  #13#10+
                    '                        when ''1'' then ''�԰���'' end) as BUFFSTATUS_DESC, ' +  #13#10+
                    '       (SUBSTRING(DSTAISLE,4,1)+''-''+SUBSTRING(DSTBAY,3,2)+''-''+FORMAT(CONVERT(INT,DSTLEVEL), ''D2'')) as ID_CODE,           ' +
                    '       (SUBSTRING(REG_TIME,1,4)+''-''+SUBSTRING(REG_TIME,5,2)+''-''+SUBSTRING(REG_TIME,7,2)+                     ' +
                    '        SUBSTRING(REG_TIME,9,2)+'':''+SUBSTRING(REG_TIME,11,2)+'':''+SUBSTRING(REG_TIME,13,2)) as REF_TIME_CONV, ' +
                    '       CONVERT(VARCHAR, REG_TIME, 120) as REG_TIME_DESC ' +
                    '   From TT_ORDER ' +  #13#10+
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
// fnCommandLang [���]                                                       //
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
  if (Sender as TPanel).Tag = 1 then // �ڵ���ȸ -> ��ȸ����
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
  if (Sender as TImage).Tag = 1 then // �ڵ���ȸ -> ��ȸ����
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
              if (FieldByName('JOBD').AsString = '1') then   // �԰�
              begin
                Canvas.Font.Color := clNavy;
              end else                                       // ���
              if (FieldByName('JOBD').AsString = '2') then
              begin
                if (FieldByName('EMG').AsString = '0') then
                     Canvas.Font.Color := clMaroon      // �Ϲ����
                else Canvas.Font.Color := clRed;        // ������
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
    begin // �ڵ���ȸ OFF ����
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
    begin // �ڵ���ȸ OFF ����
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
    begin // �ڵ���ȸ OFF ����
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
// dgInfoCellClick �۾� ���/�����Ϸ�
//==============================================================================
procedure TfrmU210.sbtClick(Sender: TObject);
var
  IO,JobNo : String;

begin
  if (((Sender as TSpeedButton).Tag = 1) or ((Sender as TSpeedButton).Tag = 2)) and
     ((Trim(edtJOB_NO_SEL1.Text) = '') or
      (not qryInfo_In.Active) or
      (qryInfo_In.RecordCount < 1) or
      (dgInfo_In.SelectedRows.Count <1) ) then
  begin
      MessageDlg('  �԰� �۾��� �������� �ʾҽ��ϴ�.' + #13#10 + #13#10 +
                 '  ����ó�� �� �԰� �۾��� ���� �� ������ �ֽʽÿ�.', mtConfirmation, [mbYes], 0);
      dgInfo_In.SetFocus;
      Exit;  
  end;
  
  if (((Sender as TSpeedButton).Tag = 3) or ((Sender as TSpeedButton).Tag = 4)) and 
     ((Trim(edtJOB_NO_SEL2.Text) = '') or
      (not qryInfo_Ot.Active) or
      (qryInfo_Ot.RecordCount < 1) or
      (dgInfo_Ot.SelectedRows.Count <1) ) then
  begin
      MessageDlg('  ��� �۾��� �������� �ʾҽ��ϴ�.' + #13#10 + #13#10 +
                 '  ����ó�� �� ��� �۾��� ���� �� ������ �ֽʽÿ�.', mtConfirmation, [mbYes], 0);
      dgInfo_In.SetFocus;
      Exit;  
  end;
  
  if (((Sender as TSpeedButton).Tag = 5) or ((Sender as TSpeedButton).Tag = 6)) and 
     ((Trim(edtJOB_NO_SEL3.Text) = '') or
      (not qryInfo_Rack.Active) or
      (qryInfo_Rack.RecordCount < 1) or
      (dgInfo_Rack.SelectedRows.Count <1) ) then
  begin
      MessageDlg('  �̵� �۾��� �������� �ʾҽ��ϴ�.' + #13#10 + #13#10 +
                 '  ����ó�� �� �̵� �۾��� ���� �� ������ �ֽʽÿ�.', mtConfirmation, [mbYes], 0);
      dgInfo_In.SetFocus;
      Exit;  
  end;
  
  Case (Sender as TSpeedButton).Tag of
    1,2 : begin JobNo := edtJOB_NO_SEL1.Text; IO := '�԰�'; end;
    3,4 : begin JobNo := edtJOB_NO_SEL2.Text; IO := '���'; end;
    5,6 : begin JobNo := edtJOB_NO_SEL3.Text; IO := '���̵�'; end;
  End;

  if MessageDlg('  [ '+JobNo+' ] �� �۾� ó�� �Ͻðڽ��ϱ�?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit ;

  if not fnOrderDataSet(JobNo) then Exit;

  if (OrderData.JOBERRORC = '1') and (OrderData.JOBERRORD = 'RFID ����ġ') then fnRFIDDataUpdate; // �˶� OFF

  if fnJobCheck(JobNo) then //�۾���
  begin 
    if (Sender as tSpeedButton).Tag mod 2 = 1 then
    begin
      fnUpdateSCSetInfo('JOB_CANCLE');//���  
    end else
    begin
      fnUpdateSCSetInfo('JOB_COMPLETE');//�Ϸ�   
    end;
  end else //�����
  begin
    if (Sender as tSpeedButton).Tag mod 2 = 1 then //���
    begin
      fnOrderCancelAndComplet(IO,JobNo,'���');
    end else                                       //�Ϸ�
    begin
      fnOrderCancelAndComplet(IO,JobNo,'�Ϸ�');
    end;
  end;
  fnAutoQuery(IO);
  fnCommandQuery;
end;
                     
//==============================================================================
// fnJobCheck �۾��� üũ
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
// fnUpdateSCSetInfo TC_SCSETINFO ������Ʈ
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
// fnOrderCancelAndComplet �۾� �Ϸ� ����
//==============================================================================
function TfrmU210.fnOrderCancelAndComplet(IO, JobNo, Order: String): Boolean;
var
  StrSQL, StrSQL2, StrSQL3, CellStatus, ITM_NAME, ITM_SPEC  : String;
  ExecNo : Integer;
begin
  if   UpperCase(OrderData.ITM_CD)='EPLT' then
  begin
    CellStatus := '1';
    ITM_NAME := '���ȷ�Ʈ';
    ITM_SPEC := '���ȷ�Ʈ';
  end else
  begin
    CellStatus := '2';
    ITM_NAME := '���ȷ�Ʈ';
    ITM_SPEC := '���ȷ�Ʈ';
  end;

  try
    if Order = '�Ϸ�' then //�Ϸ�
    begin
      if IO = '�԰�' then
      begin
        strSQL := ' UPDATE TT_ORDER ' +
                  '    SET NOWMC     = ''2'' ' +
                  '      , NOWSTATUS = ''4'' ' +
                  '      , JOBSTATUS = ''4'' ' +
                  '      , JOB_END   = ''1'' ' +
                  '      , ETC       = ''�����Ϸ�'' ' +
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
                   '    AND ID_BANK   = ''' + Copy(OrderData.DSTAISLE, 4, 1)  + ''' ' + // �Ͽ� ��
                   '    AND ID_BAY    = ''' + Copy(OrderData.DSTBAY,   3, 2)  + ''' ' + // �Ͽ� ��
                   '    AND ID_LEVEL  = ''' + Copy(OrderData.DSTLEVEL, 3, 2)  + ''' ' ; // �Ͽ� ��
      end else
      if IO = '���' then
      begin
        strSQL := ' UPDATE TT_ORDER ' +
                  '    SET NOWMC     = ''3'' ' +
                  '      , NOWSTATUS = ''4'' ' +
                  '      , JOBSTATUS = ''4'' ' +
                  '      , JOB_END   = ''1'' ' +
                  '      , ETC       = ''�����Ϸ�'' ' +                  
                  '  WHERE LUGG      = ''' + JobNo + ''' ' ;

        strSQL2 := ' Update TT_STOCK ' +
                   '    Set ITM_CD       = ''''  ' +
                   '      , ITM_NAME     = ''''  ' +
                   '      , ITM_SPEC     = ''''  ' +
                   '      , ITM_QTY      = 0     ' +
                   '      , ID_STATUS    = ''0'' ' +
                   '      , ID_MEMO      = ''''  ' +
                   '  Where ID_HOGI   = ''' + Copy(OrderData.SRCSITE,  4, 1)  + ''' ' +
                   '    AND ID_BANK   = ''' + Copy(OrderData.SRCAISLE, 4, 1)  + ''' ' + // ���� ��
                   '    AND ID_BAY    = ''' + Copy(OrderData.SRCBAY,   3, 2)  + ''' ' + // ���� ��
                   '    AND ID_LEVEL  = ''' + Copy(OrderData.SRCLEVEL, 3, 2)  + ''' ' ; // ���� ��
      end else
      begin
        strSQL := ' UPDATE TT_ORDER ' +
                  '    SET NOWMC     = ''2'' ' +
                  '      , NOWSTATUS = ''4'' ' +
                  '      , JOBSTATUS = ''4'' ' +
                  '      , JOB_END   = ''1'' ' +
                  '      , ETC       = ''�����Ϸ�'' ' +
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
                   '    AND ID_BANK   = ''' + Copy(OrderData.DSTAISLE, 4, 1)  + ''' ' + // �Ͽ� ��
                   '    AND ID_BAY    = ''' + Copy(OrderData.DSTBAY,   3, 2)  + ''' ' + // �Ͽ� ��
                   '    AND ID_LEVEL  = ''' + Copy(OrderData.DSTLEVEL, 3, 2)  + ''' ' ; // �Ͽ� ��

        strSQL3 := ' Update TT_STOCK ' +
                   '    Set ITM_CD       = ''''  ' +
                   '      , ITM_NAME     = ''''  ' +
                   '      , ITM_SPEC     = ''''  ' +
                   '      , ITM_QTY      = 0     ' +
                   '      , ID_STATUS    = ''0'' ' +
                   '      , ID_MEMO      = ''''  ' +
                   '  Where ID_HOGI   = ''' + Copy(OrderData.SRCSITE,  4, 1)  + ''' ' +
                   '    AND ID_BANK   = ''' + Copy(OrderData.SRCAISLE, 4, 1)  + ''' ' + // ���� ��
                   '    AND ID_BAY    = ''' + Copy(OrderData.SRCBAY,   3, 2)  + ''' ' + // ���� ��
                   '    AND ID_LEVEL  = ''' + Copy(OrderData.SRCLEVEL, 3, 2)  + ''' ' ; // ���� ��
      end;
    end else               //���
    begin
      strSQL := ' UPDATE TT_ORDER ' +
                '    SET JOB_END   = ''1'' ' +
                '      , ETC       = ''�۾����'' ' +
                '  WHERE LUGG      = ''' + JobNo + ''' ' ;
      if IO = '�԰�' then
      begin
        strSQL2 := ' Update TT_STOCK ' +
                   '    Set ID_STATUS    = ''0'' ' +
                   '  Where ID_HOGI   = ''' + Copy(OrderData.DSTSITE,  4, 1)  + ''' ' +
                   '    AND ID_BANK   = ''' + Copy(OrderData.DSTAISLE, 4, 1)  + ''' ' + // ���� ��
                   '    AND ID_BAY    = ''' + Copy(OrderData.DSTBAY,   3, 2)  + ''' ' + // ���� ��
                   '    AND ID_LEVEL  = ''' + Copy(OrderData.DSTLEVEL, 3, 2)  + ''' ' ; // ���� ��
      end else
      if IO = '���' then
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
                   '  Where ID_HOGI   = ''' + Copy(OrderData.SRCSITE,  4, 1)  + ''' ' +
                   '    AND ID_BANK   = ''' + Copy(OrderData.SRCAISLE, 4, 1)  + ''' ' + // ���� ��
                   '    AND ID_BAY    = ''' + Copy(OrderData.SRCBAY,   3, 2)  + ''' ' + // ���� ��
                   '    AND ID_LEVEL  = ''' + Copy(OrderData.SRCLEVEL, 3, 2)  + ''' ' ; // ���� ��

      end else
      begin
        strSQL2 := ' Update TT_STOCK ' +
                   '    Set ID_STATUS    = ''0'' ' +
                   '  Where ID_HOGI   = ''' + Copy(OrderData.DSTSITE,  4, 1)  + ''' ' +
                   '    AND ID_BANK   = ''' + Copy(OrderData.DSTAISLE, 4, 1)  + ''' ' + // ���� ��
                   '    AND ID_BAY    = ''' + Copy(OrderData.DSTBAY,   3, 2)  + ''' ' + // ���� ��
                   '    AND ID_LEVEL  = ''' + Copy(OrderData.DSTLEVEL, 3, 2)  + ''' ' ; // ���� ��

        strSQL3 := ' Update TT_STOCK ' +
                   '    Set ID_STATUS = ' + QuotedStr(CellStatus) +
                   '  Where ID_HOGI   = ''' + Copy(OrderData.SRCSITE,  4, 1)  + ''' ' +
                   '    AND ID_BANK   = ''' + Copy(OrderData.SRCAISLE, 4, 1)  + ''' ' + // ���� ��
                   '    AND ID_BAY    = ''' + Copy(OrderData.SRCBAY,   3, 2)  + ''' ' + // ���� ��
                   '    AND ID_LEVEL  = ''' + Copy(OrderData.SRCLEVEL, 3, 2)  + ''' ' ; // ���� ��
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
           (IO = '���̵�') then
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
// fnUpdateSCSetInfo TC_SCSETINFO ������Ʈ
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
// OrderDataClear [����ü �ʱ�ȭ]
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
// fnITEM_Value : TM_ITEM ������ ��ȯ
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
// fnIns_History : TT_ORDER�� History�� �ְ� ����
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
  if IO = '�԰�' then
  Begin
    Pnl_AutoQry_In.Tag := 1;
    Pnl_AutoQry_In.BevelInner := bvRaised ;
    ImgIn.Tag := 1;
    ImgIn.Picture.Bitmap := imgOK.Picture.Bitmap;
    PnlSelInfo1.Visible := False;
    edtJOB_NO_SEL1.Text := '';
  End else
  if IO = '���' then
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



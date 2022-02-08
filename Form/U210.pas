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
    Panel10: TPanel;
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
  end;
  procedure U210Create();

const
  FormNo ='210';
var
  frmU210: TfrmU210;
  SrtFlag : integer = 0 ;

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
    begin
      TmpGrid := dgInfo_Ot;
      tStr := '(Detail)';
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
    begin
      TmpGrid := dgInfo_Ot;
      tStr := '(Detail)';
      if not qryInfo_Ot.Active then Exit;
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
        SQL.Text := ' Select REG_TIME, LUGG, JOBD,                                                                                ' +
                    '        SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL                                                                  ' +
                    '        DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL                                                                  ' +
                    '        NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS                                                              ' +
                    '        JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD                                                           ' +
                    '        CVFR, CVTO, CVCURR, ETC, EMG, ITM_CD,                                                                ' +
                    '       (Case JOBD  when ''1'' then ''입고''                                                                      ' +
                    '                   when ''2'' then ''출고'' end) as JOBD_DESC,                                                   ' +
                    '       (Case NOWMC when ''1'' then ''컨베어 작업''                                                               ' +
                    '                   when ''2'' then ''스태커 적재''                                                               ' +
                    '                   when ''3'' then ''스태커 하역'' end) as NOWMC_DESC,                                           ' +
                    '       (Case NOWSTATUS when ''1'' then ''등록''                                                                  ' +
                    '                       when ''2'' then ''지시''                                                                  ' +
                    '                       when ''3'' then ''진행''                                                                  ' +
                    '                       when ''4'' then ''완료'' end) as NOWSTATUS_DESC,                                          ' +
                    '       (Case JOBERRORC when ''0'' then ''정상''                                                                  ' +
                    '                       when ''1'' then ''에러'' end) as JOBERRORC_DESC,                                          ' +
                    '       (Case JOBERRORD when ''0000'' then ''정상''                                                               ' +
                    '                       else JOBERRORD end) as JOBERRORD_DESC,                                                ' +
                    '       (Case BUFFSTATUS when ''0'' then ''대기''                                                                 ' +
                    '                        when ''1'' then ''입고가능'' end) as BUFFSTATUS_DESC,                                    ' +
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

    // 출고현황
    if Pnl_AutoQry_Ot.Tag=1 then
    begin
      with qryInfo_Ot do
      begin
        Close;
        SQL.Clear;
        SQL.Text := ' Select REG_TIME, LUGG, JOBD,                      ' +  #13#10+
                    '        SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL        ' +  #13#10+
                    '        DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL        ' +  #13#10+
                    '        NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS    ' +  #13#10+
                    '        JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD ' +  #13#10+
                    '        CVFR, CVTO, CVCURR, ETC, EMG, ITM_CD,      ' +  #13#10+
                    '       (Case when (JOBD=''1'') then ''입고'' ' +  #13#10+
                    '             when (JOBD=''2'') and (EMG=''0'') then ''출고'' ' +  #13#10+
                    '             when (JOBD=''2'') and (EMG=''1'') then ''긴급출고'' end) as JOBD_DESC, ' +  #13#10+
                    '       (Case NOWMC when ''1'' then ''컨베어 작업'' ' +  #13#10+
                    '                   when ''2'' then ''스태커 적재'' ' +  #13#10+
                    '                   when ''3'' then ''스태커 하역'' end) as NOWMC_DESC, ' +  #13#10+
                    '       (Case NOWSTATUS when ''1'' then ''등록'' ' +  #13#10+
                    '                       when ''2'' then ''지시'' ' +  #13#10+
                    '                       when ''3'' then ''진행'' ' +  #13#10+
                    '                       when ''4'' then ''완료'' end) as NOWSTATUS_DESC, ' +  #13#10+
                    '       (Case JOBERRORC when ''0'' then ''정상'' ' +  #13#10+
                    '                       when ''1'' then ''에러'' end) as JOBERRORC_DESC, ' +  #13#10+
                    '       (Case JOBERRORD when ''0000'' then ''정상'' ' +  #13#10+
                    '                       else JOBERRORD end) as JOBERRORD_DESC, ' +  #13#10+
                    '       (Case BUFFSTATUS when ''0'' then ''대기'' ' +  #13#10+
                    '                        when ''1'' then ''입고가능'' end) as BUFFSTATUS_DESC, ' +  #13#10+
                    '       (SUBSTRING(DSTAISLE,4,1)+''-''+SUBSTRING(DSTBAY,3,2)+''-''+SUBSTRING(DSTLEVEL,3,2)) as ID_CODE,           ' +
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
  Pnl_In.Height := ((Sender as TPanel).Height div 2) -2 ;
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
    end else
    begin
      ImgOt.Tag := 2;
      ImgOt.Picture.Bitmap := imgNO.Picture.Bitmap;
    end;
  end else
  begin
    (Sender as TPanel).Tag := 1 ;
    (Sender as TPanel).BevelInner := bvRaised ;

    if (Sender as TPanel).Hint='IN' then
    begin
      ImgIn.Tag := 1;
      ImgIn.Picture.Bitmap := imgOK.Picture.Bitmap;
    end else
    begin
      ImgOt.Tag := 1;
      ImgOt.Picture.Bitmap := imgOK.Picture.Bitmap;
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
    end else
    begin
      Pnl_AutoQry_Ot.Tag := 2 ;
      Pnl_AutoQry_Ot.BevelInner := bvLowered ;
      ImgOt.Picture.Bitmap := imgNO.Picture.Bitmap;
    end;
  end else
  begin
    (Sender as TImage).Tag := 1 ;

    if (Sender as TImage).Hint='IN' then
    begin
      Pnl_AutoQry_In.Tag := 1 ;
      Pnl_AutoQry_In.BevelInner := bvRaised ;
      ImgIn.Picture.Bitmap := imgOK.Picture.Bitmap;
    end else
    begin
      Pnl_AutoQry_Ot.Tag := 1 ;
      Pnl_AutoQry_Ot.BevelInner := bvRaised ;
      ImgOt.Picture.Bitmap := imgOK.Picture.Bitmap;
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
              begin
                if (FieldByName('EMG').AsString = '0') then
                     Canvas.Font.Color := clMaroon      // 일반출고
                else Canvas.Font.Color := clRed;        // 긴급출고
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
       chkGridOut.Checked := False
  else chkGridOut.Checked := True;
end;

//==============================================================================
// chkGridOutClick
//==============================================================================
procedure TfrmU210.chkGridOutClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then
       chkGridIn.Checked := False
  else chkGridIn.Checked := True;
end;

end.



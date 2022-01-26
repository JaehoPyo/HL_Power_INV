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
procedure TfrmU210.FormActivate(Sender: TObject);
begin
  frmMain.PnlMainMenu.Caption := (Sender as TForm).Caption ;
  fnWmMsgSend( 22221,111 );
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

  for i := 0 to Self.ComponentCount-1 Do
  begin
    if (Self.Components[i] is TADOQuery) then
       (Self.Components[i] as TADOQuery).Active := False ;
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
// fnCommandNew [신규]
//==============================================================================
procedure TfrmU210.fnCommandNew  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [엑셀]
//==============================================================================
procedure TfrmU210.fnCommandExcel;
begin
//
end;

//==============================================================================
// fnCommandDelete [삭제]
//==============================================================================
procedure TfrmU210.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandPrint [인쇄]
//==============================================================================
procedure TfrmU210.fnCommandPrint;
begin
//
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
        SQL.Text := ' Select REG_TIME, LUGG, JOBD,                      ' +  #13#10+
                    '        SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL        ' +  #13#10+
                    '        DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL        ' +  #13#10+
                    '        NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS    ' +  #13#10+
                    '        JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD ' +  #13#10+
                    '        CVFR, CVTO, CVCURR, ETC, EMG, ITM_CD,      ' +  #13#10+
                    '       (Case JOBD  when ''1'' then ''입고'' ' +  #13#10+
                    '                   when ''2'' then ''출고'' end) as JOBD_DESC, ' +  #13#10+
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
                    '       (SUBSTR(DSTAISLE,4,1)||''-''||SUBSTR(DSTBAY,3,2)||''-''||SUBSTR(DSTLEVEL,3,2)) as ID_CODE, ' +  #13#10+
                    '       (SUBSTR(REG_TIME,1,4)||''-''||SUBSTR(REG_TIME,5,2)||''-''||SUBSTR(REG_TIME,7,2)||''  ''|| ' +  #13#10+
                    '        SUBSTR(REG_TIME,9,2)||'':''||SUBSTR(REG_TIME,11,2)||'':''||SUBSTR(REG_TIME,13,2)) as REF_TIME_CONV, ' +  #13#10+
                    '       TO_DATE(REG_TIME,''YYYYMMDDHH24MISS'') as REG_TIME_DESC ' +
                    '   From TT_ORDER ' +  #13#10+
                    '  Where JOBD    = ''1'' ' +  #13#10+
                    '    And JOB_END = ''0'' ' +  #13#10+
                    '  Order By REG_TIME, LUGG ' ;
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
                    '       (SUBSTR(SRCAISLE,4,1)||''-''||SUBSTR(SRCBAY,3,2)||''-''||SUBSTR(SRCLEVEL,3,2)) as ID_CODE, ' +  #13#10+
                    '       (SUBSTR(REG_TIME,1,4)||''-''||SUBSTR(REG_TIME,5,2)||''-''||SUBSTR(REG_TIME,7,2)||''  ''|| ' +  #13#10+
                    '        SUBSTR(REG_TIME,9,2)||'':''||SUBSTR(REG_TIME,11,2)||'':''||SUBSTR(REG_TIME,13,2)) as REF_TIME_CONV, ' +  #13#10+
                    '       TO_DATE(REG_TIME,''YYYYMMDDHH24MISS'') as REG_TIME_DESC ' +
                    '   From TT_ORDER ' +  #13#10+
                    '  Where JOBD    = ''2'' ' +  #13#10+
                    '    And JOB_END = ''0'' ' +  #13#10+
                    '  Order By EMG DESC, REG_TIME, LUGG ASC ' ;
        Open;
      end;
    end;
  except
    if qryInfo_In.Active then qryInfo_In.Close;
    if qryInfo_Ot.Active then qryInfo_Ot.Close;
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

end.



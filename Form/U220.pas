unit U220;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, d_MainDm, h_MainLib, h_ReferLib, StdCtrls, DB, ADODB, ExLibrary, ExVclLib,
  Grids, StrUtils, DBGrids, comobj, frxClass, frxDBSet, DBGridEhGrouping, EhLibADO,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,DBGridEhImpExp,
  DBGridEh, Vcl.Mask, Vcl.DBCtrls, DBCtrlsEh, PrnDbgeh, Vcl.Buttons,
  Vcl.ComCtrls ;

type
  TfrmU220 = class(TForm)
    qryTemp: TADOQuery;
    qryInfo: TADOQuery;
    dsInfo: TDataSource;
    EhPrint: TPrintDBGridEh;
    Pnl_Main: TPanel;
    Pnl_Sub: TPanel;
    Panel2: TPanel;
    Pnl_ITM1: TPanel;
    Panel1: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Pnl_ITM2: TPanel;
    Panel8: TPanel;
    Pnl_Cell1: TPanel;
    Panel10: TPanel;
    Pnl_Cell2: TPanel;
    Pnl_InputCell: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel13: TPanel;
    Panel14: TPanel;
    edtMemo: TEdit;
    btnOrder: TButton;
    edtCode: TEdit;
    cbLevel: TComboBox;
    cbBay: TComboBox;
    cbBank: TComboBox;
    Panel3: TPanel;
    dtDateFr: TDateTimePicker;
    Panel4: TPanel;
    dtTimeFr: TDateTimePicker;
    Shape2: TShape;
    PD_GET_JOBNO: TADOStoredProc;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Pnl_MainResize(Sender: TObject);
    procedure Pnl_ITMClick(Sender: TObject);
    procedure Pnl_CellClick(Sender: TObject);
    procedure btnOrderClick(Sender: TObject);
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

    procedure OrderDataClear(OrderData:TJobOrder) ;
    function  GetJobNo : Integer;
    function  GetLocation : Boolean;
    function  SetJobOrder : Boolean;
    function  fnGetCHData(SCC_NO,SCC_SR,CH_NO,POS_NO:String) : String ;
  end;
  procedure U220Create();

const
  FormNo ='220';
var
  frmU220: TfrmU220;
  SrtFlag : integer = 0 ;

  OrderData : TJobOrder;

implementation

uses Main, Popup_Item_Search ;

{$R *.dfm}

//==============================================================================
// U220Create
//==============================================================================
procedure U220Create();
begin
  if not Assigned( frmU220 ) then
  begin
    frmU220 := TfrmU220.Create(Application);
    with frmU220 do
    begin
      fnCommandStart;
    end;
  end;
  frmU220.Show;
end;

//==============================================================================
// fnWmMsgRecv
//==============================================================================
procedure TfrmU220.fnWmMsgRecv(var MSG: TMessage);
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
procedure TfrmU220.FormActivate(Sender: TObject);
begin

  MainDm.M_Info.ActiveFormID := '220';
  frmMain.LblMenu000.Caption := MainDm.M_Info.ActiveFormID + '. ' + getLangMenuString(MainDm.M_Info.ActiveFormID, frmMain.LblMenu000.Caption, MainDm.M_Info.LANG_TYPE, 'N');
  frmU220.Caption := MainDm.M_Info.ActiveFormName;
  fnWmMsgSend( 22222,22111 );

  dtDateFr.Date := StrToDate(FormatDateTime('YYYY-MM-DD',Now));
  dtTimeFr.Time := StrToTime(FormatDateTime('HH:NN:SS',Now));

  if      pnl_ITM1.BevelInner=bvLowered then edtCode.Text := 'EPLT'
  else if pnl_ITM2.BevelInner=bvLowered then edtCode.Text := ''
  else                                       edtCode.Text := '';
end;

//==============================================================================
// FormDeactivate
//==============================================================================
procedure TfrmU220.FormDeactivate(Sender: TObject);
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
procedure TfrmU220.FormClose(Sender: TObject; var Action: TCloseAction);
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
  try frmU220 := Nil ;
  except end;
end;

//==============================================================================
// fnCommandStart
//==============================================================================
procedure TfrmU220.fnCommandStart;
begin
  Pnl_CellClick(Pnl_Cell1);
end;

//==============================================================================
// fnCommandNew [�ű�]
//==============================================================================
procedure TfrmU220.fnCommandOrder  ;
begin
//
end;

//==============================================================================
// fnCommandAdd [�ű�]                                                        //
//==============================================================================
procedure TfrmU220.fnCommandAdd  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [����]
//==============================================================================
procedure TfrmU220.fnCommandExcel;
begin
//
end;

//==============================================================================
// fnCommandDelete [����]
//==============================================================================
procedure TfrmU220.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandUpdate [����]                                                     //
//==============================================================================
procedure TfrmU220.fnCommandUpdate;
begin
//
end;

//==============================================================================
// fnCommandPrint [�μ�]
//==============================================================================
procedure TfrmU220.fnCommandPrint;
begin
//
end;

//==============================================================================
// fnCommandQuery
//==============================================================================
procedure TfrmU220.fnCommandQuery;
begin
//
end;

//==============================================================================
// fnCommandClose
//==============================================================================
procedure TfrmU220.fnCommandClose;
begin
  Close;
end;

//==============================================================================
// fnCommandLang [���]                                                       //
//==============================================================================
procedure TfrmU220.fnCommandLang;
begin
//
end;

//==============================================================================
// Pnl_ITMClick
//==============================================================================
procedure TfrmU220.Pnl_ITMClick(Sender: TObject);
var
  i, Idx : Integer ;
begin
  Idx := (Sender as TPanel).Tag ;

  if (Sender as TPanel).BevelInner = bvRaised then
  begin
    TPanel(Self.FindComponent('Pnl_ITM'+IntToStr(Idx))).BevelInner := bvLowered ;
    TPanel(Self.FindComponent('Pnl_ITM'+IntToStr(Idx))).Font.Color := clBlue ;

    for i := 1 to 2 do
    begin
      if i<>Idx then
      begin
        TPanel(Self.FindComponent('Pnl_ITM'+IntToStr(i))).BevelInner := bvRaised ;
        TPanel(Self.FindComponent('Pnl_ITM'+IntToStr(i))).Font.Color := clBlack ;
      end;
    end;

    if Idx=2 then
    begin
      edtCode.Text := '';
      frmPopup_Item_Search := TfrmPopup_Item_Search.Create(Application);
      frmPopup_Item_Search.ShowModal ;
    end else
    begin
      edtCode.Text := 'EPLT' ;
    end;
  end else
  begin
    edtCode.Text := '';
    TPanel(Self.FindComponent('Pnl_ITM'+IntToStr(Idx))).BevelInner := bvRaised ;
    TPanel(Self.FindComponent('Pnl_ITM'+IntToStr(Idx))).Font.Color := clBlack ;
  end;
end;

//==============================================================================
// Pnl_CellClick
//==============================================================================
procedure TfrmU220.Pnl_CellClick(Sender: TObject);
var
  i, Idx : Integer ;
begin
  Idx := (Sender as TPanel).Tag ;

  if (Sender as TPanel).BevelInner = bvRaised then
  begin
    TPanel(Self.FindComponent('Pnl_Cell'+IntToStr(Idx))).BevelInner := bvLowered ;
    TPanel(Self.FindComponent('Pnl_Cell'+IntToStr(Idx))).Font.Color := clBlue ;

    for i := 1 to 2 do
    begin
      if i<>Idx then
      begin
        TPanel(Self.FindComponent('Pnl_Cell'+IntToStr(i))).BevelInner := bvRaised ;
        TPanel(Self.FindComponent('Pnl_Cell'+IntToStr(i))).Font.Color := clBlack ;
      end;
    end;

    if Idx=2 then Pnl_InputCell.Visible := True
    else          Pnl_InputCell.Visible := False ;
  end else
  begin
    TPanel(Self.FindComponent('Pnl_Cell'+IntToStr(Idx))).BevelInner := bvRaised ;
    TPanel(Self.FindComponent('Pnl_Cell'+IntToStr(Idx))).Font.Color := clBlack ;
    if Idx=2 then Pnl_InputCell.Visible := False ;
  end;
end;

//==============================================================================
// Pnl_MainResize
//==============================================================================
procedure TfrmU220.Pnl_MainResize(Sender: TObject);
begin
  Pnl_Sub.Top  := (Pnl_Main.Height - Pnl_Sub.Height) div 2 ;
  Pnl_Sub.Left := (Pnl_Main.Width  - Pnl_Sub.Width ) div 2 ;
end;

//==============================================================================
// btnOrderClick [�԰�����]
//==============================================================================
procedure TfrmU220.btnOrderClick(Sender: TObject);
begin
  if Trim(edtCode.Text)='' then
  begin
    MessageDlg('�ڵ带 Ȯ���� �ֽʽÿ�.', mtConfirmation, [mbYes], 0) ;
    Exit;
  end;

  if ( Pnl_Cell2.BevelInner=bvLowered ) then
  begin
    if ( (Trim(cbBank.Text)='') or (Trim(cbBay.Text)='') or (Trim(cbLevel.Text)='') ) then
    begin
      MessageDlg('������ġ�� Ȯ���� �ֽʽÿ�.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end else
    if ( StrToInt(cbBank.Text) > 2 ) then
    begin
      MessageDlg('����[��]��ġ�� Ȯ���� �ֽʽÿ�.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end else
    if ( StrToInt(cbBay.Text) > 9 ) then
    begin
      MessageDlg('����[��]��ġ�� Ȯ���� �ֽʽÿ�.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end else
    if ( StrToInt(cbLevel.Text) > 6 ) then
    begin
      MessageDlg('����[��]��ġ�� Ȯ���� �ֽʽÿ�.', mtConfirmation, [mbYes], 0) ;
      Exit;
    end;
  end;

  OrderDataClear(OrderData) ;

  OrderData.REG_TIME   := FormatDateTime('YYYYMMDD',dtDateFr.Date) + FormatDateTime('HHNNSS',dtTimeFr.Time) ;

  OrderData.LUGG       := Format('%.4d', [GetJobNo]) ;  // �۾���ȣ

  OrderData.JOBD       := '1';     // �԰�����

  OrderData.SRCSITE    := '0100';  // ���� ȣ��
  OrderData.SRCAISLE   := '0000';  // ���� ��
  OrderData.SRCBAY     := '0000';  // ���� ��
  OrderData.SRCLEVEL   := '0001';  // ���� ��


  if Pnl_Cell1.BevelInner=bvLowered then
  begin
    if not GetLocation then
    begin
      MessageDlg('�� ã�� ���� �Դϴ�.', mtError, [mbYes], 0) ;
      Exit ;
    end;
  end else
  if Pnl_Cell2.BevelInner=bvLowered then
  begin
    OrderData.DSTSITE    := Format('%.4d', [StrToInt('1'         )]) ;
    OrderData.DSTAISLE   := Format('%.4d', [StrToInt(cbBank.Text )]) ;
    OrderData.DSTBAY     := Format('%.4d', [StrToInt(cbBay.Text  )]) ;
    OrderData.DSTLEVEL   := Format('%.4d', [StrToInt(cbLevel.Text)]) ;
    OrderData.ID_CODE    := FormatFloat('0' ,StrToInt(cbBank.Text )) +
                            FormatFloat('00',StrToInt(cbBay.Text  )) +
                            FormatFloat('00',StrToInt(cbLevel.Text));
  end else
  begin
    MessageDlg('�� ã�� ���� �Դϴ�.', mtError, [mbYes], 0) ;
    Exit;
  end;


  if (OrderData.DSTAISLE='0001') and (OrderData.DSTBAY='0001') and (OrderData.DSTLEVEL='0001')  then
  begin
    MessageDlg('�԰���ġ�� ��/����� �����ϼ̽��ϴ�.' + #13#10 +
               '�ٽ� �������ֽñ� �ٶ��ϴ�.', mtError, [mbYes], 0) ;
    Exit;
  end;



  OrderData.NOWMC      := '1';
  OrderData.JOBSTATUS  := '4';
  OrderData.NOWSTATUS  := '4';
  OrderData.BUFFSTATUS := fnGetCHData('1','R','CH05','9'); // �԰���
  OrderData.JOBREWORK  := '';
  OrderData.JOBERRORT  := '';
  OrderData.JOBERRORC  := '';
  OrderData.JOBERRORD  := '';
  OrderData.JOB_END    := '0';
  OrderData.CVFR       := '100';
  OrderData.CVTO       := '100';
  OrderData.CVCURR     := '100';
  OrderData.ETC        := edtMemo.Text ;
  OrderData.EMG        := '0';
  OrderData.ITM_CD     := edtCode.Text ;
  OrderData.UP_TIME    := '';


  if SetJobOrder then
  begin
    MessageDlg('�԰����ð� �Ϸ�Ǿ����ϴ�.' + #13#10  + #13#10+
               '===============================' + #13#10+
               '���۾���ȣ ['+ OrderData.LUGG   +'] ' + #13#10+
               '�������ڵ� ['+ OrderData.ITM_CD +'] ' + #13#10+
               '��������ġ ['+ Copy(OrderData.ID_CODE,1,1)+'-'
                             + Copy(OrderData.ID_CODE,2,2)+'-'
                             + Copy(OrderData.ID_CODE,4,2)+'] ' + #13#10+
               '===============================' + #13#10+
               '', mtConfirmation, [mbYes], 0) ;
  end;

  dtDateFr.Date := StrToDate(FormatDateTime('YYYY-MM-DD',Now));
  dtTimeFr.Time := StrToTime(FormatDateTime('HH:NN:SS',Now));
end;

//==============================================================================
// OrderDataClear [����ü �ʱ�ȭ]
//==============================================================================
procedure TfrmU220.OrderDataClear(OrderData: TJobOrder);
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
// GetJobNo [�۾���ȣ ����]
//==============================================================================
function TfrmU220.GetJobNo : Integer;
var
  StrSQL : String;
  returnValue : String;
begin
  try
    Result := 0;
    with PD_GET_JOBNO do
    begin
      Close;
      {
      ProcedureName := 'PD_GET_JOBNO';
      Parameters.CreateParameter('@i_Type', ftInteger, pdInput, 0, 1);
      //Parameters.CreateParameter('@o_JobNo', ftWideString, pdInputOutput, 10, '');
      }
      ProcedureName := 'PD_GET_JOBNO';
      Parameters.ParamByName('@I_TYPE').Value := 1;
      ExecProc;
      returnValue := Parameters.ParamValues['@o_JobNo'];

      if (returnValue.Substring(0, 2) = 'OK') then
        Result := StrToInt(returnValue.Substring(3, 4));
    end;
//    with qryTemp do
//    begin
//      Close;
//      SQL.Clear;
//      StrSQL :=  ' Select JobSeq.Nextval as JobSeq From Dual ';
//      SQL.Text := StrSQL;
//      Open;
//      if Not (Eof and Bof) then
//      begin
//        Result := FieldByName('JobSeq').AsInteger;
//      end;
//      Close;
//    end;
  except
    if qryTemp.Active then qryTemp.Close;
  end;
end;

//==============================================================================
// GetLocation [�� ã��]
//==============================================================================
function TfrmU220.GetLocation : Boolean;
var
  ScNo : integer ;
begin
  try
    Result := False;
    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := ' Select WMS_HL.DBO.fn_GetFreeLoc(:type) ID_CODE ';
      Parameters[0].Value := 0 ;
      Open;

      if ( RecordCount = 0 ) or
         ( Copy(FieldByName('ID_CODE').AsString, 1, 2) <> 'OK' ) then
      begin
        Exit;
      end;

      OrderData.DSTSITE    := Format('%.4d', [StrToInt(Copy(FieldByName('ID_CODE').AsString, 4, 1))]) ;
      OrderData.DSTAISLE   := Format('%.4d', [StrToInt(Copy(FieldByName('ID_CODE').AsString, 5, 1))]) ;
      OrderData.DSTBAY     := Format('%.4d', [StrToInt(Copy(FieldByName('ID_CODE').AsString, 6, 2))]) ;
      OrderData.DSTLEVEL   := Format('%.4d', [StrToInt(Copy(FieldByName('ID_CODE').AsString, 8, 2))]) ;
      OrderData.ID_CODE    := Copy(FieldByName('ID_CODE').AsString, 5, 5);
      Result := True;
      Close;
    end;
  except
    if qryTemp.Active then qryTemp.Close;
  end;
end;

//==============================================================================
// SetJobOrder [�԰����� ������ ����]
//==============================================================================
function TfrmU220.SetJobOrder : Boolean;
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
      // ������ ����  ( ����(0) -> ����(4) )
      //+++++++++++++++++++++++++++++++++++++
      Close;
      SQL.Clear;
      SQL.Text :=
      ' UPDATE TT_STOCK               ' + #13#10 +
      '    SET ID_STATUS = :ID_STATUS ' + #13#10 +
      '  WHERE ID_HOGI = :ID_HOGI     ' + #13#10+
      '    AND ID_CODE = :ID_CODE ' ;
      Parameters[0].Value := '4';                         // �԰���
      Parameters[1].Value := Copy(OrderData.DSTSITE,4,1); // ȣ��
      Parameters[2].Value := OrderData.ID_CODE;           // ����ġ
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
// fnGetCHData [��&��� ���� üũ]
//==============================================================================
function TfrmU220.fnGetCHData(SCC_NO,SCC_SR,CH_NO,POS_NO:String) : String ;
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
    if qryTemp.Active then qryTemp.Close;
  end;
end;


end.





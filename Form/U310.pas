unit U310;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, d_MainDm, h_MainLib, h_ReferLib, StdCtrls, DB, ADODB, ExLibrary, ExVclLib,
  Grids, StrUtils, DBGrids, comobj, frxClass, frxDBSet, DBGridEhGrouping, EhLibADO,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,DBGridEhImpExp,
  DBGridEh, Vcl.Mask, Vcl.DBCtrls, DBCtrlsEh, PrnDbgeh, Vcl.Buttons,
  Vcl.ComCtrls ;

type
  TfrmU310 = class(TForm)
    qryTemp: TADOQuery;
    qryInfo: TADOQuery;
    dsInfo: TDataSource;
    EhPrint: TPrintDBGridEh;
    Pnl_Main: TPanel;
    CanvasPanel1: TPanel;
    Pnl_Info: TPanel;
    Panel274: TPanel;
    Panel275: TPanel;
    Panel67: TPanel;
    CellStatus0: TPanel;
    CellStatus2: TPanel;
    CellStatus4: TPanel;
    CellStatus6: TPanel;
    CellStatus1: TPanel;
    CellStatus3: TPanel;
    CellStatus5: TPanel;
    CellStatus7: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel10: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    Panel16: TPanel;
    Panel23: TPanel;
    Panel24: TPanel;
    Panel26: TPanel;
    Panel27: TPanel;
    Panel30: TPanel;
    Panel31: TPanel;
    Panel32: TPanel;
    ComboBoxHogi: TComboBox;
    ComboBoxBank: TComboBox;
    ComboBoxBay: TComboBox;
    ComboBoxLevel: TComboBox;
    CB_ID_STATUS: TComboBox;
    edtITM_CD: TEdit;
    edtITM_NAME: TEdit;
    edtITM_SPEC: TEdit;
    edtITM_QTY: TEdit;
    cbInUSED: TCheckBox;
    cbOtUSED: TCheckBox;
    btnSave: TButton;
    Panel8: TPanel;
    edtID_MEMO: TEdit;
    dtDate: TDateTimePicker;
    dtTime: TDateTimePicker;
    Panel1: TPanel;
    dgInfo: TDBGridEh;
    tmrQry: TTimer;
    qryCell: TADOQuery;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrQryTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure CB_ID_STATUSChange(Sender: TObject);
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
    function  fnCellCreate(Wdt,Hgt : Integer) : Boolean ;
    procedure SetColorStatus (ID_HOGI, ID_CODE, ID_STATUS, ITM_CD, CELL_IN_USED, CELL_OT_USED : String );
    procedure CellPanelDblClick(Sender: TObject);
  end;
  procedure U310Create();

const
  FormNo ='310';

  vHogi  =  1;
  vBank  =  2;
  vBay   = 11;
  vLevel =  3;

var
  frmU310: TfrmU310;
  SrtFlag : integer = 0 ;

  BankPanel  : array [1..vHogi, 1..vBank] of TPanel;
  BankTitle  : array [1..vHogi, 1..vBank] of TPanel;
  CellPanel  : array [1..vBank, 0..vBay, 0..vLevel] of TPanel;

implementation

uses Main ;

{$R *.dfm}

//==============================================================================
// U310Create
//==============================================================================
procedure U310Create();
begin
  if not Assigned( frmU310 ) then
  begin
    frmU310 := TfrmU310.Create(Application);
    with frmU310 do
    begin
      fnCommandStart;
    end;
  end;
  frmU310.Show;
end;

//==============================================================================
// fnWmMsgRecv
//==============================================================================
procedure TfrmU310.fnWmMsgRecv(var MSG: TMessage);
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
procedure TfrmU310.FormActivate(Sender: TObject);
begin
  frmMain.PnlMainMenu.Caption := (Sender as TForm).Caption ;
  fnWmMsgSend( 22222,111 );
  fnCommandQuery ;

  if not tmrQry.Enabled then tmrQry.Enabled := True;

  dtDate.Date := StrToDate(FormatDateTime('YYYY-MM-DD',Now));
  dtTime.Time := StrToTime(FormatDateTime('HH:NN:SS',Now));
end;

//==============================================================================
// FormDeactivate
//==============================================================================
procedure TfrmU310.FormDeactivate(Sender: TObject);
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
procedure TfrmU310.FormClose(Sender: TObject; var Action: TCloseAction);
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
  try frmU310 := Nil ;
  except end;
end;

//==============================================================================
// fnCommandStart
//==============================================================================
procedure TfrmU310.fnCommandStart;
begin
  fnCellCreate(CanvasPanel1.Width, CanvasPanel1.Height) ;
  fnCommandQuery;
end;

//==============================================================================
// fnCommandNew [신규]
//==============================================================================
procedure TfrmU310.fnCommandNew  ;
begin
//
end;

//==============================================================================
// fnCommandExcel [엑셀]
//==============================================================================
procedure TfrmU310.fnCommandExcel;
begin
  hlbEhgridListExcel ( dgInfo , frmU310.Caption + '_' + FormatDatetime('YYYYMMDDHHNN', Now) );
  MessageDlg('엑셀 저장을 완료하였습니다.', mtConfirmation, [mbYes], 0)
end;

//==============================================================================
// fnCommandDelete [삭제]
//==============================================================================
procedure TfrmU310.fnCommandDelete;
begin
//
end;

//==============================================================================
// fnCommandPrint [인쇄]
//==============================================================================
procedure TfrmU310.fnCommandPrint;
begin
//
end;

//==============================================================================
// fnCommandQuery
//==============================================================================
procedure TfrmU310.fnCommandQuery;
var
  StrSQL : String;
begin
  try
    with qryInfo do
    begin
      Close;
      SQL.Clear;
      StrSql := ' Select * ' +
                '   From TT_STOCK ' +
                '  Order By ID_CODE, ID_BANK, ID_BAY, ID_LEVEL ' ;
      SQL.Text := StrSql ;
      Open;

      First;

      while not(Eof) do
      begin
        SetColorStatus ( FieldByName('ID_HOGI'   ).AsString,   // 호기
                         FieldByName('ID_CODE'   ).AsString,   // 셀 위치
                         FieldByName('ID_STATUS' ).AsString,   // 셀 상태
                         FieldByName('ITM_CD'    ).AsString,   // 아이템 코드
                         FieldByName('IN_USED'   ).AsString,   // 입고 사용여부
                         FieldByName('OT_USED'   ).AsString ); // 출고 사용여부
        Next ;
      end;
    end;

    with qryCell do
    begin
      Close;
      SQL.Clear;
      StrSql := ' Select ID_HOGI, CELL_CNT, CELL_USE, CELL_EMP, ' +
                '        TRAYCELL, ITEMCELL, EMGCELL, INCELL, ' +
                '        OUTCELL, DOUBLECELL, ZEROCELL, ' +
                '        ROUND(TRAYCELL   / Cast(CELL_CNT as Float) *100, 1) TRAYRATE,  ' +
                '        ROUND(ITEMCELL   / Cast(CELL_CNT as Float) *100, 1) ITEMRATE,  ' +
                '        ROUND(EMGCELL    / Cast(CELL_CNT as Float) *100, 1) EMGRATE,   ' +
                '        ROUND(INCELL     / Cast(CELL_CNT as Float) *100, 1) INRATE,    ' +
                '        ROUND(OUTCELL    / Cast(CELL_CNT as Float) *100, 1) OUTRATE,   ' +
                '        ROUND(DOUBLECELL / Cast(CELL_CNT as Float) *100, 1) DOUBLERATE,' +
                '        ROUND(ZEROCELL   / Cast(CELL_CNT as Float) *100, 1) ZERORATE   ' +
                '   From ( ' +
                '         Select ID_HOGI, COUNT(*) CELL_CNT, ' +
                '                SUM(case when ID_STATUS <> ''0'' then 1 else 0 end) CELL_USE, ' +
                '                SUM(case when ID_STATUS  = ''0'' then 1 else 0 end) CELL_EMP, ' +
                '                SUM(case ID_STATUS when ''1'' then 1 else 0 end) TRAYCELL,    ' +
                '                SUM(case ID_STATUS when ''2'' then 1 else 0 end) ITEMCELL,    ' +
                '                SUM(case ID_STATUS when ''3'' then 1 else 0 end) EMGCELL,     ' +
                '                SUM(case ID_STATUS when ''4'' then 1 else 0 end) INCELL,      ' +
                '                SUM(case ID_STATUS when ''5'' then 1 else 0 end) OUTCELL,     ' +
                '                SUM(case ID_STATUS when ''6'' then 1 else 0 end) DOUBLECELL,  ' +
                '                SUM(case ID_STATUS when ''7'' then 1 else 0 end) ZEROCELL     ' +
                '           From TT_STOCK   ' +
                '          Group By ID_HOGI ' +
                '       )  Stk ' +
                '  Order By ID_HOGI' ;


      SQL.Text := StrSql ;
      Open;
    end;

  except
    if qryInfo.Active then qryInfo.Close;
    if qryCell.Active then qryCell.Close;
  end;
end;

//==============================================================================
// fnCommandClose
//==============================================================================
procedure TfrmU310.fnCommandClose;
begin
  Close;
end;

//==============================================================================
// fnCellCreate
//==============================================================================
function TfrmU310.fnCellCreate(Wdt,Hgt : Integer) : Boolean ;
  //----------------------------------------------------------------------------
  function fnCreateBank(Hogi: integer) : Boolean;
    //--------------------------------------------------------------------------
    function fnCreateCell(Hogi,Bank: integer) : Boolean;
    var
      i, j, k : integer ;
    begin
      for i := 0 to vBay do
      begin
        for j := 0 to vLevel do
        begin
          CellPanel[Bank][i][j] := TPanel.Create(Self);
          with CellPanel[Bank][i][j] do
          begin

            Parent      := TPanel(Self.FindComponent('BankPnl'+IntToStr(Hogi)+IntToStr(Bank))) ;
            Align       := alNone ;
            AutoSize    := False ;
            BevelInner  := bvNone;
            BevelOuter  := bvRaised;

            ShowHint := True ;
            ParentBackground := False;
            ParentColor      := False;
            ParentFont       := False;
            ParentShowHint   := False;
            ParentCustomHint := False;

            Name        := 'Cell'+IntToStr(Hogi)+IntToStr(Bank)+FormatFloat('00',i)+FormatFloat('00',j);
            Caption     := '';
            Hint        := 'Cell'+IntToStr(Hogi)+IntToStr(Bank)+FormatFloat('00',i)+FormatFloat('00',j);

            if i=vBay then
              Width     := BankPanel[1][1].Width - (((BankPanel[1][1].Width Div (vBay  +1))+0) * vBay-1) -1
            else
              Width     := ((BankPanel[1][1].Width Div (vBay  +1))+0) ;

            Left        := ((BankPanel[1][1].Width Div (vBay  +1))+0) * (vBay-i) ;

            Height      := (BankPanel[1][1].Height Div (vLevel+1))+1 ;
            Top         := (BankPanel[1][1].Height) - ((BankPanel[1][1].Height Div (vLevel+1))+1) * (j+1);

            Font.Charset := DEFAULT_CHARSET ;
            Font.Name := '돋움';

            if (i=0) or (j=0) then
            begin
              Color := $00484848 ;
              Font.Size  := 20 ;
              Font.Color := clWhite ;
              Font.Style := [fsBold] ;
              if i=0 then Caption := IntToStr(j);
              if j=0 then Caption := IntToStr(i);
              if (i=0) and (j=0) then
              begin
                Font.Size  := 20 ;
                Caption := IntToStr(Bank)+'열';
              end;
            end else
            begin
              if (Bank=1) and (i=1) and (j=1)  then
              begin
                Color := clWhite;
                Font.Size  := 14 ;
                Font.Color := clBlack ;
                Font.Style := [fsBold] ;
                Caption := '입출고대';
              end else
              begin
                Color := clWhite ;
                Font.Size  := 14 ;
                Font.Color := clWhite ;
                Font.Style := [fsBold] ;
                OnClick := CellPanelDblClick;
              end;
            end;

          end;
        end;
      end;
    end;
  var
    i : integer ;
  begin
    Application.ProcessMessages ;
    for i := 1 to vBank do
    begin
      BankPanel[Hogi][i] := TPanel.Create(Self);
      with BankPanel[Hogi][i] do
      begin
        Parent      := TPanel(Self.FindComponent('CanvasPanel'+IntToStr(Hogi))) ;
        Align       := AlTop;
        Align       := AlBottom;
        AutoSize    := False ;
        BevelInner  := bvRaised;
        BevelOuter  := bvNone;

        ParentBackground := False;
        ParentColor      := False;
        ParentFont       := False;
        ParentShowHint   := False;
        ParentCustomHint := False;

        Name        := 'BankPnl'+IntToStr(Hogi)+IntToStr(i) ;
        Height      := (CanvasPanel1.Height div vBank)-1 ;
        Caption     := '';

        Visible     := False ; Application.ProcessMessages;

        fnCreateCell(Hogi,i) ;
        Visible     := True  ; Application.ProcessMessages;
      end;
    end;
  end;
var
  i : integer ;
begin
  for i := 1 to vHogi do
  begin
    fnCreateBank(i) ;
  end;
end;

//==============================================================================
// tmrQryTimer
//==============================================================================
procedure TfrmU310.tmrQryTimer(Sender: TObject);
begin
  try
    tmrQry.Enabled := False ;
    fnCommandQuery ;
  finally
    tmrQry.Enabled := True ;
  end;
end;

//==============================================================================
// SetColorStatus
//==============================================================================
procedure TfrmU310.SetColorStatus (ID_HOGI, ID_CODE, ID_STATUS, ITM_CD, CELL_IN_USED, CELL_OT_USED : String );
var
  IdHogi, IdBnk , IdBay , IdLvl : Integer;
  TmpCell : TPanel;
begin
  IdHogi:= StrToInt(ID_HOGI);
  IdBnk := StrToInt(Copy( Id_Code,1,1)) ;
  IdBay := StrToInt(Copy( Id_Code,2,2)) ;
  IdLvl := StrToInt(Copy( Id_Code,4,2)) ;
  TmpCell := TPanel(Self.FindComponent('Cell'+IntToStr(IdHogi)+IntToStr(IdBnk)+FormatFloat('00',IdBay)+FormatFloat('00',IdLvl))) ;

  if TmpCell <> nil then
  begin
    if ( (CELL_IN_USED = '0') or
         (CELL_OT_USED = '0') or
         (ID_STATUS    = '3') ) then TmpCell.Color := CellStatus3.Color   // 금지셀
    else if (ID_STATUS = '0')   then TmpCell.Color := CellStatus0.Color   // 공셀
    else if (ID_STATUS = '1')   then TmpCell.Color := CellStatus1.Color   // 공파레트
    else if (ID_STATUS = '2')   then TmpCell.Color := CellStatus2.Color   // 실셀
    else if (ID_STATUS = '4')   then TmpCell.Color := CellStatus4.Color   // 입고예약
    else if (ID_STATUS = '5')   then TmpCell.Color := CellStatus5.Color   // 출고예약
    else if (ID_STATUS = '6')   then TmpCell.Color := CellStatus6.Color   // 이중입고
    else if (ID_STATUS = '7')   then TmpCell.Color := CellStatus7.Color;  // 공출고

    TmpCell.Caption := ITM_CD ;
  end;
end;

//==============================================================================
// btnSaveClick
//==============================================================================
procedure TfrmU310.btnSaveClick(Sender: TObject);
var
  StrSQL, ID_HOGI, ID_CODE, IN_USE, OT_USE, INdt : String;
begin
  try
    INdt := '';

    ID_HOGI := ComboBoxHogi.Text;
    ID_CODE := ComboBoxBank.Text + ComboBoxBay.Text + ComboBoxLevel.Text;

    if cbInUSED.Checked then IN_USE := '0' else IN_USE := '1';
    if cbOtUSED.Checked then OT_USE := '0' else OT_USE := '1';

    if CB_ID_STATUS.ItemIndex = 0 then
    begin
      StrSQL := ' Update TT_STOCK ' +
                '    Set ITM_CD       = ''''  ' +
                '      , ITM_NAME     = ''''  ' +
                '      , ITM_SPEC     = ''''  ' +
                '      , ITM_QTY      = 0     ' +
                '      , ID_ZONE      = ''A'' ' +
                '      , ID_STATUS    = ' + QuotedStr(IntToStr(CB_ID_STATUS.ItemIndex)) +
                '      , OT_USED      = ' + QuotedStr(OT_USE) +
                '      , IN_USED      = ' + QuotedStr(IN_USE) +
                '      , ID_MEMO      = ' + QuotedStr(edtID_MEMO.Text) +
                '      , STOCK_REG_DT = Sysdate   ' +
                '  Where ID_HOGI = ' + QuotedStr(ID_HOGI) +
                '    And ID_CODE = ' + QuotedStr(ID_CODE) ;
    end else
    begin
      if CB_ID_STATUS.ItemIndex in [1,2] then INdt := ' , STOCK_IN_DT = Sysdate '
      else                                    INdt := '';

      StrSQL := ' Update TT_STOCK ' +
                '    Set ITM_CD       = ' + QuotedStr(edtITM_CD.Text) +
                '      , ITM_NAME     = ' + QuotedStr(edtITM_NAME.Text) +
                '      , ITM_SPEC     = ' + QuotedStr(edtITM_SPEC.Text) +
                '      , ITM_QTY      = ' + QuotedStr(edtITM_QTY.Text) +
                '      , ID_ZONE      = ''A'' ' +
                '      , ID_STATUS    = ' + QuotedStr(IntToStr(CB_ID_STATUS.ItemIndex)) +
                '      , OT_USED      = ' + QuotedStr(OT_USE) +
                '      , IN_USED      = ' + QuotedStr(IN_USE) +
                '      , ID_MEMO      = ' + QuotedStr(edtID_MEMO.Text) + INdt +
                '      , STOCK_REG_DT = Sysdate ' +
                '  Where ID_HOGI = ' + QuotedStr(ID_HOGI) +
                '    And ID_CODE = ' + QuotedStr(ID_CODE) ;
    end;

    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL;
      if ExecSQL > 0 then ShowMessage('적재 정보 수정');
    end;
  except
    if qryTemp.Active then qryTemp.Close;
  end;
end;

//==============================================================================
// CellPanelDblClick
//==============================================================================
procedure TfrmU310.CellPanelDblClick(Sender: TObject);
var
  ID_HOGI, ID_CODE, ID_BANK, ID_BAY, ID_LEVEL, StrSQL : String ;
  i : integer;
begin
  ID_HOGI  := '1' ;
  ID_CODE  := Copy((Sender as TPanel).Name,6,5) ;
  ID_BANK  := Copy(ID_CODE,1,1) ;
  ID_BAY   := Copy(ID_CODE,2,2) ;
  ID_LEVEL := Copy(ID_CODE,4,2) ;

  ComboBoxHogi.Text  := ID_HOGI;
  ComboBoxBank.Text  := ID_BANK;
  ComboBoxBay.Text   := ID_BAY;
  ComboBoxLevel.Text := ID_LEVEL;

  edtITM_CD.Text   := '';
  edtITM_NAME.Text := '';
  edtITM_SPEC.Text := '';
  edtITM_QTY.Text  := '';
  edtID_MEMO.Text  := '';

  dtDate.Date := StrToDate(FormatDateTime('YYYY-MM-DD',Now));
  dtTime.Time := StrToTime(FormatDateTime('HH:NN:SS',Now));

  cbInUSED.Checked := False;
  cbOtUSED.Checked := False;

  CB_ID_STATUS.ItemIndex := 0 ;

  try
    with qryTemp do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' Select * From TT_STOCK ' +
                '  Where ID_HOGI = ''' + ID_HOGI + '''   ' +
                '    And ID_CODE = ''' + ID_CODE + '''   ' ;

      SQL.Text := StrSQL ;
      Open;

      if not (Eof and Bof) then
      begin
        ComboBoxHogi.Text  := ID_HOGI;
        ComboBoxBank.Text  := ID_BANK;
        ComboBoxBay.Text   := ID_BAY;
        ComboBoxLevel.Text := ID_LEVEL;

        edtITM_CD.Text   := FieldByName('ITM_CD'  ).AsString;
        edtITM_NAME.Text := FieldByName('ITM_NAME').AsString;
        edtITM_SPEC.Text := FieldByName('ITM_SPEC').AsString;
        edtITM_QTY.Text  := IntToStr(FieldByName('ITM_QTY' ).AsInteger);
        edtID_MEMO.Text  := FieldByName('ID_MEMO'  ).AsString;

        dtDate.Date := FieldByName('STOCK_IN_DT').AsDateTime;
        dtTime.Time := FieldByName('STOCK_IN_DT').AsDateTime;


        if FieldByName('IN_USED').AsString = '1' then cbInUSED.Checked := False
                                                 else cbInUSED.Checked := True;

        if FieldByName('OT_USED').AsString = '1' then cbOtUSED.Checked := False
                                                 else cbOtUSED.Checked := True;

        CB_ID_STATUS.ItemIndex := StrToInt(FieldByName('ID_STATUS').AsString) ;
      end else
      begin
        ComboBoxHogi.Text  := ID_HOGI;
        ComboBoxBank.Text  := ID_BANK;
        ComboBoxBay.Text   := ID_BAY;
        ComboBoxLevel.Text := ID_LEVEL;

        edtITM_CD.Text   := '';
        edtITM_NAME.Text := '';
        edtITM_SPEC.Text := '';
        edtITM_QTY.Text  := '';
        edtID_MEMO.Text  := '';

        dtDate.Date := StrToDate(FormatDateTime('YYYY-MM-DD',Now));
        dtTime.Time := StrToTime(FormatDateTime('HH:NN:SS',Now));

        cbInUSED.Checked := False;
        cbOtUSED.Checked := False;

        CB_ID_STATUS.ItemIndex := 0 ;
      end;
    end;
  except
    if qryTemp.Active then qryTemp.Close;
  end;
end;

//==============================================================================
// Button1Click
//==============================================================================
procedure TfrmU310.Button1Click(Sender: TObject);
var
  i, j, k  : integer ;
  aStrSQL, TempCode : String ;
begin
  with qryCell do
  begin
    try
      MainDm.MainDB.BeginTrans;
      for i := 1 to 2 do      //열   기존 2열
      begin
        for j := 1 to 11 do  //연   기존 15연에서 28연으로 증설
        begin
          for k := 1 to 3 do  //단   기존 6단
          begin
            aStrSQL  := '' ;
            TempCode := '' ;

            TempCode := IntToStr(i)+FormatFloat('00',j)+FormatFloat('00',k);

            Close ;
            SQL.Clear;
            aStrSQL := ' INSERT INTO TT_STOCK ( '+
                       ' ID_HOGI,ID_CODE,ID_BANK,ID_BAY,ID_LEVEL,ID_STATUS, '+
                       ' IN_USED,OT_USED,ID_ZONE)       '+
                       ' VALUES( '+
                       ' ''1'', '+  //ID_NO
                       QuotedStr(TempCode)    + ',' +        //ID_CODE
                       QuotedStr(IntToStr(i)) + ',' +        //ID_BANK
                       QuotedStr(FormatFloat('00',j)) + ',' +//ID_BAY
                       QuotedStr(FormatFloat('00',k)) + ',' +//ID_LEVEL
                       ' ''0'', '+  //ID_STATUS
                       ' ''1'', '+  //IN_USED
                       ' ''1'', '+  //OT_USED
                       ' ''A'') ';  //ID_ZONE

            SQL.Text := aStrSQL ;
            ExecSQL ;

          end;
        end;
      end;
      if MainDm.MainDB.InTransaction then MainDm.MainDB.CommitTrans;
    except
      if qryCell.Active then qryCell.Close;
    end;
  end;

end;

//==============================================================================
// CB_ID_STATUSChange
//==============================================================================
procedure TfrmU310.CB_ID_STATUSChange(Sender: TObject);
begin
  if (Sender as TComboBox).ItemIndex=0 then
  begin
    edtITM_CD.Text   := '';
    edtITM_NAME.Text := '';
    edtITM_SPEC.Text := '';
    edtITM_QTY.Text  := '0';
    edtID_MEMO.Text  := '';
  end else
  if (Sender as TComboBox).ItemIndex=1 then
  begin
    edtITM_CD.Text   := 'EPLT';
    edtITM_NAME.Text := '공파레트';
    edtITM_SPEC.Text := '공파레트';
    edtITM_QTY.Text  := '1';
  end;

end;

end.





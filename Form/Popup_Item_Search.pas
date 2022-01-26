unit Popup_Item_Search;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, Buttons, d_MainDm, h_MainLib, h_ReferLib,
  DB, ADODB, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,
  Vcl.Mask, Vcl.DBCtrls, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh;

type
  TfrmPopup_Item_Search = class(TForm)
    Pnl_Main: TPanel;
    Pnl_Top: TPanel;
    Pnl_BTN: TPanel;
    Pnl_Btn5: TPanel;
    btnClose: TSpeedButton;
    Pnl_Btn0: TPanel;
    btnSave: TSpeedButton;
    Panel24: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    PnlFormName: TPanel;
    Shape3: TShape;
    dsInfo: TDataSource;
    qryInfo: TADOQuery;
    Pnl_Sub: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel16: TPanel;
    dgInfo: TDBGridEh;
    Panel1: TPanel;
    gbCode: TGroupBox;
    cbCode: TComboBox;
    qryTemp: TADOQuery;
    lbl_CODE: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure cbCodeChange(Sender: TObject);
    procedure cbCodeKeyPress(Sender: TObject; var Key: Char);
    procedure dgInfoCellClick(Column: TColumnEh);
    procedure dgInfoDblClick(Sender: TObject);
  private
    procedure SetItemList;
    { Private declarations }
  public
    { Public declarations }
    procedure SetComboBox;
  end;

var
  frmPopup_Item_Search: TfrmPopup_Item_Search;

implementation

uses U220;

{$R *.dfm}

//==============================================================================
// btnSaveClick
//==============================================================================
procedure TfrmPopup_Item_Search.btnSaveClick(Sender: TObject);
begin
  if Trim(lbl_Code.Caption)='' then
  begin
    MessageDlg('선택 된 코드가 없습니다.', mtConfirmation, [mbYes], 0) ;
    Exit;
  end else
  begin
    frmU220.edtCode.Text := lbl_Code.Caption ;
    frmU220.Pnl_ITM2.BevelInner := bvRaised ;
    frmU220.Pnl_ITM2.Font.Color := clBlack ;
    Close;
  end;
end;

//==============================================================================
// FormActivate
//==============================================================================
procedure TfrmPopup_Item_Search.FormActivate(Sender: TObject);
begin
  SetComboBox ;
  SetItemList;
end;

//==============================================================================
// FormDeactivate
//==============================================================================
procedure TfrmPopup_Item_Search.FormDeactivate(Sender: TObject);
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
procedure TfrmPopup_Item_Search.FormClose(Sender: TObject; var Action: TCloseAction);
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
  try frmPopup_Item_Search := Nil ;
  except end;
end;

//==============================================================================
// SetItemList
//==============================================================================
procedure TfrmPopup_Item_Search.SetItemList;
var
  StrSQL : String;
begin
  try
    with qryInfo do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' Select ITM_CD, ITM_NAME, ITM_SPEC, ITM_QTY, ' +
                '        ITM_YN, MEMO, UP_DATE, CR_DATE       ' +
                '   From TM_ITEM ' +
                '  Where 1=1 ' ;

      // 코드
      if (Trim(cbCode.Text) <> '') and (Trim(cbCode.Text) <> '전체') then
        StrSQL := StrSQL + ' And ITM_CD Like ''%' + UpperCase(Trim(cbCode.Text)) + '%'' ' ;

      StrSQL := StrSQL + ' Order By ITM_CD ' ;

      SQL.Text := StrSQL;
      Open;
    end;
  except
    if qryInfo.Active then qryInfo.Close;
  end;
end;

//==============================================================================
// btnCloseClick
//==============================================================================
procedure TfrmPopup_Item_Search.btnCloseClick(Sender: TObject);
begin
  frmU220.Pnl_ITM2.BevelInner := bvRaised ;
  frmU220.Pnl_ITM2.Font.Color := clBlack ;
  Close;
end;

//==============================================================================
// cbCodeChange
//==============================================================================
procedure TfrmPopup_Item_Search.cbCodeChange(Sender: TObject);
begin
  SetItemList;
end;

//==============================================================================
// cbCodeKeyPress
//==============================================================================
procedure TfrmPopup_Item_Search.cbCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    SetItemList;
  end;
end;

//==============================================================================
// SetComboBox [콤보박스 데이터 추가]
//==============================================================================
procedure TfrmPopup_Item_Search.SetComboBox;
var
  i : integer ;
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

      i := 0 ;
      while not(Eof) do
      begin
        if i=0 then
        begin
          lbl_CODE.Caption := FieldByName('ITM_CD').AsString ;
          inc(i);
        end;

        cbCode.Items.Add(FieldByName('ITM_CD').AsString);
        Next ;
      end;

    end;
  except
    if qryTemp.Active then qryTemp.Close;
  end;
end;

//==============================================================================
// dgInfoCellClick
//==============================================================================
procedure TfrmPopup_Item_Search.dgInfoCellClick(Column: TColumnEh);
begin
  lbl_Code.Caption := qryInfo.FieldByName('ITM_CD').AsString ;
end;

//==============================================================================
// dgInfoCellClick
//==============================================================================
procedure TfrmPopup_Item_Search.dgInfoDblClick(Sender: TObject);
begin
  frmU220.edtCode.Text := qryInfo.FieldByName('ITM_CD').AsString ;
  frmU220.Pnl_ITM2.BevelInner := bvRaised ;
  frmU220.Pnl_ITM2.Font.Color := clBlack ;
  Close;
end;

end.

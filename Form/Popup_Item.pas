unit Popup_Item;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, Buttons, d_MainDm, h_MainLib, h_ReferLib,
  DB, ADODB, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,
  Vcl.Mask, Vcl.DBCtrls, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh;

type
  TfrmPopup_Item = class(TForm)
    Pnl_Main: TPanel;
    Pnl_Sub: TPanel;
    Pnl_Top: TPanel;
    Pnl_BTN: TPanel;
    Pnl_Btn5: TPanel;
    btnClose: TSpeedButton;
    Pnl_Btn0: TPanel;
    btnSave: TSpeedButton;
    qryCommand: TADOQuery;
    Panel24: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel16: TPanel;
    Pnl_ITM_CD: TPanel;
    Pnl_ITM_DESC: TPanel;
    Pnl_MODEL_SPEC: TPanel;
    Pnl_ITM_YN: TPanel;
    Pnl_MEMO: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    qrySearch: TADOQuery;
    edtITM_CD: TEdit;
    edtITM_SPEC: TEdit;
    edtITM_QTY: TEdit;
    Panel4: TPanel;
    edtITM_NAME: TEdit;
    edtMemo: TEdit;
    cbITM_YN: TCheckBox;
    PnlFormName: TPanel;
    Shape3: TShape;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    procedure SetItemList;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPopup_Item: TfrmPopup_Item;

implementation

uses U110;

{$R *.dfm}

//==============================================================================
// btnSaveClick
//==============================================================================
procedure TfrmPopup_Item.btnSaveClick(Sender: TObject);
var
  strSQL, ITM_YN : String;
  ExecNo : integer ;
begin
  ITM_YN := '';
  if cbITM_YN.Checked then ITM_YN := 'Y'
  else                     ITM_YN := 'N';

  if btnSave.Caption = '수 정' then
  begin
    StrSQL := ' Update TM_ITEM ' +
            	'    Set ITM_NAME  = ' + QuotedStr(Trim(edtITM_Name.Text)) +
              '      , ITM_SPEC  = ' + QuotedStr(Trim(edtITM_Spec.Text)) +
            	'      , ITM_QTY   = ' + QuotedStr(Trim(edtITM_Qty.Text) ) +
            	'      , ITM_YN    = ' + QuotedStr(Trim(ITM_YN)          ) +
            	'      , MEMO      = ' + QuotedStr(Trim(edtMemo.Text)    ) +
            	'      , UP_DATE   = GETDATE() ' +
              ' Where ITM_CD = ' + QuotedStr(Trim(edtITM_CD.Text)  ) ;
  end else
  if btnSave.Caption = '등 록' then
  begin
    StrSQL := ' Insert Into TM_ITEM ( ' +
              '     ITM_CD   , ITM_NAME  , ITM_SPEC  , ' +
              '     ITM_QTY  , ITM_YN    , MEMO      , ' +
              '     CR_DATE  , UP_DATE )               ' +
              '   Values( ' +
              QuotedStr(Trim(edtITM_CD.Text)  ) + ',' + QuotedStr(Trim(edtITM_Name.Text)) + ',' +
              QuotedStr(Trim(edtITM_Spec.Text)) + ',' + QuotedStr(Trim(edtITM_Qty.Text) ) + ',' +
              QuotedStr(Trim(ITM_YN)          ) + ',' + QuotedStr(Trim(edtMemo.Text)    ) + ',' +
              ' GETDATE(), GETDATE() ) ' ;
  end;

  try
    with qryCommand do
    begin
      Close;
      SQL.Clear;
      SQL.Text := strSQL ;
      ExecNo := ExecSQL;
    end;
    frmU110.SetComboBox ;
    frmU110.fnCommandQuery;
    Close;
  except
    if qryCommand.Active then qryCommand.Close;
  end;
end;

//==============================================================================
// FormActivate
//==============================================================================
procedure TfrmPopup_Item.FormActivate(Sender: TObject);
begin
  SetItemList;
end;

//==============================================================================
// FormDeactivate
//==============================================================================
procedure TfrmPopup_Item.FormDeactivate(Sender: TObject);
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
procedure TfrmPopup_Item.FormClose(Sender: TObject; var Action: TCloseAction);
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
  try frmPopup_Item := Nil ;
  except end;
end;

//==============================================================================
// SetItemList
//==============================================================================
procedure TfrmPopup_Item.SetItemList;
var
  StrSQL : String;
begin
  try
    if btnSave.Caption = '수 정' then
    begin
      with qrySearch do
      begin
        Close;
        SQL.Clear;
        StrSQL := ' Select * From TM_ITEM ' +
                  '  Where Upper(ITM_CD) = ' + QuotedStr(UpperCase(Trim(edtITM_CD.Text))) ;
        SQL.Text := StrSQL;
        Open;

        if Not (Eof and Bof) then
        begin
          edtITM_NAME.Text := Trim(FieldByName('ITM_NAME').AsString);
          edtITM_SPEC.Text := Trim(FieldByName('ITM_SPEC').AsString);
          edtITM_QTY.Text  := Trim(FieldByName('ITM_QTY' ).AsString);
          cbITM_YN.Checked := Boolean(Trim(FieldByName('ITM_YN').AsString)='Y');
          edtMEMO.Text     := Trim(FieldByName('MEMO'    ).AsString);
        end;
      end;
    end else
    if btnSave.Caption = '등 록' then
    begin
      edtITM_NAME.Text := '';
      edtITM_SPEC.Text := '';
      edtITM_QTY.Text  := '';
      cbITM_YN.Checked := True;
      edtMEMO.Text     := '';
    end;
  except
    if qrySearch.Active then qrySearch.Close;
  end;
end;

//==============================================================================
// btnCloseClick
//==============================================================================
procedure TfrmPopup_Item.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.

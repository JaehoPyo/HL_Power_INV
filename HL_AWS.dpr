program HL_AWS;

uses
  Vcl.Forms,
  Main in 'Form\Main.pas' {frmMain},
  d_MainDm in 'Lib\d_MainDm.pas' {MainDm: TDataModule},
  h_MainLib in 'Lib\h_MainLib.pas',
  h_LangLib in 'Lib\h_LangLib.pas',
  U110 in 'Form\U110.pas' {frmU110},
  h_ReferLib in 'Lib\h_ReferLib.pas',
  ExLibrary in 'Lib\ExLibrary.pas',
  ExStrLib in 'Lib\ExStrLib.pas',
  ExVclLib in 'Lib\ExVclLib.pas',
  ExVarLib in 'Lib\ExVarLib.pas',
  Popup_Item in 'Form\Popup_Item.pas' {frmPopup_Item},
  U210 in 'Form\U210.pas' {frmU210},
  Popup_Item_Search in 'Form\Popup_Item_Search.pas' {frmPopup_Item_Search},
  U220 in 'Form\U220.pas' {frmU220},
  U230 in 'Form\U230.pas' {frmU230};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainDm, MainDm);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmU230, frmU230);
  Application.Run;
end.

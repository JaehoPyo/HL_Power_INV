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
  U230 in 'Form\U230.pas' {frmU230},
  U310 in 'Form\U310.pas' {frmU310},
  U320 in 'Form\U320.pas' {frmU320},
  U410 in 'Form\U410.pas' {frmU410},
  U420 in 'Form\U420.pas' {frmU420},
  U510 in 'Form\U510.pas' {frmU510},
  U520 in 'Form\U520.pas' {frmU520},
  U240 in 'Form\U240.pas' {frmU240},
  U530 in 'Form\U530.pas' {frmU530};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainDm, MainDm);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmU530, frmU530);
  Application.Run;
end.

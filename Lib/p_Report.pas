unit p_Report;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frxClass, StdCtrls, DBGrids, ADODB ;

type
  PrintType = ( ptPrint, ptPreview );

  PrintInfo = record
     ActionType   : PrintType ;
     TitleCaption : String;
     LeftText_1   , LeftText_2 : String;
  end;

type
  TfrmReport = class(TForm)
    Button1: TButton;
    frxReport: TfrxReport;
    StringDS: TfrxUserDataSet;
    procedure Button1Click(Sender: TObject);
    procedure frxReportGetValue(const VarName: string; var Value: Variant);

  private
    { Private declarations }
    P  : PrintInfo;
    sL : TStringList ;
    Procedure ReportSetting (var QrGrid: TDBGrid; var QrQry: TADOQuery) ;
  public
    { Public declarations }
  end;
    function  DBGridToReport(InGrid: TDBGrid; InQry: TADOQuery;  Rp: PrintInfo ) : Boolean ;
var
  frmReport: TfrmReport;
  QrGrid: TDBGrid;
  QrQry : TADOQuery ;

implementation

{$R *.DFM}

//==============================================================================
// Äü ¸®Æ÷Æ®¸¦ ¶Ù¿ì´Â ÇÔ¼ö
//==============================================================================
function DBGridToReport(InGrid: TDBGrid; InQry: TADOQuery; Rp :PrintInfo ) : Boolean ;
begin
  if not Assigned( frmReport ) then
  begin
    frmReport := TfrmReport.Create( Application );
    try
      with frmReport Do
      begin
        P := Rp;
        QrGrid := InGrid;
        QrQry  := InQry ;
        ReportSetting (QrGrid, QrQry) ;
        frxReport.ShowReport;
      end;
    finally
      frmReport.Free;
      frmReport := nil ;
    end;
  end;
end;

//==============================================================================
// Äü ¸®Æ÷Æ®¸¦ ¶Ù¿ì´Â ÇÔ¼ö
//==============================================================================
procedure TfrmReport.frxReportGetValue(const VarName: string; var Value: Variant);
begin
  if CompareText(VarName, 'ReportTitle') = 0 then
  begin
    Value := P.TitleCaption ;

  end ;
end;

Procedure TfrmReport.ReportSetting (var QrGrid: TDBGrid; var QrQry: TADOQuery) ;
var
  i : Integer;
begin
{  sL := TStringList.Create ;
  for i := 0 to QrGrid.FieldCount-1 do
  begin
    sL.Add(QrGrid.Columns[i].Title.Caption) ;
  end;}


end;



procedure TfrmReport.Button1Click(Sender: TObject);
begin
//  StringDS.RangeEnd := reCount;
//  StringDS.RangeEndCount := sl.Count;
//  frxReport1.ShowReport;

end;


end.

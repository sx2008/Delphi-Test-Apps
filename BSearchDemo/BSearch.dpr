program BSearch;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  BinarySearch in 'BinarySearch.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

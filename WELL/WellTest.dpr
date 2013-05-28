program WellTest;

uses
  Forms,
  UWellTest in 'UWellTest.pas' {Form1},
  Well1024 in 'Well1024.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

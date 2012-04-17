program Selfcheck;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  MD5windows in 'MD5windows.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

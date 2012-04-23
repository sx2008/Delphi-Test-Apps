program FileTest;

uses
  Forms,
  main in 'main.pas' {Form1},
  UStopWatch in 'UStopWatch.pas',
  USpeedTest in 'USpeedTest.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

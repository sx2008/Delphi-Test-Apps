program FileSpeedTest;

uses
  Forms,
  USpeedTestForm in 'USpeedTestForm.pas' {Form1},
  USpeedTest in 'USpeedTest.pas',
  UStopWatch in 'UStopWatch.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

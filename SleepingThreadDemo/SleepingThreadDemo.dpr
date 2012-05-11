program SleepingThreadDemo;

uses
  Forms,
  UMainForm in 'UMainForm.pas' {Form1},
  UMyThread in 'UMyThread.pas',
  USleepingThread in 'USleepingThread.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

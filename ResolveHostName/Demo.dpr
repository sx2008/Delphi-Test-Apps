program Demo;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {MainForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'WinSock Demo';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

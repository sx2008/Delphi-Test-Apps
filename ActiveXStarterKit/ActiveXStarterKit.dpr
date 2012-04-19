program ActiveXStarterKit;

uses
  Forms,
  MainForm in 'MainForm.pas' {Form1},
  ActiveXStarterKit_TLB in 'ActiveXStarterKit_TLB.pas',
  UApplication_impl in 'UApplication_impl.pas' {Application_: CoClass};

{$R *.TLB}

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

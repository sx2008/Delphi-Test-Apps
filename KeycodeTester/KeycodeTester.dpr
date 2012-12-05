program KeycodeTester;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  UVKeyCodesForm in 'UVKeyCodesForm.pas' {VKeyCodesForm},
  MouseTestForm in 'MouseTestForm.pas' {FrmMouseTest};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

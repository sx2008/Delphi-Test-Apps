program PageListDemo;

uses
  Forms,
  UMainForm in 'UMainForm.pas' {Form1},
  UPageList in 'UPageList.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

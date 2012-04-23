program FileScannerDemo;

uses
  Forms,
  MainForm in 'MainForm.pas' {Form1},
  FileScanner in 'FileScanner.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'File Scanner Demo';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

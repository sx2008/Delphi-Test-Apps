program HttpUploader;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  VariantUtils2 in 'VariantUtils2.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

program HttpDownloader;

uses
  Forms,
  UDownloader in 'UDownloader.pas' {Form1},
  VariantUtils2 in 'VariantUtils2.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

program PearsonHash;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  UPearsonHash in 'UPearsonHash.pas',
  URandomString in 'URandomString.pas',
  UBuckets in 'UBuckets.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

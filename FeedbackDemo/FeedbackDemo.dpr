program FeedbackDemo;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  CommUnit in 'CommUnit.pas',
  FeedbackFormUnit in 'FeedbackFormUnit.pas' {FeedbackForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFeedbackForm, FeedbackForm);
  Application.Run;
end.

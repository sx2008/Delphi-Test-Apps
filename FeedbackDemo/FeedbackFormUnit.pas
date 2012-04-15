unit FeedbackFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CommUnit, StdCtrls, ComCtrls;

type
  TFeedbackForm = class(TForm, IFeedback)
    ProgressBar1: TProgressBar;
    Memo1: TMemo;
  private
    { Private-Deklarationen }
    procedure WriteMessage(const msg:string);
    procedure SetProgressMinMax(min,max:Integer);
    procedure SetPosition(position:Integer);

  public
    { Public-Deklarationen }
  end;

var
  FeedbackForm: TFeedbackForm;

implementation

{$R *.dfm}

{ TForm2 }

procedure TFeedbackForm.SetPosition(position: Integer);
begin
  ProgressBar1.Position := position;
end;

procedure TFeedbackForm.SetProgressMinMax(min, max: Integer);
begin
  progressbar1.Min := min;
  ProgressBar1.Max := max;
end;

procedure TFeedbackForm.WriteMessage(const msg: string);
begin
  Memo1.Lines.Add(msg);
  BringToFront;
end;

end.

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type

  TForm1 = class(TForm)
    Timer1: TTimer;
    BtnStart: TButton;
    BtnStop: TButton;
    procedure BtnStartClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BtnStopClick(Sender: TObject);
  private
    { Private-Deklarationen }
    FNextMethod : TThreadMethod;
  public
    { Public-Deklarationen }
    procedure CallDelayedMethod(delay:cardinal; method:TThreadMethod);

    procedure AmpelRot;
    procedure AmpelGelb;
    procedure AmpelGruen;
    procedure AmpelAus;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.CallDelayedMethod(delay: cardinal; method: TThreadMethod);
begin
  timer1.Enabled := false;
  FNextMethod := method;
  timer1.Interval := delay;
  timer1.Enabled := True;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;
  if Assigned(FNextMethod) then
  begin
    FNextMethod;
  end;
end;

procedure TForm1.AmpelRot;
begin
  color := clRed;
  CallDelayedMethod(1500, AmpelGelb);
end;

procedure TForm1.AmpelGelb;
begin
  color := clYellow;
  CallDelayedMethod(800, AmpelGruen);
end;

procedure TForm1.AmpelGruen;
begin
  color := clGreen;
  CallDelayedMethod(3000, AmpelRot);
end;

procedure TForm1.AmpelAus;
begin
  color := clBtnFace;
end;



procedure TForm1.BtnStartClick(Sender: TObject);
begin
  CallDelayedMethod(200, AmpelRot);
end;


procedure TForm1.BtnStopClick(Sender: TObject);
begin
  CallDelayedMethod(50, AmpelAus);
end;

end.

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, ComCtrls;

type
  TForm1 = class(TForm)
    ProgressBar1: TProgressBar;
    BtnStart: TBitBtn;
    BtnStop: TBitBtn;
    Timer1: TTimer;
    EdtTimeout: TEdit;
    Label1: TLabel;
    BtnFireNow: TBitBtn;
    EdtRestzeit: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    procedure BtnStartClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BtnStopClick(Sender: TObject);
    procedure BtnFireNowClick(Sender: TObject);
  private
    { Private-Deklarationen }
    FStartTime  : TDateTime;
    FNextAction : TDateTime;
    procedure CheckButtons;
    procedure UpdateProgressBar;
    procedure CalcNextAction;

    function ElapsedTime:Double;  // abgelaufene Zeit
    function Restzeit:Double;
    function RestzeitMinuten:Double;
    function RestzeitSekunden:Double;

  public
    { Public-Deklarationen }
    procedure DoAktion;virtual;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses mmsystem;


Const
OneMinute = 1.0/(24.0*60.0);


procedure TForm1.BtnStartClick(Sender: TObject);
begin
   CalcNextAction;

   Timer1.Enabled := True;
   CheckButtons;
   UpdateProgressBar;
end;

procedure TForm1.CheckButtons;
begin
   BtnStart.Enabled := not Timer1.Enabled;
   BtnStop.Enabled  := Timer1.Enabled;
end;

procedure TForm1.DoAktion;
var
   i : Integer;
   b : Boolean;
begin
   MessageBeep(MB_OK);
   FlashWindow(Handle, True);
   // Wecker klingelt :-)
   PlaySound('RingIn', 0, SND_ALIAS);
   FlashWindow(Handle, False);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
   if Now >= FNextAction then
   begin
      DoAktion;
      CalcNextAction;
   end;
   UpdateProgressBar;
end;

procedure TForm1.BtnStopClick(Sender: TObject);
begin
   Timer1.Enabled := False;
   CheckButtons;
   ProgressBar1.Position := ProgressBar1.Min;
end;

procedure TForm1.UpdateProgressBar;
begin
   ProgressBar1.Position := Trunc(ElapsedTime/(FNextAction-FStartTime)*ProgressBar1.Max);
   EdtRestzeit.Text:= TimeToStr(Restzeit);
end;

procedure TForm1.CalcNextAction;
begin
   FStartTime  := Now;
   FNextAction := FStartTime+ StrToFloat(EdtTimeout.Text)*OneMinute;
end;

procedure TForm1.BtnFireNowClick(Sender: TObject);
begin
   DoAktion;
end;

function TForm1.Restzeit: Double;
begin
   Result := FNextAction-Now;
end;

function TForm1.ElapsedTime: Double;
begin
   Result := Now-FStartTime;
end;

function TForm1.RestzeitMinuten: Double;
begin
   Result := Restzeit * 24.0 * 60.0;
end;

function TForm1.RestzeitSekunden: Double;
begin
   Result := Restzeit * 24.0 * 60.0* 60.0;
end;


end.

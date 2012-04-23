unit Unit1;

{
Dieses kleine Demo soll demonstrieren, wie man eine Paintbox richtig benützt.
Es darf kostenlos kopiert und verändert (bitte nur verbessern) werden.
Author: shmia@DelphiPraxis.net
}


interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
   TLights = 1..3;


  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    Panel1: TPanel;
    RgpColor: TRadioGroup;
    TrackBarHor: TTrackBar;
    procedure PaintBox1Paint(Sender: TObject);
    procedure RgpColorClick(Sender: TObject);
    procedure TrackBarHorChange(Sender: TObject);
  private
    { Private-Deklarationen }

    function GetColor(IdxLight:TLights):TColor;

  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

// Farbe für den 1. , 2. oder 3. Kreis zurückliefern
function TForm1.GetColor(IdxLight: TLights): TColor;
var
   RIndex : Integer;  // Index der Radio-Group
begin
   RIndex := RgpColor.ItemIndex;

   case IdxLight of
      1:
      begin
         if (RIndex = 0) or (RIndex=3) then
            Result := clRed
         else
            Result := clDkGray;
      end;
      2:
      begin
         if (RIndex = 1) or (RIndex=3) then
            Result := clYellow
         else
            Result := clDkGray;
      end;
      3:
      begin
         if RIndex = 2 then
            Result := clGreen
         else
            Result := clDkGray;
      end;
   end;
end;


// Das OnPaint-Event ist die zentrale Stelle, an der auf die Paintbox
// gezeichnet werden darf
// Man darf die Paintbox nur innerhalb dieses Eventhandlers ansprechen
// Zeichnet man ausserhalb diese Methode, dann verschwindet das
// was man gezeichnet hat, sobald ein neue WM_PAINT Event eintrifft.
procedure TForm1.PaintBox1Paint(Sender: TObject);
const
   DURCHMESSER = 40;
var
   canvas : TCanvas;
   r2 : TRect;
   x, y : Integer;
begin
   // Wichtig: wir besorgen uns zuerst den Canvas der Paintbox
   // das spart viel Schreibarbeit und vereinfacht den Code
   canvas := (Sender as TPaintBox).Canvas;

   x := TrackBarHor.Position;
   y := 10;

   // rotes Licht
   r2 := Rect(x, y, x+DURCHMESSER, y+DURCHMESSER);
   canvas.Brush.Color := GetColor(1);
   canvas.Ellipse(r2);

   // gelbes Licht
   OffsetRect(r2, 0, 50);
   canvas.Brush.Color := GetColor(2);
   canvas.Ellipse(r2);

   // grünes Licht
   OffsetRect(r2, 0, 50);
   canvas.Brush.Color := GetColor(3);
   canvas.Ellipse(r2);

   // Uhrzeit ausgeben
   canvas.Brush.Color := clWhite;
   canvas.TextOut(PaintBox1.Width div 2 - 25, 70, FormatDateTime('hh:nn:ss.zzz',now));
end;

procedure TForm1.RgpColorClick(Sender: TObject);
begin
   // Nachdem die Aktive Checkbox geändert wurde
   // müssen wir noch dafür sorgen, dass die Paintbox neu gezeichnet wird
   PaintBox1.Invalidate;
end;

procedure TForm1.TrackBarHorChange(Sender: TObject);
begin
   // Paintbox neu zeichnen, wenn Hor. Position sich ändert
   PaintBox1.Invalidate;
end;

end.

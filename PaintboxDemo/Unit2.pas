unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    ColorDialog1: TColorDialog;
    Panel1: TPanel;
    Button1: TButton;
    procedure PaintBox1Paint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure PaintFarbverlauf(Canvas:TCanvas; x,y:Integer);
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}


// Farbe zwischen 2 vorgegebenen Farbwerten berechnen
function ColorBetween(C1, C2 : TColor; blend:Real):TColor;
var
   r, g, b : Byte;

   y1, y2 : Byte;
begin
   C1 := ColorToRGB(C1);
   C2 := ColorToRGB(C2);

   y1 := GetRValue(C1);
   y2 := GetRValue(C2);

   r := Round(y1 + (y2-y1)*blend);

   y1 := GetGValue(C1);
   y2 := GetGValue(C2);

   g := Round(y1 + (y2-y1)*blend);

   y1 := GetBValue(C1);
   y2 := GetBValue(C2);

   b := Round(y1 + (y2-y1)*blend);
   Result := RGB(r, g, b);
end;

// Farbe zwischen beliebig vielen vorgegebenen Farbwerten berechnen
function ColorsBetween(const colors:array of TColor; blend:Real):TColor;
var
   a : Integer;
   faktor : Real;
begin
   if Length(colors) < 2 then
      raise Exception.Create('ColorsBetween() at least 2 Colors required');

   if blend <= 0.0 then
      Result := colors[0]
   else if blend >= 1.0 then
      Result := colors[High(colors)]
   else
   begin
      a := Trunc(High(colors) * blend);
      faktor := 1.0 / High(colors);

      Result := ColorBetween(colors[a], colors[a+1], (blend-(a * faktor)) / faktor);
   end;
end;



procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
   PaintFarbverlauf(PaintBox1.Canvas, PaintBox1.Width, PaintBox1.Height);
end;

procedure TForm1.PaintFarbverlauf(Canvas:TCanvas; x,y:Integer);
var
   i : Integer;
   c : TColor;
begin
   c := ColorDialog1.Color;
   for i := 0 to x do
   begin
      Canvas.Pen.Color := ColorsBetween([clWhite, c, clBlack], i * 1.0/x);
      Canvas.MoveTo(i, 0);
      Canvas.LineTo(i, y);
   end;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   ColorDialog1.Execute;
   PaintBox1.Refresh;
end;

end.

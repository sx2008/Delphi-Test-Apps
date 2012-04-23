unit UCountryFlag;

interface

uses Windows, Graphics;

type

  // diese Klasse zeichnet verschiedene skalierbare Landesflaggen
  TCountryFlag = class(TObject)
  private
    FNationality: Integer;
    FCanvas: TCanvas;
    procedure PaintRect(r:TRect; color : TColor);
    procedure PaintVerticalFlag(rect:TRect; c1,c2,c3:TColor);
    procedure PaintHorizontalFlag(rect:TRect; c1,c2,c3:TColor);

    procedure GermanFlag(rect:TRect);
    procedure FrenchFlag(rect:TRect);
    procedure BelgianFlag(rect:TRect);
    procedure ItalianFlag(rect:TRect);
    procedure SpanishFlag(rect:TRect);
    procedure IrishFlag(rect:TRect);

  public
    procedure Paint(rect:TRect);
    property Nationality: Integer read FNationality write FNationality;
    property Canvas:TCanvas read FCanvas write FCanvas;
  end;


implementation


{ TCountryFlag }

// Rechteck mit Farbe "color" zeichnen
procedure TCountryFlag.PaintRect(r: TRect; color: TColor);
begin
   canvas.Brush.Color := color;
   canvas.FillRect(r);
end;


procedure TCountryFlag.PaintVerticalFlag(rect: TRect; c1, c2, c3: TColor);
var
   h : Integer;
   r : TRect;
begin
   h := (rect.Bottom - rect.Top) div 3;
   r := rect;
   r.Bottom := r.Top + h;
   PaintRect(r, c1);

   r.Top    := rect.Top + h;
   r.Bottom := r.Top + h;
   PaintRect(r, c2);

   r.Top    := rect.Top + h * 2;
   r.Bottom := r.Top + h;
   PaintRect(r, c3);
end;

procedure TCountryFlag.PaintHorizontalFlag(rect: TRect; c1, c2, c3: TColor);
var
   w : Integer;
   r : TRect;
begin
   w := (rect.Right - rect. Left) div 3;

   r := rect;
   r.Right := r.Left + w;
   PaintRect(r, c1);

   r.Left  := rect.Left + w;
   r.Right := r.Left + w;
   PaintRect(r, c2);

   r.Left  := rect.Left + w * 2;
   r.Right := r.Left + w;
   PaintRect(r, c3);
end;


procedure TCountryFlag.FrenchFlag(rect: TRect);
const
  BLAU    = $A45500;
  WEISS   = $FFFFFF;
  ROT     = $3145EF;
begin
   PaintHorizontalFlag(rect, BLAU, WEISS, ROT);
end;

procedure TCountryFlag.GermanFlag(rect: TRect);
const
  SCHWARZ = $000000;
  ROT     = $0000FF;
  GOLD    = $00CCFF;
begin
   PaintVerticalFlag(rect, SCHWARZ, ROT, GOLD);
end;


procedure TCountryFlag.BelgianFlag(rect: TRect);
const
   SCHWARZ = $000000;
   GELB    = $00D4FF;
   ROT     = $2A31E0;
begin
   PaintHorizontalFlag(rect, SCHWARZ, GELB, ROT);
end;

procedure TCountryFlag.ItalianFlag(rect: TRect);
const
   // TODO: richtige Farben suchen
   GRUEN    = $00A000;
   WEISS    = $FFFFFF;
   ROT      = $2A31E0;
begin
   PaintHorizontalFlag(rect, GRUEN, WEISS, ROT);
end;

procedure TCountryFlag.SpanishFlag(rect: TRect);
const
   // TODO: richtige Farben suchen
   ROT      = $2A31E0;
   GELB    = $00D4FF;
var
   h : Integer;
   r : TRect;
begin
   h := (rect.Bottom - rect.Top) div 4;
   r := rect;
   r.Bottom := r.Top + h;
   PaintRect(r, ROT);

   r.Top    := rect.Top + h;
   r.Bottom := r.Top + h * 2;
   PaintRect(r, GELB);

   r.Top    := rect.Top + h * 3;
   r.Bottom := r.Top + h;
   PaintRect(r, ROT);
end;


procedure TCountryFlag.IrishFlag(rect: TRect);
const
   // TODO: richtige Farben suchen
   GRUEN    = $439500;
   WEISS    = $FFFFFF;
   ORANGE   = $0073FF;
begin
   PaintHorizontalFlag(rect, GRUEN, WEISS, ORANGE);
end;


procedure TCountryFlag.Paint(rect: TRect);
begin
   Assert(Assigned(Canvas));
   case Nationality of
      0 : GermanFlag(rect);
      1 : FrenchFlag(rect);
      2 : BelgianFlag(rect);
      3 : ItalianFlag(rect);
      4 : SpanishFlag(rect);
      5 : IrishFlag(rect);
   end;
end;




end.

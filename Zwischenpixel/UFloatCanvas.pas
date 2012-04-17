unit UFloatCanvas;

interface

uses Graphics;

type

   TPixFactors = array[0..1, 0..1] of Double;

   TFloatCanvas = class(TObject)
   private
    class function CalcPixFactors(fx,fy : double):TPixFactors;

    function GetPixels(x, y: Double): TColor;

   public
     Canvas : TCanvas;
     constructor Create(ACanvas:TCanvas);

     property Pixels[x,y:Double]:TColor read GetPixels;
   end;



implementation

uses Windows;

{ TFloatCanvas }

class function TFloatCanvas.CalcPixFactors(fx, fy: double): TPixFactors;
begin
   Result[0,0] := (1-fx) * (1-fy);
   Result[1,0] := fx * (1-fy);
   Result[0,1] := (1-fx) * fy;
   Result[1,1] := fx * fy;
end;

constructor TFloatCanvas.Create(ACanvas: TCanvas);
begin
   inherited Create;
   Canvas := ACanvas;
end;

function TFloatCanvas.GetPixels(x, y: Double): TColor;
var
   ix, iy : Integer;
   p00, p10, p01, p11 : TColor;
   matrix : TPixFactors;
   r,g,b : word;

   function CalcColor(c00,c10,c01,c11:word):Word;
   begin
   Result := round(

      c00 * matrix[0,0]
   + c10 * matrix[1,0]
   + c01 * matrix[0,1]
   + c11 * matrix[1,1]
   );
   end;

begin
   ix := Trunc(x);
   iy := Trunc(y);

   // Farben aller 4 umgebenden Pixel holen
   p00 := Canvas.Pixels[ix,iy];
   p10 := Canvas.Pixels[ix+1,iy];
   p01 := Canvas.Pixels[ix,iy+1];
   p11 := Canvas.Pixels[ix+1,iy+1];

   // Interpolationsfaktoren berechnen
   matrix := CalcPixFactors(Frac(x), frac(y));

   // Interpolation getrennt nach Grundfarben Rot, Grün und Blau durchführen
   r := calccolor(GetRValue(p00), GetRValue(p10), GetRValue(p01), GetRValue(p11));
   g := calccolor(GetGValue(p00), GetGValue(p10), GetGValue(p01), GetGValue(p11));
   b := calccolor(GetBValue(p00), GetBValue(p10), GetBValue(p01), GetBValue(p11));

   Result := RGB(r,g,b);

end;


end.

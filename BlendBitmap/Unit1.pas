unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}



procedure BlendBitmap(BitmapA, BitmapB:TBitmap; bitmapOut:TBitmap; blend:double=0.5); overload;
var
  x, y: integer;
  RowA, RowB, RowOut: PRGBTriple;
  fA, fB : Word;
begin
   Assert(assigned(BitmapA));
   Assert(assigned(BitmapB));
   Assert(assigned(BitmapOut));

   fB := trunc(blend * 256);
   fA := 256-fB;

   BitmapA.PixelFormat := pf24bit;
   BitmapB.PixelFormat := pf24bit;
   bitmapOut.PixelFormat := pf24bit;


   for y := 0 to (BitmapA.Height - 1) do
   begin
     RowA   := BitmapA.Scanline[y];
     RowB   := BitmapB.Scanline[y];
     RowOut := bitmapOut.Scanline[y];
     for x := BitmapA.Width - 1 downto 0 do
     begin
       RowOut^.rgbtRed   := (RowA^.rgbtRed * fA    + RowB^.rgbtRed*fB) shr 8;
       RowOut^.rgbtGreen := (RowA^.rgbtGreen * fA  + RowB^.rgbtGreen*fB) shr 8;
       RowOut^.rgbtBlue  := (RowA^.rgbtBlue * fa   + RowB^.rgbtBlue*fB) shr 8;
       Inc(RowA);
       Inc(RowB);
       Inc(RowOut);
     end;
   end;
end;

procedure BlendBitmap(BitmapA, bitmapOut:TBitmap; color:TColor;blend:double=0.5); overload;
var
  x, y: integer;
  RowA, RowOut: PRGBTriple;
  fA, fB : Word;
  r, g, b : Word;
begin
   Assert(assigned(BitmapA));
   Assert(assigned(BitmapOut));

   fB := trunc(blend * 256);
   if fB > 256 then
      fB := 256;
   fA := 256-fB;

   BitmapA.PixelFormat := pf24bit;
   bitmapOut.PixelFormat := pf24bit;

   color := ColorToRGB(color);
   r := GetRValue(color) * fB;
   g := GetRValue(color) * fB;
   b := GetRValue(color) * fB;

   for y := 0 to (BitmapA.Height - 1) do
   begin
     RowA   := BitmapA.Scanline[y];
     RowOut := bitmapOut.Scanline[y];
     for x := BitmapA.Width - 1 downto 0 do
     begin
       RowOut^.rgbtRed   := (RowA^.rgbtRed * fA    + r) shr 8;
       RowOut^.rgbtGreen := (RowA^.rgbtGreen * fA  + g) shr 8;
       RowOut^.rgbtBlue  := (RowA^.rgbtBlue * fa   + b) shr 8;
       Inc(RowA);
       Inc(RowOut);
     end;
   end;
end;



procedure TForm1.TrackBar1Change(Sender: TObject);
var
   blend: Double;
begin
   blend := TrackBar1.Position / 100.0;
   BlendBitmap(Image1.Picture.Bitmap, Image2.Picture.Bitmap, Image3.Picture.Bitmap, blend);
   Image3.Repaint;
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
var
   blend: Double;
begin
   blend := TrackBar2.Position / 100.0;
   BlendBitmap(Image1.Picture.Bitmap, Image3.Picture.Bitmap, clGray, blend);
   Image3.Repaint;
end;

end.

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  jpeg, ExtCtrls, StdCtrls, Menus;

type
  TFloatPoint = record
    x, y : Double;
  end;

  TCalcCoords = function(x,y:Integer): TFloatPoint of object;

  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Button1: TButton;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    SaveImage1: TMenuItem;
    SaveDialog1: TSaveDialog;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure SaveImage1Click(Sender: TObject);
  private
    { Private-Deklarationen }

    function Scale(x,y:Integer):TFloatPoint;
    function Sinus1(x,y:Integer):TFloatPoint;
    function Sinus2(x,y:Integer):TFloatPoint;
    function Gedreht(x,y:Integer):TFloatPoint;
    function Gedreht2(x,y:Integer):TFloatPoint;
    function Quadrat(x,y:Integer):TFloatPoint;
    function Quadrat2(x,y:Integer):TFloatPoint;

    procedure GetCalcMethod(var x:TCalcCoords);

    procedure Test(const src, dst : TBitmap);

  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses UFloatCanvas;


procedure TForm1.Button1Click(Sender: TObject);
var
   bm : TBitmap;
begin
   bm := TBitmap.Create;
   bm.Width := Image2.Width;
   bm.Height := Image2.Height;
   bm.PixelFormat := pf24bit;
   Image2.Picture.Graphic := bm;

   bm.Canvas.TextOut(30,30, 'test');

   test(Image1.Picture.Bitmap, Image2.Picture.Bitmap);

end;

procedure TForm1.Test(const src, dst : TBitmap);
var
   x, y : Integer;
   color : TColor;
   cv : TFloatCanvas;
   f : TCalcCoords;
   coord : TFloatPoint;
begin
   GetCalcMethod(f);

   cv := TFloatCanvas.Create(src.Canvas);


   for y := 0 to dst.Height-1 do
   begin
      for x := 0 to dst.Width-1 do
      begin
// schräges Bild
//         color := cv.Pixels[x*0.9 + 0.1*y ,y*0.4-0.1*x];
         coord := f(x,y);
         color := cv.Pixels[coord.x, coord.y];
         dst.Canvas.Pixels[x,y] := color;
      end;
   end;

end;

procedure TForm1.SaveImage1Click(Sender: TObject);
begin
   if SaveDialog1.Execute then
      Image2.Picture.SaveToFile(SaveDialog1.FileName);
end;


function TForm1.Scale(x, y: Integer): TFloatPoint;
begin
   Result.x := x*2;
   Result.y := y*2;
end;


function TForm1.Sinus1(x, y: Integer): TFloatPoint;
begin
   Result.x := x*0.9 + 7 * sin(y / 10);
   Result.y := y + 7 * sin(x / 10);
end;

function TForm1.Sinus2(x, y: Integer): TFloatPoint;
var
   d : Double;
begin
   d := SQRT(SQR(x - 200) + SQR(y-200)) * 0.5;
   Result.x := x - 5 * cos(d);
   Result.y := y + 5 * sin(d);
end;


function TForm1.Gedreht(x, y: Integer): TFloatPoint;
begin
   Result.x := x*1.4 + 0.1*y;
   Result.y := y*1.4 - 0.1*x;
end;

function TForm1.Gedreht2(x, y: Integer): TFloatPoint;
const
   d = 600;
   scale = 10;
   a = 0.01;
   b = 0.005;
   cd = 2;
begin
//   Result.x := x*1.4 + 0.2*y - 20;
//   Result.y := y*1.4 - 0.1*x - 20;
   Result.x := x / (a*x + b *y +cd) * scale -90;
   Result.y := y / (a*x + b *y +cd) * scale -90;
end;



function TForm1.Quadrat(x, y: Integer): TFloatPoint;
begin
   Result.x := x*1.4 + (200-x)*(200-x)*0.009;
   Result.y := y*1.4;
end;

function TForm1.Quadrat2(x, y: Integer): TFloatPoint;
begin
   Result.x := x*1.4 + (200-x)*(200-y)*0.009;
   Result.y := y*1.4;
end;


procedure TForm1.GetCalcMethod(var x:TCalcCoords);
begin
   case RadioGroup1.ItemIndex of
      0: x := Sinus1;
      1: x := Sinus2;
      2: x := Gedreht;
      3: x := Gedreht2;
      4: x := Quadrat;
      5: x := Quadrat2;
   else
      x := Scale;
   end;
end;




end.

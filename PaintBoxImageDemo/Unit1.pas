unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UCountryFlag;

type

  TForm1 = class(TForm)
    Label1: TLabel;
    Timer1: TTimer;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    Image1: TImage;
    GroupBox2: TGroupBox;
    PaintBox1: TPaintBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private-Deklarationen }
    FFlagge : TCountryFlag;

    procedure CreateEmptyPicture;
    procedure DrawFlagstoImage;

  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}


procedure TForm1.CreateEmptyPicture;
var
   bmp : TBitmap;
begin
   bmp := TBitmap.Create;
   bmp.PixelFormat := pf24bit;
   bmp.Width := Image1.Width;
   bmp.Height := Image1.Height;

   Image1.Picture.Graphic := bmp;

end;

procedure TForm1.DrawFlagstoImage;
const
   SIZE_X = 50;
   SIZE_Y = 25;
   ABSTAND = 5;
var
   i : Integer;
   r : TRect;
begin
   FFlagge.Canvas := Image1.Picture.Bitmap.Canvas;

   for i := 0 to 5 do
   begin
      FFlagge.Nationality := i;

      r.Left :=  5 + i * (SIZE_X - ABSTAND);
      r.Right := r.Left + SIZE_X;
      r.Top := i * (SIZE_Y + Abstand);
      r.Bottom := r.Top + SIZE_Y;
      FFlagge.Paint(r);
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FFlagge := TCountryFlag.Create;
  CreateEmptyPicture;
  DrawFlagstoImage;
  FFlagge.Nationality := 0;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
   FFlagge.Free;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
   FFlagge.Canvas := PaintBox1.Canvas;
   FFlagge.Paint(PaintBox1.ClientRect);
end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
   FFlagge.Nationality := (FFlagge.Nationality + 1) mod 6;
   PaintBox1.Invalidate;
end;



end.

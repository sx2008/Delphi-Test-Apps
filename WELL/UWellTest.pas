unit UWellTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Well1024;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private-Deklarationen }
    FWell : TWellRng1024;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation


{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
   i : Integer;
   v : Cardinal;
   f : Extended;
begin
  for i := 0 to 100 do
  begin
//  v := FWell.Random;
//  Memo1.Lines.Add(IntToStr(v));
    f := FWell.RandomFloat;
    Memo1.Lines.Add(FloatToStr(f));
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
   i : Integer;
   v : Cardinal;
   x,y :Integer;
begin
  for i := 0 to 50000 do
  begin
    v := FWell.Random;

    x := v mod 256;
    y := (v shr 8) mod 256;
    Canvas.Pixels[x,y] := clRed;

    v := v shr 16;

    x := v mod 256;
    y := (v shr 8) mod 256;
    Canvas.Pixels[x,y] := clBlack;


  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   FWell := TWellRng1024.Create;
   FWell.Randomize;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
   FWell.Free;
end;

end.

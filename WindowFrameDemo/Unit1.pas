unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    RgpColor: TRadioGroup;
  private
    { Private-Deklarationen }
  protected
    procedure WMNCPaint(var Msg: TWMNCPaint) ; message WM_NCPAINT;
    procedure WMNCACTIVATE(var Msg: TWMNCActivate) ; message WM_NCACTIVATE;

    function GetColor:TColor;
    procedure DrawCaptionText;

  public
    { Public-Deklarationen }

  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

{ TForm1 }

procedure TForm1.DrawCaptionText;
const
   captionText = 'Delphi Praxis Demo';
var
   canvas: TCanvas;

begin
   canvas := TCanvas.Create;
   try
      canvas.Handle := GetWindowDC(Self.Handle);
      with canvas do
      begin
         // Bereich überm Fenster
         Brush.Color := clLime;
         Rectangle(0, 0, Width-1, 23);


         // Rahmen
         Pen.Color := GetColor;
         Pen.Width := 7;
         Brush.Style := bsClear;
         Polygon([Point(0,0), Point(Width-1, 0),
            Point(Width-1, Height-1), Point(0, Height-1)]);

         Brush.Style := bsClear;
         Font.Color := clBlack;
         TextOut(20, 6, captionText) ;
      end;
   finally
      ReleaseDC(Self.Handle, canvas.Handle) ;
      canvas.Free;
   end;
end;

function TForm1.GetColor: TColor;
begin
   case RgpColor.ItemIndex of
      0:
         Result := clRed;
      1:
         Result := clGreen;
      2:
         Result := clYellow;
   else
      Result := clBlack;
   end;
end;

procedure TForm1.WMNCACTIVATE(var Msg: TWMNCActivate);
begin
   DrawCaptionText;
   Msg.Result := 0;
end;

procedure TForm1.WMNCPaint(var Msg: TWMNCPaint);
begin
   DrawCaptionText;
   Msg.Result := 0;
end;

end.
 
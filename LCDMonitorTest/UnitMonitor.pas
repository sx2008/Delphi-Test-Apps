unit UnitMonitor;

{
this Testprogramm is based on a freeware programm
http://www.vandekamer.com/program/lcdmonitortest.asp
}


interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus;

type
  TScreenForm = class(TForm)
    PopupMenu1: TPopupMenu;
    Kleur1: TMenuItem;
    Kleur2: TMenuItem;
    Kleur3: TMenuItem;
    Kleur4: TMenuItem;
    Kleur5: TMenuItem;
    Kleur6: TMenuItem;
    Kleur7: TMenuItem;
    Kleur8: TMenuItem;
    Menu1: TMenuItem;
    Menu2: TMenuItem;
    Menu3: TMenuItem;
    Menu4: TMenuItem;
    Menu5: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    OpenLabel: TLabel;
    ColorCycle1: TMenuItem;
    Raster1: TMenuItem;
    Pattern1: TMenuItem;
    Diagcross1: TMenuItem;
    Horizontal1: TMenuItem;
    Vertical1: TMenuItem;
    ShowMousePos1: TMenuItem;
    Flash1: TMenuItem;
    N1s1: TMenuItem;
    N05s1: TMenuItem;
    N01s1: TMenuItem;
    N005s1: TMenuItem;
    N0s1: TMenuItem;
    N001s1: TMenuItem;
    N002s1: TMenuItem;
    procedure KleurClick(Sender: TObject);
    procedure Menu1Click(Sender: TObject);
    procedure Menu2Click(Sender: TObject);
    procedure Menu4Click(Sender: TObject);
    procedure Menu5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure ColorCycle1Click(Sender: TObject);
    procedure Kleur1DrawItem(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; Selected: Boolean);
    procedure Raster1Click(Sender: TObject);
    procedure Diagcross1Click(Sender: TObject);
    procedure Horizontal1Click(Sender: TObject);
    procedure Vertical1Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ShowMousePos1Click(Sender: TObject);
    procedure N1s1Click(Sender: TObject);
    procedure N05s1Click(Sender: TObject);
    procedure N0s1Click(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure N01s1Click(Sender: TObject);
    procedure N005s1Click(Sender: TObject);
    procedure N001s1Click(Sender: TObject);
    procedure N002s1Click(Sender: TObject);
  private
    { Private declarations }
    FDrawGrid: boolean;
    FFlashing : Boolean;
    procedure DrawPattern(pt:TBrushStyle);
    procedure Flash(time:Integer);
  public
    { Public declarations }
    FormLeft, FormTop: integer;
  end;

var
  ScreenForm: TScreenForm;

implementation

{$R *.DFM}

const
  TTestColors: array[0..7] of TColor = (clBlack, clRed, clLime, clBlue, clYellow, clFuchsia, clAqua, clWhite);


procedure MakeFullScreenForm(form : TForm);
begin
   Assert(Assigned(form));
   Form.BorderStyle := bsNone;
   Form.FormStyle := fsStayOnTop;
   Form.SetBounds(0, 0, Screen.Width, Screen.Height);
end;

procedure ToggleMenuItem(item :TMenuItem);
begin
   item.Checked := not item.Checked;
end;


procedure TScreenForm.FormCreate(Sender: TObject);
begin
  FDrawGrid := False;
  Caption := Application.Title + ' v1.06 '+ Format('    %d * %d Pixels', [Screen.Width, Screen.Height]);
end;

procedure TScreenForm.FormPaint(Sender: TObject);
begin
  if FDrawGrid then Menu4Click(Sender);
end;

procedure TScreenForm.KleurClick(Sender: TObject);
begin
  OpenLabel.Visible := False;
  FDrawGrid := False;
  ScreenForm.Color := TTestColors[TMenuItem(Sender).MenuIndex];
end;

procedure TScreenForm.Menu1Click(Sender: TObject);
begin
  if TMenuItem(Sender).Checked then
  begin
    ScreenForm.BorderStyle := bsSingle;
    ScreenForm.FormStyle := fsNormal;
    ScreenForm.SetBounds(FormLeft, FormTop, 320, 80); end
  else begin
    FormTop := ScreenForm.Top;
    FormLeft := ScreenForm.Left;

    MakeFullScreenForm(Self);
  end;
  ToggleMenuItem(TMenuItem(Sender));
end;

procedure TScreenForm.Menu2Click(Sender: TObject);
begin
  if TMenuItem(Sender).Checked then begin
    ScreenForm.Cursor := crNone; end
  else begin
    ScreenForm.Cursor := crDefault;
  end;
  ToggleMenuItem(TMenuItem(Sender));
end;

procedure TScreenForm.Menu4Click(Sender: TObject);
begin
  FDrawGrid := True;
  OpenLabel.Visible := False;
  Canvas.Brush.Bitmap := AllocPatternBitmap(clWhite, clBlack);
  Canvas.FillRect(ClientRect);
  Update;
end;

procedure TScreenForm.Menu5Click(Sender: TObject);
begin
  ScreenForm.Close;
end;

procedure TScreenForm.ColorCycle1Click(Sender: TObject);
var
   i : Integer;
begin
  FDrawGrid := False;

  for i := Low(TTestColors) to High(TTestColors) do
  begin
     ScreenForm.Color := TTestColors[i];
     Application.ProcessMessages;
     if Application.Terminated then
      Break;

     Sleep(800);
  end;
end;

procedure TScreenForm.Kleur1DrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
begin
//   ACanvas.Brush.Color := clRed;
end;

procedure TScreenForm.DrawPattern(pt: TBrushStyle);
begin
   Canvas.Brush.Style := pt;
   Canvas.FillRect(ClientRect);
   Update;
end;

procedure TScreenForm.Raster1Click(Sender: TObject);
begin
   DrawPattern(bsCross);
end;

procedure TScreenForm.Diagcross1Click(Sender: TObject);
begin
   DrawPattern(bsDiagCross);
end;

procedure TScreenForm.Horizontal1Click(Sender: TObject);
begin
   DrawPattern(bsHorizontal);
end;

procedure TScreenForm.Vertical1Click(Sender: TObject);
begin
   DrawPattern(bsVertical);
end;

procedure TScreenForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
   s : string;
begin
   if ShowMousePos1.Checked then
   begin
      s := Format('(%d,%d)   ', [x,y]);
      Self.Canvas.TextOut(0,0, s);
   end;
end;

procedure TScreenForm.ShowMousePos1Click(Sender: TObject);
begin
   ToggleMenuItem(TMenuItem(Sender));
   Self.Repaint;
end;

procedure TScreenForm.Flash(time: Integer);
begin
  FDrawGrid := False;
  FFlashing := True;

  while FFlashing do
  begin
     ScreenForm.Color := clBlack;
     Application.ProcessMessages;
     if Application.Terminated then
      Break;
     Sleep(time);
     ScreenForm.Color := clWhite;
     Application.ProcessMessages;
     if Application.Terminated then
      Break;
     Sleep(time);
  end;
end;

procedure TScreenForm.N1s1Click(Sender: TObject);
begin
   Flash(1000);
end;

procedure TScreenForm.N05s1Click(Sender: TObject);
begin
   Flash(500);
end;

procedure TScreenForm.N0s1Click(Sender: TObject);
begin
   Flash(0);
end;

procedure TScreenForm.FormClick(Sender: TObject);
begin
   FFlashing := False;
end;

procedure TScreenForm.N01s1Click(Sender: TObject);
begin
   Flash(100);
end;

procedure TScreenForm.N005s1Click(Sender: TObject);
begin
   Flash(50);
end;

procedure TScreenForm.N001s1Click(Sender: TObject);
begin
   Flash(10);
end;

procedure TScreenForm.N002s1Click(Sender: TObject);
begin
   Flash(20);
end;

end.

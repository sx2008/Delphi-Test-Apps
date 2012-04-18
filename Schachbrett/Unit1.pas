unit Unit1;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, Grids, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    DrawGrid1: TDrawGrid;
    ImageList1: TImageList;
    Timer1: TTimer;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Button1: TButton;
    procedure DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure DrawGrid1DblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
    FFrames : Integer;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

const
   COL_COUNT = 8;
   ROW_COUNT = 8;

type
   TChessField = array[1..COL_COUNT, 1..ROW_COUNT] of Smallint;
var
   chessField : TChessField;

implementation

{$R *.DFM}


// dieser Eventhandler zeichnet auf dem Drwagrid
procedure TForm1.DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
   figur : Smallint;
   bkcolor : TColor;
begin
   if ACol = 0 then
   begin
      // Beschriftung vertikal
      if ARow <> 0 then
         DrawGrid1.Canvas.TextRect(Rect, Rect.Left+2, Rect.Top+2, IntToStr(ARow));
   end
   else if ARow = 0 then
   begin
      // Beschriftung horizontal
      DrawGrid1.Canvas.TextRect(Rect, Rect.Left+2, Rect.Top+2, chr(Ord('A')+ACol-1));
   end
   else
   begin
      // "eigentliches" Schachbrett

      // Hintergrund Farbe ermitteln
      if Odd(ACol+ARow) then
         bkcolor := clLime
      else
         bkcolor := clWhite;

      // Hintergrund zeichnen
      DrawGrid1.Canvas.brush.Color := bkcolor;
      DrawGrid1.Canvas.FillRect(rect);

      // Spielfigur zeichen
      figur := chessField[ACol, ARow];
      // figur = 0 zählt als leeres Feld
      if figur > 0 then
         ImageList1.Draw(DrawGrid1.Canvas, Rect.Left, Rect.Top, figur-1);
   end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
   x ,y : Integer;
begin
   // irgenwelche Figuren setzen
   x := 1 + random(COL_COUNT);
   y := 1 + random(ROW_COUNT);
   chessField[x,y] := random(ImageList1.Count);
   // Neuzeichnen erzwingen
   DrawGrid1.Invalidate;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
   with Sender as TCheckBox do
   begin
      if Checked then
         DrawGrid1.Options := DrawGrid1.Options + [goVertLine]
      else
         DrawGrid1.Options := DrawGrid1.Options - [goVertLine];
   end;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
   with Sender as TCheckBox do
   begin
      if Checked then
         DrawGrid1.Options := DrawGrid1.Options + [goHorzLine]
      else
         DrawGrid1.Options := DrawGrid1.Options - [goHorzLine];
   end;
end;

procedure TForm1.DrawGrid1DblClick(Sender: TObject);
var
   x , y : Integer;
   figur : Smallint;
begin
   x := DrawGrid1.Col;
   y := DrawGrid1.Row;
   // alte Figur holen
   figur := chessField[x,y];
   // nächste Figur wählen
   Inc(figur);
   // auspassen, damit wir nicht ausserhalb der Imageliste kommen
   if figur > ImageList1.Count then
      figur := 0;
   chessField[x,y] := figur;  // neue Figur setzen
   DrawGrid1.Invalidate;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
   x ,y : Integer;
begin
   x := 1 + random(COL_COUNT);
   y := 1 + random(ROW_COUNT);
   // alte Figur holen
   chessField[x,y] := random(ImageList1.Count);
   DrawGrid1.Invalidate;
   Inc(FFrames);
   Caption := IntToStr(FFrames);
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
   Timer1.Enabled := CheckBox3.Checked;
   FFrames := 0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   DrawGrid1.RowCount := ROW_COUNT;
   DrawGrid1.ColCount := COL_COUNT;
end;

end.

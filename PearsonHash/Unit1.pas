unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UBuckets, ComCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    ButtonStart: TButton;
    Button2: TButton;
    Button1: TButton;
    BtnOpenFile: TButton;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    MemoBest: TMemo;
    TabSheet2: TTabSheet;
    Memo3: TMemo;
    TabSheet3: TTabSheet;
    Memo4: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BtnOpenFileClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    { Private-Deklarationen }
    FOldQuality : double;
    FRunning : Boolean;
    FIterations : Integer;
    FTextLines : TStringList;
    FBuckets : TBucketCounter;
    FMaxSearchDepth : Integer;
    FSearchDepth : Integer;

    procedure CalcAllPearson;

    procedure DisplayHitsCounters(s:TStrings);
    procedure DisplayHitsGrafic;
    procedure Optimize;

    procedure GetHashTableText(list:TStrings);
    procedure Save(list:TStrings);
    procedure SavePascalCode(list:TStrings);

  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses UPearsonHash, URandomString;


var
   LTable, oldLTable : TPearsonTable;






{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
   FTextLines := TStringList.Create;
   FTextLines.Duplicates := dupIgnore;
   FTextLines.Sorted := True;

   FBuckets := TBucketCounter.Create(256);

   FRunning := False;
   InitPearsonTable(LTable);
//   ShufflePearsonTable(LTable);
   FMaxSearchDepth := 3;

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
   FBuckets.Free;
   FTextLines.Free;
end;

procedure TForm1.GetHashTableText(list: TStrings);
var
   i : Integer;
   s : string;
begin
   s := '';
   for i := low(LTable) to High(LTable) do
   begin
      s := s + IntToStr(LTable[i])+', ';
      if (i mod 8) = 7 then
      begin
         list.Add(s);
         s := '';
      end;
   end;
end;



procedure TForm1.CalcAllPearson;
var
   i : Integer;
   s : String;
   hash : Integer;
begin
   FBuckets.Clear;
   for i := 0 to FTextLines.Count-1 do
   begin
      s := FTextLines[i];
      hash := PearsonHash(LTable, s);
      FBuckets.Increment(hash);
   end;
   FBuckets.FinishUpdate;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
   i : Integer;
begin
   for i := 1 to 100 do
      Memo1.Lines.Add(RandomString());

end;


procedure TForm1.DisplayHitsCounters(s: TStrings);
var
   j : Integer;
   sum : Integer;
begin
   s.Clear;
   for j := FBuckets.LowerLimit to FBuckets.upperLimit do
   begin
      sum := FBuckets.GetNumberOfCount(j);
      if sum > 0 then
         s.Add(Format('%d mal %d Treffer', [sum, j]));
   end;
end;


procedure TForm1.DisplayHitsGrafic;
var
   i : Integer;
   rect : TRect;
begin

   rect.Left := 10;
   rect.Top  := Self.Height - 80;
   rect.Right := rect.Left + 256 * 3;
   rect.Bottom := rect.Top + 30;

   Canvas.FillRect(rect);

   for i := 0 to 255 do
   begin
      rect.Left   := 10 + i * 3;
      rect.Top    := Self.Height - 80;
      rect.Right  := rect.Left +2;
      rect.Bottom := rect.Top + FBuckets.Count[i] * 3;

      Canvas.Rectangle(rect);
   end;

end;




procedure TForm1.Optimize;
var
   j : Integer;
   q : double;
begin
   if FSearchDepth = 0 then
      CopyPearsonTable(LTable, oldLTable);
   Inc(FIterations);

   if FIterations < 3000 then
      ShufflePearsonTable(LTable)
   else
   begin
      for j := 1 to 1+Random(4) do
         TicklePearsonTable(LTable);

      //TicklePearsonTable2(LTable, FIterations mod 256);
   end;


   CalcAllPearson;
   q := FBuckets.VariancePos;


   if q >= FOldQuality then
   begin
      Inc(FSearchDepth);

      if FSearchDepth >= FMaxSearchDepth then
      begin
         FSearchDepth := 0;
         CopyPearsonTable(oldLTable, LTable);
      end;
   end
   else
   begin
      FSearchDepth := 0;
      // Besseres Optimum gefunden
      DisplayHitsCounters(MemoBest.Lines);

      MemoBest.Lines.Add(Format('Average = %.2f', [FBuckets.Average]) );
      MemoBest.Lines.Add(Format('Variance = %.2f', [FBuckets.Variance]) );
      MemoBest.Lines.Add('Quality = '+ IntToStr(Round(q)));
      MemoBest.Lines.Add('Iter = '+ IntToStr(FIterations));
      FOldQuality := q;

      Memo3.Clear;
      GetHashTableText(Memo3.Lines);
      DisplayHitsGrafic;
   end;

end;

procedure TForm1.ButtonStartClick(Sender: TObject);
begin
   if not FRunning then
   begin
      FIterations := 0;
      FSearchDepth := 0;
      FOldQuality := 1e20;
      FTextLines.Assign(Memo1.Lines);
      Memo1.Lines.Assign(FTextLines);
      FRunning := True;
      ButtonStart.Caption := 'Stop';
      while FRunning do
      begin
         if (FIterations mod 300) = 0 then
            Application.ProcessMessages;
         Optimize;
      end;
   end
   else
   begin
      FRunning := False;
      ButtonStart.Caption := 'Start';
   end;
end;



procedure TForm1.Save(list: TStrings);
var
   i, hash : Integer;
   s,t : string;
begin
   list.Clear;

   for i := 0 to 255 do
      list.Add('');

   for i := 0 to FTextLines.Count-1 do
   begin
      s := FTextLines[i];
      hash := PearsonHash(LTable, s);
      t := list[hash];
      if t <> '' then
         list[hash] := t+'|'+s
      else
         list[hash] := s;
   end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   Memo4.Clear;
   SavePascalCode(Memo4.Lines);
end;


procedure TForm1.SavePascalCode(list: TStrings);
var
   slist : TStrings;
   i : Integer;
   delim : string;
begin
   list.Add('uses UPearsonHash;');
   list.Add('');
   list.Add('const');
   list.Add('ptable:TPearsonTable = (');
   Self.GetHashTableText(list);
   list.Add(');');
   list.Add('');

   list.Add('tlist : array[0..255] of string = (');
   slist := TStringList.Create;
   Self.Save(slist);

   delim := ',';
   for i:=0 to slist.Count-1 do
   begin
      if i = 255 then
         delim := '';
      list.Add(QuotedStr(slist[i])+ delim+'  // '+IntToStr(i))

   end;

   slist.Free;
   list.Add(');');
   list.Add('');

   list.Add('function PHash(const s:string):Boolean;');
   list.Add('var');
   list.Add('  t:string;');
   list.Add('begin');
   list.Add('  t:= tlist[PearsonHash(ptable, s)];');
   list.Add('  result := (Pos(s,t) > 0)');
   list.Add('end;');
   list.Add('');
end;

procedure TForm1.BtnOpenFileClick(Sender: TObject);
begin
   if OpenDialog1.Execute then
      Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
end;



procedure TForm1.PageControl1Change(Sender: TObject);
begin
   if PageControl1.ActivePageIndex = 2 then
   begin
      Memo4.Clear;
      if FRunning then
         Memo4.Lines.Add('Optimization still in progress')
      else
         SavePascalCode(Memo4.Lines);
   end;
end;

end.


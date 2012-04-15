unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, SieveOfEratosthenes;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    Button1: TButton;
    EditMinZ: TEdit;
    EditMaxZ: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EditMinV: TEdit;
    EditMaxV: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure BerechneAlles(MinZ, MaxZ:integer; MinV, MaxV:double);
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation


{$R *.dfm}


function ggT(A, B: Integer): Cardinal;
var
   Rest: Integer;
begin
   while B <> 0 do
   begin
      Rest := A mod B;
      A := B;
      B := Rest;
   end;
   Result := A;
end;

procedure SortTStrings(Strings:TStrings; Duplicates:TDuplicates);
var
  tmp: TStringList;
begin
  Assert(Assigned(Strings), 'SortTStrings: invalid arg');
  if Strings is TStringList then
  begin
    TStringList(Strings).Duplicates := Duplicates;
    TStringList(Strings).Sort;
  end else
  begin
    tmp := TStringList.Create;
    try
      tmp.Duplicates := Duplicates;
      tmp.Sorted := True;

      // make a sorted copy
      tmp.Assign(Strings);
      // copy back
      Strings.Assign(tmp);
    finally
      tmp.Free;
    end;
  end;
end;

procedure TForm1.BerechneAlles(MinZ, MaxZ:integer; MinV, MaxV:double);
var
  x, y : integer;
  v : double;
  sieb : TSieveOfEratosthenes;
  function IsPrime(value:integer):char;
  begin
    if sieb.IsPrime(value) then
      result := '*'
    else
      result := ' ';
  end;

begin
  sieb := TSieveOfEratosthenes.Create(MaxZ);
  try
  sieb.FindPrimes;

  for x := minZ to maxZ do
  begin
    for y := minZ to maxZ do
    begin
      if ggt(x,y) = 1 then
      begin
        v := x / y;

        if (v >= minv) and (v <= maxV) then
        begin
          Memo1.Lines.add(Format('%02.4f %2d:%2d  %s:%s', [v,x,y, IsPrime(x), IsPrime(y)]));
        end;
      end;

    end;
  end;
  finally
    sieb.free;
  end;
  SortTStrings(memo1.Lines, dupAccept);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  minZ, maxZ : integer;
  minV, maxV : double;
begin
  memo1.Clear;
  minZ := StrToint(EditMinZ.Text);
  maxz := StrToInt(EditMaxZ.Text);
  minV := Strtofloat(EditMinV.Text);
  maxV := Strtofloat(EditMaxV.Text);

  BerechneAlles(minZ, maxZ, minV, maxV);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // richtig vorbelegen, damit es keine Probleme mit dem Dezimalseparator gibt
  EditMinV.Text := FloatToStr(0.0);
  EditMaxV.Text := FloattoStr(100.0);
end;

end.

unit UniqueRandom;

interface

Uses SysUtils;

type
  ENoMoreNumbers = Exception;
  // alzaimar
  TUniqueRandomSequenceGenerator = class
  private
    FCounter: Integer;
    FNumberList: array of Integer;
  public
    constructor Create(aStart, aEnde: Integer);
    procedure BuildSequence(aStart, aEnde: Integer);
    function GetNextNumber: Integer;
    function TotalCount: Integer;
    function RemainingCount: Integer;
  end;

  // sx2008
  TUniqueRandomSequenceGenerator2 = class
  private
    FStart, FEnde : integer;
    FNumberList: array of Integer;
    procedure AddToList(Value:integer);
    function CountNumbersBetween(a,b:integer):integer;
  public
    constructor Create(aStart, aEnde: Integer);
    procedure BuildSequence(aStart, aEnde: Integer);
    function GetNextNumber: Integer;
    function TotalCount: Integer;
    function RemainingCount: Integer;
  end;


implementation

{ TUniqueRandomGenerator }

constructor TUniqueRandomSequenceGenerator.Create(aStart, aEnde: Integer);
begin
  BuildSequence(aStart, aEnde);
end;

procedure TUniqueRandomSequenceGenerator.BuildSequence(aStart, aEnde: Integer);
var
  i, j, tmp: Integer;

begin
  SetLength(FNumberList, aEnde - aStart + 1);
// Zahlenliste erzeugen
  for i := 0 to TotalCount - 1 do
    FNumberList[i] := aStart + i;

// Mischen nach Fisher-Yates
  for i := Low(FNumberList) to High(FNumberList) do begin
    j := i + Random(Length(FNumberList) - i);
    tmp := FNumberList[j];
    FNumberList[j] := FNumberList[i];
    FNumberList[i] := tmp;
  end;
  FCounter := 0;
end;

function TUniqueRandomSequenceGenerator.GetNextNumber: Integer;
begin
//  if FCounter < High(FNumberList) then begin
  if FCounter <= High(FNumberList) then begin
    Result := FNumberList[FCounter];
    Inc(FCounter);
  end
  else raise ENoMoreNumbers.Create('No more numbers');
end;

function TUniqueRandomSequenceGenerator.RemainingCount: Integer;
begin
  Result := TotalCount - FCounter;
end;

function TUniqueRandomSequenceGenerator.TotalCount: Integer;
begin
  Result := Length(FNumberList);
end;

{ TUniqueRandomSequenceGenerator2 }

procedure TUniqueRandomSequenceGenerator2.AddToList(Value: integer);
var
  len : integer;
begin
  len := Length(FNumberList);
  SetLength(FNumberList, len+1);
  FNumberlist[len] := Value;
end;

procedure TUniqueRandomSequenceGenerator2.BuildSequence(aStart, aEnde: Integer);
begin
  FStart := aStart;
  FEnde  := aEnde;
  FNumberlist := nil;
end;

function TUniqueRandomSequenceGenerator2.CountNumbersBetween(a, b: integer): integer;
var
  i : Integer;
begin
  Result := 0;
  for i := 0 to Length(FNumberList) - 1 do
  begin
    if (FNumberlist[i] > a) and (FNumberlist[i] <= b) then
    begin
       Inc(Result);
    end;
  end;
end;

constructor TUniqueRandomSequenceGenerator2.Create(aStart, aEnde: Integer);
begin
   BuildSequence(aStart, aEnde);
end;

function TUniqueRandomSequenceGenerator2.GetNextNumber: Integer;
var
  i, t, s : integer;
  endflag : boolean;
begin
  if RemainingCount = 0 then
    raise ENoMoreNumbers.Create('no more numbers');

  // hole neue Zufallszahl
  Result := FStart + random(RemainingCount);

  // Ablauf:
  // alle Zahlen zwischen Startwert und Zufallszahl zählen
  // um diese Anzahl erhöhen
  // solange wiederholen, bis keine Zahlen mehr übersprungen wurden

  s := FStart - 1;
  repeat
    t := CountNumbersBetween(s, Result);
    s := Result;
    Inc(Result, t);
  until t = 0;

  AddToList(Result);
end;

function TUniqueRandomSequenceGenerator2.RemainingCount: Integer;
begin
  Result := TotalCount - Length(FNumberList);
end;

function TUniqueRandomSequenceGenerator2.TotalCount: Integer;
begin
  result := FEnde - FStart + 1;
end;

end.

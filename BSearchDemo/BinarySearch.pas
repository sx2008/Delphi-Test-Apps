unit BinarySearch;
(*
 * org. Author  : Michael Puff - http://www.michael-puff.de
 * Redesign by  : sx2008
 * Date         : 2008-06-03
 * License      : PUBLIC DOMAIN
 *)

interface

uses Classes;

type

TBSFound = (bsFound {gefunden},
            bsNotFound {nicht gefunden},
            bsLower,
            bsHigher);

// abstrakte Basisklasse für binäre Suche und Sortieren
// muss immer für einen konkreten Datentyp abgeleitet werden
TBSearch = class(TObject)
  private
    FSorted : Boolean;
    procedure QuickSort(L, R: Integer);
  protected
    FLeft  : Integer;   // untere Grenze der Daten (meist 0)
    FRight : Integer;   // obere Grenze der Daten
    // Rückgabewert von KeyCompare()
    // Key < daten[index]  => -1  (negative Zahl)
    // Key = daten[index]  =>  0
    // Key > daten[index]  => +1  (positive Zahl)
    function KeyCompare(index:integer):integer;virtual;abstract;
    function Compare(a, b: integer):integer;virtual;abstract;
    procedure Exchange(a, b: integer);virtual;abstract;

  public
    procedure Sort;
    function Search: Integer; overload;
    function Search(out found:TBSFound): Integer; overload;
    property Sorted : Boolean read FSorted write FSorted;
  end;


//==============================================================================

TIntArray = array of Integer;
TBSearchInteger = class(TBSearch)
private
   FData : TIntArray;
   procedure SetData(const value:TIntArray);
protected
   function KeyCompare(index:integer):integer;override;
   function Compare(a, b: integer):integer;override;
   procedure Exchange(a, b: integer);override;
public
   Key : Integer;  // der Wert nach dem gesucht werden soll
   property Data : TIntArray read FData write SetData;
end;

TBSearchTStrings = class(TBSearch)
private
   FData : TStrings;
protected
   function KeyCompare(index:integer):integer;override;
   function Compare(a, b: integer):integer;override;
   procedure Exchange(a, b: integer);override;
public
   Key : String;  // der Wert nach dem gesucht werden soll
   property Data : TStrings read FData write FData;
end;


implementation

uses SysUtils;

{ TBSearch }

procedure TBSearch.QuickSort(L, R: Integer);
var
  I, J, P: Integer;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while Compare(I, P) < 0 do
        Inc(I);
      while Compare(J, P) > 0 do
        Dec(J);
      if (I <= J) then
      begin
        Exchange(I, J);
        Inc(I);
        Dec(J);
      end;
    until (I > J);
    if (L < J) then
      QuickSort(L, J);
    L := I;
  until (I >= R);
end;


function TBSearch.Search: Integer;
var
  found : TBSFound;
begin
  result := Search(found);
  if found <> bsFound then Result := -1;
end;

function TBSearch.Search(out found: TBSFound): Integer;
var
  left, right, middle, cv : integer;
begin
  if not Sorted then Sort;  // sortieren, falls nötig

  if KeyCompare(FLeft) < 0 then
  begin
    found := bsLower;
    Result := Fleft - 1;
    exit;
  end;
  if KeyCompare(FRight) > 0 then
  begin
    found := bsHigher;
    Result := FRight - 1;
    exit;
  end;

  left := FLeft;
  right := FRight;
  found := bsNotFound;
  Result := -1;

  // Algorithmus Binärsuche
  while (left <= right) do
  begin
    middle := (left + right) div 2;
    cv := KeyCompare(middle);
    if cv < 0 then
      right := middle - 1
    else if cv > 0 then
      left := middle + 1
    else
    begin
      Result := middle;
      Found := bsFound;
      break;
    end;
  end;
end;

procedure TBSearch.Sort;
begin
  QuickSort(FLeft, FRight);
  FSorted := True;
end;


//==============================================================================


procedure TBSearchInteger.SetData(const value:TIntArray);
begin
  FLeft := Low(value);   // untere
  FRight:= High(value);  // und obere Grenze merken
  FData := value;
  Sorted := False;       // die Daten sind unsortiert
end;

function TBSearchInteger.Compare(a, b: integer): integer;
begin
  if FData[a] < FData[b] then Result := -1
  else if FData[a] > FData[b] then Result := 1
  else Result := 0;
end;

procedure TBSearchInteger.Exchange(a, b: integer);
var t: integer;
begin
  t := FData[a];
  FData[a] := FData[b];
  FData[b] := t;
end;

function TBSearchInteger.KeyCompare(index:integer):integer;
begin
  if Key < FData[index] then Result := -1
  else if Key > FData[index] then Result := 1
  else Result := 0;
  // möglich wäre auch: Result := Key - FData[index]
end;





{ TBSearchTStrings }
function TBSearchTStrings.Compare(a, b: integer): integer;
begin
  result := CompareStr(FData[a],FData[b]);
end;

procedure TBSearchTStrings.Exchange(a, b: integer);
begin
   FData.Exchange(a,b);
end;

function TBSearchTStrings.KeyCompare(index: integer): integer;
begin
   result := CompareStr(Key, FData[index]);
end;

end.

unit UMonthBoldStorage;

interface

type
  // Verwaltet für jeden Tag eines Jahres ein Bit
  // ist das Bit gesetzt, dann ist der Tag "fett"
  TYearBoldManager = class(TObject)
  private
     FMonthBoldInfo : array[1..12] of Cardinal;
     class function DayBits(day:Word):Cardinal;
  public
    constructor Create;
    procedure Clear;
    procedure MakeBold(month, day:Word);     // bestimmten Tag markieren
    procedure MakeNormal(month, day:Word);
    procedure Toggle(month, day:Word);

    function GetMonthBoldInfo(month:Integer):Cardinal;
    function GetDayStatus(month, day:Word):Boolean;
  end;



implementation

{ TYearBoldManager }

constructor TYearBoldManager.Create;
begin
   inherited Create;
   Clear;
end;

procedure TYearBoldManager.Clear;
var
   i : Integer;
begin
   for i := low(FMonthBoldInfo) to high(FMonthBoldInfo) do
      FMonthBoldInfo[i] := 0;
end;

class function TYearBoldManager.DayBits(day: Word): Cardinal;
begin
   Result := $00000001 shl (day - 1);
end;

function TYearBoldManager.GetMonthBoldInfo(month: Integer): Cardinal;
begin
   Result := FMonthBoldInfo[month];
end;

procedure TYearBoldManager.MakeBold(month, day: Word);
begin
   FMonthBoldInfo[month] := FMonthBoldInfo[month]
      or DayBits(Day);
end;

procedure TYearBoldManager.MakeNormal(month, day: Word);
begin
   FMonthBoldInfo[month] := FMonthBoldInfo[month]
      and not DayBits(Day);
end;



function TYearBoldManager.GetDayStatus(month, day: Word): Boolean;
begin
   Result := (FMonthBoldInfo[month] and DayBits(day)) <> 0;
end;

procedure TYearBoldManager.Toggle(month, day: Word);
begin
   if GetDayStatus(month, day) then
      MakeNormal(month, day)
   else
      MakeBold(month, day);
end;

end.

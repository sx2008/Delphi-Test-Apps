unit UPageList;

interface


type

TPageRange = record
  a,b:integer;
end;
TPageRangeArray = array of TPageRange;

TPageList = class(TObject)
  private
    FList : TPageRangeArray;
    procedure SetPagesString(const Value: string);
    procedure AddStringEntry(entry:string);
    procedure DelEntry(idx:integer);
    function GetPagesString: string;
public
   procedure Clear;
   procedure AddPage(p:integer);
   procedure AddRange(p,q:integer);
   function IsPageInList(x:integer):Boolean;
   property PagesString:string read GetPagesString write SetPagesString;
end;

implementation

uses SysUtils;

// Hilfsfunktionen für Stringverarbeitung
function StrToken(var S: string; Separator: Char): string;
var
  I: Integer;
begin
  I := Pos(Separator, S);
  if I <> 0 then
  begin
    Result := Copy(S, 1, I - 1);
    Delete(S, 1, I);
  end
  else
  begin
    Result := S;
    S := '';
  end;
end;
function CharPos(const S: string; const C: Char): Integer;
begin
  for Result := 1 to Length(S) do
    if S[Result] = C then
      Exit;
  Result := 0;
end;

function IsInRange(x,a,b:integer):Boolean; register;
begin
  Result := (x>=a) and (x<=b);
end;

{ TPageList }

procedure TPageList.AddPage(p: integer);
begin
  if p >= 0 then
    AddRange(p,p);
end;

procedure TPageList.AddRange(p, q: integer);
var
  i, len : integer;
begin
  if p > q then exit;

  for i := Length(FList) - 1 downto 0 do
  begin
    if (p >= FList[i].a) and (q <= FList[i].b) then
      exit;
    if (p <= FList[i].a) and (q >= FList[i].b) then
    begin
      DelEntry(i);
    end
    else if IsInRange(q, FList[i].a-1, FList[i].b) then
    begin
      q := FList[i].b;
      DelEntry(i);
    end
    else if IsInRange(p, FList[i].a, FList[i].b+1) then
    begin
      p := FList[i].a;
      DelEntry(i);
    end;
  end;
  len := Length(FList);
  SetLength(FList, len+1);
  FList[len].a := p;
  FList[len].b := q;
end;

procedure TPageList.AddStringEntry(entry: string);
var
  a, b : integer;
  s : string;
begin
  if CharPos(entry, '-') = 0 then
  begin
    AddPage(StrToIntDef(Trim(entry), -1));
  end
  else
  begin
    s := Trim(StrToken(entry, '-'));
    if s='' then
      a := 0
    else
      a := StrToIntDef(s, -1);
    if entry = '' then
      b := 9999999
    else
    begin
      s := Trim(StrToken(entry, '-'));
      b := StrToIntDef(s, -1);
    end;
    AddRange(a,b);
  end;
end;

procedure TPageList.Clear;
begin
  SetLength(Flist,0);
end;

procedure TPageList.DelEntry(idx: integer);
begin
  if idx < Length(FList)-1 then
    Move(Flist[idx+1], FList[idx], (Length(FList)-idx)*sizeof(TPageRange));
  SetLength(FList, Length(FList)-1);
end;

function TPageList.GetPagesString: string;
var
  i : integer;
begin
  Result := '';
  for i := 0 to Length(FList) - 1 do
  begin
    if i <> 0 then
      Result := Result +';';
    result := Result + IntToStr(FList[i].a);
    if FList[i].a<>FList[i].b then
      Result := Result + '-'+IntToStr(FList[i].b);
  end;
end;

procedure TPageList.SetPagesString(const Value: string);
var
  tmp, entry : string;
begin
  tmp := Value;
  Clear;
  repeat
    entry := StrToken(tmp, ';');
    AddStringEntry(entry);
  until tmp ='';
end;


function TPageList.IsPageInList(x: integer): Boolean;
var
  i : integer;
begin
  for i := 0 to Length(FList) - 1 do
  begin
    if IsInRange(x, FList[i].a, FList[i].b) then
    begin
      result := True;
      exit;
    end;
  end;
  Result := False;
end;




end.

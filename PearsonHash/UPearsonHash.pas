unit UPearsonHash;

interface

type
   TPearsonTable = array[Byte] of Byte;

function PearsonHash(var T:TPearsonTable; const s:AnsiString):Byte;
procedure InitPearsonTable(var T:TPearsonTable);
procedure ShufflePearsonTable(var T:TPearsonTable);
procedure TicklePearsonTable(var T:TPearsonTable);
procedure TicklePearsonTable2(var T:TPearsonTable; index:Integer);
procedure CopyPearsonTable(var a,b:TPearsonTable);


implementation

uses Windows;


function rotb_r (x, times : byte) : byte; assembler;
asm
  mov   al,x
  mov   cl, times
  ror   al,cl
end;


function rotb_l (x, times : byte) : byte; assembler;
asm
  mov   al,x
  mov   cl,times
  rol   al,cl
end;


function PearsonHash2(var T:TPearsonTable; s:PByte; len:Integer):Byte;
var
   i : Integer;
begin
   Result := len mod 256;
   for i := 0 to len-1 do
   begin
      Result := rotb_r(Result, 3);
      Result := T[Result xor s^];
      Inc(s);
   end;
end;

(*
function PearsonHash(var T:TPearsonTable; const s:AnsiString):Byte;
var
   i : Integer;
begin
   Result := Length(s) mod 256;
   for i := 1 to Length(s) do
   begin
      //Result := rotb_l(Result, 1);
      Result := T[Result xor ord(s[i])];
   end;
end;
*)
function PearsonHash(var T:TPearsonTable; const s:AnsiString):Byte;
begin
   Result := PearsonHash2(T, @s[1], length(s));
end;



procedure InitPearsonTable(var T:TPearsonTable);
var
   i : Integer;
begin
   for i := low(T) to High(T) do
      T[i] := i;
end;

  procedure SwapByte(a,b:PByte);
  var t: Byte;
  begin
     t := a^;
     a^ := b^;
     b^ := t;
  end;

procedure ShufflePearsonTable(var T:TPearsonTable);
var
   i : Integer;
begin
   for i := High(T) downto Low(T)+1 do
   begin
      SwapByte(@T[i], @T[random(i+1)]);
   end
end;

procedure TicklePearsonTable2(var T:TPearsonTable; index:Integer);
var
   i : Integer;
begin
   repeat
      i := random(256);
   until index<>i;
   SwapByte(@T[i], @T[index]);
end;


procedure TicklePearsonTable(var T:TPearsonTable);
var
   i,j : Integer;
begin
   i := random(256);
   repeat
      j := random(256);
   until j<>i;
   SwapByte(@T[i], @T[j]);
end;



procedure CopyPearsonTable(var a,b:TPearsonTable);
begin
   Move(a[0], b[0], sizeof(b));
end;


end.

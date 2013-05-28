unit Well1024;
{
Delphi Implementation of
WELL 1024a Random Number Generator

see:
http://de.wikipedia.org/wiki/Well_Equidistributed_Long-period_Linear
http://en.wikipedia.org/wiki/Well_equidistributed_long-period_linear

}

interface

uses Classes;

(*
orginal Code see: http://www.iro.umontreal.ca/~panneton/well/WELL1024a.c
/* ***************************************************************************** */
/* Copyright:      Francois Panneton and Pierre L'Ecuyer, University of Montreal */
/*                 Makoto Matsumoto, Hiroshima University                        */
/* Notice:         This code can be used freely for personal, academic,          */
/*                 or non-commercial purposes. For commercial purposes,          */
/*                 please contact P. L'Ecuyer at: lecuyer@iro.UMontreal.ca       */
/* ***************************************************************************** */
*)


type
  TWellRng1024 = class(TPersistent)
  private
    state_i: Cardinal;
    STATE : array[0..32-1] of Cardinal;

    function GetState(idx:BYTE):Cardinal;
    procedure SetState(idx:Byte; Value:Cardinal);

  public
    constructor Create;
    procedure Assign(Source: TPersistent);override;
    function Random:Cardinal;
    function RandomFloat:Extended;
    procedure Randomize;
  end;




implementation

const
 W= 32;
 R= 32;
 M1= 3;
 M2=24;
 M3= 10;




function MAT0POS(t:Byte;v:Cardinal):Cardinal;
begin
  Result := v xor (v shr t);
end;

function MAT0NEG(t:Byte;v:Cardinal):Cardinal;
begin
  Result := v xor (v shl t);
end;



{ TWellRng1024 }

constructor TWellRng1024.Create;
begin
   inherited;
   STATE[0] := 1;
end;

procedure TWellRng1024.Assign(Source: TPersistent);
begin
   if Source is TWellRng1024 then
   begin
      state_i := TWellRng1024(Source).state_i;
      Move(TWellRng1024(Source).STATE[0], STATE[0], sizeof(STATE));
   end
   else
      inherited;
end;



function TWellRng1024.GetState(idx: BYTE): Cardinal;
begin
  Result := STATE[(state_i+idx) and $1F];
end;

procedure TWellRng1024.SetState(idx: Byte; Value: Cardinal);
begin
  STATE[(state_i+idx) and $1F] := Value;
end;


function TWellRng1024.Random: Cardinal;
var
  z0, z1, z2 : Cardinal;
begin
  z0    := GetState(31);
  z1    := GetState(0)       xor MAT0POS(8, GetState(M1));
  z2    := MAT0NEG(19, GetState(M2)) xor MAT0NEG(14, GetState(M3));

  SetState(0, z1 xor z2);
  SetState(31, MAT0NEG (11,z0)   xor MAT0NEG(7,z1)    xor MAT0NEG(13,z2)) ;
  state_i := (state_i + 31) and $1f;
  Result := STATE[state_i];
end;



procedure TWellRng1024.Randomize;
var
   i : Integer;
begin
   for i := 0 to 31 do
      STATE[i] := System.Random(MaxInt);
end;

function TWellRng1024.RandomFloat: Extended;
begin
   Result := Random * 2.32830643653869628906e-10;
end;

end.

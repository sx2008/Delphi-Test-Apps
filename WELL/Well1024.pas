unit Well1024;
{
Delphi Implementation of
WELL 1024 Random Number Generator

see:
http://de.wikipedia.org/wiki/Well_Equidistributed_Long-period_Linear
http://en.wikipedia.org/wiki/Well_equidistributed_long-period_linear

}

interface

uses Classes;

(*

#define W 32
#define R 32
#define M1 3
#define M2 24
#define M3 10

#define MAT0POS(t,v) (v^(v>>t))
#define MAT0NEG(t,v) (v^(v<<(-(t))))
#define Identity(v) (v)

#define V0            STATE[state_i                   ]
#define VM1           STATE[(state_i+M1) & 0x0000001fU]
#define VM2           STATE[(state_i+M2) & 0x0000001fU]
#define VM3           STATE[(state_i+M3) & 0x0000001fU]
#define VRm1          STATE[(state_i+31) & 0x0000001fU]
#define newV0         STATE[(state_i+31) & 0x0000001fU]
#define newV1         STATE[state_i                   ]

#define FACT 2.32830643653869628906e-10

static unsigned int state_i = 0;
static unsigned int STATE[R];
static unsigned int z0, z1, z2;

void InitWELLRNG1024a (unsigned int *init){
   int j;
   state_i = 0;
   for (j = 0; j < R; j++)
     STATE[j] = init[j];
}

double WELLRNG1024a (void){
  z0    = VRm1;
  z1    = Identity(V0)       ^ MAT0POS (8, VM1);
  z2    = MAT0NEG (-19, VM2) ^ MAT0NEG(-14,VM3);
  newV1 = z1                 ^ z2;
  newV0 = MAT0NEG (-11,z0)   ^ MAT0NEG(-7,z1)    ^ MAT0NEG(-13,z2) ;
  state_i = (state_i + 31) & 0x0000001fU;
  return ((double) STATE[state_i]  * FACT);
}


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

end.

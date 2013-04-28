unit SieveOfEratosthenes;

interface 

uses 
  Classes;

type
  TSieveOfEratosthenes = class(TPersistent) 
    private 
      fMaxValue: Cardinal; 
      fSieve: TBits; 
      fPrimes: array of Cardinal;
      fPrimesFound : Cardinal;
      function GetPrimes(const i: Cardinal): Cardinal;
      function GetPrimesFound: Cardinal;
      procedure SetMaxValue(AValue: Cardinal);
      function CountPrimes:Cardinal;
      procedure SavePrimesToArray;
    public
      constructor Create(AMaxValue: Cardinal);
      destructor Destroy;override;
      property MaxValue: Cardinal read fMaxValue write SetMaxValue;
      property Primes[const index: Cardinal]: Cardinal read GetPrimes;
      property PrimesFound: Cardinal read GetPrimesFound;
      procedure FindPrimes();
  end; 

implementation 

{ TSieveOfEratosthenes } 

constructor TSieveOfEratosthenes.Create(AMaxValue: Cardinal);
begin
   inherited Create;
   fSieve := TBits.Create;
   MaxValue := AMaxValue;
end;

destructor TSieveOfEratosthenes.Destroy;
begin
   fSieve.Free;
  inherited;
end;


function TSieveOfEratosthenes.CountPrimes: Cardinal;
var
  i : Integer;
begin
  Result := 0;
  for i := 2 to MaxValue do
    if not fSieve.Bits[i] then
      Inc(Result);
end;


procedure TSieveOfEratosthenes.SavePrimesToArray;
var
  i, j : Integer;
begin
  SetLength(fPrimes, fPrimesFound);
  j := 0;

  for i := 2 to MaxValue do begin
    if fSieve.Bits[i] = false then
    begin
      fPrimes[j] := i;
      Inc(j);
    end;
  end;
end;



procedure TSieveOfEratosthenes.FindPrimes;
var i, j: Cardinal;
begin
  fSieve.Size := 0;  // alten Inhalt wegwerfen
  fSieve.Size := MaxValue+1;  // speicher für Sieb reservieren

  // hier wird gesiebt
  i := 2;
  while i*i <= MaxValue do begin
    if fSieve.Bits[i] = false then
    begin
      j := i*i;
      while j <= MaxValue do
      begin
        fSieve.Bits[j] := true;
        Inc(j, i);
      end;
    end;
    i := i + 1;
  end;

  // Zählen der gefundenen Primzahlen
  fPrimesFound := CountPrimes;

   // speichern der Primzahlen
   SavePrimesToArray;
end;

function TSieveOfEratosthenes.GetPrimes(const i: Cardinal): Cardinal;
begin
  Result := fPrimes[i];
end;

function TSieveOfEratosthenes.GetPrimesFound: Cardinal;
begin
  Result := Length(fPrimes);
end;

procedure TSieveOfEratosthenes.SetMaxValue(AValue: Cardinal);
begin
  fMaxValue := AValue;
end;


end.

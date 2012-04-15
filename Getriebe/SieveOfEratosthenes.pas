unit SieveOfEratosthenes;

// siehe: http://www.delphipraxis.net/topic90577_primzahlen+im+intervall+2+n+ermitteln.htm

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
    public
      constructor Create(AMaxValue: Cardinal);
      destructor Destroy;override;
      property MaxValue: Cardinal read fMaxValue write SetMaxValue;
      property Primes[const index: Cardinal]: Cardinal read GetPrimes;
      property PrimesFound: Cardinal read GetPrimesFound;
      procedure FindPrimes();
      function IsPrime(value:cardinal):Boolean;
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
  fPrimesFound := 0;
  for i := 2 to MaxValue do
    if fSieve.Bits[i] = false then
      Inc(fPrimesFound);

   // speichern der Primzahl
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

function TSieveOfEratosthenes.GetPrimes(const i: Cardinal): Cardinal;
begin
  Result := fPrimes[i];
end;

function TSieveOfEratosthenes.GetPrimesFound: Cardinal;
begin
  Result := Length(fPrimes);
end;

function TSieveOfEratosthenes.IsPrime(value: cardinal): Boolean;
begin
  result := not fSieve.Bits[value];
end;

procedure TSieveOfEratosthenes.SetMaxValue(AValue: Cardinal);
begin
  fMaxValue := AValue;
end;

end.

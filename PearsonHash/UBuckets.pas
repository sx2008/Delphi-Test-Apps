unit UBuckets;

interface

type
   // Die Klasse hat eine Anzahl von Zählern (Buckets)
   // die Prozedure Increment erhöht einen best. Zähler
   TBucketCounter = class(TObject)
   private
      FBuckets : array of Integer;
      FTotalSum : Integer;
      FAverage : Double;
      function GetCount(idx: Integer): Integer;

   public
      UpperLimit, LowerLimit : Integer;

      constructor Create(size:Integer=256);

      procedure Clear;
      procedure FinishUpdate;
      function GetNumberOfCount(count:Integer):Integer;
      procedure Increment(index:Integer);


      function Variance:Double;  // Abweichung
      function VariancePos:Double;
      function VarianceWithLimit(limit:double):Double;  // Abweichung

      property Count[idx:Integer]:Integer read GetCount;
      property TotalSum:Integer read FTotalSum;
      property Average:Double read FAverage;  // Durchschnitt

   end;



implementation

{ TBucketCounter }

procedure TBucketCounter.Increment(index: Integer);
begin
   Inc(FBuckets[index]);
end;


procedure TBucketCounter.Clear;
var
   i : Integer;
begin
   for i := low(FBuckets) to High(FBuckets) do
      FBuckets[i] := 0;
end;

constructor TBucketCounter.Create(size: Integer);
begin
   inherited Create;
   SetLength(FBuckets, size);

end;



function TBucketCounter.Variance: Double;
var
   i : Integer;
   diff : Double;
begin
   Result := 0;
   for i := low(FBuckets) to High(FBuckets) do
   begin
      diff := FBuckets[i] - Average;
      Result := Result + diff * diff;
   end;
end;



function TBucketCounter.VariancePos: Double;
var
   i : Integer;
   diff : Double;
begin
   Result := 0;
   for i := low(FBuckets) to High(FBuckets) do
   begin
      diff := FBuckets[i] - Average;
      if diff > 0.0 then
         Result := Result + diff * diff * diff * diff;
   end;
end;


function TBucketCounter.VarianceWithLimit(limit: double): Double;
var
   i : Integer;
   mw, diff : Double;
begin
   mw := Average;
   Result := 0;
   for i := low(FBuckets) to High(FBuckets) do
   begin
      diff := FBuckets[i] - mw;
      if Abs(diff) > limit then
         Result := Result + diff * diff * diff * diff;
   end;
end;



function TBucketCounter.GetNumberOfCount(count: Integer): Integer;
var
   i : Integer;
begin
   Result := 0;
   for i := low(FBuckets) to High(FBuckets) do
   begin
      if FBuckets[i] = count then
         Inc(Result);
   end;
end;

function TBucketCounter.GetCount(idx: Integer): Integer;
begin
   Result := FBuckets[idx];
end;


procedure TBucketCounter.FinishUpdate;
var
   i : Integer;
begin
   FTotalSum := 0;
   UpperLimit := FBuckets[0];
   LowerLimit := FBuckets[0];

   for i := low(FBuckets) to High(FBuckets) do
   begin
      Inc(FTotalSum, FBuckets[i]);
      if FBuckets[i] > UpperLimit then
         UpperLimit := FBuckets[i]
      else if FBuckets[i] < LowerLimit then
         LowerLimit := FBuckets[i]
   end;

   FAverage := TotalSum / length(FBuckets);


end;


end.

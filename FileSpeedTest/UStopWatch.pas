unit UStopWatch;

interface

type
   IStopWatch = interface ['{ACEC2B05-9F77-4F60-A592-F3F51AD05F06}']
      procedure Start;
      procedure Stop;
      procedure Reset;
      procedure ReStart;

      function GetRunning: Boolean;
      procedure SetRunning(const Value: Boolean);

      function MilliSeconds: double;
      function Seconds: double;

      property Running: Boolean read GetRunning write SetRunning;
   end;

function CreateStopWatch(const AutoStart: Boolean = False): IStopWatch;


type
   ITimestamps = interface ['{B3FE48CC-DA94-4C9E-BF0B-F5BFCAE0B557}']
      procedure Start;
      procedure Clear;
      procedure AddTimestamp(const AMsg: string);

      function GetCount: Integer;
      function GetTimestamp(Index: Integer): Single;
      function GetTimestampMessage(Index: Integer): string;
      function GetTimestampMessages: string;

      property Count: Integer read GetCount;
      property Timestamp[Index: Integer]: Single read GetTimestamp;
      property TimestampMessage[Index: Integer]: string read GetTimestampMessage;
      property TimestampMessages: string read GetTimestampMessages;
   end;

function CreateTimestamps: ITimestamps;


implementation

uses Windows, Classes, SysUtils, Dialogs, Forms;

var
  g_QpcFreq: TLargeInteger = 0;

type
   TStopWatchQPC = class(TInterfacedObject, IStopWatch)
      FStart: TLargeInteger;
      FMilliSeconds: Double;
      FRunning: Boolean;
   private
      function CalcMilliSeconds: Double;
      function GetRunning: Boolean;
      procedure SetRunning(const Value: Boolean);
   public
      constructor Create;

      procedure Start;
      procedure Stop;
      procedure Reset;
      procedure ReStart;

      function MilliSeconds: double;
      function Seconds: double;
   end;

function CreateStopWatch(const AutoStart: Boolean): IStopWatch;
begin
   Result := TStopWatchQPC.Create as IStopWatch;

   if AutoStart then
   begin
      Result.Start;
   end;
end;

{ TStopWatchQPC }

constructor TStopWatchQPC.Create;
begin
   inherited;

   Reset;
end;

function TStopWatchQPC.CalcMilliSeconds: Double;
var
   qpc: TLargeInteger;
begin
   QueryPerformanceCounter(qpc);
   Result := ((qpc-FStart) * 1000.0) / g_QpcFreq;
end;

function TStopWatchQPC.MilliSeconds: double;
begin
   Result := FMilliSeconds;

   if FRunning then
   begin
      Result := Result + CalcMilliSeconds;
   end;
end;

function TStopWatchQPC.Seconds: double;
begin
   Result := MilliSeconds / 1000.0;
end;

procedure TStopWatchQPC.Start;
begin
   FRunning := True;
   QueryPerformanceCounter(FStart);
end;

procedure TStopWatchQPC.Stop;
begin
   if FRunning then
   begin
      FMilliSeconds := FMilliSeconds + CalcMilliSeconds;
      FRunning := False;
   end;
end;

function TStopWatchQPC.GetRunning: Boolean;
begin
   Result := FRunning;
end;

procedure TStopWatchQPC.SetRunning(const Value: Boolean);
begin
   if Value <> FRunning then
   begin
      if Value then
         Start
      else
         Stop;
   end;
end;


procedure TStopWatchQPC.Reset;
begin
   FRunning := False;
   FStart := High(TLargeInteger); 
   FMilliSeconds := 0.0;
end;

procedure TStopWatchQPC.ReStart;
begin
   Reset;
   Start;
end;


type
   TTimestamps = class(TInterfacedObject, ITimestamps)
      FTimestampList: TStringList;
      FQpcFreq, FQpcStart: Int64;
   public
      constructor Create;
      destructor Destroy; override;

   protected
      function CalcTimestamp: Single;
   public
      procedure Start;
      procedure Clear;
      procedure AddTimestamp(const AMsg: string);

      function GetCount: Integer;
      function GetTimestamp(Index: Integer): Single;
      function GetTimestampMessage(Index: Integer): string;
      function GetTimestampMessages: string;
   end;

{ TTimestamps }

procedure TTimestamps.AddTimestamp(const AMsg: string);
begin
   FTimestampList.AddObject(AMsg,TObject(CalcTimestamp));
end;

function TTimestamps.CalcTimestamp: Single;
var
   t: Int64;
begin
   QueryPerformanceCounter(t);

   Result := ((t-FQpcStart) * 1000.0) / FQpcFreq;
end;

procedure TTimestamps.Clear;
begin
   FTimestampList.Clear;
   FQpcFreq := 0;
   FQpcStart := 0;
end;

constructor TTimestamps.Create;
begin
   inherited;

   FTimestampList := TStringList.Create;
end;

destructor TTimestamps.Destroy;
begin
   FTimestampList.Free;

   inherited;
end;

function TTimestamps.GetCount: Integer;
begin
   Result := FTimestampList.Count;
end;

function TTimestamps.GetTimestamp(Index: Integer): Single;
begin
   Result := Single(FTimestampList.Objects[Index]);
end;

function TTimestamps.GetTimestampMessage(Index: Integer): string;
begin
   Result := FTimestampList[Index];
end;

function TTimestamps.GetTimestampMessages: string;
var
   i: Integer;
   t,t_last: Double;
begin
   Result := '';

   if GetCount > 0 then
   begin
      Result := '   #      total       last  msg' + #13#10 +
                '----------------------------------------------------------------';
   end;

   for i := 0 to GetCount-1 do
   begin
      t := GetTimeStamp(i);

      if i > 0 then
         t_last := t - GetTimeStamp(i-1)
      else
         t_last := 0;

      Result := Result + #13#10 + Format('[%3d] [%8.2f] [%8.2f] %s',[i,t,t_last,GetTimestampMessage(i)]);
   end;
end;

procedure TTimestamps.Start;
begin
   Clear;

   if QueryPerformanceFrequency(FQpcFreq) = False then
      raise Exception.Create('TTimestamps: QueryPerformanceFrequency failed!!!');
   QueryPerformanceCounter(FQpcStart);
end;

function CreateTimestamps: ITimestamps;
begin
   Result := TTimestamps.Create;
end;



initialization
   QueryPerformanceFrequency(g_QpcFreq);




end.


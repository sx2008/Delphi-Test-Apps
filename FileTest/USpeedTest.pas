unit USpeedTest;

interface

uses Classes;

type
   TMeasureEvent = procedure(const text:string) of Object;

   TFileSpeedTest = class(TObject)
   private
      FStream: THandleStream;
      FBuffer : string;
      FOnMeasureResult: TMeasureEvent;
      FFileSize: Integer;
      procedure ReadFile(count, blocksize: Integer);
      procedure ReadFileAPI(count, blocksize: Integer);
      procedure WriteFile(count, blocksize: Integer);
      procedure WriteFileAPI(count, blocksize: Integer);
      procedure SeekBegin;

      procedure AddMsg(const s:string);
    procedure SetFileSize(const Value: Integer);

   public
      constructor Create(AStream:THandleStream);

      procedure DoSpeedTest(UseAPI, FlushCache:Boolean);
      property OnMeasureResult:TMeasureEvent read FOnMeasureResult write FOnMeasureResult;
      property FileSize:Integer read FFileSize write SetFileSize;

   end;

implementation

uses Windows, SysUtils, UStopWatch;

{ TFileSpeedTest }

constructor TFileSpeedTest.Create(AStream: THandleStream);
begin
   inherited Create;
   FStream := AStream;
   FileSize := $4000000;
end;

procedure TFileSpeedTest.WriteFile(count, blocksize:Integer);
var
   i : Integer;
begin
   for i := 1 to count do
   begin
      FStream.WriteBuffer(Fbuffer[1], blocksize);
   end;
end;

procedure TFileSpeedTest.ReadFile(count, blocksize: Integer);
var
   i : Integer;
begin
   for i := 1 to count do
   begin
      FStream.ReadBuffer(Fbuffer[1], blocksize);
   end;
end;

procedure TFileSpeedTest.WriteFileAPI(count, blocksize: Integer);
var
   i : Integer;
   h : THandle;
   written : Cardinal;
begin
   h := FStream.Handle;

   for i := 1 to count do
   begin
      windows.WriteFile(h, Fbuffer[1], blocksize, written, nil);
   end;
end;

procedure TFileSpeedTest.ReadFileAPI(count, blocksize: Integer);
var
   i : Integer;
   h : THandle;
   readed : Cardinal;
begin
   h := FStream.Handle;

   for i := 1 to count do
   begin
      windows.ReadFile(h, Fbuffer[1], blocksize, readed, nil);
   end;
end;


procedure TFileSpeedTest.DoSpeedTest(UseAPI, FlushCache:Boolean);
var
   timer : IStopWatch;
   blocksize, count : Integer;
   i : Integer;
begin
   Assert(Assigned(FStream));
   SetLength(Fbuffer, 1 shl 18);

   for i := 3 to 18 do
   begin
      blocksize := 1 shl i;
      count := FileSize div blocksize;

      SeekBegin;
      timer := CreateStopWatch(True);

      if useAPI then
         WriteFileAPI(count, blocksize)
      else
         WriteFile(count, blocksize);
      if FlushCache then
         FlushFileBuffers(FStream.Handle);
      timer.Stop;

      AddMsg(Format('write %d blocks à %d bytes: %.1f ms', [count, blocksize, timer.MilliSeconds]));
   end;
   AddMsg('');

   for i := 3 to 18 do
   begin
      blocksize := 1 shl i;
      count := FileSize div blocksize;
      SeekBegin;

      timer := CreateStopWatch(True);

      if useAPI then
         ReadFileAPI(count, blocksize)
      else
         ReadFile(count, blocksize);
      timer.Stop;
      AddMsg(Format('read %d blocks à %d bytes: %.1f ms', [count, blocksize, timer.MilliSeconds]));
   end;
end;

procedure TFileSpeedTest.SeekBegin;
begin
   FStream.Seek(0, soFromBeginning);
end;


procedure TFileSpeedTest.AddMsg(const s: string);
begin
   if Assigned(FOnMeasureResult) then
      FOnMeasureResult(s);
end;

procedure TFileSpeedTest.SetFileSize(const Value: Integer);
begin
  FFileSize := Value;
  FFileSize := (FFileSize shr 18) shl 18;
end;

end.

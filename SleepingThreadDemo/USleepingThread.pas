unit USleepingThread;

interface

uses Classes, syncobjs;

type
  TSleepingThread = class(TThread)
  private
    FEvent : TSimpleEvent;
    FBusy : Boolean;
  protected
    procedure Execute;override;
    procedure DoTerminate;override;

    procedure DoWork;virtual;abstract;
  public
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
    procedure WakeUp;
    property Busy:Boolean read FBusy;
  end;

implementation


{ TSleepingThread }

constructor TSleepingThread.Create(CreateSuspended: Boolean);
begin
   inherited Create(CreateSuspended);
   FEvent := TSimpleEvent.Create;
end;

destructor TSleepingThread.Destroy;
begin
   FEvent.Free;
   inherited;
end;


procedure TSleepingThread.DoTerminate;
begin
   inherited;
   if not FBusy and Terminated then
      WakeUp;
end;

procedure TSleepingThread.Execute;
begin
   while not Terminated do
   begin
      case FEvent.WaitFor(1000) of
         wrSignaled:
         if not Terminated then
         begin
            FEvent.ResetEvent;
            FBusy := True;
            DoWork;
            FBusy := False;
         end;
         wrTimeout: ;

         wrError:
         begin
            ReturnValue := FEvent.LastError;
            Exit;
         end;

         wrAbandoned:
            Exit;
      end;
   end;
end;

procedure TSleepingThread.WakeUp;
begin
   FEvent.SetEvent;
end;



end.

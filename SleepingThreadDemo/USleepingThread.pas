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

    procedure DoWork;virtual;abstract;
  public
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
    procedure WakeUp;
    procedure Terminate;
    property Busy:Boolean read FBusy;
  end;

implementation


{ TSleepingThread }

constructor TSleepingThread.Create(CreateSuspended: Boolean);
begin
   inherited Create(True);
   FEvent := TSimpleEvent.Create;
   if not CreateSuspended then
      Resume;
end;

destructor TSleepingThread.Destroy;
begin
   Terminate;
   FEvent.Free;
   inherited;
end;


procedure TSleepingThread.Execute;
const
   TIME_OUT = 20000;
begin
   while not Terminated do
   begin
      case FEvent.WaitFor(TIME_OUT) of
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

procedure TSleepingThread.Terminate;
begin
   inherited Terminate;
   if not FBusy then
      WakeUp;
end;

procedure TSleepingThread.WakeUp;
begin
   FEvent.SetEvent;
end;



end.

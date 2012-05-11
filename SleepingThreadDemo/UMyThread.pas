unit UMyThread;

interface

uses USleepingThread;

type

  TMyThread = class(TSleepingThread)
  protected
    procedure DoWork;override;
  public
    Counter : Integer;
  end;




implementation

uses Windows;


{ TMyThread }

procedure TMyThread.DoWork;
var
   i : Integer;
begin
   for i := 1 to 10 do
   begin
      Sleep(50);
      Inc(Counter);
   end;
end;

end.

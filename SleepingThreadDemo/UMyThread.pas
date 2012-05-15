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



  TMyThread2 = class(TSleepingThread)
  protected
    procedure DoWork;override;
  public
    InputString: string;
    OutputString: string;
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

{ TMyThread2 }



// sortiert InputString -> OutputString
procedure TMyThread2.DoWork;
var
  iInner, iOuter: Integer;

   procedure SwapChar(var c1, c2:char);
   var
      c: Char;
   begin
      c := c1;
      c1 := c2;
      c2 := c;
   end;
begin
  OutputString := InputString;
  UniqueString(OutputString);
  for iOuter := 2 to Length(OutputString) do
    for iInner := Pred(iOuter) downto 1 do
    begin
      if OutputString[iInner] > OutputString[Succ(iInner)] then
      begin
         SwapChar(OutputString[Succ(iInner)], OutputString[iInner]);
      end else Break;
      Sleep(100);
    end;
end;

end.

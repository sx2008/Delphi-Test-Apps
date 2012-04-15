unit CommUnit;

interface

type

IFeedback = interface(IInterface)
['{0FBE993E-1FC4-4E8A-B014-53A0D82B2DC9}']

  procedure WriteMessage(const msg:string);
  procedure SetProgressMinMax(min,max:Integer);
  procedure SetPosition(position:Integer);
end;


TComm = class(TObject)
private
  procedure Phase1;
  procedure Phase2;
protected
 FFeedback: IFeedback;


public
  constructor Create(feedback: IFeedback);
  procedure DoWork;
end;


implementation

uses SysUtils;

{ TComm }

constructor TComm.Create(feedback: IFeedback);
begin
  inherited Create;
  Ffeedback := feedback;
end;

procedure TComm.DoWork;
var
  i : integer;
begin
  Phase1;
  FFeedback.SetProgressMinMax(0, 99);
  for i := 0 to 99 do
  begin
    Ffeedback.WriteMessage(Format('Durchlauf %d', [i]));
    Ffeedback.SetPosition(i);
    Sleep(20);
  end;
    
end;

procedure TComm.Phase1;
begin
  Ffeedback.WriteMessage('Phase 1...');
end;

procedure TComm.Phase2;
begin

end;

end.

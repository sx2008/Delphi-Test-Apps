unit Unit2;
{
folgendes Demo Programm zeigt, wie man mit einer selbst definierten Windows-Message
eine Funktion automatisch starten kann ohne eine Timer zu verwenden
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Gauges;

const
   WM_AUTOSTART = WM_USER+ 67;   // User defined windows message

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Gauge1: TGauge;
    procedure Panel1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure WMAutostart(var msg:TMessage); message WM_AUTOSTART;
  public
    { Public-Deklarationen }
    procedure DoWork;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}


procedure SimulateMouseclick(control : TWinControl);
var
  Wnd: HWND;
  P: TPoint;
  Rect: TRect;
begin
  Wnd := control.Handle;
  if Wnd <> 0 then
  begin
    Windows.GetClientRect(Wnd, Rect);
    P.X := (Rect.Left + Rect.Right) div 2;
    P.Y := (Rect.Top + Rect.Bottom) div 2;
    PostMessage(Wnd, WM_LBUTTONDOWN, 0, MakeLParam(P.X, P.Y));
    PostMessage(Wnd, WM_LBUTTONUP, 0, MakeLParam(P.X, P.Y));
  end;
end;




procedure TForm1.DoWork;
var
   i : Integer;
begin
   Panel1.Caption := ParamStr(1);

   Gauge1.MaxValue := StrToInt(ParamStr(1));

   for i := Gauge1.MinValue to Gauge1.MaxValue do
   begin
      Gauge1.Progress := i;
      Application.ProcessMessages;
      if Application.Terminated then
         Break;
      Sleep(2);
   end;
end;

procedure TForm1.Panel1Click(Sender: TObject);
begin
   DoWork;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   if ParamCount = 1 then
   begin
      PostMessage(Self.Handle, WM_AUTOSTART, 0, 0);

//      SimulateMouseclick(Panel1);
   end;
end;

procedure TForm1.WMAutostart(var msg: TMessage);
begin
   DoWork;
   msg.Result := 1;
end;





end.

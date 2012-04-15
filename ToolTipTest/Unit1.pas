unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
    FtipHwnd : HWnd;
    FBallHwnd : HWnd;
  public
    { Public-Deklarationen }
    procedure Moving(var Msg: TMessage);message WM_MOVING;
  end;

var
  Form1: TForm1;

implementation

uses ToolTipApi;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  AddToolTip(FtipHwnd, self,1, Rect(250,250,400,400), 'This is Tooltip #2'#13+
  '.  We want a even longer Text');

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FBallHwnd := RegisterBallonWindow(Button2);
  AddBalloonWindowCallBack(FBallHwnd, Button2, 0, 0, 'Test Test', Rect(0,0,300,300));
  SetBalloonTracking(FBallHwnd, Button2, 0, True);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  FtipHwnd := RegisterToolTip(self);
  SetTipTitel(FtipHwnd, 0, 'my first ToolTip');
  AddToolTip(FtipHwnd, self,0, Rect(0,0,200,200), 'That is a tooltip and a relativly long text'+
  '.  We want a even longer Text');
  EnableToolTip(FtipHwnd);
end;

procedure TForm1.Moving(var Msg: TMessage);
var
  r : PRect;
begin
  r := PRect(msg.LParam);
  OffsetRect(r^, random(11)-5, random(11)-5);
end;

end.

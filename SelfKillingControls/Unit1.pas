unit Unit1;

interface

uses
  Windows, Messages, Classes, Graphics, Controls, Forms, StdCtrls;

const
   WM_KILL_CONTROL = WM_USER+ 66;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
    procedure WMKillControl(var msg:TMessage); message WM_KILL_CONTROL;

  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.WMKillControl(var msg: TMessage);
var
   c : TControl;
begin
   c := TControl(msg.LParam);
   if not Assigned(c) then
      Exit;

   c.Free;
   windows.MessageBeep($FFFFFFFF);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
//   Sender.Free;   // würde meistens eine Exception auslösen
   PostMessage(Self.Handle, WM_KILL_CONTROL, 0, Integer(Sender));
end;

procedure TForm1.Button1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (Key=VK_DELETE) and (Shift=[ssCtrl]) then
   begin
   //   Sender.Free;   // würde meistens eine Exception auslösen
      PostMessage(Self.Handle, WM_KILL_CONTROL, 0, Integer(Sender));
   end;
end;

end.

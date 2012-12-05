unit MouseTestForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TFrmMouseTest = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    Edit1: TEdit;
    CboCapture: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure CboCaptureClick(Sender: TObject);
  private
    { Private-Deklarationen }
    FOk : Boolean;
  public
    { Public-Deklarationen }
    procedure AddMsg(const msg:string);

    procedure WndProc(var Message: TMessage); override;
  end;

var
  FrmMouseTest: TFrmMouseTest;

implementation

{$R *.DFM}

Const
   WM_APPCOMMAND = $0319;
   FAPPCOMMAND_MASK = $F000;

{ TForm2 }

procedure TFrmMouseTest.WndProc(var Message: TMessage);
begin
   if FOk then
   begin
      FOk := False;
      case Message.Msg of


         WM_PAINT:  ;

         WM_NCHITTEST:
            AddMsg('NC Hittest');
         WM_NCMOUSEMOVE:
            AddMsg('NC Mousemove');
         WM_MOUSEMOVE:
            AddMsg('Mouse Move');
         WM_LBUTTONDOWN:
            AddMsg('Left Button down');

         WM_SETCURSOR:
            AddMsg(Format('Set Cursor(%d, %d)', [Message.LParamLo, Message.LParamHi]));
         WM_MOUSEACTIVATE:
            AddMsg('Mouse activate');
         WM_MOUSEWHEEL:
            AddMsg('Mouse Wheel');
         WM_PARENTNOTIFY:
            AddMsg('Parent Notify');
         WM_COMMAND:
            AddMsg(Format('Command %d', [Message.LParam]));
         WM_SYSCOMMAND:
            AddMsg(Format('System-Command %d', [Message.LParam]));

         WM_APPCOMMAND:
            AddMsg(Format('App-Command %d', [Message.LParamHi and not FAPPCOMMAND_MASK]));

         WM_KEYDOWN:
            AddMsg('Keydown');
         WM_VSCROLL:
            AddMsg(Format('VScroll %x', [Message.LParam]));

         WM_CONTEXTMENU:
            AddMsg('Context Menu');

         CM_MOUSEWHEEL:
            AddMsg('Custom Mouse Wheel');


      else
         begin
            AddMsg(Format('%d - $%x (Lparam=%x)', [Message.Msg, Message.Msg, Message.LParam]));
         end;

      end;
      FOk := True;
   end;

  inherited;

end;

procedure TFrmMouseTest.FormShow(Sender: TObject);
begin
   FOk := True;
end;

procedure TFrmMouseTest.AddMsg(const msg: string);
begin
   Memo1.Lines.Add(msg);
end;

procedure TFrmMouseTest.CboCaptureClick(Sender: TObject);
begin
   FOk := CboCapture.Checked;
end;

end.

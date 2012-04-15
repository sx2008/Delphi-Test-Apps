unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Contnrs, StdCtrls;

type

  TMyThread = class(TThread)
  private
    FLoopCount : Integer;

  protected
    procedure Execute;override;
  public
    property LoopCount:integer read FLoopCount write FLoopCount;
  end;


  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
    FThreadList : TObjectList;

    procedure NewThread;
    procedure ThreadTerminated(Sender:TObject);
    procedure UpdateUI;

  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  i : integer;
begin
  for i := 1 to 1 do
     NewThread;
    

end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
{
  if FThreadCount > 0 then
  begin
    ShowMessageFmt('Es laufen noch %d Threads - Formular kann nicht geschlossen werden', [FThreadCount]);
    CanClose := False;
  end
  else
    CanClose := True;
}

end;

{ TMyThread }

procedure TMyThread.Execute;
var
  i : integer;
begin
  for i := 0 to FLoopCount do
  begin
    Sleep(100);
    if Terminated then
    begin
      Self.ReturnValue := 42;
      break;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FThreadList := TObjectList.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FThreadList.Free;
end;

procedure TForm1.NewThread;
var
  t : TMyThread;
begin
  t := TMyThread.Create(True);  // suspended erzeugen
  t.OnTerminate := ThreadTerminated;
  t.LoopCount := random(30);
  t.FreeOnTerminate := False;
  FThreadList.Add(t);   // in Liste merken
  t.Resume;  // jetzt darf der Thread losrennen
  UpdateUI;
end;

procedure TForm1.ThreadTerminated(Sender: TObject);
begin
  TThread(sender).
  // das Thread-Object aus der Liste löschen
  // dabei wird es automatisch freigegeben
  if TThread(sender). then

  FThreadlist.Extract(Sender);
  UpdateUI;
end;

procedure TForm1.UpdateUI;
begin
  Edit1.Text := IntToStr(FThreadList.Count);
end;

end.

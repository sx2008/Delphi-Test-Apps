unit UMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UMyThread, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Timer1: TTimer;
    Edit1: TEdit;
    Button2: TButton;
    Button3: TButton;
    Edit2: TEdit;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private-Deklarationen }
    FMyThread : TMyThread;
    FMyThread2 : TMyThread2;
  public
    { Public-Deklarationen }
    
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
   FMyThread := TMyThread.Create(False);
   FMyThread2 := TMyThread2.Create(False);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
   FMyThread2.Free;
   FMyThread.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   FMyThread.WakeUp;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
   Edit1.Text := IntToStr(FMyThread.Counter);
   if FMyThread.Busy then
      Edit1.Color := clRed
   else
      Edit1.Color := clWindow;


   Edit2.Text := FMyThread2.OutputString;
   if FMyThread2.Busy then
      Edit2.Color := clRed
   else
      Edit2.Color := clWindow;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   FMyThread.Terminate;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
   FMyThread2.InputString := 'Hello World!';
   FMyThread2.WakeUp;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
   FMyThread2.Terminate;
end;

end.

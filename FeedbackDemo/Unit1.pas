unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CommUnit, ComCtrls, StdCtrls;

type
  TForm1 = class(TForm, IFeedBack)
    StatusBar1: TStatusBar;
    Button1: TButton;
    ProgressBar1: TProgressBar;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private-Deklarationen }
  protected
    procedure WriteMessage(const msg:string);
    procedure SetProgressMinMax(min,max:Integer);
    procedure SetPosition(position:Integer);

  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses FeedbackFormUnit;

{$R *.dfm}

type
  TNullFeedback = class(TInterfacedObject, IFeedback)
  protected
    procedure WriteMessage(const msg:string);
    procedure SetProgressMinMax(min,max:Integer);
    procedure SetPosition(position:Integer);
  end;
{ TNullFeedback }

procedure TNullFeedback.SetPosition(position: Integer);
begin
end;
procedure TNullFeedback.SetProgressMinMax(min, max: Integer);
begin
end;
procedure TNullFeedback.WriteMessage(const msg: string);
begin
end;


{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  comm : TComm;
begin
  comm := TComm.Create(self as IFeedback);
  try
    comm.DoWork;
  finally
    comm.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  comm : TComm;
  fb : IFeedback;
begin
  fb := TNullFeedback.Create;
  comm := TComm.Create(fb);
  try
    comm.DoWork;
  finally
    comm.Free;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  comm : TComm;
  fbf : TFeedbackForm;
begin
  fbf := TFeedbackForm.Create(nil);
  fbf.Show;
  comm := TComm.Create(fbf);
  try
    comm.DoWork;
  finally
    comm.Free;
    fbf.Free;
  end;
end;

procedure TForm1.SetPosition(position: Integer);
begin
  ProgressBar1.Position := position;
end;

procedure TForm1.SetProgressMinMax(min, max: Integer);
begin
  ProgressBar1.Min := min;
  progressbar1.Max := max;
end;

procedure TForm1.WriteMessage(const msg: string);
begin
  Statusbar1.SimpleText := msg;
end;


end.

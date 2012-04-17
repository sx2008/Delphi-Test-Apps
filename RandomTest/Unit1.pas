unit Unit1;

interface

uses
  Windows, Messages, SysUtils, {Variants,} Classes, Graphics, Controls, Forms,
  Dialogs, UniqueRandom, StdCtrls, ExtCtrls;

type

  // hier wird die zu testende Klasse festgelegt
//  TTestClass = TUniqueRandomSequenceGenerator;
  TTestClass = TUniqueRandomSequenceGenerator2;

  TForm1 = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private-Deklarationen }
    FDUT : TTestClass;
    procedure ZieheZahl;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  memo1.lines.Clear;

  FDUT := TTestClass.Create(StrToInt(edit1.Text), StrToInt(edit2.Text));
  Button2.Enabled := True;
  Button3.Enabled := True;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ZieheZahl;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  while FDUT.RemainingCount > 0 do
    ZieheZahl;
end;

procedure TForm1.ZieheZahl;
var
  number : integer;
begin
  number := FDUT.GetNextNumber;
  memo1.lines.add(IntToStr(number));
end;

end.

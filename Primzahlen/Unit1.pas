unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    Edit1: TEdit;
    BtnStart: TButton;
    Label1: TLabel;
    StatusBar1: TStatusBar;
    procedure BtnStartClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses SieveOfEratosthenes;

{$R *.DFM}

procedure TForm1.BtnStartClick(Sender: TObject);
var
   x : TSieveOfEratosthenes;
   i : Integer;
begin
   StatusBar1.SimpleText := '....';
   x := TSieveOfEratosthenes.Create(StrToInt(Edit1.text));
   x.FindPrimes;
   Memo1.Lines.BeginUpdate;
   Memo1.Clear;
   for i := 0 to x.PrimesFound-1 do
   begin
      Memo1.Lines.Add(IntToStr(x.Primes[i]));
   end;
   Memo1.Lines.EndUpdate;

   StatusBar1.SimpleText := Format('%d Primzahlen gefunden', [x.PrimesFound]);
   x.Free;

end;

end.

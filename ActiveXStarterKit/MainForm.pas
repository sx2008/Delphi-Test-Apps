unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure ZeigeMeldung(const s : string);
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

{ TForm1 }

procedure TForm1.ZeigeMeldung(const s: string);
begin
   Memo1.Lines.Add(TimeToStr(time)+ ' - ' +s);
end;

end.

unit UMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses UPageList;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  dut : TPageList;
  i : integer;
begin
  memo1.Clear;
  dut := TPageList.Create;
  dut.PagesString := Edit1.text;
  Edit2.text := dut.PagesString;
  for i := 0 to 100 do
  begin
    if dut.IsPageInList(i) then
      memo1.lines.add(IntToStr(i));

  end;
  dut.Free;
end;

end.

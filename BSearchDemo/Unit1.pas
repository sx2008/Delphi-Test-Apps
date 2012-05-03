unit Unit1;

interface

uses
  Windows, Messages, SysUtils, {Variants,} Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses BinarySearch;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  data : TIntArray;
  i, index : integer;
  bs : TBSearchInteger;
  found : TBSFound;
begin
  setLength(data, memo1.Lines.Count);
  for i := 0 to memo1.Lines.Count - 1 do
  begin
    data[i] := StrToInt(memo1.lines[i]);
  end;

  bs := TBSearchInteger.Create;
  bs.Data := data;
  bs.Key := StrToInt(edit1.Text);

  index := bs.Search(found);

  case found of
    bsFound:
    begin
      Caption := IntToStr(index);
      Memo1.SelStart := index;
    end;
    bsNotFound:
      Caption := 'nicht gefunden';
    bsLower:
      Caption := 'Key kleiner als gesamte Datenmenge';
    bsHigher:
      Caption := 'Key grösser als gesamte Datenmenge';

  end;

  bs.free;

end;

end.

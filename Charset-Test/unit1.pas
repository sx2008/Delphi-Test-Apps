unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    RadioGroup1: TRadioGroup;
    procedure RadioGroup1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.RadioGroup1Click(Sender: TObject);
var
   f : TFontCharset;
begin
   case RadioGroup1.ItemIndex of
      0:
         f := DEFAULT_CHARSET;
      1:
         f := RUSSIAN_CHARSET;
      2:
         f := GREEK_CHARSET;
   end;
   Edit1.Font.Charset := f;
end;

end.

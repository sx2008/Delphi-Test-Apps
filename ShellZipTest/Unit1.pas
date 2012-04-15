unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses ShellZipTool;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  sz : TShellZip;
begin
  sz := TShellZip.Create;
  try
    sz.Zipfile := ExtractFilePath(ParamStr(0))+'t.zip';
    sz.ZipFolder(ExtractFilePath(ParamStr(0))+'Test');

    sz.Unzip(ExtractFilePath(ParamStr(0))+'out');
  finally
    sz.free;
  end;
end;

end.

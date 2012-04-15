unit Unit1;

interface

uses
  Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;


var
  Form1: TForm1;



implementation

uses PatchExeUnit;

{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
var
  filename : string;
begin
  filename := ExtractFilePath(paramstr(0))+'patched'+ExtractFileName(paramstr(0));
  PatchOwnExeFile(filename, Edit1.Text);
  ShowMessage('file '+filename+ ' created');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.text := GetConfigString;

  if IsExeChecksumValid then
    StatusBar1.SimpleText := 'Checksum ok'
  else
    StatusBar1.SimpleText := 'Bad Checksum';
end;

end.

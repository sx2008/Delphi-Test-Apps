unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Memo1: TMemo;
    Panel1: TPanel;
    RadioGroup1: TRadioGroup;
    Exit1: TMenuItem;
    procedure Open1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure ImportFile(const filename:string);
    procedure ImportFile2(const filename:string);
    procedure AddLine(const line:string);
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;



implementation

{$R *.DFM}




function FileToString(const FileName: string): AnsiString;
var
  fs: TFileStream;
  Len: Integer;
begin
  fs := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    Len := fs.Size;
    SetLength(Result, Len);
    if Len > 0 then
      fs.ReadBuffer(Result[1], Len);
  finally
    fs.Free;
  end;
end;


procedure TForm1.AddLine(const line: string);
begin
   Memo1.Lines.Add(line);
end;

function Char2Pas(c:char):string;
begin
   if (c < ' ') or (c >=#128) or (c='''') then
   begin
      Result := '#'+IntToStr(ord(c));
   end
   else
      Result := c;
end;

function Char2PasQ(c:char):string;
begin
   if (c < ' ') or (c >=#128) or (c='''') then
   begin
      Result := '#'+IntToStr(ord(c));
   end
   else
      Result := ''''+c+'''';
end;





procedure TForm1.ImportFile(const filename: string);
var
   s : string;
   i : Integer;
   line : string;
begin
   s := FileToString(filename);


   Addline('resourcestring');
   line := ChangeFileExt(ExtractFilename(filename), '')+' = ''';
   for i := 1 to length(s) do
   begin
      line := line + Char2Pas(s[i]);
      if Length(line) > 80 then
      begin
         line := line + '''';
         if i < Length(s) then
            line := line + ' +';
         Addline(line);
         line := '''';
      end;
   end;
   if line <> '''' then
      Addline(line + ''';');
end;

procedure TForm1.ImportFile2(const filename: string);
var
   s : string;
   i : Integer;
   line : string;
begin
   s := FileToString(filename);


   Addline('const');
   line := ChangeFileExt(ExtractFilename(filename), '')+':array[0..'+
      IntToStr(length(s)-1)+'] = (';
   for i := 1 to length(s) do
   begin
      if i <> 1 then line := line+ ',';
      line := line + Char2PasQ(s[i]);
      if Length(line) > 80 then
      begin
         Addline(line);
         line := '';
      end;
   end;
   if line <> '''' then
      Addline(line + ');')
   else
      AddLine(');');
end;

procedure TForm1.Open1Click(Sender: TObject);
begin
   if opendialog1.Execute then
   begin
      Memo1.Lines.Clear;

      Memo1.Lines.BeginUpdate;
      try
         if RadioGroup1.ItemIndex = 1 then
            ImportFile2(OpenDialog1.FileName)
         else
            ImportFile(OpenDialog1.FileName);
      finally
         Memo1.Lines.EndUpdate;
      end;
   end;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
   close;
end;

end.

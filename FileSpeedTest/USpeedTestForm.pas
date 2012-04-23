unit USpeedTestForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    EdtFilename: TEdit;
    Memo1: TMemo;
    ChkUseFlushCache: TCheckBox;
    ChkUseAPI: TCheckBox;
    Button1: TButton;
    CboFileSize: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
    FStream : TFileStream;
    procedure MeasureResultHandler(const s: string);
    function GetFilesize:Integer;
    procedure DoSpeedtest;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses USpeedTest;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
   Button1.Enabled := False;

   Memo1.Lines.Add('Test start '+DateTimeToStr(now));
   DoSpeedtest;
   Memo1.Lines.Add('End        '+DateTimeToStr(now));
   Button1.Enabled := True;
end;


function TForm1.GetFilesize: Integer;
begin
   case CboFileSize.ItemIndex of
      0: Result := 8 shl 20;
      1: Result := 16 shl 20;
      2: Result := 32 shl 20;
      3: Result := 64 shl 20;
      4: Result := 128 shl 20;
   else
      Result := 0;
   end;
end;

procedure TForm1.MeasureResultHandler(const s: string);
begin
   Memo1.Lines.Add(s);
   Application.ProcessMessages;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
   CboFileSize.ItemIndex := 0;
end;

procedure TForm1.DoSpeedtest;
var
   st : TFileSpeedTest;
   fn : string;
begin
   fn := EdtFilename.Text;
   if FileExists(fn) then
      if not (MessageDlg('Overwrite existing file <'+fn+'> ?', mtWarning, [mbOK, mbCancel], 0) = mrOk) then
         Exit;

   FStream := TFileStream.Create(fn, fmCreate);
   st := TFileSpeedTest.Create(FStream);
   try
      st.OnMeasureResult := MeasureResultHandler;
      st.FileSize := GetFilesize;
      st.DoSpeedTest(ChkUseAPI.Checked, ChkUseFlushCache.Checked);
   finally
      st.Free;
      FStream.Free;
      DeleteFile(fn);
   end;
end;

end.

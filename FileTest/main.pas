unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, ToolEdit;

type
  TForm1 = class(TForm)
    DirectoryEdit1: TDirectoryEdit;
    Label1: TLabel;
    RgpOpenMode: TRadioGroup;
    RgpShareMode: TRadioGroup;
    Button1: TButton;
    Memo1: TMemo;
    BtnRead: TButton;
    BtnWrite: TButton;
    BtnSpeedTest: TButton;
    ChkFlushCache: TCheckBox;
    ChkUseAPI: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure BtnReadClick(Sender: TObject);
    procedure BtnWriteClick(Sender: TObject);
    procedure BtnSpeedTestClick(Sender: TObject);
  private
    { Private-Deklarationen }

    FStream : TFileStream;

    function GetFileStreamMode:Word;

    procedure MeasureResultHandler(const s:string);

  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses UStopWatch, USpeedTest;

{$R *.DFM}

{ TForm1 }

function TForm1.GetFileStreamMode: Word;
var
   sharemode:Word;
begin
   case RgpOpenMode.ItemIndex of
      0: Result := fmCreate;
      1: Result := fmOpenRead;
      2: Result := fmOpenWrite;
      3: Result := fmOpenReadWrite;
   else
      raise Exception.Create('Open Mode fehlt');
   end;

   case RgpShareMode.ItemIndex of
      0: sharemode := fmShareCompat;
      1: sharemode := fmShareExclusive;
      2: sharemode := fmShareDenyWrite;
      3: sharemode := fmShareDenyRead;
      4: sharemode := fmShareDenyNone;
   else
      raise Exception.Create('Share Mode fehlt');
   end;

   Result := Result or sharemode;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
   capt:string;
begin

   if Assigned(FStream) then
   begin
      FStream.Free;
      FStream := nil;
      capt := 'Open';
      DirectoryEdit1.Enabled := True;
      BtnSpeedTest.Enabled := False;
   end
   else
   begin
//      FStream := TFileStream.Create(DirectoryEdit1.Text+'test.dat',GetFileStreamMode);
      FStream := TFileStream.Create(DirectoryEdit1.Text,GetFileStreamMode);
      capt := 'Close';
      DirectoryEdit1.Enabled := False;
      BtnSpeedTest.Enabled := True;
   end;

   (Sender as TButton).Caption := capt;
end;

procedure TForm1.BtnReadClick(Sender: TObject);
begin
   if not Assigned(FStream) then
      Exit;
   FStream.Position := 0;
   Memo1.Lines.LoadFromStream(FStream);
end;

procedure TForm1.BtnWriteClick(Sender: TObject);
begin
   if not Assigned(FStream) then
      Exit;
   FStream.Position := 0;
   Memo1.Lines.SaveToStream(FStream);
end;

procedure TForm1.BtnSpeedTestClick(Sender: TObject);
var
   st : TFileSpeedTest;
begin
   st := TFileSpeedTest.Create(FStream);
   try
      st.OnMeasureResult := Self.MeasureResultHandler;
//      st.FileSize := $200000;
      st.DoSpeedTest(ChkUseAPI.Checked, ChkFlushCache.Checked);
   finally
      st.Free;
   end;
end;




procedure TForm1.MeasureResultHandler(const s: string);
begin
   Memo1.Lines.Add(s);
   Application.ProcessMessages;
end;

end.

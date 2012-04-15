unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, StdCtrls, Dialogs,
  ExtCtrls;

type
  TForm1 = class(TForm)
    btnClose: TButton;
    GroupBox1: TGroupBox;
    Button9: TButton;
    Button5: TButton;
    Button2: TButton;
    Button12: TButton;
    Button1: TButton;
    Button13: TButton;
    Button4: TButton;
    Button3: TButton;
    Button7: TButton;
    Button8: TButton;
    Button11: TButton;
    Button10: TButton;
    GroupBox2: TGroupBox;
    Button6: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    procedure NumBtnClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  MMSystem;

const
  t = 150;  // Zeit/Dauer
  v =  80;  // Lautstärke

type
  TVolumeLevel = 0..127;

function AttackRelease(x,total:integer):double;
var
  margin : integer;
begin
  margin := total div 10;
  if x < margin then
    result := x / margin
  else if x > total - margin then
    result := total-x / margin
  else
    result := 1.0;
end;

procedure MakeDTMFSound(Freq: Char; Duration{mSec}: Integer; Volume: TVolumeLevel);
  {writes tone to memory and plays it}
var
  WaveFormatEx: TWaveFormatEx;
  MS: TMemoryStream;
  i, TempInt, DataCount, RiffCount: integer;
  SoundValue: Word;
  w1,w2: double; // omega ( 2 * pi * frequency)
const
  Mono: Word = $0001;
  SampleRate: Integer = 22050; // 8000, 11025, 22050, or 44100
  RiffId: string = 'RIFF';
  WaveId: string = 'WAVE';
  FmtId: string = 'fmt ';
  DataId: string = 'data';
begin
  with WaveFormatEx do
  begin
    wFormatTag := WAVE_FORMAT_PCM;
    nChannels := Mono;
    nSamplesPerSec := SampleRate;
    wBitsPerSample := $0010;
    nBlockAlign := (nChannels * wBitsPerSample) div 8;
    nAvgBytesPerSec := nSamplesPerSec * nBlockAlign;
    cbSize := 0;
  end;
  MS := TMemoryStream.Create;
  with MS do
  begin
    {Calculate length of sound data and of file data}
    DataCount := (Duration * SampleRate) div 1000; // sound data
    RiffCount := Length(WaveId) + Length(FmtId) + SizeOf(DWORD) +
      SizeOf(TWaveFormatEx) + Length(DataId) + SizeOf(DWORD) + DataCount; // file data
    {write out the wave header}
    Write(RiffId[1], 4); // 'RIFF'
    Write(RiffCount, SizeOf(DWORD)); // file data size
    Write(WaveId[1], Length(WaveId)); // 'WAVE'
    Write(FmtId[1], Length(FmtId)); // 'fmt '
    TempInt := SizeOf(TWaveFormatEx);
    Write(TempInt, SizeOf(DWORD));    // TWaveFormat data size
    Write(WaveFormatEx, SizeOf(TWaveFormatEx)); // WaveFormatEx record
    Write(DataId[1], Length(DataId));  // 'data'
    Write(DataCount, SizeOf(DWORD));  // sound data size

    case Freq of
     '#': begin w1 := 5912; w2 := 9280; end;
     '*': begin w1 := 5912; w2 := 7596; end;
     '0': begin w1 := 5912; w2 := 8394; end;
     '1': begin w1 := 4379; w2 := 7596; end;
     '2': begin w1 := 4379; w2 := 8394; end;
     '3': begin w1 := 4379; w2 := 9280; end;
     '4': begin w1 := 4838; w2 := 7596; end;
     '5': begin w1 := 4838; w2 := 8394; end;
     '6': begin w1 := 4838; w2 := 9280; end;
     '7': begin w1 := 5353; w2 := 7596; end;
     '8': begin w1 := 5353; w2 := 8394; end;
     '9': begin w1 := 5353; w2 := 9280; end;

     'A': begin w1 := 4379; w2 := 10260; end;
     'B': begin w1 := 4838; w2 := 10260; end;
     'C': begin w1 := 5353; w2 := 10260; end;
     'D': begin w1 := 5912; w2 := 10260; end;
     else begin w1 :=  100; w2 :=   100; end; // nix
    end;

    TempInt := volume *256;

    {calculate and write out the tone signal} // now the data values
    for i := 0 to DataCount - 1 do
    begin
      SoundValue := 0 + trunc( TempInt * AttackRelease(i,DataCount-1)*
      (((sin(i * w1 / SampleRate)/2))+
                                           ((cos(i * w2 / SampleRate)/2))));

      Write(SoundValue, SizeOf(SoundValue));
    end;

    SoundValue := SoundValue div 2;
    write(SoundValue, SizeOf(SoundValue));
    SoundValue := SoundValue div 2;
    write(SoundValue, SizeOf(SoundValue));


    {now play the sound}
    sndPlaySound(MS.Memory, SND_MEMORY or SND_SYNC);
    MS.SaveToFile('test.wav');
    MS.Free;
  end;
end;

procedure TForm1.NumBtnClick(Sender: TObject);
begin
  MakeDTMFSound(TButton(Sender).Caption[1], t, 80);
end;

procedure TForm1.btnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TForm1.Button17Click(Sender: TObject);
begin
  MakeDTMFSound('0', t, 80);
  MakeDTMFSound('1', t, 80);
  MakeDTMFSound('1', t, 80);
  MakeDTMFSound('9', t, 80);
  MakeDTMFSound('1', t, 80);
end;

procedure TForm1.Button18Click(Sender: TObject);
begin
  MakeDTMFSound('1', 100, 80);
  MakeDTMFSound('2', 100, 80);
  MakeDTMFSound('3', 100, 80);
  MakeDTMFSound('6', 100, 80);
  MakeDTMFSound('9', 250, 80);
  MakeDTMFSound('9', 250, 80);
  MakeDTMFSound('B', 100, 80);
  MakeDTMFSound('B', 100, 80);
  MakeDTMFSound('B', 100, 80);
  MakeDTMFSound('B', 100, 80);
  MakeDTMFSound('9', 250, 80);
  MakeDTMFSound('B', 100, 80);
  MakeDTMFSound('B', 100, 80);
  MakeDTMFSound('B', 100, 80);
  MakeDTMFSound('B', 100, 80);
  MakeDTMFSound('9', 250, 80);
  MakeDTMFSound('5', 100, 80);
  MakeDTMFSound('5', 100, 80);
  MakeDTMFSound('5', 100, 80);
  MakeDTMFSound('5', 100, 80);
  MakeDTMFSound('1', 250, 80);
  MakeDTMFSound('1', 250, 80);
  MakeDTMFSound('6', 100, 80);
  MakeDTMFSound('6', 100, 80);
  MakeDTMFSound('6', 100, 80);
  MakeDTMFSound('6', 100, 80);
  MakeDTMFSound('1', 250, 80);
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
  MakeDTMFSound(key, 100, 80);
end;

end.
 
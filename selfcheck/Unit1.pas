unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls;

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

{$R *.DFM}

uses MD5windows;



Function SelfCheck: Boolean; 
  Const SelfCheckSigLen = 25; 
    SelfCheckData: packed Array[0..44] of AnsiChar 
      = 'S'#0'e'#1'l'#2'f'#3'C'#4'h'#5'e'#5'c'#4'k'#3'D'#2'a'#1't'#0'a' 
      + '>>'#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0'<<';

  Var FileName: WideString; 
    H, Hm: THandle; 
    FileSize, i, i2: Integer; 
    P: PChar; 
    MD5: MD5_CTX; 
    B: Boolean; 
    W: Cardinal; 

  Begin 
    Result := False; 
    SetLength(FileName, MAX_PATH); 
    SetLength(FileName, GetModuleFileNameW(0, PWideChar(FileName), MAX_PATH)); 
    H := CreateFileW(PWideChar(FileName), GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE, 
      nil, OPEN_EXISTING, FILE_FLAG_SEQUENTIAL_SCAN, 0); 
    FileSize := GetFileSize(H, nil); 
    Hm := CreateFileMapping(H, nil, PAGE_READONLY, 0, 0, nil); 
    P  := MapViewOfFile(Hm, FILE_MAP_READ, 0, 0, 0); 
    CloseHandle(H); 
    Try 
      If P = nil Then Exit; 
      For i := 0 to FileSize - Length(SelfCheckData) do 
        If (P + i)^ = SelfCheckData[0] Then Begin 
          B := True; 
          For i2 := 1 to SelfCheckSigLen + 1 do
            If (P + i + i2)^ <> SelfCheckData[i2] Then Begin 
              B := False; 
              Break; 
            End; 
          For i2 := SelfCheckSigLen + 2 + SizeOf(MD5.digest) to SelfCheckSigLen + 3 + SizeOf(MD5.digest) do 
            If (P + i + i2)^ <> SelfCheckData[i2] Then B := False; 
          If B Then Begin
            MD5Init(MD5);
            MD5Update(MD5, P, i); 
            MD5Update(MD5, P + i + Length(SelfCheckData), FileSize - i - Length(SelfCheckData)); 
            MD5Final(MD5); 
            Result := True;
            For i2 := 0 to High(MD5.digest) do
              If PByte(P + i + SelfCheckSigLen + 2 + i2)^ <> 0 Then Begin
                Result := False;
                Break;
              End;
            If Result Then Begin
              DeleteFileW(PWideChar(FileName + '.old')); 
              MoveFileW(PWideChar(FileName), PWideChar(FileName + '.old')); 
              CopyFileW(PWideChar(FileName + '.old'), PWideChar(FileName), False); 
              H := CreateFileW(PWideChar(FileName), GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, 
                nil, OPEN_EXISTING, FILE_FLAG_RANDOM_ACCESS, 0); 
              If Integer(SetFilePointer(H, i + SelfCheckSigLen + 2, nil, FILE_BEGIN)) = i + SelfCheckSigLen + 2 Then
                WriteFile(H, MD5.digest[0], SizeOf(MD5.digest), W, nil);
              CloseHandle(H);
              //ShellExecuteW(0, 'open', PWideChar(FileName), GetCommandLineW, nil, SW_SHOW);
              //Halt; 
              Exit; 
            End; 
            Result := True; 
            For i2 := 0 to High(MD5.digest) do 
              If PByte(P + i + SelfCheckSigLen + 2 + i2)^ <> MD5.digest[i2] Then Begin 
                Result := False; 
                Break; 
              End; 
            Exit; 
          End; 
        End; 
    Finally 
      UnmapViewOfFile(P); 
      CloseHandle(Hm); 
    End; 
  End;







procedure TForm1.Button1Click(Sender: TObject);
begin
   if not SelfCheck then
      ShowMessage('selfcheck failed'); 
end;

end.

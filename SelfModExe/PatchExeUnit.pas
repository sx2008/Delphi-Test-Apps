unit PatchExeUnit;
{
Freeware downloaded from delphipraxis.net
Author: sx2008
Date: 2010-01-05
}


interface

type
  TExeData = record
    MagicWord : array[0..11] of Ansichar;
    Checksum : Cardinal;
    BrandingDate : TDateTime;
    Data : array[0..19] of Ansichar;
  end;
  PExeData = ^TExeData;

function GetConfigString:Ansistring;
function IsExeChecksumValid:boolean;

procedure PatchFile(const sourcefilename, destfilename:string; const newconfigstr:Ansistring);
procedure PatchOwnExefile(const filename, newconfigstr:ansistring);


implementation

uses SysUtils, Classes;


var
  globalConfigData:Ansistring = '@magic#word@'+
  #0#0#0#0+ // Checksum
  #0#0#0#0#0#0#0+ // BrandingDate
  #0#0#0#0#0#0+
  #0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0+
  #0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0;

  (*
  globalConfigData : TExeData = (MagicWord:'@magic#word@');
  *)

function FileToString(const FileName: AnsiString): AnsiString;
var
  FS: TFileStream;
  Len: Integer;
begin
  FS := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    Len := FS.Size;
    SetLength(Result, Len);
    if Len > 0 then
    FS.ReadBuffer(Result[1], Len);
  finally
    FS.Free;
  end;
end;

procedure StringToFile(const FileName: AnsiString; const Contents: AnsiString);
var
  FS: TFileStream;
  Len: Integer;
begin
  FS := TFileStream.Create(FileName, fmCreate);
  try
    Len := Length(Contents);
    if Len > 0 then
    FS.WriteBuffer(Contents[1], Len);
  finally
    FS.Free;
  end;
end;


function GetExeRecordPtr:PExeData;
begin
  Result := PExeData(@globalConfigData[1]);
end;


function GetConfigString:Ansistring;
begin
  result := GetExeRecordPtr.Data;
end;


function CalcXorSum(const s:Ansistring):Cardinal;
var
  i : integer;
  x : PCardinal;
begin
  result := 0;
  x := PCardinal(PChar(s));
  for i := 0 to Length(s) div sizeof(Cardinal) do
  begin
    result := result xor x^;
    Inc(x);
  end;
end;

function IsExeChecksumValid:boolean;
var
  exedata : AnsiString;
begin
  exedata := FileToString(ParamStr(0));    // Exe-Datei als String laden
  result := CalcXorSum(exedata) = 0;
end;


function GetMagicWord:AnsiString;
begin
  Result := GetExeRecordPtr.MagicWord;
end;

procedure PatchFile(const sourcefilename, destfilename:string; const newconfigstr:Ansistring);
var
  exedata, magicword : Ansistring;
  p : integer;
  x : PExeData;
begin
  // verhindern, dass die neuen Konfigdaten zu lang werden
  if Length(newconfigstr) > sizeof(x.Data) then
    raise Exception.Create('Config String too long');
  magicword := GetMagicWord;

  exedata := FileToString(sourcefilename);    // Exe-Datei als String laden
  p := Pos(magicword, exedata);   // Magisches Wort suchen
  if p = 0 then
    raise Exception.Create('Magic Word not found');

  x := PExeData(@exedata[p]);


  // Configdaten überschreiben
  Move(newconfigstr[1], x.Data[0], length(newconfigstr));
  x.BrandingDate := now;
  x.Checksum := CalcXorSum(exedata);

  // modifizierte EXE speichern
  StringToFile(destfilename, exedata);
end;

procedure PatchOwnExeFile(const filename, newconfigstr:ansistring);
var
  sourcefilename : string;
begin
  sourcefilename := ParamStr(0);
  Assert(sourcefilename <> filename);
  PatchFile(sourcefilename, filename, newconfigstr);
end;


end.

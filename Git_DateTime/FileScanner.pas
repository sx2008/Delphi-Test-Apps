unit FileScanner;

{
für Delphi-Praxis by shmia


}


interface

uses Windows, SysUtils;

type

// Info über einzelne Datei oder Verzeichnis
TFileInformation = record
  Name : string;
  Path : string;
  IsDir : boolean;
  ArchiveFlag, ReadOnlyFlag, HiddenFlag, SystemFlag : boolean;
//  Owner : TOwner;    // TODO
  Size : Int64;
  Depth : Integer;  // Tiefe: 0=Startverz, 1= erstes Unterverz.
  Created,LastWrite, LastAccess : TDateTime;
end;

TFileFindEvent = procedure(Sender:TObject; const FileInformation:TFileInformation) of object;


// Klasse um Verzeichnisse aufzulisten
//
TFileScanner = class(Tobject)
private
  FOnFound: TFileFindEvent;
  FRecursive: Boolean;
  FStopped  : Boolean;
  FStopDir  : Boolean;
  FStartDepth : Integer;
  procedure DoFound(const FileInformation:TFileInformation);virtual;

  class procedure CopyFileInfo(const SR : TSearchRec; var FI : TFileInformation);

  procedure ScanDirInternal(const Directory:string; depth:Integer);
  procedure ScanDirInternal2(const Directory:string; depth:Integer);

public
  procedure ScanDir(const Directory:string; DirsAtTheEnd:Boolean);  // Verzeichnis scannen

  procedure Stop;  // Scanvorgang anhalten
  procedure StopDirectory; // nur Scanvorgang im aktuellen Verzeichnis unterbrechen

  property Recursive:Boolean read FRecursive write FRecursive;
  property OnFound:TFileFindEvent read FOnFound write FOnFound;
  property Stopped:Boolean read FStopped;
end;



implementation

uses Classes;


const
  FileTimeBase      = -109205.0;
  FileTimeStep: Extended = 24.0 * 60.0 * 60.0 * 1000.0 * 1000.0 * 10.0; // 100 nSek per Day


function FileTimeToDateTime(const FileTime: TFileTime): TDateTime;
begin
  Result := Int64(FileTime) / FileTimeStep;
  Result := Result + FileTimeBase;
end;


function FileTimeToLocalDateTime(const FileTime: TFileTime): TDateTime;
var
  LocalFileTime: TFileTime;
begin
  if FileTimeToLocalFileTime(FileTime, LocalFileTime) then
     Result := FileTimeToDateTime(LocalFileTime)
  { TODO : daylight saving time }
  else
    Result := 0.0;
end;



function FileTimeToSystemDateTime(const FileTime: TFileTime): TDateTime;
begin
   Result := FileTimeToDateTime(FileTime)
end;




{ TFileScanner }

procedure TFileScanner.DoFound(const FileInformation: TFileInformation);
begin
   if Assigned(onFound) then
      OnFound(Self, FileInformation)
   else
      Stop; // ohne Eventhandler macht es keinen Sinn
end;

procedure TFileScanner.ScanDir(const Directory: string; DirsAtTheEnd:Boolean);
begin
   if Recursive then
      FStartDepth := 255
   else
      FStartDepth := 0;
   FStopped := False;
   if DirsAtTheEnd then
      ScanDirInternal2(IncludeTrailingBackslash(Directory), FStartDepth)
   else
      ScanDirInternal(IncludeTrailingBackslash(Directory), FStartDepth);
end;

class procedure TFileScanner.CopyFileInfo(const SR: TSearchRec; var FI: TFileInformation);
begin
   FI.Name := SR.Name;
   FI.Size := SR.Size;
   FI.IsDir := False;

   FI.Created := FileTimeToSystemDateTime(SR.FindData.ftCreationTime);
   FI.LastWrite := FileTimeToSystemDateTime(SR.FindData.ftLastWriteTime);
   FI.LastAccess := FileTimeToSystemDateTime(SR.FindData.ftLastAccessTime);
{
   FI.Created := FileTimeToLocalDateTime(SR.FindData.ftCreationTime);
   FI.LastWrite := FileTimeToLocalDateTime(SR.FindData.ftLastWriteTime);
   FI.LastAccess := FileTimeToLocalDateTime(SR.FindData.ftLastAccessTime);
}
   FI.ReadOnlyFlag := (SR.FindData.dwFileAttributes and faReadOnly) <> 0;
   FI.HiddenFlag   := (SR.FindData.dwFileAttributes and faHidden) <> 0;
   FI.SystemFlag   := (SR.FindData.dwFileAttributes and faSysFile) <> 0;
   FI.ArchiveFlag  := (SR.FindData.dwFileAttributes and faArchive) <> 0;

   (*
   TODO:
   Size mit 64-Bit Dateigrösse füllen
   *)
end;



procedure TFileScanner.ScanDirInternal(const Directory: string; depth:Integer);
var
   SR   : TSearchRec;
   FI : TFileInformation;
begin
   FStopDir := False;
   FI.Path := Directory;
   FI.Depth := FStartDepth-depth;
   FI.IsDir := True;

   if FindFirst(Directory+'*.*',faAnyFile,SR) = 0 then
   begin
      try
      DoFound(FI);
       if FStopDir then
         Exit;
       repeat
         if (SR.Attr and faDirectory) = faDirectory then
         begin
           if (depth > 0) and (SR.Name <> '.') and (SR.Name <> '..') then
             ScanDirInternal(IncludeTrailingBackSlash(Directory+SR.Name), depth-1);
         end
         else
         begin
            CopyFileInfo(SR, FI);
            DoFound(FI);
         end;
       until FStopped or (FindNext(SR) <> 0);
     finally
       FindClose(SR);
     end;
   end;
end;


procedure TFileScanner.ScanDirInternal2(const Directory: string; depth: Integer);
var
   SR   : TSearchRec;
   FI : TFileInformation;
   dlist : TStringList;
begin
   dlist := TStringList.Create;

   FStopDir := False;
   FI.Path := Directory;
   FI.Depth := FStartDepth-depth;
   FI.IsDir := True;

   if FindFirst(Directory+'*.*',faAnyFile,SR) = 0 then
   begin
      try
      DoFound(FI);
       if FStopDir then
         Exit;
       repeat
         if (SR.Attr and faDirectory) = faDirectory then
         begin
           if (depth > 0) and (SR.Name <> '.') and (SR.Name <> '..') then
             dlist.Add(IncludeTrailingBackSlash(Directory+SR.Name));
         end
         else
         begin
            CopyFileInfo(SR, FI);
            DoFound(FI);
         end;
       until FStopped or (FindNext(SR) <> 0);

     while dlist.Count > 0 do
     begin
        ScanDirInternal2(dlist[0], depth-1);
        dlist.Delete(0);
     end;

     finally
       FindClose(SR);
       dlist.Free;
     end;
   end;
end;



procedure TFileScanner.Stop;
begin
   FStopped := True;
end;



procedure TFileScanner.StopDirectory;
begin
   FStopDir := True;
end;

end.

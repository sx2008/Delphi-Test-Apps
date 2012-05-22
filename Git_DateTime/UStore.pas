unit UStore;

interface

uses Classes, FileScanner, UGitIgnore;

type
   TFileInfoSaver = class(TObject)
   private
      FBasePath : string;
      FScanner : TFileScanner;
      FIgnoreList : TGitIgnore;
      FList : TStrings;
      FTzBias : Integer;
      procedure FoundHandler(Sender:TObject; const FileInformation:TFileInformation);

   public
      DestFile : string;

      constructor Create(ignorelist:TGitIgnore);
      destructor Destroy;override;

      procedure ScanDir(const dir:string);

   end;


implementation

uses Windows, SysUtils, ISO8601;




{ TFileInfoSaver }

constructor TFileInfoSaver.Create(ignorelist:TGitIgnore);
var
   tzi : TTimeZoneInformation;
begin
   inherited Create;
   FIgnoreList := ignorelist;

   FScanner := TFileScanner.Create;
   FScanner.OnFound := FoundHandler;
   FScanner.Recursive := True;
   FList := TStringlist.Create;
   GetTimeZoneInformation(tzi);
   FTzBias := tzi.Bias;
end;



destructor TFileInfoSaver.Destroy;
begin
   FList.Free;
   FScanner.Free;
   inherited;
end;

procedure TFileInfoSaver.FoundHandler(Sender:TObject; const FileInformation:TFileInformation);
var
   relpath : string;
   s : string;
begin
   if FileInformation.IsDir then
   begin
      if ExtractFileName(ExcludeTrailingBackslash(FileInformation.Path)) = '.git' then
         (Sender as TFileScanner).StopDirectory;
      Exit;
   end;

   if FIgnoreList.MatchPattern(FileInformation.Name) then
      Exit;


   relpath := ExtractRelativePath(FBasepath, FileInformation.Path);

   s := relpath+FileInformation.Name+ '|'+
      ISO8601DateTimeToStr(FileInformation.LastWrite);
   FList.Add(s);
end;


procedure TFileInfoSaver.ScanDir(const dir:string);
begin
   FBasePath := dir;
   FList.Add('V1.0');
   FScanner.ScanDir(dir);
   FList.SaveToFile(DestFile);
end;





end.

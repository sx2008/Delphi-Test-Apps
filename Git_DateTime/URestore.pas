unit URestore;

interface

uses Classes;

type
   TRestoreFileInfo = class(TObject)
   protected
      FBasePath : string;
      FList : TStrings;
      procedure RestoreList;
   public
      procedure Restore(const fn : string);
   end;


implementation

uses SysUtils, JclStrings, JclFileutils, ISO8601;

{ TRestoreFileInfo }

procedure TRestoreFileInfo.Restore(const fn: string);
begin
   FBasePath := ExtractFilePath(fn);
   FList := TStringList.Create;
   try
      FList.LoadFromFile(fn);
      RestoreList;
   finally
      FList.Free;
   end;
end;

procedure TRestoreFileInfo.RestoreList;
var
   i : Integer;
   s : String;
   fn : string;
   dt : TDateTime;
   relpath : string;
begin
   for i := 1 to FList.Count - 1 do
   begin
      s := FList[i];

      if (s <> '') and (s[1]='[') then
      begin
         // read relative path
         relpath := copy(s, 2, Length(s)-2);
         Continue;
      end;


      fn := StrToken(s, '|');

      if relpath <> '' then
         fn := ExtractFileName(fn);  // for backward compatibility

      fn := FBasePath + relpath + fn;

      if FileExists(fn) then
      begin
         dt := ISO8601StrToDateTime(StrToken(s, '|'));

         //SetFileLastAccess(fn, dt);
         SetFileLastWrite(fn, dt);
         //SetFileCreation(fn, dt);
      end;
   end;

end;

end.

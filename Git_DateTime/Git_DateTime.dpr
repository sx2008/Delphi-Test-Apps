program Git_DateTime;
{$APPTYPE CONSOLE}
uses
  Windows,
  sysutils,
  Classes,
  FileScanner in 'FileScanner.pas',
  URestore in 'URestore.pas',
  ISO8601 in 'ISO8601.pas',
  UStore in 'UStore.pas',
  UGitIgnore in 'UGitIgnore.pas';

var
   x : TFileInfoSaver;
   r : TRestoreFileInfo;
   ignorelist : TGitIgnore;
   fn : string;
begin
   fn := '.gitfiledata';

   if FindCmdLineSwitch('h', ['/','-'], True) then
   begin
      Writeln('Git_DateTime Version 1.0');
      Writeln('options:');
      Writeln('-r = Restore');
      Writeln('-h = help');
   end
   else if FindCmdLineSwitch('r', ['/','-'], True) then
   begin
      r := TRestoreFileInfo.Create;
      try
         if FileExists(fn) then
            r.Restore(fn)
         else
            Writeln(fn,' doesn''t exist');
      finally
         r.Free;
      end;
   end
   else
   begin
      ignorelist := TGitIgnore.Create;
      x := TFileInfoSaver.Create(ignorelist);
      try
         ignorelist.LoadIgnoreFile('.gitignore');
         x.DestFile := fn;
         x.ScanDir('.');
      finally
         x.Free;
         ignorelist.Free;
      end;
   end;


end.
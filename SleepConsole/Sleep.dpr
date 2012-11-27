program Sleep;
{$APPTYPE CONSOLE}

uses
  Windows,
  SysUtils;


function ContainsString(var s:string; const Substr:string):Boolean;
var
   i : Integer;
begin
   i := Pos(Substr, s);
   if i > 0 then
   begin
      Result := True;
      Delete(s, i, Length(Substr));
   end
   else
      Result := False;
end;


procedure ShowUsage;
begin
   // Hilfe anzeigen
   Writeln('Usage: Sleep [timeout]');
   Writeln('Examples: Sleep 500ms');
   Writeln('          Sleep 20s');
   Writeln('          Sleep 3min');
   Writeln('          Sleep 4h');
end;


var
   mult, sleeptime : Integer;
   timeout : Double;
   s : String;
begin

   if ParamCount >= 1 then
   begin
      if FindCmdLineSwitch('h', ['-', '/'], True)
      or FindCmdLineSwitch('?', ['-', '/'], True)
      or FindCmdLineSwitch('help', ['-', '/'], True)
      then
      begin
         // Hilfe anzeigen
         ShowUsage;
         Exit;
      end;

      s := ParamStr(1);      

      if ContainsString(s, 'ms') then
         mult := 1
      else if ContainsString(s, 's') then
         mult := 1000
      else if ContainsString(s, 'min') then
         mult := 1000 * 60
      else if ContainsString(s, 'h') then
         mult := 1000 * 60 * 60
      else
         mult := 1;

      timeout := StrToFloat(s);
      timeout := timeout * mult;
   end
   else
      timeout := 1000;   // Default Wartezeit 1000ms

   sleeptime := round(timeout);
   Writeln('Sleeping ', sleeptime, ' ms ....');

   Windows.Sleep(sleeptime);

end.

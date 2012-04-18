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



var
   timeout, mult : Integer;
   s : String;
begin
   timeout := 1000;   // Default Wartezeit 1000ms

   if ParamCount >= 1 then
   begin
      s := ParamStr(1);
      if (s = '/?') or (s = '-?') or (s = '-h') or (s = '/h') then
      begin
         // Hilfe anzeigen
         Writeln('Usage: Sleep [timeout]');
         Writeln('Examples: Sleep 500ms');
         Writeln('          Sleep 20s');
         Writeln('          Sleep 3min');
         Writeln('          Sleep 4h');
         Exit;
      end;


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

      timeout := StrToInt(s);
      timeout := timeout * mult;
   end;

   Writeln('Sleeping ', timeout, ' ms ....');

   Windows.Sleep(timeout);

end.

unit MColorText;

interface

uses Windows, Graphics;

procedure DrawPCodeText(canvas:TCanvas; rect : TRect; text:string);


implementation

uses SysUtils;


{***************************************************************

§+B  = fett    (B steht für Bold)
§-B  = fett aus
§+I  = kursiv  (I steht für Italic)
§-I  = kursiv aus
§+U  = unterstreichen  (U steht für Underline)
§-U  = unterstreichen aus
§TCxxxxxxxx  = Text Farbe setzen  xxxxxxxx ist die Farbe hexadezimal
§BCxxxxxxxx  = Hintergrund Farbe setzen

****************************************************************}
procedure DrawPCodeText(canvas:TCanvas; rect : TRect; text:string);
const
  ESCAPE_CHAR = '§';

  procedure OutputText(const s:string);
  var
     tlen : Integer;
  begin
     Canvas.TextOut(Rect.Left, Rect.Top, s);   //Teilstring in das Canvas schreiben
     tlen := Canvas.TextWidth(s);              //Länge des Teilstrings bzw. Platzbedarf im Canvas ermitteln
     Inc(Rect.Left, tlen);                     //Zum linken X-Wert der Canvas addieren (für den nächsten Teilstring)
  end;


  function ExtractColor(const s : string):TColor;
  begin
     Result := StrToInt('$'+s);
  end;

var
   i, dlen : Integer;
   tmp : string;
begin
   while text <> '' do
   begin
      i := Pos(ESCAPE_CHAR, text);
      if i <> 0 then
      begin
         OutputText(Copy(text, 1, i-1));
         Delete(text, 1, i); // ausgegeb. Text + Escapezeichen löschen
         dlen := 0;
         tmp := Copy(text,1, 2);
         if tmp = '+B' then
         begin
            canvas.Font.Style := canvas.Font.Style + [fsBold];
            dlen := 2;
         end
         else if tmp = '-B' then
         begin
            canvas.Font.Style := canvas.Font.Style - [fsBold];
            dlen := 2;
         end
         else if tmp = '+I' then
         begin
            canvas.Font.Style := canvas.Font.Style + [fsItalic];
            dlen := 2;
         end
         else if tmp = '-I' then
         begin
            canvas.Font.Style := canvas.Font.Style - [fsItalic];
            dlen := 2;
            // bei kursivem Text braucht man etwas Abstand zum folgenden Text
            Inc(rect.Left, 3);
         end
         else if tmp = '+U' then
         begin
            canvas.Font.Style := canvas.Font.Style + [fsUnderline];
            dlen := 2;
         end
         else if tmp = '-U' then
         begin
            canvas.Font.Style := canvas.Font.Style - [fsUnderline];
            dlen := 2;
         end
         else if tmp = 'TC' then   // Text Color
         begin
            canvas.Font.Color := ExtractColor(Copy(text,3,8));
            dlen := 10;
         end
         else if tmp = 'BC' then   // Background Color
         begin
            canvas.Brush.Color := ExtractColor(Copy(text,3,8));
            dlen := 10;
         end
         else if tmp[1]=ESCAPE_CHAR then
         begin
            OutputText(ESCAPE_CHAR);
            dlen := 1;
         end;

         if dlen > 0 then
            Delete(text, 1, dlen);
      end
      else
      begin
         OutputText(text);
         text := '';
      end;
   end;
end;




end.

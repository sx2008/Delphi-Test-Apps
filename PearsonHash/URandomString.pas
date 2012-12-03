
unit URandomString;

interface

uses Classes;

function RandomString(const len: Integer = 10; const CharSet: string = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'): string;overload;
function RandomString(const x:array of string): string;overload;
function RandomString(s:TStrings):string;overload;

function RandomDigitString(const len:Integer):string;

function RandomBytes(const len: Integer):string;


procedure RandomizeTStrings(list:TStrings);


implementation

uses Sysutils;

{**************************************************************************
 * NAME:    RandomString
 * DESC:    Erzeugt einen zufälligen String
 * PARAMS:  len: länge des erzeugten strings
 *          CharSet: string der die zu verwendenden Zeichen enthält
 * RESULT:  [-]
 *************************************************************************}
function RandomString(const len: Integer; const CharSet: string): string;
var
   i: Integer;
   pResult : PChar;
begin
   SetLength(Result,len); // Speicher im Result-String reservieren
   pResult := PChar(Result);
   for i := 1 to len do
   begin
      pResult^ := CharSet[1+Random(Length(CharSet))];
      Inc(pResult);
   end;
end;

{**************************************************************************
 * NAME:    RandomString
 * DESC:    Es wird ein String aus dem offenen String-Array x zufällig
 *          ausgewählt und zurückgegeben
 * PARAMS:  [-]
 * RESULT:  [-]
 *************************************************************************}
function RandomString(const x:array of string): string;overload;
begin
   Result := x[Random(Length(x))];
end;


{**************************************************************************
 * NAME:    RandomString
 * DESC:    Es wird ein String aus der StringListe s zufällig
 *          ausgewählt und zurückgegeben
 * PARAMS:  [-]
 * RESULT:  [-]
 *************************************************************************}
function RandomString(s: TStrings): string;
begin
   Assert(Assigned(s));
   if s.Count = 0 then
      Result := ''
   else
      Result := Trim(s.Strings[Random(s.Count)]);
end;


function RandomDigitString(const len:Integer):string;
begin
   Result := RandomString(len, '0123456789');
end;

function RandomBytes(const len: Integer):string;
const
   MAX_BYTE = 256;
var
   i: Integer;
   pResult : PChar;
begin
   SetLength(Result,len); // Speicher im Result-String reservieren
   pResult := PChar(Result);
   for i := 1 to len do
   begin
      pResult^ := Chr(Random(MAX_BYTE));
      Inc(pResult);
   end;
end;


procedure RandomizeTStrings(list:TStrings);
var
   list2 : TStrings;
   i : Integer;
begin
   list2 := TStringList.Create;
   list.BeginUpdate;
   try
      while list.Count > 1 do
      begin
         i := Random(list.Count);
         list2.AddObject(list.Strings[i], list.Objects[i]);
         list.Delete(i);
      end;
      list.AddStrings(list2);
   finally
      list.EndUpdate;
      list2.Free;
   end;
end;


procedure RandomizeTStrings2(list:TStrings);
var z : Integer;
begin
   list.BeginUpdate;
   try
      for z := 0 to list.Count-1 do
         list.Exchange(z,Random(list.Count));
   finally
      list.EndUpdate;
   end;
end;



end.

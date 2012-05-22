unit UGitIgnore;

interface

uses Classes;

type

  // checks if a filename matches a pattern from the .gitignore file
  TGitIgnore = class(TStringList)
  public
    procedure Clean;
    function LoadIgnoreFile(const filename:string):Boolean;

    function MatchPattern(const filename:string):Boolean;
  end;




implementation

uses SysUtils;

{**************************************************************************
 * NAME:    StrMatch
 * DESC:    Vergleicht 2 Strings unter Berücksichtigung von Wildcards.
 *
 *          based on component TWildMatch from Elliott Shevin (shevine @ aol.com)
 *
 *          Beispiel:
 *             StrMatch('Hallo Welt!','H?llo W*')     ==> True
 *             StrMatch('Hello World!','H?llo W*')    ==> True
 *             StrMatch('Hello World!','H?llo W*d!')  ==> True
 *             StrMatch('Hello World!','H?llo W*d')   ==> False
 *
 * PARAMS:  SearchString: string;
 *             Der zu suchende String
 *          Mask: string;
 *             Der String mit den Wildcards
 *          CaseSensitive: boolean;
 *             Berücksichtigung von Groß/Kleinschreibung.
 * RESULT:  True, falls die Strings übereinstimmen.
 *************************************************************************}
function StrMatch(const SearchString, Mask : string; const CaseSensitive: Boolean = True) : boolean;
const
   WildCardString = '*';
   WildCardChar   = '?';
var
   s, m   : string;
   ss     : string[1];
   c      : char;
begin
   s  := SearchString;
   m  := Mask;

   if not CaseSensitive then
   begin
      s := Uppercase(s);
      m := Uppercase(m);
   end;

   // Compare the two strings one character at a time until one or the
   // other is exhausted. For each character that matches, we truncate
   // both strings at the left.
   while (Length(s) > 0) and (Length(m) > 0) do
   begin

      // Take the first character from the mask.
      ss := Copy(m,1,1);
      c := ss[1];

      if c = WildCardChar then
      begin
         // If the next mask character is wildchar, count the two characters
         // as matching; lop them off both strings.
         Delete(s,1,1);
         Delete(m,1,1);
      end
      else if c = WildCardString then
      begin
         // If the next character is a WildString, lop it off the
         // mask string, since it matches whatever follows.
         // Then keep calling this routine recursively
         // to see if what's left of the search string matches what
         // remains of the mask. If it doesn't, truncate the search
         // string at the left (the WildString character matches
         // those bytes, too) and repeat until either there's a match
         // or the search string is exhausted, which means the
         // WildString character has eaten the entire remaining
         // search string.
         Delete(m,1,1);
         while (not StrMatch(s,m,CaseSensitive)) and (Length(s) > 0) do
            Delete(s,1,1);
      end
      else if Copy(s,1,1) = Copy(m,1,1) then
      begin
         // Any other character must be an exact match. If not,
         // clear the search string to stop the loop, as a match
         // failure has been detected. This will be sealed below
         // because the search string is null but the mask string
         // is not.
         Delete(s,1,1);
         Delete(m,1,1);
      end
      else
         s := '';
   end;

   // If the loop is ended, the strings have matched if they
   // are now both reduced to null or if the match string
   // is reduced to a single WildString character.
   Result := ((Length(s) = 0) and (Length(m) = 0)) or (m = WildCardString);
end;

{ TGitIgnore }

procedure TGitIgnore.Clean;
var
   i : Integer;
   s : string;
begin
   for i := Count - 1 downto 0 do
   begin
      s := Strings[i];
      if (s = '') or (s[1]='#') then
         delete(i);
   end;
end;

function TGitIgnore.LoadIgnoreFile(const filename: string): Boolean;
begin
   Result := FileExists(filename);
   if Result then
      LoadFromFile(filename);
end;

function TGitIgnore.MatchPattern(const filename: string): Boolean;
var
   i : Integer;
   pattern : string;
begin
   for i := Count - 1 downto 0 do
   begin
      pattern := Strings[i];
      if StrMatch(filename, pattern, False) then
      begin
         Result := True;
         Exit;
      end;
   end;
   Result := False;
end;



end.

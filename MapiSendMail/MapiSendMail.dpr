program MapiSendMail;
{$APPTYPE CONSOLE}
uses
  Windows,
  sysutils,
  JclMapi,
  JclFileUtils,
  JclStrings,
  Classes,
  UCommandLine in 'UCommandline.pas';

var
   email : TJclEmail;
   ShowDialog, saveonly, verbose : Boolean;
   Filelist : TStringList;


function BuildFileList(const Path: string; const Attr: Integer; const List: TStrings): Boolean;
var
  SearchRec: TSearchRec;
  R: Integer;
begin
  Assert(List <> nil);
  R := FindFirst(Path, Attr, SearchRec);
  Result := R = 0;
  List.BeginUpdate;
  try
    if Result then
    begin
      while R = 0 do
      begin
        if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
          List.Add(SearchRec.Name);
        R := FindNext(SearchRec);
      end;
      Result := R = ERROR_NO_MORE_FILES;
    end;
  finally
    SysUtils.FindClose(SearchRec);
    List.EndUpdate;
  end;
end;

function BuildFileListMulti(MultiPath: string; const Attr: Integer; const List: TStrings): Boolean;
var
  path : string;
begin
  Result := False;
  repeat
    path := StrToken(MultiPath, ';');
    Result := Result or BuildFileList(path, Attr, List);
  until MultiPath='';
end;

function ExtractParam(var s:string; const param:string):Boolean;
var
   l : Integer;
begin
   l := length(param);

   if UpperCase(Copy(s, 1, l)) = param then
   begin
      Delete(s, 1, length(Param));
      Result := True;
   end
   else
      Result := False;
end;


procedure DoSendMail(const filename:string);
var
   list : TStringList;
   s : string;
begin
   email := TJclEmail.Create;
   list := TStringList.Create;
   try
      list.LoadFromFile(filename);

      while list.Count>0 do
      begin
         s := list[0];
         if ExtractParam(s, 'TO:') then
            email.Recipients.Add(s)
         else if ExtractParam(s, 'CC:') then
            email.Recipients.Add(s,'', rkCC)
         else if ExtractParam(s, 'BCC:') then
            email.Recipients.Add(s,'', rkBCC)
         // FROM doesn't work with outlook
         else if ExtractParam(s, 'FROM:') then
            email.Recipients.Add(s,'', rkOriginator)
         else if ExtractParam(s, 'SUBJECT:') then
            email.Subject := s
         else if ExtractParam(s, 'ATTACHMENT:') then
            email.Attachments.Add(s)
         else
            Break;
         list.Delete(0);
      end;

   (*
   if list.Count > 0 then
   begin
      s := UpperCase(list[0]);
      if Pos('<HTML>', s) <> 0 then
         email.HtmlBody := True    // html mail
      else
         email.HtmlBody := False;  // plain text
   end;
   *)

   email.Body := list.Text;

   if saveonly then
      email.Save
   else
      email.Send(ShowDialog);
   finally
      list.free;
      email.Free;
   end;
end;


procedure ShowMyself;
begin
   Writeln('MapiSendMail 1.2');
end;

procedure ShowUsage;
begin
   ShowMyself;
   Writeln('usage:');
   Writeln('mapisendmail [switches] mailfile1 mailfile2 ...');
   Writeln('/?         Help');
   Writeln('/sd=1      show mail dialog');
   Writeln('/save      don''t send, save only in mail client');
   Writeln('/diag      show MAPI version and client information');
   Writeln('/p         delete mailfile after successfull sending');
   Writeln('/v         verbose output');
   Writeln('wildcards * and ? are supported');
end;

procedure ShowDiagnose;
var
   i : Integer;
begin
   email := TJclEmail.Create;
   try
      Writeln('MAPI Version: ', email.MapiVersion);
      Writeln;
      Writeln('installed clients:');
      for i := 0 to email.ClientCount-1 do
      begin
         Writeln(' ', email.Clients[i].ClientName);
      end;


      Writeln('default client: ', email.CurrentClientName, '  ',email.DefaultProfileName);

   finally
      email.Free;
   end;
end;

procedure ParseCommandline;
var
   value : string;
   i : Integer;
begin
   Filelist := TStringList.Create;

   GetCmdLineSwitchValue(value, 'sd');
   ShowDialog := (value = '1');
   saveonly := GetCmdLineSwitch('save');
   verbose  := GetCmdLineSwitch('v');
   for i := 1 to ParamCount do
   begin
      if not IsCmdLineSwitch(i) then
         BuildFileList(ParamStr(i), faArchive,  Filelist);
   end;
end;


// Main procedure

var
   i : Integer;
   cd : string;
begin
   if GetCmdLineSwitch('?') or GetCmdLineSwitch('help') or (ParamCount = 0) then
      ShowUsage
   else if GetCmdLineSwitch('diag') then
      ShowDiagnose
   else
   begin
      ParseCommandline;
      if verbose then
         ShowMyself;
      for i := 0 to Filelist.Count-1 do
      begin
         try
            cd := GetCurrentDir;
            if verbose then
               Write('sending [', Filelist[i], ']...');
            // send the mailfile
            DoSendMail(Filelist[i]);
            if verbose then
               Writeln('ok');
            // delete mailfile
            if GetCmdLineSwitch('p') then
               DeleteFile(Filelist[i]);
            SetCurrentDir(cd);
         except
            on E:Exception do
            begin
               Writeln(E.Message);
            end;
         end;
      end;
   end;
end.
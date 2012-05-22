{ 13.01.2012 18:11:22 (GMT+1:00) > [shmia on SHMIA01] checked in Bugfix
   für function ISO8601Timezone()  }
{ 13.01.2012 17:43:43 (GMT+1:00) > [shmia on SHMIA01] checked in Erweiterung
   für Zeitzonen  }
{ 26.06.2009 10:38:50 (GMT+2:00) > [shmia on SHMIA01] checked in ISO8601StrToDateTime:
   korrekte Behandlung von "0000-00-00"  }
{ 02.12.2008 12:31:16 (GMT+1:00) > [haide on HAIDE02] checked in   }
{ 07.11.2008 18:48:12 (GMT+1:00) > [haide on HAIDE02] checked in ISO8601StrToDateTime:
   Zeitanteile wurde nicht umgewandelt, weil diese von der falschen
   Position kopiert wurden.  }
{ 04.04.2007 12:29:25 (GMT+2:00) > [shmia on SHMIA01] checked in function
   ISO8601StrToDateTime() hinzu  }
{ 09.05.2006 15:05:52 (GMT+2:00) > [shmia on SHMIA01] checked in   }
{ 09.05.2006 14:22:47 (GMT+2:00) > [shmia on SHMIA01] checked in   }
unit ISO8601;

// see: http://www.iso.org/iso/en/prods-services/popstds/datesandtime.html


interface

function ISO8601DateTimeToStr(DateTime: TDateTime):string;overload;
function ISO8601DateTimeToStr(DateTime: TDateTime; tzbias:Integer):string;overload;

function ISO8601DateToStr(Date: TDateTime):string;

function ISO8601TimeToStr(Time: TDateTime):string;overload;
function ISO8601TimeToStr(Date: TDateTime; tzbias:Integer):string;overload;

function ISO8601StrToDateTime(const s:string):TDateTime;

implementation

uses SysUtils;


function ISO8601Timezone(tzbias{in Minutes}:Integer):string;
var
   sign : Char;
begin
   if tzbias = 0 then
      Result := 'Z'
   else
   begin
      if tzbias < 0 then
      begin
         tzbias := -tzbias;
         sign := '-';
      end
      else
         sign := '+';
      Result := Result + Format('%s%2.2d:%2.2d',[sign,tzbias div 60, tzbias mod 60]);
   end;
end;




function ISO8601DateTimeToStr(DateTime: TDateTime):string;
begin
   Result := FormatDateTime('yyyy-mm-dd"T"hh":"nn":"ss', DateTime);
end;

function ISO8601DateTimeToStr(DateTime: TDateTime; tzbias:Integer):string;overload;
begin
   Result := ISO8601DateTimeToStr(DateTime) + ISO8601Timezone(tzbias);
end;


function ISO8601DateToStr(Date: TDateTime):string;
begin
   Result := FormatDateTime('yyyy-mm-dd', Date);
end;

function ISO8601TimeToStr(Time: TDateTime):string;
begin
   Result := FormatDateTime('hh":"nn":"ss', Time);
end;

function ISO8601TimeToStr(Date: TDateTime; tzbias:Integer):string;
begin
   Result := ISO8601TimeToStr(Date) + ISO8601Timezone(tzbias);
end;




(*
function CheckDateTimeFormat(const Value, DTFormat: String): Boolean;
var
  i: Integer;
begin
   Result := False;
   if Length(Value) = Length(DTFormat) then
   begin
      for i := 1 to Length(Value) do begin
       if DTFormat[i] = '9' then begin  // Digit
         if not (Value[i] in ['0'..'9']) then
           Exit;
       end
       else begin
         if DTFormat[i] <> Value[i] then
           Exit;
       end;
      end;
      Result := True;
   end;
end;
*)



function ISO8601StrToTime(const s:string):TDateTime;
   function ExtractNum(a, len: Integer):Integer;
   begin
      Result := StrToIntDef(Copy(s, a, len), 0);
   end;
begin
   if (Length(s) >= 8) and (s[3]=':') then
   begin
      Result := EncodeTime(ExtractNum(1,2), ExtractNum(4,2), ExtractNum(7,2), 0);
   end
   else
      Result := 0.0;
end;


function ISO8601StrToDateTime(const s:string):TDateTime;
   function ExtractNum(a, len: Integer):Integer;
   begin
      Result := StrToIntDef(Copy(s, a, len), 0);
   end;
var
   year, month, day: Integer;
begin
   if (Length(s) >= 10) and (s[5]='-') and (s[8]='-') then
   begin
      year  := ExtractNum(1, 4);
      month := ExtractNum(6,2);
      day   := ExtractNum(9,2);

      if (year=0) and (month=0) and (day=0) then     // shmia#26.06.2009
         Result := 0.0
      else
         Result := EncodeDate(year, month, day);

      if (Length(s) > 10) and (s[11] = 'T') then
         Result := Result +  ISO8601StrToTime(Copy(s, 12, 999));
   end
   else
      Result := ISO8601StrToTime(s);
end;




end.

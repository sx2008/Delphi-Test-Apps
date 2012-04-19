unit MemoryUtils;

interface

uses Windows;


type
  SIZE_T = Cardinal; 
  {$EXTERNALSYM SIZE_T} 
  DWORDLONG = Int64;  // ULONGLONG 
  {$EXTERNALSYM DWORDLONG} 

type 
  PMemoryStatus = ^TMemoryStatus; 
  LPMEMORYSTATUS = PMemoryStatus; 
  {$EXTERNALSYM LPMEMORYSTATUS} 
  _MEMORYSTATUS = packed record 
    dwLength       : DWORD;
    dwMemoryLoad   : DWORD; 
    dwTotalPhys    : SIZE_T; 
    dwAvailPhys    : SIZE_T; 
    dwTotalPageFile: SIZE_T; 
    dwAvailPageFile: SIZE_T; 
    dwTotalVirtual : SIZE_T; 
    dwAvailVirtual : SIZE_T; 
  end; 
  {$EXTERNALSYM _MEMORYSTATUS} 
  TMemoryStatus = _MEMORYSTATUS; 
  MEMORYSTATUS = _MEMORYSTATUS; 
  {$EXTERNALSYM MEMORYSTATUS} 

type 
  PMemoryStatusEx = ^TMemoryStatusEx; 
  LPMEMORYSTATUSEX = PMemoryStatusEx; 
  {$EXTERNALSYM LPMEMORYSTATUSEX} 
  _MEMORYSTATUSEX = packed record 
    dwLength        : DWORD; 
    dwMemoryLoad    : DWORD; 
    ullTotalPhys    : DWORDLONG; 
    ullAvailPhys    : DWORDLONG; 
    ullTotalPageFile: DWORDLONG; 
    ullAvailPageFile: DWORDLONG; 
    ullTotalVirtual : DWORDLONG; 
    ullAvailVirtual : DWORDLONG;
    ullAvailExtendedVirtual : DWORDLONG; 
  end;
  {$EXTERNALSYM _MEMORYSTATUSEX} 
  TMemoryStatusEx = _MEMORYSTATUSEX; 
  MEMORYSTATUSEX = _MEMORYSTATUSEX; 
  {$EXTERNALSYM MEMORYSTATUSEX} 

//--- 

procedure GlobalMemoryStatus(var lpBuffer: TMemoryStatus); stdcall;
  external kernel32;
{$EXTERNALSYM GlobalMemoryStatus}

function GlobalMemoryStatusEx(var lpBuffer: TMemoryStatusEx): BOOL; stdcall;

function BytesToMB(const i: DWORDLONG): DWORD;





implementation


function GlobalMemoryStatusEx(var lpBuffer: TMemoryStatusEx): BOOL; stdcall;
type
  TFNGlobalMemoryStatusEx = function(var msx: TMemoryStatusEx): BOOL; stdcall;
var
  FNGlobalMemoryStatusEx: TFNGlobalMemoryStatusEx;
begin
  FNGlobalMemoryStatusEx := TFNGlobalMemoryStatusEx(
    GetProcAddress(GetModuleHandle(kernel32), 'GlobalMemoryStatusEx'));
  if not Assigned(FNGlobalMemoryStatusEx) then
  begin
    SetLastError(ERROR_CALL_NOT_IMPLEMENTED);
    Result := False;
  end
  else
    Result := FNGlobalMemoryStatusEx(lpBuffer);
end;


// Byte nach MegaBytes umrechnen
function BytesToMB(const i: DWORDLONG): DWORD; overload;
var
   x : DWORDLONG;
begin
   x := i shr 20;
   Result := x;
end;



end.

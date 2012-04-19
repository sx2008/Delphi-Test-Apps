program ShowMemoryStatus;
{$APPTYPE CONSOLE}
uses
  MemoryUtils in 'MemoryUtils.pas';

var
   ms1 : TMemoryStatus;
   ms2 : TMemoryStatusEx;
begin
   ms1.dwLength := sizeof(TMemoryStatus);
   ms2.dwLength := sizeof(TMemoryStatusEx);
   if GlobalMemoryStatusEx(ms2) then
   begin
      Writeln('Memory Load: ',ms2.dwMemoryLoad, '%');
      Writeln('Total Phys: ',BytesToMB(ms2.ullTotalPhys), ' MB');
      Writeln('Avail Phys: ',BytesToMB(ms2.ullAvailPhys), ' MB');
      Writeln('Total Page File: ',BytesToMB(ms2.ullTotalPageFile), ' MB');
      Writeln('Avail Page File: ',BytesToMB(ms2.ullAvailPageFile), ' MB');
      Writeln('Total Virtual: ',BytesToMB(ms2.ullTotalVirtual), ' MB');
      Writeln('Avail Virtual: ',BytesToMB(ms2.ullAvailVirtual), ' MB');
      Writeln('Avail Ext. Virtual: ',BytesToMB(ms2.ullAvailExtendedVirtual), ' MB');
   end
   else
   begin
      GlobalMemoryStatus(ms1);
      Writeln('MemoryLoad ',ms1.dwMemoryLoad, '%');
      Writeln('Total Phys: ',BytesToMB(ms1.dwTotalPhys), ' MB');
      Writeln('Avail Phys: ',BytesToMB(ms1.dwAvailPhys), ' MB');
      Writeln('Total Page File: ',BytesToMB(ms1.dwTotalPageFile), ' MB');
      Writeln('Avail Page File: ',BytesToMB(ms1.dwAvailPageFile), ' MB');
      Writeln('Total Virtual: ',BytesToMB(ms1.dwTotalVirtual), ' MB');
      Writeln('Avail Virtual: ',BytesToMB(ms1.dwAvailVirtual), ' MB');
   end;
   Readln;
end.



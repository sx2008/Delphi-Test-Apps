{
Auteur:    Henk van de Kamer
Copyright: 2003 by Henk van de Kamer
License:   GPL (http://www.fsf.org/licenses/gpl.html)
Datum:     22-06-2003 (v1.0 release 0)
Updates:   22-06-2003 (v1.0 release 1)
           * bediening via rechter muistoets menu
           * icoon executable aangepast
           * toggle volledig scherm
           * toggle muiscursor
           10-09-2003 (v1.0 release 2)
           * fase/klok afregelscherm toegevoegd
           05-11-2003 (v1.0 release 3)
           * Veel snellere fase/klok patroon van Tomas Smit doorgevoerd
           * Andere suggesties van Tomas Smit doorgevoerd
}
program LCDmonitortest;

uses
  Forms,
  UnitMonitor in 'UnitMonitor.pas' {ScreenForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'LCD monitortest';
  Application.CreateForm(TScreenForm, ScreenForm);
  Application.Run;
end.

unit ActiveXStarterKit_TLB;

// ************************************************************************ //
// WARNUNG                                                                    
// -------                                                                    
// Die in dieser Datei deklarierten Typen wurden aus Daten einer Typbibliothek
// generiert. Wenn diese Typbibliothek explizit oder indirekt (über eine     
// andere Typbibliothek) reimportiert wird oder wenn die Anweisung            
// 'Aktualisieren' im Typbibliotheks-Editor während des Bearbeitens der     
// Typbibliothek aktiviert ist, wird der Inhalt dieser neu generiert und alle 
// manuell vorgenommenen Änderungen gehen verloren.                           
// ************************************************************************ //

// PASTLWTR : $Revision:   1.88.1.0.1.0  $
// Datei generiert am 04.04.2012 15:14:52 aus der unten beschriebenen Typbibliothek.

// ************************************************************************ //
// Typbib: C:\Delphi\Test\ActiveXStarterKit\ActiveXStarterKit.tlb (1)
// IID\LCID: {45071A67-9AB8-4F82-B060-FC33D9630D05}\0
// Hilfedatei: 
// AbhLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINDOWS\system32\StdVCL40.dll)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit muss ohne typüberprüfte Zeiger compiliert werden. 
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, OleCtrls, StdVCL;

// *********************************************************************//
// In dieser Typbibliothek deklarierte GUIDS . Es werden folgende         
// Präfixe verwendet:                                                     
//   Typbibliotheken     : LIBID_xxxx                                     
//   CoClasses           : CLASS_xxxx                                     
//   DISPInterfaces      : DIID_xxxx                                      
//   Non-DISP interfaces : IID_xxxx                                       
// *********************************************************************//
const
  // Haupt- und Nebenversionen der Typbibliothek
  ActiveXStarterKitMajorVersion = 1;
  ActiveXStarterKitMinorVersion = 0;

  LIBID_ActiveXStarterKit: TGUID = '{45071A67-9AB8-4F82-B060-FC33D9630D05}';

  IID_IApplication: TGUID = '{1A8EFC07-D8CF-493C-B544-16080D82EBE6}';
  CLASS_Application_: TGUID = '{6C8046D2-4050-41DF-838B-05B2A3B73DEA}';
type

// *********************************************************************//
// Forward-Deklaration von in der Typbibliothek definierten Typen         
// *********************************************************************//
  IApplication = interface;
  IApplicationDisp = dispinterface;

// *********************************************************************//
// Deklaration von in der Typbibliothek definierten CoClasses             
// (HINWEIS: Hier wird jede CoClass zu ihrer Standardschnittstelle        
// zugewiesen)                                                            
// *********************************************************************//
  Application_ = IApplication;


// *********************************************************************//
// Schnittstelle: IApplication
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1A8EFC07-D8CF-493C-B544-16080D82EBE6}
// *********************************************************************//
  IApplication = interface(IDispatch)
    ['{1A8EFC07-D8CF-493C-B544-16080D82EBE6}']
    function  Get_Version: WideString; safecall;
    procedure SendTextMessage(const text: WideString); safecall;
    function  MethodeDieExceptionVerursacht: WideString; safecall;
    function  Get_Caption: WideString; safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    property Version: WideString read Get_Version;
    property Caption: WideString read Get_Caption write Set_Caption;
  end;

// *********************************************************************//
// DispIntf:  IApplicationDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1A8EFC07-D8CF-493C-B544-16080D82EBE6}
// *********************************************************************//
  IApplicationDisp = dispinterface
    ['{1A8EFC07-D8CF-493C-B544-16080D82EBE6}']
    property Version: WideString readonly dispid 1;
    procedure SendTextMessage(const text: WideString); dispid 2;
    function  MethodeDieExceptionVerursacht: WideString; dispid 3;
    property Caption: WideString dispid 4;
  end;

// *********************************************************************//
// Die Klasse CoApplication_ stellt eine Methode Create und CreateRemote zur      
// Verfügung, um Instanzen der Standardschnittstelle IApplication, dargestellt von
// CoClass Application_, zu erzeugen. Diese Funktionen können                     
// von einem Client verwendet werden, der die CoClasses automatisieren    
// möchte, die von dieser Typbibliothek dargestellt werden.               
// *********************************************************************//
  CoApplication_ = class
    class function Create: IApplication;
    class function CreateRemote(const MachineName: string): IApplication;
  end;

implementation

uses ComObj;

class function CoApplication_.Create: IApplication;
begin
  Result := CreateComObject(CLASS_Application_) as IApplication;
end;

class function CoApplication_.CreateRemote(const MachineName: string): IApplication;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Application_) as IApplication;
end;

end.

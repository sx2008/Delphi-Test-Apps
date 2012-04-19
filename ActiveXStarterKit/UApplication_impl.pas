unit UApplication_impl;

interface

uses
  ComObj, ActiveX, ActiveXStarterKit_TLB, StdVcl;

type
  TApplication_ = class(TAutoObject, IApplication)
  protected
    { Protected-Deklarationen }
    function Get_Version: WideString; safecall;
    procedure SendTextMessage(const text: WideString); safecall;
    function MethodeDieExceptionVerursacht: WideString; safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const Value: WideString); safecall;
  end;

implementation

uses ComServ, MainForm;

{**************************************************************************
 * NAME:    ErrorNumberToHResult
 * DESC:    see also Function "MakeResult" in Unit "ActiveX"
 *************************************************************************}
function ErrorNumberToHResult(ErrorNumber : integer) : HResult;
const
  SEVERITY_ERROR = 1;
  FACILITY_ITF = 4;
begin
  Result := (SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or word (ErrorNumber);
end;



function TApplication_.Get_Version: WideString;
begin
   Result := '1.0 beta';
end;

procedure TApplication_.SendTextMessage(const text: WideString);
begin
   // Meldung an Hauptformular
   Form1.ZeigeMeldung(text);
end;

function TApplication_.MethodeDieExceptionVerursacht: WideString;
begin
   Result := 'dieser String kommt nie zurück';

   
   raise EOleSysError.Create('IApplication.GetPath: Invalid Argument', ErrorNumberToHResult(150), 0);
end;

function TApplication_.Get_Caption: WideString;
begin
   Result := Form1.Caption;
end;

procedure TApplication_.Set_Caption(const Value: WideString);
begin
   Form1.Caption := Value;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TApplication_, Class_Application_,
    ciMultiInstance, tmApartment);
end.

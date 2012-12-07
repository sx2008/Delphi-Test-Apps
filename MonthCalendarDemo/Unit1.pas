unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, UMonthBoldStorage;

type

  TForm1 = class(TForm)
    MonthCalendar1: TMonthCalendar;
    procedure MonthCalendar1GetMonthInfo(Sender: TObject; Month: Cardinal;
      var MonthBoldInfo: Cardinal);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MonthCalendar1DblClick(Sender: TObject);
  private
    { Private-Deklarationen }
    FYearBoldManager : TYearBoldManager;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses Commctrl;


const
  DTM_GETMCSTYLE = DTM_FIRST + 12;
  DTM_SETMCSTYLE = DTM_FIRST + 11;


procedure RefreshMonthCal(x:TMonthCalendar);
begin
  SendMessage(x.Handle,
  DTM_SETMCSTYLE,
  0,
  SendMessage(x.Handle, DTM_GETMCSTYLE, 0, 0) or MCS_DAYSTATE);
end;

procedure TForm1.MonthCalendar1GetMonthInfo(Sender: TObject;
  Month: Cardinal; var MonthBoldInfo: Cardinal);
begin
   MonthBoldInfo := FYearBoldManager.GetMonthBoldInfo(Month);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   FYearBoldManager := TYearBoldManager.Create;
   FYearBoldManager.MakeBold(12, 24);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
   FYearBoldManager.Free;
end;

procedure TForm1.MonthCalendar1DblClick(Sender: TObject);
var
   year, month, day : Word;
begin
   // aktuell markiertes Datum holen
   DecodeDate(MonthCalendar1.Date, year, month, day);

   // Tag "umdrehen"
   FYearBoldManager.Toggle(month, day);


   // leider scheint ein Repaint nicht zu funktionieren
   // man muss den Monat wechseln, damit man die Änderungen sieht.
   MonthCalendar1.Repaint;
end;

end.

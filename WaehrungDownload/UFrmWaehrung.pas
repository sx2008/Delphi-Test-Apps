{ 15.11.2007 14:11:57 (GMT+1:00) > [haide on HAIDE02] checked in   }
{ 20.08.2007 12:03:34 (GMT+2:00) > [haide on HAIDE02] checked in Event
   OnAfterCurrencyInternetUpdate hinzu.  }
{ 25.06.2007 10:51:02 (GMT+2:00) > [shmia on SHMIA01] checked in Download
   der Umrechnungsraten ohne Umweg über temporäre  Datei  }
{ 04.04.2007 11:55:59 (GMT+2:00) > [rotha on ROTHA01] checked in Button InternetUpdate kommentiert  }
{ 03.04.2007 15:39:14 (GMT+2:00) > [shmia on SHMIA01] checked in Umrechnungsraten
   aus dem Internet (Europäische Zentralbank) downloaden  }
{ 02.04.2007 14:32:45 (GMT+2:00) > [rotha on ROTHA01] checked in stammdaten.chm ersetzt  }
{ 02.04.2007 13:46:26 (GMT+2:00) > [haide on HAIDE02] checked in haide#02.04.07:
   Währungsumrechnung nicht mehr fix im Programm hinterlegt sondern
   aus Datenbanktabelle  }
{ 14.12.2005 18:48:25 (GMT+1:00) > [shmia on SHMIA01] checked in Formulare
   dynamisch erzeugen und beim Schliesen zerstören  }
unit UFrmWaehrung;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  UDMCvs, Grids, DBGrids, UFrameNavForm, ExtCtrls, Db, ADODB, StdCtrls,
  dxDBTLCl, dxGrClms, dxTL, dxDBCtrl, dxDBGrid, dxCntner, DBCtrls, dxGrClEx,
  UrlLabel, Buttons;

type
  TFrmWaehrung = class(TForm)
    Panel1: TPanel;
    FrameNavForm1: TFrameNavForm;
    TblWaehrung: TADOTable;
    DsWaehrung: TDataSource;
    TblWaehrungIdCurrencyUnit: TStringField;
    TblWaehrungWaehrung: TStringField;
    TblWaehrungCurrencyUnit2: TStringField;
    TblWaehrungEuroConvRate: TFloatField;
    TblWaehrungLastUpdate: TDateTimeField;
    TblWaehrungCountries: TMemoField;
    dxDBGrid1: TdxDBGrid;
    dxDBGrid1IdCurrencyUnit: TdxDBGridMaskColumn;
    dxDBGrid1Waehrung: TdxDBGridMaskColumn;
    dxDBGrid1CurrencyUnit2: TdxDBGridMaskColumn;
    dxDBGrid1LastUpdate: TdxDBGridDateColumn;
    dxDBGrid1EuroConvRate: TdxDBGridMaskColumn;
    dxDBGrid1Countries: TdxDBGridButtonColumn;
    UrlLabel1: TUrlLabel;
    UrlLabel2: TUrlLabel;
    UrlLabel3: TUrlLabel;
    BtnInternetUpdate: TBitBtn;
    Label2: TLabel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dxDBGrid1CountriesButtonClick(Sender: TObject; AbsoluteIndex: Integer);
    procedure TblWaehrungBeforePost(DataSet: TDataSet);
    procedure BtnInternetUpdateClick(Sender: TObject);
  private
    FOnAfterCurrencyInternetUpdate: TNotifyEvent;
  public
    procedure UpdateCurrency(const curstring:string; rate:Double);
    procedure UpdateFromXML(const data:string; dataIsFile:Boolean);
    procedure UpdateFromInternet;

    property OnAfterCurrencyInternetUpdate: TNotifyEvent read FOnAfterCurrencyInternetUpdate write FOnAfterCurrencyInternetUpdate;
  published
    procedure SetLanguage(Locale: Longword);
  end;

//var
//  FrmWaehrung: TFrmWaehrung;

implementation

uses Variants, JclFileUtils, ULanguage, UPssStrings, UPssFieldNames, UADOhlp, UDialogs, UDMWaehrung,
  MSXML2_TLB, MSXML_hlp, Dialogs;

{$R *.DFM}





procedure TFrmWaehrung.FormCreate(Sender: TObject);
begin
   UAdoHlp.MsAccessCursorLocation(Self);
   
   TblWaehrung.Open;

   FrameNavForm1.DataSource := DsWaehrung;

   SetLanguage(0);
end;

procedure TFrmWaehrung.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TblWaehrung.Close;

   DMWaehrung.Refresh;

   Action := caFree;
end;

{**************************************************************************
 * NAME:    SetLanguage
 * DESC:    Sprachanpassung zur Laufzeit
 * PARAMS:  [-]
 * RESULT:  [-]
 * CREATED: 00-00-2001/Haide
 * CHANGED: 00-00-2001/Haide
 *************************************************************************}
procedure TFrmWaehrung.SetLanguage(Locale: Longword);
begin
   FrameNavForm1.SetLanguage(Locale);

   PssLoadCaption(ID_PssWaehrung,Self);
end;

procedure TFrmWaehrung.dxDBGrid1CountriesButtonClick(Sender: TObject; AbsoluteIndex: Integer);
var
   sOldValue,sNewValue: string;
   slTmp: TStringList;
begin
   slTmp := TStringList.Create;
   try
      sOldValue := TblWaehrung.FieldByName('Countries').AsString;

      slTmp.Text := sOldValue;
      if UDialogs.BizEditStrings(slTmp,'Länder für Währung ' + TblWaehrung.FieldByName('IdCurrencyUnit').AsString) = mrOk then
      begin
         sNewValue := slTmp.Text;

         if sNewValue <> sOldValue then
         begin
            if not (TblWaehrung.State in [dsEdit,dsInsert]) then
            begin
               TblWaehrung.Edit;
            end; 
            TblWaehrung.FieldByName('Countries').AsString := sNewValue;
         end;
      end;
   finally
      slTmp.Free;
   end;
end;

procedure TFrmWaehrung.TblWaehrungBeforePost(DataSet: TDataSet);
begin
   DataSet['LastUpdate'] := Now;
end;

procedure TFrmWaehrung.UpdateFromInternet;
const
   URL = 'http://www.ecb.int/stats/eurofxref/eurofxref-daily.xml';
var
   xmldata : string;
   hr : IXMLHTTPRequest;
begin
   hr := CoXMLHTTP.Create;

   // Daten herunterladen
   hr.open('GET', URL, False, EmptyParam, EmptyParam);
   hr.send(EmptyParam);
   xmldata := hr.responseText;

//   ShowMessage(xmldata);
   UpdateFromXML(xmldata, False);

   if Assigned(FOnAfterCurrencyInternetUpdate) then
      FOnAfterCurrencyInternetUpdate(Self);
end;

procedure TFrmWaehrung.UpdateFromXML(const data: string; dataIsFile:Boolean);
var
   document : IXMLDOMDocument2;
   node : IXMLDOMNode;
   ElementCube : IXMLDOMElement;
   i : Integer;
   currency : string;
   rate : Double;
begin
   document := CoDOMDocument30.Create;

   if dataIsFile then
      document.load(data)
   else
      document.loadXML(data);

   CheckDocumentError(document);


   node := document.documentElement.selectSingleNode('Cube');
   node := node.firstChild;

   // Schleife über alle vorhandenen Währungen
   for i := 0 to node.childNodes.length-1 do
   begin
      ElementCube := node.childnodes.item[i] as IXMLDOMElement;

      currency := ElementCube.getAttribute('currency');
      rate     := AttrAsFloat(ElementCube, 'rate');
      UpdateCurrency(currency, rate);
   end;

end;

procedure TFrmWaehrung.BtnInternetUpdateClick(Sender: TObject);
begin
   UpdateFromInternet;
end;

procedure TFrmWaehrung.UpdateCurrency(const curstring: string;  rate: Double);
begin
   if TblWaehrung.Locate('IdCurrencyUnit', curstring, []) then
   begin
      // Konvertierungsrate updaten
      TblWaehrung.Edit;
      TblWaehrung['EuroConvRate'] := rate;
      TblWaehrung.Post;
   end
   else
   begin
      // die Währung gab's bisher noch nicht
      // => anfügen in Währungs-Tabelle
      TblWaehrung.Append;
      TblWaehrung['IdCurrencyUnit'] := curstring;
      TblWaehrung['EuroConvRate']   := rate;
      TblWaehrung.Post;
   end;

end;

end.

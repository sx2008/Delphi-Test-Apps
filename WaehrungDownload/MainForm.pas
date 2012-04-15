unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, MSXML2_TLB, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure UpdateFromXML(const data: string; dataIsFile: Boolean);
    procedure UpdateCurrency(const curstring:string; rate:Double);
  public
    { Public-Deklarationen }
    procedure UpdateFromInternet;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  UpdateFromInternet;
end;

procedure TForm1.UpdateFromXML(const data: string; dataIsFile:Boolean);
var
   document : IXMLDOMDocument2;
   node, node2 : IXMLDOMNode;
   ElementCube : IXMLDOMElement;
   i : Integer;
   currency : string;
   rate : Double;
begin
   document := CoDOMDocument40.Create;

   if dataIsFile then
      document.load(data)
   else
      document.loadXML(data);

//   CheckDocumentError(document);


   node2 := document.documentElement;
   node := node2.lastChild;
//   node := document.documentElement.selectSingleNode('//Cube');
   node := node.firstChild;

   // Schleife über alle vorhandenen Währungen
   for i := 0 to node.childNodes.length-1 do
   begin
      ElementCube := node.childnodes.item[i] as IXMLDOMElement;

      currency := ElementCube.getAttribute('currency');
      rate     := ElementCube.getAttribute('rate');
      UpdateCurrency(currency, rate);
   end;

end;



procedure TForm1.Button2Click(Sender: TObject);
begin
  if opendialog1.Execute then
  begin
    UpdateFromXML(OpenDialog1.FileName,true);
  end;
end;

procedure TForm1.UpdateCurrency(const curstring: string; rate: Double);
begin
  memo1.lines.Add(Format('%s = %f',[curstring, rate]));
end;

procedure TForm1.UpdateFromInternet;
const
   URL = 'http://www.ecb.int/stats/eurofxref/eurofxref-daily.xml';
var
   xmldata : string;
   hr : IXMLHTTPRequest;
begin
   hr := CoXMLHTTP40.Create;

   // Daten herunterladen
   hr.open('GET', URL, False, EmptyParam, EmptyParam);
   hr.send(EmptyParam);
   xmldata := hr.responseText;
   if hr.status <> 200 then
    raise Exception.CreateFmt('%d %s',[hr.Status, hr.statusText]);

//   ShowMessage(xmldata);
   UpdateFromXML(xmldata, False);

end;






end.

unit UDownloader;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, MSXML2_TLB;
{
Hinweis zum Import der Unit MSXML2_TLB
1.) Datei -> alle schliesen
2.) Projekt -> Typbibliothek importieren...
3.) Auswählen: Microsoft XML (Version 4)
4.) Unit anlegen klicken
}



type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    Label1: TLabel;
    CboURL: TComboBox;
    BtnGet: TButton;
    BtnHead: TButton;
    procedure BtnGetClick(Sender: TObject);
    procedure BtnHeadClick(Sender: TObject);
  private
    { Private-Deklarationen }
    function CreateRequestObject: IXMLHTTPRequest;
    procedure CallHttpMethod(const method:string);
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses ComObj, VariantUtils2;


function TForm1.CreateRequestObject: IXMLHTTPRequest;
begin
   // Hinweis:
   // alle XMLHTTP - Objekte von MSXML 1.0 bis 3.0 haben Bugs
   // erst ab Version 4.0 funktioniert das richtig
   // man sollte MSXML SP3 auf dem Rechner installiert haben

   try
//   result := CoXMLHTTP.Create;  // Interface erzeugen
      Result := Createoleobject('Msxml2.XMLHTTP.6.0') as IXMLHTTPRequest;
   except
      on E:Exception do
      begin
         E.Message := 'MSXML 4.0 or higher required!'#13#10+E.Message;
         raise;
      end;
   end;
end;




procedure TForm1.BtnGetClick(Sender: TObject);
begin
   CallHttpMethod('GET');
end;

procedure TForm1.BtnHeadClick(Sender: TObject);
var
   req : IXMLHTTPRequest;
   URL : string;
   user, pw : string;
   data : OleVariant;
begin
   req := CreateRequestObject;

   URL := CboURL.Text;

   req.open('HEAD', URL, False, user, pw);
   req.setRequestHeader('Connection', 'close');
//   req.setRequestHeader('Cache-Control', 'No');
   req.setRequestHeader('User-Agent', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; powered by Delphi)');


   data := '';
   req.send(data);  // Anfrage an Server senden und Antwort abwarten

   // Status auswerten
   if not (req.status in [200, 201, 204]) then
      raise Exception.CreateFmt('HTTP-Download <%s> failed.'#13#10'%d - %s',
         [URL, req.status, req.statusText] );

   Memo1.Text := req.getAllResponseHeaders;
   Memo1.Lines.Add('----');
   Memo1.Lines.Add(Format('%d - %s',[req.status,req.statusText]));
   Memo1.Lines.Add(req.responseText);


end;


procedure TForm1.CallHttpMethod(const method: string);
var
   req : IXMLHTTPRequest;
   URL : string;
   user, pw : string;
   data : OleVariant;
begin
   req := CreateRequestObject;


   URL := CboURL.Text;

   req.open(method, URL, False, user, pw);
   req.setRequestHeader('Cache-Control', 'No');
   req.setRequestHeader('User-Agent', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; powered by Delphi)');

   data := 'test'{Null};  {leerer Body}
   req.send(data);  // Anfrage an Server senden und Antwort abwarten

   // Status auswerten
   if not (req.status in [200, 201, 204]) then
      raise Exception.CreateFmt('HTTP-Download <%s> failed.'#13#10'%d - %s',
         [URL, req.status, req.statusText] );

   Memo1.Text := VarByteArrayToString(req.responseBody);
end;

end.

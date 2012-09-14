unit Unit1;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, 
  StdCtrls, Buttons, Dialogs;

type
  TForm1 = class(TForm)
    CboURL: TComboBox;
    Label1: TLabel;
    BtnUpload: TBitBtn;
    OpenDialog1: TOpenDialog;
    EdtUser: TEdit;
    EdtPW: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    ChkOverwrite: TCheckBox;
    ChkVerify: TCheckBox;
    CboMethod: TComboBox;
    Label4: TLabel;
    procedure BtnUploadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure AddToURLHist(const url:string);
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses MSXML2_TLB, JclStrings, ComObj, VariantUtils2;

{
Hinweis zum Import der Unit MSXML2_TLB
1.) Datei -> alle schliesen
2.) Projekt -> Typbibliothek importieren...
bei höheren Delphi Versionen geht das über Komponente -> Komponente importieren
3.) Auswählen: Microsoft XML (Version 4)
4.) Unit anlegen klicken
}





procedure UploadFile(const BasisURL,user,pw, filename:string; overwrite, verify:Boolean; const Method:string);
var
   req : IXMLHTTPRequest;
   URL : string;
   data, data2 : string;
   dataout : Variant;
begin
//   req := CoXMLHTTP.Create;  // Interface erzeugen
   try
      req := Createoleobject('Msxml2.XMLHTTP.4.0') as IXMLHTTPRequest;
   except
      on E:Exception do
      begin
         E.Message := 'MSXML 4.0 or higher requiered!'#13#10+E.Message;
         raise;
      end;
   end;


   URL := BasisURL;

   StrReplace(URL, '$$FILENAME$$', ExtractFileName(filename), []);



   if not overwrite then
   begin
      req.open('HEAD', URL, False, user, pw);
      req.send(EmptyParam);
      if req.status = 200 then
         raise Exception.CreateFmt('%s already on webserver',[URL]);
   end;

   req.open(Method, URL, False, user, pw);

   // eigenen Request-Header setzen
//   req.setRequestHeader('ApplicationID', 'PSS');
//   req.setRequestHeader('Content-Transfer-Encoding', 'binary');

   data := FileToString(filename);
   req.setRequestHeader('Content-Type', 'application/octet-stream');
   req.setRequestHeader('Content-Length', IntToStr(Length(data)));

   dataout := VarByteArrayCreate2(data);
   req.send(dataout);  // Anfrage an Server senden und Antwort abwarten

   // Status auswerten
   if not (req.status in [200, 201, 204]) then
      raise Exception.CreateFmt('HTTP-Upload <%s> failed.'#13#10'%d - %s',
         [URL, req.status, req.statusText] );

   if verify then
   begin
      req.open('GET', URL, False, user, pw);
      req.send(EmptyParam);
      if req.status <> 200 then
         raise Exception.CreateFmt('%s not found on webserver - %s',[URL, req.statusText]);
      data2 := VarByteArrayToString(req.responseBody);


      if data2 <> data then
         raise Exception.CreateFmt('%s verify failed (org:%d byte server:%d byte)'#13#10'%s',
            [URL, Length(data), Length(data2), req.getAllResponseHeaders]);
   end;

end;



procedure TForm1.AddToURLHist(const url: string);
begin
   if CboURL.Items.IndexOf(url) = -1 then
      CboURL.Items.Add(url);
end;

procedure TForm1.BtnUploadClick(Sender: TObject);
var
   i : Integer;
   basisURL : string;
begin
   basisURL := CboURL.Text;
   if basisURL = '' then
      raise Exception.Create('URL is missing');
   if basisURL[Length(basisURL)] <> '/' then
      basisURL := basisURL + '/';

   if OpenDialog1.Execute then
   begin
      for i := 0 to OpenDialog1.Files.Count-1 do
      begin
         UploadFile(basisURL, EdtUser.Text , EdtPW.Text, OpenDialog1.Files[i],
            ChkOverwrite.Checked, ChkVerify.Checked, Cbomethod.Text);
      end;
      AddToURLHist(CboURL.Text);
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   CboMethod.ItemIndex := 0;
end;

end.

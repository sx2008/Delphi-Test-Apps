{
  WinSock Demo: How to get IP by hostname and how to get hostname by IP.
  Designed by Alex Popkov, 2000
  Uploaded to Code Central, http://codecentral.borland.com, 12.09.2000
  Copyrights: open source.

  Purpose:  There was some questions about hostname <-> address resolving.
            This demo containts sample code as illustration.

  Usage:  Very easy. Just select/enter hostname or IP address and hit [Resolve]
          button.

  Note:   Some hosts may have many IP addresses. Sometimes, one IP address
          can be resolved to many hostnames.

}


unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls;

type
  TMainForm = class(TForm)
    PageControl: TPageControl;
    StatusBar: TStatusBar;
    GetIPByNameTabSheet: TTabSheet;
    NameComboBox: TComboBox;
    NameToIPButton: TButton;
    AddressListBox: TListBox;
    IPToNameTabSheet: TTabSheet;
    AddressComboBox: TComboBox;
    IPToNameButton: TButton;
    NameListBox: TListBox;
    procedure StatusBarResize(Sender: TObject);
    procedure NameToIPButtonClick(Sender: TObject);
    procedure IPToNameButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure StatusText( Text: String );

    procedure NameToIP;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  WinSock, WinSock2;  // I did not found any *.hlp files about WinSock library in my D5Pro.

{$R *.DFM}

procedure TMainForm.StatusBarResize(Sender: TObject);
begin
  StatusBar.Panels[0].Width := StatusBar.Width;
  StatusText( 'Idle' );
end;

// Just show given text in StatusBar
procedure TMainForm.StatusText( Text: String );
begin
  StatusBar.Panels[0].Text := ' ' + Text;
end;

// Resolve hostname to IP address
procedure TMainForm.NameToIPButtonClick(Sender: TObject);
begin
  NameToIPButton.Enabled := False;
  Cursor := crHourGlass;
  AddressListBox.Clear();
  StatusText( 'Busy' );

  NameToIp;

  Cursor := crDefault;
  NameToIPButton.Enabled := True;
  StatusText( 'Idle' );
end;

// Resolve host IP address to hostname
procedure TMainForm.IPToNameButtonClick(Sender: TObject);
type
  TAPInAddr = Array[0..100] of PInAddr;
  PAPInAddr = ^TAPInAddr;
var
  WSAData: TWSAData;
  Address: String;
  InetAddr: u_long;
  HostEntPtr: PHostEnt;
  HostEnt: THostEnt;
  HostName: String;
  pptr: PAPInAddr;
  len, struct: Integer;
  i: Integer;
begin

  IPToNameButton.Enabled := False;
  Cursor := crHourGlass;
  NameListBox.Clear();
  StatusText( 'Busy' );

  WSAStartUp( $101, WSAData );

  try

    Address := Trim( AddressComboBox.Text );
    if Address = '' then
      raise Exception.Create( 'IP address not entered' );

    // Convert textual IP address to binary format
    InetAddr := inet_addr( PChar(Address) );
    if InetAddr = SOCKET_ERROR then
      raise Exception.Create( 'Invalid address entered' );

    // Get hist entry by IP
    HostEntPtr := GetHostByAddr( @InetAddr, len, struct );
    if HostEntPtr = NIL then
      raise Exception.Create( 'WinSock error: ' + IntToStr( WSAGetLastError() ) );

    // Insert hostname into list
    HostName := String( HostEntPtr^.h_name );
    NameListBox.Items.Add( HostName );

    // Add aliases into list (if aliases are present in host entry)
    pptr := PAPInAddr( HostEntPtr^.h_aliases );
    i := 0;
    while pptr^[i] <> NIL do begin
      NameListBox.Items.Add( String( pptr^[i] ) );
      Inc( i );
    end;

{
    ;
    i := 0;
    while HostEntPtr^.h_addr_list[i] <> nil do
    begin
      NameListBox.Items.Add( String( HostEntPtr^.h_addr_list^[i] ) );
      Inc( i );
    end;
}



  except
    on E: Exception do begin
      StatusText( 'Exception' );
      Beep();
      ShowMessage( E.Message );
    end;
  end;

  WSACleanUp();

  Cursor := crDefault;
  IPToNameButton.Enabled := True;
  StatusText( 'Idle' );

end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  buffer: Array[0..63] of Char;
  WSAData: TWSAData;
begin
  // Get local host name
  WSAStartUp( $101, WSAData );
  GetHostName( buffer, SizeOf(buffer) );
  NameComboBox.Items.Add( String( buffer ) );
  WSACleanUp();
end;

procedure TMainForm.NameToIP;
type
  TAPInAddr = Array[0..100] of PInAddr;
  PAPInAddr = ^TAPInAddr;
var
  WSAData: TWSAData;
  Host: String;
  HostEntPtr: PHostEnt;
  pptr: PAPInAddr;
  i: Integer;
begin


  // WinSock initialisation
  WSAStartUp( $101, WSAData );

  try

    Host := Trim( NameComboBox.Text );
    if Host = '' then
      raise Exception.Create( 'Host name not entered' );

    // Get host entry by hostname
    HostEntPtr := GetHostByName( PChar( Host ) );
    if HostEntPtr = NIL then
      raise Exception.Create( 'WinSock error: ' + IntToStr( WSAGetLastError() ) );

    // Make list of host IPs
    pptr := PAPInAddr( HostEntPtr^.h_addr_list );
    i := 0;
    while pptr^[i] <> NIL do begin
      AddressListBox.Items.Add( inet_ntoa( pptr^[i]^ ) );
      Inc( i );
    end;

  except
    on E: Exception do begin
      StatusText( 'Exception' );
      Beep();
      ShowMessage( E.Message );
    end;
  end;

  WSACleanUp(); // uninitialise WinSock

end;


end.

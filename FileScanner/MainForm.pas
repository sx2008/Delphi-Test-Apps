unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileScanner, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    ListView1: TListView;
    Panel1: TPanel;
    BtnStart: TButton;
    Edit1: TEdit;
    BtnStop: TButton;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    CboRecursive: TCheckBox;
    EdtSearched: TEdit;
    Label2: TLabel;
    RgpFilter: TRadioGroup;
    procedure BtnStartClick(Sender: TObject);
    procedure BtnStopClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private-Deklarationen }
    FStopped : Boolean;
    FSearchedDirs : Integer;
    FFoundFiles : Integer;

    function Filter(const FileInformation:TFileInformation):Boolean;

    procedure FoundHandler(Sender:TObject; const FileInformation:TFileInformation);
    procedure UpdateButtons;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses JclStrings;

{$R *.DFM}



function IsDelphiApplication(const fn : string):Boolean;
var
   modul : HMODULE;
begin
   modul := LoadLibraryEx(PChar(fn), 0, LOAD_LIBRARY_AS_DATAFILE);
   if modul <> 0 then
   begin
      Result := (FindResourceEx(modul, RT_RCDATA, 'DVCLAL', 0) <> 0);
      FreeLibrary(modul);
   end
   else
      Result := False;
end;


function IsLoadable(const fn : string):Boolean;
var t:string;
begin
   t := UpperCase(ExtractFileExt(fn));
   Result := StrIsOneOf(t, ['.EXE', '.DLL', '.OCX']);
   //Result := True;
end;

procedure TForm1.BtnStartClick(Sender: TObject);
var
   x :TFileScanner;
begin
   ListView1.Items.Clear;
   FStopped := False;
   FSearchedDirs := 0;
   FFoundFiles := 0;
   UpdateButtons;
   x := TFileScanner.Create;
   try
      x.Recursive := CboRecursive.Checked;
      x.OnFound   := FoundHandler;
      x.ScanDir(Edit1.Text);
   finally
      x.Free;
   end;
   FStopped := True;
   UpdateButtons;
   StatusBar1.SimpleText := '';
end;



function TForm1.Filter(const FileInformation: TFileInformation): Boolean;
begin
   if RgpFilter.ItemIndex = 1 then
      Result := IsLoadable(FileInformation.Name) and
         IsDelphiApplication(FileInformation.Path+FileInformation.Name)
   else
      Result := True;
end;




procedure TForm1.FoundHandler(Sender: TObject; const FileInformation: TFileInformation);
var
   li : TListItem;
   flags : string;
begin
   if FileInformation.IsDir then
   begin
      // Verzeichnis
      if Pos('System32', FileInformation.Path) <> 0 then
         (Sender as TFileScanner).Stop;
      StatusBar1.SimpleText := 'Scanning '+ FileInformation.Path+ ' ...';
      Inc(FSearchedDirs);
      EdtSearched.Text := IntToStr(FSearchedDirs)+' / ' +IntToStr(FFoundFiles);
   end
   else
   begin
      if Filter(FileInformation) then
      begin

      // Datei
      li := ListView1.Items.Add;
      li.Caption := FileInformation.Name;
      li.SubItems.Add(IntToStr(FileInformation.Size));
      li.SubItems.Add(IntToStr(FileInformation.Depth));
      li.SubItems.Add(DateTimeToStr(FileInformation.LastWrite));
      li.SubItems.Add(DateTimeToStr(FileInformation.Created));


      flags := '';
      if FileInformation.ArchiveFlag then flags := flags + 'A';
      if FileInformation.ReadOnlyFlag then flags := flags + 'R';
      li.SubItems.Add(flags);

      li.SubItems.Add(FileInformation.Path);

      Inc(FFoundFiles);
      EdtSearched.Text := IntToStr(FSearchedDirs)+' / ' +IntToStr(FFoundFiles);

      end;

   end;

   Application.ProcessMessages;

   if FStopped then
   begin
      TFileScanner(Sender).Stop;
      StatusBar1.SimpleText := 'Stopped';
   end;
end;

procedure TForm1.BtnStopClick(Sender: TObject);
begin
   FStopped := True;
end;

// Start/Stop Button aktivieren/deaktivieren
procedure TForm1.UpdateButtons;
begin
   BtnStart.Enabled := FStopped;
   BtnStop.Enabled  := not FStopped;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   FStopped := True;
   UpdateButtons;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   // Beim Schliesen muss die Suche unterbrochen werden können
   FStopped := True;
   CanClose := True;
end;


end.

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls;

const
   WM_BARCODE = WM_USER+188;


type
  TForm1 = class(TForm)
    BtnClear: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    BtnShowVKeyCodes: TButton;
    ListView1: TListView;
    ChkDown: TCheckBox;
    ChkPress: TCheckBox;
    ChkUp: TCheckBox;
    Button1: TButton;
    Memo1: TMemo;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnClearClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure BtnShowVKeyCodesClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure MsgHandler(var Msg: TMsg; var Handled: Boolean);

    procedure Barcode_Handler(var Message: TMessage); message WM_BARCODE;


  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses UVKeyCodesForm, MouseTestForm;

{$R *.DFM}

var keyboardchars:string;


function ShiftStateAsString(Shift: TShiftState):string;
begin
   Result := '';
   if ssshift in Shift then
      Result := Result + 'Shift-';
   if ssAlt in Shift then
      Result := Result + 'Alt-';
   if ssCtrl in Shift then
      Result := Result + 'Ctrl-';
end;


procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   s : string;
   li : TListItem;
begin
   if ChkDown.Checked then
   begin
      s := ShiftStateAsString(Shift) + chr(Key);

      li := ListView1.Items.Add;
      li.Caption := IntToStr(Key);
      li.SubItems.Add('Down');
      li.SubItems.Add(s);
   end;
end;

procedure TForm1.BtnClearClick(Sender: TObject);
begin
   ListView1.Items.Clear;

   Memo1.Clear;
   Memo1.SetFocus;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   s : string;
   li : TListItem;
begin
   if ChkUp.Checked then
   begin
      s := ShiftStateAsString(Shift) + chr(Key);

      li := ListView1.Items.Add;
      li.Caption := IntToStr(Key);
      li.SubItems.Add('Up');
      li.SubItems.Add(s);
   end;
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
var
   s : string;
   li : TListItem;
begin
   if ChkPress.Checked then
   begin
      s := Key;

      li := ListView1.Items.Add;
      li.Caption := '';
      li.SubItems.Add('Press');
      li.SubItems.Add(key);
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   Application.OnMessage := MsgHandler;
end;

procedure StrShiftLeft(var s:string);
begin
   Move(s[2], s[1], Length(s)-1);
   s[Length(s)] := '?';
end;

function IsBarcodePrefix(const s:string):Boolean;
begin
   Result :=
      (s = ']c1') or   // EAN128
      (s = ']e0') or   // EAN13
      (s = ']c0') or   // Code128
      (s = ']a0');     // Code39

end;



procedure TForm1.MsgHandler(var Msg: TMsg; var Handled: Boolean);
var
   phnd : HWND;
begin
   case Msg.message of
      WM_CHAR:
      begin
         if IsBarcodePrefix(keyboardchars) then
         begin
            SendMessage(Msg.hwnd, WM_CHAR, VK_BACK, 0);
            SendMessage(Msg.hwnd, WM_CHAR, VK_BACK, 0);
            SendMessage(Msg.hwnd, WM_CHAR, VK_BACK, 0);
            keyboardchars:='';

            // Send a Message to the Root-Window (Delphi Form)
            phnd := GetAncestor(Msg.hwnd, GA_ROOT);
            SendMessage(phnd, WM_BARCODE, 0,0);
         end;

         if Length(keyboardchars) < 3 then
            keyboardchars := keyboardchars+Char(Msg.wParam)
         else
         begin
            StrShiftLeft(keyboardchars);
            keyboardchars[3] := Char(Msg.wParam);
         end;
      end;
   end;
end;

procedure TForm1.Barcode_Handler(var Message: TMessage);
begin
   Edit2.Text := IntToStr(StrToInt(Edit2.Text)+1);
end;

procedure TForm1.BtnShowVKeyCodesClick(Sender: TObject);
var
   f : TForm;
begin
   f := TVKeyCodesForm.Create(nil);
   try
      f.ShowModal;
   finally
      f.Free;
   end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
   x : TFrmMouseTest;
begin
   x := TFrmMouseTest.Create(nil);

   with x do
   begin
      ShowModal;
      Free;
   end;
end;

end.

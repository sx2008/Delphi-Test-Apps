unit UVKeyCodesForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ComCtrls;

type
  TVKeyCodesForm = class(TForm)
    ListView1: TListView;
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  VKeyCodesForm: TVKeyCodesForm;

implementation

{$R *.DFM}

procedure TVKeyCodesForm.FormCreate(Sender: TObject);
Var
   i, j: Word;

   MyKey: LPARAM;//Just to be brave!

   TmpStr: string;
   li : TListItem;
begin
   For i := 0 to 511 do
   Begin

      MyKey := MapVirtualKey(i, 3);//if this is not done, we get
      //actual keyboard scan code

// First Paramter of GetKeyNameText()
// Bits  Meaning
// 16-23 Scan code.
// 24    Extended-key flag. Distinguishes some keys on an enhanced keyboard.
// 25    "Don't care" bit. The application calling this function sets this bit to indicate that the function should not distinguish between left and right CTRL and SHIFT keys, for example.

      SetLength(TmpStr, 200);
      j := GetKeyNameText(i shl 16, PChar(TmpStr), Length(TmpStr) );
      SetLength(TmpStr, j);
      if j > 0 then
      begin
         li := ListView1.Items.Add;
         li.Caption := Format(' %.3d', [i]);
         li.SubItems.Add(IntToStr(MyKey));
         li.SubItems.Add(TmpStr);
      End;
   end;
end;

end.

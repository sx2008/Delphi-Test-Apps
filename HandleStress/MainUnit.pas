unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Contnrs;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Output: TGroupBox;
    Edit1: TEdit;
    BtnStart: TButton;
    procedure BtnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private-Deklarationen }
    FList : TObjectList;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.BtnStartClick(Sender: TObject);
var
  i, x, y : Integer;
  control : TWinControl;
  t : THandle;
begin
   x := 0;
   y := 0;
   i := StrToInt(Edit1.Text);

   while i > 0 do
   begin
      control := TEdit.Create(nil);
      FList.Add(control);
      control.Top := y;
      control.Left := x;
      control.ParentWindow := Self.Handle;
      t := control.Handle;

      //control.Parent := Output;

      x := (x + 3) mod (Output.Width-20);
      y := (y + 3) mod (Output.Height -8);


      Dec(i);
   end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   FList := TObjectList.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
   FList.Free;
end;

end.

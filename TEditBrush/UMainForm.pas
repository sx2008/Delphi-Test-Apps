unit UMainForm;
{
This Demo application shows, how to use a bitmap as a background for edit controls.

Diese Demoprogramm zeigt, wie man ein Bitmap als Hintergrundbild für Edit-Controls
verwenden kann.

Andreas Schmidt, 6.7.2004
}


interface

uses
  Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    BtnCreateBrush: TButton;
    Edit1: TEdit;
    Image1: TImage;
    BtnFreeBrush: TButton;
    ChkUseBitmap: TCheckBox;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    procedure BtnCreateBrushClick(Sender: TObject);
    procedure BtnFreeBrushClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
    FEditBrush : TBrush;

    procedure SetBrushButtons(c:Boolean);

  protected
    procedure WMCtlColorEdit(var msg:TMessage); message WM_CTLCOLOREDIT;
    procedure WMCtlColorBtn(var msg:TMessage); message WM_CTLCOLORBTN;
    procedure WMCtlColordlg(var msg:TMessage); message WM_CTLCOLORDLG;


  public
    { Public-Deklarationen }

  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses SysUtils;

{ TForm1 }

procedure TForm1.WMCtlColorEdit(var msg: TMessage);
begin
   if Assigned(FEditBrush) then
   begin
      msg.Result := FEditBrush.Handle;
   end;
end;


procedure TForm1.WMCtlColorBtn(var msg: TMessage);
begin
   if Assigned(FEditBrush) then
   begin
      msg.Result := FEditBrush.Handle;
   end;
end;

procedure TForm1.WMCtlColordlg(var msg: TMessage);
begin
   if Assigned(FEditBrush) then
   begin
      msg.Result := FEditBrush.Handle;
   end;
end;


procedure TForm1.BtnCreateBrushClick(Sender: TObject);
begin
   FreeAndNil(FEditBrush);

   FEditBrush := TBrush.Create;
   if ChkUseBitmap.Checked then
   begin
      FEditBrush.Bitmap := Image1.Picture.Bitmap;
   end
   else
   begin
      FEditBrush.Color := clRed;
      FEditBrush.Style := bsDiagCross;
   end;

   // the control must repainted
   // Das Control muss neu gezeichnet werden
   Edit1.Repaint;
   SetBrushButtons(false);
end;

procedure TForm1.BtnFreeBrushClick(Sender: TObject);
begin
   // free the brush
   // Brush freigeben
   FreeAndNil(FEditBrush);

   // the control must repainted
   // Das Control muss neu gezeichnet werden
   Edit1.Repaint;
   SetBrushButtons(True);
end;



procedure TForm1.Button1Click(Sender: TObject);
begin
   OpenDialog1.Execute;
end;

procedure TForm1.SetBrushButtons(c: Boolean);
begin
   BtnCreateBrush.Enabled := c;
   BtnFreeBrush.Enabled := not c;
end;

end.

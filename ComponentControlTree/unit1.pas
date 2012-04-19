unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    RadioGroup1: TRadioGroup;
    GroupBox1: TGroupBox;
    TreeView1: TTreeView;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation


{$R *.DFM}


function GetComponentName(c: TComponent): string;
begin
   Result := c.Name;

   if Result = '' then
   begin
      Result := '0x' + Format('%.8x',[Integer(c)]);
   end;
end;

procedure BuildComponentTree(c:TComponent; tn:TTreeNodes);
   procedure AddComponent(n: TTreeNode; nodes:TTreeNodes;c: TComponent);
   var
      n1: TTreeNode;
      i: Integer;
   begin
      n1 := nodes.AddChildObject(n,GetComponentName(c)+': '+c.ClassName,Pointer(c));

      for i := 0 to c.ComponentCount-1 do
      begin
         AddComponent(n1, nodes,c.Components[i]);
      end;
   end;
begin
   AddComponent(nil, tn, c);
end;

procedure BuildControlTree(c: TControl; tn:TTreeNodes);
   procedure AddControl(n: TTreeNode; nodes:TTreeNodes;c: TControl);
   var
      n1: TTreeNode;
      i: Integer;
   begin
      n1 := nodes.AddChildObject(n,GetComponentName(c)+': '+c.ClassName,Pointer(c));

      if c is TWinControl then
      begin
         for i := 0 to TWinControl(c).ControlCount-1 do
         begin
            AddControl(n1, nodes,TWinControl(c).Controls[i]);
         end;
      end;
   end;

begin
   AddControl(nil, tn, c);
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
   TreeView1.Items.Clear;
   BuildComponentTree(Application, TreeView1.Items);
   TreeView1.FullExpand;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   TreeView1.Items.Clear;
   BuildControlTree(self, TreeView1.Items);
   TreeView1.FullExpand;
end;

end.

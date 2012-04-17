object Form1: TForm1
  Left = 440
  Top = 193
  Width = 247
  Height = 155
  ActiveControl = Button1
  Caption = 'Self destroying Controls'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 16
    Top = 24
    Width = 177
    Height = 25
    Caption = 'Click Me -> kills me'
    TabOrder = 0
    OnClick = Button1Click
    OnKeyDown = Button1KeyDown
  end
  object Edit1: TEdit
    Left = 16
    Top = 64
    Width = 209
    Height = 21
    TabOrder = 1
    Text = 'I want to die ! Press Crtl-Delete to kill me'
    OnKeyDown = Button1KeyDown
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 96
    Width = 177
    Height = 17
    Caption = 'Pleeeease, don'#39't check me'
    TabOrder = 2
    OnClick = Button1Click
    OnKeyDown = Button1KeyDown
  end
end

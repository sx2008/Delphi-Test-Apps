object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Self modifing Exe Demo'
  ClientHeight = 123
  ClientWidth = 214
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 62
    Height = 13
    Caption = 'Config String'
  end
  object Edit1: TEdit
    Left = 16
    Top = 27
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 16
    Top = 75
    Width = 121
    Height = 25
    Caption = 'write patched Exe'
    TabOrder = 1
    OnClick = Button1Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 104
    Width = 214
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitLeft = 112
    ExplicitTop = 112
    ExplicitWidth = 0
  end
end

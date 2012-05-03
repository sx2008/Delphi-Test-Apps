object Form1: TForm1
  Left = 307
  Top = 138
  Width = 383
  Height = 149
  Caption = 'Form1'
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
    Left = 30
    Top = 28
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 184
    Top = 27
    Width = 100
    Height = 25
    Caption = 'SHA Selftest'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 184
    Top = 54
    Width = 100
    Height = 25
    Caption = 'MD4 Selftest'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 184
    Top = 81
    Width = 100
    Height = 25
    Caption = 'MD5 Selftest'
    TabOrder = 3
    OnClick = Button4Click
  end
end

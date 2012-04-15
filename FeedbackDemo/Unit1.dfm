object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 254
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 235
    Width = 480
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitLeft = 224
    ExplicitTop = 160
    ExplicitWidth = 0
  end
  object Button1: TButton
    Left = 32
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Test 1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 213
    Width = 150
    Height = 16
    TabOrder = 2
  end
  object Button2: TButton
    Left = 32
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Test 2'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 32
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Test 3'
    TabOrder = 4
    OnClick = Button3Click
  end
end

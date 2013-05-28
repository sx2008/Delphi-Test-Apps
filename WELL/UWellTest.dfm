object Form1: TForm1
  Left = 307
  Top = 138
  Width = 467
  Height = 513
  Caption = 'WELL 1024 Random Number Generator'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 367
    Top = 11
    Width = 75
    Height = 25
    Caption = 'Get random numbers'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 255
    Top = 5
    Width = 104
    Height = 460
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object Button2: TButton
    Left = 0
    Top = 270
    Width = 75
    Height = 25
    Caption = 'Draw'
    TabOrder = 2
    OnClick = Button2Click
  end
end

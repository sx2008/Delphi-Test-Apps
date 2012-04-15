object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Binary Search and Quicksort Demo'
  ClientHeight = 186
  ClientWidth = 295
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 144
    Top = 8
    Width = 18
    Height = 13
    Caption = 'Key'
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 113
    Height = 186
    Align = alLeft
    Lines.Strings = (
      '2'
      '3'
      '5'
      '7'
      '11'
      '13'
      '17'
      '19'
      '23'
      '29'
      '31'
      '37'
      '41')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 144
    Top = 32
    Width = 75
    Height = 21
    TabOrder = 1
    Text = '7'
  end
  object Button1: TButton
    Left = 144
    Top = 59
    Width = 75
    Height = 25
    Caption = '&Search'
    TabOrder = 2
    OnClick = Button1Click
  end
end

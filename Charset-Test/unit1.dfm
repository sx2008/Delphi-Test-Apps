object Form1: TForm1
  Left = 307
  Top = 138
  Width = 298
  Height = 254
  Caption = 'Charset Test'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 6
    Top = 150
    Width = 273
    Height = 40
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Courier'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = '‰ˆ¸ƒ÷‹ﬂ'
  end
  object RadioGroup1: TRadioGroup
    Left = 15
    Top = 8
    Width = 185
    Height = 105
    Caption = 'Charset'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 1
    Items.Strings = (
      'Default'
      'Russian'
      'Greek')
    ParentFont = False
    TabOrder = 1
    OnClick = RadioGroup1Click
  end
end

object Form1: TForm1
  Left = 361
  Top = 276
  Width = 439
  Height = 393
  Caption = 'Binary data to Pascal Converter'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 67
    Width = 431
    Height = 280
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 431
    Height = 67
    Align = alTop
    TabOrder = 1
    object RadioGroup1: TRadioGroup
      Left = 5
      Top = 5
      Width = 185
      Height = 58
      Caption = 'Output'
      ItemIndex = 0
      Items.Strings = (
        'string'
        'array of char')
      TabOrder = 0
    end
  end
  object MainMenu1: TMainMenu
    Left = 53
    Top = 34
    object File1: TMenuItem
      Caption = 'File'
      object Open1: TMenuItem
        Caption = 'Open...'
        OnClick = Open1Click
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
        OnClick = Exit1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 176
    Top = 39
  end
end

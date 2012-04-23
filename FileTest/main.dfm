object Form1: TForm1
  Left = 253
  Top = 224
  Width = 439
  Height = 420
  Caption = 'File Sharing Test Programm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 8
    Width = 54
    Height = 13
    Caption = 'Verzeichnis'
  end
  object DirectoryEdit1: TDirectoryEdit
    Left = 12
    Top = 23
    Width = 313
    Height = 21
    NumGlyphs = 1
    TabOrder = 0
    Text = 'C:\'
  end
  object RgpOpenMode: TRadioGroup
    Left = 12
    Top = 64
    Width = 105
    Height = 105
    Caption = 'Open Mode'
    ItemIndex = 0
    Items.Strings = (
      'Create'
      'Read'
      'Write'
      'Read Write')
    TabOrder = 1
  end
  object RgpShareMode: TRadioGroup
    Left = 128
    Top = 65
    Width = 113
    Height = 105
    Caption = 'Share Mode'
    ItemIndex = 1
    Items.Strings = (
      'Compat'
      'Exclusive'
      'Deny Write'
      'Deny Read'
      'Deny None')
    TabOrder = 2
  end
  object Button1: TButton
    Left = 264
    Top = 68
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 5
    Top = 205
    Width = 416
    Height = 184
    TabOrder = 4
  end
  object BtnRead: TButton
    Left = 13
    Top = 177
    Width = 75
    Height = 25
    Caption = 'Read'
    TabOrder = 5
    OnClick = BtnReadClick
  end
  object BtnWrite: TButton
    Left = 108
    Top = 177
    Width = 75
    Height = 25
    Caption = 'Write'
    TabOrder = 6
    OnClick = BtnWriteClick
  end
  object BtnSpeedTest: TButton
    Left = 263
    Top = 97
    Width = 75
    Height = 25
    Caption = 'Speed Test'
    Enabled = False
    TabOrder = 7
    OnClick = BtnSpeedTestClick
  end
  object ChkFlushCache: TCheckBox
    Left = 263
    Top = 125
    Width = 97
    Height = 17
    Caption = 'flush cache'
    TabOrder = 8
  end
  object ChkUseAPI: TCheckBox
    Left = 263
    Top = 144
    Width = 97
    Height = 17
    Caption = 'Use API'
    TabOrder = 9
  end
end

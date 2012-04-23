object Form1: TForm1
  Left = 360
  Top = 214
  Width = 505
  Height = 379
  Caption = 'File speed test application'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 497
    Height = 117
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 7
      Width = 42
      Height = 13
      Caption = 'file name'
    end
    object Label2: TLabel
      Left = 168
      Top = 7
      Width = 18
      Height = 13
      Caption = 'size'
    end
    object EdtFilename: TEdit
      Left = 12
      Top = 20
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'C:\test.dat'
    end
    object ChkUseFlushCache: TCheckBox
      Left = 12
      Top = 50
      Width = 207
      Height = 17
      Caption = 'flush write cache'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object ChkUseAPI: TCheckBox
      Left = 12
      Top = 66
      Width = 149
      Height = 17
      Caption = 'use Windows API'
      TabOrder = 2
    end
    object Button1: TButton
      Left = 338
      Top = 39
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 3
      OnClick = Button1Click
    end
    object CboFileSize: TComboBox
      Left = 166
      Top = 20
      Width = 64
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      Items.Strings = (
        '8 MB'
        '16 MB'
        '32 MB'
        '64 MB'
        '128 MB')
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 117
    Width = 497
    Height = 235
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 1
  end
end

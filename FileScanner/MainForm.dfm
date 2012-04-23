object Form1: TForm1
  Left = 307
  Top = 138
  Width = 870
  Height = 640
  Caption = 'File Scanner Demo für Delphi Praxis by shmia'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ListView1: TListView
    Left = 0
    Top = 73
    Width = 862
    Height = 521
    Align = alClient
    Columns = <
      item
        Caption = 'Name'
        Width = 200
      end
      item
        Caption = 'Size'
      end
      item
        Caption = 'Level'
      end
      item
        Caption = 'LastWrite'
        Width = 115
      end
      item
        Caption = 'Created'
      end
      item
        Caption = 'Flags'
      end
      item
        Caption = 'Path'
        Width = -2
        WidthType = (
          -2)
      end>
    TabOrder = 0
    ViewStyle = vsReport
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 862
    Height = 73
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 14
      Top = 9
      Width = 54
      Height = 13
      Caption = 'Verzeichnis'
    end
    object Label2: TLabel
      Left = 715
      Top = 28
      Width = 113
      Height = 13
      Caption = 'Verzeichnisse / Dateien'
    end
    object BtnStart: TButton
      Left = 265
      Top = 28
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      OnClick = BtnStartClick
    end
    object Edit1: TEdit
      Left = 10
      Top = 30
      Width = 239
      Height = 21
      TabOrder = 1
      Text = 'C:\'
    end
    object BtnStop: TButton
      Left = 349
      Top = 28
      Width = 75
      Height = 25
      Caption = 'Stop'
      TabOrder = 2
      OnClick = BtnStopClick
    end
    object CboRecursive: TCheckBox
      Left = 11
      Top = 56
      Width = 194
      Height = 17
      Caption = 'Unterverzeichnise durchsuchen'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object EdtSearched: TEdit
      Left = 713
      Top = 43
      Width = 123
      Height = 21
      TabOrder = 4
      Text = '0'
    end
    object RgpFilter: TRadioGroup
      Left = 476
      Top = 15
      Width = 185
      Height = 49
      Caption = 'Filter'
      ItemIndex = 0
      Items.Strings = (
        'all'
        'only Delphi Apps or libs')
      TabOrder = 5
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 594
    Width = 862
    Height = 19
    Panels = <>
    SimplePanel = True
  end
end

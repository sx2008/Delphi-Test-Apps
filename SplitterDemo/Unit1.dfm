object Form1: TForm1
  Left = 307
  Top = 138
  Width = 870
  Height = 640
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefaultPosOnly
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 41
    Width = 862
    Height = 4
    Cursor = crVSplit
    Align = alTop
    Color = clBlue
    ParentColor = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 862
    Height = 41
    Align = alTop
    Caption = 'Splitter Demo'
    TabOrder = 0
    object Button1: TButton
      Left = 18
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Button1'
      Enabled = False
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 45
    Width = 862
    Height = 568
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object Splitter2: TSplitter
      Left = 186
      Top = 1
      Width = 4
      Height = 566
      Cursor = crHSplit
      Color = clFuchsia
      ParentColor = False
    end
    object Memo1: TMemo
      Left = 1
      Top = 1
      Width = 185
      Height = 566
      Align = alLeft
      Lines.Strings = (
        'Memo1')
      TabOrder = 0
    end
    object StringGrid1: TStringGrid
      Left = 190
      Top = 1
      Width = 671
      Height = 566
      Align = alClient
      TabOrder = 1
    end
  end
end

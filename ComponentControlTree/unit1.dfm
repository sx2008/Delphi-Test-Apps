object Form1: TForm1
  Left = 342
  Top = 242
  Width = 435
  Height = 350
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 427
    Height = 98
    Align = alTop
    TabOrder = 0
    object Button1: TButton
      Left = 12
      Top = 8
      Width = 154
      Height = 25
      Caption = 'Alle Komponenten zeigen'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 12
      Top = 38
      Width = 154
      Height = 25
      Caption = 'Alle Controls diese Forms'
      TabOrder = 1
      OnClick = Button2Click
    end
    object RadioGroup1: TRadioGroup
      Left = 317
      Top = 13
      Width = 97
      Height = 60
      Caption = 'RadioGroup1'
      Items.Strings = (
        'rot'
        'grün'
        'blau')
      TabOrder = 2
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 98
    Width = 427
    Height = 225
    Align = alClient
    Caption = 'Baumansicht'
    TabOrder = 1
    object TreeView1: TTreeView
      Left = 2
      Top = 15
      Width = 423
      Height = 208
      Align = alClient
      Indent = 19
      TabOrder = 0
    end
  end
end
